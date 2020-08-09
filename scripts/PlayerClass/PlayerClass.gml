_dependencies = [
	Require()
]

randomize()

//if live_call() return live_result

function Player() constructor {
	// unused anyway
	//Cards = require("cards")
	
	
	deck = new Array()
	hand = new Array()
	grave = new Array()
	exiled = new Array()
	
	effects = new Array()
	
	#region Workarouds
	
	last_played_pos = -1
	
	#endregion
	
	hp = 75
	max_hp = 75
	
	mana = 3
	max_mana = 3
	
	#region Status effects
	
	clearEffects = function() {
		effects.clear()
	}
	
	processEffects = function() {
		effects.lambda(function(eff) {
			switch(eff.pers) {
				case -1:
					eff.pow = 0
					break
				case 0:
					eff.pow--
					break
				case 1:
					// Do nothing
					break
			}
			
			
			return eff
		})
		
		effects = effects.filter(function(eff) {
			return eff.pow > 0
		})
	}
	
	applyEffect = function(eff, amount, pers) {
		if is_undefined(amount)
			amount = 1
		if is_undefined(pers)
			pers = 0
		
		// If found an instance of the effect - stack on it
		for(var i = 0; i < effects.size; ++i) {
			var eff_struct = effects.get(i)
			var effect = eff_struct.effect
		
			if effect == eff {
				eff_struct.pow += amount
				effects.set(i, eff_struct)
			
				return 0
			}
		}
	
		// otherwise create a new effect instance
		effects.append(new Effect(eff, amount, pers))
	}
	
	getEffect = function(eff) {
		// Loop through all effect instances
		for(var i = 0; i < effects.size; ++i) {
			var eff_struct = effects.get(i)
			var effect = eff_struct.effect
		
			// if the name is matching - return
			if effect == eff {
				var val = eff_struct.pow
				return val
			}
		}
		// else just return that the effect isn't applied
		return 0
	}
	
	setEffect = function(eff, value) {
		for(var i = 0; i < effects.size; ++i) {
			var eff_struct = effects.get(i)
			var effect = eff_struct.effect
			
			// if the name is matching - return
			if effect == eff {
				if value == 0 {
					effects.remove(i)
				}
				else {
					eff_struct.pow = value
					effects.set(i, eff_struct)
				}
				return 0
			}
		}
		// otherwise create a new effect instance
		if value != 0
			effects.append(new Effect(eff, value, pers))
		return 0
	}
	
	drawEffects = function(x, y) {
		var _x = x
		var _y = y
		for (var i = 0; i < effects.size; ++i)
		{
			var eff_struct = effects.get(i)
			var eff = eff_struct.effect
			var pow = eff_struct.pow
			
			var spr = sEffectIcon
			var img = eff
			var xs = ICON_WIDTH / sprite_get_width(spr)
			var ys = ICON_HEIGHT / sprite_get_height(spr)
			
			draw_sprite_ext(spr, img, _x, _y, xs, ys, 0, c_white, 1.0)
			draw_text(_x, _y+ICON_HEIGHT/2, string(pow))
			
			_x += ICON_WIDTH + ICON_OFFX
		}
	}
	
	clearEffects()
	
	#endregion
	#region Modify card text+effect
	
	modifyDamage = function(damage) {
		if getEffect(EFFECTS.STRENGTH) {
			damage = damage + getEffect(EFFECTS.STRENGTH)
		}
		if getEffect(EFFECTS.SAFE) {
			damage /= 2
			damage = ceil(damage)
		}
		if getEffect(EFFECTS.PREPARATION2) {
			damage *= 2
		}
		
		return damage
	}
	
	modifyHeal = function(healing) {
		
		if getEffect(EFFECTS.DOUBLE_HEALING) {
			healing *= 2
		}
		
		return healing
	}
	
	modifyDraw = function(cards) {
		if getEffect(EFFECTS.TIRED) {
			cards = 0
		}
		
		return cards
	}
	
	modifyDiscard = function(cards) {
		
		return cards
	}
	
	modifyCost = function(cost) {
		if getEffect(EFFECTS.PREPARATION) {
			cost -= 2
		}
		
		if cost < 0
			cost = 0
		
		return cost
	}
	
	modifyHit = function(damage) {
		if getEffect(EFFECTS.SAFE)
			damage = floor(damage/2)
		
		return damage
	}
	
	#endregion
	#region Dealing with health
	
	hit = function(damage, dealer) {
		damage = modifyHit(damage)
		
		if damage > 0
		{
			hp -= damage
			audio_play_sound(aPlayerHit, 40, false)
		
			if getEffect(EFFECTS.THORNS)
			{
				if !is_undefined(dealer)
				{
					dealer.hit(damage, self)
				}
			}
			
			#region Burst blood particles
		
			var xp, yp;
			xp = oPlayer.x;
			yp = oPlayer.y;
			part_emitter_region(global.ps, global.pe_Blood, xp-16, xp+16, yp-32, yp+32, ps_shape_rectangle, ps_distr_linear);
			part_emitter_burst(global.ps, global.pe_Blood, global.pt_Blood, 10);

			#endregion
			
			create_text({x: oPlayer.x, y: oPlayer.bbox_top - global.hit_num*16, text: "-"+string(damage), color: c_red, font: fDamageNumber, spd: {x: 0, y: -1}, lifetime: 60, fade_offset: 40})
			global.hit_num++
			
			handleHealth()
		}
		
		oPlayer.flash_color = c_red
		oPlayer.flash_alpha = 1.0
	}
	
	heal = function(amount) {
		
		amount = modifyHeal(amount)
		
		if getEffect(EFFECTS.DEADLY_HEALING)
		//if effects.get(8)
		{
			with(oEnemy)
			{
				other.deal(id, amount, true) // lifesteal = true, so we don't go infinite
				trace("Dealt damage to %",id)
			}
			amount = 0
		}
		
		
		hp += amount
		handleHealth()
		
		create_text({x: oPlayer.x, y: oPlayer.bbox_top, text: "+"+string(amount), color: c_lime, font: fDamageNumber, spd: {x: 0, y: -1}, lifetime: 60, fade_offset: 40})
		
		oPlayer.flash_color = c_lime
		oPlayer.flash_alpha = 1.0
	}
	
	// Used for damage modifiers
	deal = function(target, damage, lifesteal) {
		if is_undefined(lifesteal)
			lifesteal = false
		
		
		damage = modifyDamage(damage)
		
		target.hit(damage, self)
		
		if getEffect(EFFECTS.HEALING_DEATH) and !lifesteal
			heal(ceil(damage/2)) // there lifesteal becomes equal to true, so we don't go infinite
		
		if !instance_exists(target) or target.hp <= 0 {
			onKill()
		}
		
	}
	
	onKill = function() {
		//var healing = getEffect(EFFECTS.HEALING_DEATH)
		
		//if healing > 0 {
		//	heal(healing)
		//}
		
		// Glory kills became lifesteal instead
	}
	
	handleHealth = function() {
		hp = clamp(hp, 0, max_hp)
		
		if hp == 0 {
			die()
		}
	}
	
	die = function() {
		audio_play_sound(aPlayerDeath, 100, false)
		game_restart()
		//room_goto(rGameover)
	}
	
	#endregion
	#region Turns
	
	endTurn = function() {
		discardHand()
		passTurn()
	}
	
	startTurn = function() {
		global.hit_num = 0
		
		global.player.setEffect(EFFECTS.TIRED, false)
		
		if global.turn > 0 and !global.choice and instance_number(oEnemy) == 0
		{
			endBattle()
		}
		else
		{
			global.player.mana = global.player.max_mana
			global.player.draw(3)
		
			if global.player.getEffect(EFFECTS.BEST4LAST) {
				global.player.addMana(2)
				global.player.draw(1)
			}
			if global.player.getEffect(EFFECTS.REST) {
				global.player.draw(1)
			}
		}
		
		global.player.processEffects()
	}
	
	#endregion
	#region Card-related stuff
	
	discardHand = function() {
		while(!hand.empty())
		{
			discard(0)
		}
	}
	
	exile = function(pos) {
		// Basically discard() but with appending to exile pile instead of grave
		try {
			var card = hand.get(pos)
		}
		catch(e) { return e }
		
		exiled.append(card)
		hand.remove(pos)
		
		// Delete the visual representation
		var inst = global.card_inst.get(pos)
		
		with(inst) {
			state = CARD_STATE.EXILE
			targetx = EXILE_X
			targety = EXILE_Y
				
			if global.dragging == id {
				global.dragging = noone
			}
		}
		global.card_inst.remove(pos)
		
		
		// Move all the other card instances
		// So that they are bound to correct card indicies
		self.pos = pos
		global.card_inst.forEach(function(inst) {
			if inst.index > pos {
				inst.index--
			}
		})
		
		
		moveCards()
	}
	
	discard = function(pos) {
		try {
			var card = hand.get(pos)
		}
		catch(e) { return e }
		
		grave.append(card)
		hand.remove(pos)
		
		// Delete the visual representation
		var inst = global.card_inst.get(pos)
		
		with(inst) {
			state = CARD_STATE.DISCARD
			targetx = GRAVE_X
			targety = GRAVE_Y
			
			if global.dragging == id {
				global.dragging = noone
			}
		}
		global.card_inst.remove(pos)
		
		
		// Move all the other card instances
		// So that they are bound to correct card indicies
		self.pos = pos
		global.card_inst.forEach(function(inst) {
			if inst.index > pos {
				inst.index--
			}
		})
		
		
		moveCards()
		
		return card
	}
	
	discardRandom = function(num, except) {
		if is_undefined(num)
			num = 1
		if is_undefined(except)
			except = -1
		
		num = modifyDiscard(num)
		
		repeat(num) {
			if hand.empty() or except != -1 and hand.size < 2
				break
			do {
				var pos = irandom(hand.size-1)
			} until(pos != except)
			
			discard(pos)
			
			if pos < except
				except--
			if pos < last_played_pos
				last_played_pos--
		}
	}
	
	canPlay = function(card, target) {
		if modifyCost(card.cost) > mana {
			return false
		}
		
		return true
	}
	
	play = function(pos, target) { // pos_in_hand
		if hand.empty()
			return -1
		
		var card = hand.get(pos)
		
		
		if !is_undefined(card)
  		{
			oPlayer.sprite_index = sPlayerAttack
			var _reduced = false
			
			if getEffect(EFFECTS.PREPARATION) and card.cost > 0 {
				var _reduced = true
				trace("Reduced cost.")
			}
			
			// buffer the initial cost
			prev_cost = card.cost
			// modify the cost
			card.cost = modifyCost(card.cost)
			
			
			if canPlay(card, target)
			{
				last_played_pos = pos
				
				var result = card.play(target)
				
				card.cost = prev_cost
				
				// If discarded, last_played_pos will change
				pos = last_played_pos
				
				switch(result) {
					case "Success":
						discard(pos) // Also handles visual card instances
						break
					case "Exile":
						exile(pos)
						break
				}
			}
			else {
				if card.cost > mana
				{
					create_text({
						text: "Not enough mana!",
						font: fPopup,
						color: c_aqua,
						x: room_width/2, y: room_height/2,
						spd: {x: 0, y: -1},
						lifetime: 60,
						fade_offset: 40
					})
				}
				
				card.cost = prev_cost
				
				_reduced = false
			}
			
			
			if getEffect(EFFECTS.PREPARATION) and card.name != "Preparation" and _reduced
			{
				setEffect(EFFECTS.PREPARATION, false)
			}
			if getEffect(EFFECTS.PREPARATION2) and card.name != "Preparation"
			{
				setEffect(EFFECTS.PREPARATION2, false)
			}
		}
		
		if instance_number(oEnemy) == 0
			endBattle()
	}
	
	handleEmpty = function() {
		if deck.empty() {
			grave.forEach(function(grave_card) {
				deck.append(grave_card)
			})
			deck.shuffle()
			grave.clear()
		}
	}
	
	getTop = function() {
		if deck.empty()
			return undefined
		
		return deck.last()
	}
	
	// Gets a random card struct from the deck
	//getRandom = function() {
	//	if deck.empty()
	//		return undefined
		
	//	var idx = irandom(deck.size)
	//	return deck.get(idx)
	//}
	
	moveCards = function() {
		// Move all the cards
		
		_x = HANDX - ( (hand.size+1) * (CARD_WIDTH + CARD_OFFX) ) / 2
		_y = HANDY // Hand Y is quite handy :)
		
		//trace("(%; %)", CARD_WIDTH, CARD_OFFX)
			
		global.player.hand.forEach(function(card) {
			card.x = _x //+ CARD_WIDTH / 2
			card.y = _y //+ CARD_HEIGHT / 2
			card.startx = card.x
			card.starty = card.y
				
			//trace("(%; %)", card.x, card.y)
				
			_x += CARD_WIDTH + CARD_OFFX
			_y += CARD_OFFY
		})
	}
	
	// Draw from the deck
	draw = function(num) {
		if is_undefined(num)
			num = 1
		
		num = modifyDraw(num)
		
		repeat(num)
		{
			handleEmpty()
			if deck.empty()
				return -1
			
			var _card = deck.last()
			hand.append(_card)
			
			deck.pop()
			
			
			moveCards()
			
			// Create a visual representation of the drawn card
			
			
			var inst = instance_create_layer(DECK_X, DECK_Y, "Cards", oCard)
			inst.index = global.player.hand.size - 1
			global.card_inst.append(inst)
			
			
			
			//var inst = instance_create_layer(_x, _y, "Cards", oCard)
		}
	}
	
	#region Rendering Cards
	
	// Draw ON SCREEN
	//drawCard = function(card, x, y) {
	//	draw_sprite_ext(card.spr, 0, x, y, 4, 4, 0, c_white, 1.0)
	//	draw_text_transformed(x, y + CARD_HEIGHT / 4, card.text, 4, 4, 1.0)
	//}
	
	//drawHand = function(x, y) {
	//	_x = x
	//	_y = y
	//	offx = 0S
	//	offy = 0
		
	//	hand.forEach(function(card) {
	//		offx -= (sprite_get_width(card.spr) * 4 + 16) / 2
	//	})
		
	//	_x += offx
	//	_y += offy
		
	//	hand.forEach(function(card) {
	//		drawCard(card)
	//		_x += sprite_get_width(card.spr) * 4 + 16
	//	})
	//}
	
	drawDeck = function(x, y) {
		var xs = 4
		var ys = 4
		if variable_global_exists("deck_ease") {
			global.ease_channel = animcurve_get_channel(cvCardEaseIn2, "curve1")
			global.ease = animcurve_channel_evaluate(global.ease_channel, global.deck_ease)
			
			xs += global.ease
			ys += global.ease
		}
		
		draw_sprite_ext(sDeck, 0, x, y, global.deck_xs, global.deck_ys, 0, c_white, 1.0)
		
		draw_get()
		
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		draw_set_color(c_white)
		draw_set_font(fDeckSize)
		draw_text(x, y, string(deck.size))
		
		draw_reset()
	}
	
	drawGraveyard = function(x, y) {
		draw_sprite_ext(sGrave, 0, x, y, 2, 2, 0, c_white, 1.0)
		
		draw_get()
		
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		draw_set_color(c_ltgray)
		draw_set_font(fDeckSize)
		draw_text(x, y, string(grave.size))
		
		draw_reset()
	}
	
	#endregion
	#endregion
	#region Misc
	
	addCrystal = function(num) {
		if is_undefined(num) num = 1
		
		max_mana += num
		mana += num
		create_text({x: oPlayer.x, y: oPlayer.bbox_top - 16, text: "+"+string(num), color: c_blue, font: fDamageNumber, spd: {x: 0, y: -1}, lifetime: 60, fade_offset: 40})
	}
	
	addMana = function(num) {
		if is_undefined(num) num = 1
		mana += num
		
		create_text({x: oPlayer.x, y: oPlayer.bbox_top - 16, text: "+"+string(num), color: c_aqua, font: fDamageNumber, spd: {x: 0, y: -1}, lifetime: 60, fade_offset: 40})
	}
	
	destroyCrystal = function(num) {
		if is_undefined(num) num = 1
		
		max_mana -= num
		mana -= num
		
		create_text({x: oPlayer.x, y: oPlayer.bbox_top - 16, text: "-"+string(num), color: c_blue, font: fDamageNumber, spd: {x: 0, y: -1}, lifetime: 60, fade_offset: 40})
	}
	
	#endregion
}
