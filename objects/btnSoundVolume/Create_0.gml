/// @desc

// Inherit the parent event
event_inherited();

var scale = .75
var _x = bbox_left - sprite_get_width(sDefaultSlider) / 2 - 10
var _y = y

my_slider = instance_create_layer(_x, _y, layer, sldSoundVolume)
my_slider.image_xscale = scale
my_slider.image_yscale = scale