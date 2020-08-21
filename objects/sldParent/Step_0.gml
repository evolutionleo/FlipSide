/// @desc

prev_value = value


if active {
	if Input.get("right") or Input.get("left") {
		repeat_delay++
	}
	else {
		repeat_delay = 0
	}
	
	if Input.getPressed("right") {
		value += step
	}
	else if Input.getPressed("left") {
		value -= step
	}
	else if Input.get("right") and repeat_delay > max_repeat_delay {
		value += small_step
	}
	else if Input.get("left") and repeat_delay > max_repeat_delay {
		value -= small_step
	}
	
	
	if on_mouse() {
		if mouse_check_button_pressed(mb_left) {
			clicked = true
			onPress()
			
			set_value()
		}
		else if mouse_check_button(mb_left) {
			onHold()
		}
		else {
			onHover()	
		}
	}
	if clicked and mouse_check_button(mb_left) and nearly_on_mouse()
		set_value()
}
else {
	onDefault()
	repeat_delay = 0
}

if mouse_check_button_released(mb_left)
or distance_to_point(mouse_x, mouse_y) > 64 {
	clicked = false
}


value = clamp(value, min_value, max_value)

if value != prev_value
	onChange()