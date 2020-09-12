/// @desc

event_inherited();


afterDraw = function() {
	
}

onStep = function() {
	static _scale = SUMMARY_ICON_SCALE
	text = "[scale"+_scale+"]"+"[sRunSummary, 0][/s]" + string(oStats.getStats().kills)
}