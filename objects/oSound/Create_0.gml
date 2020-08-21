/// @desc
if !variable_global_exists("mute") {
	global.mute = false
	global.master_volume = 100
	
	global.music_mute = false
	global.music_volume = 100
	
	global.sound_mute = false
	global.sound_volume = 100
}

if !variable_global_exists("audio_initialized")
	global.audio_initialized = false

function audio_init() {
	with(vinyl_library) {
		// Buss
		//vinyl_lib.master = vinyl_buss_get("master")
		master = vinyl_buss_get("master")
		with(master) {
			vinyl_lib.music_buss = vinyl_buss_create("music")
			vinyl_lib.sound_buss = vinyl_buss_create("sound effects")
		}
		
		// Music
		music_loop = vinyl_loop(aMusic, aMusic2, "")
	
		// Sound Effects
	
		// Card
		card_hover = vinyl_random(aCardHover1, aCardHover1)
		card_play = vinyl_random(aCardPlay1, aCardPlay1)
		// Player
		player_hit = vinyl_random(aPlayerHit)
		player_death = vinyl_random(aPlayerDeath)
		// Slime
		//SlimeHit = vinyl_random(aSlimeHit)
		slime_hit = vinyl_random(aSlimeHit)
		
		// Doesn't work
		music_loop.buss_name = "music"
		// Doesn't work either
		//music_loop.buss = vinyl_lib.music_buss
		
		card_hover.buss_name = "sound effects"
		card_play.buss_name	= "sound effects"
	}
}
function audio_reinit() {
	vinyl_stop(vinyl_lib.music_inst)
}


_ = function() {
	static initialized = false;
	
	if !initialized {
		initialized = true
		audio_init()
	}
	else {
		audio_reinit()
	}
}()

vinyl_lib.music_inst = vinyl_play(vinyl_lib.music_loop)