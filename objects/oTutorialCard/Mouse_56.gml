/// @desc

//if live_call() return live_result

if global.dragging == id
{
	global.dragging = noone
	
	
	if dark_side and y < room_height / 2 {
		startTransition(TransitionSlideOut, function() { room_goto(Room1) })
		instance_destroy()
	}
}