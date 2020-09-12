/// @desc

event_inherited();

onStep = function() {
	static _scale = SUMMARY_ICON_SCALE
	var killer = oStats.getStats().killer
	text = object_get_name(killer.object_index)
}