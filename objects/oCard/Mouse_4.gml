/// @desc

//if live_call() return live_result

if state == CARD_STATE.DISCARD
	exit

global.dragging = id

if state == CARD_STATE.HAND
	layer = layer_get_id("ActiveCard")
else if state == CARD_STATE.CHOICE {
	depth = 0
	layer = layer_get_id("Choice")
	global.deck_xs = 5
	global.deck_ys = 5
}