/// @desc

if !variable_global_exists("lemmedie") or !global.lemmedie
{

global.player	 = new Player()
global.card_inst = new Array()


#region BLYAT' VERSTKA SLETELA

//#macro CARD_WIDTH  64*1.5
//#macro CARD_HEIGHT 96*1.5
#macro CARD_WIDTH  96
#macro CARD_HEIGHT 144
#macro CARD_OFFX 16
#macro CARD_OFFY 0

#macro BASE_CARD_XSCALE (CARD_WIDTH  / sprite_get_width(sprite_index))
#macro BASE_CARD_YSCALE (CARD_HEIGHT / sprite_get_height(sprite_index))

#macro CARD_TEXTBOX_X x + .5*image_xscale
#macro CARD_TEXTBOX_Y y +28*image_yscale
#macro CARD_TEXTBOX_W ((CARD_WIDTH - 15) / BASE_CARD_XSCALE) * image_xscale / flip
#macro CARD_TEXTBOX_H ((CARD_HEIGHT / 3) / BASE_CARD_YSCALE) * image_yscale

#macro CHOICE_X room_width/2
#macro CHOICE_Y room_height/2

#macro DECK_WIDTH  80
#macro DECK_HEIGHT 104


#macro GRAVE_X 64-10
#macro GRAVE_Y 64+104

#macro EXILE_X room_width/2
#macro EXILE_Y room_height/2

#macro DECK_X 64
#macro DECK_Y 64


//#macro MANA_WIDTH 24
//#macro MANA_HEIGHT 32
#macro MANA_WIDTH 36
#macro MANA_HEIGHT 48
#macro MANA_OFFX 4
#macro MANA_OFFY 0

#macro ICON_WIDTH 24
#macro ICON_HEIGHT 24
#macro ICON_OFFX 4
#macro ICON_OFFY 0

global.dragging = noone

//HANDX = room_width  / 3 * 2 - 24
#macro HANDX room_width - 192 - 128
#macro HANDY room_height - 96

// Minimal y for a card to be threated as not in hand
global.playy = HANDY - 64


global.deck_xs = 4
global.deck_ys = 4


global.deck_ease = 0

#endregion

repeat(4) {
	global.player.deck.append(new Card("Fire"))
}

global.player.deck.append(new Card("Water"))

global.battles = 0

}
else {
	global.player.deck.append(new Card("Water"))
	trace(global.player.deck)
	blah = false
}


global.choice = false

startBattle()





if !variable_global_exists("mute") {
	global.mute = false
}

if !global.mute and !audio_is_playing(aMusic) and !audio_is_playing(aMusic2)
	audio_play_sound(aMusic, 1000, false)