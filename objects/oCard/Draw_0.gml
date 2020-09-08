/// @desc

//if live_call() return live_result

draw_self()

if my_card == -1 or is_undefined(my_card)
	exit


draw_get()

#region Draw card text
//draw_set_font(fCard)
if image_index == 0 {
	//draw_set_color(my_card.color)
	var col = my_card.color
	var text = my_card.text
}
else {
	//draw_set_color(my_card.side_color)
	var col = my_card.side_color
	var text = my_card.side_text
}
text = my_card.parse(text, flip_pos < .5)

draw_set_align(fa_center, fa_top)
draw_set_font(fCard)
//var hei = string_height(text)/4

//col = c_white

var pre = "[fCard][d#"+string(col)+"]"
var post = "[/f]"


var _scale

if string_length(text) < 15 {
	_scale = 1/5
}
else if string_length(text) < 20 {
	_scale = 1/6
}
else if string_length(text) < 40 {
	_scale = 1/7
}
else {
	_scale = 1/8
}

#region //Textbox highlight for debugging

if DEBUG_MODE {
	//var x1 = CARD_TEXTBOX_X - CARD_TEXTBOX_W/2 / CARD_XSCALE_MOD
	//var x2 = CARD_TEXTBOX_X + CARD_TEXTBOX_W/2 / CARD_XSCALE_MOD
	//var y1 = CARD_TEXTBOX_Y - CARD_TEXTBOX_H/2 / CARD_YSCALE_MOD
	//var y2 = CARD_TEXTBOX_Y + CARD_TEXTBOX_H/2 / CARD_YSCALE_MOD
	
	//draw_set_color(c_red)
	//draw_set_alpha(.5)
	//draw_rectangle(x1, y1, x2, y2, false)
}

#endregion


var xscale = image_xscale*_scale*CARD_XSCALE_MOD
var yscale = image_yscale*_scale*CARD_YSCALE_MOD
scribble_set_transform(xscale, yscale, image_angle)
// /yscale for purpose
scribble_set_wrap(CARD_TEXTBOX_W/yscale, CARD_TEXTBOX_H/yscale, false)
scribble_set_box_align(fa_center, fa_middle, false)
// y + 26*image_yscale -hei/2*image_yscale
scribble_draw(CARD_TEXTBOX_X, CARD_TEXTBOX_Y, pre+ text +post)

//if DEBUG_MODE { // ugly frick
//	scribble_set_transform(4, 4, 0)
//	scribble_draw(x, y, string(my_card.cost))
//}

#endregion
#region Credit the artist

if state == CARD_STATE.CREDITS
{
	var _x = x
	var _y = bbox_bottom
	draw_set_font(fCredit)
	draw_set_align(fa_center, fa_top)
	
	draw_set_color(c_gray)
	draw_text_transformed(_x+.5, _y+.5, "Art: " + my_card.artist, .75, .75, 0)
	draw_set_color(c_white)
	draw_text_transformed(_x   , _y	  ,	"Art: " + my_card.artist, .75, .75, 0)
}

#endregion

draw_reset()