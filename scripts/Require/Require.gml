_dependencies = [
	CardsLib(),
	InputClass()
]

global.modules = {
	cards: global.Cards,
	input: global.Input
}

///@function	require(module)
///@param		{string} module
function require(module) {
	
	return variable_struct_get(global.modules, module)
}