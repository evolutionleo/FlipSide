/// @desc

// Inherit the parent event
event_inherited();

onClick = function() {
	global.lemmedie = true
	room_goto(Room1)

	setTimeout(noone, function() {
		global.battles = 11-1
		endBattle()
	}, 1)
}