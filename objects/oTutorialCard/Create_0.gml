/// @desc

ease_pos = 0
flip_pos = 0

flipping = false

dark_side = false

startx = xstart
starty = ystart

targetx = x
targety = y
interpolation = .5

if !variable_global_exists("dragging")
	global.dragging = noone


on_mouse = function() {
	return bbox_left < mouse_x and bbox_right > mouse_x and bbox_top < mouse_y and bbox_bottom > mouse_y
}