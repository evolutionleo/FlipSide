function startTransition(transition, foo) {	
	if global.transition
		return -1
	
	global.transition = true
	
	//timeline_index = timeline
	//timeline_speed = 1
	//timeline_position = 0
	//timeline_running = true
	
	global.transition_func = foo
	global.peak_time = 0
	
	transition()
	
	setTimeout(oTransition, TransitionEnd, global.peak_time)
}


function TransitionSlideIn() {
	live_name = "TransitionSlideIn"
	if live_call()
		return live_result
	
	
	// sqares = new Array()
	sqares = array_to_Array([])

	global.transition_time = 30
	global.go_back_time = 75
	global.return_time = 20

	for(var _y = 16; _y <= room_height + 16; _y += 32) {
		for(var _x = 16; _x <= room_width + 16; _x += 32) {
			var inst = instance_create_layer(_x, _y, "Effects", oBlackTransitionSquare)
			with(inst) {
				//inst.time_offset = (_x + _y) div 32
				inst.time_offset = (_x) div 32
				angle_spd = 360/global.transition_time
				scale_spd = 1/global.transition_time
		
				time_offset2 = time_offset + global.go_back_time
			}
			
			sqares.add(inst)
		}
	}
	
	// the last square is fully opened
	//global.peak_time = (room_width + room_height) div 32 + global.transition_time
	global.peak_time = (room_width) div 32 + global.transition_time
}


function TransitionSlideOut() {
	live_name = "TransitionSlideOut"
	if live_call()
		return live_result
	
	
	// sqares = new Array()
	sqares = array_to_Array([])

	global.transition_time = 30
	global.go_back_time = 75
	global.return_time = 20

	for(var _y = 16; _y <= room_height + 16; _y += 32) {
		for(var _x = 16; _x <= room_width + 16; _x += 32) {
			var inst = instance_create_layer(_x, _y, "Effects", oBlackTransitionSquare)
			with(inst) {
				//inst.time_offset = ((room_width + room_height) - (_x + _y)) div 32
				inst.time_offset = (room_width - _x) div 32
				angle_spd = 360/global.transition_time
				scale_spd = 1/global.transition_time
		
				time_offset2 = time_offset + global.go_back_time
			}
			
			sqares.add(inst)
		}
	}
	
	// the last square is fully opened
	//global.peak_time = (room_width + room_height) div 32 + global.transition_time
	global.peak_time = (room_width) div 32 + global.transition_time
}


function TransitionIn() {
	live_name = "TransitionIn"
	if live_call()
		return live_result
	
	//sqares = new Array()
	sqares = array_to_Array([])
	
	global.transition_time = 15
	global.go_back_time = 75
	global.return_time = 20

	for(var _y = 16; _y <= room_height + 16; _y += 32) {
		for(var _x = 16; _x <= room_width + 16; _x += 32) {
			var inst = instance_create_layer(_x, _y, "Effects", oBlackTransitionSquare)
			var xx = abs(_x - room_width/2)
			var yy = abs(_y - room_height/2)
			with(inst) {
				time_offset = sqrt(sqr(xx) + sqr(yy)) div 32
				angle_spd = 360/global.transition_time
				scale_spd = 1/global.transition_time
				
				time_offset2 = time_offset + global.go_back_time
			}
			
			sqares.add(inst)
		}
	}
	
	global.peak_time = sqrt(sqr(room_width/2) + sqr(room_height/2)) div 32 + global.transition_time
}

function TransitionOut() {
	live_name = "TransitionOut"
	if live_call()
		return live_result
	
	//sqares = new Array()
	sqares = array_to_Array([])
	
	
	global.transition_time = 15
	global.go_back_time = 75
	global.return_time = 20
	
	for(var _y = 16; _y <= room_height + 16; _y += 32) {
		for(var _x = 16; _x <= room_width + 16; _x += 32) {
			var inst = instance_create_layer(_x, _y, "Effects", oBlackTransitionSquare)
			//var xx = room_width/2 - abs(_x - room_width/2)
			//var yy = room_height/2 - abs(_y - room_height/2)
			var xx = _x
			var yy = _y
			with(inst) {
				time_offset = sqrt(sqr(xx) + sqr(yy)) div 32 * 2
				angle_spd = 360/global.transition_time
				scale_spd = 1/global.transition_time
		
				time_offset2 = time_offset + global.go_back_time
			}
			
			sqares.add(inst)
		}
	}
	
	//global.peak_time = sqrt(sqr(room_width/2) + sqr(room_height/2)) div 32 * 2 + global.transition_time
	global.peak_time = sqrt(sqr(room_width) + sqr(room_height)) div 32 * 2 + global.transition_time
}

function TransitionEnd() {
	global.transition_func()

	global.transition = false
}