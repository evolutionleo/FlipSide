/// @desc

draw_self()

#region Debug
if DEBUG_MODE
{
	draw_get()
	draw_set_align(fa_left, fa_bottom)
	draw_text(10, room_height-64, string(global.player.effects))
	draw_reset()
}
#endregion
#region Flash

if flash_alpha > 0 {
	shader_set(shFlash)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, flash_color, flash_alpha)
	shader_reset()
}

#endregion
#region Helthbar

max_hp = global.player.max_hp
hp = global.player.hp

var x1 = (bbox_left + bbox_right) / 2 - (max_hp) / 2
var x2 = (bbox_left + bbox_right) / 2 + (max_hp) / 2
var x3 = lerp(x1, x2, hp/max_hp)

var y1 = bbox_top - 5 - 15
var y2 = bbox_top - 5

draw_get()

draw_set_color(c_red)
draw_rectangle(x1, y1, x3, y2, false)
draw_set_color(c_white)
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
#region Mana

#endregion
#region Effects
var _x = bbox_left
var _y = bbox_top - 25 - ICON_HEIGHT

global.player.drawEffects(_x, _y)
#endregion