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
	var filename = "save1.game"
	
	
	// not working yet
	return -1
	
	var map = ds_map_create()
	#region //Full game save
	// [General]
	//map[? "area"] = global.area_name
	//map[? "level"] = global.battles
	//map[? "seed"] = random_get_seed()
	
	//// [Enemies]
	//var enemy_list = ds_list_create()
	//with(oEnemy) {
	//	var my_map = ds_map_create()
		
	//	my_map[? "object"] = object_get_name(object_index)
	//	my_map[? "x"] = x
	//	my_map[? "y"] = y
	//	my_map[? "max_hp"] = max_hp
	//	my_map[? "hp"] = hp
	//	my_map[? "pattern_pos"] = pattern_pos
	//	//ds_map_add_list(my_map, "pattern",		ds_list_from_Array(pattern))
	//	//ds_map_add_list(my_map, "next_pattern", ds_list_from_Array(next_pattern))
	//	//ds_map_add_list(my_map, "effects", ds_list_from_Array(effects))
		
	//	ds_list_add(enemy_list, my_map)
	//	ds_list_mark_as_map(enemy_list, ds_list_size(enemy_list)-1)
	//}
	
	//ds_map_add_list(map, "enemies", enemy_list)
	
	#endregion
	#region Simple save
	
	// [General]
	map[? "area"] = global.area_name
	map[? "level"] = global.battles
	map[? "seed"] = random_get_seed()
	
	// [Player]
	//map[? "deck"] = global.player.deck
	deck = new Array()
	global.player.deck.forEach(function(card) {
		deck.append(card.name)
	})
	
	//map[? "deck"] = deck.toString()
	map[? "deck"] = ds_list_from_Array(deck)
	
	#endregion
	
	//ds_map_secure_save(map, filename)
	var json = json_encode(map)
	show_message(json)
	
	
	var file = file_text_open_write(filename)
	file_text_write_string(file, json)
	file_text_writeln(file)
	
	file_text_close(file)
	
	ds_map_destroy(map)
}

function load_game() {
	// because of the stupid way rooms are loaded
	var filename = "save1.game"
	
	//if !file_exists(filename)
		return -1
	
	//var map = ds_map_secure_load(filename)
	var file = file_text_open_read(filename)
	
	var json = ""
	do {
		var str = file_text_read_string(file)
		file_text_readln(file)
		
		json += str
	} until(str == "")
	
	file_text_close(file)
	
	
	show_message(json)
	
	var map = json_decode(json)
	
	#region //Full game save
	
	// [General]
	//global.area_name = map[? "area"]
	//global.battles = map[? "level"]
	//random_set_seed(map[? "seed"])
	
	
	//// [Enemies]
	//with(oEnemy) {
	//	instance_destroy()
	//}
	
	//var enemy_list = ds_list_to_Array(map[? "enemies"])
	//enemy_list.forEach(function(enemy_map) {
	//	var _x = enemy_map[? "x"]
	//	var _y = enemy_map[? "y"]
	//	var obj = enemy_map[? "object"] // this is object name
	//	obj = asset_get_index(obj)
		
	//	var inst = instance_create_layer(_x, _y, "Enemies", obj)
		
	//	with(inst) {
	//		hp = enemy_map[? "hp"]
	//		max_hp = enemy_map[? "max_hp"]
	//		//pattern = enemy_map[? "pattern"]
	//		pattern_pos = enemy_map[? "pattern_pos"]
	//	}
	//})
	
	#endregion
	#region Simple save
	
	// [General]
	global.area_name = map[? "area"]
	global.battles = map[? "level"]
	random_set_seed(map[? "seed"])
	
	// [Player]
	global.player.deck = map[? "deck"]
	
	#endregion
}