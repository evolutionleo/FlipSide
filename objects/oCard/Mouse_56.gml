/// @desc

//if live_call() return live_result


if global.dragging == id
{
	global.dragging = noone
	
	play_sound = play_sounds.getRandom()
	audio_play_sound(play_sound, 30, false)
	
	if state == CARD_STATE.HAND
		layer = layer_get_id("Cards")
	else if state == CARD_STATE.CHOICE {
		layer = layer_get_id("Choice")
		depth = 1
		global.deck_xs = 4
		global.deck_ys = 4
	}
	
	
	if targeting and target != noone {
		target.image_xscale = 5
		target.image_yscale = 5
		target.image_blend = c_white
	}
	
	if state == CARD_STATE.HAND and y > global.playy
	or targeting and target == noone
	or state == CARD_STATE.CHOICE and distance_to_point(DECK_X, DECK_Y) > 128
	{
		targetx = startx
		targety = starty
	}
	else
	{
		if state == CARD_STATE.HAND {
			//trace("My pos is",index)
			//trace("Hand is",global.player.hand)
			//show_message("STOPTIME")
			global.player.play(index, target)
		}
		else if state == CARD_STATE.CHOICE {
			global.player.deck.append(my_card)
			endCardChoice()
		}
		//instance_destroy()
	}
}