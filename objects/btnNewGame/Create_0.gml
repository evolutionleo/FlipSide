/// @desc

// Inherit the parent event
event_inherited();

onClick = function() {
	startTransition(TransitionIn, function() { room_goto(Room1) })
}