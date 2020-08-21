/// @desc

if live_call() return live_result

//draw_text(15, 15, global.turn)
draw_get()

if !global.transition {
	//	my_gui_alpha -= .05
	//}
	//else {
	//	my_gui_alpha += .1
	//}

	draw_set_color(c_yellow)
	draw_set_alpha(my_gui_alpha)
	draw_set_halign(fa_center)
	draw_set_valign(fa_top)
	draw_set_font(fTurn)

	if global.choice
		var text = "Choose a card"
	else
		text = "Turn "+string(global.full_turns)

	//draw_text_transformed(room_width/2, 15, text, 1, 1, 0)
	draw_text(room_width/2, 15, text)


	// Trash
	//draw_set_valign(fa_bottom)
	//draw_set_halign(fa_left)
	//draw_set_font(fTutorial)
	//draw_text(64, room_height - 64, tutor_str)

	draw_reset()
	//global.player.drawHand(room_width/2, room_height/3*2)
	
	global.player.drawDeck(DECK_X, DECK_Y)
	if !global.choice {
		global.player.drawGraveyard(GRAVE_X, GRAVE_Y)
	}
}