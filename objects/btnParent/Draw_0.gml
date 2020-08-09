/// @desc

draw_self()

draw_get()

if text != ""
{

var midx = (bbox_left + bbox_right) / 2
var midy = (bbox_bottom + bbox_top) / 2

draw_set_align(fa_center, fa_middle)
draw_set_font(fMenuButton)
draw_set_color(c_white)
draw_text(midx, midy, text)

}

draw_reset()