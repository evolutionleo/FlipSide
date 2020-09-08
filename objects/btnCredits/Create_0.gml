/// @desc

// Inherit the parent event
event_inherited();

onClick = function() {
	startTransition(TransitionSlideIn, function() { room_goto(rCredits) })
}