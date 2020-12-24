/datum/trait/speed_slow
	name = "Slowdown"
	desc = "Causes you to move slower on average than baseline."
	cost = -2
	var_changes = list("slowdown" = 0.5)

/datum/trait/speed_slow_plus
	name = "Major Slowdown"
	desc = "Causes you to move MUCH slower on average than baseline."
	cost = -3
	var_changes = list("slowdown" = 1.0)

/datum/trait/weakling
	name = "Weakling"
	desc = "Causes heavy items to slow you down one and a half times as much as they normally would."
	cost = -1
	var_changes = list("item_slowdown_mod" = 1.5)

/datum/trait/weakling_plus
	name = "Major Weakling"
	desc = "Causes heavy items to slow you down twice as much as they normally would."
	cost = -2
	var_changes = list("item_slowdown_mod" = 2.0)

/datum/trait/endurance_low
	name = "Low Endurance"
	desc = "Reduces your maximum total hitpoints to 75, from 100."
	cost = -2
	var_changes = list("total_health" = 75)

	apply(var/datum/species/S,var/mob/living/carbon/human/H)
		..(S,H)
		H.setMaxHealth(S.total_health)

/datum/trait/endurance_very_low
	name = "Extremely Low Endurance"
	desc = "Reduces your maximum total hitpoints to 50, from 100."
	cost = -3 //Teshari HP. This makes the person a lot more susceptible to getting stunned, killed, etc.
	var_changes = list("total_health" = 50)

	apply(var/datum/species/S,var/mob/living/carbon/human/H)
		..(S,H)
		H.setMaxHealth(S.total_health)

/datum/trait/minor_brute_weak
	name = "Minor Brute Weakness"
	desc = "Incoming brute damage is increased by 15%. Common sources of brute damage include fists and toolboxes."
	cost = -1
	var_changes = list("brute_mod" = 1.15)

/datum/trait/brute_weak
	name = "Brute Weakness"
	desc = "Incoming brute damage is increased by 25%. Common sources of brute damage include fists and toolboxes."
	cost = -2
	var_changes = list("brute_mod" = 1.25)

/datum/trait/brute_weak_plus
	name = "Major Brute Weakness"
	desc = "Incoming brute damage is increased by 50%. Common sources of brute damage include fists and toolboxes."
	cost = -3
	var_changes = list("brute_mod" = 1.5)

/datum/trait/minor_burn_weak
	name = "Minor Burn Weakness"
	desc = "Incoming burn damage is increased by 15%. Common sources of burn damage include fire and lasers."
	cost = -1
	var_changes = list("burn_mod" = 1.15)

/datum/trait/burn_weak
	name = "Burn Weakness"
	desc = "Incoming burn damage is increased by 25%. Common sources of burn damage include fire and lasers."
	cost = -2
	var_changes = list("burn_mod" = 1.25)

/datum/trait/burn_weak_plus
	name = "Major Burn Weakness"
	desc = "Incoming burn damage is increased by 50%. Common sources of burn damage include fire and lasers."
	cost = -3
	var_changes = list("burn_mod" = 1.5)

/datum/trait/conductive
	name = "Conductive"
	desc = "You are more vulnerable to electrical shocks than most. Zaps of all kinds, from outlets, batons, or tasers, are one-half more effective."
	cost = -1
	var_changes = list("siemens_coefficient" = 1.5) //This makes you a lot weaker to tasers.

/datum/trait/conductive_plus
	name = "Major Conductive"
	desc = "You are significantly more vulnerable to electrical shocks than most. Zaps of all kinds, from outlets, batons, or tasers, are twice as effective."
	cost = -2
	var_changes = list("siemens_coefficient" = 2.0) //This makes you extremely weak to tasers.
	
/datum/trait/pain_weakness
	name = "Sensitive Nerves"
	desc = "You are highly sensitive to common forms of pain-compliance such as stun batons, taser bolts, pepper spray, and so on."
	cost = -2
	var_changes = list("pain_mod" = 1.5) //with this, a single beanbag will almost floor you outright. pray you never meet taser spiders.
	excludes = list(/datum/trait/neural_hypersensitivity)

/datum/trait/electromag_sensitivity
	name = "Electromagnetic Sensitivity"
	desc = "Your species possesses organs that are sensitive to a wider range of the electromagnetic spectrum than most. With this trait, being hit with an electromagnetic pulse (such as that from an EMP grenade or ion blaster) will blind, confuse, and potentially stun you based on the pulse's intensity. This trait cannot be taken by synthetics."
	cost = -1
	var_changes = list("emp_sensitivity" = 26) // BLIND (2) + CONFUSE (8) + WEAKEN (10)
	not_for_synths = 1
	excludes = list(/datum/trait/electromag_hypersensitivity)

/datum/trait/electromag_hypersensitivity
	name = "Electromagnetic Hypersensitivity"
	desc = "Your species possesses organs that are highly sensitive to a significantly wider range of the electromagnetic spectrum than most. With this trait, being hit with an electromagnetic pulse (such as that from an EMP grenade or ion blaster) will cause pain, blindness, and confusion, potentially stun you based on the pulse's intensity, and cause you to take toxic damage. This trait cannot be taken by synthetics."
	cost = -2
	var_changes = list("emp_sensitivity" = 155) // PAIN (1) + BLIND (2) + CONFUSE (8) + WEAKEN (10) + TOX (80).
	not_for_synths = 1
	excludes = list(/datum/trait/electromag_sensitivity)

/datum/trait/medicine_tolerant
	name = "Medicine Tolerant"
	desc = "Your biology reacts poorly (or at least slowly) to modern curative medicines; they have only half their usual effects on you. You should probably note this in your medical records. Not to be taken on synthetics."
	cost = -1
	var_changes = list("chem_strength_heal" = 0.5)
	not_for_synths = 1

/datum/trait/painkiller_tolerance
	name = "Painkiller Tolerant"
	desc = "Years or perhaps even decades of painkiller use have rendered you resistant to the analgesic effects of these potent and often highly addictive chemicals. Oh the cruel, cruel irony. You should probably note this in your medical records. Not to be taken on synthetics."
	//specifying how much they actually do isn't very useful since most people won't know how painkillers work anyway
	cost = -1
	var_changes = list("chem_strength_pain" = 0.75)
	not_for_synths = 1

/datum/trait/haemophilia
	name = "Haemophilia - Organics only"
	desc = "When you bleed, you bleed a LOT. You should probably note this in your medical records. This trait is only for organics, buggy with synths!"
	cost = -2
	var_changes = list("bloodloss_rate" = 2)
	not_for_synths = 1

/datum/trait/hollow
	name = "Hollow Bones/Aluminum Alloy"
	desc = "Your bones and robot limbs are much easier to break. You should probably note this in your medical records."
	cost = -2 //I feel like this should be higher, but let's see where it goes

/datum/trait/hollow/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	for(var/obj/item/organ/external/O in H.organs)
		O.min_broken_damage *= 0.5
		O.min_bruised_damage *= 0.5

/datum/trait/lightweight
	name = "Lightweight"
	desc = "Your light weight and poor balance make you very susceptible to unhelpful bumping. Think of it like a bowling ball versus a pin."
	cost = -2
	var_changes = list("lightweight" = 1)

/datum/trait/colorblind/mono
	name = "Colorblindness (Monochromancy)"
	desc = "You simply can't see colors at all, period. You are 100% colorblind."
	cost = -1

/datum/trait/colorblind/mono/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.add_modifier(/datum/modifier/trait/colorblind_monochrome)

/datum/trait/colorblind/para_vulp
	name = "Colorblindness (Para Vulp)"
	desc = "You have a severe issue with green colors and have difficulty recognizing them from red colors."
	cost = -1

/datum/trait/colorblind/para_vulp/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.add_modifier(/datum/modifier/trait/colorblind_vulp)

/datum/trait/colorblind/para_taj
	name = "Colorblindness (Para Taj)"
	desc = "You have a minor issue with blue colors and have difficulty recognizing them from red colors."
	cost = -1

/datum/trait/colorblind/para_taj/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.add_modifier(/datum/modifier/trait/colorblind_taj)
	
/datum/trait/neural_hypersensitivity
	name = "Neural Hypersensitivity"
	desc = "Your nerves are particularly sensitive to physical changes, leading to experiencing twice the intensity of pain and pleasure alike. Doubles traumatic shock."
	cost = -1
	var_changes = list("traumatic_mod" = 2)
	excludes = list(/datum/trait/pain_weakness,/datum/trait/pain_resistant)