///@arg json
function json_optimize(json) {
	
	// Cut the zeros
	for(var sym = 0; sym < 10; sym++) // 00000 through 90000
	{
		var str_ = string(sym)
		json = string_replace_all(json,"."+str_+"00000,",	"."+str_+",")
		json = string_replace_all(json,"."+str_+"0000,",	"."+str_+",")
		json = string_replace_all(json,"."+str_+"000,",		"."+str_+",")
		json = string_replace_all(json,"."+str_+"00,",		"."+str_+",")
		json = string_replace_all(json,"."+str_+"0,",		"."+str_+",")

		json = string_replace_all(json,"."+str_+"00000 ]",	"."+str_+" ]")
		json = string_replace_all(json,"."+str_+"0000 ]",	"."+str_+" ]")
		json = string_replace_all(json,"."+str_+"000 ]",	"."+str_+" ]")
		json = string_replace_all(json,"."+str_+"00 ]",		"."+str_+" ]")
		json = string_replace_all(json,"."+str_+"0 ]",		"."+str_+" ]")
	
		json = string_replace_all(json,"."+str_+"00000 }",	"."+str_+" }")
		json = string_replace_all(json,"."+str_+"0000 }",	"."+str_+" }")
		json = string_replace_all(json,"."+str_+"000 }",	"."+str_+" }")
		json = string_replace_all(json,"."+str_+"00 }",		"."+str_+" }")
		json = string_replace_all(json,"."+str_+"0 }",		"."+str_+" }")
	}

	json = string_replace_all(json,".0,",",")
	json = string_replace_all(json,".0 ]"," ]")
	json = string_replace_all(json,".0 }"," }")

	return json


}
