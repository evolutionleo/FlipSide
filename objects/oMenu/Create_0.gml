/// @desc the Init

global.btn_pointer = 0
global.selected_btn = noone
global.menu_buttons = new Array()

#region Fill the buttons array

// Add all the buttons
with(btnParent)
{
	// Every element is an array
	global.menu_buttons.append([id, y])
}

// Sort by y pos
global.menu_buttons.sort(function(btn1, btn2) {
	return btn1[1] > btn2[1] // Compare y's
})

// Remove y positions from list
global.menu_buttons.lambda(function(btn) {
	return btn[0] // Get rid of the second element of the nested array
})

#endregion
#region //Manual drawing/processing

//#macro BTN_WIDTH 96
//#macro BTN_HEIGHT 16

//global.menu_buttons = new Array
//(
//	{text: "Play", onClick: function() { room_goto(rTutorial) }}
//)

//drawButton = function(btn, x, y) {
//	var w = BTN_WIDTH
//	var h = BTN_HEIGHT
	
//	draw_set_color(c_white)
//	draw_rectangle(x-w/2, y-h/2, x+w/2, y+h/2, true)
	
//	draw_set_font(fMenuButton)
//	draw_set_align()
//	draw_text()
//}
#endregion


Input = require("input")
Input.addBind("press", vk_space)