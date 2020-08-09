/// @desc
if !global.mute and !audio_is_playing(aMusic) and !audio_is_playing(aMusic2) {
	audio_play_sound(aMusic2, 1000, true)
}