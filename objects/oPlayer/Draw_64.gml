/// @desc Draw mana

//var _x = bbox_left
//var _y = bbox_bottom + 10

if !global.transition and !global.choice {
	var gui_wid = display_get_gui_width()
	var gui_hei = display_get_gui_height()


	var off = 2
	var _x = off
	var _y = gui_hei - off - MANA_HEIGHT

	var i = 0
	for(; i < global.player.max_mana; ++i) {
		var idx = global.player.mana > i
		var xs = MANA_WIDTH / sprite_get_width(sManaCrystal)
		var ys = MANA_HEIGHT / sprite_get_height(sManaCrystal)
	
		draw_sprite_ext(sManaCrystal, idx, _x+MANA_WIDTH/2, _y+MANA_HEIGHT/2, xs, ys, 0, c_white, 1.0)
	
		_x += MANA_WIDTH + MANA_OFFX
	}
	for(; i < global.player.mana; ++i) { // Additional mana, over the max
		var idx = 2
		var xs = MANA_WIDTH / sprite_get_width(sManaCrystal)
		var ys = MANA_HEIGHT / sprite_get_height(sManaCrystal)
	
		draw_sprite_ext(sManaCrystal, idx, _x + MANA_WIDTH/2, _y+MANA_HEIGHT/2, xs, ys, 0, c_white, 1.0)
	
		_x += MANA_WIDTH + MANA_OFFX
	}

}