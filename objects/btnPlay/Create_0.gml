/// @desc

// Inherit the parent event
event_inherited();

onClick = function() {
	//room_goto(rTutorial)
	//if !oTransition.transition
	startTransition(TransitionIn, function() { room_goto(Room1) })
}