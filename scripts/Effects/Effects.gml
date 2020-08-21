_dependencies = [
	SetTimeout()
]

function inheritProps(_props) {
	_props = new Map(_props)
	_props.forEach(function(val, name) {
		props.set(name, val)
	})
	delete _props
}

function create_flash(_props) {
	props = new Map({color: c_white, alpha: 1.0, fadespd: .02})
	
	inheritProps(_props)
	
	props = props.content
	
	var flash = instance_create_layer(0, 0, "Effects", oFlash)
	flash.color = props.color
	flash.alpha = props.alpha
	flash.delta_alpha = props.fadespd
	
	return flash
}

function create_freeze(_props) {
	props = new Map({time: 100})
	inheritProps(_props)
	
	props = props.content
	
	
	static freeze_limit = 150
	global.freeze += props.time
	
	if global.freeze > freeze_limit {
		props.time -= global.freeze - freeze_limit
		global.freeze = freeze_limit
	}
	
	var target_time = current_time + props.time
	
	while (current_time < target_time) {}
}


global.freeze = 0

function create_sprite(_props) {
	props = new Map(
	{
		x: 0,
		y: 0,
		spr: sError,
		img: 0,
		img_spd: 1,
		spd: {x: 0, y: 0},
		alpha: 1.0,
		lifetime: 30,
		fade_offset: 0,
		xscale: 1,
		yscale: 1,
		rotation: 0,
		color: c_white,
		one_cycle: false,
		on_gui: false,
		stuck: noone
	})
	
	inheritProps(_props)
	
	props = props.content
	
	
	var inst = instance_create_layer(props.x, props.y, "Effects", oFloatingSprite)
	inst.sprite_index = props.spr
	inst.image_index = props.img
	inst.alpha = props.alpha
	inst.spd = props.spd
	inst.image_speed = props.img_spd
	inst.lifetime = props.lifetime
	inst.fade_offset = props.fade_offset
	inst.fade_speed = props.alpha/(props.lifetime-props.fade_offset)
	inst.rot = props.rotation
	inst.xs = props.xscale
	inst.ys = props.yscale
	inst.col = props.color
	inst.one_cycle = props.one_cycle
	inst.stuck = props.stuck
	inst.on_gui = props.on_gui
	
	
	return inst
}

function create_text(_props) {
	props = new Map({
		x: 0,
		y: 0,
		font: noone,
		text: "Sample Text",
		spd: {x: 0, y: 0},
		halign: fa_center,
		valign: fa_middle,
		alpha: 1.0,
		lifetime: 30,
		fadeout_time: 0,
		fadein_time: 0,
		xscale: 1,
		yscale: 1,
		rotation: 0,
		color: c_white,
		stuck: noone,
		on_gui: false
	})
	
	inheritProps(_props)
	
	props = props.content
	
	var inst = instance_create_layer(props.x, props.y, "Effects", oFloatingText)
	
	inst.text = props.text
	inst.font = props.font
	
	inst.halign = props.halign
	inst.valign = props.valign
	
	inst.alpha = props.alpha
	inst.spd = props.spd
	
	inst.lifetime = props.lifetime
				  //+ props.fadein_time
				  //+ props.fadeout_time
	
	inst.fadein_time = props.fadein_time
	inst.fadeout_time = props.fadeout_time
	
	inst.fadein_speed = (props.alpha)/(props.fadein_time)
	inst.fadeout_speed = (props.alpha)/(props.fadeout_time)
	
	inst.rot = props.rotation
	inst.xs = props.xscale
	inst.ys = props.yscale
	
	inst.col = props.color
	inst.stuck = props.stuck
	inst.on_gui = props.on_gui
	
	
	if props.fadein_time {
		inst.alpha = 0
	}
	
	return inst
}