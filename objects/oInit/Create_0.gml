/// @desc

function __init__() {
	static initialized = false
	
	if !initialized {
		scribble_init("Fonts", "fCard", false)
		scribble_add_font("fCard")
		
		display_set_gui_size(room_width, room_height)
		
		initialized = true
	}
}

__init__()