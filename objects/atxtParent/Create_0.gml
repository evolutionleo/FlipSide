/// @desc Autotype!

event_inherited();

// when the typing is over
onEnd = function() {
	
}

// whenever a single character is typed
onCharacter = function() {
	__onCharacter()
}

__onCharacter = function() {
	atype_char++
	if (atype_char >= string_length(text))
		onEnd()
}


Input = require("input")
Input.addBind("typeskip", vk_space, "keyboard")
Input.addBind("typeskip", mb_left, "mouse")


atype_char = 1


onStep = function() {
	if Input.getDown("typeskip") {
		scribble_autotype_skip(scribble)
	}
}

onChange = function() {
	scribble_autotype_fade_in(scribble, type_speed, type_smooth, type_perline)
}


scribble_autotype_fade_in(scribble, type_speed, type_smooth, type_perline)
scribble_autotype_function(scribble, onCharacter)