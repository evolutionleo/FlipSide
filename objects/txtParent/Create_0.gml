/// @desc

onChange = function() {
	
}

// for example dynamically change text
onStep = function() {
	
}

// no idea how to use these :|
beforeDraw = function() {
	
}

afterDraw = function() {
	
}

// don't overwrite this
__onChange = function() {
	scribble = scribble_draw(0, 0, "["+font+"][d#"+string(color)+"]"+string(text)+"[/]")
	
	onChange();
}

font = scribble_font
prev_text = text
scribble = scribble_draw(0, 0, "["+font+"][d#"+string(color)+"]"+string(text)+"[/]")