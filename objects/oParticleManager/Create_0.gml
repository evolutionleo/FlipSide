/// @desc Manages Particles :)

#region Blood Particle System
global.ps = part_system_create();
part_system_depth(global.ps, -1);
#endregion
#region Blood particles
//Generated for GMS2 in Geon FX v1.3
//Put this code in Create event

//Blood Particle Types
//Blood
global.pt_Blood = part_type_create();
part_type_shape(global.pt_Blood, pt_shape_disk);
part_type_size(global.pt_Blood, 0.50, 0.50, 0, 0);
part_type_scale(global.pt_Blood, 0.50, 0.50);
part_type_orientation(global.pt_Blood, 0, 0, 0, 0, 0);
part_type_color3(global.pt_Blood, 255, 79102, 255);
part_type_alpha3(global.pt_Blood, 1, 1, 1);
part_type_blend(global.pt_Blood, 0);
part_type_life(global.pt_Blood, 80, 80);
part_type_speed(global.pt_Blood, 5, 5, 0, 0);
part_type_direction(global.pt_Blood, -11, 187, 0, 0);
part_type_gravity(global.pt_Blood, 0.50, 270);

//Blood Emitters
global.pe_Blood = part_emitter_create(global.ps);

#endregion
#region SlimeBlood particles

//SlimeBlood Particle Types
//SlimeBlood
global.pt_SlimeBlood = part_type_create();
part_type_shape(global.pt_SlimeBlood, pt_shape_disk);
part_type_size(global.pt_SlimeBlood, 0.50, 0.50, 0, 0);
part_type_scale(global.pt_SlimeBlood, 0.50, 0.50);
part_type_orientation(global.pt_SlimeBlood, 0, 0, 0, 0, 0);
part_type_color3(global.pt_SlimeBlood, 4259584, 65408, 8454016);
part_type_alpha3(global.pt_SlimeBlood, 1, 1, 1);
part_type_blend(global.pt_SlimeBlood, 0);
part_type_life(global.pt_SlimeBlood, 80, 80);
part_type_speed(global.pt_SlimeBlood, 5, 5, 0, 0);
part_type_direction(global.pt_SlimeBlood, -11, 187, 0, 0);
part_type_gravity(global.pt_SlimeBlood, 0.50, 270);

//SlimeBlood Emitters
global.pe_SlimeBlood = part_emitter_create(global.ps);

#endregion