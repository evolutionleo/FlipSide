/// @desc

draw_self()

#region Flash

if flash_alpha > 0 {
	shader_set(shFlash)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, flash_color, flash_alpha)
	shader_reset()
}
#endregion
#region Icons

var bottom = y + 8*image_yscale

var _x = bbox_left
var _y = bottom + 4
var xs = ICON_WIDTH  / sprite_get_width(sEffectIcon)
var ys = ICON_HEIGHT / sprite_get_height(sEffectIcon)
//var xs = ICON_WIDTH  / 16
//var ys = ICON_HEIGHT / 16

draw_get()


if intention.type == INTENTIONS.ATTACK {
	// attack icon
	draw_sprite_ext(sIntentions, INTENTIONS.ATTACK, _x, _y, xs, ys, 0, c_white, 1.0)

	draw_set_font(fIcon)
	draw_set_color(c_white)
	draw_text(_x, _y+ICON_HEIGHT/2, string(intention.value))

	_x += ICON_WIDTH
}
else if intention == INTENTIONS.HEAL {
	// heal icon
	draw_sprite_ext(sIntentions, INTENTIONS.HEAL, _x, _y, xs, ys, 0, c_white, 1.0)
	
	draw_set_font(fIcon)
	draw_set_color(c_white)
	draw_text(_x, _y+ICON_HEIGHT/2, string(intention.value))

	_x += ICON_WIDTH
}

id._x = _x
id._y = _y
id.xs = xs
id.ys = ys

effects.forEach(function(effect) {
	var eff = effect.effect
	var amount = effect.pow
	
	draw_sprite_ext(sEffectIcon, eff, _x, _y, xs, ys, 0, c_white, 1.0)
	draw_text(_x, _y+ICON_HEIGHT/2, string(amount))
	
	_x += ICON_WIDTH
})
_x = id._x
_y = id._y


draw_reset()
#endregion