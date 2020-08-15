/// @desc

// Inherit the parent event
event_inherited();

max_hp = 40
hp = 40
atk = 10


hpbar_color = c_red
hpbar_textcolor = c_white
blood_color = c_lime


pattern = [INTENTIONS.ATTACK]

initializeEnemy()


onHit = function() {
	audio_play_sound(aSlimeHit, 50, false)
	#region Burst blood particles
	
	var xp, yp;
	xp = x;
	yp = y;
	part_type_color1(global.pe_SlimeBlood, blood_color)
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
	part_type_color1(global.pe_SlimeBlood, blood_color)
	part_emitter_region(global.ps, global.pe_SlimeBlood, xp-16, xp+16, yp-32, yp+32, ps_shape_rectangle, ps_distr_linear);
	part_emitter_burst(global.ps, global.pe_SlimeBlood, global.pt_SlimeBlood, 10);

	#endregion
	}
}
