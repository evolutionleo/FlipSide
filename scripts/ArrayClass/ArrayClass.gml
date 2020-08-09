// Idea: child class CleanArray(), with all methods not affecting the original array


///@function	Array(*item1, *item2, ...)
///@description	Constructor funcion for Array objects
///@param		{any} *item
function Array() constructor {
	content = [];
	size = 0;
	
	
	///@function	append(value)
	///@description	Adds a value to the end of the array
	///@param		{any} value
	append = function(value) {
		content[self.size] = value;
		++size;
		
		return self;
	}
	
	///@function	add(value)
	///@description Mirrors append() method
	///@param		{any} value
	add = function(value) {
		append(value)
	}
	
	///@function	concat(other)
	///@description	Adds every element of the second array to this array
	///@param		{Array} other
	concat = function(_other) {
		if(!is_Array(_other)) {
			throw "TypeError: trying to concat "+typeof(_other)+" with Array";
			return self;
		}
		
		for(var i = 0; i < _other.size; i++) {
			self.append(_other.get(i));
		}
		
		return self;
	}
	
	///@function	copy()
	///@description	Returns a copy of the array object
	copy = function() {
		ans = new Array();
		
		self.forEach(function(el) {
			ans.append(el);
		});
		
		return ans;
	}
	
	///@function	clear()
	///@description	clears an array object
	clear = function() {
		self.content = [];
		self.size = 0;
	}
	
	///@function	remove(pos)
	///@description	removes the value at given position
	///@param		{real} pos
	remove = function(pos) {
		if(pos < 0)
			pos += size;
		
		if(size == 0) {
			throw "Error: trying to remove value from an empty Array";
			return self;
		}
		else if(pos < 0 or pos > size - 1) {
			throw "Error: index "+string(pos)+" is out of range [0, "+string(size-1)+"]";
			return self;
		}
		
		var part1 = self.slice(0, pos);
		var part2 = self.slice(pos+1);
		
		part1.concat(part2);
		
		self.content = part1.content;
		self.size--;
		
		return self;
	}
	
	///@function	empty()
	///@description	Returns true if the array is empty and false otherwise
	empty = function() {
		return self.size == 0;
	}
	
	///@function	equal(other)
	///@description	Returns true if arrays are equal and false otherwise
	equal = function(_other) {
		if(!is_Array(_other)) {
			throw "TypeError: trying to compare "+typeof(_other)+" with Array";
			return false;
		}
		
		if(self.size != _other.size)
			return false;
		
		for(var i = 0; i < self.size; i++) {
			var c1 = self.get(i);
			var c2 = _other.get(i);
			
			
			if(typeof(c1) != typeof(c2))
				return false;
			
			
			if(is_array(c1) and is_array(c2)) {
				if(!array_equals(c1, c2))
					return false;
			}
			else if(is_Array(c1) and is_Array(c2)) {
				if(!c1.equal(c2))
					return false;
			}
			else if c1 != c2
				return false;
		}
		
		return true;
	}
	
	///@function	exists(value)
	///@description	Returns true if the value exists in the array and false otherwise
	exists = function(_val) {
		val = _val;
		ans = false;
		
		self.forEach(function(x, pos) {
			if(x == val) {
				ans = true;
				return 1; //Break out of forEach()
			}
		});
		
		return ans;
	}
	
	///@function	filter(func)
	///@description	Loops through the array and passes each value into a function.
	///				Returns a new array with only values, that returned true.
	///				Function func gets (x, *pos) as input
	///				Note: Clean function. Does not affect the original array!
	///@param		{function} func
	filter = function(_func) {
		func = _func;
		ans = new Array();
		
		self.forEach(function(x, pos) {
			if(func(x, pos))
				ans.append(x);
		});
		
		//self.content = ans.content;
		//return self;
		return ans;
	}
	
	///@function	find(value)
	///@description	finds a value and returns its position. -1 if not found
	///@param		{any} value
	find = function(_val) {
		val = _val;
		ans = -1;
		
		self.forEach(function(x, pos) {
			if(x == val) {
				ans = pos;
				return 1; //Break out of forEach()
			}
		});
		
		return ans;
	}
	
	///@function	findAll(value)
	///@description	finds all places a value appears and returns an Array with all the positions. empty set if not found
	///@param		{any} value
	findAll = function(_val) {
		val = _val;
		ans = new Array();
		
		self.forEach(function(x, pos) {
			if(x == val)
				ans.append(pos);
		});
		
		return ans;
	}

	///@function	first()
	///@description	Returns the first value of the array
	first = function() {
		return self.get(0);
	}
	
	///@function	forEach(func)
	///@description	Loops through the array and runs the function with each element as an argument
	///				Function func gets (x, *pos) as arguments
	///				Note: Loop will stop immediately if the function returns anything but zero
	///@param		{function} func(x, *pos)
	forEach = function(func) {
		for(var i = 0; i < self.size; i++) {
			var res = func(self.get(i), i)
			if(!is_undefined(res) and res != 0) {
				break;
			}
		}
		
		return self;
	}
	
	///@function	get(pos)
	///@description	Returns value at given pos
	///@param		{real} pos
	get = function(pos) {
		if(pos < 0)
			pos += size; //i.e. Array.get(-1) = Array.last()
		
		if(size == 0) {
			throw "Error: trying to achieve value from empty Array";
			return undefined;
		}
		else if(pos < 0 or pos > size-1) {
			throw "Error: index "+string(pos)+" is out of range [0, "+string(size-1)+"]";
			return undefined;
		}
		
		
		return content[pos];
	}
	
	///@function	insert(pos, value)
	///@description	inserts a value into the array at given position
	///@param		{real} pos
	///@param		{any} value
	insert = function(pos, value) {
		if(pos < 0)
			pos += size;
		
		if(pos < 0 or (pos > size-1 and size != 0)) {
			show_debug_message("Warning: trying to insert a value outside of the array. Use Array.set() or Array.append() instead");
			return self.set(pos, value);
		}
		
		var part1 = self.slice(0, pos);
		var part2 = self.slice(pos);
		
		part1.append(value);
		part1.concat(part2);
		
		self.content = part1.content;
		self.size++;
		
		return self;
	}
	
	///@function	lambda(func)
	///@description	Loops through the array and applies the function to each element
	///@param		{function} func(x, *pos)
	lambda = function(func) {
		for(var i = 0; i < self.size; i++) {
			self.set(i, func(self.get(i), i) );
		}
		
		return self;
	}
	
	///@function	last()
	///@description	Returns the last value of the array
	last = function() {
		return self.get(-1);
	}
	
	///@function	_max()
	///@description	Returns a maximum of the array. Only works with numbers
	_max = function() {
		ans = self.get(0);
		
		self.forEach(function(x) {
			if(!is_numeric(x)) {
				throw "TypeError: Trying to calculate maximum of "+typeof(x)+"";
				ans = undefined;
				return 1 // Break out of forEach()
			}
			
			if(x > ans)
				ans = x;
		});
		
		return ans;
	}
	
	///@function	_min()
	///@description	Returns a minimum of the array. Only works with numbers
	_min = function() {
		ans = self.content[0];
		
		self.forEach(function(x) {
			if(!is_numeric(x)) {
				throw "TypeError: Trying to calculate minimum of "+typeof(x)+"";
				ans = undefined;
				return 1
			}
			
			if(x < ans)
				ans = x;
		});
		
		return ans;
	}
	
	///@function	number(value)
	///@description	Returns the amount of elements equal to given value in the array
	///@note		IMPORTANT! Don't try to use this with data structures, as results may be unpredictable
	///				(Use forEach() with your own logic instead)
	///@param		{any} value
	number = function(_val) {
		val = _val;
		ans = 0;
		
		self.forEach(function(x, pos) {
			if(x == val)
				ans++;
		});
		
		return ans;
	}
	
	///@function	pop()
	///@description	removes a value from the end of the array and returns it
	pop = function() {
		ans = self.last();
		if(self.empty()) {
			throw "Error: trying to pop value from empty Array";
			return undefined;
		}
		
		self.remove(-1);
		
		return ans;
	}
	
	///@function	popBack()
	///@description	removes a value from the beginning of the array and returns it
	popBack = function() {
		ans = self.first();
		self.remove(0);
		
		return ans;
	}
	
	///@function	pushBack(value)
	///@description	inserts a value to the beginning of the array
	///@param		{any} value
	pushBack = function(val) {
		self.insert(0, val);
	}
	
	///@function	getRandom()
	///@description Returns a random element from the array
	getRandom = function() {
		var idx = irandom(self.size-1)
		if self.empty() {
			var ans = undefined
		}
		else {
			var ans = self.get(idx)
		}
		
		return ans
	}
	
	///@function	resize(size)
	///@description	resizes the array. Sizing up leads to filling the empty spots with zeros
	///@param		{real} size
	resize = function(size) {
		if(size < 0) {
			throw "Error: array size cannot be negative";
			return self;
		}
		
		while(self.size < size) {
			self.append(0);
		}
		while(self.size > size) {
			self.pop();
		}
		
		return self;
	}
	
	///@function	reverse()
	///@description	reverses the array, affecting it
	reverse = function() {
		ans = new Array();
		self.forEach(function(element, pos) {
			ans.set(size-pos-1, element);
		});
		
		self.content = ans.content;
		return self;
	}
	
	///@function	reversed()
	///@description	Returns reversed version of the array, without affecting the original
	reversed = function() {
		ans = new Array();
		self.forEach(function(element, pos) {
			ans.set(size-pos-1, element);
		});
		
		return ans;
	}
	
	///@function	set(pos, value)
	///@description	sets value in the array at given index
	///@param		{real} pos
	///@param		{any} item
	set = function(pos, value) {
		if(pos < 0)
			pos += size;
		
		if(pos > size-1)
			size = pos+1;
		
		
		content[pos] = value;
		
		return self;
	}
	
	///@function	slice(begin, end)
	///@description	Returns a slice from the array with given boundaries. If begin > end - returns reversed version
	///@param		{real} begin
	///@param		{real} end
	slice = function(_begin, _end) {
		if(is_undefined(_begin))
			_begin = 0;
		
		if(is_undefined(_end))
			_end = self.size;
		
		ans = new Array();
		
		
		if(_begin > _end) {
			for(var i = _end; i < _begin; i++) {
				ans.pushBack(content[i]);
			}
		}
		else {
			for(var i = _begin; i < _end; i++) {
				ans.append(content[i]);
			}
		}
		
		return ans;
	}
	
	///@function	sort(func, *startpos, *endpos)
	///@description	Bubble sorts through the array in given range, comparing values using provided function. 
	///Function gets (a, b) as input and must return True if A has more priority than B and False otherwise.
	///@example myarray.sort(function(a, b) { return a > b }) will sort myarray in descending order
	///@param		{function} func(a, b)
	///@param		{real} *startpos	Default - 0
	///@param		{real} *endpos		Default - size
	sort = function(compare, _begin, _end) {
		if(is_undefined(_begin))
			_begin = 0;
		
		if(is_undefined(_end))
			_end = self.size;
		
		
		if(!is_numeric(_begin) or round(_begin) != _begin or !is_numeric(_end) or round(_end) != _end) {
			throw "TypeError: sort boundaries must be integers";
			return self;
		}
		
		for(var i = _begin; i < _end; i++) {	// Bubble sort LUL
			for(var j = i; j > _begin; j--) {
				if(compare(self.get(j), self.get(j-1))) {
					self.swap(j, j-1);
				}
			}
		}
		
		return self;
	}
	
	///@function	shuffle()
	///@description shuffles the array (randomly replaces every element)
	shuffle = function() {
		//ans = new Array()
		//ans.resize(self.size)
		
		//var list = ds_list_from_Array(self)
		var list = ds_list_create()
		for(var i = 0; i < size; i++) 
		{
			ds_list_add(list, content[i])
		}
		
		ds_list_shuffle(list)
		
		ans = ds_list_to_Array(list)
		ds_list_destroy(list)
		
		content = Array_to_array(ans)
		
		return self
	}
	
	///@function	summ()
	///@description	Returns the summ of all the elements of the array. concats strings.
	///NOTE: Works only with strings or numbars and only if all the elements are the same type.
	summ = function() {
		if(is_string(self.get(0)))
			ans = "";
		else if(is_numeric(self.get(0)))
			ans = 0;
		else {
			throw "TypeError: trying to summ up elements, that aren't strings or reals";
			return undefined;
		}
		
		self.forEach(function(el) {
			if(typeof(el) != typeof(ans))
				throw "TypeError: Array elements aren't the same type: got "+typeof(el)+", "+typeof(ans)+" expected.";
			
			ans += el;
		});
		
		return ans;
	}
	
	///@function	swap(pos1, pos2)
	///@description	swaps 2 values at given positions
	///@param		{real} pos1
	///@param		{real} pos2
	swap = function(pos1, pos2) {
		var temp = self.get(pos1);
		self.set(pos1, self.get(pos2));
		self.set(pos2, temp);
		
		return self;
	}
	
	///@function	unique()
	///@description	Returns an Array object, containing a copy of this, but without repeats
	unique = function() {
		ans = new Array();
		
		self.forEach(function(x) {
			if(!ans.exists(x))
				ans.append(x);
		});
		
		return ans;
	}

	
	for(var i = 0; i < argument_count; i++)
		self.append(argument[i])
	
	
	toString = function() {
		str = "[";
		
		self.forEach(function(el, i) {
			str += string(el);
			if(i < size-1)
				str += ", ";
		});
		
		str += "]";
		
		return str;
	}
}

///@function	array_to_Array(array)
///@description	Returns an instance of Array object with all the contents of an array
///@param		{array}	array
function array_to_Array(array) {
	if(!is_array(array)) {
		throw "TypeError: expected array, got "+typeof(array);
		return undefined;
	}
	
	ans = new Array();
	
	for(var i = 0; i < array_length(array); i++) {
		ans.append(array[i]);
	}
	
	return ans;
}

///@function	ds_list_to_Array(list)
///@description	Returns an instance of Array object with all the contents of an array
///@param		{real} list
function ds_list_to_Array(list) {
	if(!ds_exists(list, ds_type_list)) {
		throw "Error: ds_list with given index does not exist";
		return undefined;
	}
	
	ans = new Array();
	
	for(var i = 0; i < ds_list_size(list); i++) {
		ans.append(list[| i]);
	}
	
	return ans;
}

///@function	is_Array(Arr)
///@description	Checks if a variable holds reference to an Array object
///@param		{any} arr
function is_Array(Arr) {
	return is_struct(Arr) and instanceof(Arr) == "Array";
}

///@function	Array_to_array(Arr)
///@description	Returns contents of an Array object in format of regular array
///@param		{Array} Arr
function Array_to_array(Arr) {
	if !is_Array(Arr) {
		throw "Error in function Array_to_array(): expected Array(), got "+typeof(Arr)
		return undefined;
	}
	return Arr.content
}

///@function	ds_list_from_Array(Arr)
///@description	Returns contents of an Array object in format of ds_list
///@param		{Array} Arr
function ds_list_from_Array(Arr) {
	if !is_Array(Arr) {
		throw "Error in function ds_list_from_Array(): expected Array(), got "+typeof(Arr)
		return undefined;
	}
	
	var list = ds_list_create()
	Arr.forEach(function(item) {
		ds_list_add(list, item)
	})
	return list
}