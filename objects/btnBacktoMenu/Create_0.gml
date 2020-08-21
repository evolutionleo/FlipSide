/// @desc

// Inherit the parent event
event_inherited();

onClick = function() {
	//room_goto(rTutorial)
	//if !oTransition.transition
	startTransition(TransitionSlideOut, function() { room_goto(rMenu) })
}