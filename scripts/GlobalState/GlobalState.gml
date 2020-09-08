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
	
	// instance
	var card = instance_create_layer(_x, _y, "Choice", oCard)
	card.index = global.choices.size - 1
	card.state = CARD_STATE.CHOICE
	
	// card.my_card is defined automatically
	// from card.index and card.state
}

function cardChoiceExists(name) {
	// Not forEach() to avoid using "global" variables
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
	layer_set_visible(layer_get_id("ChoiceBackground"), true)
	global.choices = new Array()
	repeat(3)
	{
		// Don't add repeating cards
		do {
			var card = randomCard({})
		}
		until(!cardChoiceExists(card.name)) // until found a unique card
		
		addCardChoice(card)
	}
	
	
	//// wait until the card instances assign their `my_card` variables
	//setTimeout(noone, function() {
	save_game()
	//}, 1)
}

// like createCardChoice() but not randomized
function createDefinedCardChoice(cards) {
	global.choice = true
	layer_set_visible(layer_get_id("Choice"), true)
	layer_set_visible(layer_get_id("ChoiceBackground"), true)
	global.choices = new Array()
	cards.forEach(function(card) {
		addCardChoice(card)
	})
}

// start the transition
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

// the actual state change
function endCardChoice2() {
	global.choice = false
	layer_set_visible(layer_get_id("Choice"), false)
	layer_set_visible(layer_get_id("ChoiceBackground"), false)
	
	startBattle()
}

function addCreditCards() {
	//live_name = "addCreditCard"
	//if live_call() return live_result
	
	//trace("executing...")
	
	creditCards = new Array()
	cardNames = variable_struct_get_names(global.Cards)
	
	trace(cardNames)
	
	//var len = array_length(cardNames)
	var len = 8
	var _w = 4
	var _h = 2
	
	var startx = 160 starty = 160
	var margin_x = 80, margin_y = 40
	
	
	for(var _y = 0; _y < _h; _y++)
	{
		for(var _x = 0; _x < _w; _x++)
		{
			//trace("Iterating...")
			
			var card_idx = (_y * _w) + _x
			if card_idx >= len {
				break
			}
			
			var card_name = cardNames[card_idx]
			
			var xx = startx + _x * margin_x// + sprite_width  )
			var yy = starty + _y * margin_y// + sprite_height )
			
			// the credit card
			var card = instance_create_layer(xx, yy, "CreditCards", oCard)
			card.state = CARD_STATE.CREDITS
			//card.artist = "Johnatan Blow"
			card.my_card = new Card(card_name)
			card.draggable = false
			
			
			card.x += card.sprite_width  * _x * 2
			card.y += card.sprite_height * _y * 2
			
			creditCards.add(card)
			
			
			//trace("added credit card id#%", card.id)
		}
	}
}

function startBattle() {
	global.player.deck.shuffle()
	global.player.mana = 3
	global.player.max_mana = 3
	global.player.hp = global.player.max_hp
	//global.player.draw(3) - replaced with .startTurn()

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
	
	// Draw here
	global.player.startTurn()
	#endregion
	#region Enemies
	
	spawn = function() {
		#region Assemble the enemies
		
		// Make a set of matching enemies
		set = new Array()
		
		max_diff = (global.battles + 1) * 2 // difficulty not difference
		cur_diff = 0
		
		enemy_names = array_to_Array(variable_struct_get_names(enemy_difficulties))
		
		while(true)
		{
			if enemy_names.empty() // if no fitting enemies - leave
				break
			
			var idx = irandom(enemy_names.size-1)   // not getRandom() b/c we need index
			cur_enemy = enemy_names.get(idx)		// this is a string
			enemy_weight = variable_struct_get(enemy_difficulties, cur_enemy)
			
			if (cur_diff + enemy_weight > max_diff) { // found too hard enemy
				enemy_names.remove(idx)
				continue
			}
			else {
				var enemy_id = asset_get_index(cur_enemy)
				set.append(enemy_id)
				cur_diff += enemy_weight
				
				trace("Appending %", cur_enemy)
				trace("Current set difficulty: %/%", cur_diff, max_diff)
				
				if set.number(enemy_id) >= 2 {
					enemy_names.remove(idx)
				}
			}
			
			if cur_diff == max_diff {
				break
			}
		}
		
		#endregion
		#region Actual spawn
		
		// they're random anyway
		
		// Strongest first
		set.sort(function(a, b) {
			var val_a = variable_struct_get(enemy_difficulties, object_get_name(a))
			var val_b = variable_struct_get(enemy_difficulties, object_get_name(b))
			return val_a > val_b
		})
		
		// Cut the weakest
		if set.size - 1 < instance_number(oEnemyPos) {
			set.resize(instance_number(oEnemyPos)-1)
		}
		// Shuffle again
		set.shuffle()
		
		// Actual spawning
		set.forEach(function(enemy, i) {
			var pos = instance_find(oEnemyPos, i)
			if pos
				instance_create_layer(pos.x, pos.y, "Enemies", enemy)
			//trace(enemy)
		})
		//trace(set)
		
		#endregion
	}
	
	#region //Old strict code
	
	//switch(global.battles) {
	//	case 1:
	//		set = [oSmallSlime]
	//	break
	//	case 2:
	//		set = [oSlime]
	//	break
	//	case 3:
	//		set = [oSlime, oSlime, oSmallSlime]
	//		//set = [oGoblin]
	//	break
	//	case 4:
	//		set = [oBigSlime, oSlime, oSlime]
	//		//set = [oGoblin, oGoblin]
	//	break
	//	case 5:
	//		set = [oPinkSlime]
	//		//set = [oBat, oGoblin]
	//	break
	//	case 6:
	//		set = [oPinkSlime, oBigSlime]
	//		//set = [oBat]
	//	break
	//	case 7:
	//		set = [oBlueSlime]
	//		//set = [oBat, oBat]
	//	break
	//	case 8:
	//		set = [oPinkSlime, oBlueSlime]
	//	break
	//	case 9:
	//		set = [oPinkSlime, oBlueSlime, oBigSlime]
	//		break
	//	case 10:
	//		set = [oBlackSlime]
	//	break
	//	case 11:
	//		set = [oBlackSlime, oBigSlime]
	//	break
	//	case 12:
	//		set = [oBlackSlime, oBlackSlime]
	//	break
	//	case 13:
	//		set = [oBlackSlime, oBlackSlime, oBlackSlime]
	//	break
	//}
	
	#endregion
	#region New code /w blackjack and random generation
	
	// Because you cant just name a struct entry "oSmallSlime"
	enemy_difficulties = new (function() constructor
	{
		self.oSmallSlime = 1 // these are strings anyway
		self.oSlime= 2		// (expressed with object_get_name() rather than object_index)
		self.oBigSlime= 4
		self.oPinkSlime= 6
		self.oBlueSlime= 9 // the dangerous guy
		self.oBlackSlime= 10
		self.oGoblin= 14
		self.oBat= 16
	})()
	
	#endregion
	
	#region Endings
	
	if !variable_global_exists("lemmedie")
		global.lemmedie = false
	
	if global.battles > 13 and !global.lemmedie {
		room_goto(rGG)
	}
	//else if global.battles > 13 {
	//	room_goto(rTrue)
	//}
	#endregion
	else { // not ending yet
		spawn()
	}
	#endregion
	
	if global.battles != 0
		save_game()
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
	global.player.clearEffects()
	
	
	global.battles++
	
	
	// Buff player hp
	//var pers = global.player.hp / global.player.max_hp
	global.player.max_hp += 10
	//global.player.hp = floor(global.player.max_hp * pers)
	
	// Shuffle everything into the deck:
	// hand -> grave
	global.player.discardHand()
	// grave -> deck
	global.player.grave.forEach(function(card) {
		global.player.deck.append(card)
	})
	global.player.grave.clear()
	
	// flip all the cards on their A-Side
	global.player.deck.lambda(function(card) {
		card.side = 0
		return card
	})
	
	// kill all the enemies
	with(oEnemy) {
		die()
	}
	
	// Go to card selection
	startTransition(TransitionSlideIn, function() { createCardChoice() })
}

// Like endBattle() but without permanent global game state consequences
function semiEndBattle() {
	global.player.clearEffects()
	
	// Shuffle everything into the deck:
	// hand -> grave
	global.player.discardHand()
	// grave -> deck
	global.player.grave.forEach(function(card) {
		global.player.deck.append(card)
	})
	global.player.grave.clear()
	
	// flip all the cards on their A-Side
	global.player.deck.lambda(function(card) {
		card.side = 0
		return card
	})
	
	// kill all the enemies
	with(oEnemy) {
		die()
	}
}

function restartBattle() {
	semiEndBattle()
	startBattle()
}