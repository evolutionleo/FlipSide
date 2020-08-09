/// @desc Draw custom healthbar

event_inherited()

var x1 = (bbox_left + bbox_right) / 2 - (max_hp) / 2
var x2 = (bbox_left + bbox_right) / 2 + (max_hp) / 2
var x3 = lerp(x1, x2, hp/max_hp)
var top = y - image_xscale*8

var y1 = top - 5 - 15
var y2 = top - 5

draw_get()

draw_set_color(c_blue)
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