/// @desc
if active
	image_alpha += .1
else
	image_alpha -= .1


image_alpha = clamp(image_alpha, 0, 1)