/// @desc

onChange = function() {
	
}

onHold = function() {
	
}

onPress = function() {
	
}

onHover = function() {
	
}

onDefault = function() {
	
}


nearly_on_mouse = function() {
	var off = 16
	return bbox_left - off < mouse_x and bbox_right + off > mouse_x
	   and bbox_top - off < mouse_y  and bbox_bottom + off > mouse_y
}
// static function! Do not override! (unless you know what you're doing)
on_mouse = function() {
	return bbox_left < mouse_x and bbox_right > mouse_x
	   and bbox_top < mouse_y  and bbox_bottom > mouse_y
}


// based on mouse
set_value = function() {
	var x1 = bbox_left
	var x2 = bbox_right
	
	var perc = (mouse_x - x1) / (x2 - x1)
	value = lerp(min_value, max_value, perc)
}


prev_value = value

repeat_delay = 0
max_repeat_delay = room_speed * .3

clicked = false


Input = require("input")