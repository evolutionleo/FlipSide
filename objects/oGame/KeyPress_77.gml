/// @desc

if audio_is_playing(aMusic2) or audio_is_playing(aMusic) {
	//audio_stop_all()
	audio_pause_all()
	global.mute = true
}
else	 {
	//audio_play_sound(aMusic2, 1000, true)
	//if audio_is_paused(aMusic)
	audio_resume_all()
	global.mute = false
}