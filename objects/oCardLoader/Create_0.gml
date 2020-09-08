/// @desc

function card_load(map)
{
	var new_card = {}
	
	#region Set all variables from map to the card
	
	for(var k = ds_map_find_first(map); !is_undefined(k); k = ds_map_find_next(map, k)) {
		variable_struct_set(new_card, k, map[? k])
	}
	#endregion
	#region Rarity
	
	if is_undefined(new_card.rarity)
		new_card.rarity = RARITY.COMMON
	else if is_string(new_card.rarity)
	{
		switch(string_lower(new_card.rarity))
		{
			case "common":
				new_card.rarity = RARITY.COMMON
				break
			case "rare":
				new_card.rarity = RARITY.RARE
				break
			case "veryrare":
			case "very rare":
				new_card.rarity = RARITY.VERYRARE
				break
			case "legendary":
				new_card.rarity = RARITY.LEGENDARY
				break
			case "special":
				new_card.rarity = RARITY.SPECIAL
				break
			case "token":
				new_card.rarity = RARITY.TOKEN
				break
			default:
				trace("WARNING! UNKNOWN RARITY FOUND IN CARD NAME "+new_card.name)
				new_card.rarity = RARITY.COMMON
				break
		}
	}
	
	#endregion
	#region Functions/effects
	
	// We can't just put functions into JSON,
	// so we have to execute GMLive snippets instead
	
	
	new_card.effect_str = new_card.effect
	new_card.side_effect_str = new_card.side_effect
	
	new_card.effect_snip = live_snippet_create(new_card.effect_str)
	new_card.side_effect_snip = live_snippet_create(new_card.side_effect_str)
	
	var func = function(target) {
		self.target = target
		live_snippet_call(effect_snip)
	}
	var func2 = function(target) {
		self.target = target
		live_snippet_call(side_effect_snip)
	}
	
	new_card.effect = method(new_card, func)
	new_card.side_effect = method(new_card, func2)
	
	#endregion
	#region Color
	
	// Colors are RGB strings
	
	var r1 = string_copy(new_card.color, 1, 2)
	var g1 = string_copy(new_card.color, 3, 2)
	var b1 = string_copy(new_card.color, 5, 2)
	
	var r2 = string_copy(new_card.side_color, 1, 2)
	var g2 = string_copy(new_card.side_color, 3, 2)
	var b2 = string_copy(new_card.side_color, 5, 2)
	
	// Translate them to BGR
	
	new_card.color = hex(b1 + g1 + r1)
	new_card.side_color = hex(b2 + g2 + r2)
	
	#endregion
	#region Set sprite
	
	// Sprites are also stored as strings
	//new_card.spr = asset_get_index(new_card.spr)
	
	// Load a sprite from the file!
	// omg this is so exciting!!!
	var spr_file = path + new_card.spr
	var spr = sprite_add(spr_file, 2, false, false, 0, 0)
	sprite_set_offset(spr, sprite_get_width(spr)/2, sprite_get_height(spr)/2)
	new_card.spr = spr
	
	// Finally, add the card into the global library
	variable_struct_set(global.Cards, new_card.name, new_card)
	
	#endregion
}
#region Load from the local files

// Not making this one local 
// so it can be accessed from the function
path = "Cards/"

var fname = file_find_first(path+"*.card", 0)

// Do while still finding new files
do {
	// Open for reading
	var file = file_text_open_read(path+fname)
	var str = ""
	
	// Read all lines
	do {
		var line = file_text_read_string(file)
		file_text_readln(file)
		str += line
	} until(line == "")
	
	// Decode the string
	var map = json_decode(str)
	
	
	// The actual work
	card_load(map)
	
	
	// No memory leaks!
	ds_map_destroy(map)
	
	// Close the file
	file_text_close(file)
	
	// Go to the next card
	fname = file_find_next()
	
// Stop after we went through all files
} until(fname == "")

//show_message(global.Cards)

#endregion

global.fetch_request = -1
//global.fetch_url = "http://127.0.0.1:3001/fetch_cards"
global.fetch_url = "http://62.113.112.109:3001/fetch_cards"

global.png_requests = ds_map_create()