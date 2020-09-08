function save_settings() {
	ini_open("settings.ini")
	// [Sound]
	ini_write_real("Sound", "master_volume", global.master_volume)
	ini_write_real("Sound", "music_volume", global.music_volume)
	ini_write_real("Sound", "effects_volume", global.sound_volume)
	// [Display]
	ini_write_real("Display", "fullscreen", window_get_fullscreen())
	
	ini_close()
}

function load_settings() {
	ini_open("settings.ini")
	// [Sound]
	global.master_volume = ini_read_real("Sound", "master_volume", 100)
	global.music_volume = ini_read_real("Sound", "music_volume", 100)
	global.sound_volume = ini_read_real("Sound", "effects_volume", 100)
	// [Display]
	var fullscreen = ini_read_real("Display", "fullscreen", false)
	window_set_fullscreen(fullscreen)
	
	ini_close()
}

function save_game() {
	//live_name = "save_game"
	
	//if live_call()
	//	return live_result
	
	var filename = "save1.game"
	
	var map = ds_map_create()
	
	#region Full game save
	
	// [General]
	map[? "status"] = global.choice ? "choice" : "play"
	
	
	map[? "area"] = global.area_name
	map[? "level"] = global.battles
	//map[? "seed"] = random_get_seed()
	
	// [Player]
	_deck = new Array()
	
	// Put the deck into the Array
	global.player.deck.forEach(function(card) {
		_deck.append(card.name)
	})
	// ...and put the grave into the Array
	global.player.grave.forEach(function(card) {
		_deck.append(card.name)
	})
	// ...and put the hand into the Array
	global.player.hand.forEach(function(card) {
		_deck.append(card.name)
	})
	
	// Save the deck
	ds_map_add_list(map, "deck", ds_list_from_Array(_deck))
	
	
	if global.choice {
		// [Choice]
		var choice = new Array()
		with(oCard) {
			if state == CARD_STATE.CHOICE || state == CARD_STATE.CHOICE_END {
				//choice.pushBack(my_card.name)
				var card = global.choices.get(index)
				choice.pushBack(card.name)
			}
		}
		ds_map_add_list(map, "choice", ds_list_from_Array(choice))
	}
	else {
		// [Enemies]
		var enemy_list = ds_list_create()
		with(oEnemy) {
			var my_map = ds_map_create()
			
			// we only save the starting state
			my_map[? "object"] = object_get_name(object_index)
			my_map[? "x"] = x
			my_map[? "y"] = y
			
			ds_list_add(enemy_list, my_map)
			ds_list_mark_as_map(enemy_list, ds_list_size(enemy_list)-1)
		}
		
		ds_map_add_list(map, "enemies", enemy_list)
	}
	
	#endregion
	
	//ds_map_secure_save(map, filename)
	var json = json_encode(map)
	json = json_optimize(json)
	//show_message(json)
	
	
	var file = file_text_open_write(filename)
	file_text_write_string(file, json)
	file_text_writeln(file)
	
	file_text_close(file)
	
	ds_map_destroy(map)
}

function load_game() {
	//live_name = "load_game"
	
	//if live_call()
	//	return live_result
	
	
	// because of the stupid way rooms are loaded
	var filename = "save1.game"
	
	if !file_exists(filename)
		return -1
	
	//var map = ds_map_secure_load(filename)
	var file = file_text_open_read(filename)
	
	
	var json = ""
	// read the whole file
	do {
		var str = file_text_read_string(file)
		file_text_readln(file)
		
		json += str
	} until(str == "")
	
	file_text_close(file)
	
	
	
	var map = json_decode(json)
	
	#region Full game save
	// [General]
	global.area_name = map[? "area"]
	global.battles = map[? "level"]
	//random_set_seed(map[? "seed"])
	
	// [Player]
	// get rid of old cards
	global.player.discardHand() // hand -> grave
	global.player.deck.clear()	// x deck x
	global.player.grave.clear() // x grave x
	// add new (loaded) cards to the deck
	var deck_names = ds_list_to_Array(map[? "deck"])
	deck_names.forEach(function(card_name) {
		var card = new Card(card_name)
		global.player.deck.add(card)
	})
	
	//// restart with new cards and stuff
	//restartBattle()
	
	trace("Loading state: %...", map[? "status"])
	trace("Loading deck: %", global.player.deck)
	
	switch(map[? "status"]) {
		case "choice":
			semiEndBattle()
			// don't start the next battle/draw cards
			
			// [Choice]
			var choices = ds_list_to_Array(map[? "choice"])
			choices.lambda(function(card_name) {
				return new Card(card_name)
			})
			
			createDefinedCardChoice(choices)
			
			break
		case "play":
			// [Enemies]
			semiEndBattle()
			startBattle() // draw the cards and stuff
			
			with(oEnemy) {
				die()
			}
			
			var enemy_list = ds_list_to_Array(map[? "enemies"])
			enemy_list.forEach(function(enemy_map) {
				var _x = enemy_map[? "x"]
				var _y = enemy_map[? "y"]
				var obj = enemy_map[? "object"] // this is object name
				obj = asset_get_index(obj)
		
				//var inst = 
				instance_create_layer(_x, _y, "Enemies", obj)
			})
			break
	}
	
	#endregion
	
	ds_map_destroy(map)
}