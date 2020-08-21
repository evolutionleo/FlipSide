/// @desc

if live_call()
	return live_result

var perc = (value - min_value) / (max_value - min_value)

var x1 = bbox_left
var x2 = bbox_right

var _x = lerp(x1, x2, perc)
var _y = y

var scale = .85 * image_xscale


draw_self()
//draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_gray, image_alpha)

draw_sprite_ext(sDefaultSlider2, 0, _x, _y, scale, scale, image_angle, image_blend, image_alpha)
//draw_sprite_ext(sDefaultSlider2, 0, _x+1, _y+1, scale, scale, image_angle, c_gray, image_alpha)