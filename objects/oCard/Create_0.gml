/// @desc

enum CARD_STATE {
	HAND,
	CHOICE,
	DISCARD,
	INACTIVE,
	EXILE
}

state = CARD_STATE.HAND


index = -1
my_card = -1

ease_pos = 0
flip_pos = 0

flipping = false

dark_side = false

// Not just renaming, we'll change that later
startx = xstart
starty = ystart

targetx = x
targety = y
interpolation = .5


on_mouse = function() {
	return bbox_left < mouse_x and bbox_right > mouse_x and bbox_top < mouse_y and bbox_bottom > mouse_y
}

prev_on_mouse = false


// SFX

my_sound = -1
hover_sounds = new Array(aCardHover1)
play_sounds = new Array(aCardPlay1)

//for(var snd = aCardHover1; snd <= aCardHover4; ++snd) {
	//hover_sounds.Append(snd)
//}