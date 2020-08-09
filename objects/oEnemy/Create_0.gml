/// @desc

#macro Idle 1
#macro Attack 2
#macro Death 3
#macro Recovery 4

enum INTENTIONS {
	ATTACK = 0,
	HEAL = 1
}


friendly = false

#region Intentions + move patterns

function Intention(type, value) constructor {
	if is_undefined(value) {
		switch(type) {
			case INTENTIONS.ATTACK:
				value = atk
				break
			case INTENTIONS.HEAL:
				value = regen
				break
		}
	}
	
	self.type = type
	self.value = value
}

pattern = [INTENTIONS.ATTACK]
pattern_pos = 0
pattern_loop = true
pattern_random = false
pattern_custom = false // use custom function
pattern_next = pattern // 

intention = undefined


// Convert to Intention data type
pattern = array_to_Array(pattern)
pattern.lambda(function(move) {
	if is_array(move) {
		return new Intention(move[0], move[1])
	}
	else {
		return new Intention(move)
	}
})
pattern = Array_to_array(pattern)


getIntention = function() {
	return pattern[pattern_pos]
}

getRandomIntention = function() {
	var len = array_length(pattern)
	pattern_pos = irandom(len-1)
	
	return getIntention()
}

getNextIntention = function() {
	pattern_pos++
	if pattern_pos >= len
	{
		if !array_equals(pattern, pattern_next) {
			pattern = pattern_next
			pattern_pos = 0
		}
		else if pattern_loop
			pattern_pos = 0 // Go back to first move
		else {
			pattern_pos = len-1 // Just repeat the last move
		}
	}
	
	return getIntention()
}


// Override this to make actual AI with decisions
getCustomIntention = function() {
	return intention
}

// Changes the intention
nextIntention = function() {
	
	if pattern_random {
		intention = getRandomIntention()
	}
	else if pattern_custom {
		intention = getCustomIntention()
	}
	else {
		intention = getNextIntention()
	}
}

attack = function() {
	var opposite_team = new Array()
	
	if !friendly {
		opposite_team.add(global.player)
		trace("Slime id#% is hostile!", id)
	}
	
	with(oEnemy) {
		if friendly != other.friendly
			opposite_team.add(id)
	}
	
	
	var target = opposite_team.getRandom()
	
	if !is_undefined(target) {
		deal(target, atk)
		trace("Slime attacked!")
	}
	else {
		trace("No one to attack!")
	}
}

action = function() {
	var value = intention.value
	
	switch(intention.type) {
		case INTENTIONS.ATTACK:
			attack(value)
			break
		case INTENTIONS.HEAL:
			heal(value)
			break
	}
}

#endregion
#region Status Effects

effects = new Array()

clearEffects = function() {
	effects.clear()
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
#endregion
#region Modify damage/heal/hit

modifyDamage = function(dmg) {
	if getEffect(EFFECTS.WEAK) {
		dmg = floor(dmg/2)
	}
	if global.player.getEffect(EFFECTS.SAFE) {
		dmg = floor(dmg/2)
	}
	
	
	if dmg < 0
		dmg = 0
	return dmg
}

modifyHeal = function(healing) {
	
	
	if healing < 0
		healing = 0
	return healing
}

modifyHit = function(dmg) {
	
	return dmg
}

#endregion
#region Stats

hp = 100
max_hp = 100

atk = 0
regen = 0

flash_alpha = 0
flash_color = c_red

#endregion
#region Turn-based stuff

endTurn = function() {
	action()
	nextIntention()
	passTurn()
}

startTurn = function() {
	endTurn()
	processEffects()
}


registerTurner(id)
nextIntention()

#endregion
#region Deal with health

onHit = function() { }
onDeath = function() { }

die = function() {
	onDeath()
	instance_destroy()
}

handleHealth = function() {
	hp = clamp(hp, 0, max_hp)
	
	if hp == 0
		die()
}

deal = function(target, damage) {
	damage = modifyDamage(damage)
	
	target.hit(damage, id)
}

hit = function(damage, dealer) {
	hp -= damage
	onHit(damage)
	
	handleHealth()
	
	create_text({x: x, y: bbox_top - 16 * global.turn_id, text: "-"+string(damage), color: c_red, font: fDamageNumber, spd: {x: 0, y: -1}, lifetime: 60, fade_offset: 40})
	
	flash_alpha = 1.0
}

heal = function(healing) {
	healing = modifyHeal(healing)
	
	hp += healing
	handleHealth()
	
	create_text({x: x, y: y-8*image_yscale, text: "+"+string(healing), color: c_lime, font: fDamageNumber, spd: {x: 0, y: -1}, lifetime: 60, fade_offset: 40})
}

#endregion

switchSide = function(_friendly) {
	friendly = _friendly
	
	if friendly {
		// Select from the left places
		var idx = 0;
		found = false;
		
		while(!found) {
			var p = instance_find(oFriendlyPos, idx);
			if (!position_meeting(p.x, p.y, oEnemy)) {
				found = true;
			}
			idx++;
		}
		
		x = p.x
		y = p.y
	}
	else {
		// Select from the right places
		var idx = 0;
		found = false;
		
		while(!found) {
			var p = instance_find(oEnemyPos, idx);
			if (!position_meeting(p.x, p.y, oEnemy)) {
				found = true;
			}
			idx++;
		}
		
		x = p.x
		y = p.y
	}
}