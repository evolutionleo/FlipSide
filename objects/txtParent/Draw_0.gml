/// @desc

if (show_back) then draw_self()


switch(text_x) {
	case "x":
		_text_x = x
		break
	case "bbox_left":
		_text_x = bbox_left
		break
	case "bbox_right":
		_text_x = bbox_right
		break
	case "bbox_center":
		_text_x = (bbox_right + bbox_left) / 2
		break
	default:
		show_debug_message("Yo wtf text_x unknown value ("+string(_text_x)+")")
		break
}
switch(text_y) {
	case "y":
		_text_y = y
		break
	case "bbox_top":
		_text_y = bbox_top
		break
	case "bbox_bottom":
		_text_y = bbox_bottom
		break
	case "bbox_middle":
		_text_y = (bbox_top + bbox_bottom) / 2
		break
	default:
		show_debug_message("Yo wtf text_x unknown value ("+string(_text_x)+")")
		break
}


// Some setup
scribble_set_box_align(halign, valign)

var scribble_state = scribble_get_state()
scribble_state[SCRIBBLE_STATE.ANGLE] = image_angle
scribble_state[SCRIBBLE_STATE.XSCALE] = xscale
scribble_state[SCRIBBLE_STATE.YSCALE] = yscale
scribble_set_state(scribble_state)

// Custom functions
beforeDraw()

// The thing
scribble = scribble_draw(_text_x, _text_y, scribble)

// Custom functions
afterDraw()

// Don't go global
scribble_reset()