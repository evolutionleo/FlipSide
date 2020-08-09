/// @desc

event_inherited();

max_hp = 160

pattern = [
	[INTENTIONS.ATTACK, 20],
	[INTENTIONS.HEAL, 20],
	[INTENTIONS.ATTACK, 40],
	[INTENTIONS.HEAL, 40],
	[INTENTIONS.ATTACK, 80]
]

pattern_next = [
	[INTENTIONS.HEAL, 100],
	[INTENTIONS.ATTACK, 100]
]

pattern_loop = true
