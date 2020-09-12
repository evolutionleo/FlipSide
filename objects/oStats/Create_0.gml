/// @desc

reset = function() {
	kills = 0
	killer = noone
	kill_list = new Array()
	dealt_damage = 0
	heal_amount = 0
	turns = 0
}

getStats = function() {
	return {
		kills		  :	kills,
		killer		  :	global.player.last_hit,
		kill_list	  :	kill_list,
		level_reached :	global.battles,
		turns		  :	turns,
		deck		  :	global.player.deck,
		deck_size	  : global.player.deck.size,
		dealt_damage  :	dealt_damage,
		heal_amount	  :	heal_amount
	}
}


reset()