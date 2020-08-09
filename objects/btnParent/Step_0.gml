/// @desc

onStep()

if on_mouse()
{
	// Initially I had the if/else branch, but then I cut it
	onHover()
	
	if mouse_check_button(mb_left)
		onHold()
	
	//if mouse_check_button_released(mb_left)
	//	onClick()
}
else
	onDefault()