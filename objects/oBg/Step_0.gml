/// @desc

var _x = layer_get_x(lay_id)
var _y = layer_get_y(lay_id)

layer_x(lay_id, _x + bg_spd.x)
layer_y(lay_id, _y + bg_spd.y)