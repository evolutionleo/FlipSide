/// @desc

// Apparently Breaks because of animcurves
//if live_call() return live_result


//my_card = -1
//exit


//trace("Card id#%, target: %", id, target)


if state == CARD_STATE.HAND or state == CARD_STATE.CHOICE
{

if index != -1
{
	if state == CARD_STATE.HAND {
		my_card = global.player.hand.get(index)
	}
	else if state == CARD_STATE.CHOICE {
		my_card = global.choices.get(index)
	}
	else {
		trace("Undefined state!")
		my_card = -1
	}
	
	if my_card != -1
	{
		sprite_index = my_card.spr
	
		if !variable_struct_exists(my_card, "side")
			my_card.side = dark_side
	
		if !flipping {
			image_index = my_card.side
			dark_side = my_card.side
			if dark_side {
				flip_pos = 1
			}
			else {
				flip_pos = 0
			}
		}
	
		if state == CARD_STATE.HAND {
			targeting = (my_card.targeting      and !my_card.side)
					 or (my_card.side_targeting and  my_card.side)
		}
		else {
			targeting = false
		}
	
		if global.dragging == id
		{
			targetx = mouse_x
			targety = mouse_y
			interpolation = .8
		
			if state == CARD_STATE.CHOICE
			{
				if !variable_global_exists("deck_ease") {
					global.deck_ease = 0
				}
				if distance_to_point(DECK_X, DECK_Y) < 128 {
					global.deck_ease += .04 // To compensate the -
				}
			}
			else if targeting and y < global.playy
			{
				target = instance_nearest(x, y, oEnemy)
				
				if distance_to_object(target) < 128 {
					// Moved everything to enemy begin step event
					
					//target.ease_pos += .02
					//target.image_blend = c_red
				}
				else {
					//target.ease_pos -= .02
					target = noone
				}
			}
			else {
				target = noone
			}
	
			//my_card.x = mouse_x
			//my_card.y = mouse_y
		}
		else
		{
			targetx = my_card.x
			targety = my_card.y
			interpolation = .3
		
			startx = my_card.x
			starty = my_card.y
		}
	
	
	}
}

if on_mouse() and (global.dragging == noone or global.dragging == id)
{
	ease_pos += .02
	
	if state == CARD_STATE.HAND {
		layer = layer_get_id("ActiveCard")
	}
	else if state == CARD_STATE.CHOICE {
		layer = layer_get_id("Choice")
		depth = 0
	}
	
	
	if !prev_on_mouse and global.dragging == noone //and !audio_is_playing(my_sound)
    {
		my_sound = hover_sounds.getRandom()
		audio_play_sound(my_sound, 10, false)
	}
	
	
	prev_on_mouse = true
}
else // Not on mouse
{
	ease_pos -= .02
	if state == CARD_STATE.HAND
		layer = layer_get_id("Cards")
	else if state == CARD_STATE.CHOICE {
		layer = layer_get_id("Choice")
		depth = 1
	}
	
	prev_on_mouse = false
}


if flipping and my_card != -1
{
	if dark_side {
		my_card.side = false
		
		flip_pos -= .05
		if flip_pos < 0 {
			dark_side = false
			flipping = false
		}
	}
	else {
		my_card.side = true
		
		flip_pos += .05
		if flip_pos > 1 {
			dark_side = true
			flipping = false
		}
	}
		
	if flip_pos < .5
		image_index = 0
	else
		image_index = 1
}


flip_pos = clamp(flip_pos, 0, 1)
flip_channel = animcurve_get_channel(cvFlipping, "curve1")
flip = animcurve_channel_evaluate(flip_channel, flip_pos)


ease_pos = clamp(ease_pos, 0, .3)
ease_channel = animcurve_get_channel(cvCardEaseIn, "curve1")
scale = animcurve_channel_evaluate(ease_channel, ease_pos)

image_xscale = ( BASE_CARD_XSCALE + (scale / CARD_XSCALE_MOD) ) * flip
image_yscale =   BASE_CARD_YSCALE + (scale / CARD_YSCALE_MOD)


x = lerp(x, targetx, interpolation)
y = lerp(y, targety, interpolation)

} // other state 
else if state == CARD_STATE.DISCARD
{
	target = noone
	
	interpolation = .1
	
	x = lerp(x, targetx, interpolation)
	y = lerp(y, targety, interpolation)
	
	image_xscale *= .9
	image_yscale = image_xscale
	
	image_alpha *= .9
	
	if point_distance(x, y, targetx, targety) <= 5 || image_alpha <= 0.01 || image_xscale <= 0.01
		instance_destroy()
}
else if state == CARD_STATE.CHOICE_END
{	
	target = noone
	
	interpolation = .1
	
	x = lerp(x, targetx, interpolation)
	y = lerp(y, targety, interpolation)
	
	image_xscale *= .9
	image_yscale = image_xscale
	
	image_alpha *= .9
	
	image_angle += 3
	
	
	if image_alpha <= 0.01 || image_xscale <= 0.01
		instance_destroy()
}
else if state == CARD_STATE.EXILE
{
	target = noone
	
	interpolation = .1
	
	x = lerp(x, targetx, interpolation)
	y = lerp(y, targety, interpolation)
	
	image_xscale *= .8
	image_yscale = image_xscale
	
	image_alpha *= .9
	
	if point_distance(x, y, targetx, targety) <= 5 || image_alpha <= 0.01 || image_xscale <= 0.01
		instance_destroy()
}