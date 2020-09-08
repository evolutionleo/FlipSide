/// @desc

if sprite_index != sDefaultButton {
	draw_self()
}

draw_get()

if text != ""
{

//var midx = (bbox_left + bbox_right) / 2
//var midy = (bbox_bottom + bbox_top) / 2
var _x = x
var _y = y

draw_set_align(halign, valign)
draw_set_font(fMenuButton)

draw_set_color(col2)
draw_text(_x+.8, _y+1, text)

draw_set_color(col)
draw_text(_x, _y, text)

}

draw_reset()