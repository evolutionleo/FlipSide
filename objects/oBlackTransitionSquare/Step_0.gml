/// @desc

if time_offset {
	time_offset--
}
else {
	scale = clamp(scale + scale_spd, 0, 1)
	image_angle += angle_spd
}


if time_offset2 {
	time_offset2--
}
else if time_offset2 == 0 {
	angle_spd = -360/global.return_time
	scale_spd = -1/global.return_time
}

if image_angle > 360 {
	image_angle = 0
	angle_spd = 0
}
else if scale < 0 {
	instance_destroy()
}


if scale <= 0 {
	instance_destroy()
}
else {
	image_xscale = scale
	image_yscale = scale
}