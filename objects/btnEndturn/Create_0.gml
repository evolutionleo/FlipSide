/// @desc

event_inherited()

function playableCardExists() {
	for(var i = 0; i < global.player.hand.size; ++i)
	{
		var card = global.player.hand.get(i)
		if global.player.canPlay(card)
			return true
	}
	return false
}


onClick = function() {
	if getTurner() == oPlayer and !global.choice
		global.player.endTurn()
	else if global.choice {
		create_text({
			text: "Please choose a Card!",
			font: fDamageNumber,
			color: c_yellow,
			spd: {x: 0, y: -1},
			x: room_width/2, y: room_height/4,
			lifetime: 40,
			fadeout_time: 20
		})
	}
	else {
		create_text({
			text: "It's not your turn!",
			font: fDamageNumber,
			color: c_yellow,
			spd: {x: 0, y: -1},
			x: room_width/2, y: room_height/2,
			lifetime: 40,
			fadeout_time: 20
		})
	}
}