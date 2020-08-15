_dependencies = [
	ArrayClass()
]

function Chance() constructor {
	chances = new Array()
	choices = new Array()
	
	///@function	addChoice(choice, chance, *choice2)
	///@param		{any} choice
	///@param		{real} chance
	addChoice = function(choice, chance) {
		var i = 0;
		
		repeat(argument_count div 2) {
			choice = argument[i++]
			chance = argument[i++]
			
			choices.append(choice)
			chances.append(chance)
		}
	}
	
	///@function	add(choice, chance, *choice2)
	///@param		{any} choice
	///@param		{real} chance
	add = function(choice, chance) {
		var i = 0;
		
		repeat(argument_count div 2) {
			choice = argument[i++]
			chance = argument[i++]
			
			choices.append(choice)
			chances.append(chance)
		}
	}
	
	///@function	roll()
	roll = function() {
		// Basically select a random real number,
		_pool = chances.sum()
		_rand = random(_pool)
		_iterator = 0
	
		result = undefined
		
		if _pool == 0 {
			return result
		}
		
		// Then iterate over the choices and get the correct index
		choices.forEach(function(choice, idx) {
			var chance = chances.get(idx)
			// if the random number is in range -
			if  (_rand > _iterator)	and
				(_rand < _iterator + chance)
			{
				result = choice // - set the result and
				return 1 // break out of forEach
			}
			
			_iterator += chance
		})
		
		return result
	}
	
	///@example: 	
}