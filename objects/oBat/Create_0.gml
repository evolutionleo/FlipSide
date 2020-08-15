/// @desc

event_inherited();

max_hp = 160
hp = 160
atk = 20

pattern = [
	//[INTENTIONS.ATTACK, 20],
	INTENTIONS.ATTACK,
	[INTENTIONS.HEAL, 10],
	[INTENTIONS.ATTACK, 30],
	[INTENTIONS.HEAL, 20],
	[INTENTIONS.ATTACK, 40]
]

pattern_next = [
	[INTENTIONS.HEAL, 30],
	[INTENTIONS.ATTACK, 20]
]

pattern_loop = true



initializeEnemy()