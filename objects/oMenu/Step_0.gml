/// @desc the Update

if live_call() return live_result


move = Input.getPressed("down") - Input.getPressed("up")


global.btn_pointer += move
if global.btn_pointer > global.menu_buttons.size - 1
{
	global.btn_pointer = 0
}
if global.btn_pointer < 0
{
	global.btn_pointer = global.menu_buttons.size - 1
}

global.selected_btn = global.menu_buttons.get(global.btn_pointer)