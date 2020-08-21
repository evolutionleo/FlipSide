/// @desc

++timer

if stuck
{
	if instance_exists(stuck) {
		if offx == "auto" then offx = x - stuck.x
		if offy == "auto" then offy = y - stuck.y
	
		x = stuck.x + offx
		y = stuck.y + offy
	}
	else {
		stuck = false
	}
}
else {
	x += spd.x
	y += spd.y
}
if timer > fade_offset
	alpha -= fade_speed

if lifetime < timer
	instance_destroy()