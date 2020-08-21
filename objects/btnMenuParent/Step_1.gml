/// @desc Ease

//if live_call()
//	return live_result

//animcurve = ease_state == EASE_STATE.UP
//					? cvButtonSlideIn
					//: cvButtonSlideOut

animcurve = cvButtonSlideIn

ease_pos = clamp(ease_pos, 0, 1)

channel = animcurve_get_channel(animcurve, "curve1")
channel_pos = animcurve_channel_evaluate(channel, ease_pos)

x	  =	xstart		+ max_ease_x	 * channel_pos
scale = start_scale + max_ease_scale * channel_pos