/mob/living/Check_Shoegrip()
	if(flying)
		return 1
	..()

/mob/living/verb/customsay()
	set category = "IC.Settings"
	set name = "Customize Speech Verbs"
	set desc = "Customize the text which appears when you type- e.g. 'says', 'asks', 'exclaims'."

	if(src.client)
		var/sayselect = tgui_alert(src, "Which say-verb do you wish to customize?", "Select Verb", list("Say","Whisper","Ask (?)","Exclaim/Shout/Yell (!)","Cancel"))

		if(sayselect == "Say")
			custom_say =  lowertext(sanitize(tgui_input_text(usr, "This word or phrase will appear instead of 'says': [src] says, \"Hi.\"", "Custom Say", null)))
		else if(sayselect == "Whisper")
			custom_whisper =  lowertext(sanitize(tgui_input_text(usr, "This word or phrase will appear instead of 'whispers': [src] whispers, \"Hi...\"", "Custom Whisper", null)))
		else if(sayselect == "Ask (?)")
			custom_ask =  lowertext(sanitize(tgui_input_text(usr, "This word or phrase will appear instead of 'asks': [src] asks, \"Hi?\"", "Custom Ask", null)))
		else if(sayselect == "Exclaim/Shout/Yell (!)")
			custom_exclaim =  lowertext(sanitize(tgui_input_text(usr, "This word or phrase will appear instead of 'exclaims', 'shouts' or 'yells': [src] exclaims, \"Hi!\"", "Custom Exclaim", null)))
		else
			return

/mob/living/verb/set_metainfo()
	set name = "Set OOC Metainfo"
	set desc = "Sets OOC notes about yourself or your RP preferences or status."
	set category = "OOC.Game Settings"

	if(usr != src)
		return
	var/new_metadata = strip_html_simple(tgui_input_text(usr, "Enter any information you'd like others to see, such as Roleplay-preferences. This will not be saved permanently unless you click save in the OOC notes panel!", "Game Preference" , html_decode(ooc_notes), multiline = TRUE,  prevent_enter = TRUE))
	if(new_metadata && CanUseTopic(usr))
		ooc_notes = new_metadata
		client.prefs.update_preference_by_type(/datum/preference/text/living/ooc_notes, new_metadata)
		to_chat(usr, span_filter_notice("OOC notes updated. Don't forget to save!"))
		log_admin("[key_name(usr)] updated their OOC notes mid-round.")
		ooc_notes_window(usr)
		set_metainfo_likes(FALSE)
		set_metainfo_dislikes(FALSE)

/mob/living/proc/set_metainfo_panel()
	if(usr != src)
		return
	var/new_metadata = strip_html_simple(tgui_input_text(usr, "Enter any information you'd like others to see, such as Roleplay-preferences. This will not be saved permanently unless you click save in the OOC notes panel!", "Game Preference" , html_decode(ooc_notes), multiline = TRUE,  prevent_enter = TRUE))
	if(new_metadata && CanUseTopic(usr))
		ooc_notes = new_metadata
		client.prefs.update_preference_by_type(/datum/preference/text/living/ooc_notes, new_metadata)
		to_chat(usr, span_filter_notice("OOC notes updated. Don't forget to save!"))
		log_admin("[key_name(usr)] updated their OOC notes mid-round.")
		ooc_notes_window(usr)

/mob/living/proc/set_metainfo_likes(var/reopen = TRUE)
	if(usr != src)
		return
	var/new_metadata = strip_html_simple(tgui_input_text(usr, "Enter any information you'd like others to see relating to your LIKED roleplay preferences. This will not be saved permanently unless you click save in the OOC notes panel! Type \"!clear\" to empty.", "Game Preference" , html_decode(ooc_notes_likes), multiline = TRUE,  prevent_enter = TRUE))
	if(new_metadata && CanUseTopic(usr))
		if(new_metadata == "!clear")
			new_metadata = ""
		ooc_notes_likes = new_metadata
		client.prefs.update_preference_by_type(/datum/preference/text/living/ooc_notes_likes, new_metadata)
		to_chat(usr, span_filter_notice("OOC note likes have been updated. Don't forget to save!"))
		log_admin("[key_name(usr)] updated their OOC note likes mid-round.")
		if(reopen)
			ooc_notes_window(usr)

/mob/living/proc/set_metainfo_dislikes(var/reopen = TRUE)
	if(usr != src)
		return
	var/new_metadata = strip_html_simple(tgui_input_text(usr, "Enter any information you'd like others to see relating to your DISLIKED roleplay preferences. This will not be saved permanently unless you click save in the OOC notes panel! Type \"!clear\" to empty.", "Game Preference" , html_decode(ooc_notes_dislikes), multiline = TRUE,  prevent_enter = TRUE))
	if(new_metadata && CanUseTopic(usr))
		if(new_metadata == "!clear")
			new_metadata = ""
		ooc_notes_dislikes = new_metadata
		client.prefs.update_preference_by_type(/datum/preference/text/living/ooc_notes_dislikes, new_metadata)
		to_chat(usr, span_filter_notice("OOC note dislikes have been updated. Don't forget to save!"))
		log_admin("[key_name(usr)] updated their OOC note dislikes mid-round.")
		if(reopen)
			ooc_notes_window(usr)

/mob/living/proc/save_ooc_panel()
	if(usr != src)
		return
	if(client.prefs.real_name != real_name)
		to_chat(usr, span_danger("Your selected character slot name is not the same as your character's name. Aborting save. Please select [real_name]'s character slot in character setup before saving."))
		return
	if(client.prefs.save_character())
		to_chat(usr, span_filter_notice("Character preferences saved."))

/mob/living/proc/print_ooc_notes_to_chat()
	if(!ooc_notes)
		return
	var/msg = ooc_notes
	if(ooc_notes_likes)
		msg += "<br><br><b>LIKES</b><br><br>[ooc_notes_likes]"
	if(ooc_notes_dislikes)
		msg += "<br><br><b>DISLIKES</b><br><br>[ooc_notes_dislikes]"
	to_chat(usr, span_chatexport("[src]'s Metainfo:<br>[msg]"))

/mob/living/verb/set_custom_link()
	set name = "Set Custom Link"
	set desc = "Set a custom link to show up with your examine text."
	set category = "IC.Settings"

	if(usr != src)
		return
	var/new_link = strip_html_simple(tgui_input_text(usr, "Enter a link to add on to your examine text! This should be a related image link/gallery, or things like your F-list. This is not the place for memes.", "Custom Link" , html_decode(custom_link), max_length = 100, encode = TRUE,  prevent_enter = TRUE))
	if(new_link && CanUseTopic(usr))
		if(length(new_link) > 100)
			to_chat(usr, span_warning("Your entry is too long, it must be 100 characters or less."))
			return

		custom_link = new_link
		to_chat(usr, span_notice("Link set: [custom_link]"))
		log_admin("[usr]/[usr.ckey] set their custom link to [custom_link]")

/mob/living/verb/set_voice_freq()
	set name = "Set Voice Frequency"
	set desc = "Sets your voice frequency to be higher or lower pitched!"
	set category = "OOC.Game Settings"

	var/list/preset_voice_freqs = list("high" = MAX_VOICE_FREQ, "middle-high" = 56250, "middle" = 425000, "middle-low"= 28750, "low" = MIN_VOICE_FREQ, "custom" = 1, "random" = 0)
	var/choice = tgui_input_list(src, "What would you like to set your voice frequency to?", "Voice Frequency", preset_voice_freqs)
	if(!choice)
		return
	choice = preset_voice_freqs[choice]
	if(choice == 0)
		voice_freq = choice
		return
	else if(choice == 1)
		choice = tgui_input_number(src, "Choose your character's voice frequency, ranging from [MIN_VOICE_FREQ] to [MAX_VOICE_FREQ]", "Custom Voice Frequency", null, MAX_VOICE_FREQ, MIN_VOICE_FREQ)
	else if(choice > MAX_VOICE_FREQ)
		choice = MAX_VOICE_FREQ
	else if(choice < MIN_VOICE_FREQ)
		choice = MIN_VOICE_FREQ
	voice_freq = choice

/mob/living/verb/set_voice_type()
	set name = "Set Voice Type"
	set desc = "Sets your voice style!"
	set category = "OOC.Game Settings"

	var/list/possible_voice_types = get_talk_sound()
	var/choice = tgui_input_list(usr, "Which set of sounds would you like to use for your character's speech sounds?", "Voice Sounds", possible_voice_types)
	if(!choice)
		voice_sounds_list = talk_sound
	voice_sounds_list = get_talk_sound(choice)

/mob/living/proc/save_private_notes(mob/user)
	if(user != src)
		return
	if(client.prefs.real_name != real_name)
		to_chat(src, span_danger("Your selected character slot name is not the same as your character's name. Aborting save. Please select [real_name]'s character slot in character setup before saving."))
		return
	if(client.prefs.save_character())
		to_chat(src, span_filter_notice("Character preferences saved."))

/mob/living/verb/open_private_notes(mob/user)
	set name = "Private Notes"
	set desc = "View and edit your character's private notes, that persist between rounds!"
	set category = "IC.Notes"

	private_notes_window(user)

/mob/living/proc/set_metainfo_private_notes(mob/user)
	if(user != src)
		return
	var/new_metadata = sanitize(tgui_input_text(src,"Write some notes for yourself. These can be anything that is useful, whether it's character events that you want to remember or a bit of lore. Things that you would normally stick in a txt file for yourself! This will not be saved unless you press save in the private notes panel.", "Private Notes", html_decode(private_notes), multiline = TRUE, prevent_enter = TRUE), extra = 0)
	if(new_metadata && CanUseTopic(src))
		private_notes = new_metadata
		client.prefs.update_preference_by_type(/datum/preference/text/living/private_notes, new_metadata)
		to_chat(src, span_filter_notice("Private notes updated. Don't forget to save!"))
		private_notes_window(user)
