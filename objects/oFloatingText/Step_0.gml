/// @desc pos and alpha
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

//if timer > fade_offset
//	alpha -= fade_speed

// Fadein
if timer < fadein_time {
	fade_speed = fadein_speed
}
// Fadeout
else if timer > lifetime + fadein_time and timer < lifetime + fadein_time + fadeout_time {
	fade_speed = -fadeout_speed
}
// No fade
else {
	fade_speed = 0
}

alpha += fade_speed


if fadein_time + lifetime + fadeout_time < timer
	instance_destroy()