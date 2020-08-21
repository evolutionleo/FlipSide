/// @desc

onStep()

if on_mouse() || instance_exists(oMenu) && global.selected_btn == id
{
	// I'm the selected button!
	global.selected_btn = id
	global.btn_pointer = global.menu_buttons.find(id)
	
	// Initially I had the if/else branch, but then I cut it
	onHover()
	
	if (mouse_check_button(mb_left) and on_mouse()) || Input.get("select")
		onHold()
	
	if (mouse_check_button_released(mb_left) and on_mouse()) || Input.getReleased("select")
		onClick()
	
}
else
	onDefault()