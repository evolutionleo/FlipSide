/// @desc

//if live_call() return live_result

draw_self()


draw_get()

draw_set_font(fCard)
if flip_pos < .5 {
	draw_set_color(c_black)
	var text = "Unplayable."
}
else {
	draw_set_color($80dc00)
	var text = "Leave the\ntutorial"
}
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_text_transformed(x, y + 28*image_yscale, text, image_xscale/6, image_yscale/6, 1.0)

draw_reset()