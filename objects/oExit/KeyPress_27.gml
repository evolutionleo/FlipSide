/// @desc Go out

//save_game()

if room != rMenu
	startTransition(TransitionOut, function() { room_goto(rMenu) })
else
	startTransition(TransitionOut, function() { game_end() })