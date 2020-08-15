/// @desc

var is_targeted = false

with(oCard) {
	if target == other.id
		is_targeted = true
}

if is_targeted {
	ease_pos += .03
	//image_blend = c_red
}
else {
	ease_pos -= .04
	//image_blend = c_white
}


ease_pos = clamp(ease_pos, 0, .3)
channel = animcurve_get_channel(cvEnemyEaseIn, "curve1")
scale = animcurve_channel_evaluate(channel, ease_pos)


color_val = lerp(0, .7, ease_pos/.3)
image_blend = merge_color(c_white, c_red, color_val)


image_xscale = BASE_ENEMY_XSCALE * scale
image_yscale = BASE_ENEMY_YSCALE * scale

flash_alpha -= .025