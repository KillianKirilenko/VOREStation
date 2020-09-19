/mob/living/simple_mob/vore/solargrub
	var/grub_charge = 0		//current stored charge; gains 1 per Life() tick if attached to a cable and recursive.
	var/grub_maturation = 30	//how many Life() ticks it takes us to mature. default to 30 to be safe.
	var/grub_recursive = 0		//do we recurse? normally, we don't, but sometimes we do.

/mob/living/simple_mob/vore/solargrub/New()
	existing_solargrubs += src
	if(prob(25))	//hey look it's the sometimes
		grub_recursive = 1
	grub_maturation = 5 * rand(4,8)	//20-40 ticks in steps of 5.
	..()

//this is basically just a wholesale override since I don't know if it's possible to do this more elegantly.
//all prior comments cleaned up.
/mob/living/simple_mob/vore/solargrub/Life()
	. = ..()
	if(!.) return

	if(!ai_holder.target)
		var/turf/S = loc
		attached = locate(/obj/structure/cable) in S
		if(attached)
			set_AI_busy(TRUE)
			if(prob(2))
				src.visible_message("<span class='notice'>\The [src] begins to sink power from the net.</span>")
			if(prob(5))
				var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
				sparks.set_up(5, 0, get_turf(src))
				sparks.start()
			anchored = 1
			PN = attached.powernet
			PN.draw_power(100000)
			var/apc_drain_rate = 750
			for(var/obj/machinery/power/terminal/T in PN.nodes)
				if(istype(T.master, /obj/machinery/power/apc))
					var/obj/machinery/power/apc/A = T.master
					if(A.operating && A.cell)
						var/cur_charge = A.cell.charge / CELLRATE
						var/drain_val = min(apc_drain_rate, cur_charge)
						A.cell.use(drain_val * CELLRATE)
			if(grub_recursive)	//no point incrementing charge or tracking any of the rest if it's non-recursive.
				grub_charge += 1
				if(grub_charge >= grub_maturation * 0.5)
					if(prob(5))	//small chance to ping a visible message that hints at the grub being 'different'.
						src.visible_message("<span class='notice'>\The [src] sparkles with a soft inner light.</span>")
				if(grub_charge >= grub_maturation)
					visible_message("<span class='warning'>\The [src] wriggles violently from head to tail, lets out a peculiar chittering noise, then suddenly explodes in a shower of gore... and fresh larvae!</span>")
					var/i = rand(3,5)
					while(i>1)
						new /mob/living/simple_mob/animal/solargrub_larva(get_turf(src))
						i--
					playsound(src, 'sound/weapons/tablehit1.ogg', 50, 1)	//needs a better sound, but this has enough of a wet slap/pop feel for now.
					gib(src)
		else if(!attached && anchored)
			anchored = 0
			PN = null