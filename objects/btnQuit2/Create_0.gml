/// @desc

// Inherit the parent event
event_inherited();

onClick = function() {
	if show_question("Are you sure want to qui ?")
		game_end()
}