/// @desc

if !initialized
	exit


draw_self()

#region Flash

if flash_alpha > 0 {
	shader_set(shFlash)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, flash_color, flash_alpha)
	shader_reset()
}
#endregion
#region Icons

//var bottom = y + 8*image_yscale
var bottom = bbox_bottom

var _x = bbox_left
var _y = bottom + 4
var xs = ICON_WIDTH  / sprite_get_width(sEffectIcon)
var ys = ICON_HEIGHT / sprite_get_height(sEffectIcon)
//var xs = ICON_WIDTH  / 16
//var ys = ICON_HEIGHT / 16

draw_get()

//trace("Drawing intention: %", intention)


// Intention Icon
draw_sprite_ext(sIntentions, intention.type, _x, _y, xs, ys, 0, c_white, 1.0)
	
draw_set_font(fIcon)
draw_set_color(c_white)
draw_text(_x, _y+ICON_HEIGHT/2, string(intention.value))

_x += ICON_WIDTH


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
#region Healthbar

var x1 = (bbox_left + bbox_right) / 2 - (max_hp) / 2
var x2 = (bbox_left + bbox_right) / 2 + (max_hp) / 2
var x3 = lerp(x1, x2, hp/max_hp)

//var top = y - 8*image_yscale
var top = bbox_top

var y1 = top - 5 - 15
var y2 = top - 5

draw_get()

draw_set_color(hpbar_color)
draw_rectangle(x1, y1, x3, y2, false)
draw_set_color(hpbar_textcolor)
draw_rectangle(x1, y1, x2, y2, true)

draw_set_halign(fa_left)
draw_set_valign(fa_middle)

var _x = x1 + 3
var _y = (y1 + y2) / 2
draw_set_font(fHealthbar)
//draw_text(_x, _y, str_format("hp:%/%", hp, max_hp))
draw_text(_x, _y, str_format("%/%", hp, max_hp))

draw_reset()

#endregion