/// @desc

// Inherit the parent event
event_inherited();

onClick = function() {
	//global.fetch_request = http_get(global.fetch_url)
	//create_text({
	//	text: "Request sent.",
	//	x: room_width/2, y: room_height/2,
	//	spd: {x: 0, y: -1},
	//	font: fPopup
	//})
	create_text({
		text: "Sorry, not available yet.",
		x: room_width/2, y: room_height/2,
		spd: {x: 0, y: -1},
		font: fPopup
	})
}