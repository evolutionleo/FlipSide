_dependencies = [
	CardsLib()
]

function randomCard(props) { // For now, props are ignored
	#region Rarity enum
	
	enum RARITY {
		COMMON,
		RARE,
		VERYRARE,
		LEGENDARY
	}
	#endregion
	
	if is_undefined(props)
		props = {}
	
	var names = variable_struct_get_names(global.Cards)
	names = array_to_Array(names)
	
	costs = new Array()
	
	_pool = 0
	
	names.forEach(function(name) {
		var cd = variable_struct_get(global.Cards, name)
		switch(cd.rarity) {
			case RARITY.COMMON:
				costs.append(1)
				break
			case RARITY.RARE:
				costs.append(.5)  //2 times rarer than common
				break
			case RARITY.VERYRARE:
				costs.append(.15) //~6 times rarer than common
				break
			case RARITY.LEGENDARY:
				costs.append(.05) //20 times rarer than common
				break
			default:
				trace("WARNING! UNKNOWN RARITY IN CARD RANDOMIZATION!")
				costs.append(1)
				break
		}
	})
	
	_pool = costs.summ()
	_rand = random(_pool)
	_iterator = 0
	
	result = undefined
	
	names.forEach(function(name, idx) {
		var cost = costs.get(idx)
		if  (_rand > _iterator)	and
			(_rand < _iterator + cost)
		{
			result = name
			return 1 // Break out of forEach
		}
		
		_iterator += cost
	})
	
	return new Card(result)
}


function Card(type) constructor {
	self.type = type
	
	self.struct = variable_struct_get(global.Cards, type)

	var names = variable_struct_get_names(self.struct)
	var len = array_length(names)
	
	for(var i = 0; i < len; i++) {
		var val = variable_struct_get(struct, names[i])
		variable_instance_set(self, names[i], val)
	}
	
	//show_debug_message(self.name)
	
	parse = function(str, side) {
		#region Key Colors enum
		enum KEY_COLORS {
			DAMAGE = c_red,
			HEAL = c_lime,
			DRAW = c_yellow,
			MANA = c_aqua
		}
		#endregion
		
		var pos0 = 1
		
		while string_pos_ext("[", str, pos0)
		{
			var pos1 = string_pos_ext("[", str, pos0)+1
			var pos2 = string_pos_ext("]", str, pos1)
			
			//if !pos1 or !pos2
			//	break
			
			var len = pos2-pos1
			var contents = string_copy(str, pos1, len)
			var old_contents = contents
			
			var tag = ""
			var pos = 1
			
			while(pos <= len) { // Relative position
				var ch = string_char_at(contents, pos)
				if ch == "=" {
					pos++
					break
				}
				
				tag += ch
				pos++
			}
			
			var value = ""
			while(pos <= len) { // Relative position
				var ch = string_char_at(contents, pos)
				
				value += ch
				pos++
			}
			
			var start_col = side ? side_color : color
			//var opening = "[c_red]"
			//var closing = "[/c][d#"+string(start_col)+"]"
			var opening = "", closing = ""
			
			//trace("Found tag: [%, %]", tag, value)
			
			
			switch(tag) {
				case "damage":
					//var col = merge_color(start_col, c_red, .5)
					//var col = c_red
					//var col = KEY_COLORS.DAMAGE
					//opening = "[d#"+string(col)+"]"
					
					var damage = real(value)
					damage = global.player.modifyDamage(damage)
					
					contents = string(damage)
					break
				case "heal":
					//var col = merge_color(start_col, c_lime, .5)
					//var col = c_lime
					//opening = "[d#"+string(col)+"]"
					
					var healing = real(value)
					healing = global.player.modifyHeal(healing)
					
					contents = string(healing)
					break
				case "hit":
					var damage = real(value)
					damage = global.player.modifyHit(damage)
					
					contents = string(damage)
					break
				case "draw":
					//var col = merge_color(start_col, c_blue, .5)
					//var col = c_blue
					//opening = "[d#"+string(col)+"]"
					
					var cards = real(value)
					cards = global.player.modifyDraw(cards)
					
					contents = string(cards)
					break
				case "discard":
					
					var cards = real(value)
					cards = global.player.modifyDiscard(cards)
					
					contents = string(cards)
					break
				case "strength":
					
					contents = value
					break
				case "weak":
					
					contents = value
					break
				default: // default scribble tags
					opening = "["
					closing = "]"
					break
			}
			
			contents = opening+contents+closing
			str = string_replace(str, "["+old_contents+"]", contents)
			
			var diff = string_length("["+old_contents+"]") - string_length(contents)
			
			pos0 = pos2 - diff + 1 // +1 to ignore "]"
		}
		
		return str
	}
	
	play = function(target) { // this should only be called from global.player
		if cost <= global.player.mana
		{
			global.player.mana -= cost
			// Used global to bypass the scope
			global.exile = false
			
			if side
				self.side_effect(target)
			else
				self.effect(target)
			
			//show_message(global.exile)
			
			if global.exile {
				trace("EXILED!")
				// returns to global.player
				return "Exile"
			}
			else {
				// returns to global.player
				return "Success"
			}
		}
		else
		{
			show_message(str_format("%/%", cost, global.player.mana))
			return "Cost Error"
		}
	}
}