/// @desc

// Inherit the parent event
event_inherited();

// hehen't
//on_mouse = function() {
//	return mouse_y < bbox_bottom and mouse_y > bbox_top
//}

onHover = function() {
	ease_pos += .1
	ease_state = EASE_STATE.UP
}

onDefault = function() {
	ease_pos -= .1
	ease_state = EASE_STATE.DOWN
}


enum EASE_STATE {
	STATIC,
	UP,
	DOWN
}

ease_state = EASE_STATE.STATIC

ease_pos = 0

max_ease_x = -50
max_ease_scale = 3

start_scale = image_xscale