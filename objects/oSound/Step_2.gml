/// @desc

//if global.mute
//	global.master_volume = 0
//if global.sound_mute
//	global.sound_volume = 0
//if global.music_mute
//	global.music_volume = 0


master = vinyl_buss_get("master")

//vinyl_lib.master.gain	  = global.master_volume / 100
master.gain	  = global.master_volume / 100
vinyl_lib.sound_buss.gain = global.sound_volume	 / 100
vinyl_lib.music_buss.gain = global.music_volume  / 100


vinyl_system_end_step()