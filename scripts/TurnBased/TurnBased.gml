function passTurn() {
	global.turn++
	
	global.turn_id++
	
	if global.turn_id >= global.turners.size
	{
		global.turn_id = 0
	}
	
	global.turner = global.turners.get(global.turn_id)
	if global.turner == oPlayer
		global.full_turns++
	global.turner.startTurn()
}

function getTurner() {
	global.turner = global.turners.get(global.turn_id)
	return global.turner
}

function registerTurner(turner) {
	global.turners.append(turner)
	
	return 0
}

function unregisterTurner(turner) {
	var idx = global.turners.find(turner)
	global.turners.remove(idx)
	
	return 0
}