/// @desc

function __init__() {
	static initialized = false
	
	if !initialized {
		scribble_init("Fonts", "fCard", false)
		//scribble_add_font("fCard")
		for(var i = 0; i < 999; ++i) {
			if (!font_exists(i))
				break
			
			scribble_add_font(font_name(i))
		}
		
		
		display_set_gui_size(room_width, room_height)
		
		
		live_blank_object = oBlank
		live_blank_room = rBlank
		
		//room_set_live(rMenu, true)
		//sprite_set_live(sDefaultButton, true)
		
		initialized = true
	}
	
	//room_goto_live(rMenu)
	//room_goto(rMenu)
	
	load_settings()
}

__init__()
