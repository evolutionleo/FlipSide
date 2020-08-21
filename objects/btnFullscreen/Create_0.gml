/// @desc

// Inherit the parent event
event_inherited();

onClick = function() {
	var fullscreen = window_get_fullscreen()
	window_set_fullscreen(!fullscreen)
}