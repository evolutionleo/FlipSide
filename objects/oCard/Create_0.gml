/// @desc

enum CARD_STATE {
	HAND,
	CHOICE,
	CHOICE_END,
	DISCARD,
	INACTIVE,
	EXILE,
	CREDITS
}

state = CARD_STATE.HAND

draggable = true

index = -1
my_card = -1
target = noone

ease_pos = 0
flip_pos = 0

flip = 1


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

//for(var snd = aCardHover1; snd <= aCardHover4; ++snd) {
	//hover_sounds.Append(snd)
//}

image_speed = 0