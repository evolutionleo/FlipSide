/// @desc

// Inherit the parent event
event_inherited();

onClick = function() {
	//startTransition(TransitionIn, function() {
		room_goto(Room1)
		
		setTimeout(noone, function() {
			load_game()
		}, 1)
	//})
}


if !file_exists("save1.game")
	instance_destroy()


