/// @desc

lay_ids.forEach(function(lay_id) {
	if lay_id == -1 {
		return 0 // don't break forEach()
	}
	
	var _x = layer_get_x(lay_id)
	var _y = layer_get_y(lay_id)
	
	layer_x(lay_id, _x + bg_spd.x)
	layer_y(lay_id, _y + bg_spd.y)
})