/// @desc

// Inherit the parent event
event_inherited();

max_hp = 40
hp = 40
atk = 10

acting = false

pattern = [INTENTIONS.ATTACK]


startTurn = function() {
	processEffects()
	
	// Start animation
	var postfix = ""
	if intention == INTENTIONS.ATTACK
		postfix = "Attack"
	else if intention == INTENTIONS.HEAL
		postfix = "Heal"
	
	sprite_index = asset_get_index(sprite_get_name(object_get_sprite(object_index))+postfix)
	if !sprite_exists(sprite_index)
		sprite_index = object_get_sprite(object_index)
	
	
	audio_play_sound(aSlimeAttack, 30, false)
	acting = true
}

onHit = function() {
	audio_play_sound(aSlimeHit, 50, false)
	#region Burst blood particles
	
	var xp, yp;
	xp = x;
	yp = y;
	part_emitter_region(global.ps, global.pe_SlimeBlood, xp-16, xp+16, yp-32, yp+32, ps_shape_rectangle, ps_distr_linear);
	part_emitter_burst(global.ps, global.pe_SlimeBlood, global.pt_SlimeBlood, 10);
	
	#endregion
}

onDeath = function() {
	//if global.turner == id {
	//	global.turn_id--
	//	passTurn()
	//}
	repeat(2) {
	#region Burst blood particles
		
	var xp, yp;
	xp = x;
	yp = y;
	part_emitter_region(global.ps, global.pe_SlimeBlood, xp-16, xp+16, yp-32, yp+32, ps_shape_rectangle, ps_distr_linear);
	part_emitter_burst(global.ps, global.pe_SlimeBlood, global.pt_SlimeBlood, 10);

	#endregion
	}
}