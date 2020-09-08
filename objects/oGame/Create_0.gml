/// @desc

#region BLYAT' VERSTKA SLETELA
#macro elseif else if
#macro elif else if


#region BLYAT' VERSTKA SLETELA

//#macro CARD_WIDTH  64*1.5
//#macro CARD_HEIGHT 96*1.5
#macro CARD_WIDTH  96
#macro CARD_HEIGHT 144
#macro CARD_OFFX 16
#macro CARD_OFFY 0

#macro CREDIT_CARD_WIDTH 96*1.15
#macro CREDIT_CARD_HEIGHT 144*1.15
#macro BASE_CREDIT_CARD_XSCALE (CREDIT_CARD_WIDTH  / sprite_get_width(sprite_index))
#macro BASE_CREDIT_CARD_YSCALE (CREDIT_CARD_HEIGHT  / sprite_get_height(sprite_index))
#macro NORMAL_CREDIT_CARD_XSCALE (CREDIT_CARD_WIDTH  / (128 / 2))
#macro NORMAL_CREDIT_CARD_YSCALE (CREDIT_CARD_HEIGHT / 96)
#macro CREDIT_CARD_XSCALE_MOD (NORMAL_CREDIT_CARD_XSCALE / BASE_CREDIT_CARD_XSCALE)
#macro CREDIT_CARD_YSCALE_MOD (NORMAL_CREDIT_CARD_YSCALE / BASE_CREDIT_CARD_YSCALE)

// Scale without considering flipping and tweening
#macro BASE_CARD_XSCALE (CARD_WIDTH  / sprite_get_width(sprite_index))
#macro BASE_CARD_YSCALE (CARD_HEIGHT / sprite_get_height(sprite_index))
// BASE_CARD_XSCALE for standard 128x96 cards
#macro NORMAL_CARD_XSCALE (CARD_WIDTH  / (128 / 2))
#macro NORMAL_CARD_YSCALE (CARD_HEIGHT / 96)
// 1 for normal 128x96 cards,
// different for other resolutions
#macro CARD_XSCALE_MOD (NORMAL_CARD_XSCALE / BASE_CARD_XSCALE)
#macro CARD_YSCALE_MOD (NORMAL_CARD_YSCALE / BASE_CARD_YSCALE)

// Position to draw card text at
#macro CARD_TEXTBOX_X (x + .5*image_xscale*CARD_XSCALE_MOD)
#macro CARD_TEXTBOX_Y (y +28 *image_yscale*CARD_YSCALE_MOD)

// The dimensions of the card textbox
#macro CARD_TEXTBOX_W ((CARD_WIDTH - 15) / BASE_CARD_XSCALE) * image_xscale * CARD_YSCALE_MOD / flip
#macro CARD_TEXTBOX_H ((CARD_HEIGHT / 3) / BASE_CARD_YSCALE) * image_yscale * CARD_XSCALE_MOD

// Where to display the drafting cards thing
#macro CHOICE_X room_width/2
#macro CHOICE_Y room_height/2

// Deck position
#macro DECK_X 64
#macro DECK_Y 64
// Deck display size
#macro DECK_WIDTH  80
#macro DECK_HEIGHT 104

// Enemy
#macro ENEMY_WIDTH  80
#macro ENEMY_HEIGHT 80

#macro BASE_ENEMY_XSCALE (ENEMY_WIDTH  / sprite_get_width(sprite_index))
#macro BASE_ENEMY_YSCALE (ENEMY_HEIGHT / sprite_get_height(sprite_index))


// Discard pile position
//#macro GRAVE_X 64-10
//#macro GRAVE_Y 64+104
#macro GRAVE_X 54
#macro GRAVE_Y 168
#macro GRAVE_WIDTH 64
#macro GRAVE_HEIGHT 64

// Exile pile position
#macro EXILE_X room_width/2
#macro EXILE_Y room_height/2


// Mana crystal UI display
//#macro MANA_WIDTH 24
//#macro MANA_HEIGHT 32
#macro MANA_WIDTH 32
#macro MANA_HEIGHT 48
#macro MANA_OFFX 4
#macro MANA_OFFY 0

// Status effects and enemies' intentions
#macro ICON_WIDTH 24
#macro ICON_HEIGHT 24
#macro ICON_OFFX 4
#macro ICON_OFFY 0

// The current dragging card
global.dragging = noone

// Hand position on screen
//HANDX = room_width  / 3 * 2 - 24
#macro HANDX room_width - 192 - 128
#macro HANDY room_height - 96

// Minimal y for a card to be threated as not in hand
global.playy = HANDY - 64

// Scaling the deck up and down
global.deck_xs = 4
global.deck_ys = 4

global.deck_ease = 0


#endregion
#endregion

if !variable_global_exists("lemmedie") or !global.lemmedie
{

global.player	 = new Player()
global.card_inst = new Array()


my_gui_alpha = 1

#region Initial setup

repeat(4) {
	global.player.deck.append(new Card("Fire"))
}

global.player.deck.append(new Card("Water"))

global.battles = 0
global.area = 0
global.area_name = "Cave"

}
else {
	global.player.deck.append(new Card("Water"))
	trace(global.player.deck)
	blah = false
}

global.choice = false

startBattle()

#endregion