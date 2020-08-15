#region Status effects

enum EFFECTS {
	THORNS = 1,
	STRENGTH = 2,
	SAFE = 3,
	BEST4LAST = 4,
	PREPARATION = 5,
	PREPARATION2 = 6,
	HEALING_DEATH = 7,
	DEADLY_HEALING = 8,
	TIRED = 9, // Can't draw cards
	REST = 10,
	WEAK = 11,
	DOUBLE_HEALING = 12,
	VULNERABLE = 13,
	
	
	__SIZE
}

function Effect(effect, pow, pers) constructor {
	// persistent can be either:
	//		1 (never wears off)
	//		0 (decreases by 1 each turn)
	//	   -1 (immediately wears off next turn)
	
	if is_undefined(pers)
		pers = 0
	
	self.effect = effect
	self.pow = pow
	self.pers = pers
}

#endregion


function addCardChoice(_card) {
	global.choices.append(_card)
	_x = CHOICE_X - (global.choices.size - 1) * (CARD_WIDTH + CARD_OFFX) / 2
	_y = CHOICE_Y
	
	global.choices.forEach(function(card) {
		card.x = _x
		card.y = _y

		_x += CARD_WIDTH + CARD_OFFX
	})
	
	var card = instance_create_layer(_x, _y, "Choice", oCard)
	card.index = global.choices.size - 1
	card.state = CARD_STATE.CHOICE
}

function cardChoiceExists(name) {
	// Not ForEach() to avoid using "global" variables
	for(var i = 0; i < global.choices.size; ++i)
	{
		var _card = global.choices.get(i)
		if _card.name == name
		{
			return true
		}
	}
	return false
}

function createCardChoice() {
	global.choice = true
	layer_set_visible(layer_get_id("Choice"), true)
	global.choices = new Array()
	repeat(3)
	{
		// Don't add repeating cards
		do {
			var card = randomCard({})
		}
		until(!cardChoiceExists(card.name))
		
		addCardChoice(card)
	}
}

function endCardChoice() {
	with(oCard)
	{
		if state == CARD_STATE.CHOICE {
			targetx = x
			targety = y
			state = CARD_STATE.CHOICE_END
			//instance_destroy()
		}
	}
	
	startTransition(TransitionSlideOut, function() { endCardChoice2() })
}

function endCardChoice2() {
	global.choice = false
	layer_set_visible(layer_get_id("Choice"), false)
	
	startBattle()
}

function startBattle() {
	global.player.deck.shuffle()
	//global.player.mana = 3
	global.player.mana = 3
	global.player.max_mana = 3
	global.player.hp = global.player.max_hp
	//global.player.draw(3) - replaced with .startTurn()
	
	global.battles++
	#region Turns
	
	// Absolute turn counter
	global.turn = 0
	// Tracks who's turn it is
	global.turn_id = 0
	// Used to display "Turn X"
	global.full_turns = 1
	global.turners = new Array()



	registerTurner(oPlayer)

	global.turner = global.turners.get(global.turn_id)
	
	global.player.startTurn()
	#endregion
	#region Enemies
	//global.enemies = new Array()
	
	spawn = function() {
		set.shuffle()
		set.forEach(function(enemy, i) {
			var pos = instance_find(oEnemyPos, i)
			instance_create_layer(pos.x, pos.y, "Enemies", enemy)
		})
	}
	
	switch(global.battles) {
		case 1:
			set = [oSmallSlime]
		break
		case 2:
			set = [oSlime]
		break
		case 3:
			//set = [oSlime, oSlime, oSmallSlime]
			set = [oGoblin]
		break
		case 4:
			//set = [oBigSlime, oSlime, oSlime]
			set = [oGoblin, oGoblin]
		break
		case 5:
			//set = [oPinkSlime]
			set = [oBat, oGoblin]
		break
		case 6:
			//set = [oPinkSlime, oBigSlime]
			set = [oBat]
		break
		case 7:
			//set = [oBlueSlime]
			set = [oBat, oBat]
		break
		case 8:
			set = [oPinkSlime, oBlueSlime]
		break
		case 9:
			set = [oPinkSlime, oBlueSlime, oBigSlime]
			break
		case 10:
			set = [oBlackSlime]
		break
		case 11:
			set = [oBlackSlime, oBigSlime]
		break
		case 12:
			set = [oBlackSlime, oBlackSlime]
		break
		case 13:
			set = [oBlackSlime, oBlackSlime, oBlackSlime]
		break
	}
	
	#region Ending
	
	if !variable_global_exists("lemmedie")
		global.lemmedie = false
	
	if global.battles > 13 and !global.lemmedie {
		room_goto(rGG)
	}
	//else if global.battles > 13 {
	//	room_goto(rTrue)
	//}
	#endregion
	else {
	
	set = array_to_Array(set)
	
	spawn()
	
	}
	#endregion
}

function enemiesRemain() {
	var counter = 0
	with(oEnemy) {
		if !friendly {
			counter++
		}
	}
	
	return counter
}

function endBattle() {
	global.player.discardHand()
	global.player.clearEffects()
	
	var pers = global.player.hp / global.player.max_hp
	global.player.max_hp += 10
	global.player.hp = floor(global.player.max_hp * pers)
	
	global.player.grave.forEach(function(card) {
		global.player.deck.append(card)
	})
	global.player.grave.clear()
	
	global.player.deck.lambda(function(card) {
		card.side = 0
		return card
	})
	
	
	with(oEnemy) {
		die()
	}
	
	startTransition(TransitionSlideIn, function() { createCardChoice() })
	trace("choice began = %", global.choice ? "true" : "false")
}