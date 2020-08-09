/// @desc

//if live_call() return live_result


var _id = async_load[? "id"]
var status = async_load[? "status"]

//show_debug_message(global.fetch_request)

if _id == global.fetch_request
{
	if status == 0
	{
		//show_message("Received cards!")
		
		var json = async_load[? "result"]
		//show_message(json)
		var map = json_decode(json)
		if is_undefined(map) { // For some reason cannot parse JSON
			show_message(json)
			exit
		}
		if is_string(map[? "default"]) { // Hand-written server error in the map
			show_message(map[? "default"])
			exit
		}
		
		var list = map[? "default"]
		
		for(var i = 0; i < ds_list_size(list); ++i)
		{
			var card_map = list[| i]
			
			
			var spr = card_map[? "spr"]
			if (!file_exists(path+spr))
			{
				var copy_map = ds_map_create()
				ds_map_copy(copy_map, card_map)
				
				var req = http_get_file(global.fetch_url+"/"+spr, path+spr)
				ds_map_add_map(global.png_requests, req, copy_map)
			}
			else {
				card_load(card_map)
			}
			
			
			var fname = path+card_map[? "filename"]
			var file = file_text_open_write(fname)
			
			var str = json_encode(card_map)
			str = json_optimize(str)
			file_text_write_string(file, str)
			file_text_writeln(file)
			
			trace("Wrote card \""+card_map[? "name"]+"\" to "+fname)
			
			file_text_close(file)
			
			ds_map_destroy(card_map)
		}
		
		ds_map_destroy(map) // Should also destroy everything nested
		
		var text = ("Loaded new files into AppData directory.\nNote: Files in AppData always override the included files")
		show_message_async(text)
	}
}
else if (ds_map_exists(global.png_requests, _id)) // Received an image for a card
{
	show_message("Received .png!")
	if status == 0 {
		var card = global.png_requests[? _id]
		card_load(card)
	
		// memory leaks = bad
		ds_map_destroy(card)
		ds_map_delete(global.png_requests, _id)
	}
}