/// @desc

if global.dragging == id
{
	targetx = mouse_x
	targety = mouse_y
	interpolation = .8
}
else
{
	targetx = startx
	targety = starty
	interpolation = .3
}


if on_mouse() and (global.dragging == noone or global.dragging == id) {
	ease_pos += .02
}
else {
	ease_pos -= .02
}


if flipping
{
	if dark_side {
		flip_pos -= .05
		if flip_pos < 0 {
			dark_side = false
			flipping = false
		}
	}
	else {
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

if !flipping
	image_index = dark_side


//my_card.side = dark_side


ease_pos = clamp(ease_pos, 0, .3)
ease_channel = animcurve_get_channel(cvCardEaseIn, "curve1")
scale = animcurve_channel_evaluate(ease_channel, ease_pos)

image_xscale = (CARD_WIDTH / sprite_get_width(sprite_index) + scale) * flip
image_yscale = CARD_HEIGHT / sprite_get_height(sprite_index) + scale


x = lerp(x, targetx, interpolation)
y = lerp(y, targety, interpolation)