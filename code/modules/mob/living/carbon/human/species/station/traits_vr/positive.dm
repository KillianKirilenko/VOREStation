/datum/trait/speed_fast
	name = "Haste"
	desc = "Allows you to move faster on average than baseline."
	cost = 4
	var_changes = list("slowdown" = -0.5)

/datum/trait/hardy
	name = "Hardy"
	desc = "Allows you to carry heavy equipment with less slowdown."
	cost = 1
	var_changes = list("item_slowdown_mod" = 0.5)

/datum/trait/hardy_plus
	name = "Major Hardy"
	desc = "Allows you to carry heavy equipment with almost no slowdown."
	cost = 2
	var_changes = list("item_slowdown_mod" = 0.1)

/datum/trait/endurance_high
	name = "High Endurance"
	desc = "Increases your maximum total hitpoints to 125, from 100."
	cost = 4
	var_changes = list("total_health" = 125)

	apply(var/datum/species/S,var/mob/living/carbon/human/H)
		..(S,H)
		H.setMaxHealth(S.total_health)

/datum/trait/nonconductive
	name = "Non-Conductive"
	desc = "You are more resistant to electrical shocks than most. Zaps of all kinds, from outlets, batons, or tasers, are three-quarters as effective."
	cost = 2 //This effects tasers!
	var_changes = list("siemens_coefficient" = 0.75)

/datum/trait/nonconductive_plus
	name = "Major Non-Conductive"
	desc = "You are significantly more resistant to electrical shocks than most. Zaps of all kinds, from outlets, batons, or tasers, are half as effective."
	cost = 3 //Let us not forget this effects tasers!
	var_changes = list("siemens_coefficient" = 0.5)
	
/datum/trait/pain_resistant
	name = "Deadened Nerves"
	desc = "You are more resistant to common forms of pain-compliance such as stun batons, taser bolts, pepper spray, and so on."
	cost = 3 //this makes you fairly resistant to a lot more stuff than just shocks, so it costs a lot!
	var_changes = list("pain_mod" = 0.75)
	excludes = list(/datum/trait/neural_hypersensitivity)

/datum/trait/darksight
	name = "Darksight"
	desc = "Allows you to see a short distance in the dark, but doubles the blinding duration of flashes."
	cost = 1
	var_changes = list("darksight" = 5, "flash_mod" = 2.0)

/datum/trait/darksight_plus
	name = "Darksight (Major)"
	desc = "Allows you to see in the dark for the whole screen, but triples the blinding duration of flashes."
	cost = 2
	var_changes = list("darksight" = 8, "flash_mod" = 3.0)

/datum/trait/melee_attack
	name = "Sharp Melee"
	desc = "You have sharp claws and vicious fangs that deal slightly more damage than regular punches."
	cost = 1
	var_changes = list("unarmed_types" = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp))

/datum/trait/melee_attack_fangs
	name = "Sharp Melee & Numbing Fangs"
	desc = "An enhanced version of the Sharp Melee trait that causes your bites to inject a numbing, non-lethal venom."
	cost = 2
	var_changes = list("unarmed_types" = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp, /datum/unarmed_attack/bite/sharp/numbing))

/datum/trait/fangs
	name = "Numbing Fangs"
	desc = "Provides the fangs and numbing venom without the sharp claws enhancing your regular unarmed strikes."
	cost = 1
	var_changes = list("unarmed_types" = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/punch, /datum/unarmed_attack/bite/sharp/numbing))

/datum/trait/minor_brute_resist
	name = "Minor Brute Resist"
	desc = "Incoming brute damage is reduced by 15%. Common sources of brute damage include fists and toolboxes."
	cost = 2
	var_changes = list("brute_mod" = 0.85)

/datum/trait/brute_resist
	name = "Brute Resist"
	desc = "Incoming brute damage is reduced by 25%. Common sources of brute damage include fists and toolboxes. Incompatible with burn resist traits."
	cost = 3
	var_changes = list("brute_mod" = 0.75)
	excludes = list(/datum/trait/minor_burn_resist,/datum/trait/burn_resist)

/datum/trait/minor_burn_resist
	name = "Minor Burn Resist"
	desc = "Incoming burn damage is reduced by 15%. Common sources of burn damage include fire and lasers."
	cost = 2
	var_changes = list("burn_mod" = 0.85)

/datum/trait/burn_resist
	name = "Burn Resist"
	desc = "Incoming burn damage is reduced by 25%. Common sources of burn damage include fire and lasers. Incompatible with brute resist traits."
	cost = 3
	var_changes = list("burn_mod" = 0.75)
	excludes = list(/datum/trait/minor_brute_resist,/datum/trait/brute_resist)

/datum/trait/photoresistant
	name = "Photoresistant"
	desc = "Decreases stun duration from flashes and other light-based stuns and disabilities by 50%."
	cost = 1
	var_changes = list("flash_mod" = 0.5)

/datum/trait/winged_flight
	name = "Winged Flight"
	desc = "Allows you to fly by using your wings. Don't forget to bring them!"
	cost = 1

/datum/trait/winged_flight/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/proc/flying_toggle
	H.verbs |= /mob/living/proc/start_wings_hovering

/datum/trait/hardfeet
	name = "Hard Feet"
	desc = "Makes your nice clawed, scaled, hooved, armored, or otherwise just awfully calloused feet immune to glass shards."
	cost = 1
	var_changes = list("flags" = NO_MINOR_CUT) //Checked the flag is only used by shard stepping.

/datum/trait/antiseptic_saliva
	name = "Antiseptic Saliva"
	desc = "Your saliva has especially strong antiseptic properties that can be used to heal small wounds."
	cost = 1

/datum/trait/antiseptic_saliva/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..()
	H.verbs |= /mob/living/carbon/human/proc/lick_wounds 

/datum/trait/traceur
	name = "Traceur"
	desc = "You're capable of parkour and can *flip over low objects (most of the time)."
	cost = 2
	var_changes = list("agility" = 90)

/datum/trait/snowwalker
	name = "Snow Walker"
	desc = "You are able to move unhindered on snow."
	cost = 1
	var_changes = list("snow_movement" = -2)

/datum/trait/slow_bleeder
	name = "Ain't Got Time To Bleed"
	desc = "Some quirk of biology, or perhaps sheer force of will, means you lose blood 25% slower. You'll stay conscious and capable for longer when suffering from bleeding wounds. Note this trait currently does nothing useful for synths."
	cost = 1
	var_changes = list("bloodloss_rate" = 0.75)
	not_for_synths = 1