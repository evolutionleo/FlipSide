/// @desc

// Override these to create different buttons

// Is called on mouse release
onClick = function() {
	// show_message("Clicked!")
}

// Is called every frame
onStep = function() {
	// y = ystart + sin(current_time / 1000)
}

// Is called every frame if not hovered/pressed
onDefault = function() {
	// image_index = 0
}

// Is called every frame if mouse is hovered over the button
onHover = function() {
	// image_index = 1
}

// Is called every frame if mouse is hovered and down
onHold = function() {
	// image_index = 2
}


// static function! Do not override! (unless you know what you're doing)
on_mouse = function() {
	return bbox_left < mouse_x and bbox_right > mouse_x
	   and bbox_top < mouse_y  and bbox_bottom > mouse_y
}

Input = require(@'input')