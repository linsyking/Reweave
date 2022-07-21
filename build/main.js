(function(scope){
'use strict';

function F(arity, fun, wrapper) {
  wrapper.a = arity;
  wrapper.f = fun;
  return wrapper;
}

function F2(fun) {
  return F(2, fun, function(a) { return function(b) { return fun(a,b); }; })
}
function F3(fun) {
  return F(3, fun, function(a) {
    return function(b) { return function(c) { return fun(a, b, c); }; };
  });
}
function F4(fun) {
  return F(4, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return fun(a, b, c, d); }; }; };
  });
}
function F5(fun) {
  return F(5, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return fun(a, b, c, d, e); }; }; }; };
  });
}
function F6(fun) {
  return F(6, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return fun(a, b, c, d, e, f); }; }; }; }; };
  });
}
function F7(fun) {
  return F(7, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return fun(a, b, c, d, e, f, g); }; }; }; }; }; };
  });
}
function F8(fun) {
  return F(8, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) {
    return fun(a, b, c, d, e, f, g, h); }; }; }; }; }; }; };
  });
}
function F9(fun) {
  return F(9, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) { return function(i) {
    return fun(a, b, c, d, e, f, g, h, i); }; }; }; }; }; }; }; };
  });
}

function A2(fun, a, b) {
  return fun.a === 2 ? fun.f(a, b) : fun(a)(b);
}
function A3(fun, a, b, c) {
  return fun.a === 3 ? fun.f(a, b, c) : fun(a)(b)(c);
}
function A4(fun, a, b, c, d) {
  return fun.a === 4 ? fun.f(a, b, c, d) : fun(a)(b)(c)(d);
}
function A5(fun, a, b, c, d, e) {
  return fun.a === 5 ? fun.f(a, b, c, d, e) : fun(a)(b)(c)(d)(e);
}
function A6(fun, a, b, c, d, e, f) {
  return fun.a === 6 ? fun.f(a, b, c, d, e, f) : fun(a)(b)(c)(d)(e)(f);
}
function A7(fun, a, b, c, d, e, f, g) {
  return fun.a === 7 ? fun.f(a, b, c, d, e, f, g) : fun(a)(b)(c)(d)(e)(f)(g);
}
function A8(fun, a, b, c, d, e, f, g, h) {
  return fun.a === 8 ? fun.f(a, b, c, d, e, f, g, h) : fun(a)(b)(c)(d)(e)(f)(g)(h);
}
function A9(fun, a, b, c, d, e, f, g, h, i) {
  return fun.a === 9 ? fun.f(a, b, c, d, e, f, g, h, i) : fun(a)(b)(c)(d)(e)(f)(g)(h)(i);
}

console.warn('Compiled in DEV mode. Follow the advice at https://elm-lang.org/0.19.1/optimize for better performance and smaller assets.');


var _JsArray_empty = [];

function _JsArray_singleton(value)
{
    return [value];
}

function _JsArray_length(array)
{
    return array.length;
}

var _JsArray_initialize = F3(function(size, offset, func)
{
    var result = new Array(size);

    for (var i = 0; i < size; i++)
    {
        result[i] = func(offset + i);
    }

    return result;
});

var _JsArray_initializeFromList = F2(function (max, ls)
{
    var result = new Array(max);

    for (var i = 0; i < max && ls.b; i++)
    {
        result[i] = ls.a;
        ls = ls.b;
    }

    result.length = i;
    return _Utils_Tuple2(result, ls);
});

var _JsArray_unsafeGet = F2(function(index, array)
{
    return array[index];
});

var _JsArray_unsafeSet = F3(function(index, value, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[index] = value;
    return result;
});

var _JsArray_push = F2(function(value, array)
{
    var length = array.length;
    var result = new Array(length + 1);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[length] = value;
    return result;
});

var _JsArray_foldl = F3(function(func, acc, array)
{
    var length = array.length;

    for (var i = 0; i < length; i++)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_foldr = F3(function(func, acc, array)
{
    for (var i = array.length - 1; i >= 0; i--)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_map = F2(function(func, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = func(array[i]);
    }

    return result;
});

var _JsArray_indexedMap = F3(function(func, offset, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = A2(func, offset + i, array[i]);
    }

    return result;
});

var _JsArray_slice = F3(function(from, to, array)
{
    return array.slice(from, to);
});

var _JsArray_appendN = F3(function(n, dest, source)
{
    var destLen = dest.length;
    var itemsToCopy = n - destLen;

    if (itemsToCopy > source.length)
    {
        itemsToCopy = source.length;
    }

    var size = destLen + itemsToCopy;
    var result = new Array(size);

    for (var i = 0; i < destLen; i++)
    {
        result[i] = dest[i];
    }

    for (var i = 0; i < itemsToCopy; i++)
    {
        result[i + destLen] = source[i];
    }

    return result;
});



// LOG

var _Debug_log_UNUSED = F2(function(tag, value)
{
	return value;
});

var _Debug_log = F2(function(tag, value)
{
	console.log(tag + ': ' + _Debug_toString(value));
	return value;
});


// TODOS

function _Debug_todo(moduleName, region)
{
	return function(message) {
		_Debug_crash(8, moduleName, region, message);
	};
}

function _Debug_todoCase(moduleName, region, value)
{
	return function(message) {
		_Debug_crash(9, moduleName, region, value, message);
	};
}


// TO STRING

function _Debug_toString_UNUSED(value)
{
	return '<internals>';
}

function _Debug_toString(value)
{
	return _Debug_toAnsiString(false, value);
}

function _Debug_toAnsiString(ansi, value)
{
	if (typeof value === 'function')
	{
		return _Debug_internalColor(ansi, '<function>');
	}

	if (typeof value === 'boolean')
	{
		return _Debug_ctorColor(ansi, value ? 'True' : 'False');
	}

	if (typeof value === 'number')
	{
		return _Debug_numberColor(ansi, value + '');
	}

	if (value instanceof String)
	{
		return _Debug_charColor(ansi, "'" + _Debug_addSlashes(value, true) + "'");
	}

	if (typeof value === 'string')
	{
		return _Debug_stringColor(ansi, '"' + _Debug_addSlashes(value, false) + '"');
	}

	if (typeof value === 'object' && '$' in value)
	{
		var tag = value.$;

		if (typeof tag === 'number')
		{
			return _Debug_internalColor(ansi, '<internals>');
		}

		if (tag[0] === '#')
		{
			var output = [];
			for (var k in value)
			{
				if (k === '$') continue;
				output.push(_Debug_toAnsiString(ansi, value[k]));
			}
			return '(' + output.join(',') + ')';
		}

		if (tag === 'Set_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Set')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Set$toList(value));
		}

		if (tag === 'RBNode_elm_builtin' || tag === 'RBEmpty_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Dict')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Dict$toList(value));
		}

		if (tag === 'Array_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Array')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Array$toList(value));
		}

		if (tag === '::' || tag === '[]')
		{
			var output = '[';

			value.b && (output += _Debug_toAnsiString(ansi, value.a), value = value.b)

			for (; value.b; value = value.b) // WHILE_CONS
			{
				output += ',' + _Debug_toAnsiString(ansi, value.a);
			}
			return output + ']';
		}

		var output = '';
		for (var i in value)
		{
			if (i === '$') continue;
			var str = _Debug_toAnsiString(ansi, value[i]);
			var c0 = str[0];
			var parenless = c0 === '{' || c0 === '(' || c0 === '[' || c0 === '<' || c0 === '"' || str.indexOf(' ') < 0;
			output += ' ' + (parenless ? str : '(' + str + ')');
		}
		return _Debug_ctorColor(ansi, tag) + output;
	}

	if (typeof DataView === 'function' && value instanceof DataView)
	{
		return _Debug_stringColor(ansi, '<' + value.byteLength + ' bytes>');
	}

	if (typeof File !== 'undefined' && value instanceof File)
	{
		return _Debug_internalColor(ansi, '<' + value.name + '>');
	}

	if (typeof value === 'object')
	{
		var output = [];
		for (var key in value)
		{
			var field = key[0] === '_' ? key.slice(1) : key;
			output.push(_Debug_fadeColor(ansi, field) + ' = ' + _Debug_toAnsiString(ansi, value[key]));
		}
		if (output.length === 0)
		{
			return '{}';
		}
		return '{ ' + output.join(', ') + ' }';
	}

	return _Debug_internalColor(ansi, '<internals>');
}

function _Debug_addSlashes(str, isChar)
{
	var s = str
		.replace(/\\/g, '\\\\')
		.replace(/\n/g, '\\n')
		.replace(/\t/g, '\\t')
		.replace(/\r/g, '\\r')
		.replace(/\v/g, '\\v')
		.replace(/\0/g, '\\0');

	if (isChar)
	{
		return s.replace(/\'/g, '\\\'');
	}
	else
	{
		return s.replace(/\"/g, '\\"');
	}
}

function _Debug_ctorColor(ansi, string)
{
	return ansi ? '\x1b[96m' + string + '\x1b[0m' : string;
}

function _Debug_numberColor(ansi, string)
{
	return ansi ? '\x1b[95m' + string + '\x1b[0m' : string;
}

function _Debug_stringColor(ansi, string)
{
	return ansi ? '\x1b[93m' + string + '\x1b[0m' : string;
}

function _Debug_charColor(ansi, string)
{
	return ansi ? '\x1b[92m' + string + '\x1b[0m' : string;
}

function _Debug_fadeColor(ansi, string)
{
	return ansi ? '\x1b[37m' + string + '\x1b[0m' : string;
}

function _Debug_internalColor(ansi, string)
{
	return ansi ? '\x1b[36m' + string + '\x1b[0m' : string;
}

function _Debug_toHexDigit(n)
{
	return String.fromCharCode(n < 10 ? 48 + n : 55 + n);
}


// CRASH


function _Debug_crash_UNUSED(identifier)
{
	throw new Error('https://github.com/elm/core/blob/1.0.0/hints/' + identifier + '.md');
}


function _Debug_crash(identifier, fact1, fact2, fact3, fact4)
{
	switch(identifier)
	{
		case 0:
			throw new Error('What node should I take over? In JavaScript I need something like:\n\n    Elm.Main.init({\n        node: document.getElementById("elm-node")\n    })\n\nYou need to do this with any Browser.sandbox or Browser.element program.');

		case 1:
			throw new Error('Browser.application programs cannot handle URLs like this:\n\n    ' + document.location.href + '\n\nWhat is the root? The root of your file system? Try looking at this program with `elm reactor` or some other server.');

		case 2:
			var jsonErrorString = fact1;
			throw new Error('Problem with the flags given to your Elm program on initialization.\n\n' + jsonErrorString);

		case 3:
			var portName = fact1;
			throw new Error('There can only be one port named `' + portName + '`, but your program has multiple.');

		case 4:
			var portName = fact1;
			var problem = fact2;
			throw new Error('Trying to send an unexpected type of value through port `' + portName + '`:\n' + problem);

		case 5:
			throw new Error('Trying to use `(==)` on functions.\nThere is no way to know if functions are "the same" in the Elm sense.\nRead more about this at https://package.elm-lang.org/packages/elm/core/latest/Basics#== which describes why it is this way and what the better version will look like.');

		case 6:
			var moduleName = fact1;
			throw new Error('Your page is loading multiple Elm scripts with a module named ' + moduleName + '. Maybe a duplicate script is getting loaded accidentally? If not, rename one of them so I know which is which!');

		case 8:
			var moduleName = fact1;
			var region = fact2;
			var message = fact3;
			throw new Error('TODO in module `' + moduleName + '` ' + _Debug_regionToString(region) + '\n\n' + message);

		case 9:
			var moduleName = fact1;
			var region = fact2;
			var value = fact3;
			var message = fact4;
			throw new Error(
				'TODO in module `' + moduleName + '` from the `case` expression '
				+ _Debug_regionToString(region) + '\n\nIt received the following value:\n\n    '
				+ _Debug_toString(value).replace('\n', '\n    ')
				+ '\n\nBut the branch that handles it says:\n\n    ' + message.replace('\n', '\n    ')
			);

		case 10:
			throw new Error('Bug in https://github.com/elm/virtual-dom/issues');

		case 11:
			throw new Error('Cannot perform mod 0. Division by zero error.');
	}
}

function _Debug_regionToString(region)
{
	if (region.start.line === region.end.line)
	{
		return 'on line ' + region.start.line;
	}
	return 'on lines ' + region.start.line + ' through ' + region.end.line;
}



// EQUALITY

function _Utils_eq(x, y)
{
	for (
		var pair, stack = [], isEqual = _Utils_eqHelp(x, y, 0, stack);
		isEqual && (pair = stack.pop());
		isEqual = _Utils_eqHelp(pair.a, pair.b, 0, stack)
		)
	{}

	return isEqual;
}

function _Utils_eqHelp(x, y, depth, stack)
{
	if (x === y)
	{
		return true;
	}

	if (typeof x !== 'object' || x === null || y === null)
	{
		typeof x === 'function' && _Debug_crash(5);
		return false;
	}

	if (depth > 100)
	{
		stack.push(_Utils_Tuple2(x,y));
		return true;
	}

	/**/
	if (x.$ === 'Set_elm_builtin')
	{
		x = $elm$core$Set$toList(x);
		y = $elm$core$Set$toList(y);
	}
	if (x.$ === 'RBNode_elm_builtin' || x.$ === 'RBEmpty_elm_builtin')
	{
		x = $elm$core$Dict$toList(x);
		y = $elm$core$Dict$toList(y);
	}
	//*/

	/**_UNUSED/
	if (x.$ < 0)
	{
		x = $elm$core$Dict$toList(x);
		y = $elm$core$Dict$toList(y);
	}
	//*/

	for (var key in x)
	{
		if (!_Utils_eqHelp(x[key], y[key], depth + 1, stack))
		{
			return false;
		}
	}
	return true;
}

var _Utils_equal = F2(_Utils_eq);
var _Utils_notEqual = F2(function(a, b) { return !_Utils_eq(a,b); });



// COMPARISONS

// Code in Generate/JavaScript.hs, Basics.js, and List.js depends on
// the particular integer values assigned to LT, EQ, and GT.

function _Utils_cmp(x, y, ord)
{
	if (typeof x !== 'object')
	{
		return x === y ? /*EQ*/ 0 : x < y ? /*LT*/ -1 : /*GT*/ 1;
	}

	/**/
	if (x instanceof String)
	{
		var a = x.valueOf();
		var b = y.valueOf();
		return a === b ? 0 : a < b ? -1 : 1;
	}
	//*/

	/**_UNUSED/
	if (typeof x.$ === 'undefined')
	//*/
	/**/
	if (x.$[0] === '#')
	//*/
	{
		return (ord = _Utils_cmp(x.a, y.a))
			? ord
			: (ord = _Utils_cmp(x.b, y.b))
				? ord
				: _Utils_cmp(x.c, y.c);
	}

	// traverse conses until end of a list or a mismatch
	for (; x.b && y.b && !(ord = _Utils_cmp(x.a, y.a)); x = x.b, y = y.b) {} // WHILE_CONSES
	return ord || (x.b ? /*GT*/ 1 : y.b ? /*LT*/ -1 : /*EQ*/ 0);
}

var _Utils_lt = F2(function(a, b) { return _Utils_cmp(a, b) < 0; });
var _Utils_le = F2(function(a, b) { return _Utils_cmp(a, b) < 1; });
var _Utils_gt = F2(function(a, b) { return _Utils_cmp(a, b) > 0; });
var _Utils_ge = F2(function(a, b) { return _Utils_cmp(a, b) >= 0; });

var _Utils_compare = F2(function(x, y)
{
	var n = _Utils_cmp(x, y);
	return n < 0 ? $elm$core$Basics$LT : n ? $elm$core$Basics$GT : $elm$core$Basics$EQ;
});


// COMMON VALUES

var _Utils_Tuple0_UNUSED = 0;
var _Utils_Tuple0 = { $: '#0' };

function _Utils_Tuple2_UNUSED(a, b) { return { a: a, b: b }; }
function _Utils_Tuple2(a, b) { return { $: '#2', a: a, b: b }; }

function _Utils_Tuple3_UNUSED(a, b, c) { return { a: a, b: b, c: c }; }
function _Utils_Tuple3(a, b, c) { return { $: '#3', a: a, b: b, c: c }; }

function _Utils_chr_UNUSED(c) { return c; }
function _Utils_chr(c) { return new String(c); }


// RECORDS

function _Utils_update(oldRecord, updatedFields)
{
	var newRecord = {};

	for (var key in oldRecord)
	{
		newRecord[key] = oldRecord[key];
	}

	for (var key in updatedFields)
	{
		newRecord[key] = updatedFields[key];
	}

	return newRecord;
}


// APPEND

var _Utils_append = F2(_Utils_ap);

function _Utils_ap(xs, ys)
{
	// append Strings
	if (typeof xs === 'string')
	{
		return xs + ys;
	}

	// append Lists
	if (!xs.b)
	{
		return ys;
	}
	var root = _List_Cons(xs.a, ys);
	xs = xs.b
	for (var curr = root; xs.b; xs = xs.b) // WHILE_CONS
	{
		curr = curr.b = _List_Cons(xs.a, ys);
	}
	return root;
}



var _List_Nil_UNUSED = { $: 0 };
var _List_Nil = { $: '[]' };

function _List_Cons_UNUSED(hd, tl) { return { $: 1, a: hd, b: tl }; }
function _List_Cons(hd, tl) { return { $: '::', a: hd, b: tl }; }


var _List_cons = F2(_List_Cons);

function _List_fromArray(arr)
{
	var out = _List_Nil;
	for (var i = arr.length; i--; )
	{
		out = _List_Cons(arr[i], out);
	}
	return out;
}

function _List_toArray(xs)
{
	for (var out = []; xs.b; xs = xs.b) // WHILE_CONS
	{
		out.push(xs.a);
	}
	return out;
}

var _List_map2 = F3(function(f, xs, ys)
{
	for (var arr = []; xs.b && ys.b; xs = xs.b, ys = ys.b) // WHILE_CONSES
	{
		arr.push(A2(f, xs.a, ys.a));
	}
	return _List_fromArray(arr);
});

var _List_map3 = F4(function(f, xs, ys, zs)
{
	for (var arr = []; xs.b && ys.b && zs.b; xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A3(f, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map4 = F5(function(f, ws, xs, ys, zs)
{
	for (var arr = []; ws.b && xs.b && ys.b && zs.b; ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A4(f, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map5 = F6(function(f, vs, ws, xs, ys, zs)
{
	for (var arr = []; vs.b && ws.b && xs.b && ys.b && zs.b; vs = vs.b, ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A5(f, vs.a, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_sortBy = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		return _Utils_cmp(f(a), f(b));
	}));
});

var _List_sortWith = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		var ord = A2(f, a, b);
		return ord === $elm$core$Basics$EQ ? 0 : ord === $elm$core$Basics$LT ? -1 : 1;
	}));
});



// MATH

var _Basics_add = F2(function(a, b) { return a + b; });
var _Basics_sub = F2(function(a, b) { return a - b; });
var _Basics_mul = F2(function(a, b) { return a * b; });
var _Basics_fdiv = F2(function(a, b) { return a / b; });
var _Basics_idiv = F2(function(a, b) { return (a / b) | 0; });
var _Basics_pow = F2(Math.pow);

var _Basics_remainderBy = F2(function(b, a) { return a % b; });

// https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/divmodnote-letter.pdf
var _Basics_modBy = F2(function(modulus, x)
{
	var answer = x % modulus;
	return modulus === 0
		? _Debug_crash(11)
		:
	((answer > 0 && modulus < 0) || (answer < 0 && modulus > 0))
		? answer + modulus
		: answer;
});


// TRIGONOMETRY

var _Basics_pi = Math.PI;
var _Basics_e = Math.E;
var _Basics_cos = Math.cos;
var _Basics_sin = Math.sin;
var _Basics_tan = Math.tan;
var _Basics_acos = Math.acos;
var _Basics_asin = Math.asin;
var _Basics_atan = Math.atan;
var _Basics_atan2 = F2(Math.atan2);


// MORE MATH

function _Basics_toFloat(x) { return x; }
function _Basics_truncate(n) { return n | 0; }
function _Basics_isInfinite(n) { return n === Infinity || n === -Infinity; }

var _Basics_ceiling = Math.ceil;
var _Basics_floor = Math.floor;
var _Basics_round = Math.round;
var _Basics_sqrt = Math.sqrt;
var _Basics_log = Math.log;
var _Basics_isNaN = isNaN;


// BOOLEANS

function _Basics_not(bool) { return !bool; }
var _Basics_and = F2(function(a, b) { return a && b; });
var _Basics_or  = F2(function(a, b) { return a || b; });
var _Basics_xor = F2(function(a, b) { return a !== b; });



var _String_cons = F2(function(chr, str)
{
	return chr + str;
});

function _String_uncons(string)
{
	var word = string.charCodeAt(0);
	return !isNaN(word)
		? $elm$core$Maybe$Just(
			0xD800 <= word && word <= 0xDBFF
				? _Utils_Tuple2(_Utils_chr(string[0] + string[1]), string.slice(2))
				: _Utils_Tuple2(_Utils_chr(string[0]), string.slice(1))
		)
		: $elm$core$Maybe$Nothing;
}

var _String_append = F2(function(a, b)
{
	return a + b;
});

function _String_length(str)
{
	return str.length;
}

var _String_map = F2(function(func, string)
{
	var len = string.length;
	var array = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = string.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			array[i] = func(_Utils_chr(string[i] + string[i+1]));
			i += 2;
			continue;
		}
		array[i] = func(_Utils_chr(string[i]));
		i++;
	}
	return array.join('');
});

var _String_filter = F2(function(isGood, str)
{
	var arr = [];
	var len = str.length;
	var i = 0;
	while (i < len)
	{
		var char = str[i];
		var word = str.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += str[i];
			i++;
		}

		if (isGood(_Utils_chr(char)))
		{
			arr.push(char);
		}
	}
	return arr.join('');
});

function _String_reverse(str)
{
	var len = str.length;
	var arr = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = str.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			arr[len - i] = str[i + 1];
			i++;
			arr[len - i] = str[i - 1];
			i++;
		}
		else
		{
			arr[len - i] = str[i];
			i++;
		}
	}
	return arr.join('');
}

var _String_foldl = F3(function(func, state, string)
{
	var len = string.length;
	var i = 0;
	while (i < len)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += string[i];
			i++;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_foldr = F3(function(func, state, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_split = F2(function(sep, str)
{
	return str.split(sep);
});

var _String_join = F2(function(sep, strs)
{
	return strs.join(sep);
});

var _String_slice = F3(function(start, end, str) {
	return str.slice(start, end);
});

function _String_trim(str)
{
	return str.trim();
}

function _String_trimLeft(str)
{
	return str.replace(/^\s+/, '');
}

function _String_trimRight(str)
{
	return str.replace(/\s+$/, '');
}

function _String_words(str)
{
	return _List_fromArray(str.trim().split(/\s+/g));
}

function _String_lines(str)
{
	return _List_fromArray(str.split(/\r\n|\r|\n/g));
}

function _String_toUpper(str)
{
	return str.toUpperCase();
}

function _String_toLower(str)
{
	return str.toLowerCase();
}

var _String_any = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (isGood(_Utils_chr(char)))
		{
			return true;
		}
	}
	return false;
});

var _String_all = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (!isGood(_Utils_chr(char)))
		{
			return false;
		}
	}
	return true;
});

var _String_contains = F2(function(sub, str)
{
	return str.indexOf(sub) > -1;
});

var _String_startsWith = F2(function(sub, str)
{
	return str.indexOf(sub) === 0;
});

var _String_endsWith = F2(function(sub, str)
{
	return str.length >= sub.length &&
		str.lastIndexOf(sub) === str.length - sub.length;
});

var _String_indexes = F2(function(sub, str)
{
	var subLen = sub.length;

	if (subLen < 1)
	{
		return _List_Nil;
	}

	var i = 0;
	var is = [];

	while ((i = str.indexOf(sub, i)) > -1)
	{
		is.push(i);
		i = i + subLen;
	}

	return _List_fromArray(is);
});


// TO STRING

function _String_fromNumber(number)
{
	return number + '';
}


// INT CONVERSIONS

function _String_toInt(str)
{
	var total = 0;
	var code0 = str.charCodeAt(0);
	var start = code0 == 0x2B /* + */ || code0 == 0x2D /* - */ ? 1 : 0;

	for (var i = start; i < str.length; ++i)
	{
		var code = str.charCodeAt(i);
		if (code < 0x30 || 0x39 < code)
		{
			return $elm$core$Maybe$Nothing;
		}
		total = 10 * total + code - 0x30;
	}

	return i == start
		? $elm$core$Maybe$Nothing
		: $elm$core$Maybe$Just(code0 == 0x2D ? -total : total);
}


// FLOAT CONVERSIONS

function _String_toFloat(s)
{
	// check if it is a hex, octal, or binary number
	if (s.length === 0 || /[\sxbo]/.test(s))
	{
		return $elm$core$Maybe$Nothing;
	}
	var n = +s;
	// faster isNaN check
	return n === n ? $elm$core$Maybe$Just(n) : $elm$core$Maybe$Nothing;
}

function _String_fromList(chars)
{
	return _List_toArray(chars).join('');
}




function _Char_toCode(char)
{
	var code = char.charCodeAt(0);
	if (0xD800 <= code && code <= 0xDBFF)
	{
		return (code - 0xD800) * 0x400 + char.charCodeAt(1) - 0xDC00 + 0x10000
	}
	return code;
}

function _Char_fromCode(code)
{
	return _Utils_chr(
		(code < 0 || 0x10FFFF < code)
			? '\uFFFD'
			:
		(code <= 0xFFFF)
			? String.fromCharCode(code)
			:
		(code -= 0x10000,
			String.fromCharCode(Math.floor(code / 0x400) + 0xD800, code % 0x400 + 0xDC00)
		)
	);
}

function _Char_toUpper(char)
{
	return _Utils_chr(char.toUpperCase());
}

function _Char_toLower(char)
{
	return _Utils_chr(char.toLowerCase());
}

function _Char_toLocaleUpper(char)
{
	return _Utils_chr(char.toLocaleUpperCase());
}

function _Char_toLocaleLower(char)
{
	return _Utils_chr(char.toLocaleLowerCase());
}



/**/
function _Json_errorToString(error)
{
	return $elm$json$Json$Decode$errorToString(error);
}
//*/


// CORE DECODERS

function _Json_succeed(msg)
{
	return {
		$: 0,
		a: msg
	};
}

function _Json_fail(msg)
{
	return {
		$: 1,
		a: msg
	};
}

function _Json_decodePrim(decoder)
{
	return { $: 2, b: decoder };
}

var _Json_decodeInt = _Json_decodePrim(function(value) {
	return (typeof value !== 'number')
		? _Json_expecting('an INT', value)
		:
	(-2147483647 < value && value < 2147483647 && (value | 0) === value)
		? $elm$core$Result$Ok(value)
		:
	(isFinite(value) && !(value % 1))
		? $elm$core$Result$Ok(value)
		: _Json_expecting('an INT', value);
});

var _Json_decodeBool = _Json_decodePrim(function(value) {
	return (typeof value === 'boolean')
		? $elm$core$Result$Ok(value)
		: _Json_expecting('a BOOL', value);
});

var _Json_decodeFloat = _Json_decodePrim(function(value) {
	return (typeof value === 'number')
		? $elm$core$Result$Ok(value)
		: _Json_expecting('a FLOAT', value);
});

var _Json_decodeValue = _Json_decodePrim(function(value) {
	return $elm$core$Result$Ok(_Json_wrap(value));
});

var _Json_decodeString = _Json_decodePrim(function(value) {
	return (typeof value === 'string')
		? $elm$core$Result$Ok(value)
		: (value instanceof String)
			? $elm$core$Result$Ok(value + '')
			: _Json_expecting('a STRING', value);
});

function _Json_decodeList(decoder) { return { $: 3, b: decoder }; }
function _Json_decodeArray(decoder) { return { $: 4, b: decoder }; }

function _Json_decodeNull(value) { return { $: 5, c: value }; }

var _Json_decodeField = F2(function(field, decoder)
{
	return {
		$: 6,
		d: field,
		b: decoder
	};
});

var _Json_decodeIndex = F2(function(index, decoder)
{
	return {
		$: 7,
		e: index,
		b: decoder
	};
});

function _Json_decodeKeyValuePairs(decoder)
{
	return {
		$: 8,
		b: decoder
	};
}

function _Json_mapMany(f, decoders)
{
	return {
		$: 9,
		f: f,
		g: decoders
	};
}

var _Json_andThen = F2(function(callback, decoder)
{
	return {
		$: 10,
		b: decoder,
		h: callback
	};
});

function _Json_oneOf(decoders)
{
	return {
		$: 11,
		g: decoders
	};
}


// DECODING OBJECTS

var _Json_map1 = F2(function(f, d1)
{
	return _Json_mapMany(f, [d1]);
});

var _Json_map2 = F3(function(f, d1, d2)
{
	return _Json_mapMany(f, [d1, d2]);
});

var _Json_map3 = F4(function(f, d1, d2, d3)
{
	return _Json_mapMany(f, [d1, d2, d3]);
});

var _Json_map4 = F5(function(f, d1, d2, d3, d4)
{
	return _Json_mapMany(f, [d1, d2, d3, d4]);
});

var _Json_map5 = F6(function(f, d1, d2, d3, d4, d5)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5]);
});

var _Json_map6 = F7(function(f, d1, d2, d3, d4, d5, d6)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6]);
});

var _Json_map7 = F8(function(f, d1, d2, d3, d4, d5, d6, d7)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7]);
});

var _Json_map8 = F9(function(f, d1, d2, d3, d4, d5, d6, d7, d8)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7, d8]);
});


// DECODE

var _Json_runOnString = F2(function(decoder, string)
{
	try
	{
		var value = JSON.parse(string);
		return _Json_runHelp(decoder, value);
	}
	catch (e)
	{
		return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, 'This is not valid JSON! ' + e.message, _Json_wrap(string)));
	}
});

var _Json_run = F2(function(decoder, value)
{
	return _Json_runHelp(decoder, _Json_unwrap(value));
});

function _Json_runHelp(decoder, value)
{
	switch (decoder.$)
	{
		case 2:
			return decoder.b(value);

		case 5:
			return (value === null)
				? $elm$core$Result$Ok(decoder.c)
				: _Json_expecting('null', value);

		case 3:
			if (!_Json_isArray(value))
			{
				return _Json_expecting('a LIST', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _List_fromArray);

		case 4:
			if (!_Json_isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _Json_toElmArray);

		case 6:
			var field = decoder.d;
			if (typeof value !== 'object' || value === null || !(field in value))
			{
				return _Json_expecting('an OBJECT with a field named `' + field + '`', value);
			}
			var result = _Json_runHelp(decoder.b, value[field]);
			return ($elm$core$Result$isOk(result)) ? result : $elm$core$Result$Err(A2($elm$json$Json$Decode$Field, field, result.a));

		case 7:
			var index = decoder.e;
			if (!_Json_isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			if (index >= value.length)
			{
				return _Json_expecting('a LONGER array. Need index ' + index + ' but only see ' + value.length + ' entries', value);
			}
			var result = _Json_runHelp(decoder.b, value[index]);
			return ($elm$core$Result$isOk(result)) ? result : $elm$core$Result$Err(A2($elm$json$Json$Decode$Index, index, result.a));

		case 8:
			if (typeof value !== 'object' || value === null || _Json_isArray(value))
			{
				return _Json_expecting('an OBJECT', value);
			}

			var keyValuePairs = _List_Nil;
			// TODO test perf of Object.keys and switch when support is good enough
			for (var key in value)
			{
				if (value.hasOwnProperty(key))
				{
					var result = _Json_runHelp(decoder.b, value[key]);
					if (!$elm$core$Result$isOk(result))
					{
						return $elm$core$Result$Err(A2($elm$json$Json$Decode$Field, key, result.a));
					}
					keyValuePairs = _List_Cons(_Utils_Tuple2(key, result.a), keyValuePairs);
				}
			}
			return $elm$core$Result$Ok($elm$core$List$reverse(keyValuePairs));

		case 9:
			var answer = decoder.f;
			var decoders = decoder.g;
			for (var i = 0; i < decoders.length; i++)
			{
				var result = _Json_runHelp(decoders[i], value);
				if (!$elm$core$Result$isOk(result))
				{
					return result;
				}
				answer = answer(result.a);
			}
			return $elm$core$Result$Ok(answer);

		case 10:
			var result = _Json_runHelp(decoder.b, value);
			return (!$elm$core$Result$isOk(result))
				? result
				: _Json_runHelp(decoder.h(result.a), value);

		case 11:
			var errors = _List_Nil;
			for (var temp = decoder.g; temp.b; temp = temp.b) // WHILE_CONS
			{
				var result = _Json_runHelp(temp.a, value);
				if ($elm$core$Result$isOk(result))
				{
					return result;
				}
				errors = _List_Cons(result.a, errors);
			}
			return $elm$core$Result$Err($elm$json$Json$Decode$OneOf($elm$core$List$reverse(errors)));

		case 1:
			return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, decoder.a, _Json_wrap(value)));

		case 0:
			return $elm$core$Result$Ok(decoder.a);
	}
}

function _Json_runArrayDecoder(decoder, value, toElmValue)
{
	var len = value.length;
	var array = new Array(len);
	for (var i = 0; i < len; i++)
	{
		var result = _Json_runHelp(decoder, value[i]);
		if (!$elm$core$Result$isOk(result))
		{
			return $elm$core$Result$Err(A2($elm$json$Json$Decode$Index, i, result.a));
		}
		array[i] = result.a;
	}
	return $elm$core$Result$Ok(toElmValue(array));
}

function _Json_isArray(value)
{
	return Array.isArray(value) || (typeof FileList !== 'undefined' && value instanceof FileList);
}

function _Json_toElmArray(array)
{
	return A2($elm$core$Array$initialize, array.length, function(i) { return array[i]; });
}

function _Json_expecting(type, value)
{
	return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, 'Expecting ' + type, _Json_wrap(value)));
}


// EQUALITY

function _Json_equality(x, y)
{
	if (x === y)
	{
		return true;
	}

	if (x.$ !== y.$)
	{
		return false;
	}

	switch (x.$)
	{
		case 0:
		case 1:
			return x.a === y.a;

		case 2:
			return x.b === y.b;

		case 5:
			return x.c === y.c;

		case 3:
		case 4:
		case 8:
			return _Json_equality(x.b, y.b);

		case 6:
			return x.d === y.d && _Json_equality(x.b, y.b);

		case 7:
			return x.e === y.e && _Json_equality(x.b, y.b);

		case 9:
			return x.f === y.f && _Json_listEquality(x.g, y.g);

		case 10:
			return x.h === y.h && _Json_equality(x.b, y.b);

		case 11:
			return _Json_listEquality(x.g, y.g);
	}
}

function _Json_listEquality(aDecoders, bDecoders)
{
	var len = aDecoders.length;
	if (len !== bDecoders.length)
	{
		return false;
	}
	for (var i = 0; i < len; i++)
	{
		if (!_Json_equality(aDecoders[i], bDecoders[i]))
		{
			return false;
		}
	}
	return true;
}


// ENCODE

var _Json_encode = F2(function(indentLevel, value)
{
	return JSON.stringify(_Json_unwrap(value), null, indentLevel) + '';
});

function _Json_wrap(value) { return { $: 0, a: value }; }
function _Json_unwrap(value) { return value.a; }

function _Json_wrap_UNUSED(value) { return value; }
function _Json_unwrap_UNUSED(value) { return value; }

function _Json_emptyArray() { return []; }
function _Json_emptyObject() { return {}; }

var _Json_addField = F3(function(key, value, object)
{
	object[key] = _Json_unwrap(value);
	return object;
});

function _Json_addEntry(func)
{
	return F2(function(entry, array)
	{
		array.push(_Json_unwrap(func(entry)));
		return array;
	});
}

var _Json_encodeNull = _Json_wrap(null);



// TASKS

function _Scheduler_succeed(value)
{
	return {
		$: 0,
		a: value
	};
}

function _Scheduler_fail(error)
{
	return {
		$: 1,
		a: error
	};
}

function _Scheduler_binding(callback)
{
	return {
		$: 2,
		b: callback,
		c: null
	};
}

var _Scheduler_andThen = F2(function(callback, task)
{
	return {
		$: 3,
		b: callback,
		d: task
	};
});

var _Scheduler_onError = F2(function(callback, task)
{
	return {
		$: 4,
		b: callback,
		d: task
	};
});

function _Scheduler_receive(callback)
{
	return {
		$: 5,
		b: callback
	};
}


// PROCESSES

var _Scheduler_guid = 0;

function _Scheduler_rawSpawn(task)
{
	var proc = {
		$: 0,
		e: _Scheduler_guid++,
		f: task,
		g: null,
		h: []
	};

	_Scheduler_enqueue(proc);

	return proc;
}

function _Scheduler_spawn(task)
{
	return _Scheduler_binding(function(callback) {
		callback(_Scheduler_succeed(_Scheduler_rawSpawn(task)));
	});
}

function _Scheduler_rawSend(proc, msg)
{
	proc.h.push(msg);
	_Scheduler_enqueue(proc);
}

var _Scheduler_send = F2(function(proc, msg)
{
	return _Scheduler_binding(function(callback) {
		_Scheduler_rawSend(proc, msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});

function _Scheduler_kill(proc)
{
	return _Scheduler_binding(function(callback) {
		var task = proc.f;
		if (task.$ === 2 && task.c)
		{
			task.c();
		}

		proc.f = null;

		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
}


/* STEP PROCESSES

type alias Process =
  { $ : tag
  , id : unique_id
  , root : Task
  , stack : null | { $: SUCCEED | FAIL, a: callback, b: stack }
  , mailbox : [msg]
  }

*/


var _Scheduler_working = false;
var _Scheduler_queue = [];


function _Scheduler_enqueue(proc)
{
	_Scheduler_queue.push(proc);
	if (_Scheduler_working)
	{
		return;
	}
	_Scheduler_working = true;
	while (proc = _Scheduler_queue.shift())
	{
		_Scheduler_step(proc);
	}
	_Scheduler_working = false;
}


function _Scheduler_step(proc)
{
	while (proc.f)
	{
		var rootTag = proc.f.$;
		if (rootTag === 0 || rootTag === 1)
		{
			while (proc.g && proc.g.$ !== rootTag)
			{
				proc.g = proc.g.i;
			}
			if (!proc.g)
			{
				return;
			}
			proc.f = proc.g.b(proc.f.a);
			proc.g = proc.g.i;
		}
		else if (rootTag === 2)
		{
			proc.f.c = proc.f.b(function(newRoot) {
				proc.f = newRoot;
				_Scheduler_enqueue(proc);
			});
			return;
		}
		else if (rootTag === 5)
		{
			if (proc.h.length === 0)
			{
				return;
			}
			proc.f = proc.f.b(proc.h.shift());
		}
		else // if (rootTag === 3 || rootTag === 4)
		{
			proc.g = {
				$: rootTag === 3 ? 0 : 1,
				b: proc.f.b,
				i: proc.g
			};
			proc.f = proc.f.d;
		}
	}
}



function _Process_sleep(time)
{
	return _Scheduler_binding(function(callback) {
		var id = setTimeout(function() {
			callback(_Scheduler_succeed(_Utils_Tuple0));
		}, time);

		return function() { clearTimeout(id); };
	});
}




// PROGRAMS


var _Platform_worker = F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function() { return function() {} }
	);
});



// INITIALIZE A PROGRAM


function _Platform_initialize(flagDecoder, args, init, update, subscriptions, stepperBuilder)
{
	var result = A2(_Json_run, flagDecoder, _Json_wrap(args ? args['flags'] : undefined));
	$elm$core$Result$isOk(result) || _Debug_crash(2 /**/, _Json_errorToString(result.a) /**/);
	var managers = {};
	var initPair = init(result.a);
	var model = initPair.a;
	var stepper = stepperBuilder(sendToApp, model);
	var ports = _Platform_setupEffects(managers, sendToApp);

	function sendToApp(msg, viewMetadata)
	{
		var pair = A2(update, msg, model);
		stepper(model = pair.a, viewMetadata);
		_Platform_enqueueEffects(managers, pair.b, subscriptions(model));
	}

	_Platform_enqueueEffects(managers, initPair.b, subscriptions(model));

	return ports ? { ports: ports } : {};
}



// TRACK PRELOADS
//
// This is used by code in elm/browser and elm/http
// to register any HTTP requests that are triggered by init.
//


var _Platform_preload;


function _Platform_registerPreload(url)
{
	_Platform_preload.add(url);
}



// EFFECT MANAGERS


var _Platform_effectManagers = {};


function _Platform_setupEffects(managers, sendToApp)
{
	var ports;

	// setup all necessary effect managers
	for (var key in _Platform_effectManagers)
	{
		var manager = _Platform_effectManagers[key];

		if (manager.a)
		{
			ports = ports || {};
			ports[key] = manager.a(key, sendToApp);
		}

		managers[key] = _Platform_instantiateManager(manager, sendToApp);
	}

	return ports;
}


function _Platform_createManager(init, onEffects, onSelfMsg, cmdMap, subMap)
{
	return {
		b: init,
		c: onEffects,
		d: onSelfMsg,
		e: cmdMap,
		f: subMap
	};
}


function _Platform_instantiateManager(info, sendToApp)
{
	var router = {
		g: sendToApp,
		h: undefined
	};

	var onEffects = info.c;
	var onSelfMsg = info.d;
	var cmdMap = info.e;
	var subMap = info.f;

	function loop(state)
	{
		return A2(_Scheduler_andThen, loop, _Scheduler_receive(function(msg)
		{
			var value = msg.a;

			if (msg.$ === 0)
			{
				return A3(onSelfMsg, router, value, state);
			}

			return cmdMap && subMap
				? A4(onEffects, router, value.i, value.j, state)
				: A3(onEffects, router, cmdMap ? value.i : value.j, state);
		}));
	}

	return router.h = _Scheduler_rawSpawn(A2(_Scheduler_andThen, loop, info.b));
}



// ROUTING


var _Platform_sendToApp = F2(function(router, msg)
{
	return _Scheduler_binding(function(callback)
	{
		router.g(msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});


var _Platform_sendToSelf = F2(function(router, msg)
{
	return A2(_Scheduler_send, router.h, {
		$: 0,
		a: msg
	});
});



// BAGS


function _Platform_leaf(home)
{
	return function(value)
	{
		return {
			$: 1,
			k: home,
			l: value
		};
	};
}


function _Platform_batch(list)
{
	return {
		$: 2,
		m: list
	};
}


var _Platform_map = F2(function(tagger, bag)
{
	return {
		$: 3,
		n: tagger,
		o: bag
	}
});



// PIPE BAGS INTO EFFECT MANAGERS
//
// Effects must be queued!
//
// Say your init contains a synchronous command, like Time.now or Time.here
//
//   - This will produce a batch of effects (FX_1)
//   - The synchronous task triggers the subsequent `update` call
//   - This will produce a batch of effects (FX_2)
//
// If we just start dispatching FX_2, subscriptions from FX_2 can be processed
// before subscriptions from FX_1. No good! Earlier versions of this code had
// this problem, leading to these reports:
//
//   https://github.com/elm/core/issues/980
//   https://github.com/elm/core/pull/981
//   https://github.com/elm/compiler/issues/1776
//
// The queue is necessary to avoid ordering issues for synchronous commands.


// Why use true/false here? Why not just check the length of the queue?
// The goal is to detect "are we currently dispatching effects?" If we
// are, we need to bail and let the ongoing while loop handle things.
//
// Now say the queue has 1 element. When we dequeue the final element,
// the queue will be empty, but we are still actively dispatching effects.
// So you could get queue jumping in a really tricky category of cases.
//
var _Platform_effectsQueue = [];
var _Platform_effectsActive = false;


function _Platform_enqueueEffects(managers, cmdBag, subBag)
{
	_Platform_effectsQueue.push({ p: managers, q: cmdBag, r: subBag });

	if (_Platform_effectsActive) return;

	_Platform_effectsActive = true;
	for (var fx; fx = _Platform_effectsQueue.shift(); )
	{
		_Platform_dispatchEffects(fx.p, fx.q, fx.r);
	}
	_Platform_effectsActive = false;
}


function _Platform_dispatchEffects(managers, cmdBag, subBag)
{
	var effectsDict = {};
	_Platform_gatherEffects(true, cmdBag, effectsDict, null);
	_Platform_gatherEffects(false, subBag, effectsDict, null);

	for (var home in managers)
	{
		_Scheduler_rawSend(managers[home], {
			$: 'fx',
			a: effectsDict[home] || { i: _List_Nil, j: _List_Nil }
		});
	}
}


function _Platform_gatherEffects(isCmd, bag, effectsDict, taggers)
{
	switch (bag.$)
	{
		case 1:
			var home = bag.k;
			var effect = _Platform_toEffect(isCmd, home, taggers, bag.l);
			effectsDict[home] = _Platform_insert(isCmd, effect, effectsDict[home]);
			return;

		case 2:
			for (var list = bag.m; list.b; list = list.b) // WHILE_CONS
			{
				_Platform_gatherEffects(isCmd, list.a, effectsDict, taggers);
			}
			return;

		case 3:
			_Platform_gatherEffects(isCmd, bag.o, effectsDict, {
				s: bag.n,
				t: taggers
			});
			return;
	}
}


function _Platform_toEffect(isCmd, home, taggers, value)
{
	function applyTaggers(x)
	{
		for (var temp = taggers; temp; temp = temp.t)
		{
			x = temp.s(x);
		}
		return x;
	}

	var map = isCmd
		? _Platform_effectManagers[home].e
		: _Platform_effectManagers[home].f;

	return A2(map, applyTaggers, value)
}


function _Platform_insert(isCmd, newEffect, effects)
{
	effects = effects || { i: _List_Nil, j: _List_Nil };

	isCmd
		? (effects.i = _List_Cons(newEffect, effects.i))
		: (effects.j = _List_Cons(newEffect, effects.j));

	return effects;
}



// PORTS


function _Platform_checkPortName(name)
{
	if (_Platform_effectManagers[name])
	{
		_Debug_crash(3, name)
	}
}



// OUTGOING PORTS


function _Platform_outgoingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		e: _Platform_outgoingPortMap,
		u: converter,
		a: _Platform_setupOutgoingPort
	};
	return _Platform_leaf(name);
}


var _Platform_outgoingPortMap = F2(function(tagger, value) { return value; });


function _Platform_setupOutgoingPort(name)
{
	var subs = [];
	var converter = _Platform_effectManagers[name].u;

	// CREATE MANAGER

	var init = _Process_sleep(0);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, cmdList, state)
	{
		for ( ; cmdList.b; cmdList = cmdList.b) // WHILE_CONS
		{
			// grab a separate reference to subs in case unsubscribe is called
			var currentSubs = subs;
			var value = _Json_unwrap(converter(cmdList.a));
			for (var i = 0; i < currentSubs.length; i++)
			{
				currentSubs[i](value);
			}
		}
		return init;
	});

	// PUBLIC API

	function subscribe(callback)
	{
		subs.push(callback);
	}

	function unsubscribe(callback)
	{
		// copy subs into a new array in case unsubscribe is called within a
		// subscribed callback
		subs = subs.slice();
		var index = subs.indexOf(callback);
		if (index >= 0)
		{
			subs.splice(index, 1);
		}
	}

	return {
		subscribe: subscribe,
		unsubscribe: unsubscribe
	};
}



// INCOMING PORTS


function _Platform_incomingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		f: _Platform_incomingPortMap,
		u: converter,
		a: _Platform_setupIncomingPort
	};
	return _Platform_leaf(name);
}


var _Platform_incomingPortMap = F2(function(tagger, finalTagger)
{
	return function(value)
	{
		return tagger(finalTagger(value));
	};
});


function _Platform_setupIncomingPort(name, sendToApp)
{
	var subs = _List_Nil;
	var converter = _Platform_effectManagers[name].u;

	// CREATE MANAGER

	var init = _Scheduler_succeed(null);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, subList, state)
	{
		subs = subList;
		return init;
	});

	// PUBLIC API

	function send(incomingValue)
	{
		var result = A2(_Json_run, converter, _Json_wrap(incomingValue));

		$elm$core$Result$isOk(result) || _Debug_crash(4, name, result.a);

		var value = result.a;
		for (var temp = subs; temp.b; temp = temp.b) // WHILE_CONS
		{
			sendToApp(temp.a(value));
		}
	}

	return { send: send };
}



// EXPORT ELM MODULES
//
// Have DEBUG and PROD versions so that we can (1) give nicer errors in
// debug mode and (2) not pay for the bits needed for that in prod mode.
//


function _Platform_export_UNUSED(exports)
{
	scope['Elm']
		? _Platform_mergeExportsProd(scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsProd(obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6)
				: _Platform_mergeExportsProd(obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}


function _Platform_export(exports)
{
	scope['Elm']
		? _Platform_mergeExportsDebug('Elm', scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsDebug(moduleName, obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6, moduleName)
				: _Platform_mergeExportsDebug(moduleName + '.' + name, obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}




// HELPERS


var _VirtualDom_divertHrefToApp;

var _VirtualDom_doc = typeof document !== 'undefined' ? document : {};


function _VirtualDom_appendChild(parent, child)
{
	parent.appendChild(child);
}

var _VirtualDom_init = F4(function(virtualNode, flagDecoder, debugMetadata, args)
{
	// NOTE: this function needs _Platform_export available to work

	/**_UNUSED/
	var node = args['node'];
	//*/
	/**/
	var node = args && args['node'] ? args['node'] : _Debug_crash(0);
	//*/

	node.parentNode.replaceChild(
		_VirtualDom_render(virtualNode, function() {}),
		node
	);

	return {};
});



// TEXT


function _VirtualDom_text(string)
{
	return {
		$: 0,
		a: string
	};
}



// NODE


var _VirtualDom_nodeNS = F2(function(namespace, tag)
{
	return F2(function(factList, kidList)
	{
		for (var kids = [], descendantsCount = 0; kidList.b; kidList = kidList.b) // WHILE_CONS
		{
			var kid = kidList.a;
			descendantsCount += (kid.b || 0);
			kids.push(kid);
		}
		descendantsCount += kids.length;

		return {
			$: 1,
			c: tag,
			d: _VirtualDom_organizeFacts(factList),
			e: kids,
			f: namespace,
			b: descendantsCount
		};
	});
});


var _VirtualDom_node = _VirtualDom_nodeNS(undefined);



// KEYED NODE


var _VirtualDom_keyedNodeNS = F2(function(namespace, tag)
{
	return F2(function(factList, kidList)
	{
		for (var kids = [], descendantsCount = 0; kidList.b; kidList = kidList.b) // WHILE_CONS
		{
			var kid = kidList.a;
			descendantsCount += (kid.b.b || 0);
			kids.push(kid);
		}
		descendantsCount += kids.length;

		return {
			$: 2,
			c: tag,
			d: _VirtualDom_organizeFacts(factList),
			e: kids,
			f: namespace,
			b: descendantsCount
		};
	});
});


var _VirtualDom_keyedNode = _VirtualDom_keyedNodeNS(undefined);



// CUSTOM


function _VirtualDom_custom(factList, model, render, diff)
{
	return {
		$: 3,
		d: _VirtualDom_organizeFacts(factList),
		g: model,
		h: render,
		i: diff
	};
}



// MAP


var _VirtualDom_map = F2(function(tagger, node)
{
	return {
		$: 4,
		j: tagger,
		k: node,
		b: 1 + (node.b || 0)
	};
});



// LAZY


function _VirtualDom_thunk(refs, thunk)
{
	return {
		$: 5,
		l: refs,
		m: thunk,
		k: undefined
	};
}

var _VirtualDom_lazy = F2(function(func, a)
{
	return _VirtualDom_thunk([func, a], function() {
		return func(a);
	});
});

var _VirtualDom_lazy2 = F3(function(func, a, b)
{
	return _VirtualDom_thunk([func, a, b], function() {
		return A2(func, a, b);
	});
});

var _VirtualDom_lazy3 = F4(function(func, a, b, c)
{
	return _VirtualDom_thunk([func, a, b, c], function() {
		return A3(func, a, b, c);
	});
});

var _VirtualDom_lazy4 = F5(function(func, a, b, c, d)
{
	return _VirtualDom_thunk([func, a, b, c, d], function() {
		return A4(func, a, b, c, d);
	});
});

var _VirtualDom_lazy5 = F6(function(func, a, b, c, d, e)
{
	return _VirtualDom_thunk([func, a, b, c, d, e], function() {
		return A5(func, a, b, c, d, e);
	});
});

var _VirtualDom_lazy6 = F7(function(func, a, b, c, d, e, f)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f], function() {
		return A6(func, a, b, c, d, e, f);
	});
});

var _VirtualDom_lazy7 = F8(function(func, a, b, c, d, e, f, g)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f, g], function() {
		return A7(func, a, b, c, d, e, f, g);
	});
});

var _VirtualDom_lazy8 = F9(function(func, a, b, c, d, e, f, g, h)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f, g, h], function() {
		return A8(func, a, b, c, d, e, f, g, h);
	});
});



// FACTS


var _VirtualDom_on = F2(function(key, handler)
{
	return {
		$: 'a0',
		n: key,
		o: handler
	};
});
var _VirtualDom_style = F2(function(key, value)
{
	return {
		$: 'a1',
		n: key,
		o: value
	};
});
var _VirtualDom_property = F2(function(key, value)
{
	return {
		$: 'a2',
		n: key,
		o: value
	};
});
var _VirtualDom_attribute = F2(function(key, value)
{
	return {
		$: 'a3',
		n: key,
		o: value
	};
});
var _VirtualDom_attributeNS = F3(function(namespace, key, value)
{
	return {
		$: 'a4',
		n: key,
		o: { f: namespace, o: value }
	};
});



// XSS ATTACK VECTOR CHECKS
//
// For some reason, tabs can appear in href protocols and it still works.
// So '\tjava\tSCRIPT:alert("!!!")' and 'javascript:alert("!!!")' are the same
// in practice. That is why _VirtualDom_RE_js and _VirtualDom_RE_js_html look
// so freaky.
//
// Pulling the regular expressions out to the top level gives a slight speed
// boost in small benchmarks (4-10%) but hoisting values to reduce allocation
// can be unpredictable in large programs where JIT may have a harder time with
// functions are not fully self-contained. The benefit is more that the js and
// js_html ones are so weird that I prefer to see them near each other.


var _VirtualDom_RE_script = /^script$/i;
var _VirtualDom_RE_on_formAction = /^(on|formAction$)/i;
var _VirtualDom_RE_js = /^\s*j\s*a\s*v\s*a\s*s\s*c\s*r\s*i\s*p\s*t\s*:/i;
var _VirtualDom_RE_js_html = /^\s*(j\s*a\s*v\s*a\s*s\s*c\s*r\s*i\s*p\s*t\s*:|d\s*a\s*t\s*a\s*:\s*t\s*e\s*x\s*t\s*\/\s*h\s*t\s*m\s*l\s*(,|;))/i;


function _VirtualDom_noScript(tag)
{
	return _VirtualDom_RE_script.test(tag) ? 'p' : tag;
}

function _VirtualDom_noOnOrFormAction(key)
{
	return _VirtualDom_RE_on_formAction.test(key) ? 'data-' + key : key;
}

function _VirtualDom_noInnerHtmlOrFormAction(key)
{
	return key == 'innerHTML' || key == 'formAction' ? 'data-' + key : key;
}

function _VirtualDom_noJavaScriptUri(value)
{
	return _VirtualDom_RE_js.test(value)
		? /**_UNUSED/''//*//**/'javascript:alert("This is an XSS vector. Please use ports or web components instead.")'//*/
		: value;
}

function _VirtualDom_noJavaScriptOrHtmlUri(value)
{
	return _VirtualDom_RE_js_html.test(value)
		? /**_UNUSED/''//*//**/'javascript:alert("This is an XSS vector. Please use ports or web components instead.")'//*/
		: value;
}

function _VirtualDom_noJavaScriptOrHtmlJson(value)
{
	return (typeof _Json_unwrap(value) === 'string' && _VirtualDom_RE_js_html.test(_Json_unwrap(value)))
		? _Json_wrap(
			/**_UNUSED/''//*//**/'javascript:alert("This is an XSS vector. Please use ports or web components instead.")'//*/
		) : value;
}



// MAP FACTS


var _VirtualDom_mapAttribute = F2(function(func, attr)
{
	return (attr.$ === 'a0')
		? A2(_VirtualDom_on, attr.n, _VirtualDom_mapHandler(func, attr.o))
		: attr;
});

function _VirtualDom_mapHandler(func, handler)
{
	var tag = $elm$virtual_dom$VirtualDom$toHandlerInt(handler);

	// 0 = Normal
	// 1 = MayStopPropagation
	// 2 = MayPreventDefault
	// 3 = Custom

	return {
		$: handler.$,
		a:
			!tag
				? A2($elm$json$Json$Decode$map, func, handler.a)
				:
			A3($elm$json$Json$Decode$map2,
				tag < 3
					? _VirtualDom_mapEventTuple
					: _VirtualDom_mapEventRecord,
				$elm$json$Json$Decode$succeed(func),
				handler.a
			)
	};
}

var _VirtualDom_mapEventTuple = F2(function(func, tuple)
{
	return _Utils_Tuple2(func(tuple.a), tuple.b);
});

var _VirtualDom_mapEventRecord = F2(function(func, record)
{
	return {
		message: func(record.message),
		stopPropagation: record.stopPropagation,
		preventDefault: record.preventDefault
	}
});



// ORGANIZE FACTS


function _VirtualDom_organizeFacts(factList)
{
	for (var facts = {}; factList.b; factList = factList.b) // WHILE_CONS
	{
		var entry = factList.a;

		var tag = entry.$;
		var key = entry.n;
		var value = entry.o;

		if (tag === 'a2')
		{
			(key === 'className')
				? _VirtualDom_addClass(facts, key, _Json_unwrap(value))
				: facts[key] = _Json_unwrap(value);

			continue;
		}

		var subFacts = facts[tag] || (facts[tag] = {});
		(tag === 'a3' && key === 'class')
			? _VirtualDom_addClass(subFacts, key, value)
			: subFacts[key] = value;
	}

	return facts;
}

function _VirtualDom_addClass(object, key, newClass)
{
	var classes = object[key];
	object[key] = classes ? classes + ' ' + newClass : newClass;
}



// RENDER


function _VirtualDom_render(vNode, eventNode)
{
	var tag = vNode.$;

	if (tag === 5)
	{
		return _VirtualDom_render(vNode.k || (vNode.k = vNode.m()), eventNode);
	}

	if (tag === 0)
	{
		return _VirtualDom_doc.createTextNode(vNode.a);
	}

	if (tag === 4)
	{
		var subNode = vNode.k;
		var tagger = vNode.j;

		while (subNode.$ === 4)
		{
			typeof tagger !== 'object'
				? tagger = [tagger, subNode.j]
				: tagger.push(subNode.j);

			subNode = subNode.k;
		}

		var subEventRoot = { j: tagger, p: eventNode };
		var domNode = _VirtualDom_render(subNode, subEventRoot);
		domNode.elm_event_node_ref = subEventRoot;
		return domNode;
	}

	if (tag === 3)
	{
		var domNode = vNode.h(vNode.g);
		_VirtualDom_applyFacts(domNode, eventNode, vNode.d);
		return domNode;
	}

	// at this point `tag` must be 1 or 2

	var domNode = vNode.f
		? _VirtualDom_doc.createElementNS(vNode.f, vNode.c)
		: _VirtualDom_doc.createElement(vNode.c);

	if (_VirtualDom_divertHrefToApp && vNode.c == 'a')
	{
		domNode.addEventListener('click', _VirtualDom_divertHrefToApp(domNode));
	}

	_VirtualDom_applyFacts(domNode, eventNode, vNode.d);

	for (var kids = vNode.e, i = 0; i < kids.length; i++)
	{
		_VirtualDom_appendChild(domNode, _VirtualDom_render(tag === 1 ? kids[i] : kids[i].b, eventNode));
	}

	return domNode;
}



// APPLY FACTS


function _VirtualDom_applyFacts(domNode, eventNode, facts)
{
	for (var key in facts)
	{
		var value = facts[key];

		key === 'a1'
			? _VirtualDom_applyStyles(domNode, value)
			:
		key === 'a0'
			? _VirtualDom_applyEvents(domNode, eventNode, value)
			:
		key === 'a3'
			? _VirtualDom_applyAttrs(domNode, value)
			:
		key === 'a4'
			? _VirtualDom_applyAttrsNS(domNode, value)
			:
		((key !== 'value' && key !== 'checked') || domNode[key] !== value) && (domNode[key] = value);
	}
}



// APPLY STYLES


function _VirtualDom_applyStyles(domNode, styles)
{
	var domNodeStyle = domNode.style;

	for (var key in styles)
	{
		domNodeStyle[key] = styles[key];
	}
}



// APPLY ATTRS


function _VirtualDom_applyAttrs(domNode, attrs)
{
	for (var key in attrs)
	{
		var value = attrs[key];
		typeof value !== 'undefined'
			? domNode.setAttribute(key, value)
			: domNode.removeAttribute(key);
	}
}



// APPLY NAMESPACED ATTRS


function _VirtualDom_applyAttrsNS(domNode, nsAttrs)
{
	for (var key in nsAttrs)
	{
		var pair = nsAttrs[key];
		var namespace = pair.f;
		var value = pair.o;

		typeof value !== 'undefined'
			? domNode.setAttributeNS(namespace, key, value)
			: domNode.removeAttributeNS(namespace, key);
	}
}



// APPLY EVENTS


function _VirtualDom_applyEvents(domNode, eventNode, events)
{
	var allCallbacks = domNode.elmFs || (domNode.elmFs = {});

	for (var key in events)
	{
		var newHandler = events[key];
		var oldCallback = allCallbacks[key];

		if (!newHandler)
		{
			domNode.removeEventListener(key, oldCallback);
			allCallbacks[key] = undefined;
			continue;
		}

		if (oldCallback)
		{
			var oldHandler = oldCallback.q;
			if (oldHandler.$ === newHandler.$)
			{
				oldCallback.q = newHandler;
				continue;
			}
			domNode.removeEventListener(key, oldCallback);
		}

		oldCallback = _VirtualDom_makeCallback(eventNode, newHandler);
		domNode.addEventListener(key, oldCallback,
			_VirtualDom_passiveSupported
			&& { passive: $elm$virtual_dom$VirtualDom$toHandlerInt(newHandler) < 2 }
		);
		allCallbacks[key] = oldCallback;
	}
}



// PASSIVE EVENTS


var _VirtualDom_passiveSupported;

try
{
	window.addEventListener('t', null, Object.defineProperty({}, 'passive', {
		get: function() { _VirtualDom_passiveSupported = true; }
	}));
}
catch(e) {}



// EVENT HANDLERS


function _VirtualDom_makeCallback(eventNode, initialHandler)
{
	function callback(event)
	{
		var handler = callback.q;
		var result = _Json_runHelp(handler.a, event);

		if (!$elm$core$Result$isOk(result))
		{
			return;
		}

		var tag = $elm$virtual_dom$VirtualDom$toHandlerInt(handler);

		// 0 = Normal
		// 1 = MayStopPropagation
		// 2 = MayPreventDefault
		// 3 = Custom

		var value = result.a;
		var message = !tag ? value : tag < 3 ? value.a : value.message;
		var stopPropagation = tag == 1 ? value.b : tag == 3 && value.stopPropagation;
		var currentEventNode = (
			stopPropagation && event.stopPropagation(),
			(tag == 2 ? value.b : tag == 3 && value.preventDefault) && event.preventDefault(),
			eventNode
		);
		var tagger;
		var i;
		while (tagger = currentEventNode.j)
		{
			if (typeof tagger == 'function')
			{
				message = tagger(message);
			}
			else
			{
				for (var i = tagger.length; i--; )
				{
					message = tagger[i](message);
				}
			}
			currentEventNode = currentEventNode.p;
		}
		currentEventNode(message, stopPropagation); // stopPropagation implies isSync
	}

	callback.q = initialHandler;

	return callback;
}

function _VirtualDom_equalEvents(x, y)
{
	return x.$ == y.$ && _Json_equality(x.a, y.a);
}



// DIFF


// TODO: Should we do patches like in iOS?
//
// type Patch
//   = At Int Patch
//   | Batch (List Patch)
//   | Change ...
//
// How could it not be better?
//
function _VirtualDom_diff(x, y)
{
	var patches = [];
	_VirtualDom_diffHelp(x, y, patches, 0);
	return patches;
}


function _VirtualDom_pushPatch(patches, type, index, data)
{
	var patch = {
		$: type,
		r: index,
		s: data,
		t: undefined,
		u: undefined
	};
	patches.push(patch);
	return patch;
}


function _VirtualDom_diffHelp(x, y, patches, index)
{
	if (x === y)
	{
		return;
	}

	var xType = x.$;
	var yType = y.$;

	// Bail if you run into different types of nodes. Implies that the
	// structure has changed significantly and it's not worth a diff.
	if (xType !== yType)
	{
		if (xType === 1 && yType === 2)
		{
			y = _VirtualDom_dekey(y);
			yType = 1;
		}
		else
		{
			_VirtualDom_pushPatch(patches, 0, index, y);
			return;
		}
	}

	// Now we know that both nodes are the same $.
	switch (yType)
	{
		case 5:
			var xRefs = x.l;
			var yRefs = y.l;
			var i = xRefs.length;
			var same = i === yRefs.length;
			while (same && i--)
			{
				same = xRefs[i] === yRefs[i];
			}
			if (same)
			{
				y.k = x.k;
				return;
			}
			y.k = y.m();
			var subPatches = [];
			_VirtualDom_diffHelp(x.k, y.k, subPatches, 0);
			subPatches.length > 0 && _VirtualDom_pushPatch(patches, 1, index, subPatches);
			return;

		case 4:
			// gather nested taggers
			var xTaggers = x.j;
			var yTaggers = y.j;
			var nesting = false;

			var xSubNode = x.k;
			while (xSubNode.$ === 4)
			{
				nesting = true;

				typeof xTaggers !== 'object'
					? xTaggers = [xTaggers, xSubNode.j]
					: xTaggers.push(xSubNode.j);

				xSubNode = xSubNode.k;
			}

			var ySubNode = y.k;
			while (ySubNode.$ === 4)
			{
				nesting = true;

				typeof yTaggers !== 'object'
					? yTaggers = [yTaggers, ySubNode.j]
					: yTaggers.push(ySubNode.j);

				ySubNode = ySubNode.k;
			}

			// Just bail if different numbers of taggers. This implies the
			// structure of the virtual DOM has changed.
			if (nesting && xTaggers.length !== yTaggers.length)
			{
				_VirtualDom_pushPatch(patches, 0, index, y);
				return;
			}

			// check if taggers are "the same"
			if (nesting ? !_VirtualDom_pairwiseRefEqual(xTaggers, yTaggers) : xTaggers !== yTaggers)
			{
				_VirtualDom_pushPatch(patches, 2, index, yTaggers);
			}

			// diff everything below the taggers
			_VirtualDom_diffHelp(xSubNode, ySubNode, patches, index + 1);
			return;

		case 0:
			if (x.a !== y.a)
			{
				_VirtualDom_pushPatch(patches, 3, index, y.a);
			}
			return;

		case 1:
			_VirtualDom_diffNodes(x, y, patches, index, _VirtualDom_diffKids);
			return;

		case 2:
			_VirtualDom_diffNodes(x, y, patches, index, _VirtualDom_diffKeyedKids);
			return;

		case 3:
			if (x.h !== y.h)
			{
				_VirtualDom_pushPatch(patches, 0, index, y);
				return;
			}

			var factsDiff = _VirtualDom_diffFacts(x.d, y.d);
			factsDiff && _VirtualDom_pushPatch(patches, 4, index, factsDiff);

			var patch = y.i(x.g, y.g);
			patch && _VirtualDom_pushPatch(patches, 5, index, patch);

			return;
	}
}

// assumes the incoming arrays are the same length
function _VirtualDom_pairwiseRefEqual(as, bs)
{
	for (var i = 0; i < as.length; i++)
	{
		if (as[i] !== bs[i])
		{
			return false;
		}
	}

	return true;
}

function _VirtualDom_diffNodes(x, y, patches, index, diffKids)
{
	// Bail if obvious indicators have changed. Implies more serious
	// structural changes such that it's not worth it to diff.
	if (x.c !== y.c || x.f !== y.f)
	{
		_VirtualDom_pushPatch(patches, 0, index, y);
		return;
	}

	var factsDiff = _VirtualDom_diffFacts(x.d, y.d);
	factsDiff && _VirtualDom_pushPatch(patches, 4, index, factsDiff);

	diffKids(x, y, patches, index);
}



// DIFF FACTS


// TODO Instead of creating a new diff object, it's possible to just test if
// there *is* a diff. During the actual patch, do the diff again and make the
// modifications directly. This way, there's no new allocations. Worth it?
function _VirtualDom_diffFacts(x, y, category)
{
	var diff;

	// look for changes and removals
	for (var xKey in x)
	{
		if (xKey === 'a1' || xKey === 'a0' || xKey === 'a3' || xKey === 'a4')
		{
			var subDiff = _VirtualDom_diffFacts(x[xKey], y[xKey] || {}, xKey);
			if (subDiff)
			{
				diff = diff || {};
				diff[xKey] = subDiff;
			}
			continue;
		}

		// remove if not in the new facts
		if (!(xKey in y))
		{
			diff = diff || {};
			diff[xKey] =
				!category
					? (typeof x[xKey] === 'string' ? '' : null)
					:
				(category === 'a1')
					? ''
					:
				(category === 'a0' || category === 'a3')
					? undefined
					:
				{ f: x[xKey].f, o: undefined };

			continue;
		}

		var xValue = x[xKey];
		var yValue = y[xKey];

		// reference equal, so don't worry about it
		if (xValue === yValue && xKey !== 'value' && xKey !== 'checked'
			|| category === 'a0' && _VirtualDom_equalEvents(xValue, yValue))
		{
			continue;
		}

		diff = diff || {};
		diff[xKey] = yValue;
	}

	// add new stuff
	for (var yKey in y)
	{
		if (!(yKey in x))
		{
			diff = diff || {};
			diff[yKey] = y[yKey];
		}
	}

	return diff;
}



// DIFF KIDS


function _VirtualDom_diffKids(xParent, yParent, patches, index)
{
	var xKids = xParent.e;
	var yKids = yParent.e;

	var xLen = xKids.length;
	var yLen = yKids.length;

	// FIGURE OUT IF THERE ARE INSERTS OR REMOVALS

	if (xLen > yLen)
	{
		_VirtualDom_pushPatch(patches, 6, index, {
			v: yLen,
			i: xLen - yLen
		});
	}
	else if (xLen < yLen)
	{
		_VirtualDom_pushPatch(patches, 7, index, {
			v: xLen,
			e: yKids
		});
	}

	// PAIRWISE DIFF EVERYTHING ELSE

	for (var minLen = xLen < yLen ? xLen : yLen, i = 0; i < minLen; i++)
	{
		var xKid = xKids[i];
		_VirtualDom_diffHelp(xKid, yKids[i], patches, ++index);
		index += xKid.b || 0;
	}
}



// KEYED DIFF


function _VirtualDom_diffKeyedKids(xParent, yParent, patches, rootIndex)
{
	var localPatches = [];

	var changes = {}; // Dict String Entry
	var inserts = []; // Array { index : Int, entry : Entry }
	// type Entry = { tag : String, vnode : VNode, index : Int, data : _ }

	var xKids = xParent.e;
	var yKids = yParent.e;
	var xLen = xKids.length;
	var yLen = yKids.length;
	var xIndex = 0;
	var yIndex = 0;

	var index = rootIndex;

	while (xIndex < xLen && yIndex < yLen)
	{
		var x = xKids[xIndex];
		var y = yKids[yIndex];

		var xKey = x.a;
		var yKey = y.a;
		var xNode = x.b;
		var yNode = y.b;

		var newMatch = undefined;
		var oldMatch = undefined;

		// check if keys match

		if (xKey === yKey)
		{
			index++;
			_VirtualDom_diffHelp(xNode, yNode, localPatches, index);
			index += xNode.b || 0;

			xIndex++;
			yIndex++;
			continue;
		}

		// look ahead 1 to detect insertions and removals.

		var xNext = xKids[xIndex + 1];
		var yNext = yKids[yIndex + 1];

		if (xNext)
		{
			var xNextKey = xNext.a;
			var xNextNode = xNext.b;
			oldMatch = yKey === xNextKey;
		}

		if (yNext)
		{
			var yNextKey = yNext.a;
			var yNextNode = yNext.b;
			newMatch = xKey === yNextKey;
		}


		// swap x and y
		if (newMatch && oldMatch)
		{
			index++;
			_VirtualDom_diffHelp(xNode, yNextNode, localPatches, index);
			_VirtualDom_insertNode(changes, localPatches, xKey, yNode, yIndex, inserts);
			index += xNode.b || 0;

			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNextNode, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 2;
			continue;
		}

		// insert y
		if (newMatch)
		{
			index++;
			_VirtualDom_insertNode(changes, localPatches, yKey, yNode, yIndex, inserts);
			_VirtualDom_diffHelp(xNode, yNextNode, localPatches, index);
			index += xNode.b || 0;

			xIndex += 1;
			yIndex += 2;
			continue;
		}

		// remove x
		if (oldMatch)
		{
			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNode, index);
			index += xNode.b || 0;

			index++;
			_VirtualDom_diffHelp(xNextNode, yNode, localPatches, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 1;
			continue;
		}

		// remove x, insert y
		if (xNext && xNextKey === yNextKey)
		{
			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNode, index);
			_VirtualDom_insertNode(changes, localPatches, yKey, yNode, yIndex, inserts);
			index += xNode.b || 0;

			index++;
			_VirtualDom_diffHelp(xNextNode, yNextNode, localPatches, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 2;
			continue;
		}

		break;
	}

	// eat up any remaining nodes with removeNode and insertNode

	while (xIndex < xLen)
	{
		index++;
		var x = xKids[xIndex];
		var xNode = x.b;
		_VirtualDom_removeNode(changes, localPatches, x.a, xNode, index);
		index += xNode.b || 0;
		xIndex++;
	}

	while (yIndex < yLen)
	{
		var endInserts = endInserts || [];
		var y = yKids[yIndex];
		_VirtualDom_insertNode(changes, localPatches, y.a, y.b, undefined, endInserts);
		yIndex++;
	}

	if (localPatches.length > 0 || inserts.length > 0 || endInserts)
	{
		_VirtualDom_pushPatch(patches, 8, rootIndex, {
			w: localPatches,
			x: inserts,
			y: endInserts
		});
	}
}



// CHANGES FROM KEYED DIFF


var _VirtualDom_POSTFIX = '_elmW6BL';


function _VirtualDom_insertNode(changes, localPatches, key, vnode, yIndex, inserts)
{
	var entry = changes[key];

	// never seen this key before
	if (!entry)
	{
		entry = {
			c: 0,
			z: vnode,
			r: yIndex,
			s: undefined
		};

		inserts.push({ r: yIndex, A: entry });
		changes[key] = entry;

		return;
	}

	// this key was removed earlier, a match!
	if (entry.c === 1)
	{
		inserts.push({ r: yIndex, A: entry });

		entry.c = 2;
		var subPatches = [];
		_VirtualDom_diffHelp(entry.z, vnode, subPatches, entry.r);
		entry.r = yIndex;
		entry.s.s = {
			w: subPatches,
			A: entry
		};

		return;
	}

	// this key has already been inserted or moved, a duplicate!
	_VirtualDom_insertNode(changes, localPatches, key + _VirtualDom_POSTFIX, vnode, yIndex, inserts);
}


function _VirtualDom_removeNode(changes, localPatches, key, vnode, index)
{
	var entry = changes[key];

	// never seen this key before
	if (!entry)
	{
		var patch = _VirtualDom_pushPatch(localPatches, 9, index, undefined);

		changes[key] = {
			c: 1,
			z: vnode,
			r: index,
			s: patch
		};

		return;
	}

	// this key was inserted earlier, a match!
	if (entry.c === 0)
	{
		entry.c = 2;
		var subPatches = [];
		_VirtualDom_diffHelp(vnode, entry.z, subPatches, index);

		_VirtualDom_pushPatch(localPatches, 9, index, {
			w: subPatches,
			A: entry
		});

		return;
	}

	// this key has already been removed or moved, a duplicate!
	_VirtualDom_removeNode(changes, localPatches, key + _VirtualDom_POSTFIX, vnode, index);
}



// ADD DOM NODES
//
// Each DOM node has an "index" assigned in order of traversal. It is important
// to minimize our crawl over the actual DOM, so these indexes (along with the
// descendantsCount of virtual nodes) let us skip touching entire subtrees of
// the DOM if we know there are no patches there.


function _VirtualDom_addDomNodes(domNode, vNode, patches, eventNode)
{
	_VirtualDom_addDomNodesHelp(domNode, vNode, patches, 0, 0, vNode.b, eventNode);
}


// assumes `patches` is non-empty and indexes increase monotonically.
function _VirtualDom_addDomNodesHelp(domNode, vNode, patches, i, low, high, eventNode)
{
	var patch = patches[i];
	var index = patch.r;

	while (index === low)
	{
		var patchType = patch.$;

		if (patchType === 1)
		{
			_VirtualDom_addDomNodes(domNode, vNode.k, patch.s, eventNode);
		}
		else if (patchType === 8)
		{
			patch.t = domNode;
			patch.u = eventNode;

			var subPatches = patch.s.w;
			if (subPatches.length > 0)
			{
				_VirtualDom_addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
			}
		}
		else if (patchType === 9)
		{
			patch.t = domNode;
			patch.u = eventNode;

			var data = patch.s;
			if (data)
			{
				data.A.s = domNode;
				var subPatches = data.w;
				if (subPatches.length > 0)
				{
					_VirtualDom_addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
				}
			}
		}
		else
		{
			patch.t = domNode;
			patch.u = eventNode;
		}

		i++;

		if (!(patch = patches[i]) || (index = patch.r) > high)
		{
			return i;
		}
	}

	var tag = vNode.$;

	if (tag === 4)
	{
		var subNode = vNode.k;

		while (subNode.$ === 4)
		{
			subNode = subNode.k;
		}

		return _VirtualDom_addDomNodesHelp(domNode, subNode, patches, i, low + 1, high, domNode.elm_event_node_ref);
	}

	// tag must be 1 or 2 at this point

	var vKids = vNode.e;
	var childNodes = domNode.childNodes;
	for (var j = 0; j < vKids.length; j++)
	{
		low++;
		var vKid = tag === 1 ? vKids[j] : vKids[j].b;
		var nextLow = low + (vKid.b || 0);
		if (low <= index && index <= nextLow)
		{
			i = _VirtualDom_addDomNodesHelp(childNodes[j], vKid, patches, i, low, nextLow, eventNode);
			if (!(patch = patches[i]) || (index = patch.r) > high)
			{
				return i;
			}
		}
		low = nextLow;
	}
	return i;
}



// APPLY PATCHES


function _VirtualDom_applyPatches(rootDomNode, oldVirtualNode, patches, eventNode)
{
	if (patches.length === 0)
	{
		return rootDomNode;
	}

	_VirtualDom_addDomNodes(rootDomNode, oldVirtualNode, patches, eventNode);
	return _VirtualDom_applyPatchesHelp(rootDomNode, patches);
}

function _VirtualDom_applyPatchesHelp(rootDomNode, patches)
{
	for (var i = 0; i < patches.length; i++)
	{
		var patch = patches[i];
		var localDomNode = patch.t
		var newNode = _VirtualDom_applyPatch(localDomNode, patch);
		if (localDomNode === rootDomNode)
		{
			rootDomNode = newNode;
		}
	}
	return rootDomNode;
}

function _VirtualDom_applyPatch(domNode, patch)
{
	switch (patch.$)
	{
		case 0:
			return _VirtualDom_applyPatchRedraw(domNode, patch.s, patch.u);

		case 4:
			_VirtualDom_applyFacts(domNode, patch.u, patch.s);
			return domNode;

		case 3:
			domNode.replaceData(0, domNode.length, patch.s);
			return domNode;

		case 1:
			return _VirtualDom_applyPatchesHelp(domNode, patch.s);

		case 2:
			if (domNode.elm_event_node_ref)
			{
				domNode.elm_event_node_ref.j = patch.s;
			}
			else
			{
				domNode.elm_event_node_ref = { j: patch.s, p: patch.u };
			}
			return domNode;

		case 6:
			var data = patch.s;
			for (var i = 0; i < data.i; i++)
			{
				domNode.removeChild(domNode.childNodes[data.v]);
			}
			return domNode;

		case 7:
			var data = patch.s;
			var kids = data.e;
			var i = data.v;
			var theEnd = domNode.childNodes[i];
			for (; i < kids.length; i++)
			{
				domNode.insertBefore(_VirtualDom_render(kids[i], patch.u), theEnd);
			}
			return domNode;

		case 9:
			var data = patch.s;
			if (!data)
			{
				domNode.parentNode.removeChild(domNode);
				return domNode;
			}
			var entry = data.A;
			if (typeof entry.r !== 'undefined')
			{
				domNode.parentNode.removeChild(domNode);
			}
			entry.s = _VirtualDom_applyPatchesHelp(domNode, data.w);
			return domNode;

		case 8:
			return _VirtualDom_applyPatchReorder(domNode, patch);

		case 5:
			return patch.s(domNode);

		default:
			_Debug_crash(10); // 'Ran into an unknown patch!'
	}
}


function _VirtualDom_applyPatchRedraw(domNode, vNode, eventNode)
{
	var parentNode = domNode.parentNode;
	var newNode = _VirtualDom_render(vNode, eventNode);

	if (!newNode.elm_event_node_ref)
	{
		newNode.elm_event_node_ref = domNode.elm_event_node_ref;
	}

	if (parentNode && newNode !== domNode)
	{
		parentNode.replaceChild(newNode, domNode);
	}
	return newNode;
}


function _VirtualDom_applyPatchReorder(domNode, patch)
{
	var data = patch.s;

	// remove end inserts
	var frag = _VirtualDom_applyPatchReorderEndInsertsHelp(data.y, patch);

	// removals
	domNode = _VirtualDom_applyPatchesHelp(domNode, data.w);

	// inserts
	var inserts = data.x;
	for (var i = 0; i < inserts.length; i++)
	{
		var insert = inserts[i];
		var entry = insert.A;
		var node = entry.c === 2
			? entry.s
			: _VirtualDom_render(entry.z, patch.u);
		domNode.insertBefore(node, domNode.childNodes[insert.r]);
	}

	// add end inserts
	if (frag)
	{
		_VirtualDom_appendChild(domNode, frag);
	}

	return domNode;
}


function _VirtualDom_applyPatchReorderEndInsertsHelp(endInserts, patch)
{
	if (!endInserts)
	{
		return;
	}

	var frag = _VirtualDom_doc.createDocumentFragment();
	for (var i = 0; i < endInserts.length; i++)
	{
		var insert = endInserts[i];
		var entry = insert.A;
		_VirtualDom_appendChild(frag, entry.c === 2
			? entry.s
			: _VirtualDom_render(entry.z, patch.u)
		);
	}
	return frag;
}


function _VirtualDom_virtualize(node)
{
	// TEXT NODES

	if (node.nodeType === 3)
	{
		return _VirtualDom_text(node.textContent);
	}


	// WEIRD NODES

	if (node.nodeType !== 1)
	{
		return _VirtualDom_text('');
	}


	// ELEMENT NODES

	var attrList = _List_Nil;
	var attrs = node.attributes;
	for (var i = attrs.length; i--; )
	{
		var attr = attrs[i];
		var name = attr.name;
		var value = attr.value;
		attrList = _List_Cons( A2(_VirtualDom_attribute, name, value), attrList );
	}

	var tag = node.tagName.toLowerCase();
	var kidList = _List_Nil;
	var kids = node.childNodes;

	for (var i = kids.length; i--; )
	{
		kidList = _List_Cons(_VirtualDom_virtualize(kids[i]), kidList);
	}
	return A3(_VirtualDom_node, tag, attrList, kidList);
}

function _VirtualDom_dekey(keyedNode)
{
	var keyedKids = keyedNode.e;
	var len = keyedKids.length;
	var kids = new Array(len);
	for (var i = 0; i < len; i++)
	{
		kids[i] = keyedKids[i].b;
	}

	return {
		$: 1,
		c: keyedNode.c,
		d: keyedNode.d,
		e: kids,
		f: keyedNode.f,
		b: keyedNode.b
	};
}




// ELEMENT


var _Debugger_element;

var _Browser_element = _Debugger_element || F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function(sendToApp, initialModel) {
			var view = impl.view;
			/**_UNUSED/
			var domNode = args['node'];
			//*/
			/**/
			var domNode = args && args['node'] ? args['node'] : _Debug_crash(0);
			//*/
			var currNode = _VirtualDom_virtualize(domNode);

			return _Browser_makeAnimator(initialModel, function(model)
			{
				var nextNode = view(model);
				var patches = _VirtualDom_diff(currNode, nextNode);
				domNode = _VirtualDom_applyPatches(domNode, currNode, patches, sendToApp);
				currNode = nextNode;
			});
		}
	);
});



// DOCUMENT


var _Debugger_document;

var _Browser_document = _Debugger_document || F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function(sendToApp, initialModel) {
			var divertHrefToApp = impl.setup && impl.setup(sendToApp)
			var view = impl.view;
			var title = _VirtualDom_doc.title;
			var bodyNode = _VirtualDom_doc.body;
			var currNode = _VirtualDom_virtualize(bodyNode);
			return _Browser_makeAnimator(initialModel, function(model)
			{
				_VirtualDom_divertHrefToApp = divertHrefToApp;
				var doc = view(model);
				var nextNode = _VirtualDom_node('body')(_List_Nil)(doc.body);
				var patches = _VirtualDom_diff(currNode, nextNode);
				bodyNode = _VirtualDom_applyPatches(bodyNode, currNode, patches, sendToApp);
				currNode = nextNode;
				_VirtualDom_divertHrefToApp = 0;
				(title !== doc.title) && (_VirtualDom_doc.title = title = doc.title);
			});
		}
	);
});



// ANIMATION


var _Browser_cancelAnimationFrame =
	typeof cancelAnimationFrame !== 'undefined'
		? cancelAnimationFrame
		: function(id) { clearTimeout(id); };

var _Browser_requestAnimationFrame =
	typeof requestAnimationFrame !== 'undefined'
		? requestAnimationFrame
		: function(callback) { return setTimeout(callback, 1000 / 60); };


function _Browser_makeAnimator(model, draw)
{
	draw(model);

	var state = 0;

	function updateIfNeeded()
	{
		state = state === 1
			? 0
			: ( _Browser_requestAnimationFrame(updateIfNeeded), draw(model), 1 );
	}

	return function(nextModel, isSync)
	{
		model = nextModel;

		isSync
			? ( draw(model),
				state === 2 && (state = 1)
				)
			: ( state === 0 && _Browser_requestAnimationFrame(updateIfNeeded),
				state = 2
				);
	};
}



// APPLICATION


function _Browser_application(impl)
{
	var onUrlChange = impl.onUrlChange;
	var onUrlRequest = impl.onUrlRequest;
	var key = function() { key.a(onUrlChange(_Browser_getUrl())); };

	return _Browser_document({
		setup: function(sendToApp)
		{
			key.a = sendToApp;
			_Browser_window.addEventListener('popstate', key);
			_Browser_window.navigator.userAgent.indexOf('Trident') < 0 || _Browser_window.addEventListener('hashchange', key);

			return F2(function(domNode, event)
			{
				if (!event.ctrlKey && !event.metaKey && !event.shiftKey && event.button < 1 && !domNode.target && !domNode.hasAttribute('download'))
				{
					event.preventDefault();
					var href = domNode.href;
					var curr = _Browser_getUrl();
					var next = $elm$url$Url$fromString(href).a;
					sendToApp(onUrlRequest(
						(next
							&& curr.protocol === next.protocol
							&& curr.host === next.host
							&& curr.port_.a === next.port_.a
						)
							? $elm$browser$Browser$Internal(next)
							: $elm$browser$Browser$External(href)
					));
				}
			});
		},
		init: function(flags)
		{
			return A3(impl.init, flags, _Browser_getUrl(), key);
		},
		view: impl.view,
		update: impl.update,
		subscriptions: impl.subscriptions
	});
}

function _Browser_getUrl()
{
	return $elm$url$Url$fromString(_VirtualDom_doc.location.href).a || _Debug_crash(1);
}

var _Browser_go = F2(function(key, n)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function() {
		n && history.go(n);
		key();
	}));
});

var _Browser_pushUrl = F2(function(key, url)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function() {
		history.pushState({}, '', url);
		key();
	}));
});

var _Browser_replaceUrl = F2(function(key, url)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function() {
		history.replaceState({}, '', url);
		key();
	}));
});



// GLOBAL EVENTS


var _Browser_fakeNode = { addEventListener: function() {}, removeEventListener: function() {} };
var _Browser_doc = typeof document !== 'undefined' ? document : _Browser_fakeNode;
var _Browser_window = typeof window !== 'undefined' ? window : _Browser_fakeNode;

var _Browser_on = F3(function(node, eventName, sendToSelf)
{
	return _Scheduler_spawn(_Scheduler_binding(function(callback)
	{
		function handler(event)	{ _Scheduler_rawSpawn(sendToSelf(event)); }
		node.addEventListener(eventName, handler, _VirtualDom_passiveSupported && { passive: true });
		return function() { node.removeEventListener(eventName, handler); };
	}));
});

var _Browser_decodeEvent = F2(function(decoder, event)
{
	var result = _Json_runHelp(decoder, event);
	return $elm$core$Result$isOk(result) ? $elm$core$Maybe$Just(result.a) : $elm$core$Maybe$Nothing;
});



// PAGE VISIBILITY


function _Browser_visibilityInfo()
{
	return (typeof _VirtualDom_doc.hidden !== 'undefined')
		? { hidden: 'hidden', change: 'visibilitychange' }
		:
	(typeof _VirtualDom_doc.mozHidden !== 'undefined')
		? { hidden: 'mozHidden', change: 'mozvisibilitychange' }
		:
	(typeof _VirtualDom_doc.msHidden !== 'undefined')
		? { hidden: 'msHidden', change: 'msvisibilitychange' }
		:
	(typeof _VirtualDom_doc.webkitHidden !== 'undefined')
		? { hidden: 'webkitHidden', change: 'webkitvisibilitychange' }
		: { hidden: 'hidden', change: 'visibilitychange' };
}



// ANIMATION FRAMES


function _Browser_rAF()
{
	return _Scheduler_binding(function(callback)
	{
		var id = _Browser_requestAnimationFrame(function() {
			callback(_Scheduler_succeed(Date.now()));
		});

		return function() {
			_Browser_cancelAnimationFrame(id);
		};
	});
}


function _Browser_now()
{
	return _Scheduler_binding(function(callback)
	{
		callback(_Scheduler_succeed(Date.now()));
	});
}



// DOM STUFF


function _Browser_withNode(id, doStuff)
{
	return _Scheduler_binding(function(callback)
	{
		_Browser_requestAnimationFrame(function() {
			var node = document.getElementById(id);
			callback(node
				? _Scheduler_succeed(doStuff(node))
				: _Scheduler_fail($elm$browser$Browser$Dom$NotFound(id))
			);
		});
	});
}


function _Browser_withWindow(doStuff)
{
	return _Scheduler_binding(function(callback)
	{
		_Browser_requestAnimationFrame(function() {
			callback(_Scheduler_succeed(doStuff()));
		});
	});
}


// FOCUS and BLUR


var _Browser_call = F2(function(functionName, id)
{
	return _Browser_withNode(id, function(node) {
		node[functionName]();
		return _Utils_Tuple0;
	});
});



// WINDOW VIEWPORT


function _Browser_getViewport()
{
	return {
		scene: _Browser_getScene(),
		viewport: {
			x: _Browser_window.pageXOffset,
			y: _Browser_window.pageYOffset,
			width: _Browser_doc.documentElement.clientWidth,
			height: _Browser_doc.documentElement.clientHeight
		}
	};
}

function _Browser_getScene()
{
	var body = _Browser_doc.body;
	var elem = _Browser_doc.documentElement;
	return {
		width: Math.max(body.scrollWidth, body.offsetWidth, elem.scrollWidth, elem.offsetWidth, elem.clientWidth),
		height: Math.max(body.scrollHeight, body.offsetHeight, elem.scrollHeight, elem.offsetHeight, elem.clientHeight)
	};
}

var _Browser_setViewport = F2(function(x, y)
{
	return _Browser_withWindow(function()
	{
		_Browser_window.scroll(x, y);
		return _Utils_Tuple0;
	});
});



// ELEMENT VIEWPORT


function _Browser_getViewportOf(id)
{
	return _Browser_withNode(id, function(node)
	{
		return {
			scene: {
				width: node.scrollWidth,
				height: node.scrollHeight
			},
			viewport: {
				x: node.scrollLeft,
				y: node.scrollTop,
				width: node.clientWidth,
				height: node.clientHeight
			}
		};
	});
}


var _Browser_setViewportOf = F3(function(id, x, y)
{
	return _Browser_withNode(id, function(node)
	{
		node.scrollLeft = x;
		node.scrollTop = y;
		return _Utils_Tuple0;
	});
});



// ELEMENT


function _Browser_getElement(id)
{
	return _Browser_withNode(id, function(node)
	{
		var rect = node.getBoundingClientRect();
		var x = _Browser_window.pageXOffset;
		var y = _Browser_window.pageYOffset;
		return {
			scene: _Browser_getScene(),
			viewport: {
				x: x,
				y: y,
				width: _Browser_doc.documentElement.clientWidth,
				height: _Browser_doc.documentElement.clientHeight
			},
			element: {
				x: x + rect.left,
				y: y + rect.top,
				width: rect.width,
				height: rect.height
			}
		};
	});
}



// LOAD and RELOAD


function _Browser_reload(skipCache)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function(callback)
	{
		_VirtualDom_doc.location.reload(skipCache);
	}));
}

function _Browser_load(url)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function(callback)
	{
		try
		{
			_Browser_window.location = url;
		}
		catch(err)
		{
			// Only Firefox can throw a NS_ERROR_MALFORMED_URI exception here.
			// Other browsers reload the page, so let's be consistent about that.
			_VirtualDom_doc.location.reload(false);
		}
	}));
}


/*
 * Copyright (c) 2010 Mozilla Corporation
 * Copyright (c) 2010 Vladimir Vukicevic
 * Copyright (c) 2013 John Mayer
 * Copyright (c) 2018 Andrey Kuzmin
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

// Vector2

var _MJS_v2 = F2(function(x, y) {
    return new Float64Array([x, y]);
});

var _MJS_v2getX = function(a) {
    return a[0];
};

var _MJS_v2getY = function(a) {
    return a[1];
};

var _MJS_v2setX = F2(function(x, a) {
    return new Float64Array([x, a[1]]);
});

var _MJS_v2setY = F2(function(y, a) {
    return new Float64Array([a[0], y]);
});

var _MJS_v2toRecord = function(a) {
    return { x: a[0], y: a[1] };
};

var _MJS_v2fromRecord = function(r) {
    return new Float64Array([r.x, r.y]);
};

var _MJS_v2add = F2(function(a, b) {
    var r = new Float64Array(2);
    r[0] = a[0] + b[0];
    r[1] = a[1] + b[1];
    return r;
});

var _MJS_v2sub = F2(function(a, b) {
    var r = new Float64Array(2);
    r[0] = a[0] - b[0];
    r[1] = a[1] - b[1];
    return r;
});

var _MJS_v2negate = function(a) {
    var r = new Float64Array(2);
    r[0] = -a[0];
    r[1] = -a[1];
    return r;
};

var _MJS_v2direction = F2(function(a, b) {
    var r = new Float64Array(2);
    r[0] = a[0] - b[0];
    r[1] = a[1] - b[1];
    var im = 1.0 / _MJS_v2lengthLocal(r);
    r[0] = r[0] * im;
    r[1] = r[1] * im;
    return r;
});

function _MJS_v2lengthLocal(a) {
    return Math.sqrt(a[0] * a[0] + a[1] * a[1]);
}
var _MJS_v2length = _MJS_v2lengthLocal;

var _MJS_v2lengthSquared = function(a) {
    return a[0] * a[0] + a[1] * a[1];
};

var _MJS_v2distance = F2(function(a, b) {
    var dx = a[0] - b[0];
    var dy = a[1] - b[1];
    return Math.sqrt(dx * dx + dy * dy);
});

var _MJS_v2distanceSquared = F2(function(a, b) {
    var dx = a[0] - b[0];
    var dy = a[1] - b[1];
    return dx * dx + dy * dy;
});

var _MJS_v2normalize = function(a) {
    var r = new Float64Array(2);
    var im = 1.0 / _MJS_v2lengthLocal(a);
    r[0] = a[0] * im;
    r[1] = a[1] * im;
    return r;
};

var _MJS_v2scale = F2(function(k, a) {
    var r = new Float64Array(2);
    r[0] = a[0] * k;
    r[1] = a[1] * k;
    return r;
});

var _MJS_v2dot = F2(function(a, b) {
    return a[0] * b[0] + a[1] * b[1];
});

// Vector3

var _MJS_v3temp1Local = new Float64Array(3);
var _MJS_v3temp2Local = new Float64Array(3);
var _MJS_v3temp3Local = new Float64Array(3);

var _MJS_v3 = F3(function(x, y, z) {
    return new Float64Array([x, y, z]);
});

var _MJS_v3getX = function(a) {
    return a[0];
};

var _MJS_v3getY = function(a) {
    return a[1];
};

var _MJS_v3getZ = function(a) {
    return a[2];
};

var _MJS_v3setX = F2(function(x, a) {
    return new Float64Array([x, a[1], a[2]]);
});

var _MJS_v3setY = F2(function(y, a) {
    return new Float64Array([a[0], y, a[2]]);
});

var _MJS_v3setZ = F2(function(z, a) {
    return new Float64Array([a[0], a[1], z]);
});

var _MJS_v3toRecord = function(a) {
    return { x: a[0], y: a[1], z: a[2] };
};

var _MJS_v3fromRecord = function(r) {
    return new Float64Array([r.x, r.y, r.z]);
};

var _MJS_v3add = F2(function(a, b) {
    var r = new Float64Array(3);
    r[0] = a[0] + b[0];
    r[1] = a[1] + b[1];
    r[2] = a[2] + b[2];
    return r;
});

function _MJS_v3subLocal(a, b, r) {
    if (r === undefined) {
        r = new Float64Array(3);
    }
    r[0] = a[0] - b[0];
    r[1] = a[1] - b[1];
    r[2] = a[2] - b[2];
    return r;
}
var _MJS_v3sub = F2(_MJS_v3subLocal);

var _MJS_v3negate = function(a) {
    var r = new Float64Array(3);
    r[0] = -a[0];
    r[1] = -a[1];
    r[2] = -a[2];
    return r;
};

function _MJS_v3directionLocal(a, b, r) {
    if (r === undefined) {
        r = new Float64Array(3);
    }
    return _MJS_v3normalizeLocal(_MJS_v3subLocal(a, b, r), r);
}
var _MJS_v3direction = F2(_MJS_v3directionLocal);

function _MJS_v3lengthLocal(a) {
    return Math.sqrt(a[0] * a[0] + a[1] * a[1] + a[2] * a[2]);
}
var _MJS_v3length = _MJS_v3lengthLocal;

var _MJS_v3lengthSquared = function(a) {
    return a[0] * a[0] + a[1] * a[1] + a[2] * a[2];
};

var _MJS_v3distance = F2(function(a, b) {
    var dx = a[0] - b[0];
    var dy = a[1] - b[1];
    var dz = a[2] - b[2];
    return Math.sqrt(dx * dx + dy * dy + dz * dz);
});

var _MJS_v3distanceSquared = F2(function(a, b) {
    var dx = a[0] - b[0];
    var dy = a[1] - b[1];
    var dz = a[2] - b[2];
    return dx * dx + dy * dy + dz * dz;
});

function _MJS_v3normalizeLocal(a, r) {
    if (r === undefined) {
        r = new Float64Array(3);
    }
    var im = 1.0 / _MJS_v3lengthLocal(a);
    r[0] = a[0] * im;
    r[1] = a[1] * im;
    r[2] = a[2] * im;
    return r;
}
var _MJS_v3normalize = _MJS_v3normalizeLocal;

var _MJS_v3scale = F2(function(k, a) {
    return new Float64Array([a[0] * k, a[1] * k, a[2] * k]);
});

var _MJS_v3dotLocal = function(a, b) {
    return a[0] * b[0] + a[1] * b[1] + a[2] * b[2];
};
var _MJS_v3dot = F2(_MJS_v3dotLocal);

function _MJS_v3crossLocal(a, b, r) {
    if (r === undefined) {
        r = new Float64Array(3);
    }
    r[0] = a[1] * b[2] - a[2] * b[1];
    r[1] = a[2] * b[0] - a[0] * b[2];
    r[2] = a[0] * b[1] - a[1] * b[0];
    return r;
}
var _MJS_v3cross = F2(_MJS_v3crossLocal);

var _MJS_v3mul4x4 = F2(function(m, v) {
    var w;
    var tmp = _MJS_v3temp1Local;
    var r = new Float64Array(3);

    tmp[0] = m[3];
    tmp[1] = m[7];
    tmp[2] = m[11];
    w = _MJS_v3dotLocal(v, tmp) + m[15];
    tmp[0] = m[0];
    tmp[1] = m[4];
    tmp[2] = m[8];
    r[0] = (_MJS_v3dotLocal(v, tmp) + m[12]) / w;
    tmp[0] = m[1];
    tmp[1] = m[5];
    tmp[2] = m[9];
    r[1] = (_MJS_v3dotLocal(v, tmp) + m[13]) / w;
    tmp[0] = m[2];
    tmp[1] = m[6];
    tmp[2] = m[10];
    r[2] = (_MJS_v3dotLocal(v, tmp) + m[14]) / w;
    return r;
});

// Vector4

var _MJS_v4 = F4(function(x, y, z, w) {
    return new Float64Array([x, y, z, w]);
});

var _MJS_v4getX = function(a) {
    return a[0];
};

var _MJS_v4getY = function(a) {
    return a[1];
};

var _MJS_v4getZ = function(a) {
    return a[2];
};

var _MJS_v4getW = function(a) {
    return a[3];
};

var _MJS_v4setX = F2(function(x, a) {
    return new Float64Array([x, a[1], a[2], a[3]]);
});

var _MJS_v4setY = F2(function(y, a) {
    return new Float64Array([a[0], y, a[2], a[3]]);
});

var _MJS_v4setZ = F2(function(z, a) {
    return new Float64Array([a[0], a[1], z, a[3]]);
});

var _MJS_v4setW = F2(function(w, a) {
    return new Float64Array([a[0], a[1], a[2], w]);
});

var _MJS_v4toRecord = function(a) {
    return { x: a[0], y: a[1], z: a[2], w: a[3] };
};

var _MJS_v4fromRecord = function(r) {
    return new Float64Array([r.x, r.y, r.z, r.w]);
};

var _MJS_v4add = F2(function(a, b) {
    var r = new Float64Array(4);
    r[0] = a[0] + b[0];
    r[1] = a[1] + b[1];
    r[2] = a[2] + b[2];
    r[3] = a[3] + b[3];
    return r;
});

var _MJS_v4sub = F2(function(a, b) {
    var r = new Float64Array(4);
    r[0] = a[0] - b[0];
    r[1] = a[1] - b[1];
    r[2] = a[2] - b[2];
    r[3] = a[3] - b[3];
    return r;
});

var _MJS_v4negate = function(a) {
    var r = new Float64Array(4);
    r[0] = -a[0];
    r[1] = -a[1];
    r[2] = -a[2];
    r[3] = -a[3];
    return r;
};

var _MJS_v4direction = F2(function(a, b) {
    var r = new Float64Array(4);
    r[0] = a[0] - b[0];
    r[1] = a[1] - b[1];
    r[2] = a[2] - b[2];
    r[3] = a[3] - b[3];
    var im = 1.0 / _MJS_v4lengthLocal(r);
    r[0] = r[0] * im;
    r[1] = r[1] * im;
    r[2] = r[2] * im;
    r[3] = r[3] * im;
    return r;
});

function _MJS_v4lengthLocal(a) {
    return Math.sqrt(a[0] * a[0] + a[1] * a[1] + a[2] * a[2] + a[3] * a[3]);
}
var _MJS_v4length = _MJS_v4lengthLocal;

var _MJS_v4lengthSquared = function(a) {
    return a[0] * a[0] + a[1] * a[1] + a[2] * a[2] + a[3] * a[3];
};

var _MJS_v4distance = F2(function(a, b) {
    var dx = a[0] - b[0];
    var dy = a[1] - b[1];
    var dz = a[2] - b[2];
    var dw = a[3] - b[3];
    return Math.sqrt(dx * dx + dy * dy + dz * dz + dw * dw);
});

var _MJS_v4distanceSquared = F2(function(a, b) {
    var dx = a[0] - b[0];
    var dy = a[1] - b[1];
    var dz = a[2] - b[2];
    var dw = a[3] - b[3];
    return dx * dx + dy * dy + dz * dz + dw * dw;
});

var _MJS_v4normalize = function(a) {
    var r = new Float64Array(4);
    var im = 1.0 / _MJS_v4lengthLocal(a);
    r[0] = a[0] * im;
    r[1] = a[1] * im;
    r[2] = a[2] * im;
    r[3] = a[3] * im;
    return r;
};

var _MJS_v4scale = F2(function(k, a) {
    var r = new Float64Array(4);
    r[0] = a[0] * k;
    r[1] = a[1] * k;
    r[2] = a[2] * k;
    r[3] = a[3] * k;
    return r;
});

var _MJS_v4dot = F2(function(a, b) {
    return a[0] * b[0] + a[1] * b[1] + a[2] * b[2] + a[3] * b[3];
});

// Matrix4

var _MJS_m4x4temp1Local = new Float64Array(16);
var _MJS_m4x4temp2Local = new Float64Array(16);

var _MJS_m4x4identity = new Float64Array([
    1.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0
]);

var _MJS_m4x4fromRecord = function(r) {
    var m = new Float64Array(16);
    m[0] = r.m11;
    m[1] = r.m21;
    m[2] = r.m31;
    m[3] = r.m41;
    m[4] = r.m12;
    m[5] = r.m22;
    m[6] = r.m32;
    m[7] = r.m42;
    m[8] = r.m13;
    m[9] = r.m23;
    m[10] = r.m33;
    m[11] = r.m43;
    m[12] = r.m14;
    m[13] = r.m24;
    m[14] = r.m34;
    m[15] = r.m44;
    return m;
};

var _MJS_m4x4toRecord = function(m) {
    return {
        m11: m[0], m21: m[1], m31: m[2], m41: m[3],
        m12: m[4], m22: m[5], m32: m[6], m42: m[7],
        m13: m[8], m23: m[9], m33: m[10], m43: m[11],
        m14: m[12], m24: m[13], m34: m[14], m44: m[15]
    };
};

var _MJS_m4x4inverse = function(m) {
    var r = new Float64Array(16);

    r[0] = m[5] * m[10] * m[15] - m[5] * m[11] * m[14] - m[9] * m[6] * m[15] +
        m[9] * m[7] * m[14] + m[13] * m[6] * m[11] - m[13] * m[7] * m[10];
    r[4] = -m[4] * m[10] * m[15] + m[4] * m[11] * m[14] + m[8] * m[6] * m[15] -
        m[8] * m[7] * m[14] - m[12] * m[6] * m[11] + m[12] * m[7] * m[10];
    r[8] = m[4] * m[9] * m[15] - m[4] * m[11] * m[13] - m[8] * m[5] * m[15] +
        m[8] * m[7] * m[13] + m[12] * m[5] * m[11] - m[12] * m[7] * m[9];
    r[12] = -m[4] * m[9] * m[14] + m[4] * m[10] * m[13] + m[8] * m[5] * m[14] -
        m[8] * m[6] * m[13] - m[12] * m[5] * m[10] + m[12] * m[6] * m[9];
    r[1] = -m[1] * m[10] * m[15] + m[1] * m[11] * m[14] + m[9] * m[2] * m[15] -
        m[9] * m[3] * m[14] - m[13] * m[2] * m[11] + m[13] * m[3] * m[10];
    r[5] = m[0] * m[10] * m[15] - m[0] * m[11] * m[14] - m[8] * m[2] * m[15] +
        m[8] * m[3] * m[14] + m[12] * m[2] * m[11] - m[12] * m[3] * m[10];
    r[9] = -m[0] * m[9] * m[15] + m[0] * m[11] * m[13] + m[8] * m[1] * m[15] -
        m[8] * m[3] * m[13] - m[12] * m[1] * m[11] + m[12] * m[3] * m[9];
    r[13] = m[0] * m[9] * m[14] - m[0] * m[10] * m[13] - m[8] * m[1] * m[14] +
        m[8] * m[2] * m[13] + m[12] * m[1] * m[10] - m[12] * m[2] * m[9];
    r[2] = m[1] * m[6] * m[15] - m[1] * m[7] * m[14] - m[5] * m[2] * m[15] +
        m[5] * m[3] * m[14] + m[13] * m[2] * m[7] - m[13] * m[3] * m[6];
    r[6] = -m[0] * m[6] * m[15] + m[0] * m[7] * m[14] + m[4] * m[2] * m[15] -
        m[4] * m[3] * m[14] - m[12] * m[2] * m[7] + m[12] * m[3] * m[6];
    r[10] = m[0] * m[5] * m[15] - m[0] * m[7] * m[13] - m[4] * m[1] * m[15] +
        m[4] * m[3] * m[13] + m[12] * m[1] * m[7] - m[12] * m[3] * m[5];
    r[14] = -m[0] * m[5] * m[14] + m[0] * m[6] * m[13] + m[4] * m[1] * m[14] -
        m[4] * m[2] * m[13] - m[12] * m[1] * m[6] + m[12] * m[2] * m[5];
    r[3] = -m[1] * m[6] * m[11] + m[1] * m[7] * m[10] + m[5] * m[2] * m[11] -
        m[5] * m[3] * m[10] - m[9] * m[2] * m[7] + m[9] * m[3] * m[6];
    r[7] = m[0] * m[6] * m[11] - m[0] * m[7] * m[10] - m[4] * m[2] * m[11] +
        m[4] * m[3] * m[10] + m[8] * m[2] * m[7] - m[8] * m[3] * m[6];
    r[11] = -m[0] * m[5] * m[11] + m[0] * m[7] * m[9] + m[4] * m[1] * m[11] -
        m[4] * m[3] * m[9] - m[8] * m[1] * m[7] + m[8] * m[3] * m[5];
    r[15] = m[0] * m[5] * m[10] - m[0] * m[6] * m[9] - m[4] * m[1] * m[10] +
        m[4] * m[2] * m[9] + m[8] * m[1] * m[6] - m[8] * m[2] * m[5];

    var det = m[0] * r[0] + m[1] * r[4] + m[2] * r[8] + m[3] * r[12];

    if (det === 0) {
        return $elm$core$Maybe$Nothing;
    }

    det = 1.0 / det;

    for (var i = 0; i < 16; i = i + 1) {
        r[i] = r[i] * det;
    }

    return $elm$core$Maybe$Just(r);
};

var _MJS_m4x4inverseOrthonormal = function(m) {
    var r = _MJS_m4x4transposeLocal(m);
    var t = [m[12], m[13], m[14]];
    r[3] = r[7] = r[11] = 0;
    r[12] = -_MJS_v3dotLocal([r[0], r[4], r[8]], t);
    r[13] = -_MJS_v3dotLocal([r[1], r[5], r[9]], t);
    r[14] = -_MJS_v3dotLocal([r[2], r[6], r[10]], t);
    return r;
};

function _MJS_m4x4makeFrustumLocal(left, right, bottom, top, znear, zfar) {
    var r = new Float64Array(16);

    r[0] = 2 * znear / (right - left);
    r[1] = 0;
    r[2] = 0;
    r[3] = 0;
    r[4] = 0;
    r[5] = 2 * znear / (top - bottom);
    r[6] = 0;
    r[7] = 0;
    r[8] = (right + left) / (right - left);
    r[9] = (top + bottom) / (top - bottom);
    r[10] = -(zfar + znear) / (zfar - znear);
    r[11] = -1;
    r[12] = 0;
    r[13] = 0;
    r[14] = -2 * zfar * znear / (zfar - znear);
    r[15] = 0;

    return r;
}
var _MJS_m4x4makeFrustum = F6(_MJS_m4x4makeFrustumLocal);

var _MJS_m4x4makePerspective = F4(function(fovy, aspect, znear, zfar) {
    var ymax = znear * Math.tan(fovy * Math.PI / 360.0);
    var ymin = -ymax;
    var xmin = ymin * aspect;
    var xmax = ymax * aspect;

    return _MJS_m4x4makeFrustumLocal(xmin, xmax, ymin, ymax, znear, zfar);
});

function _MJS_m4x4makeOrthoLocal(left, right, bottom, top, znear, zfar) {
    var r = new Float64Array(16);

    r[0] = 2 / (right - left);
    r[1] = 0;
    r[2] = 0;
    r[3] = 0;
    r[4] = 0;
    r[5] = 2 / (top - bottom);
    r[6] = 0;
    r[7] = 0;
    r[8] = 0;
    r[9] = 0;
    r[10] = -2 / (zfar - znear);
    r[11] = 0;
    r[12] = -(right + left) / (right - left);
    r[13] = -(top + bottom) / (top - bottom);
    r[14] = -(zfar + znear) / (zfar - znear);
    r[15] = 1;

    return r;
}
var _MJS_m4x4makeOrtho = F6(_MJS_m4x4makeOrthoLocal);

var _MJS_m4x4makeOrtho2D = F4(function(left, right, bottom, top) {
    return _MJS_m4x4makeOrthoLocal(left, right, bottom, top, -1, 1);
});

function _MJS_m4x4mulLocal(a, b) {
    var r = new Float64Array(16);
    var a11 = a[0];
    var a21 = a[1];
    var a31 = a[2];
    var a41 = a[3];
    var a12 = a[4];
    var a22 = a[5];
    var a32 = a[6];
    var a42 = a[7];
    var a13 = a[8];
    var a23 = a[9];
    var a33 = a[10];
    var a43 = a[11];
    var a14 = a[12];
    var a24 = a[13];
    var a34 = a[14];
    var a44 = a[15];
    var b11 = b[0];
    var b21 = b[1];
    var b31 = b[2];
    var b41 = b[3];
    var b12 = b[4];
    var b22 = b[5];
    var b32 = b[6];
    var b42 = b[7];
    var b13 = b[8];
    var b23 = b[9];
    var b33 = b[10];
    var b43 = b[11];
    var b14 = b[12];
    var b24 = b[13];
    var b34 = b[14];
    var b44 = b[15];

    r[0] = a11 * b11 + a12 * b21 + a13 * b31 + a14 * b41;
    r[1] = a21 * b11 + a22 * b21 + a23 * b31 + a24 * b41;
    r[2] = a31 * b11 + a32 * b21 + a33 * b31 + a34 * b41;
    r[3] = a41 * b11 + a42 * b21 + a43 * b31 + a44 * b41;
    r[4] = a11 * b12 + a12 * b22 + a13 * b32 + a14 * b42;
    r[5] = a21 * b12 + a22 * b22 + a23 * b32 + a24 * b42;
    r[6] = a31 * b12 + a32 * b22 + a33 * b32 + a34 * b42;
    r[7] = a41 * b12 + a42 * b22 + a43 * b32 + a44 * b42;
    r[8] = a11 * b13 + a12 * b23 + a13 * b33 + a14 * b43;
    r[9] = a21 * b13 + a22 * b23 + a23 * b33 + a24 * b43;
    r[10] = a31 * b13 + a32 * b23 + a33 * b33 + a34 * b43;
    r[11] = a41 * b13 + a42 * b23 + a43 * b33 + a44 * b43;
    r[12] = a11 * b14 + a12 * b24 + a13 * b34 + a14 * b44;
    r[13] = a21 * b14 + a22 * b24 + a23 * b34 + a24 * b44;
    r[14] = a31 * b14 + a32 * b24 + a33 * b34 + a34 * b44;
    r[15] = a41 * b14 + a42 * b24 + a43 * b34 + a44 * b44;

    return r;
}
var _MJS_m4x4mul = F2(_MJS_m4x4mulLocal);

var _MJS_m4x4mulAffine = F2(function(a, b) {
    var r = new Float64Array(16);
    var a11 = a[0];
    var a21 = a[1];
    var a31 = a[2];
    var a12 = a[4];
    var a22 = a[5];
    var a32 = a[6];
    var a13 = a[8];
    var a23 = a[9];
    var a33 = a[10];
    var a14 = a[12];
    var a24 = a[13];
    var a34 = a[14];

    var b11 = b[0];
    var b21 = b[1];
    var b31 = b[2];
    var b12 = b[4];
    var b22 = b[5];
    var b32 = b[6];
    var b13 = b[8];
    var b23 = b[9];
    var b33 = b[10];
    var b14 = b[12];
    var b24 = b[13];
    var b34 = b[14];

    r[0] = a11 * b11 + a12 * b21 + a13 * b31;
    r[1] = a21 * b11 + a22 * b21 + a23 * b31;
    r[2] = a31 * b11 + a32 * b21 + a33 * b31;
    r[3] = 0;
    r[4] = a11 * b12 + a12 * b22 + a13 * b32;
    r[5] = a21 * b12 + a22 * b22 + a23 * b32;
    r[6] = a31 * b12 + a32 * b22 + a33 * b32;
    r[7] = 0;
    r[8] = a11 * b13 + a12 * b23 + a13 * b33;
    r[9] = a21 * b13 + a22 * b23 + a23 * b33;
    r[10] = a31 * b13 + a32 * b23 + a33 * b33;
    r[11] = 0;
    r[12] = a11 * b14 + a12 * b24 + a13 * b34 + a14;
    r[13] = a21 * b14 + a22 * b24 + a23 * b34 + a24;
    r[14] = a31 * b14 + a32 * b24 + a33 * b34 + a34;
    r[15] = 1;

    return r;
});

var _MJS_m4x4makeRotate = F2(function(angle, axis) {
    var r = new Float64Array(16);
    axis = _MJS_v3normalizeLocal(axis, _MJS_v3temp1Local);
    var x = axis[0];
    var y = axis[1];
    var z = axis[2];
    var c = Math.cos(angle);
    var c1 = 1 - c;
    var s = Math.sin(angle);

    r[0] = x * x * c1 + c;
    r[1] = y * x * c1 + z * s;
    r[2] = z * x * c1 - y * s;
    r[3] = 0;
    r[4] = x * y * c1 - z * s;
    r[5] = y * y * c1 + c;
    r[6] = y * z * c1 + x * s;
    r[7] = 0;
    r[8] = x * z * c1 + y * s;
    r[9] = y * z * c1 - x * s;
    r[10] = z * z * c1 + c;
    r[11] = 0;
    r[12] = 0;
    r[13] = 0;
    r[14] = 0;
    r[15] = 1;

    return r;
});

var _MJS_m4x4rotate = F3(function(angle, axis, m) {
    var r = new Float64Array(16);
    var im = 1.0 / _MJS_v3lengthLocal(axis);
    var x = axis[0] * im;
    var y = axis[1] * im;
    var z = axis[2] * im;
    var c = Math.cos(angle);
    var c1 = 1 - c;
    var s = Math.sin(angle);
    var xs = x * s;
    var ys = y * s;
    var zs = z * s;
    var xyc1 = x * y * c1;
    var xzc1 = x * z * c1;
    var yzc1 = y * z * c1;
    var t11 = x * x * c1 + c;
    var t21 = xyc1 + zs;
    var t31 = xzc1 - ys;
    var t12 = xyc1 - zs;
    var t22 = y * y * c1 + c;
    var t32 = yzc1 + xs;
    var t13 = xzc1 + ys;
    var t23 = yzc1 - xs;
    var t33 = z * z * c1 + c;
    var m11 = m[0], m21 = m[1], m31 = m[2], m41 = m[3];
    var m12 = m[4], m22 = m[5], m32 = m[6], m42 = m[7];
    var m13 = m[8], m23 = m[9], m33 = m[10], m43 = m[11];
    var m14 = m[12], m24 = m[13], m34 = m[14], m44 = m[15];

    r[0] = m11 * t11 + m12 * t21 + m13 * t31;
    r[1] = m21 * t11 + m22 * t21 + m23 * t31;
    r[2] = m31 * t11 + m32 * t21 + m33 * t31;
    r[3] = m41 * t11 + m42 * t21 + m43 * t31;
    r[4] = m11 * t12 + m12 * t22 + m13 * t32;
    r[5] = m21 * t12 + m22 * t22 + m23 * t32;
    r[6] = m31 * t12 + m32 * t22 + m33 * t32;
    r[7] = m41 * t12 + m42 * t22 + m43 * t32;
    r[8] = m11 * t13 + m12 * t23 + m13 * t33;
    r[9] = m21 * t13 + m22 * t23 + m23 * t33;
    r[10] = m31 * t13 + m32 * t23 + m33 * t33;
    r[11] = m41 * t13 + m42 * t23 + m43 * t33;
    r[12] = m14,
    r[13] = m24;
    r[14] = m34;
    r[15] = m44;

    return r;
});

function _MJS_m4x4makeScale3Local(x, y, z) {
    var r = new Float64Array(16);

    r[0] = x;
    r[1] = 0;
    r[2] = 0;
    r[3] = 0;
    r[4] = 0;
    r[5] = y;
    r[6] = 0;
    r[7] = 0;
    r[8] = 0;
    r[9] = 0;
    r[10] = z;
    r[11] = 0;
    r[12] = 0;
    r[13] = 0;
    r[14] = 0;
    r[15] = 1;

    return r;
}
var _MJS_m4x4makeScale3 = F3(_MJS_m4x4makeScale3Local);

var _MJS_m4x4makeScale = function(v) {
    return _MJS_m4x4makeScale3Local(v[0], v[1], v[2]);
};

var _MJS_m4x4scale3 = F4(function(x, y, z, m) {
    var r = new Float64Array(16);

    r[0] = m[0] * x;
    r[1] = m[1] * x;
    r[2] = m[2] * x;
    r[3] = m[3] * x;
    r[4] = m[4] * y;
    r[5] = m[5] * y;
    r[6] = m[6] * y;
    r[7] = m[7] * y;
    r[8] = m[8] * z;
    r[9] = m[9] * z;
    r[10] = m[10] * z;
    r[11] = m[11] * z;
    r[12] = m[12];
    r[13] = m[13];
    r[14] = m[14];
    r[15] = m[15];

    return r;
});

var _MJS_m4x4scale = F2(function(v, m) {
    var r = new Float64Array(16);
    var x = v[0];
    var y = v[1];
    var z = v[2];

    r[0] = m[0] * x;
    r[1] = m[1] * x;
    r[2] = m[2] * x;
    r[3] = m[3] * x;
    r[4] = m[4] * y;
    r[5] = m[5] * y;
    r[6] = m[6] * y;
    r[7] = m[7] * y;
    r[8] = m[8] * z;
    r[9] = m[9] * z;
    r[10] = m[10] * z;
    r[11] = m[11] * z;
    r[12] = m[12];
    r[13] = m[13];
    r[14] = m[14];
    r[15] = m[15];

    return r;
});

function _MJS_m4x4makeTranslate3Local(x, y, z) {
    var r = new Float64Array(16);

    r[0] = 1;
    r[1] = 0;
    r[2] = 0;
    r[3] = 0;
    r[4] = 0;
    r[5] = 1;
    r[6] = 0;
    r[7] = 0;
    r[8] = 0;
    r[9] = 0;
    r[10] = 1;
    r[11] = 0;
    r[12] = x;
    r[13] = y;
    r[14] = z;
    r[15] = 1;

    return r;
}
var _MJS_m4x4makeTranslate3 = F3(_MJS_m4x4makeTranslate3Local);

var _MJS_m4x4makeTranslate = function(v) {
    return _MJS_m4x4makeTranslate3Local(v[0], v[1], v[2]);
};

var _MJS_m4x4translate3 = F4(function(x, y, z, m) {
    var r = new Float64Array(16);
    var m11 = m[0];
    var m21 = m[1];
    var m31 = m[2];
    var m41 = m[3];
    var m12 = m[4];
    var m22 = m[5];
    var m32 = m[6];
    var m42 = m[7];
    var m13 = m[8];
    var m23 = m[9];
    var m33 = m[10];
    var m43 = m[11];

    r[0] = m11;
    r[1] = m21;
    r[2] = m31;
    r[3] = m41;
    r[4] = m12;
    r[5] = m22;
    r[6] = m32;
    r[7] = m42;
    r[8] = m13;
    r[9] = m23;
    r[10] = m33;
    r[11] = m43;
    r[12] = m11 * x + m12 * y + m13 * z + m[12];
    r[13] = m21 * x + m22 * y + m23 * z + m[13];
    r[14] = m31 * x + m32 * y + m33 * z + m[14];
    r[15] = m41 * x + m42 * y + m43 * z + m[15];

    return r;
});

var _MJS_m4x4translate = F2(function(v, m) {
    var r = new Float64Array(16);
    var x = v[0];
    var y = v[1];
    var z = v[2];
    var m11 = m[0];
    var m21 = m[1];
    var m31 = m[2];
    var m41 = m[3];
    var m12 = m[4];
    var m22 = m[5];
    var m32 = m[6];
    var m42 = m[7];
    var m13 = m[8];
    var m23 = m[9];
    var m33 = m[10];
    var m43 = m[11];

    r[0] = m11;
    r[1] = m21;
    r[2] = m31;
    r[3] = m41;
    r[4] = m12;
    r[5] = m22;
    r[6] = m32;
    r[7] = m42;
    r[8] = m13;
    r[9] = m23;
    r[10] = m33;
    r[11] = m43;
    r[12] = m11 * x + m12 * y + m13 * z + m[12];
    r[13] = m21 * x + m22 * y + m23 * z + m[13];
    r[14] = m31 * x + m32 * y + m33 * z + m[14];
    r[15] = m41 * x + m42 * y + m43 * z + m[15];

    return r;
});

var _MJS_m4x4makeLookAt = F3(function(eye, center, up) {
    var z = _MJS_v3directionLocal(eye, center, _MJS_v3temp1Local);
    var x = _MJS_v3normalizeLocal(_MJS_v3crossLocal(up, z, _MJS_v3temp2Local), _MJS_v3temp2Local);
    var y = _MJS_v3normalizeLocal(_MJS_v3crossLocal(z, x, _MJS_v3temp3Local), _MJS_v3temp3Local);
    var tm1 = _MJS_m4x4temp1Local;
    var tm2 = _MJS_m4x4temp2Local;

    tm1[0] = x[0];
    tm1[1] = y[0];
    tm1[2] = z[0];
    tm1[3] = 0;
    tm1[4] = x[1];
    tm1[5] = y[1];
    tm1[6] = z[1];
    tm1[7] = 0;
    tm1[8] = x[2];
    tm1[9] = y[2];
    tm1[10] = z[2];
    tm1[11] = 0;
    tm1[12] = 0;
    tm1[13] = 0;
    tm1[14] = 0;
    tm1[15] = 1;

    tm2[0] = 1; tm2[1] = 0; tm2[2] = 0; tm2[3] = 0;
    tm2[4] = 0; tm2[5] = 1; tm2[6] = 0; tm2[7] = 0;
    tm2[8] = 0; tm2[9] = 0; tm2[10] = 1; tm2[11] = 0;
    tm2[12] = -eye[0]; tm2[13] = -eye[1]; tm2[14] = -eye[2]; tm2[15] = 1;

    return _MJS_m4x4mulLocal(tm1, tm2);
});


function _MJS_m4x4transposeLocal(m) {
    var r = new Float64Array(16);

    r[0] = m[0]; r[1] = m[4]; r[2] = m[8]; r[3] = m[12];
    r[4] = m[1]; r[5] = m[5]; r[6] = m[9]; r[7] = m[13];
    r[8] = m[2]; r[9] = m[6]; r[10] = m[10]; r[11] = m[14];
    r[12] = m[3]; r[13] = m[7]; r[14] = m[11]; r[15] = m[15];

    return r;
}
var _MJS_m4x4transpose = _MJS_m4x4transposeLocal;

var _MJS_m4x4makeBasis = F3(function(vx, vy, vz) {
    var r = new Float64Array(16);

    r[0] = vx[0];
    r[1] = vx[1];
    r[2] = vx[2];
    r[3] = 0;
    r[4] = vy[0];
    r[5] = vy[1];
    r[6] = vy[2];
    r[7] = 0;
    r[8] = vz[0];
    r[9] = vz[1];
    r[10] = vz[2];
    r[11] = 0;
    r[12] = 0;
    r[13] = 0;
    r[14] = 0;
    r[15] = 1;

    return r;
});



var _Bitwise_and = F2(function(a, b)
{
	return a & b;
});

var _Bitwise_or = F2(function(a, b)
{
	return a | b;
});

var _Bitwise_xor = F2(function(a, b)
{
	return a ^ b;
});

function _Bitwise_complement(a)
{
	return ~a;
};

var _Bitwise_shiftLeftBy = F2(function(offset, a)
{
	return a << offset;
});

var _Bitwise_shiftRightBy = F2(function(offset, a)
{
	return a >> offset;
});

var _Bitwise_shiftRightZfBy = F2(function(offset, a)
{
	return a >>> offset;
});



function _Time_now(millisToPosix)
{
	return _Scheduler_binding(function(callback)
	{
		callback(_Scheduler_succeed(millisToPosix(Date.now())));
	});
}

var _Time_setInterval = F2(function(interval, task)
{
	return _Scheduler_binding(function(callback)
	{
		var id = setInterval(function() { _Scheduler_rawSpawn(task); }, interval);
		return function() { clearInterval(id); };
	});
});

function _Time_here()
{
	return _Scheduler_binding(function(callback)
	{
		callback(_Scheduler_succeed(
			A2($elm$time$Time$customZone, -(new Date().getTimezoneOffset()), _List_Nil)
		));
	});
}


function _Time_getZoneName()
{
	return _Scheduler_binding(function(callback)
	{
		try
		{
			var name = $elm$time$Time$Name(Intl.DateTimeFormat().resolvedOptions().timeZone);
		}
		catch (e)
		{
			var name = $elm$time$Time$Offset(new Date().getTimezoneOffset());
		}
		callback(_Scheduler_succeed(name));
	});
}
var $elm$core$List$cons = _List_cons;
var $elm$core$Elm$JsArray$foldr = _JsArray_foldr;
var $elm$core$Array$foldr = F3(
	function (func, baseCase, _v0) {
		var tree = _v0.c;
		var tail = _v0.d;
		var helper = F2(
			function (node, acc) {
				if (node.$ === 'SubTree') {
					var subTree = node.a;
					return A3($elm$core$Elm$JsArray$foldr, helper, acc, subTree);
				} else {
					var values = node.a;
					return A3($elm$core$Elm$JsArray$foldr, func, acc, values);
				}
			});
		return A3(
			$elm$core$Elm$JsArray$foldr,
			helper,
			A3($elm$core$Elm$JsArray$foldr, func, baseCase, tail),
			tree);
	});
var $elm$core$Array$toList = function (array) {
	return A3($elm$core$Array$foldr, $elm$core$List$cons, _List_Nil, array);
};
var $elm$core$Dict$foldr = F3(
	function (func, acc, t) {
		foldr:
		while (true) {
			if (t.$ === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var key = t.b;
				var value = t.c;
				var left = t.d;
				var right = t.e;
				var $temp$func = func,
					$temp$acc = A3(
					func,
					key,
					value,
					A3($elm$core$Dict$foldr, func, acc, right)),
					$temp$t = left;
				func = $temp$func;
				acc = $temp$acc;
				t = $temp$t;
				continue foldr;
			}
		}
	});
var $elm$core$Dict$toList = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, list) {
				return A2(
					$elm$core$List$cons,
					_Utils_Tuple2(key, value),
					list);
			}),
		_List_Nil,
		dict);
};
var $elm$core$Dict$keys = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, keyList) {
				return A2($elm$core$List$cons, key, keyList);
			}),
		_List_Nil,
		dict);
};
var $elm$core$Set$toList = function (_v0) {
	var dict = _v0.a;
	return $elm$core$Dict$keys(dict);
};
var $elm$core$Basics$EQ = {$: 'EQ'};
var $elm$core$Basics$GT = {$: 'GT'};
var $elm$core$Basics$LT = {$: 'LT'};
var $elm$core$Result$Err = function (a) {
	return {$: 'Err', a: a};
};
var $elm$json$Json$Decode$Failure = F2(
	function (a, b) {
		return {$: 'Failure', a: a, b: b};
	});
var $elm$json$Json$Decode$Field = F2(
	function (a, b) {
		return {$: 'Field', a: a, b: b};
	});
var $elm$json$Json$Decode$Index = F2(
	function (a, b) {
		return {$: 'Index', a: a, b: b};
	});
var $elm$core$Result$Ok = function (a) {
	return {$: 'Ok', a: a};
};
var $elm$json$Json$Decode$OneOf = function (a) {
	return {$: 'OneOf', a: a};
};
var $elm$core$Basics$False = {$: 'False'};
var $elm$core$Basics$add = _Basics_add;
var $elm$core$Maybe$Just = function (a) {
	return {$: 'Just', a: a};
};
var $elm$core$Maybe$Nothing = {$: 'Nothing'};
var $elm$core$String$all = _String_all;
var $elm$core$Basics$and = _Basics_and;
var $elm$core$Basics$append = _Utils_append;
var $elm$json$Json$Encode$encode = _Json_encode;
var $elm$core$String$fromInt = _String_fromNumber;
var $elm$core$String$join = F2(
	function (sep, chunks) {
		return A2(
			_String_join,
			sep,
			_List_toArray(chunks));
	});
var $elm$core$String$split = F2(
	function (sep, string) {
		return _List_fromArray(
			A2(_String_split, sep, string));
	});
var $elm$json$Json$Decode$indent = function (str) {
	return A2(
		$elm$core$String$join,
		'\n    ',
		A2($elm$core$String$split, '\n', str));
};
var $elm$core$List$foldl = F3(
	function (func, acc, list) {
		foldl:
		while (true) {
			if (!list.b) {
				return acc;
			} else {
				var x = list.a;
				var xs = list.b;
				var $temp$func = func,
					$temp$acc = A2(func, x, acc),
					$temp$list = xs;
				func = $temp$func;
				acc = $temp$acc;
				list = $temp$list;
				continue foldl;
			}
		}
	});
var $elm$core$List$length = function (xs) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (_v0, i) {
				return i + 1;
			}),
		0,
		xs);
};
var $elm$core$List$map2 = _List_map2;
var $elm$core$Basics$le = _Utils_le;
var $elm$core$Basics$sub = _Basics_sub;
var $elm$core$List$rangeHelp = F3(
	function (lo, hi, list) {
		rangeHelp:
		while (true) {
			if (_Utils_cmp(lo, hi) < 1) {
				var $temp$lo = lo,
					$temp$hi = hi - 1,
					$temp$list = A2($elm$core$List$cons, hi, list);
				lo = $temp$lo;
				hi = $temp$hi;
				list = $temp$list;
				continue rangeHelp;
			} else {
				return list;
			}
		}
	});
var $elm$core$List$range = F2(
	function (lo, hi) {
		return A3($elm$core$List$rangeHelp, lo, hi, _List_Nil);
	});
var $elm$core$List$indexedMap = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$map2,
			f,
			A2(
				$elm$core$List$range,
				0,
				$elm$core$List$length(xs) - 1),
			xs);
	});
var $elm$core$Char$toCode = _Char_toCode;
var $elm$core$Char$isLower = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (97 <= code) && (code <= 122);
};
var $elm$core$Char$isUpper = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (code <= 90) && (65 <= code);
};
var $elm$core$Basics$or = _Basics_or;
var $elm$core$Char$isAlpha = function (_char) {
	return $elm$core$Char$isLower(_char) || $elm$core$Char$isUpper(_char);
};
var $elm$core$Char$isDigit = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (code <= 57) && (48 <= code);
};
var $elm$core$Char$isAlphaNum = function (_char) {
	return $elm$core$Char$isLower(_char) || ($elm$core$Char$isUpper(_char) || $elm$core$Char$isDigit(_char));
};
var $elm$core$List$reverse = function (list) {
	return A3($elm$core$List$foldl, $elm$core$List$cons, _List_Nil, list);
};
var $elm$core$String$uncons = _String_uncons;
var $elm$json$Json$Decode$errorOneOf = F2(
	function (i, error) {
		return '\n\n(' + ($elm$core$String$fromInt(i + 1) + (') ' + $elm$json$Json$Decode$indent(
			$elm$json$Json$Decode$errorToString(error))));
	});
var $elm$json$Json$Decode$errorToString = function (error) {
	return A2($elm$json$Json$Decode$errorToStringHelp, error, _List_Nil);
};
var $elm$json$Json$Decode$errorToStringHelp = F2(
	function (error, context) {
		errorToStringHelp:
		while (true) {
			switch (error.$) {
				case 'Field':
					var f = error.a;
					var err = error.b;
					var isSimple = function () {
						var _v1 = $elm$core$String$uncons(f);
						if (_v1.$ === 'Nothing') {
							return false;
						} else {
							var _v2 = _v1.a;
							var _char = _v2.a;
							var rest = _v2.b;
							return $elm$core$Char$isAlpha(_char) && A2($elm$core$String$all, $elm$core$Char$isAlphaNum, rest);
						}
					}();
					var fieldName = isSimple ? ('.' + f) : ('[\'' + (f + '\']'));
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, fieldName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 'Index':
					var i = error.a;
					var err = error.b;
					var indexName = '[' + ($elm$core$String$fromInt(i) + ']');
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, indexName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 'OneOf':
					var errors = error.a;
					if (!errors.b) {
						return 'Ran into a Json.Decode.oneOf with no possibilities' + function () {
							if (!context.b) {
								return '!';
							} else {
								return ' at json' + A2(
									$elm$core$String$join,
									'',
									$elm$core$List$reverse(context));
							}
						}();
					} else {
						if (!errors.b.b) {
							var err = errors.a;
							var $temp$error = err,
								$temp$context = context;
							error = $temp$error;
							context = $temp$context;
							continue errorToStringHelp;
						} else {
							var starter = function () {
								if (!context.b) {
									return 'Json.Decode.oneOf';
								} else {
									return 'The Json.Decode.oneOf at json' + A2(
										$elm$core$String$join,
										'',
										$elm$core$List$reverse(context));
								}
							}();
							var introduction = starter + (' failed in the following ' + ($elm$core$String$fromInt(
								$elm$core$List$length(errors)) + ' ways:'));
							return A2(
								$elm$core$String$join,
								'\n\n',
								A2(
									$elm$core$List$cons,
									introduction,
									A2($elm$core$List$indexedMap, $elm$json$Json$Decode$errorOneOf, errors)));
						}
					}
				default:
					var msg = error.a;
					var json = error.b;
					var introduction = function () {
						if (!context.b) {
							return 'Problem with the given value:\n\n';
						} else {
							return 'Problem with the value at json' + (A2(
								$elm$core$String$join,
								'',
								$elm$core$List$reverse(context)) + ':\n\n    ');
						}
					}();
					return introduction + ($elm$json$Json$Decode$indent(
						A2($elm$json$Json$Encode$encode, 4, json)) + ('\n\n' + msg));
			}
		}
	});
var $elm$core$Array$branchFactor = 32;
var $elm$core$Array$Array_elm_builtin = F4(
	function (a, b, c, d) {
		return {$: 'Array_elm_builtin', a: a, b: b, c: c, d: d};
	});
var $elm$core$Elm$JsArray$empty = _JsArray_empty;
var $elm$core$Basics$ceiling = _Basics_ceiling;
var $elm$core$Basics$fdiv = _Basics_fdiv;
var $elm$core$Basics$logBase = F2(
	function (base, number) {
		return _Basics_log(number) / _Basics_log(base);
	});
var $elm$core$Basics$toFloat = _Basics_toFloat;
var $elm$core$Array$shiftStep = $elm$core$Basics$ceiling(
	A2($elm$core$Basics$logBase, 2, $elm$core$Array$branchFactor));
var $elm$core$Array$empty = A4($elm$core$Array$Array_elm_builtin, 0, $elm$core$Array$shiftStep, $elm$core$Elm$JsArray$empty, $elm$core$Elm$JsArray$empty);
var $elm$core$Elm$JsArray$initialize = _JsArray_initialize;
var $elm$core$Array$Leaf = function (a) {
	return {$: 'Leaf', a: a};
};
var $elm$core$Basics$apL = F2(
	function (f, x) {
		return f(x);
	});
var $elm$core$Basics$apR = F2(
	function (x, f) {
		return f(x);
	});
var $elm$core$Basics$eq = _Utils_equal;
var $elm$core$Basics$floor = _Basics_floor;
var $elm$core$Elm$JsArray$length = _JsArray_length;
var $elm$core$Basics$gt = _Utils_gt;
var $elm$core$Basics$max = F2(
	function (x, y) {
		return (_Utils_cmp(x, y) > 0) ? x : y;
	});
var $elm$core$Basics$mul = _Basics_mul;
var $elm$core$Array$SubTree = function (a) {
	return {$: 'SubTree', a: a};
};
var $elm$core$Elm$JsArray$initializeFromList = _JsArray_initializeFromList;
var $elm$core$Array$compressNodes = F2(
	function (nodes, acc) {
		compressNodes:
		while (true) {
			var _v0 = A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, nodes);
			var node = _v0.a;
			var remainingNodes = _v0.b;
			var newAcc = A2(
				$elm$core$List$cons,
				$elm$core$Array$SubTree(node),
				acc);
			if (!remainingNodes.b) {
				return $elm$core$List$reverse(newAcc);
			} else {
				var $temp$nodes = remainingNodes,
					$temp$acc = newAcc;
				nodes = $temp$nodes;
				acc = $temp$acc;
				continue compressNodes;
			}
		}
	});
var $elm$core$Tuple$first = function (_v0) {
	var x = _v0.a;
	return x;
};
var $elm$core$Array$treeFromBuilder = F2(
	function (nodeList, nodeListSize) {
		treeFromBuilder:
		while (true) {
			var newNodeSize = $elm$core$Basics$ceiling(nodeListSize / $elm$core$Array$branchFactor);
			if (newNodeSize === 1) {
				return A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, nodeList).a;
			} else {
				var $temp$nodeList = A2($elm$core$Array$compressNodes, nodeList, _List_Nil),
					$temp$nodeListSize = newNodeSize;
				nodeList = $temp$nodeList;
				nodeListSize = $temp$nodeListSize;
				continue treeFromBuilder;
			}
		}
	});
var $elm$core$Array$builderToArray = F2(
	function (reverseNodeList, builder) {
		if (!builder.nodeListSize) {
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.tail),
				$elm$core$Array$shiftStep,
				$elm$core$Elm$JsArray$empty,
				builder.tail);
		} else {
			var treeLen = builder.nodeListSize * $elm$core$Array$branchFactor;
			var depth = $elm$core$Basics$floor(
				A2($elm$core$Basics$logBase, $elm$core$Array$branchFactor, treeLen - 1));
			var correctNodeList = reverseNodeList ? $elm$core$List$reverse(builder.nodeList) : builder.nodeList;
			var tree = A2($elm$core$Array$treeFromBuilder, correctNodeList, builder.nodeListSize);
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.tail) + treeLen,
				A2($elm$core$Basics$max, 5, depth * $elm$core$Array$shiftStep),
				tree,
				builder.tail);
		}
	});
var $elm$core$Basics$idiv = _Basics_idiv;
var $elm$core$Basics$lt = _Utils_lt;
var $elm$core$Array$initializeHelp = F5(
	function (fn, fromIndex, len, nodeList, tail) {
		initializeHelp:
		while (true) {
			if (fromIndex < 0) {
				return A2(
					$elm$core$Array$builderToArray,
					false,
					{nodeList: nodeList, nodeListSize: (len / $elm$core$Array$branchFactor) | 0, tail: tail});
			} else {
				var leaf = $elm$core$Array$Leaf(
					A3($elm$core$Elm$JsArray$initialize, $elm$core$Array$branchFactor, fromIndex, fn));
				var $temp$fn = fn,
					$temp$fromIndex = fromIndex - $elm$core$Array$branchFactor,
					$temp$len = len,
					$temp$nodeList = A2($elm$core$List$cons, leaf, nodeList),
					$temp$tail = tail;
				fn = $temp$fn;
				fromIndex = $temp$fromIndex;
				len = $temp$len;
				nodeList = $temp$nodeList;
				tail = $temp$tail;
				continue initializeHelp;
			}
		}
	});
var $elm$core$Basics$remainderBy = _Basics_remainderBy;
var $elm$core$Array$initialize = F2(
	function (len, fn) {
		if (len <= 0) {
			return $elm$core$Array$empty;
		} else {
			var tailLen = len % $elm$core$Array$branchFactor;
			var tail = A3($elm$core$Elm$JsArray$initialize, tailLen, len - tailLen, fn);
			var initialFromIndex = (len - tailLen) - $elm$core$Array$branchFactor;
			return A5($elm$core$Array$initializeHelp, fn, initialFromIndex, len, _List_Nil, tail);
		}
	});
var $elm$core$Basics$True = {$: 'True'};
var $elm$core$Result$isOk = function (result) {
	if (result.$ === 'Ok') {
		return true;
	} else {
		return false;
	}
};
var $elm$json$Json$Decode$andThen = _Json_andThen;
var $MartinSStewart$elm_audio$Audio$LoopConfig = F2(
	function (loopStart, loopEnd) {
		return {loopEnd: loopEnd, loopStart: loopStart};
	});
var $elm$core$Basics$identity = function (x) {
	return x;
};
var $ianmackenzie$elm_units$Quantity$Quantity = function (a) {
	return {$: 'Quantity', a: a};
};
var $ianmackenzie$elm_units$Quantity$zero = $ianmackenzie$elm_units$Quantity$Quantity(0);
var $MartinSStewart$elm_audio$Audio$audioDefaultConfig = {loop: $elm$core$Maybe$Nothing, playbackRate: 1, startAt: $ianmackenzie$elm_units$Quantity$zero};
var $MartinSStewart$elm_audio$Audio$BasicAudio = function (a) {
	return {$: 'BasicAudio', a: a};
};
var $MartinSStewart$elm_audio$Audio$audioWithConfig = F3(
	function (audioSettings, source, startTime) {
		return $MartinSStewart$elm_audio$Audio$BasicAudio(
			{settings: audioSettings, source: source, startTime: startTime});
	});
var $MartinSStewart$elm_audio$Audio$audio = F2(
	function (source, startTime) {
		return A3($MartinSStewart$elm_audio$Audio$audioWithConfig, $MartinSStewart$elm_audio$Audio$audioDefaultConfig, source, startTime);
	});
var $MartinSStewart$elm_audio$Audio$audioSourceBufferId = function (_v0) {
	var audioSource = _v0.a;
	return audioSource.bufferId;
};
var $elm$core$Basics$compare = _Utils_compare;
var $elm$core$Dict$get = F2(
	function (targetKey, dict) {
		get:
		while (true) {
			if (dict.$ === 'RBEmpty_elm_builtin') {
				return $elm$core$Maybe$Nothing;
			} else {
				var key = dict.b;
				var value = dict.c;
				var left = dict.d;
				var right = dict.e;
				var _v1 = A2($elm$core$Basics$compare, targetKey, key);
				switch (_v1.$) {
					case 'LT':
						var $temp$targetKey = targetKey,
							$temp$dict = left;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
					case 'EQ':
						return $elm$core$Maybe$Just(value);
					default:
						var $temp$targetKey = targetKey,
							$temp$dict = right;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
				}
			}
		}
	});
var $elm$core$Maybe$map = F2(
	function (f, maybe) {
		if (maybe.$ === 'Just') {
			var value = maybe.a;
			return $elm$core$Maybe$Just(
				f(value));
		} else {
			return $elm$core$Maybe$Nothing;
		}
	});
var $MartinSStewart$elm_audio$Audio$rawBufferId = function (_v0) {
	var bufferId = _v0.a;
	return bufferId;
};
var $elm$core$Maybe$withDefault = F2(
	function (_default, maybe) {
		if (maybe.$ === 'Just') {
			var value = maybe.a;
			return value;
		} else {
			return _default;
		}
	});
var $MartinSStewart$elm_audio$Audio$length = F2(
	function (_v0, source) {
		var audioData_ = _v0.a;
		return A2(
			$elm$core$Maybe$withDefault,
			$ianmackenzie$elm_units$Quantity$zero,
			A2(
				$elm$core$Maybe$map,
				function ($) {
					return $.duration;
				},
				A2(
					$elm$core$Dict$get,
					$MartinSStewart$elm_audio$Audio$rawBufferId(
						$MartinSStewart$elm_audio$Audio$audioSourceBufferId(source)),
					audioData_.sourceData)));
	});
var $elm$core$List$foldrHelper = F4(
	function (fn, acc, ctr, ls) {
		if (!ls.b) {
			return acc;
		} else {
			var a = ls.a;
			var r1 = ls.b;
			if (!r1.b) {
				return A2(fn, a, acc);
			} else {
				var b = r1.a;
				var r2 = r1.b;
				if (!r2.b) {
					return A2(
						fn,
						a,
						A2(fn, b, acc));
				} else {
					var c = r2.a;
					var r3 = r2.b;
					if (!r3.b) {
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(fn, c, acc)));
					} else {
						var d = r3.a;
						var r4 = r3.b;
						var res = (ctr > 500) ? A3(
							$elm$core$List$foldl,
							fn,
							acc,
							$elm$core$List$reverse(r4)) : A4($elm$core$List$foldrHelper, fn, acc, ctr + 1, r4);
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(
									fn,
									c,
									A2(fn, d, res))));
					}
				}
			}
		}
	});
var $elm$core$List$foldr = F3(
	function (fn, acc, ls) {
		return A4($elm$core$List$foldrHelper, fn, acc, 0, ls);
	});
var $elm$core$List$map = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (x, acc) {
					return A2(
						$elm$core$List$cons,
						f(x),
						acc);
				}),
			_List_Nil,
			xs);
	});
var $ianmackenzie$elm_units$Duration$seconds = function (numSeconds) {
	return $ianmackenzie$elm_units$Quantity$Quantity(numSeconds);
};
var $author$project$Lib$Audio$Audio$getAudio = F2(
	function (ad, repo) {
		return A2(
			$elm$core$List$map,
			function (_v0) {
				var sound = _v0.b;
				var _v1 = _v0.c;
				var opt = _v1.a;
				var s = _v1.b;
				if (opt.$ === 'ALoop') {
					var _default = $MartinSStewart$elm_audio$Audio$audioDefaultConfig;
					return A3(
						$MartinSStewart$elm_audio$Audio$audioWithConfig,
						_Utils_update(
							_default,
							{
								loop: $elm$core$Maybe$Just(
									A2(
										$MartinSStewart$elm_audio$Audio$LoopConfig,
										$ianmackenzie$elm_units$Duration$seconds(0),
										A2($MartinSStewart$elm_audio$Audio$length, ad, sound)))
							}),
						sound,
						s);
				} else {
					return A2($MartinSStewart$elm_audio$Audio$audio, sound, s);
				}
			},
			repo);
	});
var $MartinSStewart$elm_audio$Audio$Group = function (a) {
	return {$: 'Group', a: a};
};
var $MartinSStewart$elm_audio$Audio$group = function (audios) {
	return $MartinSStewart$elm_audio$Audio$Group(audios);
};
var $MartinSStewart$elm_audio$Audio$Effect = function (a) {
	return {$: 'Effect', a: a};
};
var $MartinSStewart$elm_audio$Audio$ScaleVolume = function (a) {
	return {$: 'ScaleVolume', a: a};
};
var $MartinSStewart$elm_audio$Audio$scaleVolume = F2(
	function (scaleBy, audio_) {
		return $MartinSStewart$elm_audio$Audio$Effect(
			{
				audio: audio_,
				effectType: $MartinSStewart$elm_audio$Audio$ScaleVolume(
					{
						scaleBy: A2($elm$core$Basics$max, 0, scaleBy)
					})
			});
	});
var $author$project$Common$audio = F2(
	function (ad, model) {
		return A2(
			$MartinSStewart$elm_audio$Audio$scaleVolume,
			model.currentGlobalData.audioVolume,
			$MartinSStewart$elm_audio$Audio$group(
				A2($author$project$Lib$Audio$Audio$getAudio, ad, model.audiorepo)));
	});
var $elm$json$Json$Decode$value = _Json_decodeValue;
var $author$project$Main$audioPortFromJS = _Platform_incomingPort('audioPortFromJS', $elm$json$Json$Decode$value);
var $author$project$Main$audioPortToJS = _Platform_outgoingPort('audioPortToJS', $elm$core$Basics$identity);
var $MartinSStewart$elm_audio$Audio$UserMsg = function (a) {
	return {$: 'UserMsg', a: a};
};
var $MartinSStewart$elm_audio$Audio$AudioData = function (a) {
	return {$: 'AudioData', a: a};
};
var $MartinSStewart$elm_audio$Audio$audioData = function (_v0) {
	var model = _v0.a;
	return $MartinSStewart$elm_audio$Audio$AudioData(
		{sourceData: model.sourceData});
};
var $elm$core$Basics$composeR = F3(
	function (f, g, x) {
		return g(
			f(x));
	});
var $elm$json$Json$Decode$map = _Json_map1;
var $elm$json$Json$Decode$map2 = _Json_map2;
var $elm$json$Json$Decode$succeed = _Json_succeed;
var $elm$virtual_dom$VirtualDom$toHandlerInt = function (handler) {
	switch (handler.$) {
		case 'Normal':
			return 0;
		case 'MayStopPropagation':
			return 1;
		case 'MayPreventDefault':
			return 2;
		default:
			return 3;
	}
};
var $elm$browser$Browser$External = function (a) {
	return {$: 'External', a: a};
};
var $elm$browser$Browser$Internal = function (a) {
	return {$: 'Internal', a: a};
};
var $elm$browser$Browser$Dom$NotFound = function (a) {
	return {$: 'NotFound', a: a};
};
var $elm$url$Url$Http = {$: 'Http'};
var $elm$url$Url$Https = {$: 'Https'};
var $elm$url$Url$Url = F6(
	function (protocol, host, port_, path, query, fragment) {
		return {fragment: fragment, host: host, path: path, port_: port_, protocol: protocol, query: query};
	});
var $elm$core$String$contains = _String_contains;
var $elm$core$String$length = _String_length;
var $elm$core$String$slice = _String_slice;
var $elm$core$String$dropLeft = F2(
	function (n, string) {
		return (n < 1) ? string : A3(
			$elm$core$String$slice,
			n,
			$elm$core$String$length(string),
			string);
	});
var $elm$core$String$indexes = _String_indexes;
var $elm$core$String$isEmpty = function (string) {
	return string === '';
};
var $elm$core$String$left = F2(
	function (n, string) {
		return (n < 1) ? '' : A3($elm$core$String$slice, 0, n, string);
	});
var $elm$core$String$toInt = _String_toInt;
var $elm$url$Url$chompBeforePath = F5(
	function (protocol, path, params, frag, str) {
		if ($elm$core$String$isEmpty(str) || A2($elm$core$String$contains, '@', str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, ':', str);
			if (!_v0.b) {
				return $elm$core$Maybe$Just(
					A6($elm$url$Url$Url, protocol, str, $elm$core$Maybe$Nothing, path, params, frag));
			} else {
				if (!_v0.b.b) {
					var i = _v0.a;
					var _v1 = $elm$core$String$toInt(
						A2($elm$core$String$dropLeft, i + 1, str));
					if (_v1.$ === 'Nothing') {
						return $elm$core$Maybe$Nothing;
					} else {
						var port_ = _v1;
						return $elm$core$Maybe$Just(
							A6(
								$elm$url$Url$Url,
								protocol,
								A2($elm$core$String$left, i, str),
								port_,
								path,
								params,
								frag));
					}
				} else {
					return $elm$core$Maybe$Nothing;
				}
			}
		}
	});
var $elm$url$Url$chompBeforeQuery = F4(
	function (protocol, params, frag, str) {
		if ($elm$core$String$isEmpty(str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, '/', str);
			if (!_v0.b) {
				return A5($elm$url$Url$chompBeforePath, protocol, '/', params, frag, str);
			} else {
				var i = _v0.a;
				return A5(
					$elm$url$Url$chompBeforePath,
					protocol,
					A2($elm$core$String$dropLeft, i, str),
					params,
					frag,
					A2($elm$core$String$left, i, str));
			}
		}
	});
var $elm$url$Url$chompBeforeFragment = F3(
	function (protocol, frag, str) {
		if ($elm$core$String$isEmpty(str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, '?', str);
			if (!_v0.b) {
				return A4($elm$url$Url$chompBeforeQuery, protocol, $elm$core$Maybe$Nothing, frag, str);
			} else {
				var i = _v0.a;
				return A4(
					$elm$url$Url$chompBeforeQuery,
					protocol,
					$elm$core$Maybe$Just(
						A2($elm$core$String$dropLeft, i + 1, str)),
					frag,
					A2($elm$core$String$left, i, str));
			}
		}
	});
var $elm$url$Url$chompAfterProtocol = F2(
	function (protocol, str) {
		if ($elm$core$String$isEmpty(str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, '#', str);
			if (!_v0.b) {
				return A3($elm$url$Url$chompBeforeFragment, protocol, $elm$core$Maybe$Nothing, str);
			} else {
				var i = _v0.a;
				return A3(
					$elm$url$Url$chompBeforeFragment,
					protocol,
					$elm$core$Maybe$Just(
						A2($elm$core$String$dropLeft, i + 1, str)),
					A2($elm$core$String$left, i, str));
			}
		}
	});
var $elm$core$String$startsWith = _String_startsWith;
var $elm$url$Url$fromString = function (str) {
	return A2($elm$core$String$startsWith, 'http://', str) ? A2(
		$elm$url$Url$chompAfterProtocol,
		$elm$url$Url$Http,
		A2($elm$core$String$dropLeft, 7, str)) : (A2($elm$core$String$startsWith, 'https://', str) ? A2(
		$elm$url$Url$chompAfterProtocol,
		$elm$url$Url$Https,
		A2($elm$core$String$dropLeft, 8, str)) : $elm$core$Maybe$Nothing);
};
var $elm$core$Basics$never = function (_v0) {
	never:
	while (true) {
		var nvr = _v0.a;
		var $temp$_v0 = nvr;
		_v0 = $temp$_v0;
		continue never;
	}
};
var $elm$core$Task$Perform = function (a) {
	return {$: 'Perform', a: a};
};
var $elm$core$Task$succeed = _Scheduler_succeed;
var $elm$core$Task$init = $elm$core$Task$succeed(_Utils_Tuple0);
var $elm$core$Task$andThen = _Scheduler_andThen;
var $elm$core$Task$map = F2(
	function (func, taskA) {
		return A2(
			$elm$core$Task$andThen,
			function (a) {
				return $elm$core$Task$succeed(
					func(a));
			},
			taskA);
	});
var $elm$core$Task$map2 = F3(
	function (func, taskA, taskB) {
		return A2(
			$elm$core$Task$andThen,
			function (a) {
				return A2(
					$elm$core$Task$andThen,
					function (b) {
						return $elm$core$Task$succeed(
							A2(func, a, b));
					},
					taskB);
			},
			taskA);
	});
var $elm$core$Task$sequence = function (tasks) {
	return A3(
		$elm$core$List$foldr,
		$elm$core$Task$map2($elm$core$List$cons),
		$elm$core$Task$succeed(_List_Nil),
		tasks);
};
var $elm$core$Platform$sendToApp = _Platform_sendToApp;
var $elm$core$Task$spawnCmd = F2(
	function (router, _v0) {
		var task = _v0.a;
		return _Scheduler_spawn(
			A2(
				$elm$core$Task$andThen,
				$elm$core$Platform$sendToApp(router),
				task));
	});
var $elm$core$Task$onEffects = F3(
	function (router, commands, state) {
		return A2(
			$elm$core$Task$map,
			function (_v0) {
				return _Utils_Tuple0;
			},
			$elm$core$Task$sequence(
				A2(
					$elm$core$List$map,
					$elm$core$Task$spawnCmd(router),
					commands)));
	});
var $elm$core$Task$onSelfMsg = F3(
	function (_v0, _v1, _v2) {
		return $elm$core$Task$succeed(_Utils_Tuple0);
	});
var $elm$core$Task$cmdMap = F2(
	function (tagger, _v0) {
		var task = _v0.a;
		return $elm$core$Task$Perform(
			A2($elm$core$Task$map, tagger, task));
	});
_Platform_effectManagers['Task'] = _Platform_createManager($elm$core$Task$init, $elm$core$Task$onEffects, $elm$core$Task$onSelfMsg, $elm$core$Task$cmdMap);
var $elm$core$Task$command = _Platform_leaf('Task');
var $elm$core$Task$perform = F2(
	function (toMessage, task) {
		return $elm$core$Task$command(
			$elm$core$Task$Perform(
				A2($elm$core$Task$map, toMessage, task)));
	});
var $elm$browser$Browser$element = _Browser_element;
var $MartinSStewart$elm_audio$Audio$getUserModel = function (_v0) {
	var model = _v0.a;
	return model.userModel;
};
var $MartinSStewart$elm_audio$Audio$Model = function (a) {
	return {$: 'Model', a: a};
};
var $elm$core$Platform$Cmd$batch = _Platform_batch;
var $ianmackenzie$elm_units$Duration$inSeconds = function (_v0) {
	var numSeconds = _v0.a;
	return numSeconds;
};
var $ianmackenzie$elm_units$Duration$inMilliseconds = function (duration) {
	return $ianmackenzie$elm_units$Duration$inSeconds(duration) * 1000;
};
var $elm$time$Time$Posix = function (a) {
	return {$: 'Posix', a: a};
};
var $elm$time$Time$millisToPosix = $elm$time$Time$Posix;
var $elm$time$Time$posixToMillis = function (_v0) {
	var millis = _v0.a;
	return millis;
};
var $elm$core$Basics$round = _Basics_round;
var $ianmackenzie$elm_units$Duration$addTo = F2(
	function (time, duration) {
		return $elm$time$Time$millisToPosix(
			$elm$time$Time$posixToMillis(time) + $elm$core$Basics$round(
				$ianmackenzie$elm_units$Duration$inMilliseconds(duration)));
	});
var $MartinSStewart$elm_audio$Audio$audioStartTime = function (audio_) {
	return A2($ianmackenzie$elm_units$Duration$addTo, audio_.startTime, audio_.offset);
};
var $elm$json$Json$Encode$int = _Json_wrap;
var $MartinSStewart$elm_audio$Audio$encodeBufferId = function (_v0) {
	var bufferId = _v0.a;
	return $elm$json$Json$Encode$int(bufferId);
};
var $elm$json$Json$Encode$float = _Json_wrap;
var $MartinSStewart$elm_audio$Audio$encodeDuration = A2($elm$core$Basics$composeR, $ianmackenzie$elm_units$Duration$inMilliseconds, $elm$json$Json$Encode$float);
var $elm$json$Json$Encode$null = _Json_encodeNull;
var $elm$json$Json$Encode$object = function (pairs) {
	return _Json_wrap(
		A3(
			$elm$core$List$foldl,
			F2(
				function (_v0, obj) {
					var k = _v0.a;
					var v = _v0.b;
					return A3(_Json_addField, k, v, obj);
				}),
			_Json_emptyObject(_Utils_Tuple0),
			pairs));
};
var $MartinSStewart$elm_audio$Audio$encodeLoopConfig = function (maybeLoop) {
	if (maybeLoop.$ === 'Just') {
		var loop = maybeLoop.a;
		return $elm$json$Json$Encode$object(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'loopStart',
					$MartinSStewart$elm_audio$Audio$encodeDuration(loop.loopStart)),
					_Utils_Tuple2(
					'loopEnd',
					$MartinSStewart$elm_audio$Audio$encodeDuration(loop.loopEnd))
				]));
	} else {
		return $elm$json$Json$Encode$null;
	}
};
var $MartinSStewart$elm_audio$Audio$encodeTime = A2($elm$core$Basics$composeR, $elm$time$Time$posixToMillis, $elm$json$Json$Encode$int);
var $elm$json$Json$Encode$list = F2(
	function (func, entries) {
		return _Json_wrap(
			A3(
				$elm$core$List$foldl,
				_Json_addEntry(func),
				_Json_emptyArray(_Utils_Tuple0),
				entries));
	});
var $mgold$elm_nonempty_list$List$Nonempty$toList = function (_v0) {
	var x = _v0.a;
	var xs = _v0.b;
	return A2($elm$core$List$cons, x, xs);
};
var $MartinSStewart$elm_audio$Audio$encodeVolumeTimeline = function (volumeTimeline) {
	return A2(
		$elm$json$Json$Encode$list,
		function (_v0) {
			var time = _v0.a;
			var volume = _v0.b;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'time',
						$MartinSStewart$elm_audio$Audio$encodeTime(time)),
						_Utils_Tuple2(
						'volume',
						$elm$json$Json$Encode$float(volume))
					]));
		},
		$mgold$elm_nonempty_list$List$Nonempty$toList(volumeTimeline));
};
var $elm$json$Json$Encode$string = _Json_wrap;
var $mgold$elm_nonempty_list$List$Nonempty$Nonempty = F2(
	function (a, b) {
		return {$: 'Nonempty', a: a, b: b};
	});
var $mgold$elm_nonempty_list$List$Nonempty$map = F2(
	function (f, _v0) {
		var x = _v0.a;
		var xs = _v0.b;
		return A2(
			$mgold$elm_nonempty_list$List$Nonempty$Nonempty,
			f(x),
			A2($elm$core$List$map, f, xs));
	});
var $elm$core$Tuple$mapFirst = F2(
	function (func, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		return _Utils_Tuple2(
			func(x),
			y);
	});
var $MartinSStewart$elm_audio$Audio$volumeTimelines = function (audio_) {
	return A2(
		$elm$core$List$map,
		$mgold$elm_nonempty_list$List$Nonempty$map(
			$elm$core$Tuple$mapFirst(
				function (a) {
					return A2($ianmackenzie$elm_units$Duration$addTo, a, audio_.offset);
				})),
		audio_.volumeTimelines);
};
var $MartinSStewart$elm_audio$Audio$encodeStartSound = F2(
	function (nodeGroupId, audio_) {
		return $elm$json$Json$Encode$object(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'action',
					$elm$json$Json$Encode$string('startSound')),
					_Utils_Tuple2(
					'nodeGroupId',
					$elm$json$Json$Encode$int(nodeGroupId)),
					_Utils_Tuple2(
					'bufferId',
					$MartinSStewart$elm_audio$Audio$encodeBufferId(
						$MartinSStewart$elm_audio$Audio$audioSourceBufferId(audio_.source))),
					_Utils_Tuple2(
					'startTime',
					$MartinSStewart$elm_audio$Audio$encodeTime(
						$MartinSStewart$elm_audio$Audio$audioStartTime(audio_))),
					_Utils_Tuple2(
					'startAt',
					$MartinSStewart$elm_audio$Audio$encodeDuration(audio_.startAt)),
					_Utils_Tuple2(
					'volume',
					$elm$json$Json$Encode$float(audio_.volume)),
					_Utils_Tuple2(
					'volumeTimelines',
					A2(
						$elm$json$Json$Encode$list,
						$MartinSStewart$elm_audio$Audio$encodeVolumeTimeline,
						$MartinSStewart$elm_audio$Audio$volumeTimelines(audio_))),
					_Utils_Tuple2(
					'loop',
					$MartinSStewart$elm_audio$Audio$encodeLoopConfig(audio_.loop)),
					_Utils_Tuple2(
					'playbackRate',
					$elm$json$Json$Encode$float(audio_.playbackRate))
				]));
	});
var $elm$core$List$append = F2(
	function (xs, ys) {
		if (!ys.b) {
			return xs;
		} else {
			return A3($elm$core$List$foldr, $elm$core$List$cons, ys, xs);
		}
	});
var $elm$core$List$concat = function (lists) {
	return A3($elm$core$List$foldr, $elm$core$List$append, _List_Nil, lists);
};
var $ianmackenzie$elm_units$Quantity$plus = F2(
	function (_v0, _v1) {
		var y = _v0.a;
		var x = _v1.a;
		return $ianmackenzie$elm_units$Quantity$Quantity(x + y);
	});
var $MartinSStewart$elm_audio$Audio$flattenAudio = function (audio_) {
	switch (audio_.$) {
		case 'Group':
			var group_ = audio_.a;
			return $elm$core$List$concat(
				A2($elm$core$List$map, $MartinSStewart$elm_audio$Audio$flattenAudio, group_));
		case 'BasicAudio':
			var source = audio_.a.source;
			var startTime = audio_.a.startTime;
			var settings = audio_.a.settings;
			return _List_fromArray(
				[
					{loop: settings.loop, offset: $ianmackenzie$elm_units$Quantity$zero, playbackRate: settings.playbackRate, source: source, startAt: settings.startAt, startTime: startTime, volume: 1, volumeTimelines: _List_Nil}
				]);
		default:
			var effect = audio_.a;
			var _v1 = effect.effectType;
			switch (_v1.$) {
				case 'ScaleVolume':
					var scaleVolume_ = _v1.a;
					return A2(
						$elm$core$List$map,
						function (a) {
							return _Utils_update(
								a,
								{volume: scaleVolume_.scaleBy * a.volume});
						},
						$MartinSStewart$elm_audio$Audio$flattenAudio(effect.audio));
				case 'ScaleVolumeAt':
					var volumeAt = _v1.a.volumeAt;
					return A2(
						$elm$core$List$map,
						function (a) {
							return _Utils_update(
								a,
								{
									volumeTimelines: A2($elm$core$List$cons, volumeAt, a.volumeTimelines)
								});
						},
						$MartinSStewart$elm_audio$Audio$flattenAudio(effect.audio));
				default:
					var duration = _v1.a;
					return A2(
						$elm$core$List$map,
						function (a) {
							return _Utils_update(
								a,
								{
									offset: A2($ianmackenzie$elm_units$Quantity$plus, duration, a.offset)
								});
						},
						$MartinSStewart$elm_audio$Audio$flattenAudio(effect.audio));
			}
	}
};
var $elm$core$Dict$Black = {$: 'Black'};
var $elm$core$Dict$RBNode_elm_builtin = F5(
	function (a, b, c, d, e) {
		return {$: 'RBNode_elm_builtin', a: a, b: b, c: c, d: d, e: e};
	});
var $elm$core$Dict$RBEmpty_elm_builtin = {$: 'RBEmpty_elm_builtin'};
var $elm$core$Dict$Red = {$: 'Red'};
var $elm$core$Dict$balance = F5(
	function (color, key, value, left, right) {
		if ((right.$ === 'RBNode_elm_builtin') && (right.a.$ === 'Red')) {
			var _v1 = right.a;
			var rK = right.b;
			var rV = right.c;
			var rLeft = right.d;
			var rRight = right.e;
			if ((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) {
				var _v3 = left.a;
				var lK = left.b;
				var lV = left.c;
				var lLeft = left.d;
				var lRight = left.e;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Red,
					key,
					value,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					color,
					rK,
					rV,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, key, value, left, rLeft),
					rRight);
			}
		} else {
			if ((((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) && (left.d.$ === 'RBNode_elm_builtin')) && (left.d.a.$ === 'Red')) {
				var _v5 = left.a;
				var lK = left.b;
				var lV = left.c;
				var _v6 = left.d;
				var _v7 = _v6.a;
				var llK = _v6.b;
				var llV = _v6.c;
				var llLeft = _v6.d;
				var llRight = _v6.e;
				var lRight = left.e;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Red,
					lK,
					lV,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, llK, llV, llLeft, llRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, key, value, lRight, right));
			} else {
				return A5($elm$core$Dict$RBNode_elm_builtin, color, key, value, left, right);
			}
		}
	});
var $elm$core$Dict$insertHelp = F3(
	function (key, value, dict) {
		if (dict.$ === 'RBEmpty_elm_builtin') {
			return A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, key, value, $elm$core$Dict$RBEmpty_elm_builtin, $elm$core$Dict$RBEmpty_elm_builtin);
		} else {
			var nColor = dict.a;
			var nKey = dict.b;
			var nValue = dict.c;
			var nLeft = dict.d;
			var nRight = dict.e;
			var _v1 = A2($elm$core$Basics$compare, key, nKey);
			switch (_v1.$) {
				case 'LT':
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						A3($elm$core$Dict$insertHelp, key, value, nLeft),
						nRight);
				case 'EQ':
					return A5($elm$core$Dict$RBNode_elm_builtin, nColor, nKey, value, nLeft, nRight);
				default:
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						nLeft,
						A3($elm$core$Dict$insertHelp, key, value, nRight));
			}
		}
	});
var $elm$core$Dict$insert = F3(
	function (key, value, dict) {
		var _v0 = A3($elm$core$Dict$insertHelp, key, value, dict);
		if ((_v0.$ === 'RBNode_elm_builtin') && (_v0.a.$ === 'Red')) {
			var _v1 = _v0.a;
			var k = _v0.b;
			var v = _v0.c;
			var l = _v0.d;
			var r = _v0.e;
			return A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, k, v, l, r);
		} else {
			var x = _v0;
			return x;
		}
	});
var $MartinSStewart$elm_audio$Audio$encodeSetLoopConfig = F2(
	function (nodeGroupId, loop) {
		return $elm$json$Json$Encode$object(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'nodeGroupId',
					$elm$json$Json$Encode$int(nodeGroupId)),
					_Utils_Tuple2(
					'action',
					$elm$json$Json$Encode$string('setLoopConfig')),
					_Utils_Tuple2(
					'loop',
					$MartinSStewart$elm_audio$Audio$encodeLoopConfig(loop))
				]));
	});
var $MartinSStewart$elm_audio$Audio$encodeSetPlaybackRate = F2(
	function (nodeGroupId, playbackRate) {
		return $elm$json$Json$Encode$object(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'nodeGroupId',
					$elm$json$Json$Encode$int(nodeGroupId)),
					_Utils_Tuple2(
					'action',
					$elm$json$Json$Encode$string('setPlaybackRate')),
					_Utils_Tuple2(
					'playbackRate',
					$elm$json$Json$Encode$float(playbackRate))
				]));
	});
var $MartinSStewart$elm_audio$Audio$encodeSetVolume = F2(
	function (nodeGroupId, volume) {
		return $elm$json$Json$Encode$object(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'nodeGroupId',
					$elm$json$Json$Encode$int(nodeGroupId)),
					_Utils_Tuple2(
					'action',
					$elm$json$Json$Encode$string('setVolume')),
					_Utils_Tuple2(
					'volume',
					$elm$json$Json$Encode$float(volume))
				]));
	});
var $MartinSStewart$elm_audio$Audio$encodeSetVolumeAt = F2(
	function (nodeGroupId, volumeTimelines_) {
		return $elm$json$Json$Encode$object(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'nodeGroupId',
					$elm$json$Json$Encode$int(nodeGroupId)),
					_Utils_Tuple2(
					'action',
					$elm$json$Json$Encode$string('setVolumeAt')),
					_Utils_Tuple2(
					'volumeAt',
					A2($elm$json$Json$Encode$list, $MartinSStewart$elm_audio$Audio$encodeVolumeTimeline, volumeTimelines_))
				]));
	});
var $MartinSStewart$elm_audio$Audio$encodeStopSound = function (nodeGroupId) {
	return $elm$json$Json$Encode$object(
		_List_fromArray(
			[
				_Utils_Tuple2(
				'action',
				$elm$json$Json$Encode$string('stopSound')),
				_Utils_Tuple2(
				'nodeGroupId',
				$elm$json$Json$Encode$int(nodeGroupId))
			]));
};
var $elm$core$List$filter = F2(
	function (isGood, list) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (x, xs) {
					return isGood(x) ? A2($elm$core$List$cons, x, xs) : xs;
				}),
			_List_Nil,
			list);
	});
var $elm$core$List$maybeCons = F3(
	function (f, mx, xs) {
		var _v0 = f(mx);
		if (_v0.$ === 'Just') {
			var x = _v0.a;
			return A2($elm$core$List$cons, x, xs);
		} else {
			return xs;
		}
	});
var $elm$core$List$filterMap = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$foldr,
			$elm$core$List$maybeCons(f),
			_List_Nil,
			xs);
	});
var $MartinSStewart$elm_audio$Audio$find = F2(
	function (predicate, list) {
		find:
		while (true) {
			if (!list.b) {
				return $elm$core$Maybe$Nothing;
			} else {
				var first = list.a;
				var rest = list.b;
				if (predicate(first)) {
					return $elm$core$Maybe$Just(first);
				} else {
					var $temp$predicate = predicate,
						$temp$list = rest;
					predicate = $temp$predicate;
					list = $temp$list;
					continue find;
				}
			}
		}
	});
var $elm$core$Tuple$pair = F2(
	function (a, b) {
		return _Utils_Tuple2(a, b);
	});
var $elm$core$Dict$getMin = function (dict) {
	getMin:
	while (true) {
		if ((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) {
			var left = dict.d;
			var $temp$dict = left;
			dict = $temp$dict;
			continue getMin;
		} else {
			return dict;
		}
	}
};
var $elm$core$Dict$moveRedLeft = function (dict) {
	if (((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) && (dict.e.$ === 'RBNode_elm_builtin')) {
		if ((dict.e.d.$ === 'RBNode_elm_builtin') && (dict.e.d.a.$ === 'Red')) {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v1 = dict.d;
			var lClr = _v1.a;
			var lK = _v1.b;
			var lV = _v1.c;
			var lLeft = _v1.d;
			var lRight = _v1.e;
			var _v2 = dict.e;
			var rClr = _v2.a;
			var rK = _v2.b;
			var rV = _v2.c;
			var rLeft = _v2.d;
			var _v3 = rLeft.a;
			var rlK = rLeft.b;
			var rlV = rLeft.c;
			var rlL = rLeft.d;
			var rlR = rLeft.e;
			var rRight = _v2.e;
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				$elm$core$Dict$Red,
				rlK,
				rlV,
				A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					rlL),
				A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, rK, rV, rlR, rRight));
		} else {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v4 = dict.d;
			var lClr = _v4.a;
			var lK = _v4.b;
			var lV = _v4.c;
			var lLeft = _v4.d;
			var lRight = _v4.e;
			var _v5 = dict.e;
			var rClr = _v5.a;
			var rK = _v5.b;
			var rV = _v5.c;
			var rLeft = _v5.d;
			var rRight = _v5.e;
			if (clr.$ === 'Black') {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			}
		}
	} else {
		return dict;
	}
};
var $elm$core$Dict$moveRedRight = function (dict) {
	if (((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) && (dict.e.$ === 'RBNode_elm_builtin')) {
		if ((dict.d.d.$ === 'RBNode_elm_builtin') && (dict.d.d.a.$ === 'Red')) {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v1 = dict.d;
			var lClr = _v1.a;
			var lK = _v1.b;
			var lV = _v1.c;
			var _v2 = _v1.d;
			var _v3 = _v2.a;
			var llK = _v2.b;
			var llV = _v2.c;
			var llLeft = _v2.d;
			var llRight = _v2.e;
			var lRight = _v1.e;
			var _v4 = dict.e;
			var rClr = _v4.a;
			var rK = _v4.b;
			var rV = _v4.c;
			var rLeft = _v4.d;
			var rRight = _v4.e;
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				$elm$core$Dict$Red,
				lK,
				lV,
				A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, llK, llV, llLeft, llRight),
				A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					lRight,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight)));
		} else {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v5 = dict.d;
			var lClr = _v5.a;
			var lK = _v5.b;
			var lV = _v5.c;
			var lLeft = _v5.d;
			var lRight = _v5.e;
			var _v6 = dict.e;
			var rClr = _v6.a;
			var rK = _v6.b;
			var rV = _v6.c;
			var rLeft = _v6.d;
			var rRight = _v6.e;
			if (clr.$ === 'Black') {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			}
		}
	} else {
		return dict;
	}
};
var $elm$core$Dict$removeHelpPrepEQGT = F7(
	function (targetKey, dict, color, key, value, left, right) {
		if ((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) {
			var _v1 = left.a;
			var lK = left.b;
			var lV = left.c;
			var lLeft = left.d;
			var lRight = left.e;
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				color,
				lK,
				lV,
				lLeft,
				A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, key, value, lRight, right));
		} else {
			_v2$2:
			while (true) {
				if ((right.$ === 'RBNode_elm_builtin') && (right.a.$ === 'Black')) {
					if (right.d.$ === 'RBNode_elm_builtin') {
						if (right.d.a.$ === 'Black') {
							var _v3 = right.a;
							var _v4 = right.d;
							var _v5 = _v4.a;
							return $elm$core$Dict$moveRedRight(dict);
						} else {
							break _v2$2;
						}
					} else {
						var _v6 = right.a;
						var _v7 = right.d;
						return $elm$core$Dict$moveRedRight(dict);
					}
				} else {
					break _v2$2;
				}
			}
			return dict;
		}
	});
var $elm$core$Dict$removeMin = function (dict) {
	if ((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) {
		var color = dict.a;
		var key = dict.b;
		var value = dict.c;
		var left = dict.d;
		var lColor = left.a;
		var lLeft = left.d;
		var right = dict.e;
		if (lColor.$ === 'Black') {
			if ((lLeft.$ === 'RBNode_elm_builtin') && (lLeft.a.$ === 'Red')) {
				var _v3 = lLeft.a;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					color,
					key,
					value,
					$elm$core$Dict$removeMin(left),
					right);
			} else {
				var _v4 = $elm$core$Dict$moveRedLeft(dict);
				if (_v4.$ === 'RBNode_elm_builtin') {
					var nColor = _v4.a;
					var nKey = _v4.b;
					var nValue = _v4.c;
					var nLeft = _v4.d;
					var nRight = _v4.e;
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						$elm$core$Dict$removeMin(nLeft),
						nRight);
				} else {
					return $elm$core$Dict$RBEmpty_elm_builtin;
				}
			}
		} else {
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				color,
				key,
				value,
				$elm$core$Dict$removeMin(left),
				right);
		}
	} else {
		return $elm$core$Dict$RBEmpty_elm_builtin;
	}
};
var $elm$core$Dict$removeHelp = F2(
	function (targetKey, dict) {
		if (dict.$ === 'RBEmpty_elm_builtin') {
			return $elm$core$Dict$RBEmpty_elm_builtin;
		} else {
			var color = dict.a;
			var key = dict.b;
			var value = dict.c;
			var left = dict.d;
			var right = dict.e;
			if (_Utils_cmp(targetKey, key) < 0) {
				if ((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Black')) {
					var _v4 = left.a;
					var lLeft = left.d;
					if ((lLeft.$ === 'RBNode_elm_builtin') && (lLeft.a.$ === 'Red')) {
						var _v6 = lLeft.a;
						return A5(
							$elm$core$Dict$RBNode_elm_builtin,
							color,
							key,
							value,
							A2($elm$core$Dict$removeHelp, targetKey, left),
							right);
					} else {
						var _v7 = $elm$core$Dict$moveRedLeft(dict);
						if (_v7.$ === 'RBNode_elm_builtin') {
							var nColor = _v7.a;
							var nKey = _v7.b;
							var nValue = _v7.c;
							var nLeft = _v7.d;
							var nRight = _v7.e;
							return A5(
								$elm$core$Dict$balance,
								nColor,
								nKey,
								nValue,
								A2($elm$core$Dict$removeHelp, targetKey, nLeft),
								nRight);
						} else {
							return $elm$core$Dict$RBEmpty_elm_builtin;
						}
					}
				} else {
					return A5(
						$elm$core$Dict$RBNode_elm_builtin,
						color,
						key,
						value,
						A2($elm$core$Dict$removeHelp, targetKey, left),
						right);
				}
			} else {
				return A2(
					$elm$core$Dict$removeHelpEQGT,
					targetKey,
					A7($elm$core$Dict$removeHelpPrepEQGT, targetKey, dict, color, key, value, left, right));
			}
		}
	});
var $elm$core$Dict$removeHelpEQGT = F2(
	function (targetKey, dict) {
		if (dict.$ === 'RBNode_elm_builtin') {
			var color = dict.a;
			var key = dict.b;
			var value = dict.c;
			var left = dict.d;
			var right = dict.e;
			if (_Utils_eq(targetKey, key)) {
				var _v1 = $elm$core$Dict$getMin(right);
				if (_v1.$ === 'RBNode_elm_builtin') {
					var minKey = _v1.b;
					var minValue = _v1.c;
					return A5(
						$elm$core$Dict$balance,
						color,
						minKey,
						minValue,
						left,
						$elm$core$Dict$removeMin(right));
				} else {
					return $elm$core$Dict$RBEmpty_elm_builtin;
				}
			} else {
				return A5(
					$elm$core$Dict$balance,
					color,
					key,
					value,
					left,
					A2($elm$core$Dict$removeHelp, targetKey, right));
			}
		} else {
			return $elm$core$Dict$RBEmpty_elm_builtin;
		}
	});
var $elm$core$Dict$remove = F2(
	function (key, dict) {
		var _v0 = A2($elm$core$Dict$removeHelp, key, dict);
		if ((_v0.$ === 'RBNode_elm_builtin') && (_v0.a.$ === 'Red')) {
			var _v1 = _v0.a;
			var k = _v0.b;
			var v = _v0.c;
			var l = _v0.d;
			var r = _v0.e;
			return A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, k, v, l, r);
		} else {
			var x = _v0;
			return x;
		}
	});
var $elm$core$List$drop = F2(
	function (n, list) {
		drop:
		while (true) {
			if (n <= 0) {
				return list;
			} else {
				if (!list.b) {
					return list;
				} else {
					var x = list.a;
					var xs = list.b;
					var $temp$n = n - 1,
						$temp$list = xs;
					n = $temp$n;
					list = $temp$list;
					continue drop;
				}
			}
		}
	});
var $elm$core$List$tail = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(xs);
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $elm$core$List$takeReverse = F3(
	function (n, list, kept) {
		takeReverse:
		while (true) {
			if (n <= 0) {
				return kept;
			} else {
				if (!list.b) {
					return kept;
				} else {
					var x = list.a;
					var xs = list.b;
					var $temp$n = n - 1,
						$temp$list = xs,
						$temp$kept = A2($elm$core$List$cons, x, kept);
					n = $temp$n;
					list = $temp$list;
					kept = $temp$kept;
					continue takeReverse;
				}
			}
		}
	});
var $elm$core$List$takeTailRec = F2(
	function (n, list) {
		return $elm$core$List$reverse(
			A3($elm$core$List$takeReverse, n, list, _List_Nil));
	});
var $elm$core$List$takeFast = F3(
	function (ctr, n, list) {
		if (n <= 0) {
			return _List_Nil;
		} else {
			var _v0 = _Utils_Tuple2(n, list);
			_v0$1:
			while (true) {
				_v0$5:
				while (true) {
					if (!_v0.b.b) {
						return list;
					} else {
						if (_v0.b.b.b) {
							switch (_v0.a) {
								case 1:
									break _v0$1;
								case 2:
									var _v2 = _v0.b;
									var x = _v2.a;
									var _v3 = _v2.b;
									var y = _v3.a;
									return _List_fromArray(
										[x, y]);
								case 3:
									if (_v0.b.b.b.b) {
										var _v4 = _v0.b;
										var x = _v4.a;
										var _v5 = _v4.b;
										var y = _v5.a;
										var _v6 = _v5.b;
										var z = _v6.a;
										return _List_fromArray(
											[x, y, z]);
									} else {
										break _v0$5;
									}
								default:
									if (_v0.b.b.b.b && _v0.b.b.b.b.b) {
										var _v7 = _v0.b;
										var x = _v7.a;
										var _v8 = _v7.b;
										var y = _v8.a;
										var _v9 = _v8.b;
										var z = _v9.a;
										var _v10 = _v9.b;
										var w = _v10.a;
										var tl = _v10.b;
										return (ctr > 1000) ? A2(
											$elm$core$List$cons,
											x,
											A2(
												$elm$core$List$cons,
												y,
												A2(
													$elm$core$List$cons,
													z,
													A2(
														$elm$core$List$cons,
														w,
														A2($elm$core$List$takeTailRec, n - 4, tl))))) : A2(
											$elm$core$List$cons,
											x,
											A2(
												$elm$core$List$cons,
												y,
												A2(
													$elm$core$List$cons,
													z,
													A2(
														$elm$core$List$cons,
														w,
														A3($elm$core$List$takeFast, ctr + 1, n - 4, tl)))));
									} else {
										break _v0$5;
									}
							}
						} else {
							if (_v0.a === 1) {
								break _v0$1;
							} else {
								break _v0$5;
							}
						}
					}
				}
				return list;
			}
			var _v1 = _v0.b;
			var x = _v1.a;
			return _List_fromArray(
				[x]);
		}
	});
var $elm$core$List$take = F2(
	function (n, list) {
		return A3($elm$core$List$takeFast, 0, n, list);
	});
var $MartinSStewart$elm_audio$Audio$removeAt = F2(
	function (index, l) {
		if (index < 0) {
			return l;
		} else {
			var tail = $elm$core$List$tail(
				A2($elm$core$List$drop, index, l));
			var head = A2($elm$core$List$take, index, l);
			if (tail.$ === 'Nothing') {
				return l;
			} else {
				var t = tail.a;
				return A2($elm$core$List$append, head, t);
			}
		}
	});
var $MartinSStewart$elm_audio$Audio$updateAudioState = F2(
	function (_v0, _v1) {
		var nodeGroupId = _v0.a;
		var audioGroup = _v0.b;
		var flattenedAudio = _v1.a;
		var audioState = _v1.b;
		var json = _v1.c;
		var validAudio = A2(
			$elm$core$List$filter,
			function (_v7) {
				var a = _v7.b;
				return _Utils_eq(a.source, audioGroup.source) && (_Utils_eq(
					$MartinSStewart$elm_audio$Audio$audioStartTime(a),
					$MartinSStewart$elm_audio$Audio$audioStartTime(audioGroup)) && _Utils_eq(a.startAt, audioGroup.startAt));
			},
			A2($elm$core$List$indexedMap, $elm$core$Tuple$pair, flattenedAudio));
		var _v2 = A2(
			$MartinSStewart$elm_audio$Audio$find,
			function (_v3) {
				var a = _v3.b;
				return _Utils_eq(a, audioGroup);
			},
			validAudio);
		if (_v2.$ === 'Just') {
			var _v4 = _v2.a;
			var index = _v4.a;
			return _Utils_Tuple3(
				A2($MartinSStewart$elm_audio$Audio$removeAt, index, flattenedAudio),
				audioState,
				json);
		} else {
			if (validAudio.b) {
				var _v6 = validAudio.a;
				var index = _v6.a;
				var a = _v6.b;
				var encodeValue = F2(
					function (getter, encoder) {
						return _Utils_eq(
							getter(audioGroup),
							getter(a)) ? $elm$core$Maybe$Nothing : $elm$core$Maybe$Just(
							A2(
								encoder,
								nodeGroupId,
								getter(a)));
					});
				var effects = A2(
					$elm$core$List$filterMap,
					$elm$core$Basics$identity,
					_List_fromArray(
						[
							A2(
							encodeValue,
							function ($) {
								return $.volume;
							},
							$MartinSStewart$elm_audio$Audio$encodeSetVolume),
							A2(
							encodeValue,
							function ($) {
								return $.loop;
							},
							$MartinSStewart$elm_audio$Audio$encodeSetLoopConfig),
							A2(
							encodeValue,
							function ($) {
								return $.playbackRate;
							},
							$MartinSStewart$elm_audio$Audio$encodeSetPlaybackRate),
							A2(encodeValue, $MartinSStewart$elm_audio$Audio$volumeTimelines, $MartinSStewart$elm_audio$Audio$encodeSetVolumeAt)
						]));
				return _Utils_Tuple3(
					A2($MartinSStewart$elm_audio$Audio$removeAt, index, flattenedAudio),
					A3($elm$core$Dict$insert, nodeGroupId, a, audioState),
					_Utils_ap(effects, json));
			} else {
				return _Utils_Tuple3(
					flattenedAudio,
					A2($elm$core$Dict$remove, nodeGroupId, audioState),
					A2(
						$elm$core$List$cons,
						$MartinSStewart$elm_audio$Audio$encodeStopSound(nodeGroupId),
						json));
			}
		}
	});
var $MartinSStewart$elm_audio$Audio$diffAudioState = F3(
	function (nodeGroupIdCounter, audioState, newAudio) {
		var _v0 = A3(
			$elm$core$List$foldl,
			$MartinSStewart$elm_audio$Audio$updateAudioState,
			_Utils_Tuple3(
				$MartinSStewart$elm_audio$Audio$flattenAudio(newAudio),
				audioState,
				_List_Nil),
			$elm$core$Dict$toList(audioState));
		var newAudioLeft = _v0.a;
		var newAudioState = _v0.b;
		var json2 = _v0.c;
		var _v1 = A3(
			$elm$core$List$foldl,
			F2(
				function (audioLeft, _v2) {
					var counter = _v2.a;
					var audioState_ = _v2.b;
					var json_ = _v2.c;
					return _Utils_Tuple3(
						counter + 1,
						A3($elm$core$Dict$insert, counter, audioLeft, audioState_),
						A2(
							$elm$core$List$cons,
							A2($MartinSStewart$elm_audio$Audio$encodeStartSound, counter, audioLeft),
							json_));
				}),
			_Utils_Tuple3(nodeGroupIdCounter, newAudioState, json2),
			newAudioLeft);
		var newNodeGroupIdCounter = _v1.a;
		var newAudioState2 = _v1.b;
		var json3 = _v1.c;
		return _Utils_Tuple3(newAudioState2, newNodeGroupIdCounter, json3);
	});
var $elm$core$Dict$empty = $elm$core$Dict$RBEmpty_elm_builtin;
var $MartinSStewart$elm_audio$Audio$encodeAudioLoadRequest = F2(
	function (index, audioLoad) {
		return $elm$json$Json$Encode$object(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'audioUrl',
					$elm$json$Json$Encode$string(audioLoad.audioUrl)),
					_Utils_Tuple2(
					'requestId',
					$elm$json$Json$Encode$int(index))
				]));
	});
var $MartinSStewart$elm_audio$Audio$flattenAudioCmd = function (audioCmd) {
	if (audioCmd.$ === 'AudioLoadRequest') {
		var data = audioCmd.a;
		return _List_fromArray(
			[data]);
	} else {
		var list = audioCmd.a;
		return $elm$core$List$concat(
			A2($elm$core$List$map, $MartinSStewart$elm_audio$Audio$flattenAudioCmd, list));
	}
};
var $elm$core$Dict$fromList = function (assocs) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (_v0, dict) {
				var key = _v0.a;
				var value = _v0.b;
				return A3($elm$core$Dict$insert, key, value, dict);
			}),
		$elm$core$Dict$empty,
		assocs);
};
var $elm$core$Dict$foldl = F3(
	function (func, acc, dict) {
		foldl:
		while (true) {
			if (dict.$ === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var key = dict.b;
				var value = dict.c;
				var left = dict.d;
				var right = dict.e;
				var $temp$func = func,
					$temp$acc = A3(
					func,
					key,
					value,
					A3($elm$core$Dict$foldl, func, acc, left)),
					$temp$dict = right;
				func = $temp$func;
				acc = $temp$acc;
				dict = $temp$dict;
				continue foldl;
			}
		}
	});
var $elm$core$Dict$union = F2(
	function (t1, t2) {
		return A3($elm$core$Dict$foldl, $elm$core$Dict$insert, t2, t1);
	});
var $MartinSStewart$elm_audio$Audio$encodeAudioCmd = F2(
	function (_v0, audioCmd) {
		var model = _v0.a;
		var flattenedAudioCmd = $MartinSStewart$elm_audio$Audio$flattenAudioCmd(audioCmd);
		var newPendingRequests = A2(
			$elm$core$List$indexedMap,
			F2(
				function (index, request) {
					return _Utils_Tuple2(model.requestCount + index, request);
				}),
			flattenedAudioCmd);
		return _Utils_Tuple2(
			$MartinSStewart$elm_audio$Audio$Model(
				_Utils_update(
					model,
					{
						pendingRequests: A2(
							$elm$core$Dict$union,
							model.pendingRequests,
							$elm$core$Dict$fromList(newPendingRequests)),
						requestCount: model.requestCount + $elm$core$List$length(flattenedAudioCmd)
					})),
			A2(
				$elm$json$Json$Encode$list,
				$elm$core$Basics$identity,
				A2(
					$elm$core$List$map,
					function (_v1) {
						var index = _v1.a;
						var value = _v1.b;
						return A2($MartinSStewart$elm_audio$Audio$encodeAudioLoadRequest, index, value);
					},
					newPendingRequests)));
	});
var $elm$core$Platform$Cmd$map = _Platform_map;
var $MartinSStewart$elm_audio$Audio$initHelper = F3(
	function (audioPort, audioFunc, _v0) {
		var model = _v0.a;
		var cmds = _v0.b;
		var audioCmds = _v0.c;
		var _v1 = A3(
			$MartinSStewart$elm_audio$Audio$diffAudioState,
			0,
			$elm$core$Dict$empty,
			A2(
				audioFunc,
				$MartinSStewart$elm_audio$Audio$AudioData(
					{sourceData: $elm$core$Dict$empty}),
				model));
		var audioState = _v1.a;
		var newNodeGroupIdCounter = _v1.b;
		var json = _v1.c;
		var initialModel = $MartinSStewart$elm_audio$Audio$Model(
			{audioState: audioState, nodeGroupIdCounter: newNodeGroupIdCounter, pendingRequests: $elm$core$Dict$empty, requestCount: 0, samplesPerSecond: $elm$core$Maybe$Nothing, sourceData: $elm$core$Dict$empty, userModel: model});
		var _v2 = A2($MartinSStewart$elm_audio$Audio$encodeAudioCmd, initialModel, audioCmds);
		var initialModel2 = _v2.a;
		var audioRequests = _v2.b;
		var portMessage = $elm$json$Json$Encode$object(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'audio',
					A2($elm$json$Json$Encode$list, $elm$core$Basics$identity, json)),
					_Utils_Tuple2('audioCmds', audioRequests)
				]));
		return _Utils_Tuple2(
			initialModel2,
			$elm$core$Platform$Cmd$batch(
				_List_fromArray(
					[
						A2($elm$core$Platform$Cmd$map, $MartinSStewart$elm_audio$Audio$UserMsg, cmds),
						audioPort(portMessage)
					])));
	});
var $elm$virtual_dom$VirtualDom$map = _VirtualDom_map;
var $elm$html$Html$map = $elm$virtual_dom$VirtualDom$map;
var $elm$core$Platform$Sub$batch = _Platform_batch;
var $MartinSStewart$elm_audio$Audio$FromJSMsg = function (a) {
	return {$: 'FromJSMsg', a: a};
};
var $MartinSStewart$elm_audio$Audio$JsonParseError = function (a) {
	return {$: 'JsonParseError', a: a};
};
var $MartinSStewart$elm_audio$Audio$AudioLoadFailed = function (a) {
	return {$: 'AudioLoadFailed', a: a};
};
var $MartinSStewart$elm_audio$Audio$AudioLoadSuccess = function (a) {
	return {$: 'AudioLoadSuccess', a: a};
};
var $MartinSStewart$elm_audio$Audio$InitAudioContext = function (a) {
	return {$: 'InitAudioContext', a: a};
};
var $MartinSStewart$elm_audio$Audio$BufferId = function (a) {
	return {$: 'BufferId', a: a};
};
var $elm$json$Json$Decode$int = _Json_decodeInt;
var $MartinSStewart$elm_audio$Audio$decodeBufferId = A2($elm$json$Json$Decode$map, $MartinSStewart$elm_audio$Audio$BufferId, $elm$json$Json$Decode$int);
var $MartinSStewart$elm_audio$Audio$FailedToDecode = {$: 'FailedToDecode'};
var $MartinSStewart$elm_audio$Audio$NetworkError = {$: 'NetworkError'};
var $MartinSStewart$elm_audio$Audio$UnknownError = {$: 'UnknownError'};
var $elm$json$Json$Decode$string = _Json_decodeString;
var $MartinSStewart$elm_audio$Audio$decodeLoadError = A2(
	$elm$json$Json$Decode$andThen,
	function (value) {
		switch (value) {
			case 'NetworkError':
				return $elm$json$Json$Decode$succeed($MartinSStewart$elm_audio$Audio$NetworkError);
			case 'MediaDecodeAudioDataUnknownContentType':
				return $elm$json$Json$Decode$succeed($MartinSStewart$elm_audio$Audio$FailedToDecode);
			case 'DOMException: The buffer passed to decodeAudioData contains an unknown content type.':
				return $elm$json$Json$Decode$succeed($MartinSStewart$elm_audio$Audio$FailedToDecode);
			default:
				return $elm$json$Json$Decode$succeed($MartinSStewart$elm_audio$Audio$UnknownError);
		}
	},
	$elm$json$Json$Decode$string);
var $elm$json$Json$Decode$field = _Json_decodeField;
var $elm$json$Json$Decode$float = _Json_decodeFloat;
var $elm$json$Json$Decode$map3 = _Json_map3;
var $MartinSStewart$elm_audio$Audio$decodeFromJSMsg = A2(
	$elm$json$Json$Decode$andThen,
	function (value) {
		switch (value) {
			case 0:
				return A3(
					$elm$json$Json$Decode$map2,
					F2(
						function (requestId, error) {
							return $MartinSStewart$elm_audio$Audio$AudioLoadFailed(
								{error: error, requestId: requestId});
						}),
					A2($elm$json$Json$Decode$field, 'requestId', $elm$json$Json$Decode$int),
					A2($elm$json$Json$Decode$field, 'error', $MartinSStewart$elm_audio$Audio$decodeLoadError));
			case 1:
				return A4(
					$elm$json$Json$Decode$map3,
					F3(
						function (requestId, bufferId, duration) {
							return $MartinSStewart$elm_audio$Audio$AudioLoadSuccess(
								{
									bufferId: bufferId,
									duration: $ianmackenzie$elm_units$Duration$seconds(duration),
									requestId: requestId
								});
						}),
					A2($elm$json$Json$Decode$field, 'requestId', $elm$json$Json$Decode$int),
					A2($elm$json$Json$Decode$field, 'bufferId', $MartinSStewart$elm_audio$Audio$decodeBufferId),
					A2($elm$json$Json$Decode$field, 'durationInSeconds', $elm$json$Json$Decode$float));
			case 2:
				return A2(
					$elm$json$Json$Decode$map,
					function (samplesPerSecond) {
						return $MartinSStewart$elm_audio$Audio$InitAudioContext(
							{samplesPerSecond: samplesPerSecond});
					},
					A2($elm$json$Json$Decode$field, 'samplesPerSecond', $elm$json$Json$Decode$int));
			default:
				return $elm$json$Json$Decode$succeed(
					$MartinSStewart$elm_audio$Audio$JsonParseError(
						{
							error: 'Type ' + ($elm$core$String$fromInt(value) + ' not handled.')
						}));
		}
	},
	A2($elm$json$Json$Decode$field, 'type', $elm$json$Json$Decode$int));
var $elm$json$Json$Decode$decodeValue = _Json_run;
var $MartinSStewart$elm_audio$Audio$fromJSPortSub = function (json) {
	var _v0 = A2($elm$json$Json$Decode$decodeValue, $MartinSStewart$elm_audio$Audio$decodeFromJSMsg, json);
	if (_v0.$ === 'Ok') {
		var value = _v0.a;
		return $MartinSStewart$elm_audio$Audio$FromJSMsg(value);
	} else {
		var error = _v0.a;
		return $MartinSStewart$elm_audio$Audio$FromJSMsg(
			$MartinSStewart$elm_audio$Audio$JsonParseError(
				{
					error: $elm$json$Json$Decode$errorToString(error)
				}));
	}
};
var $elm$core$Platform$Sub$map = _Platform_map;
var $MartinSStewart$elm_audio$Audio$subscriptions = F2(
	function (app, _v0) {
		var model = _v0.a;
		return $elm$core$Platform$Sub$batch(
			_List_fromArray(
				[
					A2(
					$elm$core$Platform$Sub$map,
					$MartinSStewart$elm_audio$Audio$UserMsg,
					A2(
						app.subscriptions,
						$MartinSStewart$elm_audio$Audio$audioData(
							$MartinSStewart$elm_audio$Audio$Model(model)),
						model.userModel)),
					app.audioPort.fromJS($MartinSStewart$elm_audio$Audio$fromJSPortSub)
				]));
	});
var $MartinSStewart$elm_audio$Audio$File = function (a) {
	return {$: 'File', a: a};
};
var $MartinSStewart$elm_audio$Audio$flip = F3(
	function (func, a, b) {
		return A2(func, b, a);
	});
var $mgold$elm_nonempty_list$List$Nonempty$head = function (_v0) {
	var x = _v0.a;
	var xs = _v0.b;
	return x;
};
var $elm$core$Platform$Cmd$none = $elm$core$Platform$Cmd$batch(_List_Nil);
var $elm$core$Tuple$second = function (_v0) {
	var y = _v0.b;
	return y;
};
var $MartinSStewart$elm_audio$Audio$updateHelper = F4(
	function (audioPort, audioFunc, userUpdate, _v0) {
		var model = _v0.a;
		var audioData_ = $MartinSStewart$elm_audio$Audio$audioData(
			$MartinSStewart$elm_audio$Audio$Model(model));
		var _v1 = A2(userUpdate, audioData_, model.userModel);
		var newUserModel = _v1.a;
		var userCmd = _v1.b;
		var audioCmds = _v1.c;
		var _v2 = A3(
			$MartinSStewart$elm_audio$Audio$diffAudioState,
			model.nodeGroupIdCounter,
			model.audioState,
			A2(audioFunc, audioData_, newUserModel));
		var audioState = _v2.a;
		var newNodeGroupIdCounter = _v2.b;
		var json = _v2.c;
		var newModel = $MartinSStewart$elm_audio$Audio$Model(
			_Utils_update(
				model,
				{audioState: audioState, nodeGroupIdCounter: newNodeGroupIdCounter, userModel: newUserModel}));
		var _v3 = A2($MartinSStewart$elm_audio$Audio$encodeAudioCmd, newModel, audioCmds);
		var newModel2 = _v3.a;
		var audioRequests = _v3.b;
		var portMessage = $elm$json$Json$Encode$object(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'audio',
					A2($elm$json$Json$Encode$list, $elm$core$Basics$identity, json)),
					_Utils_Tuple2('audioCmds', audioRequests)
				]));
		return _Utils_Tuple2(
			newModel2,
			$elm$core$Platform$Cmd$batch(
				_List_fromArray(
					[
						A2($elm$core$Platform$Cmd$map, $MartinSStewart$elm_audio$Audio$UserMsg, userCmd),
						audioPort(portMessage)
					])));
	});
var $MartinSStewart$elm_audio$Audio$update = F3(
	function (app, msg, _v0) {
		var model = _v0.a;
		if (msg.$ === 'UserMsg') {
			var userMsg = msg.a;
			return A4(
				$MartinSStewart$elm_audio$Audio$updateHelper,
				app.audioPort.toJS,
				app.audio,
				A2($MartinSStewart$elm_audio$Audio$flip, app.update, userMsg),
				$MartinSStewart$elm_audio$Audio$Model(model));
		} else {
			var response = msg.a;
			switch (response.$) {
				case 'AudioLoadSuccess':
					var requestId = response.a.requestId;
					var bufferId = response.a.bufferId;
					var duration = response.a.duration;
					var _v3 = A2($elm$core$Dict$get, requestId, model.pendingRequests);
					if (_v3.$ === 'Just') {
						var pendingRequest = _v3.a;
						var sourceData = A3(
							$elm$core$Dict$insert,
							$MartinSStewart$elm_audio$Audio$rawBufferId(bufferId),
							{duration: duration},
							model.sourceData);
						var source = $elm$core$Result$Ok(
							$MartinSStewart$elm_audio$Audio$File(
								{bufferId: bufferId}));
						var maybeUserMsg = A2(
							$MartinSStewart$elm_audio$Audio$find,
							A2(
								$elm$core$Basics$composeR,
								$elm$core$Tuple$first,
								$elm$core$Basics$eq(source)),
							$mgold$elm_nonempty_list$List$Nonempty$toList(pendingRequest.userMsg));
						if (maybeUserMsg.$ === 'Just') {
							var _v5 = maybeUserMsg.a;
							var userMsg = _v5.b;
							return A4(
								$MartinSStewart$elm_audio$Audio$updateHelper,
								app.audioPort.toJS,
								app.audio,
								A2($MartinSStewart$elm_audio$Audio$flip, app.update, userMsg),
								$MartinSStewart$elm_audio$Audio$Model(
									_Utils_update(
										model,
										{
											pendingRequests: A2($elm$core$Dict$remove, requestId, model.pendingRequests),
											sourceData: sourceData
										})));
						} else {
							return A4(
								$MartinSStewart$elm_audio$Audio$updateHelper,
								app.audioPort.toJS,
								app.audio,
								A2(
									$MartinSStewart$elm_audio$Audio$flip,
									app.update,
									$mgold$elm_nonempty_list$List$Nonempty$head(pendingRequest.userMsg).b),
								$MartinSStewart$elm_audio$Audio$Model(
									_Utils_update(
										model,
										{
											pendingRequests: A2($elm$core$Dict$remove, requestId, model.pendingRequests),
											sourceData: sourceData
										})));
						}
					} else {
						return _Utils_Tuple2(
							$MartinSStewart$elm_audio$Audio$Model(model),
							$elm$core$Platform$Cmd$none);
					}
				case 'AudioLoadFailed':
					var requestId = response.a.requestId;
					var error = response.a.error;
					var _v6 = A2($elm$core$Dict$get, requestId, model.pendingRequests);
					if (_v6.$ === 'Just') {
						var pendingRequest = _v6.a;
						var a = $elm$core$Result$Err(error);
						var b = A2(
							$MartinSStewart$elm_audio$Audio$find,
							A2(
								$elm$core$Basics$composeR,
								$elm$core$Tuple$first,
								$elm$core$Basics$eq(a)),
							$mgold$elm_nonempty_list$List$Nonempty$toList(pendingRequest.userMsg));
						if (b.$ === 'Just') {
							var _v8 = b.a;
							var userMsg = _v8.b;
							return A4(
								$MartinSStewart$elm_audio$Audio$updateHelper,
								app.audioPort.toJS,
								app.audio,
								A2($MartinSStewart$elm_audio$Audio$flip, app.update, userMsg),
								$MartinSStewart$elm_audio$Audio$Model(
									_Utils_update(
										model,
										{
											pendingRequests: A2($elm$core$Dict$remove, requestId, model.pendingRequests)
										})));
						} else {
							return A4(
								$MartinSStewart$elm_audio$Audio$updateHelper,
								app.audioPort.toJS,
								app.audio,
								A2(
									$MartinSStewart$elm_audio$Audio$flip,
									app.update,
									$mgold$elm_nonempty_list$List$Nonempty$head(pendingRequest.userMsg).b),
								$MartinSStewart$elm_audio$Audio$Model(
									_Utils_update(
										model,
										{
											pendingRequests: A2($elm$core$Dict$remove, requestId, model.pendingRequests)
										})));
						}
					} else {
						return _Utils_Tuple2(
							$MartinSStewart$elm_audio$Audio$Model(model),
							$elm$core$Platform$Cmd$none);
					}
				case 'InitAudioContext':
					var samplesPerSecond = response.a.samplesPerSecond;
					return _Utils_Tuple2(
						$MartinSStewart$elm_audio$Audio$Model(
							_Utils_update(
								model,
								{
									samplesPerSecond: $elm$core$Maybe$Just(samplesPerSecond)
								})),
						$elm$core$Platform$Cmd$none);
				default:
					var error = response.a.error;
					return _Utils_Tuple2(
						$MartinSStewart$elm_audio$Audio$Model(model),
						$elm$core$Platform$Cmd$none);
			}
		}
	});
var $ianmackenzie$elm_units$Duration$milliseconds = function (numMilliseconds) {
	return $ianmackenzie$elm_units$Duration$seconds(0.001 * numMilliseconds);
};
var $MartinSStewart$elm_audio$Audio$Offset = function (a) {
	return {$: 'Offset', a: a};
};
var $MartinSStewart$elm_audio$Audio$offsetBy = F2(
	function (offset_, audio_) {
		return $MartinSStewart$elm_audio$Audio$Effect(
			{
				audio: audio_,
				effectType: $MartinSStewart$elm_audio$Audio$Offset(offset_)
			});
	});
var $MartinSStewart$elm_audio$Audio$withAudioOffset = function (app) {
	return _Utils_update(
		app,
		{
			audio: F2(
				function (audioData_, model) {
					return A2(
						$MartinSStewart$elm_audio$Audio$offsetBy,
						$ianmackenzie$elm_units$Duration$milliseconds(50),
						A2(app.audio, audioData_, model));
				})
		});
};
var $MartinSStewart$elm_audio$Audio$elementWithAudio = A2(
	$elm$core$Basics$composeR,
	$MartinSStewart$elm_audio$Audio$withAudioOffset,
	function (app) {
		return $elm$browser$Browser$element(
			{
				init: A2(
					$elm$core$Basics$composeR,
					app.init,
					A2($MartinSStewart$elm_audio$Audio$initHelper, app.audioPort.toJS, app.audio)),
				subscriptions: $MartinSStewart$elm_audio$Audio$subscriptions(app),
				update: $MartinSStewart$elm_audio$Audio$update(app),
				view: function (model) {
					return A2(
						$elm$html$Html$map,
						$MartinSStewart$elm_audio$Audio$UserMsg,
						A2(
							app.view,
							$MartinSStewart$elm_audio$Audio$audioData(model),
							$MartinSStewart$elm_audio$Audio$getUserModel(model)));
				}
			});
	});
var $author$project$Lib$Scene$Base$NullSceneMsg = {$: 'NullSceneMsg'};
var $MartinSStewart$elm_audio$Audio$AudioCmdGroup = function (a) {
	return {$: 'AudioCmdGroup', a: a};
};
var $MartinSStewart$elm_audio$Audio$cmdNone = $MartinSStewart$elm_audio$Audio$AudioCmdGroup(_List_Nil);
var $author$project$Lib$Coordinate$Coordinates$getStartPoint = function (_v0) {
	var w = _v0.a;
	var h = _v0.b;
	var fw = (h / 9) * 16;
	var fh = (w / 16) * 9;
	return (_Utils_cmp(w * 9, h * 16) > 0) ? _Utils_Tuple2((w - fw) / 2, 0) : _Utils_Tuple2(0, (h - fh) / 2);
};
var $author$project$Scenes$SceneSettings$NullSceneData = {$: 'NullSceneData'};
var $author$project$Common$initGlobalData = {
	audioVolume: 0.5,
	browserViewPort: _Utils_Tuple2(1280, 720),
	randomnum: 0,
	realHeight: 720,
	realWidth: 1280,
	sprites: $elm$core$Dict$empty,
	startLeft: 0,
	startTop: 0
};
var $author$project$Lib$Scene$Base$NullSceneOutputMsg = {$: 'NullSceneOutputMsg'};
var $joakin$elm_canvas$Canvas$Internal$Canvas$DrawableGroup = function (a) {
	return {$: 'DrawableGroup', a: a};
};
var $joakin$elm_canvas$Canvas$Internal$Canvas$NotSpecified = {$: 'NotSpecified'};
var $joakin$elm_canvas$Canvas$Internal$Canvas$Renderable = function (a) {
	return {$: 'Renderable', a: a};
};
var $joakin$elm_canvas$Canvas$Internal$Canvas$Fill = function (a) {
	return {$: 'Fill', a: a};
};
var $joakin$elm_canvas$Canvas$Internal$Canvas$FillAndStroke = F2(
	function (a, b) {
		return {$: 'FillAndStroke', a: a, b: b};
	});
var $joakin$elm_canvas$Canvas$Internal$Canvas$Stroke = function (a) {
	return {$: 'Stroke', a: a};
};
var $joakin$elm_canvas$Canvas$mergeDrawOp = F2(
	function (op1, op2) {
		var _v0 = _Utils_Tuple2(op1, op2);
		_v0$7:
		while (true) {
			switch (_v0.b.$) {
				case 'FillAndStroke':
					var _v1 = _v0.b;
					var c = _v1.a;
					var sc = _v1.b;
					return A2($joakin$elm_canvas$Canvas$Internal$Canvas$FillAndStroke, c, sc);
				case 'Fill':
					switch (_v0.a.$) {
						case 'Fill':
							var c = _v0.b.a;
							return $joakin$elm_canvas$Canvas$Internal$Canvas$Fill(c);
						case 'Stroke':
							var c1 = _v0.a.a;
							var c2 = _v0.b.a;
							return A2($joakin$elm_canvas$Canvas$Internal$Canvas$FillAndStroke, c2, c1);
						case 'FillAndStroke':
							var _v2 = _v0.a;
							var sc = _v2.b;
							var c2 = _v0.b.a;
							return A2($joakin$elm_canvas$Canvas$Internal$Canvas$FillAndStroke, c2, sc);
						default:
							break _v0$7;
					}
				case 'Stroke':
					switch (_v0.a.$) {
						case 'Stroke':
							var c = _v0.b.a;
							return $joakin$elm_canvas$Canvas$Internal$Canvas$Stroke(c);
						case 'Fill':
							var c1 = _v0.a.a;
							var c2 = _v0.b.a;
							return A2($joakin$elm_canvas$Canvas$Internal$Canvas$FillAndStroke, c1, c2);
						case 'FillAndStroke':
							var _v3 = _v0.a;
							var c = _v3.a;
							var sc2 = _v0.b.a;
							return A2($joakin$elm_canvas$Canvas$Internal$Canvas$FillAndStroke, c, sc2);
						default:
							break _v0$7;
					}
				default:
					if (_v0.a.$ === 'NotSpecified') {
						break _v0$7;
					} else {
						var whatever = _v0.a;
						var _v5 = _v0.b;
						return whatever;
					}
			}
		}
		var _v4 = _v0.a;
		var whatever = _v0.b;
		return whatever;
	});
var $joakin$elm_canvas$Canvas$addSettingsToRenderable = F2(
	function (settings, renderable) {
		var addSetting = F2(
			function (setting, _v1) {
				var r = _v1.a;
				return $joakin$elm_canvas$Canvas$Internal$Canvas$Renderable(
					function () {
						switch (setting.$) {
							case 'SettingCommand':
								var cmd = setting.a;
								return _Utils_update(
									r,
									{
										commands: A2($elm$core$List$cons, cmd, r.commands)
									});
							case 'SettingCommands':
								var cmds = setting.a;
								return _Utils_update(
									r,
									{
										commands: A3($elm$core$List$foldl, $elm$core$List$cons, r.commands, cmds)
									});
							case 'SettingUpdateDrawable':
								var f = setting.a;
								return _Utils_update(
									r,
									{
										drawable: f(r.drawable)
									});
							default:
								var op = setting.a;
								return _Utils_update(
									r,
									{
										drawOp: A2($joakin$elm_canvas$Canvas$mergeDrawOp, r.drawOp, op)
									});
						}
					}());
			});
		return A3($elm$core$List$foldl, addSetting, renderable, settings);
	});
var $joakin$elm_canvas$Canvas$group = F2(
	function (settings, entities) {
		return A2(
			$joakin$elm_canvas$Canvas$addSettingsToRenderable,
			settings,
			$joakin$elm_canvas$Canvas$Internal$Canvas$Renderable(
				{
					commands: _List_Nil,
					drawOp: $joakin$elm_canvas$Canvas$Internal$Canvas$NotSpecified,
					drawable: $joakin$elm_canvas$Canvas$Internal$Canvas$DrawableGroup(entities)
				}));
	});
var $author$project$Scenes$SceneSettings$nullSceneCT = {
	init: F2(
		function (_v0, _v1) {
			return $author$project$Scenes$SceneSettings$NullSceneData;
		}),
	update: F3(
		function (_v2, g, _v3) {
			return _Utils_Tuple3($author$project$Scenes$SceneSettings$NullSceneData, $author$project$Lib$Scene$Base$NullSceneOutputMsg, g);
		}),
	view: F2(
		function (_v4, _v5) {
			return A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil);
		})
};
var $author$project$Main$initModel = {audiorepo: _List_Nil, currentData: $author$project$Scenes$SceneSettings$NullSceneData, currentGlobalData: $author$project$Common$initGlobalData, currentScene: $author$project$Scenes$SceneSettings$nullSceneCT, time: 0};
var $author$project$Lib$CoreEngine$FrontgroundLayer$Base$CTInfo = F2(
	function (components, timeseries) {
		return {components: components, timeseries: timeseries};
	});
var $author$project$Lib$Layer$Base$GameLayerInit = F3(
	function (player, actors, chartlets) {
		return {actors: actors, chartlets: chartlets, player: player};
	});
var $author$project$Lib$Layer$Base$LayerCTMsg = function (a) {
	return {$: 'LayerCTMsg', a: a};
};
var $author$project$Lib$Layer$Base$LayerInitGameLayer = function (a) {
	return {$: 'LayerInitGameLayer', a: a};
};
var $author$project$Lib$Layer$Base$NullLayerMsg = {$: 'NullLayerMsg'};
var $author$project$Lib$Layer$Base$Layer = F4(
	function (data, init, update, view) {
		return {data: data, init: init, update: update, view: view};
	});
var $author$project$Lib$CoreEngine$BackgroundLayer$Export$nullData = {
	render: F3(
		function (_v0, _v1, _v2) {
			return A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil);
		})
};
var $author$project$Lib$CoreEngine$BackgroundLayer$Global$ctTod = function (ldt) {
	if (ldt.$ === 'BackgroundData') {
		var x = ldt.a;
		return x;
	} else {
		return $author$project$Lib$CoreEngine$BackgroundLayer$Export$nullData;
	}
};
var $author$project$Lib$CoreEngine$LayerSettings$BackgroundData = function (a) {
	return {$: 'BackgroundData', a: a};
};
var $author$project$Lib$CoreEngine$BackgroundLayer$Global$dToCT = function (data) {
	return $author$project$Lib$CoreEngine$LayerSettings$BackgroundData(data);
};
var $author$project$Lib$CoreEngine$BackgroundLayer$Global$getLayerCT = function (layer) {
	var view = F3(
		function (_v3, cd, gd) {
			var ldt = _v3.a;
			var t = _v3.b;
			return A3(
				layer.view,
				_Utils_Tuple2(
					$author$project$Lib$CoreEngine$BackgroundLayer$Global$ctTod(ldt),
					t),
				cd,
				gd);
		});
	var update = F5(
		function (m, gd, lm, _v2, cd) {
			var ldt = _v2.a;
			var t = _v2.b;
			var _v0 = A5(
				layer.update,
				m,
				gd,
				lm,
				_Utils_Tuple2(
					$author$project$Lib$CoreEngine$BackgroundLayer$Global$ctTod(ldt),
					t),
				cd);
			var _v1 = _v0.a;
			var rldt = _v1.a;
			var rcd = _v1.b;
			var ltm = _v1.c;
			var newgd = _v0.b;
			return _Utils_Tuple2(
				_Utils_Tuple3(
					$author$project$Lib$CoreEngine$BackgroundLayer$Global$dToCT(rldt),
					rcd,
					ltm),
				newgd);
		});
	var init = F3(
		function (t, lm, cd) {
			return $author$project$Lib$CoreEngine$BackgroundLayer$Global$dToCT(
				A3(layer.init, t, lm, cd));
		});
	return A4(
		$author$project$Lib$Layer$Base$Layer,
		$author$project$Lib$CoreEngine$BackgroundLayer$Global$dToCT(layer.data),
		init,
		update,
		view);
};
var $author$project$Lib$CoreEngine$FrontgroundLayer$Export$nullData = {
	components: $elm$core$Array$empty,
	fpsrepo: _List_Nil,
	render: F3(
		function (_v0, _v1, _v2) {
			return A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil);
		})
};
var $author$project$Lib$CoreEngine$FrontgroundLayer$Global$ctTod = function (ldt) {
	if (ldt.$ === 'FrontgroundData') {
		var x = ldt.a;
		return x;
	} else {
		return $author$project$Lib$CoreEngine$FrontgroundLayer$Export$nullData;
	}
};
var $author$project$Lib$CoreEngine$LayerSettings$FrontgroundData = function (a) {
	return {$: 'FrontgroundData', a: a};
};
var $author$project$Lib$CoreEngine$FrontgroundLayer$Global$dToCT = function (data) {
	return $author$project$Lib$CoreEngine$LayerSettings$FrontgroundData(data);
};
var $author$project$Lib$CoreEngine$FrontgroundLayer$Global$getLayerCT = function (layer) {
	var view = F3(
		function (_v3, cd, gd) {
			var ldt = _v3.a;
			var t = _v3.b;
			return A3(
				layer.view,
				_Utils_Tuple2(
					$author$project$Lib$CoreEngine$FrontgroundLayer$Global$ctTod(ldt),
					t),
				cd,
				gd);
		});
	var update = F5(
		function (m, gd, lm, _v2, cd) {
			var ldt = _v2.a;
			var t = _v2.b;
			var _v0 = A5(
				layer.update,
				m,
				gd,
				lm,
				_Utils_Tuple2(
					$author$project$Lib$CoreEngine$FrontgroundLayer$Global$ctTod(ldt),
					t),
				cd);
			var _v1 = _v0.a;
			var rldt = _v1.a;
			var rcd = _v1.b;
			var ltm = _v1.c;
			var newgd = _v0.b;
			return _Utils_Tuple2(
				_Utils_Tuple3(
					$author$project$Lib$CoreEngine$FrontgroundLayer$Global$dToCT(rldt),
					rcd,
					ltm),
				newgd);
		});
	var init = F3(
		function (t, lm, cd) {
			return $author$project$Lib$CoreEngine$FrontgroundLayer$Global$dToCT(
				A3(layer.init, t, lm, cd));
		});
	return A4(
		$author$project$Lib$Layer$Base$Layer,
		$author$project$Lib$CoreEngine$FrontgroundLayer$Global$dToCT(layer.data),
		init,
		update,
		view);
};
var $author$project$Lib$CoreEngine$GameComponent$Base$Alive = {$: 'Alive'};
var $author$project$Lib$CoreEngine$GameComponents$Player$Model$collisionBox = {height: 120, name: 'col', offsetX: 0, offsetY: 0, width: 70};
var $author$project$Lib$Component$Base$CDPlayerModel = function (a) {
	return {$: 'CDPlayerModel', a: a};
};
var $author$project$Lib$CoreEngine$GameComponents$Player$Base$BoundKey = F5(
	function (left, right, up, down, space) {
		return {down: down, left: left, right: right, space: space, up: up};
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$Base$Nope = {$: 'Nope'};
var $author$project$Lib$CoreEngine$GameComponents$Player$Base$PlayerStates = function (a) {
	return {$: 'PlayerStates', a: a};
};
var $author$project$Lib$CoreEngine$GameComponents$Player$Base$nullModel = {
	currentKeys: A5($author$project$Lib$CoreEngine$GameComponents$Player$Base$BoundKey, 0, 0, 0, 0, 0),
	jStartTime: 0,
	keyPressed: $author$project$Lib$CoreEngine$GameComponents$Player$Base$Nope,
	lastOriginKeys: A5($author$project$Lib$CoreEngine$GameComponents$Player$Base$BoundKey, 0, 0, 0, 0, 0),
	originKeys: A5($author$project$Lib$CoreEngine$GameComponents$Player$Base$BoundKey, 0, 0, 0, 0, 0),
	playerStates: $author$project$Lib$CoreEngine$GameComponents$Player$Base$PlayerStates(_List_Nil)
};
var $author$project$Lib$CoreEngine$GameComponents$Player$Model$initExtraData = $elm$core$Dict$fromList(
	_List_fromArray(
		[
			_Utils_Tuple2(
			'model',
			$author$project$Lib$Component$Base$CDPlayerModel($author$project$Lib$CoreEngine$GameComponents$Player$Base$nullModel))
		]));
var $elm$core$Basics$negate = function (n) {
	return -n;
};
var $author$project$Lib$CoreEngine$GameComponents$Player$Model$initData = {
	acceleration: _Utils_Tuple2(0, -8),
	collisionbox: _List_fromArray(
		[$author$project$Lib$CoreEngine$GameComponents$Player$Model$collisionBox]),
	extra: $author$project$Lib$CoreEngine$GameComponents$Player$Model$initExtraData,
	mass: 50,
	position: _Utils_Tuple2(100, 2000),
	simplecheck: $author$project$Lib$CoreEngine$GameComponents$Player$Model$collisionBox,
	status: $author$project$Lib$CoreEngine$GameComponent$Base$Alive,
	uid: 1,
	velocity: _Utils_Tuple2(0, 0)
};
var $author$project$Lib$CoreEngine$GameComponents$Player$Model$initModel = F2(
	function (_v0, gcm) {
		if (gcm.$ === 'GamePlayerInit') {
			var info = gcm.a;
			return {
				acceleration: _Utils_Tuple2(0, -8),
				collisionbox: _List_fromArray(
					[$author$project$Lib$CoreEngine$GameComponents$Player$Model$collisionBox]),
				extra: $author$project$Lib$CoreEngine$GameComponents$Player$Model$initExtraData,
				mass: 50,
				position: info.initPosition,
				simplecheck: $author$project$Lib$CoreEngine$GameComponents$Player$Model$collisionBox,
				status: $author$project$Lib$CoreEngine$GameComponent$Base$Alive,
				uid: 1,
				velocity: _Utils_Tuple2(0, 0)
			};
		} else {
			return $author$project$Lib$CoreEngine$GameComponents$Player$Model$initData;
		}
	});
var $author$project$Lib$CoreEngine$GameComponent$Base$Dead = function (a) {
	return {$: 'Dead', a: a};
};
var $author$project$Lib$CoreEngine$GameComponent$Base$GameActorUidMsg = F2(
	function (a, b) {
		return {$: 'GameActorUidMsg', a: a, b: b};
	});
var $author$project$Lib$CoreEngine$GameComponent$Base$GameStringMsg = function (a) {
	return {$: 'GameStringMsg', a: a};
};
var $author$project$Lib$CoreEngine$GameComponents$Player$InputFilter$afterMove = function (model) {
	return _Utils_update(
		model,
		{lastOriginKeys: model.originKeys});
};
var $elm_explorations$linear_algebra$Math$Vector2$getX = _MJS_v2getX;
var $elm_explorations$linear_algebra$Math$Vector2$getY = _MJS_v2getY;
var $elm_explorations$linear_algebra$Math$Vector2$normalize = _MJS_v2normalize;
var $elm_explorations$linear_algebra$Math$Vector2$scale = _MJS_v2scale;
var $elm$core$Basics$sqrt = _Basics_sqrt;
var $elm_explorations$linear_algebra$Math$Vector2$vec2 = _MJS_v2;
var $author$project$Lib$CoreEngine$Physics$Velocity$changeCVel = F3(
	function (c, _v0, k) {
		var px = _v0.a;
		var py = _v0.b;
		var punit = $elm_explorations$linear_algebra$Math$Vector2$normalize(
			A2($elm_explorations$linear_algebra$Math$Vector2$vec2, px, -py));
		var cm = c.mass;
		var nm = A2(
			$elm_explorations$linear_algebra$Math$Vector2$scale,
			$elm$core$Basics$sqrt((10000 * k) / cm),
			punit);
		var newvx = $elm_explorations$linear_algebra$Math$Vector2$getX(nm);
		var newvy = $elm_explorations$linear_algebra$Math$Vector2$getY(nm);
		var _v1 = c.velocity;
		var ovx = _v1.a;
		var ovy = _v1.b;
		var newdata = _Utils_update(
			c,
			{
				velocity: _Utils_Tuple2(
					((newvx * ovx) > 0) ? (newvx + ovx) : newvx,
					((newvy * ovy) > 0) ? (newvy + ovy) : newvy)
			});
		return newdata;
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$Base$PressTime = function (a) {
	return {$: 'PressTime', a: a};
};
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Xdir = {$: 'Xdir'};
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Ydir = {$: 'Ydir'};
var $elm$core$Basics$abs = function (n) {
	return (n < 0) ? (-n) : n;
};
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$boundXY = F2(
	function (_v0, _v1) {
		var a = _v0.a;
		var b = _v1.b;
		return _Utils_Tuple2(a, b);
	});
var $author$project$Lib$CoreEngine$Physics$NaiveCollision$getBoxPos = F2(
	function (_v0, b) {
		var x1 = _v0.a;
		var y1 = _v0.b;
		var ry1 = y1 + b.offsetY;
		var ry2 = (ry1 + b.height) - 1;
		var rx1 = x1 + b.offsetX;
		var rx2 = (rx1 + b.width) - 1;
		return _Utils_Tuple2(
			_Utils_Tuple2(rx1, ry1),
			_Utils_Tuple2(rx2, ry2));
	});
var $elm$core$List$any = F2(
	function (isOkay, list) {
		any:
		while (true) {
			if (!list.b) {
				return false;
			} else {
				var x = list.a;
				var xs = list.b;
				if (isOkay(x)) {
					return true;
				} else {
					var $temp$isOkay = isOkay,
						$temp$list = xs;
					isOkay = $temp$isOkay;
					list = $temp$list;
					continue any;
				}
			}
		}
	});
var $elm$core$Basics$ge = _Utils_ge;
var $elm$core$Maybe$andThen = F2(
	function (callback, maybeValue) {
		if (maybeValue.$ === 'Just') {
			var value = maybeValue.a;
			return callback(value);
		} else {
			return $elm$core$Maybe$Nothing;
		}
	});
var $elm$core$Bitwise$and = _Bitwise_and;
var $elm$core$Bitwise$shiftRightZfBy = _Bitwise_shiftRightZfBy;
var $elm$core$Array$bitMask = 4294967295 >>> (32 - $elm$core$Array$shiftStep);
var $elm$core$Elm$JsArray$unsafeGet = _JsArray_unsafeGet;
var $elm$core$Array$getHelp = F3(
	function (shift, index, tree) {
		getHelp:
		while (true) {
			var pos = $elm$core$Array$bitMask & (index >>> shift);
			var _v0 = A2($elm$core$Elm$JsArray$unsafeGet, pos, tree);
			if (_v0.$ === 'SubTree') {
				var subTree = _v0.a;
				var $temp$shift = shift - $elm$core$Array$shiftStep,
					$temp$index = index,
					$temp$tree = subTree;
				shift = $temp$shift;
				index = $temp$index;
				tree = $temp$tree;
				continue getHelp;
			} else {
				var values = _v0.a;
				return A2($elm$core$Elm$JsArray$unsafeGet, $elm$core$Array$bitMask & index, values);
			}
		}
	});
var $elm$core$Bitwise$shiftLeftBy = _Bitwise_shiftLeftBy;
var $elm$core$Array$tailIndex = function (len) {
	return (len >>> 5) << 5;
};
var $elm$core$Array$get = F2(
	function (index, _v0) {
		var len = _v0.a;
		var startShift = _v0.b;
		var tree = _v0.c;
		var tail = _v0.d;
		return ((index < 0) || (_Utils_cmp(index, len) > -1)) ? $elm$core$Maybe$Nothing : ((_Utils_cmp(
			index,
			$elm$core$Array$tailIndex(len)) > -1) ? $elm$core$Maybe$Just(
			A2($elm$core$Elm$JsArray$unsafeGet, $elm$core$Array$bitMask & index, tail)) : $elm$core$Maybe$Just(
			A3($elm$core$Array$getHelp, startShift, index, tree)));
	});
var $tortus$elm_array_2d$Array2D$getRow = F2(
	function (row, array2d) {
		return A2($elm$core$Array$get, row, array2d.data);
	});
var $tortus$elm_array_2d$Array2D$get = F3(
	function (row, col, array2d) {
		return A2(
			$elm$core$Maybe$andThen,
			$elm$core$Array$get(col),
			A2($tortus$elm_array_2d$Array2D$getRow, row, array2d));
	});
var $author$project$Lib$CoreEngine$Physics$SolidCollision$blockIsSolid = F2(
	function (model, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		var _v1 = A3($tortus$elm_array_2d$Array2D$get, x, y, model.solidmap);
		if (_v1.$ === 'Just') {
			var t = _v1.a;
			return (t > 0) ? true : false;
		} else {
			return ((x < 0) || ((_Utils_cmp(x, model.mapsize.a) > -1) || (_Utils_cmp(y, model.mapsize.b) > -1))) ? true : false;
		}
	});
var $author$project$Lib$CoreEngine$Base$brickSize = 32;
var $author$project$Lib$Tools$Math$rfint = function (x) {
	return $elm$core$Basics$floor(x / $author$project$Lib$CoreEngine$Base$brickSize);
};
var $author$project$Lib$CoreEngine$Physics$SolidCollision$lineHasSolid = F3(
	function (_v0, _v1, model) {
		var x1 = _v0.a;
		var y1 = _v0.b;
		var x2 = _v1.a;
		var y2 = _v1.b;
		var y2t = $author$project$Lib$Tools$Math$rfint(y2);
		var y1t = $author$project$Lib$Tools$Math$rfint(y1);
		var x2t = $author$project$Lib$Tools$Math$rfint(x2);
		var x1t = $author$project$Lib$Tools$Math$rfint(x1);
		if (_Utils_eq(x1, x2)) {
			var bdrange = (_Utils_cmp(y1, y2) > 0) ? A2($elm$core$List$range, y2t, y1t) : A2($elm$core$List$range, y1t, y2t);
			var totest = A2(
				$elm$core$List$map,
				function (i) {
					return _Utils_Tuple2(x1t, i);
				},
				bdrange);
			return A2(
				$elm$core$List$any,
				$author$project$Lib$CoreEngine$Physics$SolidCollision$blockIsSolid(model),
				totest);
		} else {
			if (_Utils_eq(y1, y2)) {
				var bdrange = (_Utils_cmp(x1, x2) > 0) ? A2($elm$core$List$range, x2t, x1t) : A2($elm$core$List$range, x1t, x2t);
				var totest = A2(
					$elm$core$List$map,
					function (i) {
						return _Utils_Tuple2(i, y1t);
					},
					bdrange);
				return A2(
					$elm$core$List$any,
					$author$project$Lib$CoreEngine$Physics$SolidCollision$blockIsSolid(model),
					totest);
			} else {
				return true;
			}
		}
	});
var $elm$core$Basics$not = _Basics_not;
var $author$project$Lib$CoreEngine$Physics$SolidCollision$canMove = F3(
	function (actor, model, drt) {
		var yv = $elm_explorations$linear_algebra$Math$Vector2$getY(drt);
		var xv = $elm_explorations$linear_algebra$Math$Vector2$getX(drt);
		var cbox = actor.simplecheck;
		var _v0 = A2($author$project$Lib$CoreEngine$Physics$NaiveCollision$getBoxPos, actor.position, cbox);
		var _v1 = _v0.a;
		var x1 = _v1.a;
		var y1 = _v1.b;
		var _v2 = _v0.b;
		var x2 = _v2.a;
		var y2 = _v2.b;
		return ((!xv) && (!yv)) ? true : (((!xv) && (yv > 0)) ? (!A3(
			$author$project$Lib$CoreEngine$Physics$SolidCollision$lineHasSolid,
			_Utils_Tuple2(x1, y1 - 1),
			_Utils_Tuple2(x2, y1 - 1),
			model)) : (((!xv) && (yv < 0)) ? (!A3(
			$author$project$Lib$CoreEngine$Physics$SolidCollision$lineHasSolid,
			_Utils_Tuple2(x1, y2 + 1),
			_Utils_Tuple2(x2, y2 + 1),
			model)) : (((xv > 0) && (!yv)) ? (!A3(
			$author$project$Lib$CoreEngine$Physics$SolidCollision$lineHasSolid,
			_Utils_Tuple2(x2 + 1, y1),
			_Utils_Tuple2(x2 + 1, y2),
			model)) : (((xv < 0) && (!yv)) ? (!A3(
			$author$project$Lib$CoreEngine$Physics$SolidCollision$lineHasSolid,
			_Utils_Tuple2(x1 - 1, y1),
			_Utils_Tuple2(x1 - 1, y2),
			model)) : false))));
	});
var $author$project$Lib$CoreEngine$Physics$Ground$isInAir = F2(
	function (gc, ggd) {
		var _v0 = gc.velocity;
		var vely = _v0.b;
		return (vely > 0) ? true : A3(
			$author$project$Lib$CoreEngine$Physics$SolidCollision$canMove,
			gc,
			ggd,
			A2($elm_explorations$linear_algebra$Math$Vector2$vec2, 0, -1));
	});
var $author$project$Lib$CoreEngine$Physics$Ground$isOnground = F2(
	function (gc, ggd) {
		return !A2($author$project$Lib$CoreEngine$Physics$Ground$isInAir, gc, ggd);
	});
var $author$project$Lib$CoreEngine$Physics$Ground$canJump = F2(
	function (actor, model) {
		return A2($author$project$Lib$CoreEngine$Physics$Ground$isOnground, actor, model);
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityHelper = F2(
	function (cd, nv) {
		return _Utils_update(
			cd,
			{velocity: nv});
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Blank = F2(
	function (a, b) {
		return {$: 'Blank', a: a, b: b};
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Opposite = F2(
	function (a, b) {
		return {$: 'Opposite', a: a, b: b};
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Pressed = F2(
	function (a, b) {
		return {$: 'Pressed', a: a, b: b};
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$DelVelocityFunction = F3(
	function (funcA, funcB, funcC) {
		return {funcA: funcA, funcB: funcB, funcC: funcC};
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$blankVelocityFunction = A3($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$DelVelocityFunction, (-1) / 160.0, 0, 0);
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$delVelocityFunction = F2(
	function (f, vel) {
		var delVel = ((vel <= 10) && (vel > 0)) ? (-vel) : (((_Utils_cmp(vel, -10) > -1) && (vel < 0)) ? vel : $elm$core$Basics$round((((f.funcA * vel) * vel) + (f.funcB * vel)) + f.funcC));
		var newVel = vel + delVel;
		return ((newVel <= 9) && (_Utils_cmp(newVel, -9) > -1)) ? (-vel) : delVel;
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$jumpBlankVelocityFunction = A3($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$DelVelocityFunction, (-1) / 460.0, 0, 0);
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$jumpOppositeVelocityFunction = A3($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$DelVelocityFunction, (-1) / 640.0, -0.125, -10);
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$jumpPressedVelocityFunction = A3($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$DelVelocityFunction, 1 / 1280.0, -0.3125, 20);
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$oppositeVelocityFunction = A3($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$DelVelocityFunction, (-1) / 640.0, -0.25, -10);
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$pressedVelocityFunction = A3($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$DelVelocityFunction, 1 / 320.0, -0.75, 40);
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$sign = function (x) {
	return (x > 0) ? 1 : ((x < 0) ? (-1) : 0);
};
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$delVelocityFunctionHelper = F2(
	function (vec, velTypeMsg) {
		var _v0 = vec;
		var vecX = _v0.a;
		var vecY = _v0.b;
		var signX = $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$sign(vecX);
		switch (velTypeMsg.$) {
			case 'Pressed':
				var msgDir = velTypeMsg.a;
				var x = velTypeMsg.b;
				if (msgDir.$ === 'Xdir') {
					return _Utils_Tuple2(
						x * ($elm$core$Basics$abs(vecX) + A2(
							$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$delVelocityFunction,
							$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$pressedVelocityFunction,
							$elm$core$Basics$abs(vecX))),
						vecY);
				} else {
					return _Utils_Tuple2(
						x * ($elm$core$Basics$abs(vecX) + A2(
							$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$delVelocityFunction,
							$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$jumpPressedVelocityFunction,
							$elm$core$Basics$abs(vecX))),
						vecY);
				}
			case 'Blank':
				var msgDir = velTypeMsg.a;
				if (msgDir.$ === 'Xdir') {
					return _Utils_Tuple2(
						signX * ($elm$core$Basics$abs(vecX) + A2(
							$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$delVelocityFunction,
							$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$blankVelocityFunction,
							$elm$core$Basics$abs(vecX))),
						vecY);
				} else {
					return _Utils_Tuple2(
						signX * ($elm$core$Basics$abs(vecX) + A2(
							$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$delVelocityFunction,
							$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$jumpBlankVelocityFunction,
							$elm$core$Basics$abs(vecX))),
						vecY);
				}
			case 'Opposite':
				var msgDir = velTypeMsg.a;
				if (msgDir.$ === 'Xdir') {
					return _Utils_Tuple2(
						signX * ($elm$core$Basics$abs(vecX) + A2(
							$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$delVelocityFunction,
							$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$oppositeVelocityFunction,
							$elm$core$Basics$abs(vecX))),
						vecY);
				} else {
					return _Utils_Tuple2(
						signX * ($elm$core$Basics$abs(vecX) + A2(
							$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$delVelocityFunction,
							$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$jumpOppositeVelocityFunction,
							$elm$core$Basics$abs(vecX))),
						vecY);
				}
			default:
				return _Utils_Tuple2(vecX, vecY);
		}
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityX = F3(
	function (_char, model, dir) {
		var right = model.currentKeys.right;
		var left = model.currentKeys.left;
		var charVelocity = _char.velocity;
		var signX = $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$sign(charVelocity.a);
		return (!left) ? ((!right) ? A2(
			$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$delVelocityFunctionHelper,
			charVelocity,
			A2($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Blank, dir, 0)) : ((right === 1) ? ((signX >= 0) ? A2(
			$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$delVelocityFunctionHelper,
			charVelocity,
			A2($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Pressed, dir, 1)) : A2(
			$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$delVelocityFunctionHelper,
			charVelocity,
			A2($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Opposite, dir, 0))) : charVelocity)) : ((left === 1) ? ((!right) ? ((signX > 0) ? A2(
			$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$delVelocityFunctionHelper,
			charVelocity,
			A2($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Opposite, dir, 0)) : A2(
			$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$delVelocityFunctionHelper,
			charVelocity,
			A2($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Pressed, dir, -1))) : ((right === 1) ? charVelocity : charVelocity)) : ((!right) ? charVelocity : ((right === 1) ? ((signX >= 0) ? A2(
			$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$delVelocityFunctionHelper,
			charVelocity,
			A2($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Pressed, dir, 1)) : A2(
			$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$delVelocityFunctionHelper,
			charVelocity,
			A2($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Opposite, dir, 0))) : charVelocity)));
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityY = F2(
	function (_char, flag) {
		var charVelocity = _char.velocity;
		var _v0 = charVelocity;
		var vecX = _v0.a;
		var vecY = _v0.b;
		switch (flag) {
			case 1:
				return _Utils_Tuple2(vecX, vecY + 160);
			case 2:
				return _Utils_Tuple2(vecX, vecY + 3);
			default:
				return charVelocity;
		}
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$delLargeVelocity = F4(
	function (ct, model, d, cj) {
		var space = model.currentKeys.space;
		var right = model.currentKeys.right;
		var left = model.currentKeys.left;
		var _v0 = d.velocity;
		var vx = _v0.a;
		var vy = _v0.b;
		if (!space) {
			return cj ? ((vx > 0) ? (((left === 1) && (!left)) ? _Utils_Tuple2(
				model,
				_Utils_update(
					d,
					{
						velocity: _Utils_Tuple2(vx / 1.1, vy)
					})) : (((right === 1) && (!left)) ? _Utils_Tuple2(
				model,
				_Utils_update(
					d,
					{
						velocity: _Utils_Tuple2(vx / 1.04, vy)
					})) : _Utils_Tuple2(
				model,
				_Utils_update(
					d,
					{
						velocity: _Utils_Tuple2(vx / 1.05, vy)
					})))) : (((left === 1) && (!left)) ? _Utils_Tuple2(
				model,
				_Utils_update(
					d,
					{
						velocity: _Utils_Tuple2(vx / 1.04, vy)
					})) : (((right === 1) && (!left)) ? _Utils_Tuple2(
				model,
				_Utils_update(
					d,
					{
						velocity: _Utils_Tuple2(vx / 1.1, vy)
					})) : _Utils_Tuple2(
				model,
				_Utils_update(
					d,
					{
						velocity: _Utils_Tuple2(vx / 1.05, vy)
					}))))) : ((vx > 0) ? (((left === 1) && (!left)) ? _Utils_Tuple2(
				model,
				_Utils_update(
					d,
					{
						velocity: _Utils_Tuple2(vx / 1.1, vy)
					})) : (((right === 1) && (!left)) ? _Utils_Tuple2(
				model,
				_Utils_update(
					d,
					{
						velocity: _Utils_Tuple2(vx / 1.01, vy)
					})) : _Utils_Tuple2(
				model,
				_Utils_update(
					d,
					{
						velocity: _Utils_Tuple2(vx / 1.05, vy)
					})))) : (((left === 1) && (!left)) ? _Utils_Tuple2(
				model,
				_Utils_update(
					d,
					{
						velocity: _Utils_Tuple2(vx / 1.01, vy)
					})) : (((right === 1) && (!left)) ? _Utils_Tuple2(
				model,
				_Utils_update(
					d,
					{
						velocity: _Utils_Tuple2(vx / 1.1, vy)
					})) : _Utils_Tuple2(
				model,
				_Utils_update(
					d,
					{
						velocity: _Utils_Tuple2(vx / 1.05, vy)
					})))));
		} else {
			var _v1 = model.keyPressed;
			if (_v1.$ === 'PressTime') {
				var t = _v1.a;
				return ((ct - t) <= 20) ? _Utils_Tuple2(
					_Utils_update(
						model,
						{
							keyPressed: $author$project$Lib$CoreEngine$GameComponents$Player$Base$PressTime(ct)
						}),
					_Utils_update(
						d,
						{
							velocity: _Utils_Tuple2(vx, vy + 5)
						})) : _Utils_Tuple2(
					_Utils_update(
						model,
						{keyPressed: $author$project$Lib$CoreEngine$GameComponents$Player$Base$Nope}),
					d);
			} else {
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{
							keyPressed: $author$project$Lib$CoreEngine$GameComponents$Player$Base$PressTime(ct)
						}),
					_Utils_update(
						d,
						{
							velocity: _Utils_Tuple2(vx, vy + 120)
						}));
			}
		}
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocity = F4(
	function (t, _char, ggd, model) {
		var space = model.currentKeys.space;
		var curTime = t;
		if ($elm$core$Basics$abs(_char.velocity.a) > 80) {
			return A4(
				$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$delLargeVelocity,
				t,
				model,
				_char,
				A2($author$project$Lib$CoreEngine$Physics$Ground$canJump, _char, ggd));
		} else {
			if (!space) {
				return (!A2($author$project$Lib$CoreEngine$Physics$Ground$canJump, _char, ggd)) ? _Utils_Tuple2(
					model,
					A2(
						$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityHelper,
						_char,
						A2(
							$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$boundXY,
							A3($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityX, _char, model, $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Ydir),
							_char.velocity))) : _Utils_Tuple2(
					model,
					A2(
						$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityHelper,
						_char,
						A2(
							$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$boundXY,
							A3($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityX, _char, model, $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Xdir),
							_char.velocity)));
			} else {
				if (space === 1) {
					var _v0 = model.keyPressed;
					if (_v0.$ === 'PressTime') {
						var time = _v0.a;
						return ((curTime - time) <= 20) ? _Utils_Tuple2(
							model,
							A2(
								$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityHelper,
								_char,
								A2(
									$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$boundXY,
									A3($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityX, _char, model, $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Ydir),
									A2($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityY, _char, 2)))) : ((!A2($author$project$Lib$CoreEngine$Physics$Ground$canJump, _char, ggd)) ? _Utils_Tuple2(
							_Utils_update(
								model,
								{keyPressed: $author$project$Lib$CoreEngine$GameComponents$Player$Base$Nope}),
							A2(
								$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityHelper,
								_char,
								A2(
									$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$boundXY,
									A3($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityX, _char, model, $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Ydir),
									_char.velocity))) : _Utils_Tuple2(
							_Utils_update(
								model,
								{keyPressed: $author$project$Lib$CoreEngine$GameComponents$Player$Base$Nope}),
							A2(
								$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityHelper,
								_char,
								A2(
									$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$boundXY,
									A3($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityX, _char, model, $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Xdir),
									_char.velocity))));
					} else {
						return (!A2($author$project$Lib$CoreEngine$Physics$Ground$canJump, _char, ggd)) ? _Utils_Tuple2(
							_Utils_update(
								model,
								{
									keyPressed: $author$project$Lib$CoreEngine$GameComponents$Player$Base$PressTime(curTime)
								}),
							A2(
								$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityHelper,
								_char,
								A2(
									$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$boundXY,
									A3($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityX, _char, model, $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Ydir),
									A2($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityY, _char, 1)))) : _Utils_Tuple2(
							model,
							A2(
								$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityHelper,
								_char,
								A2(
									$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$boundXY,
									A3($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityX, _char, model, $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Ydir),
									A2($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityY, _char, 1))));
					}
				} else {
					if (!A2($author$project$Lib$CoreEngine$Physics$Ground$canJump, _char, ggd)) {
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{keyPressed: $author$project$Lib$CoreEngine$GameComponents$Player$Base$Nope}),
							A2(
								$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityHelper,
								_char,
								A2(
									$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$boundXY,
									A3($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityX, _char, model, $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Ydir),
									_char.velocity)));
					} else {
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{keyPressed: $author$project$Lib$CoreEngine$GameComponents$Player$Base$Nope}),
							A2(
								$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityHelper,
								_char,
								A2(
									$author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$boundXY,
									A3($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocityX, _char, model, $author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$Xdir),
									_char.velocity)));
					}
				}
			}
		}
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$Base$changebk = F3(
	function (key, status, bk) {
		switch (key) {
			case 65:
				return _Utils_update(
					bk,
					{left: status});
			case 68:
				return _Utils_update(
					bk,
					{right: status});
			case 67:
				return _Utils_update(
					bk,
					{space: status});
			default:
				return bk;
		}
	});
var $author$project$Lib$DefinedTypes$Parser$dgetPlayer = F2(
	function (f, s) {
		var _v0 = A2($elm$core$Dict$get, s, f);
		if ((_v0.$ === 'Just') && (_v0.a.$ === 'CDPlayerModel')) {
			var x = _v0.a.a;
			return x;
		} else {
			return $author$project$Lib$CoreEngine$GameComponents$Player$Base$nullModel;
		}
	});
var $elm$core$Dict$update = F3(
	function (targetKey, alter, dictionary) {
		var _v0 = alter(
			A2($elm$core$Dict$get, targetKey, dictionary));
		if (_v0.$ === 'Just') {
			var value = _v0.a;
			return A3($elm$core$Dict$insert, targetKey, value, dictionary);
		} else {
			return A2($elm$core$Dict$remove, targetKey, dictionary);
		}
	});
var $author$project$Lib$DefinedTypes$Parser$dsetPlayer = F3(
	function (s, t, f) {
		return A3(
			$elm$core$Dict$update,
			s,
			function (_v0) {
				return $elm$core$Maybe$Just(
					$author$project$Lib$Component$Base$CDPlayerModel(t));
			},
			f);
	});
var $author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera = F2(
	function (_v0, ggd) {
		var x = _v0.a;
		var y = _v0.b;
		var _v1 = ggd.camera.position;
		var cx = _v1.a;
		var cy = _v1.b;
		return _Utils_Tuple2(x - cx, y - cy);
	});
var $author$project$Lib$CoreEngine$GameComponent$ComponentHandler$isAlive = function (d) {
	var _v0 = d.status;
	if (_v0.$ === 'Alive') {
		return true;
	} else {
		return false;
	}
};
var $author$project$Constants$plHeight = 1080;
var $author$project$Lib$Coordinate$Coordinates$heightToReal = F2(
	function (gd, x) {
		var realHeight = gd.realHeight;
		return realHeight * (x / ($author$project$Constants$plHeight - 1));
	});
var $author$project$Constants$plWidth = 1920;
var $author$project$Lib$Coordinate$Coordinates$posToReal = F2(
	function (gd, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		var realWidth = gd.realWidth;
		var realHeight = gd.realHeight;
		return _Utils_Tuple2(realWidth * (x / ($author$project$Constants$plWidth - 1)), realHeight * (y / ($author$project$Constants$plHeight - 1)));
	});
var $author$project$Lib$Coordinate$Coordinates$widthToReal = F2(
	function (gd, x) {
		var realWidth = gd.realWidth;
		return realWidth * (x / ($author$project$Constants$plWidth - 1));
	});
var $author$project$Lib$Coordinate$Coordinates$judgeMouse = F4(
	function (gd, _v0, _v1, _v2) {
		var mx = _v0.a;
		var my = _v0.b;
		var x = _v1.a;
		var y = _v1.b;
		var w = _v2.a;
		var h = _v2.b;
		var rw = A2($author$project$Lib$Coordinate$Coordinates$widthToReal, gd, w);
		var rh = A2($author$project$Lib$Coordinate$Coordinates$heightToReal, gd, h);
		var mpy = my - gd.startTop;
		var mpx = mx - gd.startLeft;
		var _v3 = A2(
			$author$project$Lib$Coordinate$Coordinates$posToReal,
			gd,
			_Utils_Tuple2(x, y));
		var rpx = _v3.a;
		var rpy = _v3.b;
		return ((_Utils_cmp(rpx, mpx) < 1) && ((_Utils_cmp(mpx, rpx + rw) < 1) && ((_Utils_cmp(rpy, mpy) < 1) && (_Utils_cmp(mpy, rpy + rh) < 1)))) ? true : false;
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$InputFilter$isFirstJump = function (model) {
	return ((!model.lastOriginKeys.space) && (model.originKeys.space === 1)) ? true : false;
};
var $author$project$Lib$CoreEngine$GameComponents$Player$InputFilter$isNope = function (model) {
	var _v0 = model.keyPressed;
	if (_v0.$ === 'Nope') {
		return true;
	} else {
		return false;
	}
};
var $author$project$Lib$CoreEngine$GameComponents$Player$FSM$allStates = _List_fromArray(
	[
		{
		doing: F5(
			function (_v0, _v1, _v2, x, _v3) {
				return x;
			}),
		ifEnter: F4(
			function (_v4, _v5, gc, ggd) {
				return A2($author$project$Lib$CoreEngine$Physics$Ground$isOnground, gc, ggd);
			}),
		ifExit: F5(
			function (_v6, _v7, _v8, gc, ggd) {
				return A2($author$project$Lib$CoreEngine$Physics$Ground$isInAir, gc, ggd);
			}),
		key: 'onground',
		onEnter: F4(
			function (_v9, _v10, x, _v11) {
				return x;
			}),
		onExit: F5(
			function (_v12, _v13, _v14, x, _v15) {
				return x;
			})
	},
		{
		doing: F5(
			function (_v16, _v17, _v18, x, _v19) {
				return x;
			}),
		ifEnter: F4(
			function (_v20, _v21, gc, ggd) {
				return A2($author$project$Lib$CoreEngine$Physics$Ground$isInAir, gc, ggd);
			}),
		ifExit: F5(
			function (_v22, _v23, _v24, gc, ggd) {
				return A2($author$project$Lib$CoreEngine$Physics$Ground$isOnground, gc, ggd);
			}),
		key: 'inair',
		onEnter: F4(
			function (_v25, _v26, x, _v27) {
				return x;
			}),
		onExit: F5(
			function (_v28, _v29, _v30, x, _v31) {
				return x;
			})
	},
		{
		doing: F5(
			function (_v32, _v33, _v34, x, _v35) {
				return x;
			}),
		ifEnter: F4(
			function (_v36, _v37, _v38, _v39) {
				return false;
			}),
		ifExit: F5(
			function (_v40, _v41, _v42, gc, ggd) {
				return A2($author$project$Lib$CoreEngine$Physics$Ground$isOnground, gc, ggd);
			}),
		key: 'wolfjump',
		onEnter: F4(
			function (_v43, _v44, x, _v45) {
				return x;
			}),
		onExit: F5(
			function (_v46, _v47, _v48, x, _v49) {
				return x;
			})
	}
	]);
var $elm$core$List$head = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(x);
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $author$project$Lib$CoreEngine$GameComponents$Player$FSM$nullState = {
	doing: F5(
		function (_v0, _v1, _v2, x, _v3) {
			return x;
		}),
	ifEnter: F4(
		function (_v4, _v5, _v6, _v7) {
			return false;
		}),
	ifExit: F5(
		function (_v8, _v9, _v10, _v11, _v12) {
			return false;
		}),
	key: '',
	onEnter: F4(
		function (_v13, _v14, x, _v15) {
			return x;
		}),
	onExit: F5(
		function (_v16, _v17, _v18, x, _v19) {
			return x;
		})
};
var $author$project$Lib$CoreEngine$GameComponents$Player$FSM$getStateFunction = function (s) {
	return A2(
		$elm$core$Maybe$withDefault,
		$author$project$Lib$CoreEngine$GameComponents$Player$FSM$nullState,
		$elm$core$List$head(
			A2(
				$elm$core$List$filter,
				function (x) {
					return _Utils_eq(x.key, s);
				},
				$author$project$Lib$CoreEngine$GameComponents$Player$FSM$allStates)));
};
var $author$project$Lib$CoreEngine$GameComponents$Player$FSM$getPlayerStates = function (model) {
	var _v0 = model.playerStates;
	var x = _v0.a;
	return A2(
		$elm$core$List$map,
		function (ps) {
			return _Utils_Tuple2(
				$author$project$Lib$CoreEngine$GameComponents$Player$FSM$getStateFunction(ps.stype),
				ps.starttime);
		},
		x);
};
var $author$project$Lib$CoreEngine$GameComponents$Player$FSM$queryIsState = F2(
	function (model, qs) {
		return A2(
			$elm$core$List$any,
			function (_v0) {
				var x = _v0.a;
				return _Utils_eq(x.key, qs);
			},
			$author$project$Lib$CoreEngine$GameComponents$Player$FSM$getPlayerStates(model));
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$FSM$queryStateStarttime = F2(
	function (model, s) {
		var alls = A2(
			$elm$core$List$filter,
			function (_v2) {
				var x = _v2.a;
				return _Utils_eq(x.key, s);
			},
			$author$project$Lib$CoreEngine$GameComponents$Player$FSM$getPlayerStates(model));
		if (alls.b) {
			var _v1 = alls.a;
			var ss = _v1.b;
			return ss;
		} else {
			return 0;
		}
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$InputFilter$preCheck = F3(
	function (t, model, d) {
		var stt = A2($author$project$Lib$CoreEngine$GameComponents$Player$FSM$queryStateStarttime, model, 'inair');
		var mok = model.originKeys;
		var jst = $author$project$Lib$CoreEngine$GameComponents$Player$InputFilter$isFirstJump(model) ? t : model.jStartTime;
		var cs = model.originKeys.space;
		var iswolfJump = (cs === 1) && (A2($author$project$Lib$CoreEngine$GameComponents$Player$FSM$queryIsState, model, 'inair') && (((t - stt) <= 10) && ($author$project$Lib$CoreEngine$GameComponents$Player$InputFilter$isNope(model) && ((t - jst) <= 10))));
		var newd = function () {
			if (iswolfJump) {
				var _v0 = d.velocity;
				var vx = _v0.a;
				return _Utils_update(
					d,
					{
						velocity: _Utils_Tuple2(vx, 0)
					});
			} else {
				return d;
			}
		}();
		var nspace = (cs === 1) ? ((A2($author$project$Lib$CoreEngine$GameComponents$Player$FSM$queryIsState, model, 'inair') && (!$author$project$Lib$CoreEngine$GameComponents$Player$InputFilter$isNope(model))) ? 1 : ((A2($author$project$Lib$CoreEngine$GameComponents$Player$FSM$queryIsState, model, 'onground') && ((t - jst) <= 10)) ? 1 : (iswolfJump ? 1 : 0))) : cs;
		var newkeys = _Utils_update(
			mok,
			{space: nspace});
		return _Utils_Tuple2(
			_Utils_update(
				model,
				{currentKeys: newkeys, jStartTime: jst}),
			newd);
	});
var $author$project$Lib$CoreEngine$Physics$Acceleration$putAccOn = function (ada) {
	var _v0 = ada.velocity;
	var ovx = _v0.a;
	var ovy = _v0.b;
	var _v1 = ada.acceleration;
	var acx = _v1.a;
	var acy = _v1.b;
	var newvel = _Utils_Tuple2(ovx + acx, ovy + acy);
	var newdata = _Utils_update(
		ada,
		{velocity: newvel});
	return newdata;
};
var $author$project$Lib$CoreEngine$GameComponents$Player$Model$reboundPlayer = F2(
	function (rbv, d) {
		var _v0 = d.position;
		var px = _v0.a;
		var py = _v0.b;
		var _v1 = d.velocity;
		var pvx = _v1.a;
		var pvy = _v1.b;
		var nv = (_Utils_cmp(pvy, -200) > 0) ? 200 : ((_Utils_cmp(pvy, -300) > 0) ? 300 : 400);
		return _Utils_update(
			d,
			{
				position: _Utils_Tuple2(px, py - 10),
				velocity: _Utils_Tuple2(
					pvx,
					nv + $elm$core$Basics$abs(rbv))
			});
	});
var $author$project$Lib$CoreEngine$Physics$SolidCollision$getNearBySolid = F2(
	function (ggd, d) {
		var _v0 = A2($author$project$Lib$CoreEngine$Physics$NaiveCollision$getBoxPos, d.position, d.simplecheck);
		var _v1 = _v0.a;
		var px = _v1.a;
		var py = _v1.b;
		var _v2 = _v0.b;
		var p2x = _v2.a;
		var p2y = _v2.b;
		var _v3 = _Utils_Tuple2(((p2x / $author$project$Lib$CoreEngine$Base$brickSize) | 0) + 2, ((p2y / $author$project$Lib$CoreEngine$Base$brickSize) | 0) + 2);
		var pb3 = _v3.a;
		var pb4 = _v3.b;
		var _v4 = _Utils_Tuple2(((px / $author$project$Lib$CoreEngine$Base$brickSize) | 0) - 2, ((py / $author$project$Lib$CoreEngine$Base$brickSize) | 0) - 2);
		var pb1 = _v4.a;
		var pb2 = _v4.b;
		var ir = A2($elm$core$List$range, pb1, pb3);
		var jr = A2($elm$core$List$range, pb2, pb4);
		return A3(
			$elm$core$List$foldl,
			F2(
				function (i, all) {
					return A3(
						$elm$core$List$foldl,
						F2(
							function (j, all2) {
								var _v5 = A3($tortus$elm_array_2d$Array2D$get, i, j, ggd.solidmap);
								if (_v5.$ === 'Just') {
									var v = _v5.a;
									return (v > 0) ? _Utils_ap(
										all2,
										_List_fromArray(
											[
												_Utils_Tuple2(i, j)
											])) : all2;
								} else {
									return all2;
								}
							}),
						all,
						jr);
				}),
			_List_Nil,
			ir);
	});
var $author$project$Lib$CoreEngine$Physics$CollisionShape$CBOOSTBOTTOMLEFT = {$: 'CBOOSTBOTTOMLEFT'};
var $author$project$Lib$CoreEngine$Physics$CollisionShape$CBOOSTBOTTOMRIGHT = {$: 'CBOOSTBOTTOMRIGHT'};
var $author$project$Lib$CoreEngine$Physics$CollisionShape$CBOOSTTOPLEFT = {$: 'CBOOSTTOPLEFT'};
var $author$project$Lib$CoreEngine$Physics$CollisionShape$CBOOSTTOPRIGHT = {$: 'CBOOSTTOPRIGHT'};
var $author$project$Lib$CoreEngine$Physics$CollisionShape$CBOTTOM = {$: 'CBOTTOM'};
var $author$project$Lib$CoreEngine$Physics$CollisionShape$CBOTTOMLEFT = {$: 'CBOTTOMLEFT'};
var $author$project$Lib$CoreEngine$Physics$CollisionShape$CBOTTOMRIGHT = {$: 'CBOTTOMRIGHT'};
var $author$project$Lib$CoreEngine$Physics$CollisionShape$CLCORNERBOOST = {$: 'CLCORNERBOOST'};
var $author$project$Lib$CoreEngine$Physics$CollisionShape$CLEFT = {$: 'CLEFT'};
var $author$project$Lib$CoreEngine$Physics$CollisionShape$CRCORNERBOOST = {$: 'CRCORNERBOOST'};
var $author$project$Lib$CoreEngine$Physics$CollisionShape$CRIGHT = {$: 'CRIGHT'};
var $author$project$Lib$CoreEngine$Physics$CollisionShape$CTOP = {$: 'CTOP'};
var $author$project$Lib$CoreEngine$Physics$CollisionShape$CTOPLEFT = {$: 'CTOPLEFT'};
var $author$project$Lib$CoreEngine$Physics$CollisionShape$CTOPRIGHT = {$: 'CTOPRIGHT'};
var $elm$core$Basics$composeL = F3(
	function (g, f, x) {
		return g(
			f(x));
	});
var $elm$core$List$all = F2(
	function (isOkay, list) {
		return !A2(
			$elm$core$List$any,
			A2($elm$core$Basics$composeL, $elm$core$Basics$not, isOkay),
			list);
	});
var $author$project$Lib$CoreEngine$Physics$CollisionShape$judgeXSame = function (ls) {
	var h = A2(
		$elm$core$Maybe$withDefault,
		_Utils_Tuple2(0, 0),
		$elm$core$List$head(ls)).a;
	return A2(
		$elm$core$List$all,
		function (_v0) {
			var x = _v0.a;
			return _Utils_eq(x, h);
		},
		ls);
};
var $author$project$Lib$CoreEngine$Physics$CollisionShape$judgeYSame = function (ls) {
	var h = A2(
		$elm$core$Maybe$withDefault,
		_Utils_Tuple2(0, 0),
		$elm$core$List$head(ls)).b;
	return A2(
		$elm$core$List$all,
		function (_v0) {
			var y = _v0.b;
			return _Utils_eq(y, h);
		},
		ls);
};
var $author$project$Lib$CoreEngine$Physics$CollisionShape$judgeShape = F2(
	function (d, ls) {
		var ysame = $author$project$Lib$CoreEngine$Physics$CollisionShape$judgeYSame(ls);
		var xsame = $author$project$Lib$CoreEngine$Physics$CollisionShape$judgeXSame(ls);
		var _v0 = d.velocity;
		var x = _v0.a;
		var y = _v0.b;
		var _v1 = A2($author$project$Lib$CoreEngine$Physics$NaiveCollision$getBoxPos, d.position, d.simplecheck);
		var _v2 = _v1.a;
		var x1 = _v2.a;
		var y1 = _v2.b;
		var _v3 = _v1.b;
		var x2 = _v3.a;
		if (ls.b && (!ls.b.b)) {
			var _v5 = ls.a;
			var lfx = _v5.a;
			var lfy = _v5.b;
			var _v6 = _Utils_Tuple2(((lfx + 1) * $author$project$Lib$CoreEngine$Base$brickSize) - 1, ((lfy + 1) * $author$project$Lib$CoreEngine$Base$brickSize) - 1);
			var blx2 = _v6.a;
			var bly2 = _v6.b;
			var _v7 = _Utils_Tuple2(lfx * $author$project$Lib$CoreEngine$Base$brickSize, lfy * $author$project$Lib$CoreEngine$Base$brickSize);
			var blx1 = _v7.a;
			return (_Utils_cmp(x2, blx1) < 0) ? ((x > 200) ? $author$project$Lib$CoreEngine$Physics$CollisionShape$CRCORNERBOOST : $author$project$Lib$CoreEngine$Physics$CollisionShape$CRIGHT) : ((_Utils_cmp(x1, blx2) > 0) ? ((_Utils_cmp(x, -200) < 0) ? $author$project$Lib$CoreEngine$Physics$CollisionShape$CLCORNERBOOST : $author$project$Lib$CoreEngine$Physics$CollisionShape$CLEFT) : ((_Utils_cmp(y1, bly2) > 0) ? ((_Utils_cmp(x1, blx2 - 12) > -1) ? $author$project$Lib$CoreEngine$Physics$CollisionShape$CBOOSTTOPRIGHT : ((_Utils_cmp(x2, blx1 + 12) < 1) ? $author$project$Lib$CoreEngine$Physics$CollisionShape$CBOOSTTOPLEFT : $author$project$Lib$CoreEngine$Physics$CollisionShape$CTOP)) : ((_Utils_cmp(x1, blx2 - 12) > -1) ? $author$project$Lib$CoreEngine$Physics$CollisionShape$CBOOSTBOTTOMRIGHT : ((_Utils_cmp(x2, blx1 + 12) < 1) ? $author$project$Lib$CoreEngine$Physics$CollisionShape$CBOOSTBOTTOMLEFT : $author$project$Lib$CoreEngine$Physics$CollisionShape$CBOTTOM))));
		} else {
			return ((y >= 0) && (x >= 0)) ? (ysame ? $author$project$Lib$CoreEngine$Physics$CollisionShape$CTOP : (xsame ? $author$project$Lib$CoreEngine$Physics$CollisionShape$CRIGHT : $author$project$Lib$CoreEngine$Physics$CollisionShape$CTOPRIGHT)) : (((y >= 0) && (x < 0)) ? (ysame ? $author$project$Lib$CoreEngine$Physics$CollisionShape$CTOP : (xsame ? $author$project$Lib$CoreEngine$Physics$CollisionShape$CLEFT : $author$project$Lib$CoreEngine$Physics$CollisionShape$CTOPLEFT)) : (((y < 0) && (x >= 0)) ? (ysame ? $author$project$Lib$CoreEngine$Physics$CollisionShape$CBOTTOM : (xsame ? $author$project$Lib$CoreEngine$Physics$CollisionShape$CRIGHT : $author$project$Lib$CoreEngine$Physics$CollisionShape$CBOTTOMRIGHT)) : (ysame ? $author$project$Lib$CoreEngine$Physics$CollisionShape$CBOTTOM : (xsame ? $author$project$Lib$CoreEngine$Physics$CollisionShape$CLEFT : $author$project$Lib$CoreEngine$Physics$CollisionShape$CBOTTOMLEFT))));
		}
	});
var $author$project$Lib$Tools$Array$delSame = F2(
	function (ls, xs) {
		delSame:
		while (true) {
			if (ls.b) {
				var l = ls.a;
				var lps = ls.b;
				var _v1 = $elm$core$List$head(
					$elm$core$List$reverse(xs));
				if (_v1.$ === 'Nothing') {
					var $temp$ls = lps,
						$temp$xs = _List_fromArray(
						[l]);
					ls = $temp$ls;
					xs = $temp$xs;
					continue delSame;
				} else {
					var x = _v1.a;
					if (_Utils_eq(l, x)) {
						var $temp$ls = lps,
							$temp$xs = xs;
						ls = $temp$ls;
						xs = $temp$xs;
						continue delSame;
					} else {
						var $temp$ls = lps,
							$temp$xs = _Utils_ap(
							xs,
							_List_fromArray(
								[l]));
						ls = $temp$ls;
						xs = $temp$xs;
						continue delSame;
					}
				}
			} else {
				return xs;
			}
		}
	});
var $author$project$Lib$CoreEngine$Physics$NaiveCollision$judgeCollision = F2(
	function (_v0, _v1) {
		var p1 = _v0.a;
		var p2 = _v0.b;
		var p3 = _v1.a;
		var p4 = _v1.b;
		var p4y = p4.b;
		var p4x = p4.a;
		var p3y = p3.b;
		var p3x = p3.a;
		var p2y = p2.b;
		var p2x = p2.a;
		var p1y = p1.b;
		var p1x = p1.a;
		return ((_Utils_cmp(p2y, p3y) > -1) && ((_Utils_cmp(p1y, p4y) < 1) && ((_Utils_cmp(p2x, p3x) > -1) && (_Utils_cmp(p1x, p4x) < 1)))) ? true : false;
	});
var $author$project$Lib$CoreEngine$Physics$SolidCollision$judgeEasyCollision = F2(
	function (d, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		var gbx = A2($author$project$Lib$CoreEngine$Physics$NaiveCollision$getBoxPos, d.position, d.simplecheck);
		var res = A2(
			$author$project$Lib$CoreEngine$Physics$NaiveCollision$judgeCollision,
			gbx,
			_Utils_Tuple2(
				_Utils_Tuple2(x * $author$project$Lib$CoreEngine$Base$brickSize, y * $author$project$Lib$CoreEngine$Base$brickSize),
				_Utils_Tuple2(((x * $author$project$Lib$CoreEngine$Base$brickSize) + $author$project$Lib$CoreEngine$Base$brickSize) - 1, ((y * $author$project$Lib$CoreEngine$Base$brickSize) + $author$project$Lib$CoreEngine$Base$brickSize) - 1)));
		return res;
	});
var $author$project$Lib$CoreEngine$Physics$SolidCollision$velToDis = function (x) {
	return x / 15;
};
var $author$project$Lib$CoreEngine$Physics$SolidCollision$moveTilCollide = F2(
	function (d, xs) {
		var qs = A2($elm$core$List$range, 0, 100);
		var _v0 = d.velocity;
		var vx = _v0.a;
		var vy = _v0.b;
		var tdisx = $author$project$Lib$CoreEngine$Physics$SolidCollision$velToDis(vx);
		var tdisy = -$author$project$Lib$CoreEngine$Physics$SolidCollision$velToDis(vy);
		var _v1 = d.position;
		var opx = _v1.a;
		var opy = _v1.b;
		var qsmp = A2(
			$elm$core$List$map,
			function (x) {
				return _Utils_Tuple2(
					$elm$core$Basics$floor(opx + ((tdisx * x) / 100)),
					$elm$core$Basics$floor(opy + ((tdisy * x) / 100)));
			},
			qs);
		var qsm = A2($author$project$Lib$Tools$Array$delSame, qsmp, _List_Nil);
		var alls = A2(
			$elm$core$List$filter,
			function (pos) {
				var newd = _Utils_update(
					d,
					{position: pos});
				return A2(
					$elm$core$List$all,
					function (x) {
						return !A2($author$project$Lib$CoreEngine$Physics$SolidCollision$judgeEasyCollision, newd, x);
					},
					xs);
			},
			qsm);
		var qh = A2(
			$elm$core$Maybe$withDefault,
			d.position,
			$elm$core$List$head(
				$elm$core$List$reverse(alls)));
		return _Utils_update(
			d,
			{position: qh});
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$Movement$solidCollisionMove = F3(
	function (ls, ggd, d) {
		var moved = A2(
			$author$project$Lib$CoreEngine$Physics$SolidCollision$moveTilCollide,
			d,
			A2($author$project$Lib$CoreEngine$Physics$SolidCollision$getNearBySolid, ggd, d));
		var jshape = A2($author$project$Lib$CoreEngine$Physics$CollisionShape$judgeShape, d, ls);
		var _v0 = d.velocity;
		var pvx = _v0.a;
		var pvy = _v0.b;
		var newvel = function () {
			switch (jshape.$) {
				case 'CTOP':
					return _Utils_Tuple2(pvx, 0);
				case 'CBOTTOM':
					return _Utils_Tuple2(pvx, 0);
				case 'CRIGHT':
					return _Utils_Tuple2(0, pvy);
				case 'CLEFT':
					return _Utils_Tuple2(0, pvy);
				case 'CBOTTOMLEFT':
					return _Utils_Tuple2(0, 0);
				case 'CBOTTOMRIGHT':
					return _Utils_Tuple2(0, 0);
				case 'CTOPLEFT':
					return _Utils_Tuple2(0, 0);
				case 'CTOPRIGHT':
					return _Utils_Tuple2(0, 0);
				case 'CBOOSTBOTTOMLEFT':
					return (_Utils_cmp(pvy, -50) > 0) ? _Utils_Tuple2(pvx, 0) : ((_Utils_cmp(pvy, -150) > 0) ? _Utils_Tuple2(-40, 0) : _Utils_Tuple2((-10) + pvy, 0));
				case 'CBOOSTBOTTOMRIGHT':
					return (_Utils_cmp(pvy, -50) > 0) ? _Utils_Tuple2(pvx, 0) : ((_Utils_cmp(pvy, -150) > 0) ? _Utils_Tuple2(40, 0) : _Utils_Tuple2(10 - pvy, 0));
				case 'CBOOSTTOPLEFT':
					return _Utils_Tuple2(-40, 0);
				case 'CBOOSTTOPRIGHT':
					return _Utils_Tuple2(40, 0);
				case 'CRCORNERBOOST':
					return _Utils_Tuple2(pvx + 30, pvy);
				default:
					return _Utils_Tuple2(pvx - 30, pvy);
			}
		}();
		var _v1 = moved.position;
		var mvdx = _v1.a;
		var mvdy = _v1.b;
		var newpos = function () {
			switch (jshape.$) {
				case 'CRCORNERBOOST':
					return (_Utils_cmp(pvy, -50) > 0) ? _Utils_Tuple2(mvdx, mvdy) : _Utils_Tuple2(mvdx, mvdy - 20);
				case 'CLCORNERBOOST':
					return (_Utils_cmp(pvy, -50) > 0) ? _Utils_Tuple2(mvdx, mvdy) : _Utils_Tuple2(mvdx, mvdy - 20);
				default:
					return _Utils_Tuple2(mvdx, mvdy);
			}
		}();
		return _Utils_update(
			moved,
			{position: newpos, velocity: newvel});
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$Base$StateData = F2(
	function (stype, starttime) {
		return {starttime: starttime, stype: stype};
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$FSM$addPlayerStates = F3(
	function (t, model, s) {
		var _v0 = model.playerStates;
		var x = _v0.a;
		return $author$project$Lib$CoreEngine$GameComponents$Player$Base$PlayerStates(
			_Utils_ap(
				x,
				_List_fromArray(
					[
						A2($author$project$Lib$CoreEngine$GameComponents$Player$Base$StateData, s, t)
					])));
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$FSM$addState = F5(
	function (t, model, gc, ggd, key) {
		var ns = $author$project$Lib$CoreEngine$GameComponents$Player$FSM$getStateFunction(key);
		var newgc = A4(ns.onEnter, t, model, gc, ggd);
		return _Utils_Tuple2(
			_Utils_update(
				model,
				{
					playerStates: A3($author$project$Lib$CoreEngine$GameComponents$Player$FSM$addPlayerStates, t, model, key)
				}),
			newgc);
	});
var $elm$core$Basics$neq = _Utils_notEqual;
var $author$project$Lib$CoreEngine$GameComponents$Player$FSM$delPlayerStates = F2(
	function (model, s) {
		var _v0 = model.playerStates;
		var x = _v0.a;
		return $author$project$Lib$CoreEngine$GameComponents$Player$Base$PlayerStates(
			A2(
				$elm$core$List$filter,
				function (t) {
					return !_Utils_eq(t.stype, s);
				},
				x));
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$FSM$exitState = F5(
	function (t, model, gc, ggd, key) {
		var ss = $author$project$Lib$CoreEngine$GameComponents$Player$FSM$getPlayerStates(model);
		var origin = $elm$core$List$head(
			A2(
				$elm$core$List$filter,
				function (_v2) {
					var x = _v2.a;
					return _Utils_eq(x.key, key);
				},
				ss));
		var tr = function () {
			if (origin.$ === 'Just') {
				var _v1 = origin.a;
				var a = _v1.a;
				var startt = _v1.b;
				return A5(a.onExit, startt, t, model, gc, ggd);
			} else {
				return gc;
			}
		}();
		var deled = A2($author$project$Lib$CoreEngine$GameComponents$Player$FSM$delPlayerStates, model, key);
		return _Utils_Tuple2(
			_Utils_update(
				model,
				{playerStates: deled}),
			tr);
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$FSM$getEmptyStates = function (m) {
	return A2(
		$elm$core$List$filter,
		function (s) {
			return !A2($author$project$Lib$CoreEngine$GameComponents$Player$FSM$queryIsState, m, s.key);
		},
		$author$project$Lib$CoreEngine$GameComponents$Player$FSM$allStates);
};
var $author$project$Lib$CoreEngine$GameComponents$Player$FSM$getPlayerState = F2(
	function (model, s) {
		var _v0 = model.playerStates;
		var x = _v0.a;
		var target = A2(
			$elm$core$List$filter,
			function (p) {
				return _Utils_eq(p.stype, s);
			},
			x);
		var treal = A2(
			$elm$core$Maybe$withDefault,
			A2($author$project$Lib$CoreEngine$GameComponents$Player$Base$StateData, '', 0),
			$elm$core$List$head(target));
		return _Utils_Tuple2(
			$author$project$Lib$CoreEngine$GameComponents$Player$FSM$getStateFunction(treal.stype),
			treal.starttime);
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$FSM$updateState = F5(
	function (t, model, gc, ggd, key) {
		var _v0 = A2($author$project$Lib$CoreEngine$GameComponents$Player$FSM$getPlayerState, model, key);
		var s = _v0.a;
		var p = _v0.b;
		return _Utils_Tuple2(
			model,
			A5(s.doing, p, t, model, gc, ggd));
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$StatesControl$stateControl = F4(
	function (t, model, gc, ggd) {
		var updatecurrent = F3(
			function (_v6, md, ngc) {
				var state = _v6.a;
				return A5($author$project$Lib$CoreEngine$GameComponents$Player$FSM$updateState, t, md, ngc, ggd, state.key);
			});
		var changecurrent = F3(
			function (_v5, md, ngc) {
				var state = _v5.a;
				var startt = _v5.b;
				return A5(state.ifExit, startt, t, md, ngc, ggd) ? A5($author$project$Lib$CoreEngine$GameComponents$Player$FSM$exitState, t, md, ngc, ggd, state.key) : _Utils_Tuple2(md, ngc);
			});
		var addcurrent = F3(
			function (state, md, ngc) {
				return A4(state.ifEnter, t, md, ngc, ggd) ? A5($author$project$Lib$CoreEngine$GameComponents$Player$FSM$addState, t, md, ngc, ggd, state.key) : _Utils_Tuple2(md, ngc);
			});
		var _v0 = A3(
			$elm$core$List$foldl,
			F2(
				function (loo, _v1) {
					var nmm = _v1.a;
					var ngcc = _v1.b;
					return A3(changecurrent, loo, nmm, ngcc);
				}),
			_Utils_Tuple2(model, gc),
			$author$project$Lib$CoreEngine$GameComponents$Player$FSM$getPlayerStates(model));
		var model2 = _v0.a;
		var gc2 = _v0.b;
		var allempty = $author$project$Lib$CoreEngine$GameComponents$Player$FSM$getEmptyStates(model2);
		var _v2 = A3(
			$elm$core$List$foldl,
			F2(
				function (xx, _v3) {
					var nmm = _v3.a;
					var ngcc = _v3.b;
					return A3(addcurrent, xx, nmm, ngcc);
				}),
			_Utils_Tuple2(model2, gc2),
			allempty);
		var model3 = _v2.a;
		var gc3 = _v2.b;
		var newmodel = A3(
			$elm$core$List$foldl,
			F2(
				function (xx, _v4) {
					var nmm = _v4.a;
					var ngcc = _v4.b;
					return A3(updatecurrent, xx, nmm, ngcc);
				}),
			_Utils_Tuple2(model3, gc3),
			$author$project$Lib$CoreEngine$GameComponents$Player$FSM$getPlayerStates(model3));
		return newmodel;
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$Model$updateModel = F5(
	function (msg, gct, ggd, gd, _v0) {
		var d = _v0.a;
		var t = _v0.b;
		var model = A2($author$project$Lib$DefinedTypes$Parser$dgetPlayer, d.extra, 'model');
		_v1$4:
		while (true) {
			switch (msg.$) {
				case 'Tick':
					if (gct.$ === 'GameSolidCollisionMsg') {
						var cs = gct.a;
						var _v3 = A4($author$project$Lib$CoreEngine$GameComponents$Player$StatesControl$stateControl, t, model, d, ggd);
						var afterStateM = _v3.a;
						var afterStateD = _v3.b;
						var _v4 = A3($author$project$Lib$CoreEngine$GameComponents$Player$InputFilter$preCheck, t, afterStateM, afterStateD);
						var aftercheckM = _v4.a;
						var aftercheckD = _v4.b;
						var _v5 = A4($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocity, t, aftercheckD, ggd, aftercheckM);
						var afterVelM = _v5.a;
						var afterVelD = _v5.b;
						var afterAccD = $author$project$Lib$CoreEngine$Physics$Acceleration$putAccOn(afterVelD);
						var aftermoveD = A3($author$project$Lib$CoreEngine$GameComponents$Player$Movement$solidCollisionMove, cs, ggd, afterAccD);
						var aftermoveM = $author$project$Lib$CoreEngine$GameComponents$Player$InputFilter$afterMove(afterVelM);
						var exportmodel = A3($author$project$Lib$DefinedTypes$Parser$dsetPlayer, 'model', aftermoveM, aftermoveD.extra);
						return _Utils_Tuple3(
							_Utils_update(
								aftermoveD,
								{extra: exportmodel}),
							_List_Nil,
							ggd);
					} else {
						if ($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$isAlive(d)) {
							var _v6 = A4($author$project$Lib$CoreEngine$GameComponents$Player$StatesControl$stateControl, t, model, d, ggd);
							var afterStateM = _v6.a;
							var afterStateD = _v6.b;
							var _v7 = A3($author$project$Lib$CoreEngine$GameComponents$Player$InputFilter$preCheck, t, afterStateM, afterStateD);
							var aftercheckM = _v7.a;
							var aftercheckD = _v7.b;
							var _v8 = A4($author$project$Lib$CoreEngine$GameComponents$Player$InputHandler$changePlayerVelocity, t, aftercheckD, ggd, aftercheckM);
							var afterVelM = _v8.a;
							var afterVelD = _v8.b;
							var afterAccD = $author$project$Lib$CoreEngine$Physics$Acceleration$putAccOn(afterVelD);
							var aftermoveM = $author$project$Lib$CoreEngine$GameComponents$Player$InputFilter$afterMove(afterVelM);
							var exportmodel = A3($author$project$Lib$DefinedTypes$Parser$dsetPlayer, 'model', aftermoveM, afterAccD.extra);
							return _Utils_Tuple3(
								_Utils_update(
									afterAccD,
									{extra: exportmodel}),
								_List_Nil,
								ggd);
						} else {
							var afterAccD = $author$project$Lib$CoreEngine$Physics$Acceleration$putAccOn(d);
							return _Utils_Tuple3(afterAccD, _List_Nil, ggd);
						}
					}
				case 'KeyDown':
					var x = msg.a;
					var newmodel = _Utils_update(
						model,
						{
							originKeys: A3($author$project$Lib$CoreEngine$GameComponents$Player$Base$changebk, x, 1, model.originKeys)
						});
					var exportmodel = A3($author$project$Lib$DefinedTypes$Parser$dsetPlayer, 'model', newmodel, d.extra);
					return _Utils_Tuple3(
						_Utils_update(
							d,
							{extra: exportmodel}),
						_List_Nil,
						ggd);
				case 'KeyUp':
					var x = msg.a;
					var newmodel = _Utils_update(
						model,
						{
							originKeys: A3($author$project$Lib$CoreEngine$GameComponents$Player$Base$changebk, x, 0, model.originKeys)
						});
					var exportmodel = A3($author$project$Lib$DefinedTypes$Parser$dsetPlayer, 'model', newmodel, d.extra);
					return _Utils_Tuple3(
						_Utils_update(
							d,
							{extra: exportmodel}),
						_List_Nil,
						ggd);
				case 'MouseDown':
					if (!msg.a) {
						var mp = msg.b;
						return A4(
							$author$project$Lib$Coordinate$Coordinates$judgeMouse,
							gd,
							mp,
							A2($author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera, d.position, ggd),
							_Utils_Tuple2(d.simplecheck.width, d.simplecheck.height)) ? _Utils_Tuple3(
							d,
							_List_Nil,
							_Utils_update(
								ggd,
								{selectobj: d.uid})) : _Utils_Tuple3(d, _List_Nil, ggd);
					} else {
						break _v1$4;
					}
				default:
					break _v1$4;
			}
		}
		_v9$4:
		while (true) {
			switch (gct.$) {
				case 'GameClearVelocity':
					return _Utils_Tuple3(
						_Utils_update(
							d,
							{
								velocity: _Utils_Tuple2(0, 0)
							}),
						_List_Nil,
						ggd);
				case 'GameStringMsg':
					if (gct.a === 'die') {
						return _Utils_Tuple3(
							_Utils_update(
								d,
								{
									status: $author$project$Lib$CoreEngine$GameComponent$Base$Dead(t)
								}),
							_List_Nil,
							ggd);
					} else {
						break _v9$4;
					}
				case 'GameUseEnergy':
					var mp = gct.a;
					var e = gct.b;
					var ndd = A3($author$project$Lib$CoreEngine$Physics$Velocity$changeCVel, d, mp, e);
					return _Utils_Tuple3(ndd, _List_Nil, ggd);
				case 'GameInterCollisionMsg':
					var s = gct.a;
					var icd = gct.b;
					var bs = gct.c;
					if (s === 'goomba') {
						var _v11 = icd.velocity;
						var gbvy = _v11.b;
						if ($elm$core$List$length(bs) >= 2) {
							var _v12 = d.velocity;
							var pvy = _v12.b;
							return ((_Utils_cmp(pvy, -200) < 0) || (gbvy > 100)) ? _Utils_Tuple3(
								A2($author$project$Lib$CoreEngine$GameComponents$Player$Model$reboundPlayer, gbvy, d),
								_List_fromArray(
									[
										A2(
										$author$project$Lib$CoreEngine$GameComponent$Base$GameActorUidMsg,
										icd.uid,
										$author$project$Lib$CoreEngine$GameComponent$Base$GameStringMsg('die'))
									]),
								ggd) : _Utils_Tuple3(
								_Utils_update(
									d,
									{
										status: $author$project$Lib$CoreEngine$GameComponent$Base$Dead(t)
									}),
								_List_Nil,
								ggd);
						} else {
							if (bs.b && (!bs.b.b)) {
								var xx = bs.a;
								var _v14 = xx.name;
								switch (_v14) {
									case 'col':
										return _Utils_Tuple3(
											_Utils_update(
												d,
												{
													status: $author$project$Lib$CoreEngine$GameComponent$Base$Dead(t)
												}),
											_List_Nil,
											ggd);
									case 'reb':
										return _Utils_Tuple3(
											A2($author$project$Lib$CoreEngine$GameComponents$Player$Model$reboundPlayer, gbvy, d),
											_List_fromArray(
												[
													A2(
													$author$project$Lib$CoreEngine$GameComponent$Base$GameActorUidMsg,
													icd.uid,
													$author$project$Lib$CoreEngine$GameComponent$Base$GameStringMsg('die'))
												]),
											ggd);
									default:
										return _Utils_Tuple3(d, _List_Nil, ggd);
								}
							} else {
								return _Utils_Tuple3(d, _List_Nil, ggd);
							}
						}
					} else {
						return _Utils_Tuple3(d, _List_Nil, ggd);
					}
				default:
					break _v9$4;
			}
		}
		return _Utils_Tuple3(d, _List_Nil, ggd);
	});
var $joakin$elm_canvas$Canvas$Internal$Canvas$SettingCommand = function (a) {
	return {$: 'SettingCommand', a: a};
};
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$field = F2(
	function (name, value) {
		return $elm$json$Json$Encode$object(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'type',
					$elm$json$Json$Encode$string('field')),
					_Utils_Tuple2(
					'name',
					$elm$json$Json$Encode$string(name)),
					_Utils_Tuple2('value', value)
				]));
	});
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$globalAlpha = function (alpha) {
	return A2(
		$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$field,
		'globalAlpha',
		$elm$json$Json$Encode$float(alpha));
};
var $joakin$elm_canvas$Canvas$Settings$Advanced$alpha = function (a) {
	return $joakin$elm_canvas$Canvas$Internal$Canvas$SettingCommand(
		$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$globalAlpha(a));
};
var $elm$core$Basics$modBy = _Basics_modBy;
var $author$project$Lib$CoreEngine$GameComponents$Player$Display$getStateNumber = F2(
	function (t, d) {
		var model = A2($author$project$Lib$DefinedTypes$Parser$dgetPlayer, d.extra, 'model');
		var sn = model.playerStates;
		var _v0 = function () {
			if (sn.a.b) {
				var _v2 = sn.a;
				var x = _v2.a;
				return _Utils_Tuple2(x.stype, x.starttime);
			} else {
				return _Utils_Tuple2('', 0);
			}
		}();
		var name = _v0.a;
		var time = _v0.b;
		var ds = A2($elm$core$Basics$modBy, 10, t - time);
		return _Utils_ap(
			name,
			$elm$core$String$fromInt(ds));
	});
var $joakin$elm_canvas$Canvas$Texture$dimensions = function (texture) {
	if (texture.$ === 'TImage') {
		var image = texture.a;
		return {height: image.height, width: image.width};
	} else {
		var data = texture.a;
		return {height: data.height, width: data.width};
	}
};
var $author$project$Lib$Resources$Base$igetSprite = F2(
	function (name, dst) {
		return A2($elm$core$Dict$get, name, dst);
	});
var $joakin$elm_canvas$Canvas$Settings$Advanced$Scale = F2(
	function (a, b) {
		return {$: 'Scale', a: a, b: b};
	});
var $joakin$elm_canvas$Canvas$Settings$Advanced$scale = $joakin$elm_canvas$Canvas$Settings$Advanced$Scale;
var $joakin$elm_canvas$Canvas$Internal$Canvas$DrawableText = function (a) {
	return {$: 'DrawableText', a: a};
};
var $joakin$elm_canvas$Canvas$text = F3(
	function (settings, point, str) {
		return A2(
			$joakin$elm_canvas$Canvas$addSettingsToRenderable,
			settings,
			$joakin$elm_canvas$Canvas$Internal$Canvas$Renderable(
				{
					commands: _List_Nil,
					drawOp: $joakin$elm_canvas$Canvas$Internal$Canvas$NotSpecified,
					drawable: $joakin$elm_canvas$Canvas$Internal$Canvas$DrawableText(
						{maxWidth: $elm$core$Maybe$Nothing, point: point, text: str})
				}));
	});
var $joakin$elm_canvas$Canvas$Internal$Canvas$DrawableTexture = F2(
	function (a, b) {
		return {$: 'DrawableTexture', a: a, b: b};
	});
var $joakin$elm_canvas$Canvas$texture = F3(
	function (settings, p, t) {
		return A2(
			$joakin$elm_canvas$Canvas$addSettingsToRenderable,
			settings,
			$joakin$elm_canvas$Canvas$Internal$Canvas$Renderable(
				{
					commands: _List_Nil,
					drawOp: $joakin$elm_canvas$Canvas$Internal$Canvas$NotSpecified,
					drawable: A2($joakin$elm_canvas$Canvas$Internal$Canvas$DrawableTexture, p, t)
				}));
	});
var $author$project$Lib$Render$Render$transPoint = F2(
	function (gd, p) {
		return A2($author$project$Lib$Coordinate$Coordinates$posToReal, gd, p);
	});
var $joakin$elm_canvas$Canvas$Internal$Canvas$SettingCommands = function (a) {
	return {$: 'SettingCommands', a: a};
};
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn = F2(
	function (name, args) {
		return $elm$json$Json$Encode$object(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'type',
					$elm$json$Json$Encode$string('function')),
					_Utils_Tuple2(
					'name',
					$elm$json$Json$Encode$string(name)),
					_Utils_Tuple2(
					'args',
					A2($elm$json$Json$Encode$list, $elm$core$Basics$identity, args))
				]));
	});
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$rotate = function (angle) {
	return A2(
		$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn,
		'rotate',
		_List_fromArray(
			[
				$elm$json$Json$Encode$float(angle)
			]));
};
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$scale = F2(
	function (x, y) {
		return A2(
			$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn,
			'scale',
			_List_fromArray(
				[
					$elm$json$Json$Encode$float(x),
					$elm$json$Json$Encode$float(y)
				]));
	});
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$transform = F6(
	function (a, b, c, d, e, f) {
		return A2(
			$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn,
			'transform',
			_List_fromArray(
				[
					$elm$json$Json$Encode$float(a),
					$elm$json$Json$Encode$float(b),
					$elm$json$Json$Encode$float(c),
					$elm$json$Json$Encode$float(d),
					$elm$json$Json$Encode$float(e),
					$elm$json$Json$Encode$float(f)
				]));
	});
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$translate = F2(
	function (x, y) {
		return A2(
			$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn,
			'translate',
			_List_fromArray(
				[
					$elm$json$Json$Encode$float(x),
					$elm$json$Json$Encode$float(y)
				]));
	});
var $joakin$elm_canvas$Canvas$Settings$Advanced$transform = function (transforms) {
	return $joakin$elm_canvas$Canvas$Internal$Canvas$SettingCommands(
		A2(
			$elm$core$List$map,
			function (t) {
				switch (t.$) {
					case 'Rotate':
						var angle = t.a;
						return $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$rotate(angle);
					case 'Scale':
						var x = t.a;
						var y = t.b;
						return A2($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$scale, x, y);
					case 'Translate':
						var x = t.a;
						var y = t.b;
						return A2($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$translate, x, y);
					default:
						var m11 = t.a.m11;
						var m12 = t.a.m12;
						var m21 = t.a.m21;
						var m22 = t.a.m22;
						var dx = t.a.dx;
						var dy = t.a.dy;
						return A6($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$transform, m11, m12, m21, m22, dx, dy);
				}
			},
			transforms));
};
var $joakin$elm_canvas$Canvas$Settings$Advanced$Translate = F2(
	function (a, b) {
		return {$: 'Translate', a: a, b: b};
	});
var $joakin$elm_canvas$Canvas$Settings$Advanced$translate = $joakin$elm_canvas$Canvas$Settings$Advanced$Translate;
var $author$project$Lib$Render$Render$renderSprite = F5(
	function (gd, ls, p, _v0, name) {
		var w = _v0.a;
		var h = _v0.b;
		var dst = gd.sprites;
		var _v1 = A2($author$project$Lib$Resources$Base$igetSprite, name, dst);
		if (_v1.$ === 'Just') {
			var t = _v1.a;
			var text_dim = $joakin$elm_canvas$Canvas$Texture$dimensions(t);
			var text_height = text_dim.height;
			var text_width = text_dim.width;
			var rw = A2($author$project$Lib$Coordinate$Coordinates$widthToReal, gd, w);
			var width_s = rw / text_width;
			var rh = A2($author$project$Lib$Coordinate$Coordinates$heightToReal, gd, h);
			var height_s = rh / text_height;
			var _v2 = A2($author$project$Lib$Render$Render$transPoint, gd, p);
			var newx = _v2.a;
			var newy = _v2.b;
			return ((w > 0) && (h > 0)) ? A3(
				$joakin$elm_canvas$Canvas$texture,
				A2(
					$elm$core$List$cons,
					$joakin$elm_canvas$Canvas$Settings$Advanced$transform(
						_List_fromArray(
							[
								A2($joakin$elm_canvas$Canvas$Settings$Advanced$translate, newx, newy),
								A2($joakin$elm_canvas$Canvas$Settings$Advanced$scale, width_s, height_s)
							])),
					ls),
				_Utils_Tuple2(0, 0),
				t) : (((w > 0) && (h <= 0)) ? A3(
				$joakin$elm_canvas$Canvas$texture,
				A2(
					$elm$core$List$cons,
					$joakin$elm_canvas$Canvas$Settings$Advanced$transform(
						_List_fromArray(
							[
								A2($joakin$elm_canvas$Canvas$Settings$Advanced$translate, newx, newy),
								A2($joakin$elm_canvas$Canvas$Settings$Advanced$scale, width_s, width_s)
							])),
					ls),
				_Utils_Tuple2(0, 0),
				t) : (((w <= 0) && (h > 0)) ? A3(
				$joakin$elm_canvas$Canvas$texture,
				A2(
					$elm$core$List$cons,
					$joakin$elm_canvas$Canvas$Settings$Advanced$transform(
						_List_fromArray(
							[
								A2($joakin$elm_canvas$Canvas$Settings$Advanced$translate, newx, newy),
								A2($joakin$elm_canvas$Canvas$Settings$Advanced$scale, height_s, height_s)
							])),
					ls),
				_Utils_Tuple2(0, 0),
				t) : A3(
				$joakin$elm_canvas$Canvas$texture,
				ls,
				_Utils_Tuple2(newx, newy),
				t)));
		} else {
			return A3(
				$joakin$elm_canvas$Canvas$text,
				_List_Nil,
				A2($author$project$Lib$Render$Render$transPoint, gd, p),
				'Wrong Sprite');
		}
	});
var $joakin$elm_canvas$Canvas$Settings$Text$Start = {$: 'Start'};
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$textAlign = function (align) {
	return A2(
		$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$field,
		'textAlign',
		$elm$json$Json$Encode$string(align));
};
var $joakin$elm_canvas$Canvas$Settings$Text$textAlignToString = function (alignment) {
	switch (alignment.$) {
		case 'Left':
			return 'left';
		case 'Right':
			return 'right';
		case 'Center':
			return 'center';
		case 'Start':
			return 'start';
		default:
			return 'end';
	}
};
var $joakin$elm_canvas$Canvas$Settings$Text$align = function (alignment) {
	return $joakin$elm_canvas$Canvas$Internal$Canvas$SettingCommand(
		$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$textAlign(
			$joakin$elm_canvas$Canvas$Settings$Text$textAlignToString(alignment)));
};
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$font = function (f) {
	return A2(
		$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$field,
		'font',
		$elm$json$Json$Encode$string(f));
};
var $joakin$elm_canvas$Canvas$Settings$Text$font = function (_v0) {
	var size = _v0.size;
	var family = _v0.family;
	return $joakin$elm_canvas$Canvas$Internal$Canvas$SettingCommand(
		$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$font(
			$elm$core$String$fromInt(size) + ('px ' + family)));
};
var $author$project$Lib$Render$Render$renderText = F5(
	function (gd, size, s, ft, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		var rx = A2($author$project$Lib$Coordinate$Coordinates$heightToReal, gd, size);
		var _v1 = A2(
			$author$project$Lib$Coordinate$Coordinates$posToReal,
			gd,
			_Utils_Tuple2(x, y));
		var dsx = _v1.a;
		var dsy = _v1.b;
		return A3(
			$joakin$elm_canvas$Canvas$text,
			_List_fromArray(
				[
					$joakin$elm_canvas$Canvas$Settings$Text$font(
					{
						family: ft,
						size: $elm$core$Basics$floor(rx)
					}),
					$joakin$elm_canvas$Canvas$Settings$Text$align($joakin$elm_canvas$Canvas$Settings$Text$Start)
				]),
			_Utils_Tuple2(dsx, (dsy + rx) - 1),
			s);
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$Display$view = F3(
	function (_v0, ggd, gd) {
		var d = _v0.a;
		var t = _v0.b;
		return _List_fromArray(
			[
				_Utils_Tuple2(
				A2(
					$joakin$elm_canvas$Canvas$group,
					_List_Nil,
					_List_fromArray(
						[
							A5(
							$author$project$Lib$Render$Render$renderSprite,
							gd,
							_List_fromArray(
								[
									$joakin$elm_canvas$Canvas$Settings$Advanced$alpha(
									_Utils_eq(ggd.selectobj, d.uid) ? 1 : 0.5)
								]),
							A2($author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera, d.position, ggd),
							_Utils_Tuple2(d.simplecheck.width, d.simplecheck.height),
							'background'),
							A5(
							$author$project$Lib$Render$Render$renderText,
							gd,
							20,
							A2($author$project$Lib$CoreEngine$GameComponents$Player$Display$getStateNumber, t, d),
							'sans-serif',
							A2($author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera, d.position, ggd))
						])),
				0)
			]);
	});
var $author$project$Lib$CoreEngine$GameComponents$Player$Export$gameComponent = {data: $author$project$Lib$CoreEngine$GameComponents$Player$Model$initData, init: $author$project$Lib$CoreEngine$GameComponents$Player$Model$initModel, name: 'player', update: $author$project$Lib$CoreEngine$GameComponents$Player$Model$updateModel, view: $author$project$Lib$CoreEngine$GameComponents$Player$Display$view};
var $author$project$Lib$CoreEngine$GameLayer$Export$nullData = {actors: $elm$core$Array$empty, chartlets: _List_Nil, ignoreInput: false, lastuseEnergyTime: 0, player: $author$project$Lib$CoreEngine$GameComponents$Player$Export$gameComponent};
var $author$project$Lib$CoreEngine$GameLayer$Global$ctTod = function (ldt) {
	if (ldt.$ === 'GameData') {
		var x = ldt.a;
		return x;
	} else {
		return $author$project$Lib$CoreEngine$GameLayer$Export$nullData;
	}
};
var $author$project$Lib$CoreEngine$LayerSettings$GameData = function (a) {
	return {$: 'GameData', a: a};
};
var $author$project$Lib$CoreEngine$GameLayer$Global$dToCT = function (data) {
	return $author$project$Lib$CoreEngine$LayerSettings$GameData(data);
};
var $author$project$Lib$CoreEngine$GameLayer$Global$getLayerCT = function (layer) {
	var view = F3(
		function (_v3, cd, gd) {
			var ldt = _v3.a;
			var t = _v3.b;
			return A3(
				layer.view,
				_Utils_Tuple2(
					$author$project$Lib$CoreEngine$GameLayer$Global$ctTod(ldt),
					t),
				cd,
				gd);
		});
	var update = F5(
		function (m, gd, lm, _v2, cd) {
			var ldt = _v2.a;
			var t = _v2.b;
			var _v0 = A5(
				layer.update,
				m,
				gd,
				lm,
				_Utils_Tuple2(
					$author$project$Lib$CoreEngine$GameLayer$Global$ctTod(ldt),
					t),
				cd);
			var _v1 = _v0.a;
			var rldt = _v1.a;
			var rcd = _v1.b;
			var ltm = _v1.c;
			var newgd = _v0.b;
			return _Utils_Tuple2(
				_Utils_Tuple3(
					$author$project$Lib$CoreEngine$GameLayer$Global$dToCT(rldt),
					rcd,
					ltm),
				newgd);
		});
	var init = F3(
		function (t, lm, cd) {
			return $author$project$Lib$CoreEngine$GameLayer$Global$dToCT(
				A3(layer.init, t, lm, cd));
		});
	return A4(
		$author$project$Lib$Layer$Base$Layer,
		$author$project$Lib$CoreEngine$GameLayer$Global$dToCT(layer.data),
		init,
		update,
		view);
};
var $author$project$Lib$CoreEngine$BackgroundLayer$Model$initModel = F3(
	function (_v0, lm, _v1) {
		if (lm.$ === 'LayerCTMsg') {
			var f = lm.a;
			return {render: f.timeseries};
		} else {
			return {
				render: F3(
					function (_v3, _v4, _v5) {
						return A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil);
					})
			};
		}
	});
var $author$project$Lib$CoreEngine$BackgroundLayer$Model$updateModel = F5(
	function (_v0, gd, _v1, _v2, ggd) {
		var model = _v2.a;
		return _Utils_Tuple2(
			_Utils_Tuple3(model, ggd, _List_Nil),
			gd);
	});
var $author$project$Lib$CoreEngine$BackgroundLayer$Display$view = F3(
	function (_v0, ggd, gd) {
		var model = _v0.a;
		var t = _v0.b;
		return A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			_List_fromArray(
				[
					A3(model.render, t, ggd, gd)
				]));
	});
var $author$project$Lib$CoreEngine$BackgroundLayer$Export$layer = {data: $author$project$Lib$CoreEngine$BackgroundLayer$Export$nullData, init: $author$project$Lib$CoreEngine$BackgroundLayer$Model$initModel, update: $author$project$Lib$CoreEngine$BackgroundLayer$Model$updateModel, view: $author$project$Lib$CoreEngine$BackgroundLayer$Display$view};
var $author$project$Lib$Component$Base$ComponentLStringMsg = function (a) {
	return {$: 'ComponentLStringMsg', a: a};
};
var $author$project$Lib$Component$Base$NullComponentMsg = {$: 'NullComponentMsg'};
var $elm$core$Elm$JsArray$appendN = _JsArray_appendN;
var $elm$core$Elm$JsArray$slice = _JsArray_slice;
var $elm$core$Array$appendHelpBuilder = F2(
	function (tail, builder) {
		var tailLen = $elm$core$Elm$JsArray$length(tail);
		var notAppended = ($elm$core$Array$branchFactor - $elm$core$Elm$JsArray$length(builder.tail)) - tailLen;
		var appended = A3($elm$core$Elm$JsArray$appendN, $elm$core$Array$branchFactor, builder.tail, tail);
		return (notAppended < 0) ? {
			nodeList: A2(
				$elm$core$List$cons,
				$elm$core$Array$Leaf(appended),
				builder.nodeList),
			nodeListSize: builder.nodeListSize + 1,
			tail: A3($elm$core$Elm$JsArray$slice, notAppended, tailLen, tail)
		} : ((!notAppended) ? {
			nodeList: A2(
				$elm$core$List$cons,
				$elm$core$Array$Leaf(appended),
				builder.nodeList),
			nodeListSize: builder.nodeListSize + 1,
			tail: $elm$core$Elm$JsArray$empty
		} : {nodeList: builder.nodeList, nodeListSize: builder.nodeListSize, tail: appended});
	});
var $elm$core$Elm$JsArray$push = _JsArray_push;
var $elm$core$Elm$JsArray$singleton = _JsArray_singleton;
var $elm$core$Elm$JsArray$unsafeSet = _JsArray_unsafeSet;
var $elm$core$Array$insertTailInTree = F4(
	function (shift, index, tail, tree) {
		var pos = $elm$core$Array$bitMask & (index >>> shift);
		if (_Utils_cmp(
			pos,
			$elm$core$Elm$JsArray$length(tree)) > -1) {
			if (shift === 5) {
				return A2(
					$elm$core$Elm$JsArray$push,
					$elm$core$Array$Leaf(tail),
					tree);
			} else {
				var newSub = $elm$core$Array$SubTree(
					A4($elm$core$Array$insertTailInTree, shift - $elm$core$Array$shiftStep, index, tail, $elm$core$Elm$JsArray$empty));
				return A2($elm$core$Elm$JsArray$push, newSub, tree);
			}
		} else {
			var value = A2($elm$core$Elm$JsArray$unsafeGet, pos, tree);
			if (value.$ === 'SubTree') {
				var subTree = value.a;
				var newSub = $elm$core$Array$SubTree(
					A4($elm$core$Array$insertTailInTree, shift - $elm$core$Array$shiftStep, index, tail, subTree));
				return A3($elm$core$Elm$JsArray$unsafeSet, pos, newSub, tree);
			} else {
				var newSub = $elm$core$Array$SubTree(
					A4(
						$elm$core$Array$insertTailInTree,
						shift - $elm$core$Array$shiftStep,
						index,
						tail,
						$elm$core$Elm$JsArray$singleton(value)));
				return A3($elm$core$Elm$JsArray$unsafeSet, pos, newSub, tree);
			}
		}
	});
var $elm$core$Array$unsafeReplaceTail = F2(
	function (newTail, _v0) {
		var len = _v0.a;
		var startShift = _v0.b;
		var tree = _v0.c;
		var tail = _v0.d;
		var originalTailLen = $elm$core$Elm$JsArray$length(tail);
		var newTailLen = $elm$core$Elm$JsArray$length(newTail);
		var newArrayLen = len + (newTailLen - originalTailLen);
		if (_Utils_eq(newTailLen, $elm$core$Array$branchFactor)) {
			var overflow = _Utils_cmp(newArrayLen >>> $elm$core$Array$shiftStep, 1 << startShift) > 0;
			if (overflow) {
				var newShift = startShift + $elm$core$Array$shiftStep;
				var newTree = A4(
					$elm$core$Array$insertTailInTree,
					newShift,
					len,
					newTail,
					$elm$core$Elm$JsArray$singleton(
						$elm$core$Array$SubTree(tree)));
				return A4($elm$core$Array$Array_elm_builtin, newArrayLen, newShift, newTree, $elm$core$Elm$JsArray$empty);
			} else {
				return A4(
					$elm$core$Array$Array_elm_builtin,
					newArrayLen,
					startShift,
					A4($elm$core$Array$insertTailInTree, startShift, len, newTail, tree),
					$elm$core$Elm$JsArray$empty);
			}
		} else {
			return A4($elm$core$Array$Array_elm_builtin, newArrayLen, startShift, tree, newTail);
		}
	});
var $elm$core$Array$appendHelpTree = F2(
	function (toAppend, array) {
		var len = array.a;
		var tree = array.c;
		var tail = array.d;
		var itemsToAppend = $elm$core$Elm$JsArray$length(toAppend);
		var notAppended = ($elm$core$Array$branchFactor - $elm$core$Elm$JsArray$length(tail)) - itemsToAppend;
		var appended = A3($elm$core$Elm$JsArray$appendN, $elm$core$Array$branchFactor, tail, toAppend);
		var newArray = A2($elm$core$Array$unsafeReplaceTail, appended, array);
		if (notAppended < 0) {
			var nextTail = A3($elm$core$Elm$JsArray$slice, notAppended, itemsToAppend, toAppend);
			return A2($elm$core$Array$unsafeReplaceTail, nextTail, newArray);
		} else {
			return newArray;
		}
	});
var $elm$core$Elm$JsArray$foldl = _JsArray_foldl;
var $elm$core$Array$builderFromArray = function (_v0) {
	var len = _v0.a;
	var tree = _v0.c;
	var tail = _v0.d;
	var helper = F2(
		function (node, acc) {
			if (node.$ === 'SubTree') {
				var subTree = node.a;
				return A3($elm$core$Elm$JsArray$foldl, helper, acc, subTree);
			} else {
				return A2($elm$core$List$cons, node, acc);
			}
		});
	return {
		nodeList: A3($elm$core$Elm$JsArray$foldl, helper, _List_Nil, tree),
		nodeListSize: (len / $elm$core$Array$branchFactor) | 0,
		tail: tail
	};
};
var $elm$core$Array$append = F2(
	function (a, _v0) {
		var aTail = a.d;
		var bLen = _v0.a;
		var bTree = _v0.c;
		var bTail = _v0.d;
		if (_Utils_cmp(bLen, $elm$core$Array$branchFactor * 4) < 1) {
			var foldHelper = F2(
				function (node, array) {
					if (node.$ === 'SubTree') {
						var tree = node.a;
						return A3($elm$core$Elm$JsArray$foldl, foldHelper, array, tree);
					} else {
						var leaf = node.a;
						return A2($elm$core$Array$appendHelpTree, leaf, array);
					}
				});
			return A2(
				$elm$core$Array$appendHelpTree,
				bTail,
				A3($elm$core$Elm$JsArray$foldl, foldHelper, a, bTree));
		} else {
			var foldHelper = F2(
				function (node, builder) {
					if (node.$ === 'SubTree') {
						var tree = node.a;
						return A3($elm$core$Elm$JsArray$foldl, foldHelper, builder, tree);
					} else {
						var leaf = node.a;
						return A2($elm$core$Array$appendHelpBuilder, leaf, builder);
					}
				});
			return A2(
				$elm$core$Array$builderToArray,
				true,
				A2(
					$elm$core$Array$appendHelpBuilder,
					bTail,
					A3(
						$elm$core$Elm$JsArray$foldl,
						foldHelper,
						$elm$core$Array$builderFromArray(a),
						bTree)));
		}
	});
var $elm$core$Array$fromListHelp = F3(
	function (list, nodeList, nodeListSize) {
		fromListHelp:
		while (true) {
			var _v0 = A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, list);
			var jsArray = _v0.a;
			var remainingItems = _v0.b;
			if (_Utils_cmp(
				$elm$core$Elm$JsArray$length(jsArray),
				$elm$core$Array$branchFactor) < 0) {
				return A2(
					$elm$core$Array$builderToArray,
					true,
					{nodeList: nodeList, nodeListSize: nodeListSize, tail: jsArray});
			} else {
				var $temp$list = remainingItems,
					$temp$nodeList = A2(
					$elm$core$List$cons,
					$elm$core$Array$Leaf(jsArray),
					nodeList),
					$temp$nodeListSize = nodeListSize + 1;
				list = $temp$list;
				nodeList = $temp$nodeList;
				nodeListSize = $temp$nodeListSize;
				continue fromListHelp;
			}
		}
	});
var $elm$core$Array$fromList = function (list) {
	if (!list.b) {
		return $elm$core$Array$empty;
	} else {
		return A3($elm$core$Array$fromListHelp, list, _List_Nil, 0);
	}
};
var $author$project$Lib$Component$Base$CDBool = function (a) {
	return {$: 'CDBool', a: a};
};
var $author$project$Lib$Component$Base$CDString = function (a) {
	return {$: 'CDString', a: a};
};
var $author$project$Components$Console$Console$initModel = F2(
	function (_v0, _v1) {
		return $elm$core$Dict$fromList(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'input',
					$author$project$Lib$Component$Base$CDString('')),
					_Utils_Tuple2(
					'state',
					$author$project$Lib$Component$Base$CDBool(false))
				]));
	});
var $author$project$Lib$Component$Base$ComponentStringMsg = function (a) {
	return {$: 'ComponentStringMsg', a: a};
};
var $elm$core$String$append = _String_append;
var $elm$core$String$concat = function (strings) {
	return A2($elm$core$String$join, '', strings);
};
var $author$project$Lib$DefinedTypes$Parser$dgetString = F2(
	function (f, s) {
		var other = '';
		var _v0 = A2($elm$core$Dict$get, s, f);
		if ((_v0.$ === 'Just') && (_v0.a.$ === 'CDString')) {
			var x = _v0.a.a;
			return x;
		} else {
			return other;
		}
	});
var $author$project$Lib$DefinedTypes$Parser$dgetbool = F2(
	function (f, s) {
		var other = false;
		var _v0 = A2($elm$core$Dict$get, s, f);
		if ((_v0.$ === 'Just') && (_v0.a.$ === 'CDBool')) {
			var x = _v0.a.a;
			return x;
		} else {
			return other;
		}
	});
var $elm$core$String$dropRight = F2(
	function (n, string) {
		return (n < 1) ? string : A3($elm$core$String$slice, 0, -n, string);
	});
var $author$project$Lib$DefinedTypes$Parser$dsetbool = F3(
	function (s, t, f) {
		return A3(
			$elm$core$Dict$update,
			s,
			function (_v0) {
				return $elm$core$Maybe$Just(
					$author$project$Lib$Component$Base$CDBool(t));
			},
			f);
	});
var $author$project$Lib$DefinedTypes$Parser$dsetstring = F3(
	function (s, t, f) {
		return A3(
			$elm$core$Dict$update,
			s,
			function (_v0) {
				return $elm$core$Maybe$Just(
					$author$project$Lib$Component$Base$CDString(t));
			},
			f);
	});
var $elm$core$String$cons = _String_cons;
var $elm$core$String$fromChar = function (_char) {
	return A2($elm$core$String$cons, _char, '');
};
var $elm$core$Char$fromCode = _Char_fromCode;
var $elm$core$Char$toLower = _Char_toLower;
var $elm$core$String$toUpper = _String_toUpper;
var $author$project$Components$Console$Console$updateModel = F4(
	function (msg, _v0, gd, _v1) {
		var d = _v1.a;
		var state = A2($author$project$Lib$DefinedTypes$Parser$dgetbool, d, 'state');
		var command = A2($author$project$Lib$DefinedTypes$Parser$dgetString, d, 'input');
		if (msg.$ === 'KeyDown') {
			switch (msg.a) {
				case 192:
					return state ? _Utils_Tuple3(
						A3($author$project$Lib$DefinedTypes$Parser$dsetbool, 'state', !state, d),
						$author$project$Lib$Component$Base$ComponentStringMsg('startGameInput'),
						gd) : _Utils_Tuple3(
						A3($author$project$Lib$DefinedTypes$Parser$dsetbool, 'state', !state, d),
						$author$project$Lib$Component$Base$ComponentStringMsg('stopGameInput'),
						gd);
				case 8:
					return state ? _Utils_Tuple3(
						A3(
							$author$project$Lib$DefinedTypes$Parser$dsetstring,
							'input',
							A2($elm$core$String$dropRight, 1, command),
							d),
						$author$project$Lib$Component$Base$NullComponentMsg,
						gd) : _Utils_Tuple3(d, $author$project$Lib$Component$Base$NullComponentMsg, gd);
				case 13:
					var scenename = A2($elm$core$String$dropLeft, 5, command);
					var realname = A2(
						$elm$core$String$left,
						1,
						$elm$core$String$toUpper(scenename));
					var loadscene = A2($elm$core$String$left, 5, command) === 'load ';
					var ld = A2($elm$core$String$dropLeft, 1, scenename);
					var kk = $elm$core$String$concat(
						_List_fromArray(
							[realname, ld]));
					return state ? _Utils_Tuple3(
						A3(
							$author$project$Lib$DefinedTypes$Parser$dsetbool,
							'state',
							false,
							A3($author$project$Lib$DefinedTypes$Parser$dsetstring, 'input', '', d)),
						loadscene ? $author$project$Lib$Component$Base$ComponentLStringMsg(
							_List_fromArray(
								['nextscene', kk])) : $author$project$Lib$Component$Base$ComponentStringMsg('startGameInput'),
						gd) : _Utils_Tuple3(d, $author$project$Lib$Component$Base$NullComponentMsg, gd);
				default:
					var x = msg.a;
					return state ? _Utils_Tuple3(
						A3(
							$author$project$Lib$DefinedTypes$Parser$dsetstring,
							'input',
							A2(
								$elm$core$String$append,
								command,
								$elm$core$String$fromChar(
									$elm$core$Char$toLower(
										$elm$core$Char$fromCode(x)))),
							d),
						$author$project$Lib$Component$Base$NullComponentMsg,
						gd) : _Utils_Tuple3(d, $author$project$Lib$Component$Base$NullComponentMsg, gd);
			}
		} else {
			return _Utils_Tuple3(d, $author$project$Lib$Component$Base$NullComponentMsg, gd);
		}
	});
var $joakin$elm_canvas$Canvas$Internal$Canvas$Rect = F3(
	function (a, b, c) {
		return {$: 'Rect', a: a, b: b, c: c};
	});
var $joakin$elm_canvas$Canvas$rect = F3(
	function (pos, width, height) {
		return A3($joakin$elm_canvas$Canvas$Internal$Canvas$Rect, pos, width, height);
	});
var $joakin$elm_canvas$Canvas$Internal$Canvas$DrawableShapes = function (a) {
	return {$: 'DrawableShapes', a: a};
};
var $joakin$elm_canvas$Canvas$shapes = F2(
	function (settings, ss) {
		return A2(
			$joakin$elm_canvas$Canvas$addSettingsToRenderable,
			settings,
			$joakin$elm_canvas$Canvas$Internal$Canvas$Renderable(
				{
					commands: _List_Nil,
					drawOp: $joakin$elm_canvas$Canvas$Internal$Canvas$NotSpecified,
					drawable: $joakin$elm_canvas$Canvas$Internal$Canvas$DrawableShapes(ss)
				}));
	});
var $author$project$Components$Console$Console$viewModel = F2(
	function (_v0, gd) {
		var d = _v0.a;
		var t = _v0.b;
		var state = A2($author$project$Lib$DefinedTypes$Parser$dgetbool, d, 'state');
		var command = A2($author$project$Lib$DefinedTypes$Parser$dgetString, d, 'input');
		return state ? A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			_List_fromArray(
				[
					A2(
					$joakin$elm_canvas$Canvas$shapes,
					_List_fromArray(
						[
							$joakin$elm_canvas$Canvas$Settings$Advanced$alpha(0.1)
						]),
					_List_fromArray(
						[
							A3(
							$joakin$elm_canvas$Canvas$rect,
							A2(
								$author$project$Lib$Coordinate$Coordinates$posToReal,
								gd,
								_Utils_Tuple2(20, 970)),
							A2($author$project$Lib$Coordinate$Coordinates$widthToReal, gd, 1850),
							A2($author$project$Lib$Coordinate$Coordinates$heightToReal, gd, 40))
						])),
					A5(
					$author$project$Lib$Render$Render$renderText,
					gd,
					30,
					'> ' + (command + '_'),
					'sans-seif',
					_Utils_Tuple2(30, 975))
				])) : A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil);
	});
var $author$project$Components$Console$Export$component = {
	data: A2($author$project$Components$Console$Console$initModel, 0, $author$project$Lib$Component$Base$NullComponentMsg),
	init: $author$project$Components$Console$Console$initModel,
	name: 'Console',
	query: F2(
		function (_v0, _v1) {
			return $author$project$Lib$Component$Base$NullComponentMsg;
		}),
	update: $author$project$Components$Console$Console$updateModel,
	view: $author$project$Components$Console$Console$viewModel
};
var $author$project$Components$Console$Export$initComponent = F2(
	function (t, ct) {
		return _Utils_update(
			$author$project$Components$Console$Export$component,
			{
				data: A2($author$project$Components$Console$Export$component.init, t, ct)
			});
	});
var $author$project$Lib$Component$Base$CDDict = function (a) {
	return {$: 'CDDict', a: a};
};
var $author$project$Lib$Component$Base$CDLComponent = function (a) {
	return {$: 'CDLComponent', a: a};
};
var $author$project$Lib$Component$Base$CDInt = function (a) {
	return {$: 'CDInt', a: a};
};
var $author$project$Components$Menu$Map$Map$initMap = F2(
	function (_v0, _v1) {
		return $elm$core$Dict$fromList(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'show',
					$author$project$Lib$Component$Base$CDBool(false)),
					_Utils_Tuple2(
					'posX',
					$author$project$Lib$Component$Base$CDInt(900)),
					_Utils_Tuple2(
					'posY',
					$author$project$Lib$Component$Base$CDInt(400)),
					_Utils_Tuple2(
					'radius',
					$author$project$Lib$Component$Base$CDInt(30)),
					_Utils_Tuple2(
					'Data',
					$author$project$Lib$Component$Base$CDDict($elm$core$Dict$empty))
				]));
	});
var $author$project$Lib$Component$Base$ComponentLSStringMsg = F2(
	function (a, b) {
		return {$: 'ComponentLSStringMsg', a: a, b: b};
	});
var $author$project$Lib$DefinedTypes$Parser$dgetint = F2(
	function (f, s) {
		var other = 0;
		var _v0 = A2($elm$core$Dict$get, s, f);
		if ((_v0.$ === 'Just') && (_v0.a.$ === 'CDInt')) {
			var x = _v0.a.a;
			return x;
		} else {
			return other;
		}
	});
var $author$project$Lib$DefinedTypes$Parser$dsetDict = F3(
	function (s, dict, f) {
		return A3(
			$elm$core$Dict$update,
			s,
			function (_v0) {
				return $elm$core$Maybe$Just(
					$author$project$Lib$Component$Base$CDDict(dict));
			},
			f);
	});
var $author$project$Components$Menu$Map$Map$updateMap = F4(
	function (mainMsg, comMsg, globalData, _v0) {
		var model = _v0.a;
		var t = _v0.b;
		var reverseShowStatus = A2($author$project$Lib$DefinedTypes$Parser$dgetbool, model, 'show') ? false : true;
		var radius = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'radius');
		var posY = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'posY');
		var posX = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'posX');
		if ((mainMsg.$ === 'MouseDown') && (!mainMsg.a)) {
			var _v2 = mainMsg.b;
			var x = _v2.a;
			var y = _v2.b;
			return A4(
				$author$project$Lib$Coordinate$Coordinates$judgeMouse,
				globalData,
				_Utils_Tuple2(x, y),
				_Utils_Tuple2(posX - radius, posY - radius),
				_Utils_Tuple2(2 * radius, 2 * radius)) ? _Utils_Tuple3(
				A3($author$project$Lib$DefinedTypes$Parser$dsetbool, 'show', reverseShowStatus, model),
				reverseShowStatus ? A2(
					$author$project$Lib$Component$Base$ComponentLSStringMsg,
					'OnShow',
					_List_fromArray(
						['Map'])) : A2(
					$author$project$Lib$Component$Base$ComponentLSStringMsg,
					'OnHide',
					_List_fromArray(
						['Map'])),
				globalData) : _Utils_Tuple3(model, $author$project$Lib$Component$Base$NullComponentMsg, globalData);
		} else {
			switch (comMsg.$) {
				case 'ComponentStringMsg':
					var demand = comMsg.a;
					switch (demand) {
						case 'Display:HIDE':
							return _Utils_Tuple3(
								A3($author$project$Lib$DefinedTypes$Parser$dsetbool, 'show', false, model),
								$author$project$Lib$Component$Base$NullComponentMsg,
								globalData);
						case 'Display:SHOW':
							return _Utils_Tuple3(
								A3($author$project$Lib$DefinedTypes$Parser$dsetbool, 'show', true, model),
								$author$project$Lib$Component$Base$NullComponentMsg,
								globalData);
						default:
							return _Utils_Tuple3(model, $author$project$Lib$Component$Base$NullComponentMsg, globalData);
					}
				case 'ComponentDictMsg':
					var dict = comMsg.a;
					return _Utils_Tuple3(
						A3($author$project$Lib$DefinedTypes$Parser$dsetDict, 'Data', dict, model),
						$author$project$Lib$Component$Base$NullComponentMsg,
						globalData);
				default:
					return _Utils_Tuple3(model, $author$project$Lib$Component$Base$NullComponentMsg, globalData);
			}
		}
	});
var $joakin$elm_canvas$Canvas$Internal$Canvas$Circle = F2(
	function (a, b) {
		return {$: 'Circle', a: a, b: b};
	});
var $joakin$elm_canvas$Canvas$circle = F2(
	function (pos, radius) {
		return A2($joakin$elm_canvas$Canvas$Internal$Canvas$Circle, pos, radius);
	});
var $author$project$Lib$DefinedTypes$Parser$dgetDict = F2(
	function (f, s) {
		var other = $elm$core$Dict$empty;
		var _v0 = A2($elm$core$Dict$get, s, f);
		if ((_v0.$ === 'Just') && (_v0.a.$ === 'CDDict')) {
			var x = _v0.a.a;
			return x;
		} else {
			return other;
		}
	});
var $author$project$Lib$DefinedTypes$Parser$dgetfloat = F2(
	function (f, s) {
		var other = 0;
		var _v0 = A2($elm$core$Dict$get, s, f);
		if ((_v0.$ === 'Just') && (_v0.a.$ === 'CDFloat')) {
			var x = _v0.a.a;
			return x;
		} else {
			return other;
		}
	});
var $avh4$elm_color$Color$RgbaSpace = F4(
	function (a, b, c, d) {
		return {$: 'RgbaSpace', a: a, b: b, c: c, d: d};
	});
var $avh4$elm_color$Color$red = A4($avh4$elm_color$Color$RgbaSpace, 204 / 255, 0 / 255, 0 / 255, 1.0);
var $joakin$elm_canvas$Canvas$Internal$Canvas$SettingDrawOp = function (a) {
	return {$: 'SettingDrawOp', a: a};
};
var $joakin$elm_canvas$Canvas$Settings$stroke = function (color) {
	return $joakin$elm_canvas$Canvas$Internal$Canvas$SettingDrawOp(
		$joakin$elm_canvas$Canvas$Internal$Canvas$Stroke(color));
};
var $author$project$Components$Menu$Map$Map$viewMap = F2(
	function (_v0, globalData) {
		var model = _v0.a;
		var showStatus = A2($author$project$Lib$DefinedTypes$Parser$dgetbool, model, 'show');
		var radius = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'radius');
		var posY = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'posY');
		var posX = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'posX');
		return A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			A2(
				$elm$core$List$append,
				_List_fromArray(
					[
						A2(
						$joakin$elm_canvas$Canvas$shapes,
						_List_fromArray(
							[
								$joakin$elm_canvas$Canvas$Settings$stroke($avh4$elm_color$Color$red)
							]),
						_List_fromArray(
							[
								A2(
								$joakin$elm_canvas$Canvas$circle,
								A2(
									$author$project$Lib$Coordinate$Coordinates$posToReal,
									globalData,
									_Utils_Tuple2(posX, posY)),
								A2($author$project$Lib$Coordinate$Coordinates$widthToReal, globalData, radius))
							])),
						A5(
						$author$project$Lib$Render$Render$renderText,
						globalData,
						50,
						'M',
						'sans-serif',
						_Utils_Tuple2(posX - 20, posY - 30))
					]),
				function () {
					if (showStatus) {
						var data = A2($author$project$Lib$DefinedTypes$Parser$dgetDict, model, 'Data');
						var mapHeight = A2($author$project$Lib$DefinedTypes$Parser$dgetfloat, data, 'MapHeight');
						var mapWidth = A2($author$project$Lib$DefinedTypes$Parser$dgetfloat, data, 'MapWidth');
						var charPosY = A2($author$project$Lib$DefinedTypes$Parser$dgetfloat, data, 'CharPositionY');
						var charPosX = A2($author$project$Lib$DefinedTypes$Parser$dgetfloat, data, 'CharPositionX');
						return _List_fromArray(
							[
								A5(
								$author$project$Lib$Render$Render$renderText,
								globalData,
								30,
								'Map',
								'sans-serif',
								_Utils_Tuple2(500, 500)),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								globalData,
								_List_Nil,
								_Utils_Tuple2(500, 550),
								_Utils_Tuple2(400, 200),
								'background'),
								A2(
								$joakin$elm_canvas$Canvas$shapes,
								_List_Nil,
								function () {
									var _v1 = _Utils_Tuple2(
										$elm$core$Basics$floor(mapWidth),
										$elm$core$Basics$floor(mapHeight));
									if (!_v1.a) {
										return _List_Nil;
									} else {
										if (!_v1.b) {
											return _List_Nil;
										} else {
											return _List_fromArray(
												[
													A2(
													$joakin$elm_canvas$Canvas$circle,
													A2(
														$author$project$Lib$Coordinate$Coordinates$posToReal,
														globalData,
														_Utils_Tuple2(
															$elm$core$Basics$floor(500 + ((charPosX / mapWidth) * 400)),
															$elm$core$Basics$floor(550 + ((charPosY / mapHeight) * 200)))),
													A2($author$project$Lib$Coordinate$Coordinates$widthToReal, globalData, 5))
												]);
										}
									}
								}())
							]);
					} else {
						return _List_Nil;
					}
				}()));
	});
var $author$project$Components$Menu$Map$Export$component = {
	data: A2($author$project$Components$Menu$Map$Map$initMap, 0, $author$project$Lib$Component$Base$NullComponentMsg),
	init: $author$project$Components$Menu$Map$Map$initMap,
	name: 'Map',
	query: F2(
		function (_v0, _v1) {
			return $author$project$Lib$Component$Base$NullComponentMsg;
		}),
	update: $author$project$Components$Menu$Map$Map$updateMap,
	view: $author$project$Components$Menu$Map$Map$viewMap
};
var $author$project$Components$Menu$Map$Export$initComponent = F2(
	function (t, ct) {
		return _Utils_update(
			$author$project$Components$Menu$Map$Export$component,
			{
				data: A2($author$project$Components$Menu$Map$Export$component.init, t, ct)
			});
	});
var $author$project$Components$Menu$Settings$Audio$Audio$initMap = F2(
	function (_v0, comMsg) {
		if (comMsg.$ === 'ComponentStringMsg') {
			var demand = comMsg.a;
			switch (demand) {
				case 'AudioDown':
					return $elm$core$Dict$fromList(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'show',
								$author$project$Lib$Component$Base$CDBool(true)),
								_Utils_Tuple2(
								'posX',
								$author$project$Lib$Component$Base$CDInt(670)),
								_Utils_Tuple2(
								'posY',
								$author$project$Lib$Component$Base$CDInt(680)),
								_Utils_Tuple2(
								'Type',
								$author$project$Lib$Component$Base$CDString('Down')),
								_Utils_Tuple2(
								'radius',
								$author$project$Lib$Component$Base$CDInt(30))
							]));
				case 'AudioUp':
					return $elm$core$Dict$fromList(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'show',
								$author$project$Lib$Component$Base$CDBool(true)),
								_Utils_Tuple2(
								'posX',
								$author$project$Lib$Component$Base$CDInt(750)),
								_Utils_Tuple2(
								'posY',
								$author$project$Lib$Component$Base$CDInt(680)),
								_Utils_Tuple2(
								'Type',
								$author$project$Lib$Component$Base$CDString('Up')),
								_Utils_Tuple2(
								'radius',
								$author$project$Lib$Component$Base$CDInt(30))
							]));
				default:
					return $elm$core$Dict$fromList(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'show',
								$author$project$Lib$Component$Base$CDBool(true)),
								_Utils_Tuple2(
								'posX',
								$author$project$Lib$Component$Base$CDInt(670)),
								_Utils_Tuple2(
								'posY',
								$author$project$Lib$Component$Base$CDInt(680)),
								_Utils_Tuple2(
								'Type',
								$author$project$Lib$Component$Base$CDString('Unknown')),
								_Utils_Tuple2(
								'radius',
								$author$project$Lib$Component$Base$CDInt(30))
							]));
			}
		} else {
			return $elm$core$Dict$fromList(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'show',
						$author$project$Lib$Component$Base$CDBool(true)),
						_Utils_Tuple2(
						'posX',
						$author$project$Lib$Component$Base$CDInt(670)),
						_Utils_Tuple2(
						'posY',
						$author$project$Lib$Component$Base$CDInt(680)),
						_Utils_Tuple2(
						'Type',
						$author$project$Lib$Component$Base$CDString('Unknown')),
						_Utils_Tuple2(
						'radius',
						$author$project$Lib$Component$Base$CDInt(30))
					]));
		}
	});
var $author$project$Components$Menu$Settings$Audio$Audio$updateMap = F4(
	function (mainMsg, comMsg, globalData, _v0) {
		var model = _v0.a;
		var t = _v0.b;
		var radius = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'radius');
		var posY = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'posY');
		var posX = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'posX');
		var comType = A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, 'Type');
		if ((mainMsg.$ === 'MouseDown') && (!mainMsg.a)) {
			var _v2 = mainMsg.b;
			var x = _v2.a;
			var y = _v2.b;
			return A4(
				$author$project$Lib$Coordinate$Coordinates$judgeMouse,
				globalData,
				_Utils_Tuple2(x, y),
				_Utils_Tuple2(posX - radius, posY - radius),
				_Utils_Tuple2(2 * radius, 2 * radius)) ? _Utils_Tuple3(
				model,
				$author$project$Lib$Component$Base$NullComponentMsg,
				function () {
					switch (comType) {
						case 'Down':
							return _Utils_update(
								globalData,
								{
									audioVolume: (globalData.audioVolume >= 0.1) ? (globalData.audioVolume - 0.1) : globalData.audioVolume
								});
						case 'Up':
							return _Utils_update(
								globalData,
								{
									audioVolume: (globalData.audioVolume <= 0.9) ? (globalData.audioVolume + 0.1) : globalData.audioVolume
								});
						default:
							return globalData;
					}
				}()) : _Utils_Tuple3(model, $author$project$Lib$Component$Base$NullComponentMsg, globalData);
		} else {
			if (comMsg.$ === 'ComponentStringMsg') {
				var demand = comMsg.a;
				switch (demand) {
					case 'Display:HIDE':
						return _Utils_Tuple3(
							A3($author$project$Lib$DefinedTypes$Parser$dsetbool, 'show', false, model),
							$author$project$Lib$Component$Base$NullComponentMsg,
							globalData);
					case 'Display:SHOW':
						return _Utils_Tuple3(
							A3($author$project$Lib$DefinedTypes$Parser$dsetbool, 'show', true, model),
							$author$project$Lib$Component$Base$NullComponentMsg,
							globalData);
					default:
						return _Utils_Tuple3(model, $author$project$Lib$Component$Base$NullComponentMsg, globalData);
				}
			} else {
				return _Utils_Tuple3(model, $author$project$Lib$Component$Base$NullComponentMsg, globalData);
			}
		}
	});
var $author$project$Components$Menu$Settings$Audio$Audio$viewMap = F2(
	function (_v0, globalData) {
		var model = _v0.a;
		var radius = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'radius');
		var posY = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'posY');
		var posX = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'posX');
		var comType = function () {
			var _v1 = A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, 'Type');
			switch (_v1) {
				case 'Down':
					return 'D';
				case 'Up':
					return 'U';
				default:
					return '';
			}
		}();
		return A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			_List_fromArray(
				[
					A2(
					$joakin$elm_canvas$Canvas$shapes,
					_List_fromArray(
						[
							$joakin$elm_canvas$Canvas$Settings$stroke($avh4$elm_color$Color$red)
						]),
					_List_fromArray(
						[
							A2(
							$joakin$elm_canvas$Canvas$circle,
							A2(
								$author$project$Lib$Coordinate$Coordinates$posToReal,
								globalData,
								_Utils_Tuple2(posX, posY)),
							A2($author$project$Lib$Coordinate$Coordinates$widthToReal, globalData, radius))
						])),
					A5(
					$author$project$Lib$Render$Render$renderText,
					globalData,
					50,
					comType,
					'sans-serif',
					_Utils_Tuple2(posX - 20, posY - 25))
				]));
	});
var $author$project$Components$Menu$Settings$Audio$Export$component = {
	data: A2($author$project$Components$Menu$Settings$Audio$Audio$initMap, 0, $author$project$Lib$Component$Base$NullComponentMsg),
	init: $author$project$Components$Menu$Settings$Audio$Audio$initMap,
	name: 'Map',
	query: F2(
		function (_v0, _v1) {
			return $author$project$Lib$Component$Base$NullComponentMsg;
		}),
	update: $author$project$Components$Menu$Settings$Audio$Audio$updateMap,
	view: $author$project$Components$Menu$Settings$Audio$Audio$viewMap
};
var $author$project$Components$Menu$Settings$Audio$Export$initComponent = F2(
	function (t, ct) {
		return _Utils_update(
			$author$project$Components$Menu$Settings$Audio$Export$component,
			{
				data: A2($author$project$Components$Menu$Settings$Audio$Export$component.init, t, ct)
			});
	});
var $author$project$Components$Menu$Settings$Settings$initSettings = F2(
	function (_v0, _v1) {
		return $elm$core$Dict$fromList(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'show',
					$author$project$Lib$Component$Base$CDBool(false)),
					_Utils_Tuple2(
					'posX',
					$author$project$Lib$Component$Base$CDInt(500)),
					_Utils_Tuple2(
					'posY',
					$author$project$Lib$Component$Base$CDInt(400)),
					_Utils_Tuple2(
					'radius',
					$author$project$Lib$Component$Base$CDInt(30)),
					_Utils_Tuple2(
					'Child',
					$author$project$Lib$Component$Base$CDLComponent(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'AudioDown',
								A2(
									$author$project$Components$Menu$Settings$Audio$Export$initComponent,
									0,
									$author$project$Lib$Component$Base$ComponentStringMsg('AudioDown'))),
								_Utils_Tuple2(
								'AudioUp',
								A2(
									$author$project$Components$Menu$Settings$Audio$Export$initComponent,
									0,
									$author$project$Lib$Component$Base$ComponentStringMsg('AudioUp')))
							])))
				]));
	});
var $author$project$Lib$DefinedTypes$Parser$dgetLComponent = F2(
	function (f, s) {
		var other = _List_Nil;
		var _v0 = A2($elm$core$Dict$get, s, f);
		if ((_v0.$ === 'Just') && (_v0.a.$ === 'CDLComponent')) {
			var x = _v0.a.a;
			return x;
		} else {
			return other;
		}
	});
var $author$project$Lib$DefinedTypes$Parser$dsetLComponent = F3(
	function (s, t, f) {
		return A3(
			$elm$core$Dict$update,
			s,
			function (_v0) {
				return $elm$core$Maybe$Just(
					$author$project$Lib$Component$Base$CDLComponent(t));
			},
			f);
	});
var $author$project$Components$Menu$Settings$Settings$updateSettings = F4(
	function (mainMsg, comMsg, globalData, _v0) {
		var model = _v0.a;
		var t = _v0.b;
		var showStatus = A2($author$project$Lib$DefinedTypes$Parser$dgetbool, model, 'show');
		var reverseShowStatus = A2($author$project$Lib$DefinedTypes$Parser$dgetbool, model, 'show') ? false : true;
		var radius = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'radius');
		var posY = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'posY');
		var posX = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'posX');
		var childComponentsList = A2($author$project$Lib$DefinedTypes$Parser$dgetLComponent, model, 'Child');
		var _v1 = showStatus ? A3(
			$elm$core$List$foldl,
			F2(
				function (_v2, _v3) {
					var comName = _v2.a;
					var comModel = _v2.b;
					var tmpComList = _v3.a;
					var tmpComMsgList = _v3.b;
					var tmpGData = _v3.c;
					var _v4 = A4(
						comModel.update,
						mainMsg,
						comMsg,
						tmpGData,
						_Utils_Tuple2(comModel.data, t));
					var tmpCom = _v4.a;
					var tmpComMsg = _v4.b;
					var gD = _v4.c;
					return _Utils_Tuple3(
						A2(
							$elm$core$List$append,
							tmpComList,
							_List_fromArray(
								[
									_Utils_Tuple2(
									comName,
									_Utils_update(
										comModel,
										{data: tmpCom}))
								])),
						A2(
							$elm$core$List$append,
							tmpComMsgList,
							_List_fromArray(
								[tmpComMsg])),
						gD);
				}),
			_Utils_Tuple3(_List_Nil, _List_Nil, globalData),
			childComponentsList) : _Utils_Tuple3(childComponentsList, _List_Nil, globalData);
		var tmpChildComponentsList = _v1.a;
		var tmpChildComponentsMsg = _v1.b;
		var newGlobalData = _v1.c;
		var newComMsg = A2(
			$elm$core$Maybe$withDefault,
			$author$project$Lib$Component$Base$NullComponentMsg,
			$elm$core$List$head(
				A2(
					$elm$core$List$filter,
					function (tmpMsg) {
						return _Utils_eq(tmpMsg, $author$project$Lib$Component$Base$NullComponentMsg) ? false : true;
					},
					tmpChildComponentsMsg)));
		if ((mainMsg.$ === 'MouseDown') && (!mainMsg.a)) {
			var _v6 = mainMsg.b;
			var x = _v6.a;
			var y = _v6.b;
			return A4(
				$author$project$Lib$Coordinate$Coordinates$judgeMouse,
				globalData,
				_Utils_Tuple2(x, y),
				_Utils_Tuple2(posX - radius, posY - radius),
				_Utils_Tuple2(2 * radius, 2 * radius)) ? _Utils_Tuple3(
				A3(
					$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
					'Child',
					tmpChildComponentsList,
					A3($author$project$Lib$DefinedTypes$Parser$dsetbool, 'show', reverseShowStatus, model)),
				reverseShowStatus ? A2(
					$author$project$Lib$Component$Base$ComponentLSStringMsg,
					'OnShow',
					_List_fromArray(
						['Settings'])) : A2(
					$author$project$Lib$Component$Base$ComponentLSStringMsg,
					'OnHide',
					_List_fromArray(
						['Settings'])),
				newGlobalData) : _Utils_Tuple3(
				A3($author$project$Lib$DefinedTypes$Parser$dsetLComponent, 'Child', tmpChildComponentsList, model),
				newComMsg,
				newGlobalData);
		} else {
			if (comMsg.$ === 'ComponentStringMsg') {
				var demand = comMsg.a;
				switch (demand) {
					case 'Display:HIDE':
						return _Utils_Tuple3(
							A3(
								$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
								'Child',
								tmpChildComponentsList,
								A3($author$project$Lib$DefinedTypes$Parser$dsetbool, 'show', false, model)),
							newComMsg,
							newGlobalData);
					case 'Display:SHOW':
						return _Utils_Tuple3(
							A3(
								$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
								'Child',
								tmpChildComponentsList,
								A3($author$project$Lib$DefinedTypes$Parser$dsetbool, 'show', true, model)),
							newComMsg,
							newGlobalData);
					default:
						return _Utils_Tuple3(
							A3($author$project$Lib$DefinedTypes$Parser$dsetLComponent, 'Child', tmpChildComponentsList, model),
							newComMsg,
							newGlobalData);
				}
			} else {
				return _Utils_Tuple3(
					A3($author$project$Lib$DefinedTypes$Parser$dsetLComponent, 'Child', tmpChildComponentsList, model),
					newComMsg,
					newGlobalData);
			}
		}
	});
var $author$project$Components$Menu$Settings$Settings$viewSettings = F2(
	function (_v0, globalData) {
		var model = _v0.a;
		var showStatus = A2($author$project$Lib$DefinedTypes$Parser$dgetbool, model, 'show');
		var radius = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'radius');
		var posY = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'posY');
		var posX = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'posX');
		var childComponentsList = A2($author$project$Lib$DefinedTypes$Parser$dgetLComponent, model, 'Child');
		return A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			A2(
				$elm$core$List$append,
				_List_fromArray(
					[
						A2(
						$joakin$elm_canvas$Canvas$shapes,
						_List_fromArray(
							[
								$joakin$elm_canvas$Canvas$Settings$stroke($avh4$elm_color$Color$red)
							]),
						_List_fromArray(
							[
								A2(
								$joakin$elm_canvas$Canvas$circle,
								A2(
									$author$project$Lib$Coordinate$Coordinates$posToReal,
									globalData,
									_Utils_Tuple2(posX, posY)),
								A2($author$project$Lib$Coordinate$Coordinates$widthToReal, globalData, radius))
							])),
						A5(
						$author$project$Lib$Render$Render$renderText,
						globalData,
						50,
						'S',
						'sans-serif',
						_Utils_Tuple2(posX - 20, posY - 30))
					]),
				showStatus ? A2(
					$elm$core$List$append,
					_List_fromArray(
						[
							A5(
							$author$project$Lib$Render$Render$renderText,
							globalData,
							50,
							'Settings',
							'sans-serif',
							_Utils_Tuple2(500, 500))
						]),
					A2(
						$elm$core$List$map,
						function (_v1) {
							var comModel = _v1.b;
							return A2(
								comModel.view,
								_Utils_Tuple2(comModel.data, 0),
								globalData);
						},
						childComponentsList)) : _List_Nil));
	});
var $author$project$Components$Menu$Settings$Export$component = {
	data: A2($author$project$Components$Menu$Settings$Settings$initSettings, 0, $author$project$Lib$Component$Base$NullComponentMsg),
	init: $author$project$Components$Menu$Settings$Settings$initSettings,
	name: 'Settings',
	query: F2(
		function (_v0, _v1) {
			return $author$project$Lib$Component$Base$NullComponentMsg;
		}),
	update: $author$project$Components$Menu$Settings$Settings$updateSettings,
	view: $author$project$Components$Menu$Settings$Settings$viewSettings
};
var $author$project$Components$Menu$Settings$Export$initComponent = F2(
	function (t, ct) {
		return _Utils_update(
			$author$project$Components$Menu$Settings$Export$component,
			{
				data: A2($author$project$Components$Menu$Settings$Export$component.init, t, ct)
			});
	});
var $author$project$Components$Menu$Status$Status$initStatus = F2(
	function (_v0, _v1) {
		return $elm$core$Dict$fromList(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'show',
					$author$project$Lib$Component$Base$CDBool(false)),
					_Utils_Tuple2(
					'posX',
					$author$project$Lib$Component$Base$CDInt(700)),
					_Utils_Tuple2(
					'posY',
					$author$project$Lib$Component$Base$CDInt(400)),
					_Utils_Tuple2(
					'radius',
					$author$project$Lib$Component$Base$CDInt(30)),
					_Utils_Tuple2(
					'Data',
					$author$project$Lib$Component$Base$CDDict($elm$core$Dict$empty))
				]));
	});
var $author$project$Components$Menu$Status$Status$updateStatus = F4(
	function (mainMsg, comMsg, globalData, _v0) {
		var model = _v0.a;
		var t = _v0.b;
		var reverseShowStatus = A2($author$project$Lib$DefinedTypes$Parser$dgetbool, model, 'show') ? false : true;
		var radius = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'radius');
		var posY = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'posY');
		var posX = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'posX');
		if ((mainMsg.$ === 'MouseDown') && (!mainMsg.a)) {
			var _v2 = mainMsg.b;
			var x = _v2.a;
			var y = _v2.b;
			return A4(
				$author$project$Lib$Coordinate$Coordinates$judgeMouse,
				globalData,
				_Utils_Tuple2(x, y),
				_Utils_Tuple2(posX - radius, posY - radius),
				_Utils_Tuple2(2 * radius, 2 * radius)) ? _Utils_Tuple3(
				A3($author$project$Lib$DefinedTypes$Parser$dsetbool, 'show', reverseShowStatus, model),
				reverseShowStatus ? A2(
					$author$project$Lib$Component$Base$ComponentLSStringMsg,
					'OnShow',
					_List_fromArray(
						['Status'])) : A2(
					$author$project$Lib$Component$Base$ComponentLSStringMsg,
					'OnHide',
					_List_fromArray(
						['Status'])),
				globalData) : _Utils_Tuple3(model, $author$project$Lib$Component$Base$NullComponentMsg, globalData);
		} else {
			switch (comMsg.$) {
				case 'ComponentStringMsg':
					var demand = comMsg.a;
					switch (demand) {
						case 'Display:HIDE':
							return _Utils_Tuple3(
								A3($author$project$Lib$DefinedTypes$Parser$dsetbool, 'show', false, model),
								$author$project$Lib$Component$Base$NullComponentMsg,
								globalData);
						case 'Display:SHOW':
							return _Utils_Tuple3(
								A3($author$project$Lib$DefinedTypes$Parser$dsetbool, 'show', true, model),
								$author$project$Lib$Component$Base$NullComponentMsg,
								globalData);
						default:
							return _Utils_Tuple3(model, $author$project$Lib$Component$Base$NullComponentMsg, globalData);
					}
				case 'ComponentDictMsg':
					var dict = comMsg.a;
					return _Utils_Tuple3(
						A3($author$project$Lib$DefinedTypes$Parser$dsetDict, 'Data', dict, model),
						$author$project$Lib$Component$Base$NullComponentMsg,
						globalData);
				default:
					return _Utils_Tuple3(model, $author$project$Lib$Component$Base$NullComponentMsg, globalData);
			}
		}
	});
var $elm$core$String$fromFloat = _String_fromNumber;
var $avh4$elm_color$Color$grey = A4($avh4$elm_color$Color$RgbaSpace, 211 / 255, 215 / 255, 207 / 255, 1.0);
var $author$project$Components$Menu$Status$Status$viewStatus = F2(
	function (_v0, globalData) {
		var model = _v0.a;
		var showStatus = A2($author$project$Lib$DefinedTypes$Parser$dgetbool, model, 'show');
		var radius = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'radius');
		var posY = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'posY');
		var posX = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, 'posX');
		return A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			A2(
				$elm$core$List$append,
				_List_fromArray(
					[
						A2(
						$joakin$elm_canvas$Canvas$shapes,
						_List_fromArray(
							[
								$joakin$elm_canvas$Canvas$Settings$stroke($avh4$elm_color$Color$grey)
							]),
						_List_fromArray(
							[
								A2(
								$joakin$elm_canvas$Canvas$circle,
								A2(
									$author$project$Lib$Coordinate$Coordinates$posToReal,
									globalData,
									_Utils_Tuple2(posX, posY)),
								A2($author$project$Lib$Coordinate$Coordinates$widthToReal, globalData, radius))
							])),
						A5(
						$author$project$Lib$Render$Render$renderText,
						globalData,
						50,
						'Status',
						'sans-serif',
						_Utils_Tuple2(posX - 20, posY - 30))
					]),
				function () {
					if (showStatus) {
						var data = A2($author$project$Lib$DefinedTypes$Parser$dgetDict, model, 'Data');
						var charLife = A2($author$project$Lib$DefinedTypes$Parser$dgetint, data, 'CharLife');
						var charEnergy = A2($author$project$Lib$DefinedTypes$Parser$dgetfloat, data, 'CharEnergy');
						return _List_fromArray(
							[
								A5(
								$author$project$Lib$Render$Render$renderText,
								globalData,
								30,
								'Status',
								'sans-serif',
								_Utils_Tuple2(500, 500)),
								A5(
								$author$project$Lib$Render$Render$renderText,
								globalData,
								30,
								'Life: ' + $elm$core$String$fromInt(charLife),
								'sans-serif',
								_Utils_Tuple2(500, 530)),
								A5(
								$author$project$Lib$Render$Render$renderText,
								globalData,
								30,
								'Energy: ' + $elm$core$String$fromFloat(charEnergy),
								'sans-serif',
								_Utils_Tuple2(500, 560))
							]);
					} else {
						return _List_Nil;
					}
				}()));
	});
var $author$project$Components$Menu$Status$Export$component = {
	data: A2($author$project$Components$Menu$Status$Status$initStatus, 0, $author$project$Lib$Component$Base$NullComponentMsg),
	init: $author$project$Components$Menu$Status$Status$initStatus,
	name: 'Status',
	query: F2(
		function (_v0, _v1) {
			return $author$project$Lib$Component$Base$NullComponentMsg;
		}),
	update: $author$project$Components$Menu$Status$Status$updateStatus,
	view: $author$project$Components$Menu$Status$Status$viewStatus
};
var $author$project$Components$Menu$Status$Export$initComponent = F2(
	function (t, ct) {
		return _Utils_update(
			$author$project$Components$Menu$Status$Export$component,
			{
				data: A2($author$project$Components$Menu$Status$Export$component.init, t, ct)
			});
	});
var $author$project$Lib$Component$Base$CDFloat = function (a) {
	return {$: 'CDFloat', a: a};
};
var $author$project$Components$Menu$Menu$testData = $elm$core$Dict$fromList(
	_List_fromArray(
		[
			_Utils_Tuple2(
			'CharLife',
			$author$project$Lib$Component$Base$CDInt(5)),
			_Utils_Tuple2(
			'CharEnergy',
			$author$project$Lib$Component$Base$CDFloat(50.5)),
			_Utils_Tuple2(
			'CharPositionX',
			$author$project$Lib$Component$Base$CDFloat(400)),
			_Utils_Tuple2(
			'CharPositionY',
			$author$project$Lib$Component$Base$CDFloat(30)),
			_Utils_Tuple2(
			'MapWidth',
			$author$project$Lib$Component$Base$CDFloat(1000)),
			_Utils_Tuple2(
			'MapHeight',
			$author$project$Lib$Component$Base$CDFloat(500))
		]));
var $author$project$Components$Menu$Menu$initMenu = F2(
	function (_v0, _v1) {
		return $elm$core$Dict$fromList(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'Show',
					$author$project$Lib$Component$Base$CDBool(false)),
					_Utils_Tuple2(
					'Child',
					$author$project$Lib$Component$Base$CDLComponent(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'Status',
								A2($author$project$Components$Menu$Status$Export$initComponent, 0, $author$project$Lib$Component$Base$NullComponentMsg)),
								_Utils_Tuple2(
								'Settings',
								A2($author$project$Components$Menu$Settings$Export$initComponent, 0, $author$project$Lib$Component$Base$NullComponentMsg)),
								_Utils_Tuple2(
								'Map',
								A2($author$project$Components$Menu$Map$Export$initComponent, 0, $author$project$Lib$Component$Base$NullComponentMsg))
							]))),
					_Utils_Tuple2(
					'Data',
					$author$project$Lib$Component$Base$CDDict($author$project$Components$Menu$Menu$testData))
				]));
	});
var $author$project$Lib$Component$Base$ComponentDictMsg = function (a) {
	return {$: 'ComponentDictMsg', a: a};
};
var $author$project$Base$UnknownMsg = {$: 'UnknownMsg'};
var $author$project$Components$Menu$Menu$componentInteract = F4(
	function (comList, comMsgList, newMsg, globalData) {
		componentInteract:
		while (true) {
			if (comMsgList.b) {
				var tmpMsg = comMsgList.a;
				var restMsgList = comMsgList.b;
				if (tmpMsg.$ === 'ComponentLSStringMsg') {
					var demand = tmpMsg.a;
					var listStr = tmpMsg.b;
					if (demand === 'OnShow') {
						var showItemName = A2(
							$elm$core$Maybe$withDefault,
							'None',
							$elm$core$List$head(listStr));
						var newComListWithComMsgs = A2(
							$elm$core$List$map,
							function (_v5) {
								var comName = _v5.a;
								var comModel = _v5.b;
								var _v6 = _Utils_eq(comName, showItemName) ? _Utils_Tuple3(comModel.data, $author$project$Lib$Component$Base$NullComponentMsg, globalData) : A4(
									comModel.update,
									$author$project$Base$UnknownMsg,
									$author$project$Lib$Component$Base$ComponentStringMsg('Display:HIDE'),
									globalData,
									_Utils_Tuple2(comModel.data, 0));
								var tmpData = _v6.a;
								var tmpComMsg = _v6.b;
								return _Utils_Tuple2(
									_Utils_Tuple2(
										comName,
										_Utils_update(
											comModel,
											{data: tmpData})),
									tmpComMsg);
							},
							comList);
						var newComMsg = A2(
							$elm$core$Maybe$withDefault,
							$author$project$Lib$Component$Base$NullComponentMsg,
							$elm$core$List$head(
								A2(
									$elm$core$List$map,
									function (_v4) {
										var tmpComMsg = _v4.b;
										return tmpComMsg;
									},
									newComListWithComMsgs)));
						var newComList = A2(
							$elm$core$List$map,
							function (_v3) {
								var tmpCom = _v3.a;
								return tmpCom;
							},
							newComListWithComMsgs);
						if (_Utils_eq(newMsg, $author$project$Lib$Component$Base$NullComponentMsg)) {
							var $temp$comList = newComList,
								$temp$comMsgList = restMsgList,
								$temp$newMsg = newComMsg,
								$temp$globalData = globalData;
							comList = $temp$comList;
							comMsgList = $temp$comMsgList;
							newMsg = $temp$newMsg;
							globalData = $temp$globalData;
							continue componentInteract;
						} else {
							var $temp$comList = newComList,
								$temp$comMsgList = restMsgList,
								$temp$newMsg = newMsg,
								$temp$globalData = globalData;
							comList = $temp$comList;
							comMsgList = $temp$comMsgList;
							newMsg = $temp$newMsg;
							globalData = $temp$globalData;
							continue componentInteract;
						}
					} else {
						var $temp$comList = comList,
							$temp$comMsgList = restMsgList,
							$temp$newMsg = newMsg,
							$temp$globalData = globalData;
						comList = $temp$comList;
						comMsgList = $temp$comMsgList;
						newMsg = $temp$newMsg;
						globalData = $temp$globalData;
						continue componentInteract;
					}
				} else {
					var $temp$comList = comList,
						$temp$comMsgList = restMsgList,
						$temp$newMsg = newMsg,
						$temp$globalData = globalData;
					comList = $temp$comList;
					comMsgList = $temp$comMsgList;
					newMsg = $temp$newMsg;
					globalData = $temp$globalData;
					continue componentInteract;
				}
			} else {
				return _Utils_Tuple3(comList, newMsg, globalData);
			}
		}
	});
var $author$project$Components$Menu$Menu$updateMenu = F4(
	function (mainMsg, comMsg, globalData, _v0) {
		var model = _v0.a;
		var t = _v0.b;
		var showStatus = A2($author$project$Lib$DefinedTypes$Parser$dgetbool, model, 'Show');
		var childComponentsList = A2($author$project$Lib$DefinedTypes$Parser$dgetLComponent, model, 'Child');
		if (mainMsg.$ === 'MouseDown') {
			var _v2 = mainMsg.b;
			var x = _v2.a;
			var y = _v2.b;
			var _v3 = A3(
				$elm$core$List$foldl,
				F2(
					function (_v4, _v5) {
						var comName = _v4.a;
						var comModel = _v4.b;
						var tmpComList = _v5.a;
						var tmpComMsgList = _v5.b;
						var tmpGData = _v5.c;
						var _v6 = A4(
							comModel.update,
							mainMsg,
							comMsg,
							tmpGData,
							_Utils_Tuple2(comModel.data, t));
						var tmpCom = _v6.a;
						var tmpComMsg = _v6.b;
						var gD = _v6.c;
						return _Utils_Tuple3(
							A2(
								$elm$core$List$append,
								tmpComList,
								_List_fromArray(
									[
										_Utils_Tuple2(
										comName,
										_Utils_update(
											comModel,
											{data: tmpCom}))
									])),
							A2(
								$elm$core$List$append,
								tmpComMsgList,
								_List_fromArray(
									[tmpComMsg])),
							gD);
					}),
				_Utils_Tuple3(_List_Nil, _List_Nil, globalData),
				childComponentsList);
			var tmpChildComponentsList = _v3.a;
			var tmpChildComponentsMsg = _v3.b;
			var tmpGlobalData = _v3.c;
			var _v7 = A4($author$project$Components$Menu$Menu$componentInteract, tmpChildComponentsList, tmpChildComponentsMsg, $author$project$Lib$Component$Base$NullComponentMsg, tmpGlobalData);
			var newChildComponentsList = _v7.a;
			var newChildComponentsMsg = _v7.b;
			var newGlobalData = _v7.c;
			return A4(
				$author$project$Lib$Coordinate$Coordinates$judgeMouse,
				globalData,
				_Utils_Tuple2(x, y),
				_Utils_Tuple2(1100 - 30, 400 - 30),
				_Utils_Tuple2(2 * 30, 2 * 30)) ? _Utils_Tuple3(
				A3($author$project$Lib$DefinedTypes$Parser$dsetbool, 'Show', false, model),
				$author$project$Lib$Component$Base$NullComponentMsg,
				globalData) : (showStatus ? _Utils_Tuple3(
				A3($author$project$Lib$DefinedTypes$Parser$dsetLComponent, 'Child', newChildComponentsList, model),
				newChildComponentsMsg,
				newGlobalData) : _Utils_Tuple3(model, $author$project$Lib$Component$Base$NullComponentMsg, globalData));
		} else {
			if (((comMsg.$ === 'ComponentLStringMsg') && comMsg.a.b) && comMsg.a.b.b) {
				var _v9 = comMsg.a;
				var demand = _v9.a;
				var _v10 = _v9.b;
				if (demand === 'Activate') {
					var tmpData = A2($author$project$Lib$DefinedTypes$Parser$dgetDict, model, 'Data');
					var _v12 = A3(
						$elm$core$List$foldl,
						F2(
							function (_v13, _v14) {
								var comName = _v13.a;
								var comModel = _v13.b;
								var tmpComList = _v14.a;
								var tmpComMsgList = _v14.b;
								var tmpGData = _v14.c;
								var _v15 = A4(
									comModel.update,
									mainMsg,
									$author$project$Lib$Component$Base$ComponentDictMsg(tmpData),
									tmpGData,
									_Utils_Tuple2(comModel.data, t));
								var tmpCom = _v15.a;
								var tmpComMsg = _v15.b;
								var gD = _v15.c;
								return _Utils_Tuple3(
									A2(
										$elm$core$List$append,
										tmpComList,
										_List_fromArray(
											[
												_Utils_Tuple2(
												comName,
												_Utils_update(
													comModel,
													{data: tmpCom}))
											])),
									A2(
										$elm$core$List$append,
										tmpComMsgList,
										_List_fromArray(
											[tmpComMsg])),
									gD);
							}),
						_Utils_Tuple3(_List_Nil, _List_Nil, globalData),
						childComponentsList);
					var newChildComponentsList = _v12.a;
					var newGlobalData = _v12.c;
					return _Utils_Tuple3(
						A3(
							$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
							'Child',
							newChildComponentsList,
							A3($author$project$Lib$DefinedTypes$Parser$dsetbool, 'Show', true, model)),
						$author$project$Lib$Component$Base$NullComponentMsg,
						newGlobalData);
				} else {
					return _Utils_Tuple3(model, $author$project$Lib$Component$Base$NullComponentMsg, globalData);
				}
			} else {
				return _Utils_Tuple3(model, $author$project$Lib$Component$Base$NullComponentMsg, globalData);
			}
		}
	});
var $avh4$elm_color$Color$black = A4($avh4$elm_color$Color$RgbaSpace, 0 / 255, 0 / 255, 0 / 255, 1.0);
var $author$project$Components$Menu$Menu$viewMenu = F2(
	function (_v0, globalData) {
		var model = _v0.a;
		var t = _v0.b;
		var showStatus = A2($author$project$Lib$DefinedTypes$Parser$dgetbool, model, 'Show');
		var childComponentsList = A2($author$project$Lib$DefinedTypes$Parser$dgetLComponent, model, 'Child');
		return showStatus ? A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			A2(
				$elm$core$List$append,
				_List_fromArray(
					[
						A2(
						$joakin$elm_canvas$Canvas$shapes,
						_List_fromArray(
							[
								$joakin$elm_canvas$Canvas$Settings$stroke($avh4$elm_color$Color$black)
							]),
						_List_fromArray(
							[
								A3(
								$joakin$elm_canvas$Canvas$rect,
								A2(
									$author$project$Lib$Coordinate$Coordinates$posToReal,
									globalData,
									_Utils_Tuple2(400, 300)),
								A2($author$project$Lib$Coordinate$Coordinates$widthToReal, globalData, 800),
								A2($author$project$Lib$Coordinate$Coordinates$heightToReal, globalData, 500)),
								A2(
								$joakin$elm_canvas$Canvas$circle,
								A2(
									$author$project$Lib$Coordinate$Coordinates$posToReal,
									globalData,
									_Utils_Tuple2(1100, 400)),
								A2($author$project$Lib$Coordinate$Coordinates$widthToReal, globalData, 30))
							])),
						A5(
						$author$project$Lib$Render$Render$renderText,
						globalData,
						50,
						'X',
						'sans-serif',
						_Utils_Tuple2(1100 - 15, 400 - 30))
					]),
				A2(
					$elm$core$List$map,
					function (_v1) {
						var comModel = _v1.b;
						return A2(
							comModel.view,
							_Utils_Tuple2(comModel.data, t),
							globalData);
					},
					childComponentsList))) : A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil);
	});
var $author$project$Components$Menu$Export$component = {
	data: A2($author$project$Components$Menu$Menu$initMenu, 0, $author$project$Lib$Component$Base$NullComponentMsg),
	init: $author$project$Components$Menu$Menu$initMenu,
	name: 'Menu',
	query: F2(
		function (_v0, _v1) {
			return $author$project$Lib$Component$Base$NullComponentMsg;
		}),
	update: $author$project$Components$Menu$Menu$updateMenu,
	view: $author$project$Components$Menu$Menu$viewMenu
};
var $author$project$Components$Menu$Export$initComponent = F2(
	function (t, ct) {
		return _Utils_update(
			$author$project$Components$Menu$Export$component,
			{
				data: A2($author$project$Components$Menu$Export$component.init, t, ct)
			});
	});
var $author$project$Lib$Component$Base$CDLString = function (a) {
	return {$: 'CDLString', a: a};
};
var $author$project$Components$Trans$Trans$initTrans = F2(
	function (t, ct) {
		if ((((ct.$ === 'ComponentLStringMsg') && ct.a.b) && ct.a.b.b) && ct.a.b.b.b) {
			var _v1 = ct.a;
			var mode = _v1.a;
			var _v2 = _v1.b;
			var method = _v2.a;
			var _v3 = _v2.b;
			var dur = _v3.a;
			return $elm$core$Dict$fromList(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'rt',
						$author$project$Lib$Component$Base$CDInt(t)),
						_Utils_Tuple2(
						'mode',
						$author$project$Lib$Component$Base$CDString(mode)),
						_Utils_Tuple2(
						'method',
						$author$project$Lib$Component$Base$CDString(method)),
						_Utils_Tuple2(
						'msg',
						$author$project$Lib$Component$Base$CDLString(_List_Nil)),
						_Utils_Tuple2(
						'duration',
						$author$project$Lib$Component$Base$CDInt(
							A2(
								$elm$core$Maybe$withDefault,
								0,
								$elm$core$String$toInt(dur)))),
						_Utils_Tuple2(
						'state',
						$author$project$Lib$Component$Base$CDBool(true))
					]));
		} else {
			return $elm$core$Dict$fromList(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'rt',
						$author$project$Lib$Component$Base$CDInt(0)),
						_Utils_Tuple2(
						'mode',
						$author$project$Lib$Component$Base$CDString('start')),
						_Utils_Tuple2(
						'method',
						$author$project$Lib$Component$Base$CDString('cloud')),
						_Utils_Tuple2(
						'msg',
						$author$project$Lib$Component$Base$CDLString(_List_Nil)),
						_Utils_Tuple2(
						'duration',
						$author$project$Lib$Component$Base$CDInt(0)),
						_Utils_Tuple2(
						'state',
						$author$project$Lib$Component$Base$CDBool(false))
					]));
		}
	});
var $author$project$Lib$DefinedTypes$Parser$dgetLString = F2(
	function (f, s) {
		var other = _List_Nil;
		var _v0 = A2($elm$core$Dict$get, s, f);
		if ((_v0.$ === 'Just') && (_v0.a.$ === 'CDLString')) {
			var x = _v0.a.a;
			return x;
		} else {
			return other;
		}
	});
var $author$project$Lib$DefinedTypes$Parser$dsetint = F3(
	function (s, t, f) {
		return A3(
			$elm$core$Dict$update,
			s,
			function (_v0) {
				return $elm$core$Maybe$Just(
					$author$project$Lib$Component$Base$CDInt(t));
			},
			f);
	});
var $author$project$Lib$DefinedTypes$Parser$dsetlstring = F3(
	function (s, t, f) {
		return A3(
			$elm$core$Dict$update,
			s,
			function (_v0) {
				return $elm$core$Maybe$Just(
					$author$project$Lib$Component$Base$CDLString(t));
			},
			f);
	});
var $author$project$Components$Trans$Trans$pausetime = 40;
var $author$project$Components$Trans$Trans$updateTrans = F4(
	function (_v0, gMsg, globalData, _v1) {
		var d = _v1.a;
		var t = _v1.b;
		var localtime = t - A2($author$project$Lib$DefinedTypes$Parser$dgetint, d, 'rt');
		var duration = A2($author$project$Lib$DefinedTypes$Parser$dgetint, d, 'duration');
		if ((((gMsg.$ === 'ComponentLStringMsg') && gMsg.a.b) && gMsg.a.b.b) && gMsg.a.b.b.b) {
			var _v3 = gMsg.a;
			var mode = _v3.a;
			var _v4 = _v3.b;
			var method = _v4.a;
			var _v5 = _v4.b;
			var dur = _v5.a;
			var msg = _v5.b;
			var newd = A3(
				$author$project$Lib$DefinedTypes$Parser$dsetint,
				'rt',
				t,
				A3(
					$author$project$Lib$DefinedTypes$Parser$dsetint,
					'duration',
					A2(
						$elm$core$Maybe$withDefault,
						0,
						$elm$core$String$toInt(dur)),
					A3(
						$author$project$Lib$DefinedTypes$Parser$dsetstring,
						'method',
						method,
						A3(
							$author$project$Lib$DefinedTypes$Parser$dsetstring,
							'mode',
							mode,
							A3(
								$author$project$Lib$DefinedTypes$Parser$dsetlstring,
								'msg',
								msg,
								A3($author$project$Lib$DefinedTypes$Parser$dsetbool, 'state', true, d))))));
			return _Utils_Tuple3(newd, $author$project$Lib$Component$Base$NullComponentMsg, globalData);
		} else {
			return (_Utils_eq(localtime, duration + $author$project$Components$Trans$Trans$pausetime) && (A2($author$project$Lib$DefinedTypes$Parser$dgetString, d, 'mode') === 'start')) ? _Utils_Tuple3(
				d,
				$author$project$Lib$Component$Base$ComponentLStringMsg(
					A2($author$project$Lib$DefinedTypes$Parser$dgetLString, d, 'msg')),
				globalData) : ((_Utils_eq(localtime, duration + $author$project$Components$Trans$Trans$pausetime) && (A2($author$project$Lib$DefinedTypes$Parser$dgetString, d, 'mode') === 'end')) ? _Utils_Tuple3(
				A3($author$project$Lib$DefinedTypes$Parser$dsetbool, 'state', false, d),
				$author$project$Lib$Component$Base$NullComponentMsg,
				globalData) : _Utils_Tuple3(d, $author$project$Lib$Component$Base$NullComponentMsg, globalData));
		}
	});
var $author$project$Components$Trans$Trans$shapePos = F3(
	function (time, _v0, _v1) {
		var startX = _v0.a;
		var startY = _v0.b;
		var endX = _v1.a;
		var endY = _v1.b;
		return (_Utils_cmp(time, $author$project$Components$Trans$Trans$pausetime) > 0) ? _Utils_Tuple2(endX, endY) : _Utils_Tuple2(startX + ((((endX - startX) / $author$project$Components$Trans$Trans$pausetime) | 0) * time), startY + ((((endY - startY) / $author$project$Components$Trans$Trans$pausetime) | 0) * time));
	});
var $author$project$Components$Trans$Trans$viewTrans = F2(
	function (_v0, gd) {
		var d = _v0.a;
		var t = _v0.b;
		var localtime = t - A2($author$project$Lib$DefinedTypes$Parser$dgetint, d, 'rt');
		if (A2($author$project$Lib$DefinedTypes$Parser$dgetbool, d, 'state')) {
			var _v1 = A2($author$project$Lib$DefinedTypes$Parser$dgetString, d, 'mode');
			switch (_v1) {
				case 'start':
					return A2(
						$joakin$elm_canvas$Canvas$group,
						_List_Nil,
						_List_fromArray(
							[
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(2000, 270),
									_Utils_Tuple2(1000, 270)),
								_Utils_Tuple2(353 * 6, 176 * 6),
								'rcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(-2000, 100),
									_Utils_Tuple2(-800, 100)),
								_Utils_Tuple2(353 * 4, 176 * 4),
								'lcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(-2000, -500),
									_Utils_Tuple2(-700, -500)),
								_Utils_Tuple2(353 * 6, 176 * 6),
								'lcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(2000, -90),
									_Utils_Tuple2(1080, -90)),
								_Utils_Tuple2(353 * 4, 176 * 4),
								'rcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(-2000, 100),
									_Utils_Tuple2(-300, 100)),
								_Utils_Tuple2(353 * 4, 176 * 4),
								'lcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(-2000, 600),
									_Utils_Tuple2(-500, 600)),
								_Utils_Tuple2(353 * 5, 176 * 5),
								'lcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(-2000, -160),
									_Utils_Tuple2(-400, -160)),
								_Utils_Tuple2(353 * 2, 176 * 2),
								'lcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(-2000, 600),
									_Utils_Tuple2(-600, 600)),
								_Utils_Tuple2(353 * 3, 176 * 3),
								'lcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(2000, 800),
									_Utils_Tuple2(1000, 800)),
								_Utils_Tuple2(353 * 3, 176 * 3),
								'rcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(2100, -100),
									_Utils_Tuple2(1580, -100)),
								_Utils_Tuple2(353 * 2, 176 * 2),
								'rcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(2000, 400),
									_Utils_Tuple2(700, 400)),
								_Utils_Tuple2(353 * 3, 176 * 3),
								'rcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(2000, 150),
									_Utils_Tuple2(1700, 150)),
								_Utils_Tuple2(353, 176),
								'rcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(-2000, 700),
									_Utils_Tuple2(150, 700)),
								_Utils_Tuple2(353, 176),
								'lcloud')
							]));
				case 'end':
					return A2(
						$joakin$elm_canvas$Canvas$group,
						_List_Nil,
						_List_fromArray(
							[
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(1000, 270),
									_Utils_Tuple2(2000, 270)),
								_Utils_Tuple2(353 * 6, 176 * 6),
								'rcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(-800, 100),
									_Utils_Tuple2(-2000, 100)),
								_Utils_Tuple2(353 * 4, 176 * 4),
								'lcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(-700, -500),
									_Utils_Tuple2(-2000, -500)),
								_Utils_Tuple2(353 * 6, 176 * 6),
								'lcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(1080, -90),
									_Utils_Tuple2(2000, -90)),
								_Utils_Tuple2(353 * 4, 176 * 4),
								'rcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(-300, 100),
									_Utils_Tuple2(-2000, 100)),
								_Utils_Tuple2(353 * 4, 176 * 4),
								'lcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(-500, 600),
									_Utils_Tuple2(-2000, 600)),
								_Utils_Tuple2(353 * 5, 176 * 5),
								'lcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(-400, -160),
									_Utils_Tuple2(-2000, -160)),
								_Utils_Tuple2(353 * 2, 176 * 2),
								'lcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(-600, 600),
									_Utils_Tuple2(-2000, 600)),
								_Utils_Tuple2(353 * 3, 176 * 3),
								'lcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(1000, 800),
									_Utils_Tuple2(2000, 800)),
								_Utils_Tuple2(353 * 3, 176 * 3),
								'rcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(1580, -100),
									_Utils_Tuple2(2100, -100)),
								_Utils_Tuple2(353 * 2, 176 * 2),
								'rcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(700, 400),
									_Utils_Tuple2(2000, 400)),
								_Utils_Tuple2(353 * 3, 176 * 3),
								'rcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(1700, 150),
									_Utils_Tuple2(2000, 150)),
								_Utils_Tuple2(353, 176),
								'rcloud'),
								A5(
								$author$project$Lib$Render$Render$renderSprite,
								gd,
								_List_Nil,
								A3(
									$author$project$Components$Trans$Trans$shapePos,
									localtime,
									_Utils_Tuple2(150, 700),
									_Utils_Tuple2(-2000, 700)),
								_Utils_Tuple2(353, 176),
								'lcloud')
							]));
				default:
					return A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil);
			}
		} else {
			return A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil);
		}
	});
var $author$project$Components$Trans$Export$component = {
	data: A2($author$project$Components$Trans$Trans$initTrans, 0, $author$project$Lib$Component$Base$NullComponentMsg),
	init: $author$project$Components$Trans$Trans$initTrans,
	name: 'Trans',
	query: F2(
		function (_v0, _v1) {
			return $author$project$Lib$Component$Base$NullComponentMsg;
		}),
	update: $author$project$Components$Trans$Trans$updateTrans,
	view: $author$project$Components$Trans$Trans$viewTrans
};
var $author$project$Components$Trans$Export$initComponent = F2(
	function (t, ct) {
		return _Utils_update(
			$author$project$Components$Trans$Export$component,
			{
				data: A2($author$project$Components$Trans$Export$component.init, t, ct)
			});
	});
var $author$project$Lib$CoreEngine$FrontgroundLayer$Model$initModel = F3(
	function (t, lm, _v0) {
		if (lm.$ === 'LayerCTMsg') {
			var f = lm.a;
			return {
				components: A2(
					$elm$core$Array$append,
					$elm$core$Array$fromList(
						_List_fromArray(
							[
								A2(
								$author$project$Components$Trans$Export$initComponent,
								t,
								$author$project$Lib$Component$Base$ComponentLStringMsg(
									_List_fromArray(
										['end', 'cloud', '0']))),
								A2($author$project$Components$Menu$Export$initComponent, t, $author$project$Lib$Component$Base$NullComponentMsg),
								A2($author$project$Components$Console$Export$initComponent, t, $author$project$Lib$Component$Base$NullComponentMsg)
							])),
					f.components),
				fpsrepo: _List_Nil,
				render: f.timeseries
			};
		} else {
			return {
				components: $elm$core$Array$empty,
				fpsrepo: _List_Nil,
				render: F3(
					function (_v2, _v3, _v4) {
						return A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil);
					})
			};
		}
	});
var $author$project$Lib$Scene$Base$DefaultPlayerPosition = {$: 'DefaultPlayerPosition'};
var $author$project$Lib$Scene$Base$EngineT = F2(
	function (energy, playerPosition) {
		return {energy: energy, playerPosition: playerPosition};
	});
var $author$project$Lib$Layer$Base$LayerExitMsg = F2(
	function (a, b) {
		return {$: 'LayerExitMsg', a: a, b: b};
	});
var $author$project$Lib$Layer$Base$LayerName = function (a) {
	return {$: 'LayerName', a: a};
};
var $author$project$Lib$Layer$Base$LayerParentScene = {$: 'LayerParentScene'};
var $author$project$Lib$Layer$Base$LayerStringMsg = function (a) {
	return {$: 'LayerStringMsg', a: a};
};
var $author$project$Lib$CoreEngine$FrontgroundLayer$Model$dealComponentsMsg = F4(
	function (rmsg, model, gd, ggd) {
		_v0$4:
		while (true) {
			switch (rmsg.$) {
				case 'ComponentLStringMsg':
					if (rmsg.a.b) {
						switch (rmsg.a.a) {
							case 'nextscene':
								if (rmsg.a.b.b) {
									var _v1 = rmsg.a;
									var _v2 = _v1.b;
									var s = _v2.a;
									return _Utils_Tuple2(
										_Utils_Tuple3(
											model,
											ggd,
											_List_fromArray(
												[
													_Utils_Tuple2(
													$author$project$Lib$Layer$Base$LayerParentScene,
													A2(
														$author$project$Lib$Layer$Base$LayerExitMsg,
														A2($author$project$Lib$Scene$Base$EngineT, ggd.energy, $author$project$Lib$Scene$Base$DefaultPlayerPosition),
														s))
												])),
										gd);
								} else {
									break _v0$4;
								}
							case 'restart':
								var _v3 = rmsg.a;
								return _Utils_Tuple2(
									_Utils_Tuple3(
										model,
										ggd,
										_List_fromArray(
											[
												_Utils_Tuple2(
												$author$project$Lib$Layer$Base$LayerParentScene,
												A2(
													$author$project$Lib$Layer$Base$LayerExitMsg,
													A2($author$project$Lib$Scene$Base$EngineT, 0, $author$project$Lib$Scene$Base$DefaultPlayerPosition),
													ggd.currentScene))
											])),
									gd);
							default:
								break _v0$4;
						}
					} else {
						break _v0$4;
					}
				case 'ComponentStringMsg':
					switch (rmsg.a) {
						case 'stopGameInput':
							return _Utils_Tuple2(
								_Utils_Tuple3(
									model,
									ggd,
									_List_fromArray(
										[
											_Utils_Tuple2(
											$author$project$Lib$Layer$Base$LayerName('Game'),
											$author$project$Lib$Layer$Base$LayerStringMsg('stopinput'))
										])),
								gd);
						case 'startGameInput':
							return _Utils_Tuple2(
								_Utils_Tuple3(
									model,
									ggd,
									_List_fromArray(
										[
											_Utils_Tuple2(
											$author$project$Lib$Layer$Base$LayerName('Game'),
											$author$project$Lib$Layer$Base$LayerStringMsg('startinput'))
										])),
								gd);
						default:
							break _v0$4;
					}
				default:
					break _v0$4;
			}
		}
		return _Utils_Tuple2(
			_Utils_Tuple3(model, ggd, _List_Nil),
			gd);
	});
var $author$project$Lib$CoreEngine$FrontgroundLayer$Model$dealAllComponentMsg = F4(
	function (rmsg, model, gd, ggd) {
		return A3(
			$elm$core$List$foldl,
			F2(
				function (lmt, _v0) {
					var _v1 = _v0.a;
					var xm = _v1.a;
					var xggd = _v1.b;
					var xlm = _v1.c;
					var xgd = _v0.b;
					var _v2 = A4($author$project$Lib$CoreEngine$FrontgroundLayer$Model$dealComponentsMsg, lmt, xm, xgd, xggd);
					var _v3 = _v2.a;
					var nm = _v3.a;
					var nggd = _v3.b;
					var nlm = _v3.c;
					var ngd = _v2.b;
					return _Utils_Tuple2(
						_Utils_Tuple3(
							nm,
							nggd,
							_Utils_ap(xlm, nlm)),
						ngd);
				}),
			_Utils_Tuple2(
				_Utils_Tuple3(model, ggd, _List_Nil),
				gd),
			rmsg);
	});
var $elm$core$Array$foldl = F3(
	function (func, baseCase, _v0) {
		var tree = _v0.c;
		var tail = _v0.d;
		var helper = F2(
			function (node, acc) {
				if (node.$ === 'SubTree') {
					var subTree = node.a;
					return A3($elm$core$Elm$JsArray$foldl, helper, acc, subTree);
				} else {
					var values = node.a;
					return A3($elm$core$Elm$JsArray$foldl, func, acc, values);
				}
			});
		return A3(
			$elm$core$Elm$JsArray$foldl,
			func,
			A3($elm$core$Elm$JsArray$foldl, helper, baseCase, tree),
			tail);
	});
var $elm$core$Array$push = F2(
	function (a, array) {
		var tail = array.d;
		return A2(
			$elm$core$Array$unsafeReplaceTail,
			A2($elm$core$Elm$JsArray$push, a, tail),
			array);
	});
var $author$project$Lib$Component$ComponentHandler$updateComponents = F4(
	function (t, msg, gd, xs) {
		return A3(
			$elm$core$Array$foldl,
			F2(
				function (x, _v0) {
					var acs = _v0.a;
					var ct = _v0.b;
					var mlgg = _v0.c;
					var _v1 = A4(
						x.update,
						msg,
						$author$project$Lib$Component$Base$NullComponentMsg,
						mlgg,
						_Utils_Tuple2(x.data, t));
					var newx = _v1.a;
					var newmsg = _v1.b;
					var newgd = _v1.c;
					return _Utils_Tuple3(
						A2(
							$elm$core$Array$push,
							_Utils_update(
								x,
								{data: newx}),
							acs),
						_Utils_ap(
							ct,
							_List_fromArray(
								[newmsg])),
						newgd);
				}),
			_Utils_Tuple3($elm$core$Array$empty, _List_Nil, gd),
			xs);
	});
var $author$project$Lib$Component$ComponentHandler$getComponent = F2(
	function (n, xs) {
		return A2($elm$core$Array$get, n, xs);
	});
var $elm$core$Array$length = function (_v0) {
	var len = _v0.a;
	return len;
};
var $author$project$Lib$Tools$Array$locate = F2(
	function (f, xs) {
		var b = A2(
			$elm$core$List$range,
			0,
			$elm$core$Array$length(xs) - 1);
		var res = A2(
			$elm$core$List$filter,
			function (i) {
				var _v0 = A2($elm$core$Array$get, i, xs);
				if (_v0.$ === 'Just') {
					var x = _v0.a;
					return f(x) ? true : false;
				} else {
					return false;
				}
			},
			b);
		return res;
	});
var $author$project$Lib$Component$ComponentHandler$getComponentFromName = F2(
	function (s, xs) {
		return A2(
			$elm$core$Maybe$withDefault,
			-1,
			$elm$core$List$head(
				A2(
					$author$project$Lib$Tools$Array$locate,
					function (x) {
						return _Utils_eq(x.name, s);
					},
					xs)));
	});
var $elm$core$Array$setHelp = F4(
	function (shift, index, value, tree) {
		var pos = $elm$core$Array$bitMask & (index >>> shift);
		var _v0 = A2($elm$core$Elm$JsArray$unsafeGet, pos, tree);
		if (_v0.$ === 'SubTree') {
			var subTree = _v0.a;
			var newSub = A4($elm$core$Array$setHelp, shift - $elm$core$Array$shiftStep, index, value, subTree);
			return A3(
				$elm$core$Elm$JsArray$unsafeSet,
				pos,
				$elm$core$Array$SubTree(newSub),
				tree);
		} else {
			var values = _v0.a;
			var newLeaf = A3($elm$core$Elm$JsArray$unsafeSet, $elm$core$Array$bitMask & index, value, values);
			return A3(
				$elm$core$Elm$JsArray$unsafeSet,
				pos,
				$elm$core$Array$Leaf(newLeaf),
				tree);
		}
	});
var $elm$core$Array$set = F3(
	function (index, value, array) {
		var len = array.a;
		var startShift = array.b;
		var tree = array.c;
		var tail = array.d;
		return ((index < 0) || (_Utils_cmp(index, len) > -1)) ? array : ((_Utils_cmp(
			index,
			$elm$core$Array$tailIndex(len)) > -1) ? A4(
			$elm$core$Array$Array_elm_builtin,
			len,
			startShift,
			tree,
			A3($elm$core$Elm$JsArray$unsafeSet, $elm$core$Array$bitMask & index, value, tail)) : A4(
			$elm$core$Array$Array_elm_builtin,
			len,
			startShift,
			A4($elm$core$Array$setHelp, startShift, index, value, tree),
			tail));
	});
var $author$project$Lib$Component$ComponentHandler$updateSingleComponentByName = F6(
	function (msg, ct, gd, t, s, xs) {
		var n = A2($author$project$Lib$Component$ComponentHandler$getComponentFromName, s, xs);
		var _v0 = A2($author$project$Lib$Component$ComponentHandler$getComponent, n, xs);
		if (_v0.$ === 'Just') {
			var k = _v0.a;
			var _v1 = A4(
				k.update,
				msg,
				ct,
				gd,
				_Utils_Tuple2(k.data, t));
			var newx = _v1.a;
			var newmsg = _v1.b;
			var newgd = _v1.c;
			return _Utils_Tuple3(
				A3(
					$elm$core$Array$set,
					n,
					_Utils_update(
						k,
						{data: newx}),
					xs),
				newmsg,
				newgd);
		} else {
			return _Utils_Tuple3(xs, $author$project$Lib$Component$Base$NullComponentMsg, gd);
		}
	});
var $author$project$Lib$CoreEngine$FrontgroundLayer$Model$updateModel = F5(
	function (msg, gd, lm, _v0, ggd) {
		var model = _v0.a;
		var t = _v0.b;
		switch (lm.$) {
			case 'LayerExitMsg':
				var s = lm.b;
				var _v2 = A6(
					$author$project$Lib$Component$ComponentHandler$updateSingleComponentByName,
					$author$project$Base$UnknownMsg,
					$author$project$Lib$Component$Base$ComponentLStringMsg(
						_List_fromArray(
							['start', 'cloud', '50', 'nextscene', s])),
					gd,
					t,
					'Trans',
					model.components);
				var newcs = _v2.a;
				var newgd = _v2.c;
				return _Utils_Tuple2(
					_Utils_Tuple3(
						_Utils_update(
							model,
							{components: newcs}),
						ggd,
						_List_Nil),
					newgd);
			case 'LayerRestartMsg':
				var _v3 = A6(
					$author$project$Lib$Component$ComponentHandler$updateSingleComponentByName,
					$author$project$Base$UnknownMsg,
					$author$project$Lib$Component$Base$ComponentLStringMsg(
						_List_fromArray(
							['start', 'cloud', '10', 'restart'])),
					gd,
					t,
					'Trans',
					model.components);
				var newcs = _v3.a;
				var newgd = _v3.c;
				return _Utils_Tuple2(
					_Utils_Tuple3(
						_Utils_update(
							model,
							{components: newcs}),
						ggd,
						_List_Nil),
					newgd);
			default:
				_v4$4:
				while (true) {
					switch (msg.$) {
						case 'Tick':
							var tick = msg.a;
							var curtime = $elm$time$Time$posixToMillis(tick);
							var newfpsrepo = ($elm$core$List$length(model.fpsrepo) >= 10) ? _Utils_ap(
								A2($elm$core$List$drop, 1, model.fpsrepo),
								_List_fromArray(
									[curtime])) : _Utils_ap(
								model.fpsrepo,
								_List_fromArray(
									[curtime]));
							var addfpsmodel = _Utils_update(
								model,
								{fpsrepo: newfpsrepo});
							var _v5 = A4($author$project$Lib$Component$ComponentHandler$updateComponents, t, msg, gd, model.components);
							var newcs = _v5.a;
							var rmsg = _v5.b;
							var newgd = _v5.c;
							return A4(
								$author$project$Lib$CoreEngine$FrontgroundLayer$Model$dealAllComponentMsg,
								rmsg,
								_Utils_update(
									addfpsmodel,
									{components: newcs}),
								newgd,
								ggd);
						case 'MouseDown':
							if (!msg.a) {
								var _v6 = A6($author$project$Lib$Component$ComponentHandler$updateSingleComponentByName, msg, $author$project$Lib$Component$Base$NullComponentMsg, gd, t, 'Menu', model.components);
								var newcs = _v6.a;
								var newgd = _v6.c;
								return _Utils_Tuple2(
									_Utils_Tuple3(
										_Utils_update(
											model,
											{components: newcs}),
										ggd,
										_List_Nil),
									newgd);
							} else {
								break _v4$4;
							}
						case 'KeyDown':
							if (msg.a === 27) {
								var _v7 = A6(
									$author$project$Lib$Component$ComponentHandler$updateSingleComponentByName,
									$author$project$Base$UnknownMsg,
									$author$project$Lib$Component$Base$ComponentLStringMsg(
										_List_fromArray(
											['Activate', 'NONE'])),
									gd,
									t,
									'Menu',
									model.components);
								var newcs = _v7.a;
								var newgd = _v7.c;
								return _Utils_Tuple2(
									_Utils_Tuple3(
										_Utils_update(
											model,
											{components: newcs}),
										ggd,
										_List_Nil),
									newgd);
							} else {
								var _v8 = A4($author$project$Lib$Component$ComponentHandler$updateComponents, t, msg, gd, model.components);
								var newcs = _v8.a;
								var rmsg = _v8.b;
								var newgd = _v8.c;
								return A4(
									$author$project$Lib$CoreEngine$FrontgroundLayer$Model$dealAllComponentMsg,
									rmsg,
									_Utils_update(
										model,
										{components: newcs}),
									newgd,
									ggd);
							}
						default:
							break _v4$4;
					}
				}
				return _Utils_Tuple2(
					_Utils_Tuple3(model, ggd, _List_Nil),
					gd);
		}
	});
var $author$project$Lib$CoreEngine$FrontgroundLayer$Display$genFPS = F2(
	function (model, gd) {
		var _v0 = function () {
			var _v1 = $elm$core$List$head(model.fpsrepo);
			if (_v1.$ === 'Just') {
				var x = _v1.a;
				var _v2 = $elm$core$List$head(
					$elm$core$List$reverse(model.fpsrepo));
				if (_v2.$ === 'Just') {
					var y = _v2.a;
					return _Utils_Tuple2(x, y);
				} else {
					return _Utils_Tuple2(0, 0);
				}
			} else {
				return _Utils_Tuple2(0, 0);
			}
		}();
		var begin = _v0.a;
		var end = _v0.b;
		var oneframe = (end - begin) / 9;
		var fps = $elm$core$Basics$floor(1000 / oneframe);
		return (!oneframe) ? A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil) : A2(
			$joakin$elm_canvas$Canvas$group,
			_List_fromArray(
				[
					$joakin$elm_canvas$Canvas$Settings$Advanced$alpha(0.3)
				]),
			_List_fromArray(
				[
					A5(
					$author$project$Lib$Render$Render$renderText,
					gd,
					20,
					'FPS:' + $elm$core$String$fromInt(fps),
					'sans-serif',
					_Utils_Tuple2(1850, 0))
				]));
	});
var $elm$core$Elm$JsArray$map = _JsArray_map;
var $elm$core$Array$map = F2(
	function (func, _v0) {
		var len = _v0.a;
		var startShift = _v0.b;
		var tree = _v0.c;
		var tail = _v0.d;
		var helper = function (node) {
			if (node.$ === 'SubTree') {
				var subTree = node.a;
				return $elm$core$Array$SubTree(
					A2($elm$core$Elm$JsArray$map, helper, subTree));
			} else {
				var values = node.a;
				return $elm$core$Array$Leaf(
					A2($elm$core$Elm$JsArray$map, func, values));
			}
		};
		return A4(
			$elm$core$Array$Array_elm_builtin,
			len,
			startShift,
			A2($elm$core$Elm$JsArray$map, helper, tree),
			A2($elm$core$Elm$JsArray$map, func, tail));
	});
var $author$project$Lib$Component$ComponentHandler$genView = F3(
	function (vp, t, xs) {
		return A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			$elm$core$Array$toList(
				A2(
					$elm$core$Array$map,
					function (x) {
						return A2(
							x.view,
							_Utils_Tuple2(x.data, t),
							vp);
					},
					xs)));
	});
var $author$project$Lib$CoreEngine$FrontgroundLayer$Display$view = F3(
	function (_v0, ggd, gd) {
		var model = _v0.a;
		var t = _v0.b;
		return A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			_List_fromArray(
				[
					A2(
					$joakin$elm_canvas$Canvas$shapes,
					_List_fromArray(
						[
							$joakin$elm_canvas$Canvas$Settings$Advanced$alpha(0.3)
						]),
					_List_fromArray(
						[
							A3(
							$joakin$elm_canvas$Canvas$rect,
							_Utils_Tuple2(0, 0),
							A2($author$project$Lib$Coordinate$Coordinates$widthToReal, gd, 200),
							A2($author$project$Lib$Coordinate$Coordinates$heightToReal, gd, 100))
						])),
					(ggd.selectobj > 0) ? A5(
					$author$project$Lib$Render$Render$renderText,
					gd,
					20,
					'Selected:' + $elm$core$String$fromInt(ggd.selectobj),
					'sans-serif',
					_Utils_Tuple2(10, 10)) : A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil),
					A5(
					$author$project$Lib$Render$Render$renderText,
					gd,
					20,
					'Energy:' + $elm$core$String$fromFloat(ggd.energy),
					'sans-serif',
					_Utils_Tuple2(10, 40)),
					A3($author$project$Lib$Component$ComponentHandler$genView, gd, t, model.components),
					A3(model.render, t, ggd, gd),
					A2($author$project$Lib$CoreEngine$FrontgroundLayer$Display$genFPS, model, gd)
				]));
	});
var $author$project$Lib$CoreEngine$FrontgroundLayer$Export$layer = {data: $author$project$Lib$CoreEngine$FrontgroundLayer$Export$nullData, init: $author$project$Lib$CoreEngine$FrontgroundLayer$Model$initModel, update: $author$project$Lib$CoreEngine$FrontgroundLayer$Model$updateModel, view: $author$project$Lib$CoreEngine$FrontgroundLayer$Display$view};
var $author$project$Lib$CoreEngine$GameComponents$Goomba$Model$collisionBox = {height: 50, name: 'col', offsetX: 0, offsetY: 11, width: 60};
var $author$project$Lib$CoreEngine$GameComponents$Goomba$Model$reboundBox = {height: 10, name: 'reb', offsetX: 0, offsetY: 0, width: 60};
var $author$project$Lib$CoreEngine$GameComponents$Goomba$Model$simplecheckBox = {height: 60, name: 'sp', offsetX: 0, offsetY: 0, width: 60};
var $author$project$Lib$CoreEngine$GameComponents$Goomba$Model$initData = {
	acceleration: _Utils_Tuple2(0, -8),
	collisionbox: _List_fromArray(
		[$author$project$Lib$CoreEngine$GameComponents$Goomba$Model$collisionBox, $author$project$Lib$CoreEngine$GameComponents$Goomba$Model$reboundBox]),
	extra: $elm$core$Dict$empty,
	mass: 70,
	position: _Utils_Tuple2(100, 1500),
	simplecheck: $author$project$Lib$CoreEngine$GameComponents$Goomba$Model$simplecheckBox,
	status: $author$project$Lib$CoreEngine$GameComponent$Base$Alive,
	uid: 2,
	velocity: _Utils_Tuple2(0, 0)
};
var $author$project$Lib$CoreEngine$GameComponents$Goomba$Model$initModel = F2(
	function (_v0, gcm) {
		if (gcm.$ === 'GameGoombaInit') {
			var info = gcm.a;
			return {
				acceleration: _Utils_Tuple2(0, -8),
				collisionbox: _List_fromArray(
					[$author$project$Lib$CoreEngine$GameComponents$Goomba$Model$collisionBox, $author$project$Lib$CoreEngine$GameComponents$Goomba$Model$reboundBox]),
				extra: $elm$core$Dict$empty,
				mass: 70,
				position: info.initPosition,
				simplecheck: $author$project$Lib$CoreEngine$GameComponents$Goomba$Model$simplecheckBox,
				status: $author$project$Lib$CoreEngine$GameComponent$Base$Alive,
				uid: info.uid,
				velocity: info.initVelocity
			};
		} else {
			return $author$project$Lib$CoreEngine$GameComponents$Goomba$Model$initData;
		}
	});
var $author$project$Lib$CoreEngine$GameComponents$Goomba$Movement$checkCollision = F2(
	function (ggd, d) {
		var _v0 = d.velocity;
		var vx = _v0.a;
		var vy = _v0.b;
		var _v1 = (((vx < 0) && (!A3(
			$author$project$Lib$CoreEngine$Physics$SolidCollision$canMove,
			d,
			ggd,
			A2($elm_explorations$linear_algebra$Math$Vector2$vec2, -1, 0)))) || ((vx > 0) && (!A3(
			$author$project$Lib$CoreEngine$Physics$SolidCollision$canMove,
			d,
			ggd,
			A2($elm_explorations$linear_algebra$Math$Vector2$vec2, 1, 0))))) ? _Utils_Tuple2(-vx, vy) : _Utils_Tuple2(vx, vy);
		var newvx = _v1.a;
		var newvy = _v1.b;
		var newnewv = A2($author$project$Lib$CoreEngine$Physics$Ground$isOnground, d, ggd) ? ((newvx >= 0) ? _Utils_Tuple2(50, newvy) : _Utils_Tuple2(-50, newvy)) : _Utils_Tuple2(newvx / 1.001, newvy);
		return _Utils_update(
			d,
			{velocity: newnewv});
	});
var $author$project$Lib$CoreEngine$GameComponents$Goomba$Movement$solidCollisionMove = F3(
	function (ls, ggd, d) {
		var moved = A2(
			$author$project$Lib$CoreEngine$Physics$SolidCollision$moveTilCollide,
			d,
			A2($author$project$Lib$CoreEngine$Physics$SolidCollision$getNearBySolid, ggd, d));
		var _v0 = d.velocity;
		var pvx = _v0.a;
		var pvy = _v0.b;
		var newvel = function () {
			var _v1 = A2($author$project$Lib$CoreEngine$Physics$CollisionShape$judgeShape, d, ls);
			switch (_v1.$) {
				case 'CTOP':
					return _Utils_Tuple2(pvx, 0);
				case 'CBOTTOM':
					return _Utils_Tuple2(pvx, 0);
				case 'CRIGHT':
					return _Utils_Tuple2(-50, pvy);
				case 'CLEFT':
					return _Utils_Tuple2(50, pvy);
				case 'CBOTTOMLEFT':
					return _Utils_Tuple2(0, 0);
				case 'CBOTTOMRIGHT':
					return _Utils_Tuple2(0, 0);
				case 'CTOPLEFT':
					return _Utils_Tuple2(0, 0);
				case 'CTOPRIGHT':
					return _Utils_Tuple2(0, 0);
				default:
					return _Utils_Tuple2(0, 0);
			}
		}();
		return _Utils_update(
			moved,
			{velocity: newvel});
	});
var $author$project$Lib$CoreEngine$GameComponents$Goomba$Model$updateModel = F5(
	function (msg, gct, ggd, gd, _v0) {
		var d = _v0.a;
		var t = _v0.b;
		_v1$2:
		while (true) {
			switch (msg.$) {
				case 'Tick':
					if (gct.$ === 'GameSolidCollisionMsg') {
						var cs = gct.a;
						var afterAccD = $author$project$Lib$CoreEngine$Physics$Acceleration$putAccOn(d);
						var afterSolidCollisionD = $author$project$Lib$CoreEngine$GameComponent$ComponentHandler$isAlive(d) ? A3($author$project$Lib$CoreEngine$GameComponents$Goomba$Movement$solidCollisionMove, cs, ggd, afterAccD) : afterAccD;
						return _Utils_Tuple3(afterSolidCollisionD, _List_Nil, ggd);
					} else {
						var afterAccD = $author$project$Lib$CoreEngine$Physics$Acceleration$putAccOn(d);
						var afterCheckCD = $author$project$Lib$CoreEngine$GameComponent$ComponentHandler$isAlive(d) ? A2($author$project$Lib$CoreEngine$GameComponents$Goomba$Movement$checkCollision, ggd, afterAccD) : afterAccD;
						return _Utils_Tuple3(afterCheckCD, _List_Nil, ggd);
					}
				case 'MouseDown':
					if (!msg.a) {
						var mp = msg.b;
						return A4(
							$author$project$Lib$Coordinate$Coordinates$judgeMouse,
							gd,
							mp,
							A2($author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera, d.position, ggd),
							_Utils_Tuple2(d.simplecheck.width, d.simplecheck.height)) ? _Utils_Tuple3(
							d,
							_List_Nil,
							_Utils_update(
								ggd,
								{selectobj: d.uid})) : _Utils_Tuple3(d, _List_Nil, ggd);
					} else {
						break _v1$2;
					}
				default:
					break _v1$2;
			}
		}
		_v3$3:
		while (true) {
			switch (gct.$) {
				case 'GameClearVelocity':
					return _Utils_Tuple3(
						_Utils_update(
							d,
							{
								velocity: _Utils_Tuple2(0, 0)
							}),
						_List_Nil,
						ggd);
				case 'GameUseEnergy':
					var mp = gct.a;
					var e = gct.b;
					var ndd = A3($author$project$Lib$CoreEngine$Physics$Velocity$changeCVel, d, mp, e);
					return _Utils_Tuple3(ndd, _List_Nil, ggd);
				case 'GameStringMsg':
					if (gct.a === 'die') {
						return _Utils_Tuple3(
							_Utils_update(
								d,
								{
									status: $author$project$Lib$CoreEngine$GameComponent$Base$Dead(t)
								}),
							_List_Nil,
							ggd);
					} else {
						break _v3$3;
					}
				default:
					break _v3$3;
			}
		}
		return _Utils_Tuple3(d, _List_Nil, ggd);
	});
var $elm$core$Basics$pi = _Basics_pi;
var $elm$core$Basics$degrees = function (angleInDegrees) {
	return (angleInDegrees * $elm$core$Basics$pi) / 180;
};
var $joakin$elm_canvas$Canvas$Settings$Advanced$Rotate = function (a) {
	return {$: 'Rotate', a: a};
};
var $joakin$elm_canvas$Canvas$Settings$Advanced$rotate = $joakin$elm_canvas$Canvas$Settings$Advanced$Rotate;
var $author$project$Lib$CoreEngine$GameComponents$Goomba$Display$view = F3(
	function (_v0, ggd, gd) {
		var d = _v0.a;
		var t = _v0.b;
		return _List_fromArray(
			[
				_Utils_Tuple2(
				A2(
					$joakin$elm_canvas$Canvas$group,
					_List_Nil,
					_List_fromArray(
						[
							A5(
							$author$project$Lib$Render$Render$renderSprite,
							gd,
							_List_fromArray(
								[
									$joakin$elm_canvas$Canvas$Settings$Advanced$alpha(
									_Utils_eq(ggd.selectobj, d.uid) ? 1 : 0.5),
									$joakin$elm_canvas$Canvas$Settings$Advanced$transform(
									function () {
										var _v1 = d.status;
										if (_v1.$ === 'Dead') {
											var kd = _v1.a;
											return _List_fromArray(
												[
													$joakin$elm_canvas$Canvas$Settings$Advanced$rotate(
													$elm$core$Basics$degrees(t - kd))
												]);
										} else {
											return _List_Nil;
										}
									}())
								]),
							A2($author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera, d.position, ggd),
							_Utils_Tuple2(d.simplecheck.width, d.simplecheck.height),
							'background'),
							A5(
							$author$project$Lib$Render$Render$renderText,
							gd,
							20,
							$elm$core$String$fromFloat(d.velocity.a),
							'sans-serif',
							A2($author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera, d.position, ggd))
						])),
				0)
			]);
	});
var $author$project$Lib$CoreEngine$GameComponents$Goomba$Export$gameComponent = {data: $author$project$Lib$CoreEngine$GameComponents$Goomba$Model$initData, init: $author$project$Lib$CoreEngine$GameComponents$Goomba$Model$initModel, name: 'goomba', update: $author$project$Lib$CoreEngine$GameComponents$Goomba$Model$updateModel, view: $author$project$Lib$CoreEngine$GameComponents$Goomba$Display$view};
var $author$project$Lib$CoreEngine$GameLayer$Model$initModel = F3(
	function (_v0, lm, _v1) {
		if (lm.$ === 'LayerInitGameLayer') {
			var info = lm.a;
			return {actors: info.actors, chartlets: info.chartlets, ignoreInput: false, lastuseEnergyTime: 0, player: info.player};
		} else {
			return {
				actors: $elm$core$Array$fromList(
					_List_fromArray(
						[$author$project$Lib$CoreEngine$GameComponents$Goomba$Export$gameComponent])),
				chartlets: _List_Nil,
				ignoreInput: false,
				lastuseEnergyTime: 0,
				player: $author$project$Lib$CoreEngine$GameComponents$Player$Export$gameComponent
			};
		}
	});
var $author$project$Lib$CoreEngine$GameComponent$Base$GameClearVelocity = {$: 'GameClearVelocity'};
var $author$project$Lib$CoreEngine$GameComponent$Base$GameUseEnergy = F2(
	function (a, b) {
		return {$: 'GameUseEnergy', a: a, b: b};
	});
var $author$project$Lib$CoreEngine$GameComponent$Base$NullGameComponentMsg = {$: 'NullGameComponentMsg'};
var $author$project$Lib$CoreEngine$GameLayer$Model$clearWrongVelocity = F2(
	function (ggd, gcs) {
		return A2(
			$elm$core$Array$map,
			function (gc) {
				var player = gc.data;
				var _v0 = gc.data.velocity;
				var pvx = _v0.a;
				var pvy = _v0.b;
				var _v1 = ((pvy < 0) && (!A3(
					$author$project$Lib$CoreEngine$Physics$SolidCollision$canMove,
					player,
					ggd,
					A2($elm_explorations$linear_algebra$Math$Vector2$vec2, 0, -1)))) ? _Utils_Tuple2(pvx, 0) : (((pvy > 0) && (!A3(
					$author$project$Lib$CoreEngine$Physics$SolidCollision$canMove,
					player,
					ggd,
					A2($elm_explorations$linear_algebra$Math$Vector2$vec2, 0, 1)))) ? _Utils_Tuple2(pvx, 0) : _Utils_Tuple2(pvx, pvy));
				var npvx = _v1.a;
				var npvy = _v1.b;
				var fv = ((npvx < 0) && (!A3(
					$author$project$Lib$CoreEngine$Physics$SolidCollision$canMove,
					player,
					ggd,
					A2($elm_explorations$linear_algebra$Math$Vector2$vec2, -1, 0)))) ? _Utils_Tuple2(0, npvy) : (((npvx > 0) && (!A3(
					$author$project$Lib$CoreEngine$Physics$SolidCollision$canMove,
					player,
					ggd,
					A2($elm_explorations$linear_algebra$Math$Vector2$vec2, 1, 0)))) ? _Utils_Tuple2(0, npvy) : _Utils_Tuple2(npvx, npvy));
				var newdata = _Utils_update(
					player,
					{velocity: fv});
				return $author$project$Lib$CoreEngine$GameComponent$ComponentHandler$isAlive(gc.data) ? _Utils_update(
					gc,
					{data: newdata}) : gc;
			},
			gcs);
	});
var $author$project$Lib$CoreEngine$GameComponent$Base$GameGoombaInit = function (a) {
	return {$: 'GameGoombaInit', a: a};
};
var $author$project$Lib$Layer$Base$LayerRestartMsg = {$: 'LayerRestartMsg'};
var $elm$core$List$maximum = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(
			A3($elm$core$List$foldl, $elm$core$Basics$max, x, xs));
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $author$project$Lib$CoreEngine$GameComponent$GenUID$genUID = function (model) {
	var actorsUID = A2(
		$elm$core$Array$map,
		function (x) {
			return x.data.uid;
		},
		model.actors);
	var _v0 = $elm$core$List$maximum(
		$elm$core$Array$toList(actorsUID));
	if (_v0.$ === 'Just') {
		var x = _v0.a;
		return x + 1;
	} else {
		return 99999;
	}
};
var $author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent = F3(
	function (t, gct, gc) {
		return _Utils_update(
			gc,
			{
				data: A2(gc.init, t, gct)
			});
	});
var $author$project$Lib$CoreEngine$GameLayer$Model$dealParentMsg = F4(
	function (gct, gd, _v0, ggd) {
		var model = _v0.a;
		var t = _v0.b;
		_v1$5:
		while (true) {
			switch (gct.$) {
				case 'GameExitScene':
					var s = gct.a;
					return _Utils_Tuple2(
						_Utils_Tuple3(
							model,
							_Utils_update(
								ggd,
								{ingamepause: true}),
							_List_fromArray(
								[
									_Utils_Tuple2(
									$author$project$Lib$Layer$Base$LayerName('Frontground'),
									A2(
										$author$project$Lib$Layer$Base$LayerExitMsg,
										A2($author$project$Lib$Scene$Base$EngineT, 0, $author$project$Lib$Scene$Base$DefaultPlayerPosition),
										s))
								])),
						gd);
				case 'GameStringMsg':
					switch (gct.a) {
						case 'restart':
							return _Utils_Tuple2(
								_Utils_Tuple3(
									model,
									_Utils_update(
										ggd,
										{ingamepause: true}),
									_List_fromArray(
										[
											_Utils_Tuple2(
											$author$project$Lib$Layer$Base$LayerName('Frontground'),
											$author$project$Lib$Layer$Base$LayerRestartMsg)
										])),
								gd);
						case 'ignoreinput':
							return _Utils_Tuple2(
								_Utils_Tuple3(
									_Utils_update(
										model,
										{ignoreInput: true}),
									ggd,
									_List_Nil),
								gd);
						case 'reactinput':
							return _Utils_Tuple2(
								_Utils_Tuple3(
									_Utils_update(
										model,
										{ignoreInput: false}),
									ggd,
									_List_Nil),
								gd);
						default:
							break _v1$5;
					}
				case 'GameGoombaInit':
					var info = gct.a;
					var newinfo = _Utils_update(
						info,
						{
							uid: $author$project$Lib$CoreEngine$GameComponent$GenUID$genUID(model)
						});
					return _Utils_Tuple2(
						_Utils_Tuple3(
							_Utils_update(
								model,
								{
									actors: A2(
										$elm$core$Array$push,
										A3(
											$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
											t,
											$author$project$Lib$CoreEngine$GameComponent$Base$GameGoombaInit(newinfo),
											$author$project$Lib$CoreEngine$GameComponents$Goomba$Export$gameComponent),
										model.actors)
								}),
							ggd,
							_List_Nil),
						gd);
				default:
					break _v1$5;
			}
		}
		return _Utils_Tuple2(
			_Utils_Tuple3(model, ggd, _List_Nil),
			gd);
	});
var $elm$core$Array$filter = F2(
	function (isGood, array) {
		return $elm$core$Array$fromList(
			A3(
				$elm$core$Array$foldr,
				F2(
					function (x, xs) {
						return isGood(x) ? A2($elm$core$List$cons, x, xs) : xs;
					}),
				_List_Nil,
				array));
	});
var $author$project$Lib$CoreEngine$Physics$Vector$addIntVec = F2(
	function (_v0, _v1) {
		var a = _v0.a;
		var b = _v0.b;
		var c = _v1.a;
		var d = _v1.b;
		return _Utils_Tuple2(a + c, b + d);
	});
var $author$project$Lib$CoreEngine$Physics$NaiveCollision$judgeInCamera = F2(
	function (gc, ggd) {
		var gcd = gc.data;
		var gcsc = gcd.simplecheck;
		var cpos = ggd.camera.position;
		var cposrb = A2(
			$author$project$Lib$CoreEngine$Physics$Vector$addIntVec,
			cpos,
			_Utils_Tuple2(1919, 1079));
		var _v0 = gcd.position;
		var op1x = _v0.a;
		var op1y = _v0.b;
		var p1x = op1x + gcsc.offsetX;
		var p2x = (op1x + gcsc.width) - 1;
		var p1y = op1y + gcsc.offsetY;
		var p2y = (op1y + gcsc.height) - 1;
		return A2(
			$author$project$Lib$CoreEngine$Physics$NaiveCollision$judgeCollision,
			_Utils_Tuple2(
				_Utils_Tuple2(p1x, p1y),
				_Utils_Tuple2(p2x, p2y)),
			_Utils_Tuple2(cpos, cposrb));
	});
var $author$project$Lib$CoreEngine$GameLayer$Model$deleteObjects = F2(
	function (ggd, gcs) {
		return A2(
			$elm$core$Array$filter,
			function (x) {
				var _v0 = x.data.status;
				if (_v0.$ === 'Alive') {
					return true;
				} else {
					return A2($author$project$Lib$CoreEngine$Physics$NaiveCollision$judgeInCamera, x, ggd) ? true : false;
				}
			},
			gcs);
	});
var $author$project$Lib$Coordinate$Coordinates$fromMouseToReal = F2(
	function (gd, _v0) {
		var px = _v0.a;
		var py = _v0.b;
		return _Utils_Tuple2(px - gd.startLeft, py - gd.startTop);
	});
var $author$project$Lib$CoreEngine$GameLayer$Model$calcDRate = F3(
	function (p1, p2, _v0) {
		var w = _v0.a;
		var h = _v0.b;
		var _v1 = p2;
		var p2X = _v1.a;
		var p2Y = _v1.b;
		var _v2 = p1;
		var p1X = _v2.a;
		var p1Y = _v2.b;
		var k = (p2X - p1X) / (p2Y - p1Y);
		var k1 = p1X / (p1Y - h);
		var k2 = (w - p1X) / (h - p1Y);
		var k3 = p1X / p1Y;
		var k4 = (p1X - w) / p1Y;
		return ((_Utils_cmp(p2Y, p1Y) > 0) && ((_Utils_cmp(k, k1) > -1) && (_Utils_cmp(k, k2) < 1))) ? (1 - ((h - p2Y) / (h - p1Y))) : (((_Utils_cmp(p2Y, p1Y) < 0) && ((_Utils_cmp(k, k4) > -1) && (_Utils_cmp(k, k3) < 1))) ? (1 - (p2Y / p1Y)) : ((((_Utils_cmp(p2X, p1X) < 0) && (_Utils_cmp(k, k1) < 0)) || (_Utils_cmp(k, k3) > 0)) ? (1 - (p2X / p1X)) : ((((_Utils_cmp(p2X, p1X) > 0) && (_Utils_cmp(k, k4) < 0)) || (_Utils_cmp(k, k2) > 0)) ? (1 - ((w - p2X) / (w - p1X))) : 0)));
	});
var $author$project$Lib$CoreEngine$GameLayer$Model$calcRPer = F3(
	function (_v0, _v1, gd) {
		var px = _v0.a;
		var py = _v0.b;
		var mx = _v1.a;
		var my = _v1.b;
		var ds = A3(
			$author$project$Lib$CoreEngine$GameLayer$Model$calcDRate,
			_Utils_Tuple2(px, py),
			_Utils_Tuple2(mx, my),
			_Utils_Tuple2(gd.realWidth, gd.realHeight));
		return (ds > 0.9) ? 1 : ds;
	});
var $author$project$Lib$CoreEngine$GameLayer$Model$getDSEnergy = F4(
	function (p, m, gd, ggd) {
		var pc = A3($author$project$Lib$CoreEngine$GameLayer$Model$calcRPer, p, m, gd);
		var curenergy = ggd.energy;
		var gpc = curenergy * pc;
		return (pc < 0.2) ? _Utils_Tuple2(0, ggd) : ((pc >= 1) ? _Utils_Tuple2(
			curenergy,
			_Utils_update(
				ggd,
				{energy: 0})) : _Utils_Tuple2(
			gpc,
			_Utils_update(
				ggd,
				{energy: curenergy - gpc})));
	});
var $author$project$Lib$CoreEngine$GameComponent$ComponentHandler$getGameComponentCenter = function (gc) {
	var d = gc.data;
	var _v0 = A2($author$project$Lib$CoreEngine$Physics$NaiveCollision$getBoxPos, d.position, d.simplecheck);
	var _v1 = _v0.a;
	var x1 = _v1.a;
	var y1 = _v1.b;
	var _v2 = _v0.b;
	var x2 = _v2.a;
	var y2 = _v2.b;
	var cx = (x1 + x2) / 2;
	var cy = (y1 + y2) / 2;
	return _Utils_Tuple2(
		$elm$core$Basics$floor(cx),
		$elm$core$Basics$floor(cy));
};
var $author$project$Lib$CoreEngine$Camera$Camera$cameraHeight = 1080;
var $author$project$Lib$CoreEngine$Camera$Camera$cameraWidth = 1920;
var $author$project$Lib$CoreEngine$Camera$Camera$getCameraInbox = function (ggd) {
	var _v0 = ggd.camera.inbox;
	var _v1 = _v0.a;
	var r1 = _v1.a;
	var r2 = _v1.b;
	var _v2 = _v0.b;
	var r3 = _v2.a;
	var r4 = _v2.b;
	var _v3 = ggd.camera.position;
	var cx = _v3.a;
	var cy = _v3.b;
	var crx = cx;
	var cry = cy;
	var p = _Utils_Tuple2(
		$elm$core$Basics$floor(crx + (r1 * $author$project$Lib$CoreEngine$Camera$Camera$cameraWidth)),
		$elm$core$Basics$floor(cry + (r2 * $author$project$Lib$CoreEngine$Camera$Camera$cameraHeight)));
	var q = _Utils_Tuple2(
		$elm$core$Basics$floor(crx + (r3 * $author$project$Lib$CoreEngine$Camera$Camera$cameraWidth)),
		$elm$core$Basics$floor(cry + (r4 * $author$project$Lib$CoreEngine$Camera$Camera$cameraHeight)));
	return _Utils_Tuple2(p, q);
};
var $author$project$Lib$CoreEngine$Camera$Camera$getCameraInboxCenter = function (ggd) {
	var _v0 = $author$project$Lib$CoreEngine$Camera$Camera$getCameraInbox(ggd);
	var _v1 = _v0.a;
	var cx1 = _v1.a;
	var cy1 = _v1.b;
	var _v2 = _v0.b;
	var cx2 = _v2.a;
	var cy2 = _v2.b;
	var vx = (cx1 + cx2) / 2;
	var vy = (cy1 + cy2) / 2;
	return A2($elm_explorations$linear_algebra$Math$Vector2$vec2, vx, vy);
};
var $author$project$Lib$CoreEngine$Camera$Camera$getPlayerCenter = function (d) {
	var _v0 = A2($author$project$Lib$CoreEngine$Physics$NaiveCollision$getBoxPos, d.position, d.simplecheck);
	var _v1 = _v0.a;
	var x1 = _v1.a;
	var y1 = _v1.b;
	var _v2 = _v0.b;
	var x2 = _v2.a;
	var y2 = _v2.b;
	var cx = (x1 + x2) / 2;
	var cy = (y1 + y2) / 2;
	return A2($elm_explorations$linear_algebra$Math$Vector2$vec2, cx, cy);
};
var $elm_explorations$linear_algebra$Math$Vector2$length = _MJS_v2length;
var $elm_explorations$linear_algebra$Math$Vector2$sub = _MJS_v2sub;
var $author$project$Lib$CoreEngine$Camera$Camera$calcMoveVec = F2(
	function (ggd, d) {
		var cp = $author$project$Lib$CoreEngine$Camera$Camera$getPlayerCenter(d);
		var cc = $author$project$Lib$CoreEngine$Camera$Camera$getCameraInboxCenter(ggd);
		var subv = A2($elm_explorations$linear_algebra$Math$Vector2$sub, cp, cc);
		var subvl = $elm_explorations$linear_algebra$Math$Vector2$length(subv);
		var subvlf = (subvl > 700) ? subvl : ((subvl > 500) ? (subvl * 2) : subvl);
		var velc = A2($elm_explorations$linear_algebra$Math$Vector2$scale, 0.0001 * subvlf, subv);
		return _Utils_Tuple2(
			$elm_explorations$linear_algebra$Math$Vector2$getX(velc),
			$elm_explorations$linear_algebra$Math$Vector2$getY(velc));
	});
var $author$project$Lib$CoreEngine$Camera$Camera$dealInboundSpeed = function (ggd) {
	var _v0 = ggd.camera.velocity;
	var vx = _v0.a;
	var vy = _v0.b;
	var v = A2($elm_explorations$linear_algebra$Math$Vector2$vec2, vx, vy);
	return (($elm_explorations$linear_algebra$Math$Vector2$length(v) < 6) || (($elm$core$Basics$abs(vx) < 1) || ($elm$core$Basics$abs(vy) < 1))) ? _Utils_Tuple2(0, 0) : (($elm_explorations$linear_algebra$Math$Vector2$length(v) < 10) ? _Utils_Tuple2(vx / 10, vy / 10) : _Utils_Tuple2(vx / 10, vy / 10));
};
var $author$project$Lib$CoreEngine$Camera$Camera$judgeInBox = F2(
	function (ggd, d) {
		var _v0 = A2($author$project$Lib$CoreEngine$Physics$NaiveCollision$getBoxPos, d.position, d.simplecheck);
		var _v1 = _v0.a;
		var x1 = _v1.a;
		var y1 = _v1.b;
		var _v2 = _v0.b;
		var x2 = _v2.a;
		var y2 = _v2.b;
		var _v3 = $author$project$Lib$CoreEngine$Camera$Camera$getCameraInbox(ggd);
		var _v4 = _v3.a;
		var ix1 = _v4.a;
		var iy1 = _v4.b;
		var _v5 = _v3.b;
		var ix2 = _v5.a;
		var iy2 = _v5.b;
		return ((_Utils_cmp(x1, ix1) > 0) && ((_Utils_cmp(x2, ix2) < 0) && ((_Utils_cmp(y1, iy1) > 0) && (_Utils_cmp(y2, iy2) < 0)))) ? true : false;
	});
var $author$project$Lib$CoreEngine$Camera$Camera$changeCP = F2(
	function (c, q) {
		return _Utils_update(
			c,
			{position: q});
	});
var $author$project$Lib$CoreEngine$Camera$Camera$judgeInBound = function (ggd) {
	var _v0 = ggd.camera.visible;
	var _v1 = _v0.a;
	var lpx1 = _v1.a;
	var lpy1 = _v1.b;
	var _v2 = _v0.b;
	var mapw = _v2.a;
	var maph = _v2.b;
	var _v3 = ggd.camera.position;
	var cx = _v3.a;
	var cy = _v3.b;
	var _v4 = _Utils_Tuple2((cx + $author$project$Lib$CoreEngine$Camera$Camera$cameraWidth) - 1, (cy + $author$project$Lib$CoreEngine$Camera$Camera$cameraHeight) - 1);
	var cx2 = _v4.a;
	var cy2 = _v4.b;
	if ((_Utils_cmp(cx, lpx1) > -1) && ((_Utils_cmp(cy, lpy1) > -1) && ((_Utils_cmp(cx2, mapw) < 1) && (_Utils_cmp(cy2, maph) < 1)))) {
		return ggd.camera;
	} else {
		var horizonD = (_Utils_cmp(cx, lpx1) < 0) ? A2(
			$author$project$Lib$CoreEngine$Camera$Camera$changeCP,
			ggd.camera,
			_Utils_Tuple2(lpx1, cy)) : ((_Utils_cmp(cx2, mapw) > 0) ? A2(
			$author$project$Lib$CoreEngine$Camera$Camera$changeCP,
			ggd.camera,
			_Utils_Tuple2((mapw - $author$project$Lib$CoreEngine$Camera$Camera$cameraWidth) + 1, cy)) : ggd.camera);
		var _v5 = horizonD.position;
		var ncx = _v5.a;
		var verticalD = (_Utils_cmp(cy, lpy1) < 0) ? A2(
			$author$project$Lib$CoreEngine$Camera$Camera$changeCP,
			horizonD,
			_Utils_Tuple2(ncx, 0)) : ((_Utils_cmp(cy2, maph) > 0) ? A2(
			$author$project$Lib$CoreEngine$Camera$Camera$changeCP,
			horizonD,
			_Utils_Tuple2(ncx, (maph - $author$project$Lib$CoreEngine$Camera$Camera$cameraHeight) + 1)) : horizonD);
		return verticalD;
	}
};
var $author$project$Lib$CoreEngine$Camera$Camera$moveCamera = function (ggd) {
	var c = ggd.camera;
	var _v0 = ggd.camera.velocity;
	var vx = _v0.a;
	var vy = _v0.b;
	var rv = A2($elm_explorations$linear_algebra$Math$Vector2$vec2, vx, vy);
	var newv = ($elm_explorations$linear_algebra$Math$Vector2$length(rv) > 1000) ? _Utils_Tuple2(0, 0) : _Utils_Tuple2(vx, vy);
	var _v1 = ggd.camera.position;
	var px = _v1.a;
	var py = _v1.b;
	var _v2 = ($elm_explorations$linear_algebra$Math$Vector2$length(rv) < 3) ? _Utils_Tuple2(px, py) : _Utils_Tuple2(
		px + $elm$core$Basics$floor(vx),
		py + $elm$core$Basics$floor(vy));
	var npx = _v2.a;
	var npy = _v2.b;
	var movex = _Utils_update(
		c,
		{
			position: _Utils_Tuple2(npx, py),
			velocity: newv
		});
	var newggd = _Utils_update(
		ggd,
		{camera: movex});
	var dkd = $author$project$Lib$CoreEngine$Camera$Camera$judgeInBound(newggd);
	var _v3 = dkd.position;
	var newdx = _v3.a;
	var movey = _Utils_update(
		dkd,
		{
			position: _Utils_Tuple2(newdx, npy)
		});
	var ffggd = _Utils_update(
		newggd,
		{camera: movey});
	return $author$project$Lib$CoreEngine$Camera$Camera$judgeInBound(ffggd);
};
var $author$project$Lib$CoreEngine$Camera$Camera$getNewCamera = F2(
	function (ggd, d) {
		var newv = A2($author$project$Lib$CoreEngine$Camera$Camera$judgeInBox, ggd, d) ? $author$project$Lib$CoreEngine$Camera$Camera$dealInboundSpeed(ggd) : A2($author$project$Lib$CoreEngine$Camera$Camera$calcMoveVec, ggd, d);
		var cd = ggd.camera;
		var newc = _Utils_update(
			cd,
			{velocity: newv});
		var newd = _Utils_update(
			ggd,
			{camera: newc});
		return $author$project$Lib$CoreEngine$Camera$Camera$moveCamera(newd);
	});
var $author$project$Lib$CoreEngine$GameComponent$Base$GameInterCollisionMsg = F3(
	function (a, b, c) {
		return {$: 'GameInterCollisionMsg', a: a, b: b, c: c};
	});
var $author$project$Lib$CoreEngine$Physics$InterCollision$genInterFromOneSide = F2(
	function (gc1, gc2) {
		var tp = gc2.data.position;
		var target = gc2.data.collisionbox;
		var origin = gc1.data.collisionbox;
		var op = gc1.data.position;
		return A3(
			$author$project$Lib$CoreEngine$GameComponent$Base$GameInterCollisionMsg,
			gc2.name,
			gc2.data,
			A3(
				$elm$core$List$foldl,
				F2(
					function (x, o) {
						return _Utils_ap(
							o,
							A2(
								$elm$core$List$filter,
								function (y) {
									return A2(
										$author$project$Lib$CoreEngine$Physics$NaiveCollision$judgeCollision,
										A2($author$project$Lib$CoreEngine$Physics$NaiveCollision$getBoxPos, op, x),
										A2($author$project$Lib$CoreEngine$Physics$NaiveCollision$getBoxPos, tp, y));
								},
								target));
					}),
				_List_Nil,
				origin));
	});
var $author$project$Lib$CoreEngine$Physics$InterCollision$gonnaInterColllide = F2(
	function (gc1, gc2) {
		var sp2 = gc2.data.simplecheck;
		var sp1 = gc1.data.simplecheck;
		var op2 = gc2.data.position;
		var op1 = gc1.data.position;
		return A2(
			$author$project$Lib$CoreEngine$Physics$NaiveCollision$judgeCollision,
			A2($author$project$Lib$CoreEngine$Physics$NaiveCollision$getBoxPos, op1, sp1),
			A2($author$project$Lib$CoreEngine$Physics$NaiveCollision$getBoxPos, op2, sp2)) ? _Utils_Tuple2(
			A2($author$project$Lib$CoreEngine$Physics$InterCollision$genInterFromOneSide, gc1, gc2),
			A2($author$project$Lib$CoreEngine$Physics$InterCollision$genInterFromOneSide, gc2, gc1)) : _Utils_Tuple2($author$project$Lib$CoreEngine$GameComponent$Base$NullGameComponentMsg, $author$project$Lib$CoreEngine$GameComponent$Base$NullGameComponentMsg);
	});
var $elm$core$Array$repeat = F2(
	function (n, e) {
		return A2(
			$elm$core$Array$initialize,
			n,
			function (_v0) {
				return e;
			});
	});
var $author$project$Lib$CoreEngine$GameComponent$ComponentHandler$updateOneGameComponent = F6(
	function (msg, ct, ggd, gd, t, c) {
		var _v0 = A5(
			c.update,
			msg,
			ct,
			ggd,
			gd,
			_Utils_Tuple2(c.data, t));
		var newx = _v0.a;
		var newmsg = _v0.b;
		var newggd = _v0.c;
		return _Utils_Tuple3(
			_Utils_update(
				c,
				{data: newx}),
			newmsg,
			newggd);
	});
var $elm_community$array_extra$Array$Extra$map2 = F3(
	function (combineAb, aArray, bArray) {
		return $elm$core$Array$fromList(
			A3(
				$elm$core$List$map2,
				combineAb,
				$elm$core$Array$toList(aArray),
				$elm$core$Array$toList(bArray)));
	});
var $elm_community$array_extra$Array$Extra$zip = $elm_community$array_extra$Array$Extra$map2($elm$core$Tuple$pair);
var $author$project$Lib$CoreEngine$GameLayer$Model$interCollision = F5(
	function (_v0, t, ggd, gd, gcs) {
		var elenum = $elm$core$Array$length(gcs);
		var is = A2($elm$core$List$range, 0, elenum - 1);
		var blc = A2($elm$core$Array$repeat, elenum, _List_Nil);
		var msggcs = A2($elm_community$array_extra$Array$Extra$zip, gcs, blc);
		var newc = A3(
			$elm$core$List$foldl,
			F2(
				function (i, ms) {
					var js = A2($elm$core$List$range, i + 1, elenum - 1);
					return A3(
						$elm$core$List$foldl,
						F2(
							function (j, mms) {
								var gcj = A2($elm$core$Array$get, j, mms);
								var gci = A2($elm$core$Array$get, i, mms);
								var _v7 = _Utils_Tuple2(gci, gcj);
								if ((_v7.a.$ === 'Just') && (_v7.b.$ === 'Just')) {
									var _v8 = _v7.a.a;
									var gc1 = _v8.a;
									var gc1msg = _v8.b;
									var _v9 = _v7.b.a;
									var gc2 = _v9.a;
									var gc2msg = _v9.b;
									if ($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$isAlive(gc1.data) && $author$project$Lib$CoreEngine$GameComponent$ComponentHandler$isAlive(gc2.data)) {
										var _v10 = A2($author$project$Lib$CoreEngine$Physics$InterCollision$gonnaInterColllide, gc1, gc2);
										var am1 = _v10.a;
										var am2 = _v10.b;
										var _v11 = function () {
											var _v12 = _Utils_Tuple2(am1, am2);
											if ((_v12.a.$ === 'NullGameComponentMsg') && (_v12.b.$ === 'NullGameComponentMsg')) {
												var _v13 = _v12.a;
												var _v14 = _v12.b;
												return _Utils_Tuple2(
													_Utils_Tuple2(gc1, gc1msg),
													_Utils_Tuple2(gc2, gc2msg));
											} else {
												return _Utils_Tuple2(
													_Utils_Tuple2(
														gc1,
														A2($elm$core$List$cons, am1, gc1msg)),
													_Utils_Tuple2(
														gc2,
														A2($elm$core$List$cons, am2, gc2msg)));
											}
										}();
										var ud1 = _v11.a;
										var ud2 = _v11.b;
										return A3(
											$elm$core$Array$set,
											j,
											ud2,
											A3($elm$core$Array$set, i, ud1, mms));
									} else {
										return mms;
									}
								} else {
									return mms;
								}
							}),
						ms,
						js);
				}),
			msggcs,
			is);
		var _v1 = A3(
			$elm$core$Array$foldl,
			F2(
				function (_v2, _v3) {
					var gc = _v2.a;
					var gcm = _v2.b;
					var bgc = _v3.a;
					var bgmsg = _v3.b;
					var cggd = _v3.c;
					var _v4 = A3(
						$elm$core$List$foldl,
						F2(
							function (cmsg, _v5) {
								var ccc = _v5.a;
								var mmm = _v5.b;
								var ggg = _v5.c;
								var _v6 = A6($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$updateOneGameComponent, $author$project$Base$UnknownMsg, cmsg, ggg, gd, t, ccc);
								var updgc = _v6.a;
								var updmsg = _v6.b;
								var updggg = _v6.c;
								return _Utils_Tuple3(
									updgc,
									_Utils_ap(updmsg, mmm),
									updggg);
							}),
						_Utils_Tuple3(gc, _List_Nil, cggd),
						gcm);
					var newgc = _v4.a;
					var newmg = _v4.b;
					var newggd = _v4.c;
					return _Utils_Tuple3(
						A2($elm$core$Array$push, newgc, bgc),
						_Utils_ap(bgmsg, newmg),
						newggd);
				}),
			_Utils_Tuple3($elm$core$Array$empty, _List_Nil, ggd),
			newc);
		var appliedgc = _v1.a;
		var appliedmsg = _v1.b;
		var appliedggc = _v1.c;
		return _Utils_Tuple3(appliedgc, appliedmsg, appliedggc);
	});
var $author$project$Lib$CoreEngine$GameLayer$Model$judgePlayerOK = F2(
	function (ggd, player) {
		var _v0 = player.data.status;
		if (_v0.$ === 'Alive') {
			return true;
		} else {
			return A2($author$project$Lib$CoreEngine$Physics$NaiveCollision$judgeInCamera, player, ggd) ? true : false;
		}
	});
var $author$project$Lib$CoreEngine$GameLayer$Model$kineticCalc = F2(
	function (mass, _v0) {
		var vx = _v0.a;
		var vy = _v0.b;
		return (mass * ((vx * vx) + (vy * vy))) / 10000;
	});
var $elm_community$array_extra$Array$Extra$any = F2(
	function (isOkay, array) {
		return A3(
			$elm$core$Array$foldl,
			function (element) {
				return $elm$core$Basics$or(
					isOkay(element));
			},
			false,
			array);
	});
var $author$project$Lib$CoreEngine$GameLayer$Model$releaseObjects = F2(
	function (ggd, gcs) {
		return A2(
			$elm_community$array_extra$Array$Extra$any,
			function (x) {
				var _v0 = x.data.status;
				if (_v0.$ === 'Alive') {
					return false;
				} else {
					return _Utils_eq(x.data.uid, ggd.selectobj) ? true : false;
				}
			},
			gcs) ? _Utils_update(
			ggd,
			{selectobj: -1}) : ggd;
	});
var $author$project$Lib$CoreEngine$GameLayer$Model$searchNameGC = F2(
	function (s, gcs) {
		return A2(
			$author$project$Lib$Tools$Array$locate,
			function (x) {
				return _Utils_eq(x.name, s);
			},
			gcs);
	});
var $author$project$Lib$CoreEngine$GameLayer$Model$searchUIDGC = F2(
	function (s, gcs) {
		var res = A2(
			$author$project$Lib$Tools$Array$locate,
			function (x) {
				return _Utils_eq(x.data.uid, s);
			},
			gcs);
		if (res.b && (!res.b.b)) {
			var x = res.a;
			return x;
		} else {
			return -1;
		}
	});
var $author$project$Lib$CoreEngine$GameComponent$ComponentHandler$sendManyGameComponentMsg = F7(
	function (msg, gct, ggd, gd, ns, t, gcs) {
		return A3(
			$elm$core$List$foldl,
			F2(
				function (x, _v0) {
					var a = _v0.a;
					var c = _v0.b;
					var b = _v0.c;
					var oldgc = A2($elm$core$Array$get, x, a);
					if (oldgc.$ === 'Just') {
						var ogc = oldgc.a;
						var _v2 = A6($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$updateOneGameComponent, msg, gct, b, gd, t, ogc);
						var nbj = _v2.a;
						var nmsg = _v2.b;
						var nggd = _v2.c;
						return _Utils_Tuple3(
							A3($elm$core$Array$set, x, nbj, a),
							_Utils_ap(c, nmsg),
							nggd);
					} else {
						return _Utils_Tuple3(a, c, b);
					}
				}),
			_Utils_Tuple3(gcs, _List_Nil, ggd),
			ns);
	});
var $author$project$Lib$CoreEngine$GameComponent$ComponentHandler$simpleUpdateAllGameComponent = F6(
	function (msg, gct, ggd, gd, t, gcs) {
		return A3(
			$elm$core$Array$foldl,
			F2(
				function (x, _v0) {
					var a = _v0.a;
					var c = _v0.b;
					var b = _v0.c;
					var _v1 = A6($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$updateOneGameComponent, msg, gct, b, gd, t, x);
					var nbj = _v1.a;
					var nmsg = _v1.b;
					var nggd = _v1.c;
					return _Utils_Tuple3(
						A2($elm$core$Array$push, nbj, a),
						_Utils_ap(c, nmsg),
						nggd);
				}),
			_Utils_Tuple3($elm$core$Array$empty, _List_Nil, ggd),
			gcs);
	});
var $author$project$Lib$CoreEngine$GameComponent$Base$GameSolidCollisionMsg = function (a) {
	return {$: 'GameSolidCollisionMsg', a: a};
};
var $author$project$Lib$CoreEngine$Physics$SolidCollision$genSplits = F3(
	function (a, b, s) {
		if (_Utils_cmp(a, b) > -1) {
			return $elm$core$Array$empty;
		} else {
			var fgs = ((b - a) / s) | 0;
			return (!A2($elm$core$Basics$modBy, s, b - a)) ? A2(
				$elm$core$Array$map,
				function (x) {
					return (x * s) + a;
				},
				$elm$core$Array$fromList(
					A2($elm$core$List$range, 0, fgs))) : A2(
				$elm$core$Array$push,
				b,
				A2(
					$elm$core$Array$map,
					function (x) {
						return (x * s) + a;
					},
					$elm$core$Array$fromList(
						A2($elm$core$List$range, 0, fgs))));
		}
	});
var $elm$core$List$isEmpty = function (xs) {
	if (!xs.b) {
		return true;
	} else {
		return false;
	}
};
var $author$project$Lib$CoreEngine$Physics$SolidCollision$pointOfSolid = F2(
	function (_v0, model) {
		var x = _v0.a;
		var y = _v0.b;
		var _v1 = A3(
			$tortus$elm_array_2d$Array2D$get,
			$author$project$Lib$Tools$Math$rfint(x),
			$author$project$Lib$Tools$Math$rfint(y),
			model.solidmap);
		if (_v1.$ === 'Just') {
			var t = _v1.a;
			return (t > 0) ? $elm$core$Maybe$Just(
				_Utils_Tuple2(
					$author$project$Lib$Tools$Math$rfint(x),
					$author$project$Lib$Tools$Math$rfint(y))) : $elm$core$Maybe$Nothing;
		} else {
			return ((x < 0) || ((_Utils_cmp(
				$author$project$Lib$Tools$Math$rfint(x),
				model.mapsize.a) > -1) || (_Utils_cmp(
				$author$project$Lib$Tools$Math$rfint(y),
				model.mapsize.b) > -1))) ? $elm$core$Maybe$Just(
				_Utils_Tuple2(
					$author$project$Lib$Tools$Math$rfint(x),
					$author$project$Lib$Tools$Math$rfint(y))) : $elm$core$Maybe$Nothing;
		}
	});
var $author$project$Lib$CoreEngine$Physics$SolidCollision$gonnaCollideSolidOrigin = F2(
	function (actor, model) {
		var velv = actor.velocity;
		var velvx = $author$project$Lib$CoreEngine$Physics$SolidCollision$velToDis(velv.a);
		var velvy = $author$project$Lib$CoreEngine$Physics$SolidCollision$velToDis(velv.b);
		var disv = A2($elm_explorations$linear_algebra$Math$Vector2$vec2, velvx, -velvy);
		var disvlength = $elm_explorations$linear_algebra$Math$Vector2$length(disv);
		var dunit = (disvlength > 5) ? A2(
			$elm_explorations$linear_algebra$Math$Vector2$scale,
			2,
			$elm_explorations$linear_algebra$Math$Vector2$normalize(disv)) : $elm_explorations$linear_algebra$Math$Vector2$normalize(disv);
		var frags = (disvlength > 5) ? $elm$core$Basics$floor(
			$elm_explorations$linear_algebra$Math$Vector2$length(disv) / 2) : $elm$core$Basics$floor(
			$elm_explorations$linear_algebra$Math$Vector2$length(disv));
		var cbox = actor.simplecheck;
		var alfs = A2(
			$elm$core$Array$push,
			disv,
			$elm$core$Array$fromList(
				A2(
					$elm$core$List$map,
					function (x) {
						return A2($elm_explorations$linear_algebra$Math$Vector2$scale, x, dunit);
					},
					A2($elm$core$List$range, 1, frags))));
		var mapToNew = F2(
			function (_v4, i) {
				var x = _v4.a;
				var y = _v4.b;
				var _v3 = A2($elm$core$Array$get, i, alfs);
				if (_v3.$ === 'Just') {
					var t = _v3.a;
					return _Utils_Tuple2(
						x + $elm$core$Basics$floor(
							$elm_explorations$linear_algebra$Math$Vector2$getX(t)),
						y + $elm$core$Basics$floor(
							$elm_explorations$linear_algebra$Math$Vector2$getY(t)));
				} else {
					return _Utils_Tuple2(x, y);
				}
			});
		var moveAgent = F2(
			function (agents, index) {
				moveAgent:
				while (true) {
					if (_Utils_eq(index, frags + 1)) {
						return $elm$core$Array$empty;
					} else {
						var curagents = A2(
							$elm$core$Array$map,
							function (x) {
								return A2(mapToNew, x, index);
							},
							agents);
						var testres = A2(
							$elm$core$Array$map,
							function (x) {
								return A2($author$project$Lib$CoreEngine$Physics$SolidCollision$pointOfSolid, x, model);
							},
							curagents);
						var td = A2(
							$elm$core$List$filterMap,
							function (x) {
								return x;
							},
							$elm$core$Array$toList(testres));
						if ($elm$core$List$isEmpty(td)) {
							var $temp$agents = agents,
								$temp$index = index + 1;
							agents = $temp$agents;
							index = $temp$index;
							continue moveAgent;
						} else {
							return $elm$core$Array$fromList(td);
						}
					}
				}
			});
		var _v0 = A2($author$project$Lib$CoreEngine$Physics$NaiveCollision$getBoxPos, actor.position, cbox);
		var _v1 = _v0.a;
		var x1A = _v1.a;
		var y1A = _v1.b;
		var _v2 = _v0.b;
		var x2A = _v2.a;
		var y2A = _v2.b;
		var topAgents = A2(
			$elm$core$Array$map,
			function (x) {
				return _Utils_Tuple2(x, y1A);
			},
			A3($author$project$Lib$CoreEngine$Physics$SolidCollision$genSplits, x1A, x2A, 5));
		var bottomAgents = A2(
			$elm$core$Array$map,
			function (x) {
				return _Utils_Tuple2(x, y2A);
			},
			A3($author$project$Lib$CoreEngine$Physics$SolidCollision$genSplits, x1A, x2A, 5));
		var leftAgents = A2(
			$elm$core$Array$map,
			function (x) {
				return _Utils_Tuple2(x1A, x);
			},
			A3($author$project$Lib$CoreEngine$Physics$SolidCollision$genSplits, y1A, y2A, 5));
		var leftbottomAgents = $elm$core$Array$fromList(
			A2(
				$elm$core$List$append,
				$elm$core$Array$toList(leftAgents),
				A2(
					$elm$core$List$drop,
					1,
					$elm$core$Array$toList(bottomAgents))));
		var lefttopAgents = $elm$core$Array$fromList(
			A2(
				$elm$core$List$append,
				$elm$core$Array$toList(leftAgents),
				A2(
					$elm$core$List$drop,
					1,
					$elm$core$Array$toList(topAgents))));
		var rightAgents = A2(
			$elm$core$Array$map,
			function (x) {
				return _Utils_Tuple2(x2A, x);
			},
			A3($author$project$Lib$CoreEngine$Physics$SolidCollision$genSplits, y1A, y2A, 5));
		var rightbottomAgents = $elm$core$Array$fromList(
			A2(
				$elm$core$List$append,
				$elm$core$Array$toList(rightAgents),
				$elm$core$Array$toList(bottomAgents)));
		var righttopAgents = $elm$core$Array$fromList(
			A2(
				$elm$core$List$append,
				$elm$core$Array$toList(rightAgents),
				A2(
					$elm$core$List$drop,
					1,
					$elm$core$Array$toList(topAgents))));
		return ((!velvx) && (!velvy)) ? $elm$core$Array$empty : (((!velvx) && (velvy > 0)) ? A2(moveAgent, topAgents, 0) : (((!velvx) && (velvy < 0)) ? A2(moveAgent, bottomAgents, 0) : (((velvx > 0) && (!velvy)) ? A2(moveAgent, rightAgents, 0) : (((velvx < 0) && (!velvy)) ? A2(moveAgent, leftAgents, 0) : (((velvx < 0) && (velvy > 0)) ? A2(moveAgent, lefttopAgents, 0) : (((velvx < 0) && (velvy < 0)) ? A2(moveAgent, leftbottomAgents, 0) : (((velvx > 0) && (velvy > 0)) ? A2(moveAgent, righttopAgents, 0) : (((velvx > 0) && (velvy < 0)) ? A2(moveAgent, rightbottomAgents, 0) : $elm$core$Array$empty))))))));
	});
var $author$project$Lib$CoreEngine$Physics$SolidCollision$gonnaSolidCollide = F2(
	function (gc, ggd) {
		var op = $elm$core$Array$toList(
			A2($author$project$Lib$CoreEngine$Physics$SolidCollision$gonnaCollideSolidOrigin, gc, ggd));
		return A2($author$project$Lib$Tools$Array$delSame, op, _List_Nil);
	});
var $author$project$Lib$CoreEngine$Physics$SolidCollision$movePointPlain = F2(
	function (vec, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		var vy = $elm_explorations$linear_algebra$Math$Vector2$getY(vec);
		var vx = $elm_explorations$linear_algebra$Math$Vector2$getX(vec);
		return _Utils_Tuple2(
			x + $elm$core$Basics$floor(
				$author$project$Lib$CoreEngine$Physics$SolidCollision$velToDis(vx)),
			y + $elm$core$Basics$floor(
				-$author$project$Lib$CoreEngine$Physics$SolidCollision$velToDis(vy)));
	});
var $author$project$Lib$CoreEngine$GameLayer$Model$playerMove = function (player) {
	var pv = player.velocity;
	var _v0 = pv;
	var npx = _v0.a;
	var npy = _v0.b;
	var pvv = A2($elm_explorations$linear_algebra$Math$Vector2$vec2, npx, npy);
	var newpos = A2($author$project$Lib$CoreEngine$Physics$SolidCollision$movePointPlain, pvv, player.position);
	var newplayer = _Utils_update(
		player,
		{position: newpos});
	return newplayer;
};
var $author$project$Lib$CoreEngine$GameLayer$Model$solidCollision = F5(
	function (msg, t, ggd, gd, gcs) {
		return A3(
			$elm$core$Array$foldl,
			F2(
				function (g, _v0) {
					var ncs = _v0.a;
					var nms = _v0.b;
					var lggd = _v0.c;
					var checksolid = A2($author$project$Lib$CoreEngine$Physics$SolidCollision$gonnaSolidCollide, g.data, ggd);
					var _v1 = function () {
						if ($elm$core$List$isEmpty(checksolid) || (!$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$isAlive(g.data))) {
							return _Utils_Tuple3(
								_Utils_update(
									g,
									{
										data: $author$project$Lib$CoreEngine$GameLayer$Model$playerMove(g.data)
									}),
								_List_Nil,
								lggd);
						} else {
							var _v2 = A6(
								$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$updateOneGameComponent,
								msg,
								$author$project$Lib$CoreEngine$GameComponent$Base$GameSolidCollisionMsg(checksolid),
								lggd,
								gd,
								t,
								g);
							var newd = _v2.a;
							var kdsl = _v2.b;
							var nndd = _v2.c;
							return _Utils_Tuple3(newd, kdsl, nndd);
						}
					}();
					var newsol = _v1.a;
					var newmsg = _v1.b;
					var newggd = _v1.c;
					return _Utils_Tuple3(
						A2($elm$core$Array$push, newsol, ncs),
						_Utils_ap(nms, newmsg),
						newggd);
				}),
			_Utils_Tuple3($elm$core$Array$empty, _List_Nil, ggd),
			gcs);
	});
var $elm$core$Array$sliceLeft = F2(
	function (from, array) {
		var len = array.a;
		var tree = array.c;
		var tail = array.d;
		if (!from) {
			return array;
		} else {
			if (_Utils_cmp(
				from,
				$elm$core$Array$tailIndex(len)) > -1) {
				return A4(
					$elm$core$Array$Array_elm_builtin,
					len - from,
					$elm$core$Array$shiftStep,
					$elm$core$Elm$JsArray$empty,
					A3(
						$elm$core$Elm$JsArray$slice,
						from - $elm$core$Array$tailIndex(len),
						$elm$core$Elm$JsArray$length(tail),
						tail));
			} else {
				var skipNodes = (from / $elm$core$Array$branchFactor) | 0;
				var helper = F2(
					function (node, acc) {
						if (node.$ === 'SubTree') {
							var subTree = node.a;
							return A3($elm$core$Elm$JsArray$foldr, helper, acc, subTree);
						} else {
							var leaf = node.a;
							return A2($elm$core$List$cons, leaf, acc);
						}
					});
				var leafNodes = A3(
					$elm$core$Elm$JsArray$foldr,
					helper,
					_List_fromArray(
						[tail]),
					tree);
				var nodesToInsert = A2($elm$core$List$drop, skipNodes, leafNodes);
				if (!nodesToInsert.b) {
					return $elm$core$Array$empty;
				} else {
					var head = nodesToInsert.a;
					var rest = nodesToInsert.b;
					var firstSlice = from - (skipNodes * $elm$core$Array$branchFactor);
					var initialBuilder = {
						nodeList: _List_Nil,
						nodeListSize: 0,
						tail: A3(
							$elm$core$Elm$JsArray$slice,
							firstSlice,
							$elm$core$Elm$JsArray$length(head),
							head)
					};
					return A2(
						$elm$core$Array$builderToArray,
						true,
						A3($elm$core$List$foldl, $elm$core$Array$appendHelpBuilder, initialBuilder, rest));
				}
			}
		}
	});
var $elm$core$Array$fetchNewTail = F4(
	function (shift, end, treeEnd, tree) {
		fetchNewTail:
		while (true) {
			var pos = $elm$core$Array$bitMask & (treeEnd >>> shift);
			var _v0 = A2($elm$core$Elm$JsArray$unsafeGet, pos, tree);
			if (_v0.$ === 'SubTree') {
				var sub = _v0.a;
				var $temp$shift = shift - $elm$core$Array$shiftStep,
					$temp$end = end,
					$temp$treeEnd = treeEnd,
					$temp$tree = sub;
				shift = $temp$shift;
				end = $temp$end;
				treeEnd = $temp$treeEnd;
				tree = $temp$tree;
				continue fetchNewTail;
			} else {
				var values = _v0.a;
				return A3($elm$core$Elm$JsArray$slice, 0, $elm$core$Array$bitMask & end, values);
			}
		}
	});
var $elm$core$Array$hoistTree = F3(
	function (oldShift, newShift, tree) {
		hoistTree:
		while (true) {
			if ((_Utils_cmp(oldShift, newShift) < 1) || (!$elm$core$Elm$JsArray$length(tree))) {
				return tree;
			} else {
				var _v0 = A2($elm$core$Elm$JsArray$unsafeGet, 0, tree);
				if (_v0.$ === 'SubTree') {
					var sub = _v0.a;
					var $temp$oldShift = oldShift - $elm$core$Array$shiftStep,
						$temp$newShift = newShift,
						$temp$tree = sub;
					oldShift = $temp$oldShift;
					newShift = $temp$newShift;
					tree = $temp$tree;
					continue hoistTree;
				} else {
					return tree;
				}
			}
		}
	});
var $elm$core$Array$sliceTree = F3(
	function (shift, endIdx, tree) {
		var lastPos = $elm$core$Array$bitMask & (endIdx >>> shift);
		var _v0 = A2($elm$core$Elm$JsArray$unsafeGet, lastPos, tree);
		if (_v0.$ === 'SubTree') {
			var sub = _v0.a;
			var newSub = A3($elm$core$Array$sliceTree, shift - $elm$core$Array$shiftStep, endIdx, sub);
			return (!$elm$core$Elm$JsArray$length(newSub)) ? A3($elm$core$Elm$JsArray$slice, 0, lastPos, tree) : A3(
				$elm$core$Elm$JsArray$unsafeSet,
				lastPos,
				$elm$core$Array$SubTree(newSub),
				A3($elm$core$Elm$JsArray$slice, 0, lastPos + 1, tree));
		} else {
			return A3($elm$core$Elm$JsArray$slice, 0, lastPos, tree);
		}
	});
var $elm$core$Array$sliceRight = F2(
	function (end, array) {
		var len = array.a;
		var startShift = array.b;
		var tree = array.c;
		var tail = array.d;
		if (_Utils_eq(end, len)) {
			return array;
		} else {
			if (_Utils_cmp(
				end,
				$elm$core$Array$tailIndex(len)) > -1) {
				return A4(
					$elm$core$Array$Array_elm_builtin,
					end,
					startShift,
					tree,
					A3($elm$core$Elm$JsArray$slice, 0, $elm$core$Array$bitMask & end, tail));
			} else {
				var endIdx = $elm$core$Array$tailIndex(end);
				var depth = $elm$core$Basics$floor(
					A2(
						$elm$core$Basics$logBase,
						$elm$core$Array$branchFactor,
						A2($elm$core$Basics$max, 1, endIdx - 1)));
				var newShift = A2($elm$core$Basics$max, 5, depth * $elm$core$Array$shiftStep);
				return A4(
					$elm$core$Array$Array_elm_builtin,
					end,
					newShift,
					A3(
						$elm$core$Array$hoistTree,
						startShift,
						newShift,
						A3($elm$core$Array$sliceTree, startShift, endIdx, tree)),
					A4($elm$core$Array$fetchNewTail, startShift, end, endIdx, tree));
			}
		}
	});
var $elm$core$Array$translateIndex = F2(
	function (index, _v0) {
		var len = _v0.a;
		var posIndex = (index < 0) ? (len + index) : index;
		return (posIndex < 0) ? 0 : ((_Utils_cmp(posIndex, len) > 0) ? len : posIndex);
	});
var $elm$core$Array$slice = F3(
	function (from, to, array) {
		var correctTo = A2($elm$core$Array$translateIndex, to, array);
		var correctFrom = A2($elm$core$Array$translateIndex, from, array);
		return (_Utils_cmp(correctFrom, correctTo) > 0) ? $elm$core$Array$empty : A2(
			$elm$core$Array$sliceLeft,
			correctFrom,
			A2($elm$core$Array$sliceRight, correctTo, array));
	});
var $elm_community$array_extra$Array$Extra$pop = function (array) {
	return A3($elm$core$Array$slice, 0, -1, array);
};
var $author$project$Lib$CoreEngine$GameComponent$ComponentHandler$splitPlayerObjs = F2(
	function (gcs, defaultplayer) {
		var newplayer = A2(
			$elm$core$Maybe$withDefault,
			defaultplayer,
			A2(
				$elm$core$Array$get,
				$elm$core$Array$length(gcs) - 1,
				gcs));
		return _Utils_Tuple2(
			newplayer,
			$elm_community$array_extra$Array$Extra$pop(gcs));
	});
var $author$project$Lib$CoreEngine$GameComponent$ComponentHandler$getGameComponent = F2(
	function (n, xs) {
		return A2($elm$core$Array$get, n, xs);
	});
var $author$project$Lib$CoreEngine$GameComponent$ComponentHandler$getGameComponentFromName = F2(
	function (s, xs) {
		return A2(
			$elm$core$Maybe$withDefault,
			-1,
			$elm$core$List$head(
				A2(
					$author$project$Lib$Tools$Array$locate,
					function (x) {
						return _Utils_eq(x.name, s);
					},
					xs)));
	});
var $author$project$Lib$CoreEngine$GameComponent$ComponentHandler$updateSingleGameComponentByName = F7(
	function (msg, ct, ggd, gd, t, s, xs) {
		var n = A2($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$getGameComponentFromName, s, xs);
		var _v0 = A2($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$getGameComponent, n, xs);
		if (_v0.$ === 'Just') {
			var k = _v0.a;
			var _v1 = A5(
				k.update,
				msg,
				ct,
				ggd,
				gd,
				_Utils_Tuple2(k.data, t));
			var newx = _v1.a;
			var newmsg = _v1.b;
			var newggd = _v1.c;
			return _Utils_Tuple3(
				A3(
					$elm$core$Array$set,
					n,
					_Utils_update(
						k,
						{data: newx}),
					xs),
				newmsg,
				newggd);
		} else {
			return _Utils_Tuple3(xs, _List_Nil, ggd);
		}
	});
var $author$project$Lib$CoreEngine$GameLayer$Model$updateModel = F5(
	function (msg, gd, lm, _v0, ggd) {
		var model = _v0.a;
		var t = _v0.b;
		_v1$2:
		while (true) {
			if (lm.$ === 'LayerStringMsg') {
				switch (lm.a) {
					case 'stopinput':
						return _Utils_Tuple2(
							_Utils_Tuple3(
								_Utils_update(
									model,
									{ignoreInput: true}),
								ggd,
								_List_Nil),
							gd);
					case 'startinput':
						return _Utils_Tuple2(
							_Utils_Tuple3(
								_Utils_update(
									model,
									{ignoreInput: false}),
								ggd,
								_List_Nil),
							gd);
					default:
						break _v1$2;
				}
			} else {
				break _v1$2;
			}
		}
		if (ggd.ingamepause) {
			return _Utils_Tuple2(
				_Utils_Tuple3(model, ggd, _List_Nil),
				gd);
		} else {
			_v2$7:
			while (true) {
				switch (msg.$) {
					case 'Tick':
						var restartmsg = A2($author$project$Lib$CoreEngine$GameLayer$Model$judgePlayerOK, ggd, model.player) ? _List_Nil : _List_fromArray(
							[
								$author$project$Lib$CoreEngine$GameComponent$Base$GameStringMsg('restart')
							]);
						var allobjs = A2($elm$core$Array$push, model.player, model.actors);
						var clearSel = A2($author$project$Lib$CoreEngine$GameLayer$Model$releaseObjects, ggd, allobjs);
						var removedobjs = A2($author$project$Lib$CoreEngine$GameLayer$Model$deleteObjects, clearSel, allobjs);
						var _v3 = A6($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$simpleUpdateAllGameComponent, msg, $author$project$Lib$CoreEngine$GameComponent$Base$NullGameComponentMsg, clearSel, gd, t, removedobjs);
						var updatedobjs = _v3.a;
						var updatedmsg = _v3.b;
						var updatedggd = _v3.c;
						var clearedobjs = A2($author$project$Lib$CoreEngine$GameLayer$Model$clearWrongVelocity, updatedggd, updatedobjs);
						var _v4 = A5($author$project$Lib$CoreEngine$GameLayer$Model$solidCollision, msg, t, updatedggd, gd, clearedobjs);
						var aftersolidobjs = _v4.a;
						var solidmsg = _v4.b;
						var aftersolidggd = _v4.c;
						var _v5 = A5($author$project$Lib$CoreEngine$GameLayer$Model$interCollision, msg, t, aftersolidggd, gd, aftersolidobjs);
						var afterinterobjs = _v5.a;
						var intermsg = _v5.b;
						var afterinterggd = _v5.c;
						var allmsg = _Utils_ap(
							updatedmsg,
							_Utils_ap(solidmsg, intermsg));
						var _v6 = A3(
							$elm$core$List$foldl,
							F2(
								function (m, _v7) {
									var ao = _v7.a;
									var ai = _v7.b;
									switch (m.$) {
										case 'GameActorNameMsg':
											var s = m.a;
											var mm = m.b;
											var rid = A2($author$project$Lib$CoreEngine$GameLayer$Model$searchNameGC, s, ao);
											var _v9 = A7($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$sendManyGameComponentMsg, $author$project$Base$UnknownMsg, mm, ai, gd, rid, t, ao);
											var res = _v9.a;
											var newgg = _v9.c;
											return _Utils_Tuple2(res, newgg);
										case 'GameActorUidMsg':
											var s = m.a;
											var mm = m.b;
											var rid = A2($author$project$Lib$CoreEngine$GameLayer$Model$searchUIDGC, s, ao);
											var _v10 = A7(
												$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$sendManyGameComponentMsg,
												$author$project$Base$UnknownMsg,
												mm,
												ai,
												gd,
												_List_fromArray(
													[rid]),
												t,
												ao);
											var res = _v10.a;
											var newgg = _v10.c;
											return _Utils_Tuple2(res, newgg);
										default:
											return _Utils_Tuple2(ao, ai);
									}
								}),
							_Utils_Tuple2(afterinterobjs, afterinterggd),
							allmsg);
						var finalobjs = _v6.a;
						var finalggd = _v6.b;
						var _v11 = A2($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$splitPlayerObjs, finalobjs, model.player);
						var newplayer = _v11.a;
						var newactors = _v11.b;
						var newcamera = A2($author$project$Lib$CoreEngine$Camera$Camera$getNewCamera, finalggd, newplayer.data);
						var newggd = _Utils_update(
							finalggd,
							{camera: newcamera});
						var newmodel = _Utils_update(
							model,
							{actors: newactors, player: newplayer});
						var newiter = A2($author$project$Lib$CoreEngine$GameLayer$Model$judgePlayerOK, ggd, model.player) ? _Utils_Tuple2(
							_Utils_Tuple3(newmodel, newggd, _List_Nil),
							gd) : _Utils_Tuple2(
							_Utils_Tuple3(model, ggd, _List_Nil),
							gd);
						var allparentmsg = _Utils_ap(
							A2(
								$elm$core$List$filterMap,
								function (x) {
									if (x.$ === 'GameParentMsg') {
										var tmsg = x.a;
										return $elm$core$Maybe$Just(tmsg);
									} else {
										return $elm$core$Maybe$Nothing;
									}
								},
								allmsg),
							restartmsg);
						return A3(
							$elm$core$List$foldl,
							F2(
								function (tm, _v12) {
									var _v13 = _v12.a;
									var cm = _v13.a;
									var cggd = _v13.b;
									var cam = _v13.c;
									var cgd = _v12.b;
									var _v14 = A4(
										$author$project$Lib$CoreEngine$GameLayer$Model$dealParentMsg,
										tm,
										cgd,
										_Utils_Tuple2(cm, t),
										cggd);
									var _v15 = _v14.a;
									var nnm = _v15.a;
									var nnggd = _v15.b;
									var nndmd = _v15.c;
									var nngd = _v14.b;
									return _Utils_Tuple2(
										_Utils_Tuple3(
											nnm,
											nnggd,
											_Utils_ap(cam, nndmd)),
										nngd);
								}),
							newiter,
							allparentmsg);
					case 'KeyDown':
						switch (msg.a) {
							case 87:
								if (model.ignoreInput) {
									return _Utils_Tuple2(
										_Utils_Tuple3(model, ggd, _List_Nil),
										gd);
								} else {
									if (ggd.selectobj > 0) {
										if (_Utils_eq(ggd.selectobj, model.player.data.uid)) {
											var k = A2($author$project$Lib$CoreEngine$GameLayer$Model$kineticCalc, model.player.data.mass, model.player.data.velocity);
											var _v17 = (k > 300) ? A6($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$updateOneGameComponent, $author$project$Base$UnknownMsg, $author$project$Lib$CoreEngine$GameComponent$Base$GameClearVelocity, ggd, gd, t, model.player) : _Utils_Tuple3(model.player, _List_Nil, ggd);
											var newplayer = _v17.a;
											var newggd = _v17.c;
											var tcggd = (k > 300) ? _Utils_update(
												newggd,
												{energy: newggd.energy + k}) : newggd;
											return _Utils_Tuple2(
												_Utils_Tuple3(
													_Utils_update(
														model,
														{player: newplayer}),
													tcggd,
													_List_Nil),
												gd);
										} else {
											var tn = A2($author$project$Lib$CoreEngine$GameLayer$Model$searchUIDGC, ggd.selectobj, model.actors);
											var tac = A2($elm$core$Array$get, tn, model.actors);
											if (tac.$ === 'Just') {
												var thisactor = tac.a;
												var k = A2($author$project$Lib$CoreEngine$GameLayer$Model$kineticCalc, thisactor.data.mass, thisactor.data.velocity);
												var _v19 = (k > 300) ? A6($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$updateOneGameComponent, $author$project$Base$UnknownMsg, $author$project$Lib$CoreEngine$GameComponent$Base$GameClearVelocity, ggd, gd, t, thisactor) : _Utils_Tuple3(thisactor, _List_Nil, ggd);
												var newactor = _v19.a;
												var newggd = _v19.c;
												var newactors = A3($elm$core$Array$set, tn, newactor, model.actors);
												var onew = (k > 300) ? _Utils_update(
													newggd,
													{energy: newggd.energy + k}) : newggd;
												return _Utils_Tuple2(
													_Utils_Tuple3(
														_Utils_update(
															model,
															{actors: newactors}),
														onew,
														_List_Nil),
													gd);
											} else {
												return _Utils_Tuple2(
													_Utils_Tuple3(model, ggd, _List_Nil),
													gd);
											}
										}
									} else {
										return _Utils_Tuple2(
											_Utils_Tuple3(model, ggd, _List_Nil),
											gd);
									}
								}
							case 13:
								var _v20 = A7($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$updateSingleGameComponentByName, msg, $author$project$Lib$CoreEngine$GameComponent$Base$NullGameComponentMsg, ggd, gd, t, 'CutScene', model.actors);
								var newactors = _v20.a;
								var newggd = _v20.c;
								return _Utils_Tuple2(
									_Utils_Tuple3(
										_Utils_update(
											model,
											{actors: newactors}),
										newggd,
										_List_Nil),
									gd);
							default:
								if (model.ignoreInput) {
									return _Utils_Tuple2(
										_Utils_Tuple3(model, ggd, _List_Nil),
										gd);
								} else {
									var _v21 = A6($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$updateOneGameComponent, msg, $author$project$Lib$CoreEngine$GameComponent$Base$NullGameComponentMsg, ggd, gd, t, model.player);
									var newplayer = _v21.a;
									var newggd = _v21.c;
									return _Utils_Tuple2(
										_Utils_Tuple3(
											_Utils_update(
												model,
												{player: newplayer}),
											newggd,
											_List_Nil),
										gd);
								}
						}
					case 'KeyUp':
						if (model.ignoreInput) {
							return _Utils_Tuple2(
								_Utils_Tuple3(model, ggd, _List_Nil),
								gd);
						} else {
							var _v22 = A6($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$updateOneGameComponent, msg, $author$project$Lib$CoreEngine$GameComponent$Base$NullGameComponentMsg, ggd, gd, t, model.player);
							var newplayer = _v22.a;
							var newggd = _v22.c;
							return _Utils_Tuple2(
								_Utils_Tuple3(
									_Utils_update(
										model,
										{player: newplayer}),
									newggd,
									_List_Nil),
								gd);
						}
					case 'MouseDown':
						switch (msg.a) {
							case 2:
								var mp = msg.b;
								if (model.ignoreInput) {
									return _Utils_Tuple2(
										_Utils_Tuple3(model, ggd, _List_Nil),
										gd);
								} else {
									if ((t - model.lastuseEnergyTime) < 15) {
										return _Utils_Tuple2(
											_Utils_Tuple3(model, ggd, _List_Nil),
											gd);
									} else {
										if (ggd.selectobj > 0) {
											if (_Utils_eq(ggd.selectobj, model.player.data.uid)) {
												var _v23 = A2(
													$author$project$Lib$Coordinate$Coordinates$posToReal,
													gd,
													A2(
														$author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera,
														$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$getGameComponentCenter(model.player),
														ggd));
												var px = _v23.a;
												var py = _v23.b;
												var pp = _Utils_Tuple2(px, py);
												var _v24 = A2($author$project$Lib$Coordinate$Coordinates$fromMouseToReal, gd, mp);
												var mx = _v24.a;
												var my = _v24.b;
												var mm = _Utils_Tuple2(mx, my);
												var _v25 = A4($author$project$Lib$CoreEngine$GameLayer$Model$getDSEnergy, pp, mm, gd, ggd);
												var xsable = _v25.a;
												var updss = _v25.b;
												var newplayer = function () {
													if (xsable > 0) {
														var _v26 = A6(
															$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$updateOneGameComponent,
															$author$project$Base$UnknownMsg,
															A2(
																$author$project$Lib$CoreEngine$GameComponent$Base$GameUseEnergy,
																_Utils_Tuple2(mx - px, my - py),
																xsable),
															ggd,
															gd,
															t,
															model.player);
														var up = _v26.a;
														return up;
													} else {
														return model.player;
													}
												}();
												return _Utils_Tuple2(
													_Utils_Tuple3(
														_Utils_update(
															model,
															{lastuseEnergyTime: t, player: newplayer}),
														updss,
														_List_Nil),
													gd);
											} else {
												var tn = A2($author$project$Lib$CoreEngine$GameLayer$Model$searchUIDGC, ggd.selectobj, model.actors);
												var tac = A2($elm$core$Array$get, tn, model.actors);
												if (tac.$ === 'Just') {
													var thisactor = tac.a;
													var _v28 = A2(
														$author$project$Lib$Coordinate$Coordinates$posToReal,
														gd,
														A2(
															$author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera,
															$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$getGameComponentCenter(thisactor),
															ggd));
													var px = _v28.a;
													var py = _v28.b;
													var pp = _Utils_Tuple2(px, py);
													var _v29 = A2($author$project$Lib$Coordinate$Coordinates$fromMouseToReal, gd, mp);
													var mx = _v29.a;
													var my = _v29.b;
													var mm = _Utils_Tuple2(mx, my);
													var _v30 = A4($author$project$Lib$CoreEngine$GameLayer$Model$getDSEnergy, pp, mm, gd, ggd);
													var xsable = _v30.a;
													var updss = _v30.b;
													var newplayer = function () {
														if (xsable > 0) {
															var _v31 = A6(
																$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$updateOneGameComponent,
																$author$project$Base$UnknownMsg,
																A2(
																	$author$project$Lib$CoreEngine$GameComponent$Base$GameUseEnergy,
																	_Utils_Tuple2(mx - px, my - py),
																	xsable),
																ggd,
																gd,
																t,
																thisactor);
															var up = _v31.a;
															return up;
														} else {
															return thisactor;
														}
													}();
													var newactors = A3($elm$core$Array$set, tn, newplayer, model.actors);
													return _Utils_Tuple2(
														_Utils_Tuple3(
															_Utils_update(
																model,
																{actors: newactors, lastuseEnergyTime: t}),
															updss,
															_List_Nil),
														gd);
												} else {
													return _Utils_Tuple2(
														_Utils_Tuple3(model, ggd, _List_Nil),
														gd);
												}
											}
										} else {
											return _Utils_Tuple2(
												_Utils_Tuple3(model, ggd, _List_Nil),
												gd);
										}
									}
								}
							case 0:
								if (model.ignoreInput) {
									return _Utils_Tuple2(
										_Utils_Tuple3(model, ggd, _List_Nil),
										gd);
								} else {
									var allobjs = A2($elm$core$Array$push, model.player, model.actors);
									var _v32 = A6($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$simpleUpdateAllGameComponent, msg, $author$project$Lib$CoreEngine$GameComponent$Base$NullGameComponentMsg, ggd, gd, t, allobjs);
									var newobjs = _v32.a;
									var newggd = _v32.c;
									var _v33 = A2($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$splitPlayerObjs, newobjs, model.player);
									var newplayer = _v33.a;
									var newactors = _v33.b;
									return _Utils_Tuple2(
										_Utils_Tuple3(
											_Utils_update(
												model,
												{actors: newactors, player: newplayer}),
											newggd,
											_List_Nil),
										gd);
								}
							default:
								break _v2$7;
						}
					default:
						break _v2$7;
				}
			}
			return _Utils_Tuple2(
				_Utils_Tuple3(model, ggd, _List_Nil),
				gd);
		}
	});
var $author$project$Lib$CoreEngine$GameComponent$ComponentHandler$renderSingleObject = F4(
	function (t, gc, ggd, gd) {
		return A2($author$project$Lib$CoreEngine$Physics$NaiveCollision$judgeInCamera, gc, ggd) ? $elm$core$Maybe$Just(
			A3(
				gc.view,
				_Utils_Tuple2(gc.data, t),
				ggd,
				gd)) : $elm$core$Maybe$Nothing;
	});
var $elm$core$List$sortWith = _List_sortWith;
var $author$project$Lib$CoreEngine$GameComponent$ComponentHandler$genView = F4(
	function (ggd, gd, t, xs) {
		var allrs = A3(
			$elm$core$Array$foldl,
			F2(
				function (x, als) {
					var _v3 = A4($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$renderSingleObject, t, x, ggd, gd);
					if (_v3.$ === 'Just') {
						var tr = _v3.a;
						return _Utils_ap(tr, als);
					} else {
						return als;
					}
				}),
			_List_Nil,
			xs);
		var res = A2(
			$elm$core$List$sortWith,
			F2(
				function (_v1, _v2) {
					var a = _v1.b;
					var b = _v2.b;
					return A2($elm$core$Basics$compare, a, b);
				}),
			allrs);
		return A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			A2(
				$elm$core$List$map,
				function (_v0) {
					var x = _v0.a;
					return x;
				},
				res));
	});
var $author$project$Lib$Render$Chartlet$renderChartletsBehindActor = F3(
	function (model, ggd, gd) {
		return A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			A2(
				$elm$core$List$filterMap,
				function (_v0) {
					var x = _v0.a;
					var dtype = _v0.b;
					if (dtype.$ === 'BehindActors') {
						return $elm$core$Maybe$Just(
							A2(x, gd, ggd));
					} else {
						return $elm$core$Maybe$Nothing;
					}
				},
				model.chartlets));
	});
var $author$project$Lib$Render$Chartlet$renderChartletsBehindSolids = F3(
	function (model, ggd, gd) {
		return A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			A2(
				$elm$core$List$filterMap,
				function (_v0) {
					var x = _v0.a;
					var dtype = _v0.b;
					if (dtype.$ === 'BehindSolids') {
						return $elm$core$Maybe$Just(
							A2(x, gd, ggd));
					} else {
						return $elm$core$Maybe$Nothing;
					}
				},
				model.chartlets));
	});
var $author$project$Lib$Render$Chartlet$renderChartletsFront = F3(
	function (model, ggd, gd) {
		return A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			A2(
				$elm$core$List$filterMap,
				function (_v0) {
					var x = _v0.a;
					var dtype = _v0.b;
					if (dtype.$ === 'FrontSolids') {
						return $elm$core$Maybe$Just(
							A2(x, gd, ggd));
					} else {
						return $elm$core$Maybe$Nothing;
					}
				},
				model.chartlets));
	});
var $joakin$elm_canvas$Canvas$Settings$fill = function (color) {
	return $joakin$elm_canvas$Canvas$Internal$Canvas$SettingDrawOp(
		$joakin$elm_canvas$Canvas$Internal$Canvas$Fill(color));
};
var $joakin$elm_canvas$Canvas$Internal$Texture$TSprite = F2(
	function (a, b) {
		return {$: 'TSprite', a: a, b: b};
	});
var $joakin$elm_canvas$Canvas$Texture$sprite = F2(
	function (data, texture) {
		if (texture.$ === 'TImage') {
			var image = texture.a;
			return A2($joakin$elm_canvas$Canvas$Internal$Texture$TSprite, data, image);
		} else {
			var image = texture.b;
			return A2($joakin$elm_canvas$Canvas$Internal$Texture$TSprite, data, image);
		}
	});
var $author$project$Lib$Render$Render$renderBrickSheet = F6(
	function (gd, ls, p, _v0, name, dst) {
		var x = _v0.a;
		var y = _v0.b;
		var _v1 = A2($author$project$Lib$Resources$Base$igetSprite, name, dst);
		if (_v1.$ === 'Just') {
			var t = _v1.a;
			var thisTexture = A2(
				$joakin$elm_canvas$Canvas$Texture$sprite,
				{height: 32, width: 32, x: x * 32, y: y * 32},
				t);
			var rw = A2($author$project$Lib$Coordinate$Coordinates$widthToReal, gd, $author$project$Lib$CoreEngine$Base$brickSize);
			var w_s = rw / 32;
			var rh = A2($author$project$Lib$Coordinate$Coordinates$heightToReal, gd, $author$project$Lib$CoreEngine$Base$brickSize);
			var h_s = rh / 32;
			var _v2 = A2($author$project$Lib$Render$Render$transPoint, gd, p);
			var newx = _v2.a;
			var newy = _v2.b;
			return A3(
				$joakin$elm_canvas$Canvas$texture,
				A2(
					$elm$core$List$cons,
					$joakin$elm_canvas$Canvas$Settings$Advanced$transform(
						_List_fromArray(
							[
								A2($joakin$elm_canvas$Canvas$Settings$Advanced$translate, newx, newy),
								A2($joakin$elm_canvas$Canvas$Settings$Advanced$scale, w_s, h_s)
							])),
					ls),
				_Utils_Tuple2(0, 0),
				thisTexture);
		} else {
			return A3(
				$joakin$elm_canvas$Canvas$text,
				_List_Nil,
				A2($author$project$Lib$Render$Render$transPoint, gd, p),
				'Wrong Sprite');
		}
	});
var $author$project$Lib$Render$Solid$renderSingleBlock = F4(
	function (tp, p, ggd, gd) {
		if (tp === 1) {
			return A2(
				$joakin$elm_canvas$Canvas$shapes,
				_List_fromArray(
					[
						$joakin$elm_canvas$Canvas$Settings$fill($avh4$elm_color$Color$red)
					]),
				_List_fromArray(
					[
						A3(
						$joakin$elm_canvas$Canvas$rect,
						A2(
							$author$project$Lib$Coordinate$Coordinates$posToReal,
							gd,
							A2($author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera, p, ggd)),
						A2($author$project$Lib$Coordinate$Coordinates$widthToReal, gd, $author$project$Lib$CoreEngine$Base$brickSize),
						A2($author$project$Lib$Coordinate$Coordinates$heightToReal, gd, $author$project$Lib$CoreEngine$Base$brickSize))
					]));
		} else {
			var k = tp;
			return A6(
				$author$project$Lib$Render$Render$renderBrickSheet,
				gd,
				_List_Nil,
				A2($author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera, p, ggd),
				_Utils_Tuple2(k, 3),
				'bricksheet',
				gd.sprites);
		}
	});
var $author$project$Lib$Render$Solid$renderSolids = F2(
	function (ggd, gd) {
		var allsolid = ggd.solidmap;
		var _v0 = ggd.camera.position;
		var cx = _v0.a;
		var cy = _v0.b;
		var _v1 = _Utils_Tuple2(cx + 1920, cy + 1080);
		var cx2 = _v1.a;
		var cy2 = _v1.b;
		var ir = A2(
			$elm$core$List$range,
			$author$project$Lib$Tools$Math$rfint(cx),
			$author$project$Lib$Tools$Math$rfint(cx2) + 1);
		var jr = A2(
			$elm$core$List$range,
			$author$project$Lib$Tools$Math$rfint(cy),
			$author$project$Lib$Tools$Math$rfint(cy2) + 1);
		var sls = A3(
			$elm$core$List$foldl,
			F2(
				function (i, alls) {
					return A3(
						$elm$core$List$foldl,
						F2(
							function (j, subs) {
								var _v2 = A3($tortus$elm_array_2d$Array2D$get, i, j, allsolid);
								if (_v2.$ === 'Just') {
									var v = _v2.a;
									return ((!v) || (v === 2)) ? subs : _Utils_ap(
										subs,
										_List_fromArray(
											[
												A4(
												$author$project$Lib$Render$Solid$renderSingleBlock,
												v,
												_Utils_Tuple2($author$project$Lib$CoreEngine$Base$brickSize * i, $author$project$Lib$CoreEngine$Base$brickSize * j),
												ggd,
												gd)
											]));
								} else {
									return subs;
								}
							}),
						alls,
						jr);
				}),
			_List_Nil,
			ir);
		return A2($joakin$elm_canvas$Canvas$group, _List_Nil, sls);
	});
var $author$project$Lib$CoreEngine$GameLayer$Display$view = F3(
	function (_v0, ggd, gd) {
		var model = _v0.a;
		var ot = _v0.b;
		var t = ggd.ingamepause ? 0 : ot;
		var allobjs = A2($elm$core$Array$push, model.player, model.actors);
		return A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			_List_fromArray(
				[
					A3($author$project$Lib$Render$Chartlet$renderChartletsBehindActor, model, ggd, gd),
					A4($author$project$Lib$CoreEngine$GameComponent$ComponentHandler$genView, ggd, gd, t, allobjs),
					A3($author$project$Lib$Render$Chartlet$renderChartletsBehindSolids, model, ggd, gd),
					A2($author$project$Lib$Render$Solid$renderSolids, ggd, gd),
					A3($author$project$Lib$Render$Chartlet$renderChartletsFront, model, ggd, gd)
				]));
	});
var $author$project$Lib$CoreEngine$GameLayer$Export$layer = {data: $author$project$Lib$CoreEngine$GameLayer$Export$nullData, init: $author$project$Lib$CoreEngine$GameLayer$Model$initModel, update: $author$project$Lib$CoreEngine$GameLayer$Model$updateModel, view: $author$project$Lib$CoreEngine$GameLayer$Display$view};
var $author$project$Lib$CoreEngine$Camera$Base$CameraData = F4(
	function (position, velocity, visible, inbox) {
		return {inbox: inbox, position: position, velocity: velocity, visible: visible};
	});
var $tortus$elm_array_2d$Array2D$empty = {columns: 0, data: $elm$core$Array$empty};
var $author$project$Lib$CoreEngine$Base$nullGameGlobalData = {
	camera: A4(
		$author$project$Lib$CoreEngine$Camera$Base$CameraData,
		_Utils_Tuple2(0, 0),
		_Utils_Tuple2(0, 0),
		_Utils_Tuple2(
			_Utils_Tuple2(0, 0),
			_Utils_Tuple2(0, 0)),
		_Utils_Tuple2(
			_Utils_Tuple2(0, 0),
			_Utils_Tuple2(0, 0))),
	currentScene: '',
	energy: 0,
	ingamepause: false,
	mapsize: _Utils_Tuple2(0, 0),
	selectobj: 1,
	solidmap: $tortus$elm_array_2d$Array2D$empty
};
var $tortus$elm_array_2d$Array2D$set = F4(
	function (row, col, newValue, array2d) {
		return A2(
			$elm$core$Maybe$withDefault,
			array2d,
			A2(
				$elm$core$Maybe$map,
				function (rowAry) {
					return _Utils_update(
						array2d,
						{
							data: A3(
								$elm$core$Array$set,
								row,
								A3($elm$core$Array$set, col, newValue, rowAry),
								array2d.data)
						});
				},
				A2($tortus$elm_array_2d$Array2D$getRow, row, array2d)));
	});
var $author$project$Lib$Map$Poly$buildrect = F4(
	function (_v0, _v1, v, ss) {
		var x = _v0.a;
		var y = _v0.b;
		var w = _v1.a;
		var h = _v1.b;
		var ys = A2($elm$core$List$range, y, (y + h) - 1);
		var xs = A2($elm$core$List$range, x, (x + w) - 1);
		return A3(
			$elm$core$List$foldl,
			F2(
				function (i, arr) {
					return A3(
						$elm$core$List$foldl,
						F2(
							function (j, arr2) {
								return A4($tortus$elm_array_2d$Array2D$set, i, j, v, arr2);
							}),
						arr,
						ys);
				}),
			ss,
			xs);
	});
var $tortus$elm_array_2d$Array2D$repeat = F3(
	function (numRows, numColumns, e) {
		var row = A2($elm$core$Array$repeat, numColumns, e);
		return {
			columns: numColumns,
			data: A2($elm$core$Array$repeat, numRows, row)
		};
	});
var $author$project$Lib$CoreEngine$Base$sds = A3($tortus$elm_array_2d$Array2D$repeat, 120, 70, 0);
var $author$project$Lib$CoreEngine$Base$ps = A4(
	$author$project$Lib$Map$Poly$buildrect,
	_Utils_Tuple2(0, 0),
	_Utils_Tuple2(120, 2),
	1,
	A4(
		$author$project$Lib$Map$Poly$buildrect,
		_Utils_Tuple2(0, 68),
		_Utils_Tuple2(120, 2),
		1,
		A4(
			$author$project$Lib$Map$Poly$buildrect,
			_Utils_Tuple2(60, 50),
			_Utils_Tuple2(13, 3),
			1,
			A4(
				$author$project$Lib$Map$Poly$buildrect,
				_Utils_Tuple2(53, 40),
				_Utils_Tuple2(3, 3),
				1,
				A4(
					$author$project$Lib$Map$Poly$buildrect,
					_Utils_Tuple2(49, 43),
					_Utils_Tuple2(3, 3),
					1,
					A4(
						$author$project$Lib$Map$Poly$buildrect,
						_Utils_Tuple2(40, 37),
						_Utils_Tuple2(3, 3),
						1,
						A4(
							$author$project$Lib$Map$Poly$buildrect,
							_Utils_Tuple2(43, 46),
							_Utils_Tuple2(3, 3),
							1,
							A4(
								$author$project$Lib$Map$Poly$buildrect,
								_Utils_Tuple2(39, 50),
								_Utils_Tuple2(3, 3),
								1,
								A4(
									$author$project$Lib$Map$Poly$buildrect,
									_Utils_Tuple2(35, 54),
									_Utils_Tuple2(3, 3),
									1,
									A4(
										$author$project$Lib$Map$Poly$buildrect,
										_Utils_Tuple2(29, 58),
										_Utils_Tuple2(3, 3),
										1,
										A4(
											$author$project$Lib$Map$Poly$buildrect,
											_Utils_Tuple2(25, 61),
											_Utils_Tuple2(3, 3),
											1,
											A4(
												$author$project$Lib$Map$Poly$buildrect,
												_Utils_Tuple2(20, 64),
												_Utils_Tuple2(3, 3),
												1,
												A4(
													$author$project$Lib$Map$Poly$buildrect,
													_Utils_Tuple2(0, 36),
													_Utils_Tuple2(1, 34),
													1,
													$author$project$Lib$CoreEngine$Base$sds)))))))))))));
var $author$project$Lib$CoreEngine$Base$testGameGlobalData = {
	camera: A4(
		$author$project$Lib$CoreEngine$Camera$Base$CameraData,
		_Utils_Tuple2(0, 1120),
		_Utils_Tuple2(0, 0),
		_Utils_Tuple2(
			_Utils_Tuple2(0, 0),
			_Utils_Tuple2((32 * 120) - 1, (70 * 32) - 1)),
		_Utils_Tuple2(
			_Utils_Tuple2(0.2, 0.3),
			_Utils_Tuple2(0.4, 0.4))),
	currentScene: 'Level1',
	energy: 0,
	ingamepause: false,
	mapsize: _Utils_Tuple2(120, 70),
	selectobj: -1,
	solidmap: $author$project$Lib$CoreEngine$Base$ps
};
var $author$project$Lib$CoreEngine$Model$initModel = F2(
	function (t, sm) {
		if (sm.$ === 'SceneEngineMsg') {
			var engine = sm.a;
			var gl = $author$project$Lib$CoreEngine$GameLayer$Export$layer;
			var gct = $author$project$Lib$CoreEngine$GameLayer$Global$getLayerCT(
				_Utils_update(
					gl,
					{
						data: A3(
							$author$project$Lib$CoreEngine$GameLayer$Export$layer.init,
							t,
							$author$project$Lib$Layer$Base$LayerInitGameLayer(
								A3($author$project$Lib$Layer$Base$GameLayerInit, engine.player, engine.actors, engine.chartlets)),
							$author$project$Lib$CoreEngine$Base$nullGameGlobalData)
					}));
			var fgl = $author$project$Lib$CoreEngine$FrontgroundLayer$Export$layer;
			var fgct = $author$project$Lib$CoreEngine$FrontgroundLayer$Global$getLayerCT(
				_Utils_update(
					fgl,
					{
						data: A3(
							$author$project$Lib$CoreEngine$FrontgroundLayer$Export$layer.init,
							t,
							$author$project$Lib$Layer$Base$LayerCTMsg(
								A2($author$project$Lib$CoreEngine$FrontgroundLayer$Base$CTInfo, engine.frontground.a, engine.frontground.b)),
							$author$project$Lib$CoreEngine$Base$nullGameGlobalData)
					}));
			var bgl = $author$project$Lib$CoreEngine$BackgroundLayer$Export$layer;
			var bgct = $author$project$Lib$CoreEngine$BackgroundLayer$Global$getLayerCT(
				_Utils_update(
					bgl,
					{
						data: A3(
							$author$project$Lib$CoreEngine$BackgroundLayer$Export$layer.init,
							t,
							$author$project$Lib$Layer$Base$LayerCTMsg(
								A2($author$project$Lib$CoreEngine$FrontgroundLayer$Base$CTInfo, engine.background.a, engine.background.b)),
							$author$project$Lib$CoreEngine$Base$nullGameGlobalData)
					}));
			return {
				gameGlobalData: engine.globalData,
				layers: _List_fromArray(
					[
						_Utils_Tuple2('Background', bgct),
						_Utils_Tuple2('Game', gct),
						_Utils_Tuple2('Frontground', fgct)
					])
			};
		} else {
			var gl = $author$project$Lib$CoreEngine$GameLayer$Export$layer;
			var gct = $author$project$Lib$CoreEngine$GameLayer$Global$getLayerCT(
				_Utils_update(
					gl,
					{
						data: A3($author$project$Lib$CoreEngine$GameLayer$Export$layer.init, t, $author$project$Lib$Layer$Base$NullLayerMsg, $author$project$Lib$CoreEngine$Base$nullGameGlobalData)
					}));
			var fgl = $author$project$Lib$CoreEngine$FrontgroundLayer$Export$layer;
			var fgct = $author$project$Lib$CoreEngine$FrontgroundLayer$Global$getLayerCT(
				_Utils_update(
					fgl,
					{
						data: A3($author$project$Lib$CoreEngine$FrontgroundLayer$Export$layer.init, t, $author$project$Lib$Layer$Base$NullLayerMsg, $author$project$Lib$CoreEngine$Base$nullGameGlobalData)
					}));
			var bgl = $author$project$Lib$CoreEngine$BackgroundLayer$Export$layer;
			var bgct = $author$project$Lib$CoreEngine$BackgroundLayer$Global$getLayerCT(
				_Utils_update(
					bgl,
					{
						data: A3($author$project$Lib$CoreEngine$BackgroundLayer$Export$layer.init, t, $author$project$Lib$Layer$Base$NullLayerMsg, $author$project$Lib$CoreEngine$Base$nullGameGlobalData)
					}));
			return {
				gameGlobalData: $author$project$Lib$CoreEngine$Base$testGameGlobalData,
				layers: _List_fromArray(
					[
						_Utils_Tuple2('Background', bgct),
						_Utils_Tuple2('Game', gct),
						_Utils_Tuple2('Frontground', fgct)
					])
			};
		}
	});
var $author$project$Lib$Scene$Base$SOChangeScene = function (a) {
	return {$: 'SOChangeScene', a: a};
};
var $author$project$Lib$Scene$Base$SOPlayAudio = F3(
	function (a, b, c) {
		return {$: 'SOPlayAudio', a: a, b: b, c: c};
	});
var $author$project$Lib$Scene$Base$SOStopAudio = function (a) {
	return {$: 'SOStopAudio', a: a};
};
var $author$project$Lib$Scene$Base$SceneEngineTMsg = function (a) {
	return {$: 'SceneEngineTMsg', a: a};
};
var $author$project$Lib$CoreEngine$Model$handleLayerMsg = F2(
	function (lmsg, _v0) {
		var model = _v0.a;
		switch (lmsg.$) {
			case 'LayerSoundMsg':
				var name = lmsg.a;
				var path = lmsg.b;
				var opt = lmsg.c;
				return _Utils_Tuple2(
					model,
					A3($author$project$Lib$Scene$Base$SOPlayAudio, name, path, opt));
			case 'LayerStopSoundMsg':
				var name = lmsg.a;
				return _Utils_Tuple2(
					model,
					$author$project$Lib$Scene$Base$SOStopAudio(name));
			case 'LayerExitMsg':
				var et = lmsg.a;
				var ss = lmsg.b;
				return _Utils_Tuple2(
					model,
					$author$project$Lib$Scene$Base$SOChangeScene(
						_Utils_Tuple2(
							$author$project$Lib$Scene$Base$SceneEngineTMsg(et),
							ss)));
			default:
				return _Utils_Tuple2(model, $author$project$Lib$Scene$Base$NullSceneOutputMsg);
		}
	});
var $author$project$Lib$Layer$LayerHandler$filterLayerParentMsg = function (xs) {
	return A2(
		$elm$core$List$filter,
		function (_v0) {
			var x = _v0.a;
			if (x.$ === 'LayerParentScene') {
				return true;
			} else {
				return false;
			}
		},
		xs);
};
var $author$project$Lib$Layer$LayerHandler$filterLayerParentMsgT = function (xs) {
	var css = A2(
		$elm$core$List$filter,
		function (_v1) {
			var x = _v1.a;
			if (x.$ === 'LayerParentScene') {
				return true;
			} else {
				return false;
			}
		},
		xs);
	return A2(
		$elm$core$List$map,
		function (_v0) {
			var x = _v0.b;
			return x;
		},
		css);
};
var $author$project$Lib$Layer$LayerHandler$judgeEnd = function (xs) {
	return A2(
		$elm$core$List$all,
		function (_v0) {
			var x = _v0.a;
			switch (x.$) {
				case 'LayerParentScene':
					return true;
				case 'NullLayerTarget':
					return true;
				default:
					return false;
			}
		},
		xs);
};
var $author$project$Lib$Layer$LayerHandler$getLayerMsg = F2(
	function (xs, s) {
		var ref = A2(
			$elm$core$List$filter,
			function (_v1) {
				var x = _v1.a;
				if (x.$ === 'LayerName') {
					var ln = x.a;
					return _Utils_eq(ln, s) ? true : false;
				} else {
					return false;
				}
			},
			xs);
		return A2(
			$elm$core$List$map,
			function (_v0) {
				var x = _v0.b;
				return x;
			},
			ref);
	});
var $author$project$Lib$Layer$LayerHandler$applyOnceOnlyNew = F8(
	function (msg, gd, t, cd, lms, ms, dxs, xs) {
		applyOnceOnlyNew:
		while (true) {
			if (!xs.b) {
				return _Utils_Tuple2(
					_Utils_Tuple3(lms, dxs, cd),
					gd);
			} else {
				var _v1 = xs.a;
				var name = _v1.a;
				var layer = _v1.b;
				var lxs = xs.b;
				var slname = A2($author$project$Lib$Layer$LayerHandler$getLayerMsg, ms, name);
				var data = layer.data;
				var _v2 = $elm$core$List$isEmpty(slname) ? _Utils_Tuple2(
					_Utils_Tuple3(data, cd, _List_Nil),
					gd) : A3(
					$elm$core$List$foldl,
					F2(
						function (x, _v4) {
							var _v5 = _v4.a;
							var dd = _v5.a;
							var dcd = _v5.b;
							var dmg = _v5.c;
							var nngd = _v4.b;
							var _v6 = A5(
								layer.update,
								msg,
								nngd,
								x,
								_Utils_Tuple2(dd, t),
								dcd);
							var _v7 = _v6.a;
							var xxx = _v7.a;
							var yyy = _v7.b;
							var lltlm = _v7.c;
							var zgd = _v6.b;
							return _Utils_Tuple2(
								_Utils_Tuple3(
									xxx,
									yyy,
									_Utils_ap(dmg, lltlm)),
								zgd);
						}),
					_Utils_Tuple2(
						_Utils_Tuple3(data, cd, _List_Nil),
						gd),
					slname);
				var _v3 = _v2.a;
				var newdata = _v3.a;
				var newcd = _v3.b;
				var newmsg = _v3.c;
				var newgd = _v2.b;
				var $temp$msg = msg,
					$temp$gd = newgd,
					$temp$t = t,
					$temp$cd = newcd,
					$temp$lms = _Utils_ap(lms, newmsg),
					$temp$ms = ms,
					$temp$dxs = _Utils_ap(
					dxs,
					_List_fromArray(
						[
							_Utils_Tuple2(
							name,
							_Utils_update(
								layer,
								{data: newdata}))
						])),
					$temp$xs = lxs;
				msg = $temp$msg;
				gd = $temp$gd;
				t = $temp$t;
				cd = $temp$cd;
				lms = $temp$lms;
				ms = $temp$ms;
				dxs = $temp$dxs;
				xs = $temp$xs;
				continue applyOnceOnlyNew;
			}
		}
	});
var $author$project$Lib$Layer$LayerHandler$updateOnceOnlyNew = F6(
	function (msg, gd, t, cd, msgs, xs) {
		return A8($author$project$Lib$Layer$LayerHandler$applyOnceOnlyNew, msg, gd, t, cd, _List_Nil, msgs, _List_Nil, xs);
	});
var $author$project$Lib$Layer$LayerHandler$updateLayerRecursive = F6(
	function (msg, gd, t, cd, msgs, xs) {
		updateLayerRecursive:
		while (true) {
			if ($author$project$Lib$Layer$LayerHandler$judgeEnd(msgs)) {
				return _Utils_Tuple2(
					_Utils_Tuple3(
						xs,
						cd,
						$author$project$Lib$Layer$LayerHandler$filterLayerParentMsgT(msgs)),
					gd);
			} else {
				var tmsgs = $author$project$Lib$Layer$LayerHandler$filterLayerParentMsg(msgs);
				var _v0 = A6($author$project$Lib$Layer$LayerHandler$updateOnceOnlyNew, msg, gd, t, cd, msgs, xs);
				var _v1 = _v0.a;
				var newmsgs = _v1.a;
				var newdata = _v1.b;
				var newcd = _v1.c;
				var newgd = _v0.b;
				var $temp$msg = msg,
					$temp$gd = newgd,
					$temp$t = t,
					$temp$cd = newcd,
					$temp$msgs = _Utils_ap(newmsgs, tmsgs),
					$temp$xs = newdata;
				msg = $temp$msg;
				gd = $temp$gd;
				t = $temp$t;
				cd = $temp$cd;
				msgs = $temp$msgs;
				xs = $temp$xs;
				continue updateLayerRecursive;
			}
		}
	});
var $author$project$Lib$Layer$LayerHandler$applyOnce = F8(
	function (msg, gd, t, cd, lms, ms, dxs, xs) {
		applyOnce:
		while (true) {
			if (!xs.b) {
				return _Utils_Tuple2(
					_Utils_Tuple3(lms, dxs, cd),
					gd);
			} else {
				var _v1 = xs.a;
				var name = _v1.a;
				var layer = _v1.b;
				var lxs = xs.b;
				var slname = A2($author$project$Lib$Layer$LayerHandler$getLayerMsg, ms, name);
				var data = layer.data;
				var _v2 = function () {
					if ($elm$core$List$isEmpty(slname)) {
						var _v4 = A5(
							layer.update,
							msg,
							gd,
							$author$project$Lib$Layer$Base$NullLayerMsg,
							_Utils_Tuple2(data, t),
							cd);
						var _v5 = _v4.a;
						var xxx = _v5.a;
						var yyy = _v5.b;
						var lltlm = _v5.c;
						var zgd = _v4.b;
						return _Utils_Tuple2(
							_Utils_Tuple3(xxx, yyy, lltlm),
							zgd);
					} else {
						return A3(
							$elm$core$List$foldl,
							F2(
								function (x, _v6) {
									var _v7 = _v6.a;
									var dd = _v7.a;
									var dcd = _v7.b;
									var dmg = _v7.c;
									var nngd = _v6.b;
									var _v8 = A5(
										layer.update,
										msg,
										nngd,
										x,
										_Utils_Tuple2(dd, t),
										dcd);
									var _v9 = _v8.a;
									var xxx = _v9.a;
									var yyy = _v9.b;
									var lltlm = _v9.c;
									var zgd = _v8.b;
									return _Utils_Tuple2(
										_Utils_Tuple3(
											xxx,
											yyy,
											_Utils_ap(dmg, lltlm)),
										zgd);
								}),
							_Utils_Tuple2(
								_Utils_Tuple3(data, cd, _List_Nil),
								gd),
							slname);
					}
				}();
				var _v3 = _v2.a;
				var newdata = _v3.a;
				var newcd = _v3.b;
				var newmsg = _v3.c;
				var newgd = _v2.b;
				var $temp$msg = msg,
					$temp$gd = newgd,
					$temp$t = t,
					$temp$cd = newcd,
					$temp$lms = _Utils_ap(lms, newmsg),
					$temp$ms = ms,
					$temp$dxs = _Utils_ap(
					dxs,
					_List_fromArray(
						[
							_Utils_Tuple2(
							name,
							_Utils_update(
								layer,
								{data: newdata}))
						])),
					$temp$xs = lxs;
				msg = $temp$msg;
				gd = $temp$gd;
				t = $temp$t;
				cd = $temp$cd;
				lms = $temp$lms;
				ms = $temp$ms;
				dxs = $temp$dxs;
				xs = $temp$xs;
				continue applyOnce;
			}
		}
	});
var $author$project$Lib$Layer$LayerHandler$updateOnce = F6(
	function (msg, gd, t, cd, msgs, xs) {
		return A8($author$project$Lib$Layer$LayerHandler$applyOnce, msg, gd, t, cd, _List_Nil, msgs, _List_Nil, xs);
	});
var $author$project$Lib$Layer$LayerHandler$updateLayer = F5(
	function (msg, gd, t, cd, xs) {
		var _v0 = A6($author$project$Lib$Layer$LayerHandler$updateOnce, msg, gd, t, cd, _List_Nil, xs);
		var _v1 = _v0.a;
		var fmsg = _v1.a;
		var fdata = _v1.b;
		var fcd = _v1.c;
		var newgd = _v0.b;
		return A6($author$project$Lib$Layer$LayerHandler$updateLayerRecursive, msg, newgd, t, fcd, fmsg, fdata);
	});
var $author$project$Lib$CoreEngine$Model$updateModel = F3(
	function (msg, gd, _v0) {
		var model = _v0.a;
		var t = _v0.b;
		var _v1 = A5($author$project$Lib$Layer$LayerHandler$updateLayer, msg, gd, t, model.gameGlobalData, model.layers);
		var _v2 = _v1.a;
		var newdata = _v2.a;
		var newcd = _v2.b;
		var msgs = _v2.c;
		var newgd = _v1.b;
		var nmodel = _Utils_update(
			model,
			{gameGlobalData: newcd, layers: newdata});
		var _v3 = A3(
			$elm$core$List$foldl,
			F2(
				function (x, _v4) {
					var y = _v4.a;
					return A2(
						$author$project$Lib$CoreEngine$Model$handleLayerMsg,
						x,
						_Utils_Tuple2(y, t));
				}),
			_Utils_Tuple2(nmodel, $author$project$Lib$Scene$Base$NullSceneOutputMsg),
			msgs);
		var newmodel = _v3.a;
		var newso = _v3.b;
		return _Utils_Tuple3(newmodel, newso, newgd);
	});
var $author$project$Lib$Layer$LayerHandler$viewLayer = F4(
	function (vp, t, cd, xs) {
		return A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			A2(
				$elm$core$List$map,
				function (_v0) {
					var l = _v0.b;
					return A3(
						l.view,
						_Utils_Tuple2(l.data, t),
						cd,
						vp);
				},
				xs));
	});
var $author$project$Lib$CoreEngine$Model$viewModel = F2(
	function (_v0, gd) {
		var model = _v0.a;
		var t = _v0.b;
		return A4($author$project$Lib$Layer$LayerHandler$viewLayer, gd, t, model.gameGlobalData, model.layers);
	});
var $author$project$Lib$CoreEngine$Export$scene = {init: $author$project$Lib$CoreEngine$Model$initModel, update: $author$project$Lib$CoreEngine$Model$updateModel, view: $author$project$Lib$CoreEngine$Model$viewModel};
var $author$project$Scenes$Home$Layer0$Export$nullData = {s: 0};
var $author$project$Scenes$Home$Layer0$Global$ctTod = function (ldt) {
	if (ldt.$ === 'Layer0Data') {
		var x = ldt.a;
		return x;
	} else {
		return $author$project$Scenes$Home$Layer0$Export$nullData;
	}
};
var $author$project$Scenes$Home$LayerSettings$Layer0Data = function (a) {
	return {$: 'Layer0Data', a: a};
};
var $author$project$Scenes$Home$Layer0$Global$dToCT = function (data) {
	return $author$project$Scenes$Home$LayerSettings$Layer0Data(data);
};
var $author$project$Scenes$Home$Layer0$Global$getLayerCT = function (layer) {
	var view = F3(
		function (_v3, cd, gd) {
			var ldt = _v3.a;
			var t = _v3.b;
			return A3(
				layer.view,
				_Utils_Tuple2(
					$author$project$Scenes$Home$Layer0$Global$ctTod(ldt),
					t),
				cd,
				gd);
		});
	var update = F5(
		function (m, gd, lm, _v2, cd) {
			var ldt = _v2.a;
			var t = _v2.b;
			var _v0 = A5(
				layer.update,
				m,
				gd,
				lm,
				_Utils_Tuple2(
					$author$project$Scenes$Home$Layer0$Global$ctTod(ldt),
					t),
				cd);
			var _v1 = _v0.a;
			var rldt = _v1.a;
			var rcd = _v1.b;
			var ltm = _v1.c;
			var newgd = _v0.b;
			return _Utils_Tuple2(
				_Utils_Tuple3(
					$author$project$Scenes$Home$Layer0$Global$dToCT(rldt),
					rcd,
					ltm),
				newgd);
		});
	var init = F3(
		function (t, lm, cd) {
			return $author$project$Scenes$Home$Layer0$Global$dToCT(
				A3(layer.init, t, lm, cd));
		});
	return A4(
		$author$project$Lib$Layer$Base$Layer,
		$author$project$Scenes$Home$Layer0$Global$dToCT(layer.data),
		init,
		update,
		view);
};
var $author$project$Scenes$Home$Layer1$Common$Button = F4(
	function (description, pos, length, width) {
		return {description: description, length: length, pos: pos, width: width};
	});
var $author$project$Scenes$Home$Layer1$Models$initButton = F4(
	function (description, _v0, len, wid) {
		var x = _v0.a;
		var y = _v0.b;
		return A4(
			$author$project$Scenes$Home$Layer1$Common$Button,
			description,
			_Utils_Tuple2(x, y),
			len,
			wid);
	});
var $author$project$Scenes$Home$Layer1$Export$nullData = {
	help: A4(
		$author$project$Scenes$Home$Layer1$Models$initButton,
		'Help',
		_Utils_Tuple2(960, 500),
		15,
		10),
	ico: 1,
	map: A4(
		$author$project$Scenes$Home$Layer1$Models$initButton,
		'Map',
		_Utils_Tuple2(960, 600),
		15,
		10),
	start: A4(
		$author$project$Scenes$Home$Layer1$Models$initButton,
		'Start',
		_Utils_Tuple2(960, 400),
		15,
		10)
};
var $author$project$Scenes$Home$Layer1$Global$ctTod = function (ldt) {
	if (ldt.$ === 'Layer1Data') {
		var x = ldt.a;
		return x;
	} else {
		return $author$project$Scenes$Home$Layer1$Export$nullData;
	}
};
var $author$project$Scenes$Home$LayerSettings$Layer1Data = function (a) {
	return {$: 'Layer1Data', a: a};
};
var $author$project$Scenes$Home$Layer1$Global$dToCT = function (data) {
	return $author$project$Scenes$Home$LayerSettings$Layer1Data(data);
};
var $author$project$Scenes$Home$Layer1$Global$getLayerCT = function (layer) {
	var view = F3(
		function (_v3, cd, gd) {
			var ldt = _v3.a;
			var t = _v3.b;
			return A3(
				layer.view,
				_Utils_Tuple2(
					$author$project$Scenes$Home$Layer1$Global$ctTod(ldt),
					t),
				cd,
				gd);
		});
	var update = F5(
		function (m, gd, lm, _v2, cd) {
			var ldt = _v2.a;
			var t = _v2.b;
			var _v0 = A5(
				layer.update,
				m,
				gd,
				lm,
				_Utils_Tuple2(
					$author$project$Scenes$Home$Layer1$Global$ctTod(ldt),
					t),
				cd);
			var _v1 = _v0.a;
			var rldt = _v1.a;
			var rcd = _v1.b;
			var ltm = _v1.c;
			var newgd = _v0.b;
			return _Utils_Tuple2(
				_Utils_Tuple3(
					$author$project$Scenes$Home$Layer1$Global$dToCT(rldt),
					rcd,
					ltm),
				newgd);
		});
	var init = F3(
		function (t, lm, cd) {
			return $author$project$Scenes$Home$Layer1$Global$dToCT(
				A3(layer.init, t, lm, cd));
		});
	return A4(
		$author$project$Lib$Layer$Base$Layer,
		$author$project$Scenes$Home$Layer1$Global$dToCT(layer.data),
		init,
		update,
		view);
};
var $author$project$Scenes$Home$Layer0$Display$dview = F3(
	function (_v0, _v1, gd) {
		return A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			_List_fromArray(
				[
					A5(
					$author$project$Lib$Render$Render$renderSprite,
					gd,
					_List_Nil,
					_Utils_Tuple2(0, 0),
					_Utils_Tuple2(1920, 1080),
					'background')
				]));
	});
var $author$project$Scenes$Home$Layer0$Models$initModel = F3(
	function (_v0, _v1, _v2) {
		return {s: 0};
	});
var $author$project$Scenes$Home$Layer0$Models$updateModel = F5(
	function (_v0, gd, _v1, _v2, cd) {
		var model = _v2.a;
		var t = _v2.b;
		return _Utils_Tuple2(
			_Utils_Tuple3(model, cd, _List_Nil),
			gd);
	});
var $author$project$Scenes$Home$Layer0$Export$layer = {data: $author$project$Scenes$Home$Layer0$Export$nullData, init: $author$project$Scenes$Home$Layer0$Models$initModel, update: $author$project$Scenes$Home$Layer0$Models$updateModel, view: $author$project$Scenes$Home$Layer0$Display$dview};
var $avh4$elm_color$Color$blue = A4($avh4$elm_color$Color$RgbaSpace, 52 / 255, 101 / 255, 164 / 255, 1.0);
var $author$project$Scenes$Home$Layer1$Display$dview = F3(
	function (_v0, _v1, gd) {
		var m = _v0.a;
		var y = m.start.pos.b;
		var x = m.start.pos.a;
		var w = m.start.width;
		var l = m.start.length;
		return A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			_List_fromArray(
				[
					A2(
					$joakin$elm_canvas$Canvas$shapes,
					_List_fromArray(
						[
							$joakin$elm_canvas$Canvas$Settings$fill($avh4$elm_color$Color$blue)
						]),
					_List_fromArray(
						[
							A3(
							$joakin$elm_canvas$Canvas$rect,
							A2($author$project$Lib$Coordinate$Coordinates$posToReal, gd, m.start.pos),
							A2($author$project$Lib$Coordinate$Coordinates$widthToReal, gd, 2 * l),
							A2($author$project$Lib$Coordinate$Coordinates$heightToReal, gd, 2 * w)),
							A3(
							$joakin$elm_canvas$Canvas$rect,
							A2(
								$author$project$Lib$Coordinate$Coordinates$posToReal,
								gd,
								_Utils_Tuple2(x, y + 100)),
							A2($author$project$Lib$Coordinate$Coordinates$widthToReal, gd, 2 * l),
							A2($author$project$Lib$Coordinate$Coordinates$heightToReal, gd, 2 * w)),
							A3(
							$joakin$elm_canvas$Canvas$rect,
							A2(
								$author$project$Lib$Coordinate$Coordinates$posToReal,
								gd,
								_Utils_Tuple2(x, y + 200)),
							A2($author$project$Lib$Coordinate$Coordinates$widthToReal, gd, 2 * l),
							A2($author$project$Lib$Coordinate$Coordinates$heightToReal, gd, 2 * w))
						])),
					A5($author$project$Lib$Render$Render$renderText, gd, 50, m.start.description, 'sans-serif', m.start.pos),
					A5($author$project$Lib$Render$Render$renderText, gd, 50, m.help.description, 'sans-serif', m.help.pos),
					A5($author$project$Lib$Render$Render$renderText, gd, 50, m.map.description, 'sans-serif', m.map.pos)
				]));
	});
var $author$project$Scenes$Home$Layer1$Models$length = 60;
var $author$project$Scenes$Home$Layer1$Models$width = 40;
var $author$project$Scenes$Home$Layer1$Models$initModel = F3(
	function (_v0, _v1, _v2) {
		return {
			help: A4(
				$author$project$Scenes$Home$Layer1$Models$initButton,
				'Help',
				_Utils_Tuple2(930, 600),
				$author$project$Scenes$Home$Layer1$Models$length,
				$author$project$Scenes$Home$Layer1$Models$width),
			ico: 1,
			map: A4(
				$author$project$Scenes$Home$Layer1$Models$initButton,
				'Map',
				_Utils_Tuple2(930, 700),
				$author$project$Scenes$Home$Layer1$Models$length,
				$author$project$Scenes$Home$Layer1$Models$width),
			start: A4(
				$author$project$Scenes$Home$Layer1$Models$initButton,
				'Start',
				_Utils_Tuple2(930, 500),
				$author$project$Scenes$Home$Layer1$Models$length,
				$author$project$Scenes$Home$Layer1$Models$width)
		};
	});
var $author$project$Lib$Layer$Base$LayerIntMsg = function (a) {
	return {$: 'LayerIntMsg', a: a};
};
var $author$project$Lib$Layer$Base$NullLayerTarget = {$: 'NullLayerTarget'};
var $author$project$Scenes$Home$Layer1$Models$updateModel = F5(
	function (msg, gd, _v0, _v1, cd) {
		var model = _v1.a;
		var t = _v1.b;
		if ((msg.$ === 'MouseDown') && (!msg.a)) {
			var _v3 = msg.b;
			var x = _v3.a;
			var y = _v3.b;
			return A4(
				$author$project$Lib$Coordinate$Coordinates$judgeMouse,
				gd,
				_Utils_Tuple2(x, y),
				_Utils_Tuple2(model.start.pos.a, model.start.pos.b),
				_Utils_Tuple2($author$project$Scenes$Home$Layer1$Models$length * 2, $author$project$Scenes$Home$Layer1$Models$width * 2)) ? _Utils_Tuple2(
				_Utils_Tuple3(
					model,
					cd,
					_List_fromArray(
						[
							_Utils_Tuple2(
							$author$project$Lib$Layer$Base$LayerParentScene,
							$author$project$Lib$Layer$Base$LayerIntMsg(1))
						])),
				gd) : (A4(
				$author$project$Lib$Coordinate$Coordinates$judgeMouse,
				gd,
				_Utils_Tuple2(x, y),
				_Utils_Tuple2(model.help.pos.a, model.help.pos.b),
				_Utils_Tuple2($author$project$Scenes$Home$Layer1$Models$length * 2, $author$project$Scenes$Home$Layer1$Models$width * 2)) ? _Utils_Tuple2(
				_Utils_Tuple3(
					model,
					cd,
					_List_fromArray(
						[
							_Utils_Tuple2(
							$author$project$Lib$Layer$Base$LayerParentScene,
							$author$project$Lib$Layer$Base$LayerIntMsg(2))
						])),
				gd) : (A4(
				$author$project$Lib$Coordinate$Coordinates$judgeMouse,
				gd,
				_Utils_Tuple2(x, y),
				_Utils_Tuple2(model.map.pos.a, model.map.pos.b),
				_Utils_Tuple2($author$project$Scenes$Home$Layer1$Models$length * 2, $author$project$Scenes$Home$Layer1$Models$width * 2)) ? _Utils_Tuple2(
				_Utils_Tuple3(
					model,
					cd,
					_List_fromArray(
						[
							_Utils_Tuple2(
							$author$project$Lib$Layer$Base$LayerParentScene,
							$author$project$Lib$Layer$Base$LayerIntMsg(3))
						])),
				gd) : _Utils_Tuple2(
				_Utils_Tuple3(
					model,
					cd,
					_List_fromArray(
						[
							_Utils_Tuple2($author$project$Lib$Layer$Base$NullLayerTarget, $author$project$Lib$Layer$Base$NullLayerMsg)
						])),
				gd)));
		} else {
			return _Utils_Tuple2(
				_Utils_Tuple3(
					model,
					cd,
					_List_fromArray(
						[
							_Utils_Tuple2($author$project$Lib$Layer$Base$NullLayerTarget, $author$project$Lib$Layer$Base$NullLayerMsg)
						])),
				gd);
		}
	});
var $author$project$Scenes$Home$Layer1$Export$layer = {data: $author$project$Scenes$Home$Layer1$Export$nullData, init: $author$project$Scenes$Home$Layer1$Models$initModel, update: $author$project$Scenes$Home$Layer1$Models$updateModel, view: $author$project$Scenes$Home$Layer1$Display$dview};
var $author$project$Scenes$Home$Model$initModel = F2(
	function (t, _v0) {
		var l1l = $author$project$Scenes$Home$Layer1$Export$layer;
		var l0l = $author$project$Scenes$Home$Layer0$Export$layer;
		var icd = {plt: 0};
		var l0ct = $author$project$Scenes$Home$Layer0$Global$getLayerCT(
			_Utils_update(
				l0l,
				{
					data: A3($author$project$Scenes$Home$Layer0$Export$layer.init, t, $author$project$Lib$Layer$Base$NullLayerMsg, icd)
				}));
		var l1ct = $author$project$Scenes$Home$Layer1$Global$getLayerCT(
			_Utils_update(
				l1l,
				{
					data: A3($author$project$Scenes$Home$Layer1$Export$layer.init, t, $author$project$Lib$Layer$Base$NullLayerMsg, icd)
				}));
		return {
			commonData: icd,
			layers: _List_fromArray(
				[
					_Utils_Tuple2('Layer0', l0ct),
					_Utils_Tuple2('Layer1', l1ct)
				])
		};
	});
var $author$project$Scenes$Home$Model$handleLayerMsg = F2(
	function (lmsg, _v0) {
		var model = _v0.a;
		if (lmsg.$ === 'LayerIntMsg') {
			var i = lmsg.a;
			return (i === 1) ? _Utils_Tuple2(
				model,
				$author$project$Lib$Scene$Base$SOChangeScene(
					_Utils_Tuple2($author$project$Lib$Scene$Base$NullSceneMsg, 'Scene1'))) : ((i === 2) ? _Utils_Tuple2(
				model,
				$author$project$Lib$Scene$Base$SOChangeScene(
					_Utils_Tuple2($author$project$Lib$Scene$Base$NullSceneMsg, 'Level1'))) : ((i === 3) ? _Utils_Tuple2(
				model,
				$author$project$Lib$Scene$Base$SOChangeScene(
					_Utils_Tuple2($author$project$Lib$Scene$Base$NullSceneMsg, 'Scene1'))) : _Utils_Tuple2(model, $author$project$Lib$Scene$Base$NullSceneOutputMsg)));
		} else {
			return _Utils_Tuple2(model, $author$project$Lib$Scene$Base$NullSceneOutputMsg);
		}
	});
var $author$project$Scenes$Home$Model$updateModel = F3(
	function (msg, gd, _v0) {
		var model = _v0.a;
		var t = _v0.b;
		var _v1 = A5($author$project$Lib$Layer$LayerHandler$updateLayer, msg, gd, t, model.commonData, model.layers);
		var _v2 = _v1.a;
		var newdata = _v2.a;
		var newcd = _v2.b;
		var msgs = _v2.c;
		var newgd = _v1.b;
		var nmodel = _Utils_update(
			model,
			{commonData: newcd, layers: newdata});
		var _v3 = A3(
			$elm$core$List$foldl,
			F2(
				function (x, _v4) {
					var y = _v4.a;
					return A2(
						$author$project$Scenes$Home$Model$handleLayerMsg,
						x,
						_Utils_Tuple2(y, t));
				}),
			_Utils_Tuple2(nmodel, $author$project$Lib$Scene$Base$NullSceneOutputMsg),
			msgs);
		var newmodel = _v3.a;
		var newso = _v3.b;
		return _Utils_Tuple3(newmodel, newso, newgd);
	});
var $author$project$Scenes$Home$Model$viewModel = F2(
	function (_v0, gd) {
		var model = _v0.a;
		var t = _v0.b;
		return A4($author$project$Lib$Layer$LayerHandler$viewLayer, gd, t, model.commonData, model.layers);
	});
var $author$project$Scenes$Home$Export$scene = {init: $author$project$Scenes$Home$Model$initModel, update: $author$project$Scenes$Home$Model$updateModel, view: $author$project$Scenes$Home$Model$viewModel};
var $author$project$Lib$Scene$Base$SceneEngineMsg = function (a) {
	return {$: 'SceneEngineMsg', a: a};
};
var $author$project$Lib$CoreEngine$GameLayer$Base$BehindActors = {$: 'BehindActors'};
var $author$project$Lib$CoreEngine$GameLayer$Base$FrontSolids = {$: 'FrontSolids'};
var $author$project$Scenes$Level1$Config$allChartlets = _List_fromArray(
	[
		_Utils_Tuple2(
		F2(
			function (gd, ggd) {
				return A5(
					$author$project$Lib$Render$Render$renderText,
					gd,
					50,
					'Hit those goombas!',
					'Times New Roman',
					A2(
						$author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera,
						_Utils_Tuple2(900, 2100),
						ggd));
			}),
		$author$project$Lib$CoreEngine$GameLayer$Base$BehindActors),
		_Utils_Tuple2(
		F2(
			function (gd, ggd) {
				return A5(
					$author$project$Lib$Render$Render$renderSprite,
					gd,
					_List_Nil,
					A2(
						$author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera,
						_Utils_Tuple2(0, 2176),
						ggd),
					_Utils_Tuple2(3840, 64),
					'background');
			}),
		$author$project$Lib$CoreEngine$GameLayer$Base$FrontSolids),
		_Utils_Tuple2(
		F2(
			function (gd, ggd) {
				return A5(
					$author$project$Lib$Render$Render$renderText,
					gd,
					40,
					'Short Description (Will be deleted in the real game, this is only for the game testers)',
					'Times New Roman',
					A2(
						$author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera,
						_Utils_Tuple2(200, 1400),
						ggd));
			}),
		$author$project$Lib$CoreEngine$GameLayer$Base$BehindActors),
		_Utils_Tuple2(
		F2(
			function (gd, ggd) {
				return A5(
					$author$project$Lib$Render$Render$renderText,
					gd,
					30,
					'1. Use Mouse to left click on any object to select it',
					'Times New Roman',
					A2(
						$author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera,
						_Utils_Tuple2(200, 1450),
						ggd));
			}),
		$author$project$Lib$CoreEngine$GameLayer$Base$BehindActors),
		_Utils_Tuple2(
		F2(
			function (gd, ggd) {
				return A5(
					$author$project$Lib$Render$Render$renderText,
					gd,
					30,
					'2. Press \'C\' key to grasp its kinetic energy(if its energy is too low, you cannot grasp it)',
					'Times New Roman',
					A2(
						$author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera,
						_Utils_Tuple2(200, 1500),
						ggd));
			}),
		$author$project$Lib$CoreEngine$GameLayer$Base$BehindActors),
		_Utils_Tuple2(
		F2(
			function (gd, ggd) {
				return A5(
					$author$project$Lib$Render$Render$renderText,
					gd,
					30,
					'3. Select any new object(Of course you can choose not to change)',
					'Times New Roman',
					A2(
						$author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera,
						_Utils_Tuple2(200, 1550),
						ggd));
			}),
		$author$project$Lib$CoreEngine$GameLayer$Base$BehindActors),
		_Utils_Tuple2(
		F2(
			function (gd, ggd) {
				return A5(
					$author$project$Lib$Render$Render$renderText,
					gd,
					30,
					'4. Right click on any position to use the kinetic energy on the chosen object',
					'Times New Roman',
					A2(
						$author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera,
						_Utils_Tuple2(200, 1600),
						ggd));
			}),
		$author$project$Lib$CoreEngine$GameLayer$Base$BehindActors),
		_Utils_Tuple2(
		F2(
			function (gd, ggd) {
				return A5(
					$author$project$Lib$Render$Render$renderText,
					gd,
					100,
					'Test Chamber',
					'Times New Roman',
					A2(
						$author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera,
						_Utils_Tuple2(200, 1250),
						ggd));
			}),
		$author$project$Lib$CoreEngine$GameLayer$Base$BehindActors)
	]);
var $author$project$Scenes$Level1$Background$background = F3(
	function (_v0, _v1, gd) {
		return A5(
			$author$project$Lib$Render$Render$renderSprite,
			gd,
			_List_fromArray(
				[
					$joakin$elm_canvas$Canvas$Settings$Advanced$alpha(0.3)
				]),
			_Utils_Tuple2(0, 0),
			_Utils_Tuple2(1920, 1080),
			'background');
	});
var $author$project$Lib$CoreEngine$GameComponents$Bullet$Base$BulletInit = F4(
	function (initPosition, initVelocity, radius, uid) {
		return {initPosition: initPosition, initVelocity: initVelocity, radius: radius, uid: uid};
	});
var $author$project$Lib$CoreEngine$GameComponents$CutScene$Base$CutSceneInit = F4(
	function (initPosition, initSize, uid, talkings) {
		return {initPosition: initPosition, initSize: initSize, talkings: talkings, uid: uid};
	});
var $author$project$Lib$CoreEngine$GameComponents$Exit$Base$ExitInit = F4(
	function (initPosition, initSize, togo, uid) {
		return {initPosition: initPosition, initSize: initSize, togo: togo, uid: uid};
	});
var $author$project$Lib$CoreEngine$GameComponent$Base$GameBulletInit = function (a) {
	return {$: 'GameBulletInit', a: a};
};
var $author$project$Lib$CoreEngine$GameComponent$Base$GameCutSceneInit = function (a) {
	return {$: 'GameCutSceneInit', a: a};
};
var $author$project$Lib$CoreEngine$GameComponent$Base$GameExitInit = function (a) {
	return {$: 'GameExitInit', a: a};
};
var $author$project$Lib$CoreEngine$GameComponent$Base$GameGoombaEmitterInit = function (a) {
	return {$: 'GameGoombaEmitterInit', a: a};
};
var $author$project$Lib$CoreEngine$GameComponent$Base$GameSpikeInit = function (a) {
	return {$: 'GameSpikeInit', a: a};
};
var $author$project$Lib$CoreEngine$GameComponents$GoombaEmitter$Base$GoombaEmitterInit = F4(
	function (initPosition, interval, goombaVelocity, uid) {
		return {goombaVelocity: goombaVelocity, initPosition: initPosition, interval: interval, uid: uid};
	});
var $author$project$Lib$CoreEngine$GameComponents$Goomba$Base$GoombaInit = F3(
	function (initPosition, initVelocity, uid) {
		return {initPosition: initPosition, initVelocity: initVelocity, uid: uid};
	});
var $author$project$Lib$CoreEngine$GameComponents$Spike$Base$HorDown = {$: 'HorDown'};
var $author$project$Lib$CoreEngine$GameComponents$Spike$Base$HorUp = {$: 'HorUp'};
var $author$project$Lib$CoreEngine$GameComponents$Spike$Base$SpikeInit = F4(
	function (initPosition, direction, spikesnum, uid) {
		return {direction: direction, initPosition: initPosition, spikesnum: spikesnum, uid: uid};
	});
var $author$project$Lib$CoreEngine$GameComponents$Spike$Base$VerRight = {$: 'VerRight'};
var $author$project$Lib$CoreEngine$GameComponents$Bullet$Model$collisionBox = {height: 30, name: 'col', offsetX: 0, offsetY: 0, width: 30};
var $author$project$Lib$CoreEngine$GameComponents$Bullet$Model$simplecheckBox = {height: 30, name: 'sp', offsetX: 0, offsetY: 0, width: 30};
var $author$project$Lib$CoreEngine$GameComponents$Bullet$Model$initData = {
	acceleration: _Utils_Tuple2(0, 0),
	collisionbox: _List_fromArray(
		[$author$project$Lib$CoreEngine$GameComponents$Bullet$Model$collisionBox]),
	extra: $elm$core$Dict$empty,
	mass: 5,
	position: _Utils_Tuple2(900, 1850),
	simplecheck: $author$project$Lib$CoreEngine$GameComponents$Bullet$Model$simplecheckBox,
	status: $author$project$Lib$CoreEngine$GameComponent$Base$Alive,
	uid: 50,
	velocity: _Utils_Tuple2(-50, 0)
};
var $author$project$Lib$CoreEngine$GameComponents$Bullet$Model$initModel = F2(
	function (_v0, gcm) {
		if (gcm.$ === 'GameBulletInit') {
			var info = gcm.a;
			return {
				acceleration: _Utils_Tuple2(0, 0),
				collisionbox: _List_fromArray(
					[$author$project$Lib$CoreEngine$GameComponents$Bullet$Model$collisionBox]),
				extra: $elm$core$Dict$fromList(
					_List_fromArray(
						[
							_Utils_Tuple2(
							'radius',
							$author$project$Lib$Component$Base$CDFloat(info.radius))
						])),
				mass: 5,
				position: info.initPosition,
				simplecheck: $author$project$Lib$CoreEngine$GameComponents$Bullet$Model$simplecheckBox,
				status: $author$project$Lib$CoreEngine$GameComponent$Base$Alive,
				uid: info.uid,
				velocity: info.initVelocity
			};
		} else {
			return $author$project$Lib$CoreEngine$GameComponents$Bullet$Model$initData;
		}
	});
var $author$project$Lib$CoreEngine$GameComponents$Bullet$Model$updateModel = F5(
	function (msg, gct, ggd, gd, _v0) {
		var d = _v0.a;
		var t = _v0.b;
		if (gct.$ === 'GameInterCollisionMsg') {
			var pd = gct.b;
			return _Utils_Tuple3(
				_Utils_update(
					d,
					{
						status: $author$project$Lib$CoreEngine$GameComponent$Base$Dead(t)
					}),
				_List_fromArray(
					[
						A2(
						$author$project$Lib$CoreEngine$GameComponent$Base$GameActorUidMsg,
						pd.uid,
						$author$project$Lib$CoreEngine$GameComponent$Base$GameStringMsg('die'))
					]),
				ggd);
		} else {
			var r = A2($author$project$Lib$DefinedTypes$Parser$dgetfloat, d.extra, 'radius');
			var _v2 = d.position;
			var x = _v2.a;
			var y = _v2.b;
			var _v3 = d.velocity;
			var vx = _v3.a;
			var vy = _v3.b;
			return (((vx < 0) && (!A3(
				$author$project$Lib$CoreEngine$Physics$SolidCollision$canMove,
				d,
				ggd,
				A2($elm_explorations$linear_algebra$Math$Vector2$vec2, -1, 0)))) || ((vx > 0) && (!A3(
				$author$project$Lib$CoreEngine$Physics$SolidCollision$canMove,
				d,
				ggd,
				A2($elm_explorations$linear_algebra$Math$Vector2$vec2, 1, 0))))) ? _Utils_Tuple3(
				_Utils_update(
					d,
					{
						status: $author$project$Lib$CoreEngine$GameComponent$Base$Dead(t)
					}),
				_List_Nil,
				ggd) : _Utils_Tuple3(
				_Utils_update(
					d,
					{
						position: _Utils_Tuple2(
							x + $elm$core$Basics$ceiling(vx / 1000),
							y + $elm$core$Basics$ceiling(vy / 1000))
					}),
				_List_Nil,
				ggd);
		}
	});
var $author$project$Lib$CoreEngine$GameComponents$Bullet$Display$view = F3(
	function (_v0, ggd, gd) {
		var d = _v0.a;
		var t = _v0.b;
		var y = A2($author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera, d.position, ggd).b;
		var x = A2($author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera, d.position, ggd).a;
		var r = A2($author$project$Lib$DefinedTypes$Parser$dgetfloat, d.extra, 'radius');
		return _Utils_eq(d.status, $author$project$Lib$CoreEngine$GameComponent$Base$Alive) ? _List_fromArray(
			[
				_Utils_Tuple2(
				A2(
					$joakin$elm_canvas$Canvas$group,
					_List_Nil,
					_List_fromArray(
						[
							A2(
							$joakin$elm_canvas$Canvas$shapes,
							_List_fromArray(
								[
									$joakin$elm_canvas$Canvas$Settings$fill($avh4$elm_color$Color$red)
								]),
							_List_fromArray(
								[
									A2(
									$joakin$elm_canvas$Canvas$circle,
									_Utils_Tuple2(x, y),
									r)
								]))
						])),
				0)
			]) : _List_fromArray(
			[
				_Utils_Tuple2(
				A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil),
				0)
			]);
	});
var $author$project$Lib$CoreEngine$GameComponents$Bullet$Export$gameComponent = {data: $author$project$Lib$CoreEngine$GameComponents$Bullet$Model$initData, init: $author$project$Lib$CoreEngine$GameComponents$Bullet$Model$initModel, name: 'bullet', update: $author$project$Lib$CoreEngine$GameComponents$Bullet$Model$updateModel, view: $author$project$Lib$CoreEngine$GameComponents$Bullet$Display$view};
var $author$project$Lib$CoreEngine$GameComponents$CutScene$Model$simplecheckBox = function (_v0) {
	var w = _v0.a;
	var h = _v0.b;
	return {height: h, name: 'sp', offsetX: 0, offsetY: 0, width: w};
};
var $author$project$Lib$CoreEngine$GameComponents$CutScene$Model$initData = {
	acceleration: _Utils_Tuple2(0, 0),
	collisionbox: _List_fromArray(
		[
			$author$project$Lib$CoreEngine$GameComponents$CutScene$Model$simplecheckBox(
			_Utils_Tuple2(0, 0))
		]),
	extra: $elm$core$Dict$empty,
	mass: 0,
	position: _Utils_Tuple2(300, 1100),
	simplecheck: $author$project$Lib$CoreEngine$GameComponents$CutScene$Model$simplecheckBox(
		_Utils_Tuple2(0, 0)),
	status: $author$project$Lib$CoreEngine$GameComponent$Base$Alive,
	uid: 888,
	velocity: _Utils_Tuple2(0, 0)
};
var $author$project$Lib$CoreEngine$GameComponents$CutScene$Model$decodeTalkings = function (talkings) {
	return $elm$core$List$concat(
		_List_fromArray(
			[
				A3(
				$elm$core$List$foldl,
				F2(
					function (_v0, _v1) {
						var charSprite = _v0.a;
						var text = _v0.b;
						var dir = _v0.c;
						var index = _v1.a;
						var list = _v1.b;
						return _Utils_Tuple2(
							index + 1,
							A2(
								$elm$core$List$append,
								list,
								_List_fromArray(
									[
										_Utils_Tuple2(
										$elm$core$String$fromInt(index) + 'textExist',
										$author$project$Lib$Component$Base$CDInt(100)),
										_Utils_Tuple2(
										$elm$core$String$fromInt(index) + 'CharSprite',
										$author$project$Lib$Component$Base$CDString(charSprite)),
										_Utils_Tuple2(
										$elm$core$String$fromInt(index) + 'Text',
										$author$project$Lib$Component$Base$CDString(text)),
										_Utils_Tuple2(
										$elm$core$String$fromInt(index) + 'Direction',
										$author$project$Lib$Component$Base$CDBool(dir))
									])));
					}),
				_Utils_Tuple2(0, _List_Nil),
				talkings).b
			]));
};
var $author$project$Lib$CoreEngine$GameComponents$CutScene$Model$initModel = F2(
	function (_v0, gcm) {
		if (gcm.$ === 'GameCutSceneInit') {
			var info = gcm.a;
			return {
				acceleration: _Utils_Tuple2(0, 0),
				collisionbox: _List_fromArray(
					[
						$author$project$Lib$CoreEngine$GameComponents$CutScene$Model$simplecheckBox(info.initSize)
					]),
				extra: $elm$core$Dict$fromList(
					$author$project$Lib$CoreEngine$GameComponents$CutScene$Model$decodeTalkings(info.talkings)),
				mass: 70,
				position: info.initPosition,
				simplecheck: $author$project$Lib$CoreEngine$GameComponents$CutScene$Model$simplecheckBox(info.initSize),
				status: $author$project$Lib$CoreEngine$GameComponent$Base$Alive,
				uid: info.uid,
				velocity: _Utils_Tuple2(0, 0)
			};
		} else {
			return $author$project$Lib$CoreEngine$GameComponents$CutScene$Model$initData;
		}
	});
var $author$project$Components$Dialog$Dialog$initDialog = F2(
	function (_v0, comMsg) {
		if (comMsg.$ === 'ComponentDictMsg') {
			var dict = comMsg.a;
			return A3(
				$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
				'_Child',
				_List_Nil,
				A3(
					$author$project$Lib$DefinedTypes$Parser$dsetint,
					'_Index',
					0,
					A3(
						$author$project$Lib$DefinedTypes$Parser$dsetint,
						'_Timer',
						0,
						A3($author$project$Lib$DefinedTypes$Parser$dsetstring, '_Status', 'OnBuild', dict))));
		} else {
			return $elm$core$Dict$empty;
		}
	});
var $author$project$Components$Dialog$NextButton$NextButton$initButton = F2(
	function (_v0, comMsg) {
		if (comMsg.$ === 'ComponentStringMsg') {
			return $elm$core$Dict$fromList(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'_Status',
						$author$project$Lib$Component$Base$CDString('OnShow')),
						_Utils_Tuple2(
						'_Timer',
						$author$project$Lib$Component$Base$CDInt(0)),
						_Utils_Tuple2(
						'_Child',
						$author$project$Lib$Component$Base$CDLComponent(_List_Nil))
					]));
		} else {
			return $elm$core$Dict$empty;
		}
	});
var $author$project$Components$Dialog$NextButton$NextButton$updateButton = F4(
	function (mainMsg, _v0, globalData, _v1) {
		var model = _v1.a;
		var t = _v1.b;
		_v2$2:
		while (true) {
			switch (mainMsg.$) {
				case 'Tick':
					var timer = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, '_Timer') + 1;
					return _Utils_Tuple3(
						A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model),
						A2(
							$author$project$Lib$Component$Base$ComponentLSStringMsg,
							'StatusReport',
							_List_fromArray(
								['OnShow'])),
						globalData);
				case 'KeyDown':
					if (mainMsg.a === 13) {
						return _Utils_Tuple3(
							A3($author$project$Lib$DefinedTypes$Parser$dsetstring, '_Status', 'OnEnd', model),
							A2(
								$author$project$Lib$Component$Base$ComponentLSStringMsg,
								'Interaction',
								_List_fromArray(
									['OnDeBuild'])),
							globalData);
					} else {
						break _v2$2;
					}
				default:
					break _v2$2;
			}
		}
		var status = A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, '_Status');
		return _Utils_Tuple3(
			model,
			A2(
				$author$project$Lib$Component$Base$ComponentLSStringMsg,
				'StatusReport',
				_List_fromArray(
					[status])),
			globalData);
	});
var $author$project$Components$Dialog$NextButton$NextButton$viewButton = F2(
	function (_v0, globalData) {
		var model = _v0.a;
		var t = _v0.b;
		return (A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, '_Status') === 'OnShow') ? A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			_List_fromArray(
				[
					A2(
					$joakin$elm_canvas$Canvas$shapes,
					_List_fromArray(
						[
							$joakin$elm_canvas$Canvas$Settings$fill($avh4$elm_color$Color$blue)
						]),
					_List_fromArray(
						[
							A3(
							$joakin$elm_canvas$Canvas$rect,
							A2(
								$author$project$Lib$Coordinate$Coordinates$posToReal,
								globalData,
								_Utils_Tuple2(1350, 320)),
							A2($author$project$Lib$Coordinate$Coordinates$widthToReal, globalData, 10),
							A2($author$project$Lib$Coordinate$Coordinates$heightToReal, globalData, 10))
						]))
				])) : A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil);
	});
var $author$project$Components$Dialog$NextButton$Export$component = {
	data: A2($author$project$Components$Dialog$NextButton$NextButton$initButton, 0, $author$project$Lib$Component$Base$NullComponentMsg),
	init: $author$project$Components$Dialog$NextButton$NextButton$initButton,
	name: 'NextButton',
	query: F2(
		function (_v0, _v1) {
			return $author$project$Lib$Component$Base$NullComponentMsg;
		}),
	update: $author$project$Components$Dialog$NextButton$NextButton$updateButton,
	view: $author$project$Components$Dialog$NextButton$NextButton$viewButton
};
var $author$project$Components$Dialog$NextButton$Export$initComponent = F2(
	function (t, ct) {
		return _Utils_update(
			$author$project$Components$Dialog$NextButton$Export$component,
			{
				data: A2($author$project$Components$Dialog$NextButton$Export$component.init, t, ct)
			});
	});
var $author$project$Components$Dialog$Text$Text$initText = F2(
	function (_v0, comMsg) {
		if (comMsg.$ === 'ComponentStringMsg') {
			var str = comMsg.a;
			return $elm$core$Dict$fromList(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'_Status',
						$author$project$Lib$Component$Base$CDString('OnBuild')),
						_Utils_Tuple2(
						'_Timer',
						$author$project$Lib$Component$Base$CDInt(0)),
						_Utils_Tuple2(
						'_wholeText',
						$author$project$Lib$Component$Base$CDString(str)),
						_Utils_Tuple2(
						'ScreenText',
						$author$project$Lib$Component$Base$CDString('')),
						_Utils_Tuple2(
						'_wholeTextLength',
						$author$project$Lib$Component$Base$CDInt(
							$elm$core$String$length(str))),
						_Utils_Tuple2(
						'_currentPos',
						$author$project$Lib$Component$Base$CDInt(-1)),
						_Utils_Tuple2(
						'_Child',
						$author$project$Lib$Component$Base$CDLComponent(_List_Nil))
					]));
		} else {
			return $elm$core$Dict$empty;
		}
	});
var $author$project$Components$Dialog$Text$Word$Word$initWord = F2(
	function (pos, comMsg) {
		if (comMsg.$ === 'ComponentStringMsg') {
			var str = comMsg.a;
			return $elm$core$Dict$fromList(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'_Status',
						$author$project$Lib$Component$Base$CDString('OnBuild')),
						_Utils_Tuple2(
						'_Timer',
						$author$project$Lib$Component$Base$CDInt(0)),
						_Utils_Tuple2(
						'_Position',
						$author$project$Lib$Component$Base$CDInt(pos)),
						_Utils_Tuple2(
						'Word',
						$author$project$Lib$Component$Base$CDString(str)),
						_Utils_Tuple2(
						'_Child',
						$author$project$Lib$Component$Base$CDLComponent(_List_Nil))
					]));
		} else {
			return $elm$core$Dict$empty;
		}
	});
var $elm$random$Random$Seed = F2(
	function (a, b) {
		return {$: 'Seed', a: a, b: b};
	});
var $elm$random$Random$next = function (_v0) {
	var state0 = _v0.a;
	var incr = _v0.b;
	return A2($elm$random$Random$Seed, ((state0 * 1664525) + incr) >>> 0, incr);
};
var $elm$random$Random$initialSeed = function (x) {
	var _v0 = $elm$random$Random$next(
		A2($elm$random$Random$Seed, 0, 1013904223));
	var state1 = _v0.a;
	var incr = _v0.b;
	var state2 = (state1 + x) >>> 0;
	return $elm$random$Random$next(
		A2($elm$random$Random$Seed, state2, incr));
};
var $elm$random$Random$Generator = function (a) {
	return {$: 'Generator', a: a};
};
var $elm$core$Bitwise$xor = _Bitwise_xor;
var $elm$random$Random$peel = function (_v0) {
	var state = _v0.a;
	var word = (state ^ (state >>> ((state >>> 28) + 4))) * 277803737;
	return ((word >>> 22) ^ word) >>> 0;
};
var $elm$random$Random$int = F2(
	function (a, b) {
		return $elm$random$Random$Generator(
			function (seed0) {
				var _v0 = (_Utils_cmp(a, b) < 0) ? _Utils_Tuple2(a, b) : _Utils_Tuple2(b, a);
				var lo = _v0.a;
				var hi = _v0.b;
				var range = (hi - lo) + 1;
				if (!((range - 1) & range)) {
					return _Utils_Tuple2(
						(((range - 1) & $elm$random$Random$peel(seed0)) >>> 0) + lo,
						$elm$random$Random$next(seed0));
				} else {
					var threshhold = (((-range) >>> 0) % range) >>> 0;
					var accountForBias = function (seed) {
						accountForBias:
						while (true) {
							var x = $elm$random$Random$peel(seed);
							var seedN = $elm$random$Random$next(seed);
							if (_Utils_cmp(x, threshhold) < 0) {
								var $temp$seed = seedN;
								seed = $temp$seed;
								continue accountForBias;
							} else {
								return _Utils_Tuple2((x % range) + lo, seedN);
							}
						}
					};
					return accountForBias(seed0);
				}
			});
	});
var $elm$random$Random$step = F2(
	function (_v0, seed) {
		var generator = _v0.a;
		return generator(seed);
	});
var $author$project$Components$Dialog$Text$Word$Word$randomPos = F3(
	function (t, l, r) {
		return A2(
			$elm$random$Random$step,
			A2($elm$random$Random$int, l, r),
			$elm$random$Random$initialSeed(t)).a;
	});
var $elm$core$List$repeatHelp = F3(
	function (result, n, value) {
		repeatHelp:
		while (true) {
			if (n <= 0) {
				return result;
			} else {
				var $temp$result = A2($elm$core$List$cons, value, result),
					$temp$n = n - 1,
					$temp$value = value;
				result = $temp$result;
				n = $temp$n;
				value = $temp$value;
				continue repeatHelp;
			}
		}
	});
var $elm$core$List$repeat = F2(
	function (n, value) {
		return A3($elm$core$List$repeatHelp, _List_Nil, n, value);
	});
var $author$project$Components$Dialog$Text$Word$Word$updateWord = F4(
	function (mainMsg, comMsg, globalData, _v0) {
		var model = _v0.a;
		var t = _v0.b;
		if (mainMsg.$ === 'Tick') {
			var timer = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, '_Timer') + 1;
			if (timer > 20) {
				return (A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, '_Status') === 'OnBuild') ? _Utils_Tuple3(
					A3(
						$author$project$Lib$DefinedTypes$Parser$dsetstring,
						'_Status',
						'OnShow',
						A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model)),
					A2(
						$author$project$Lib$Component$Base$ComponentLSStringMsg,
						'StatusReport',
						_List_fromArray(
							['OnShow'])),
					globalData) : ((A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, '_Status') === 'OnDeBuild') ? _Utils_Tuple3(
					A3(
						$author$project$Lib$DefinedTypes$Parser$dsetstring,
						'_Status',
						'OnEnd',
						A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model)),
					A2(
						$author$project$Lib$Component$Base$ComponentLSStringMsg,
						'StatusReport',
						_List_fromArray(
							['OnEnd'])),
					globalData) : _Utils_Tuple3(
					A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model),
					A2(
						$author$project$Lib$Component$Base$ComponentLSStringMsg,
						'StatusReport',
						_List_fromArray(
							[
								A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, '_Status')
							])),
					globalData));
			} else {
				if (A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, '_Status') === 'OnDeBuild') {
					var tmpCrashPos = A2($author$project$Lib$DefinedTypes$Parser$dgetLString, model, 'CrashPos');
					var newCrashPos = A2(
						$elm$core$List$map,
						function (str) {
							var list = A2($elm$core$String$split, '_', str);
							var posX = A2(
								$elm$core$Maybe$withDefault,
								0,
								$elm$core$String$toInt(
									A2(
										$elm$core$Maybe$withDefault,
										'',
										$elm$core$List$head(list))));
							var posY = A2(
								$elm$core$Maybe$withDefault,
								0,
								$elm$core$String$toInt(
									A2(
										$elm$core$Maybe$withDefault,
										'',
										$elm$core$List$head(
											$elm$core$List$reverse(list)))));
							return $elm$core$String$fromInt(
								posX + A3($author$project$Components$Dialog$Text$Word$Word$randomPos, t + posY, -10, 0)) + ('_' + $elm$core$String$fromInt(
								posY + A3($author$project$Components$Dialog$Text$Word$Word$randomPos, t + posX, -2, 2)));
						},
						tmpCrashPos);
					return _Utils_Tuple3(
						A3(
							$author$project$Lib$DefinedTypes$Parser$dsetlstring,
							'CrashPos',
							newCrashPos,
							A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model)),
						A2(
							$author$project$Lib$Component$Base$ComponentLSStringMsg,
							'StatusReport',
							_List_fromArray(
								[
									A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, '_Status')
								])),
						globalData);
				} else {
					return _Utils_Tuple3(
						A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model),
						A2(
							$author$project$Lib$Component$Base$ComponentLSStringMsg,
							'StatusReport',
							_List_fromArray(
								[
									A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, '_Status')
								])),
						globalData);
				}
			}
		} else {
			var status = A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, '_Status');
			if (comMsg.$ === 'ComponentStringMsg') {
				var demand = comMsg.a;
				if (demand === 'OnDeBuild') {
					return _Utils_Tuple3(
						A3(
							$author$project$Lib$DefinedTypes$Parser$dsetlstring,
							'CrashPos',
							A2(
								$elm$core$List$repeat,
								20,
								$elm$core$String$fromInt(
									A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, '_Position') + 650) + ('_' + $elm$core$String$fromInt(120))),
							A3(
								$author$project$Lib$DefinedTypes$Parser$dsetint,
								'_Timer',
								0,
								A3($author$project$Lib$DefinedTypes$Parser$dsetstring, '_Status', 'OnDeBuild', model))),
						A2(
							$author$project$Lib$Component$Base$ComponentLSStringMsg,
							'StatusReport',
							_List_fromArray(
								['OnDeBuild'])),
						globalData);
				} else {
					return _Utils_Tuple3(
						model,
						A2(
							$author$project$Lib$Component$Base$ComponentLSStringMsg,
							'StatusReport',
							_List_fromArray(
								[status])),
						globalData);
				}
			} else {
				return _Utils_Tuple3(
					model,
					A2(
						$author$project$Lib$Component$Base$ComponentLSStringMsg,
						'StatusReport',
						_List_fromArray(
							[status])),
					globalData);
			}
		}
	});
var $author$project$Components$Dialog$Text$Word$Word$viewWord = F2(
	function (_v0, globalData) {
		var model = _v0.a;
		var t = _v0.b;
		var timer = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, '_Timer');
		var status = A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, '_Status');
		var position = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, '_Position');
		switch (status) {
			case 'OnBuild':
				return A2(
					$joakin$elm_canvas$Canvas$group,
					_List_fromArray(
						[
							$joakin$elm_canvas$Canvas$Settings$Advanced$alpha(timer / 20.0)
						]),
					_List_fromArray(
						[
							A5(
							$author$project$Lib$Render$Render$renderText,
							globalData,
							30,
							A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, 'Word'),
							'Times New Roman',
							_Utils_Tuple2(650 + position, 100))
						]));
			case 'OnShow':
				return A2(
					$joakin$elm_canvas$Canvas$group,
					_List_Nil,
					_List_fromArray(
						[
							A5(
							$author$project$Lib$Render$Render$renderText,
							globalData,
							30,
							A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, 'Word'),
							'Times New Roman',
							_Utils_Tuple2(650 + position, 100))
						]));
			case 'OnDeBuild':
				return A2(
					$joakin$elm_canvas$Canvas$group,
					_List_fromArray(
						[
							$joakin$elm_canvas$Canvas$Settings$Advanced$alpha(1.0 - (timer / 20.0))
						]),
					A2(
						$elm$core$List$append,
						_List_fromArray(
							[
								A5(
								$author$project$Lib$Render$Render$renderText,
								globalData,
								30,
								A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, 'Word'),
								'Times New Roman',
								_Utils_Tuple2(650 + position, 100))
							]),
						A2(
							$elm$core$List$map,
							function (str) {
								var list = A2($elm$core$String$split, '_', str);
								var posX = A2(
									$elm$core$Maybe$withDefault,
									0,
									$elm$core$String$toInt(
										A2(
											$elm$core$Maybe$withDefault,
											'',
											$elm$core$List$head(list))));
								var posY = A2(
									$elm$core$Maybe$withDefault,
									0,
									$elm$core$String$toInt(
										A2(
											$elm$core$Maybe$withDefault,
											'',
											$elm$core$List$head(
												$elm$core$List$reverse(list)))));
								return A2(
									$joakin$elm_canvas$Canvas$shapes,
									_List_fromArray(
										[
											$joakin$elm_canvas$Canvas$Settings$Advanced$alpha(1.0 - (timer / 10.0))
										]),
									_List_fromArray(
										[
											A3(
											$joakin$elm_canvas$Canvas$rect,
											A2(
												$author$project$Lib$Coordinate$Coordinates$posToReal,
												globalData,
												_Utils_Tuple2(posX, posY)),
											A2($author$project$Lib$Coordinate$Coordinates$widthToReal, globalData, 2),
											A2($author$project$Lib$Coordinate$Coordinates$heightToReal, globalData, 2))
										]));
							},
							A2($author$project$Lib$DefinedTypes$Parser$dgetLString, model, 'CrashPos'))));
			default:
				return A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil);
		}
	});
var $author$project$Components$Dialog$Text$Word$Export$component = {
	data: A2($author$project$Components$Dialog$Text$Word$Word$initWord, 0, $author$project$Lib$Component$Base$NullComponentMsg),
	init: $author$project$Components$Dialog$Text$Word$Word$initWord,
	name: 'Word',
	query: F2(
		function (_v0, _v1) {
			return $author$project$Lib$Component$Base$NullComponentMsg;
		}),
	update: $author$project$Components$Dialog$Text$Word$Word$updateWord,
	view: $author$project$Components$Dialog$Text$Word$Word$viewWord
};
var $author$project$Components$Dialog$Text$Word$Export$initComponent = F2(
	function (t, ct) {
		return _Utils_update(
			$author$project$Components$Dialog$Text$Word$Export$component,
			{
				data: A2($author$project$Components$Dialog$Text$Word$Export$component.init, t, ct)
			});
	});
var $author$project$Components$Dialog$Text$Text$updateText = F4(
	function (mainMsg, comMsg, globalData, _v0) {
		var model = _v0.a;
		var t = _v0.b;
		if (mainMsg.$ === 'Tick') {
			var wholeLength = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, '_wholeTextLength');
			var timer = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, '_Timer') + 1;
			var currentPos = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, '_currentPos') + 1;
			var currentLength = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, '_currentLength') + $elm$core$Basics$floor(
				A2($author$project$Lib$Coordinate$Coordinates$heightToReal, globalData, 30));
			var childComponentsList = A2($author$project$Lib$DefinedTypes$Parser$dgetLComponent, model, '_Child');
			var _v2 = A3(
				$elm$core$List$foldl,
				F2(
					function (_v3, _v4) {
						var comName = _v3.a;
						var comModel = _v3.b;
						var tmpComponentsList = _v4.a;
						var tmpComponentsMsg = _v4.b;
						var _v5 = A4(
							comModel.update,
							mainMsg,
							$author$project$Lib$Component$Base$NullComponentMsg,
							globalData,
							_Utils_Tuple2(comModel.data, t));
						var tmpData = _v5.a;
						var tmpMsg = _v5.b;
						return _Utils_Tuple2(
							A2(
								$elm$core$List$append,
								tmpComponentsList,
								_List_fromArray(
									[
										_Utils_Tuple2(
										comName,
										_Utils_update(
											comModel,
											{data: tmpData}))
									])),
							A2(
								$elm$core$List$append,
								tmpComponentsMsg,
								_List_fromArray(
									[tmpMsg])));
					}),
				_Utils_Tuple2(_List_Nil, _List_Nil),
				childComponentsList);
			var newChildComponentsList = _v2.a;
			var allChildComponentsMsg = _v2.b;
			if (_Utils_cmp(currentPos, wholeLength) > 0) {
				if (A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, '_Status') === 'OnBuild') {
					return _Utils_Tuple3(
						A3(
							$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
							'_Child',
							newChildComponentsList,
							A3(
								$author$project$Lib$DefinedTypes$Parser$dsetstring,
								'_Status',
								'OnShow',
								A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model))),
						A2(
							$author$project$Lib$Component$Base$ComponentLSStringMsg,
							'StatusReport',
							_List_fromArray(
								['OnShow'])),
						globalData);
				} else {
					if (A2(
						$elm$core$List$all,
						function (x) {
							return _Utils_eq(
								x,
								A2(
									$author$project$Lib$Component$Base$ComponentLSStringMsg,
									'StatusReport',
									_List_fromArray(
										['OnEnd'])));
						},
						allChildComponentsMsg)) {
						return _Utils_Tuple3(
							A3(
								$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
								'_Child',
								newChildComponentsList,
								A3(
									$author$project$Lib$DefinedTypes$Parser$dsetstring,
									'_Status',
									'OnEnd',
									A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model))),
							A2(
								$author$project$Lib$Component$Base$ComponentLSStringMsg,
								'StatusReport',
								_List_fromArray(
									['OnEnd'])),
							globalData);
					} else {
						if (A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, '_Status') === 'OnDeBuild') {
							var _v6 = A3(
								$elm$core$List$foldl,
								F2(
									function (_v7, _v8) {
										var comName = _v7.a;
										var comModel = _v7.b;
										var tmpComponentsList = _v8.a;
										var tmpAllMsg = _v8.b;
										var tmpFlag = _v8.c;
										var tmpMsg = A2(
											$elm$core$Maybe$withDefault,
											$author$project$Lib$Component$Base$NullComponentMsg,
											$elm$core$List$head(tmpAllMsg));
										var _v9 = (_Utils_eq(
											tmpMsg,
											A2(
												$author$project$Lib$Component$Base$ComponentLSStringMsg,
												'StatusReport',
												_List_fromArray(
													['OnShow']))) && tmpFlag) ? A4(
											comModel.update,
											$author$project$Base$UnknownMsg,
											$author$project$Lib$Component$Base$ComponentStringMsg('OnDeBuild'),
											globalData,
											_Utils_Tuple2(comModel.data, t)) : A4(
											comModel.update,
											mainMsg,
											$author$project$Lib$Component$Base$NullComponentMsg,
											globalData,
											_Utils_Tuple2(comModel.data, t));
										var tmpData = _v9.a;
										return (_Utils_eq(
											tmpMsg,
											A2(
												$author$project$Lib$Component$Base$ComponentLSStringMsg,
												'StatusReport',
												_List_fromArray(
													['OnShow']))) && tmpFlag) ? _Utils_Tuple3(
											A2(
												$elm$core$List$append,
												tmpComponentsList,
												_List_fromArray(
													[
														_Utils_Tuple2(
														comName,
														_Utils_update(
															comModel,
															{data: tmpData}))
													])),
											A2($elm$core$List$drop, 1, tmpAllMsg),
											false) : _Utils_Tuple3(
											A2(
												$elm$core$List$append,
												tmpComponentsList,
												_List_fromArray(
													[
														_Utils_Tuple2(
														comName,
														_Utils_update(
															comModel,
															{data: tmpData}))
													])),
											A2($elm$core$List$drop, 1, tmpAllMsg),
											tmpFlag);
									}),
								_Utils_Tuple3(_List_Nil, allChildComponentsMsg, true),
								childComponentsList);
							var tmpChildComponentsList = _v6.a;
							return _Utils_Tuple3(
								A3(
									$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
									'_Child',
									tmpChildComponentsList,
									A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model)),
								A2(
									$author$project$Lib$Component$Base$ComponentLSStringMsg,
									'StatusReport',
									_List_fromArray(
										[
											A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, '_Status')
										])),
								globalData);
						} else {
							return _Utils_Tuple3(
								A3(
									$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
									'_Child',
									newChildComponentsList,
									A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model)),
								A2(
									$author$project$Lib$Component$Base$ComponentLSStringMsg,
									'StatusReport',
									_List_fromArray(
										[
											A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, '_Status')
										])),
								globalData);
						}
					}
				}
			} else {
				var tmpChar = A3(
					$elm$core$String$slice,
					currentPos,
					currentPos + 1,
					A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, '_wholeText'));
				return _Utils_Tuple3(
					A3(
						$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
						'_Child',
						A2(
							$elm$core$List$append,
							newChildComponentsList,
							_List_fromArray(
								[
									_Utils_Tuple2(
									'Word' + $elm$core$String$fromInt(currentPos),
									A2(
										$author$project$Components$Dialog$Text$Word$Export$initComponent,
										currentLength,
										$author$project$Lib$Component$Base$ComponentStringMsg(tmpChar)))
								])),
						A3(
							$author$project$Lib$DefinedTypes$Parser$dsetint,
							'_currentLength',
							currentLength,
							A3(
								$author$project$Lib$DefinedTypes$Parser$dsetint,
								'_currentPos',
								currentPos,
								A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model)))),
					A2(
						$author$project$Lib$Component$Base$ComponentLSStringMsg,
						'StatusReport',
						_List_fromArray(
							['OnBuild'])),
					globalData);
			}
		} else {
			var status = A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, '_Status');
			if (comMsg.$ === 'ComponentStringMsg') {
				var demand = comMsg.a;
				if (demand === 'OnDeBuild') {
					return _Utils_Tuple3(
						A3($author$project$Lib$DefinedTypes$Parser$dsetstring, '_Status', 'OnDeBuild', model),
						A2(
							$author$project$Lib$Component$Base$ComponentLSStringMsg,
							'StatusReport',
							_List_fromArray(
								['OnDeBuild'])),
						globalData);
				} else {
					return _Utils_Tuple3(
						model,
						A2(
							$author$project$Lib$Component$Base$ComponentLSStringMsg,
							'StatusReport',
							_List_fromArray(
								[status])),
						globalData);
				}
			} else {
				return _Utils_Tuple3(
					model,
					A2(
						$author$project$Lib$Component$Base$ComponentLSStringMsg,
						'StatusReport',
						_List_fromArray(
							[status])),
					globalData);
			}
		}
	});
var $author$project$Components$Dialog$Text$Text$viewText = F2(
	function (_v0, globalData) {
		var model = _v0.a;
		var t = _v0.b;
		var childComponentsList = A2($author$project$Lib$DefinedTypes$Parser$dgetLComponent, model, '_Child');
		return A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			A2(
				$elm$core$List$map,
				function (_v1) {
					var comModel = _v1.b;
					return A2(
						comModel.view,
						_Utils_Tuple2(comModel.data, t),
						globalData);
				},
				childComponentsList));
	});
var $author$project$Components$Dialog$Text$Export$component = {
	data: A2($author$project$Components$Dialog$Text$Text$initText, 0, $author$project$Lib$Component$Base$NullComponentMsg),
	init: $author$project$Components$Dialog$Text$Text$initText,
	name: 'Text',
	query: F2(
		function (_v0, _v1) {
			return $author$project$Lib$Component$Base$NullComponentMsg;
		}),
	update: $author$project$Components$Dialog$Text$Text$updateText,
	view: $author$project$Components$Dialog$Text$Text$viewText
};
var $author$project$Components$Dialog$Text$Export$initComponent = F2(
	function (t, ct) {
		return _Utils_update(
			$author$project$Components$Dialog$Text$Export$component,
			{
				data: A2($author$project$Components$Dialog$Text$Export$component.init, t, ct)
			});
	});
var $author$project$Components$Dialog$Dialog$checkStatusReport = F4(
	function (list, childComponentsList, globalData, _v0) {
		var model = _v0.a;
		var t = _v0.b;
		var timer = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, '_Timer') + 1;
		var statusReport = A2(
			$elm$core$Maybe$withDefault,
			'',
			$elm$core$List$head(list));
		switch (statusReport) {
			case 'OnBuild':
				return _Utils_Tuple3(
					A3(
						$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
						'_Child',
						childComponentsList,
						A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model)),
					$author$project$Lib$Component$Base$NullComponentMsg,
					globalData);
			case 'OnShow':
				return _Utils_Tuple3(
					A3(
						$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
						'_Child',
						A2(
							$elm$core$List$append,
							childComponentsList,
							_List_fromArray(
								[
									_Utils_Tuple2(
									'NextButton',
									A2(
										$author$project$Components$Dialog$NextButton$Export$initComponent,
										0,
										$author$project$Lib$Component$Base$ComponentStringMsg('')))
								])),
						A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model)),
					$author$project$Lib$Component$Base$NullComponentMsg,
					globalData);
			case 'OnDeBuild':
				return _Utils_Tuple3(
					A3(
						$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
						'_Child',
						childComponentsList,
						A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model)),
					$author$project$Lib$Component$Base$NullComponentMsg,
					globalData);
			case 'OnEnd':
				var newChildComponentsList = A2(
					$elm$core$List$filter,
					function (_v2) {
						var comName = _v2.a;
						return ((comName === 'Text') || (comName === 'NextButton')) ? false : true;
					},
					childComponentsList);
				var index = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, '_Index') + 1;
				return (A2(
					$author$project$Lib$DefinedTypes$Parser$dgetint,
					model,
					$elm$core$String$fromInt(index) + 'textExist') === 100) ? _Utils_Tuple3(
					A3(
						$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
						'_Child',
						A2(
							$elm$core$List$append,
							newChildComponentsList,
							_List_fromArray(
								[
									_Utils_Tuple2(
									'Text',
									A2(
										$author$project$Components$Dialog$Text$Export$initComponent,
										0,
										$author$project$Lib$Component$Base$ComponentStringMsg(
											A2(
												$author$project$Lib$DefinedTypes$Parser$dgetString,
												model,
												$elm$core$String$fromInt(index) + 'Text'))))
								])),
						A3(
							$author$project$Lib$DefinedTypes$Parser$dsetint,
							'_Index',
							index,
							A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model))),
					$author$project$Lib$Component$Base$NullComponentMsg,
					globalData) : _Utils_Tuple3(
					A3(
						$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
						'_Child',
						newChildComponentsList,
						A3(
							$author$project$Lib$DefinedTypes$Parser$dsetstring,
							'_Status',
							'OnDeBuild',
							A3(
								$author$project$Lib$DefinedTypes$Parser$dsetint,
								'_Index',
								index,
								A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', 0, model)))),
					$author$project$Lib$Component$Base$NullComponentMsg,
					globalData);
			default:
				return _Utils_Tuple3(
					A3(
						$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
						'_Child',
						childComponentsList,
						A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model)),
					$author$project$Lib$Component$Base$NullComponentMsg,
					globalData);
		}
	});
var $author$project$Components$Dialog$Dialog$updateDialog = F4(
	function (mainMsg, _v0, globalData, _v1) {
		var model = _v1.a;
		var t = _v1.b;
		if (mainMsg.$ === 'Tick') {
			var timer = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, '_Timer') + 1;
			var status = A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, '_Status');
			var _v3 = _Utils_Tuple2(status, timer);
			switch (_v3.a) {
				case 'OnBuild':
					if (_v3.b === 10) {
						var index = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, '_Index');
						return _Utils_Tuple3(
							A3(
								$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
								'_Child',
								_List_fromArray(
									[
										_Utils_Tuple2(
										'Text',
										A2(
											$author$project$Components$Dialog$Text$Export$initComponent,
											0,
											$author$project$Lib$Component$Base$ComponentStringMsg(
												A2(
													$author$project$Lib$DefinedTypes$Parser$dgetString,
													model,
													$elm$core$String$fromInt(index) + 'Text'))))
									]),
								A3(
									$author$project$Lib$DefinedTypes$Parser$dsetstring,
									'_Status',
									'OnShow',
									A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model))),
							$author$project$Lib$Component$Base$NullComponentMsg,
							globalData);
					} else {
						return _Utils_Tuple3(
							A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model),
							$author$project$Lib$Component$Base$NullComponentMsg,
							globalData);
					}
				case 'OnShow':
					var childComponentsList = A2($author$project$Lib$DefinedTypes$Parser$dgetLComponent, model, '_Child');
					var _v4 = A3(
						$elm$core$List$foldl,
						F2(
							function (_v5, _v6) {
								var comName = _v5.a;
								var comModel = _v5.b;
								var tmpComponentsList = _v6.a;
								var tmpComponentsMsg = _v6.b;
								if (comName === 'Text') {
									var _v7 = A4(
										comModel.update,
										mainMsg,
										$author$project$Lib$Component$Base$NullComponentMsg,
										globalData,
										_Utils_Tuple2(comModel.data, t));
									var tmpData = _v7.a;
									var tmpMsg = _v7.b;
									return _Utils_Tuple2(
										A2(
											$elm$core$List$append,
											tmpComponentsList,
											_List_fromArray(
												[
													_Utils_Tuple2(
													comName,
													_Utils_update(
														comModel,
														{data: tmpData}))
												])),
										tmpMsg);
								} else {
									var _v8 = A4(
										comModel.update,
										mainMsg,
										$author$project$Lib$Component$Base$NullComponentMsg,
										globalData,
										_Utils_Tuple2(comModel.data, t));
									var tmpData = _v8.a;
									return _Utils_Tuple2(
										A2(
											$elm$core$List$append,
											tmpComponentsList,
											_List_fromArray(
												[
													_Utils_Tuple2(
													comName,
													_Utils_update(
														comModel,
														{data: tmpData}))
												])),
										tmpComponentsMsg);
								}
							}),
						_Utils_Tuple2(_List_Nil, $author$project$Lib$Component$Base$NullComponentMsg),
						childComponentsList);
					var newChildComponentsList = _v4.a;
					var newChildComponentMsg = _v4.b;
					if (newChildComponentMsg.$ === 'ComponentLSStringMsg') {
						var demand = newChildComponentMsg.a;
						var list = newChildComponentMsg.b;
						if (demand === 'StatusReport') {
							return A4(
								$author$project$Components$Dialog$Dialog$checkStatusReport,
								list,
								newChildComponentsList,
								globalData,
								_Utils_Tuple2(model, t));
						} else {
							return _Utils_Tuple3(
								A3(
									$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
									'_Child',
									newChildComponentsList,
									A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model)),
								$author$project$Lib$Component$Base$NullComponentMsg,
								globalData);
						}
					} else {
						return _Utils_Tuple3(
							A3(
								$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
								'_Child',
								newChildComponentsList,
								A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model)),
							$author$project$Lib$Component$Base$NullComponentMsg,
							globalData);
					}
				case 'OnDeBuild':
					if (_v3.b === 10) {
						return _Utils_Tuple3(
							A3(
								$author$project$Lib$DefinedTypes$Parser$dsetstring,
								'_Status',
								'OnEnd',
								A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model)),
							$author$project$Lib$Component$Base$NullComponentMsg,
							globalData);
					} else {
						return _Utils_Tuple3(
							A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model),
							$author$project$Lib$Component$Base$NullComponentMsg,
							globalData);
					}
				case 'OnEnd':
					return _Utils_Tuple3(
						model,
						$author$project$Lib$Component$Base$ComponentStringMsg('OnEnd'),
						globalData);
				default:
					return _Utils_Tuple3(
						A3($author$project$Lib$DefinedTypes$Parser$dsetint, '_Timer', timer, model),
						$author$project$Lib$Component$Base$NullComponentMsg,
						globalData);
			}
		} else {
			var childComponetsList = A2($author$project$Lib$DefinedTypes$Parser$dgetLComponent, model, '_Child');
			var _v11 = A3(
				$elm$core$List$foldl,
				F2(
					function (_v12, _v13) {
						var comName = _v12.a;
						var comModel = _v12.b;
						var tmpComponentsList = _v13.a;
						var tmpComponentsMsg = _v13.b;
						if (comName === 'NextButton') {
							var _v14 = A4(
								comModel.update,
								mainMsg,
								$author$project$Lib$Component$Base$NullComponentMsg,
								globalData,
								_Utils_Tuple2(comModel.data, t));
							var tmpData = _v14.a;
							var tmpMsg = _v14.b;
							return _Utils_Tuple2(
								A2(
									$elm$core$List$append,
									tmpComponentsList,
									_List_fromArray(
										[
											_Utils_Tuple2(
											comName,
											_Utils_update(
												comModel,
												{data: tmpData}))
										])),
								tmpMsg);
						} else {
							return _Utils_Tuple2(
								A2(
									$elm$core$List$append,
									tmpComponentsList,
									_List_fromArray(
										[
											_Utils_Tuple2(comName, comModel)
										])),
								tmpComponentsMsg);
						}
					}),
				_Utils_Tuple2(_List_Nil, $author$project$Lib$Component$Base$NullComponentMsg),
				childComponetsList);
			var newChildComponentsList = _v11.a;
			var newChildComponentMsg = _v11.b;
			if (newChildComponentMsg.$ === 'ComponentLSStringMsg') {
				var demand = newChildComponentMsg.a;
				var list = newChildComponentMsg.b;
				if (demand === 'Interaction') {
					var request = A2(
						$elm$core$Maybe$withDefault,
						'',
						$elm$core$List$head(list));
					if (request === 'OnDeBuild') {
						var _v17 = A3(
							$elm$core$List$foldl,
							F2(
								function (_v18, _v19) {
									var comName = _v18.a;
									var comModel = _v18.b;
									var tmpComponentsList = _v19.a;
									var tmpComponentsMsg = _v19.b;
									if (comName === 'Text') {
										var _v20 = A4(
											comModel.update,
											$author$project$Base$UnknownMsg,
											$author$project$Lib$Component$Base$ComponentStringMsg('OnDeBuild'),
											globalData,
											_Utils_Tuple2(comModel.data, t));
										var tmpData = _v20.a;
										var tmpMsg = _v20.b;
										return _Utils_Tuple2(
											A2(
												$elm$core$List$append,
												tmpComponentsList,
												_List_fromArray(
													[
														_Utils_Tuple2(
														comName,
														_Utils_update(
															comModel,
															{data: tmpData}))
													])),
											tmpMsg);
									} else {
										return _Utils_Tuple2(
											A2(
												$elm$core$List$append,
												tmpComponentsList,
												_List_fromArray(
													[
														_Utils_Tuple2(comName, comModel)
													])),
											tmpComponentsMsg);
									}
								}),
							_Utils_Tuple2(_List_Nil, $author$project$Lib$Component$Base$NullComponentMsg),
							childComponetsList);
						var tmpChildComponentsList = _v17.a;
						return _Utils_Tuple3(
							A3($author$project$Lib$DefinedTypes$Parser$dsetLComponent, '_Child', tmpChildComponentsList, model),
							$author$project$Lib$Component$Base$NullComponentMsg,
							globalData);
					} else {
						return _Utils_Tuple3(
							A3($author$project$Lib$DefinedTypes$Parser$dsetLComponent, '_Child', newChildComponentsList, model),
							$author$project$Lib$Component$Base$NullComponentMsg,
							globalData);
					}
				} else {
					return _Utils_Tuple3(
						A3($author$project$Lib$DefinedTypes$Parser$dsetLComponent, '_Child', newChildComponentsList, model),
						$author$project$Lib$Component$Base$NullComponentMsg,
						globalData);
				}
			} else {
				return _Utils_Tuple3(
					A3($author$project$Lib$DefinedTypes$Parser$dsetLComponent, '_Child', newChildComponentsList, model),
					$author$project$Lib$Component$Base$NullComponentMsg,
					globalData);
			}
		}
	});
var $author$project$Components$Dialog$Dialog$viewDialog = F2(
	function (_v0, globalData) {
		var model = _v0.a;
		var t = _v0.b;
		var timer = A2($author$project$Lib$DefinedTypes$Parser$dgetint, model, '_Timer');
		var status = A2($author$project$Lib$DefinedTypes$Parser$dgetString, model, '_Status');
		var childComponentsList = A2($author$project$Lib$DefinedTypes$Parser$dgetLComponent, model, '_Child');
		switch (status) {
			case 'OnBuild':
				return A2(
					$joakin$elm_canvas$Canvas$group,
					_List_Nil,
					A2(
						$elm$core$List$append,
						_List_fromArray(
							[
								A2(
								$joakin$elm_canvas$Canvas$shapes,
								_List_fromArray(
									[
										$joakin$elm_canvas$Canvas$Settings$stroke($avh4$elm_color$Color$black)
									]),
								_List_fromArray(
									[
										A3(
										$joakin$elm_canvas$Canvas$rect,
										A2(
											$author$project$Lib$Coordinate$Coordinates$posToReal,
											globalData,
											_Utils_Tuple2(600, 200 - (15 * timer))),
										A2($author$project$Lib$Coordinate$Coordinates$widthToReal, globalData, 800),
										A2($author$project$Lib$Coordinate$Coordinates$heightToReal, globalData, 30 * timer))
									]))
							]),
						A2(
							$elm$core$List$map,
							function (_v2) {
								var comModel = _v2.b;
								return A2(
									comModel.view,
									_Utils_Tuple2(comModel.data, t),
									globalData);
							},
							childComponentsList)));
			case 'OnDeBuild':
				return A2(
					$joakin$elm_canvas$Canvas$group,
					_List_Nil,
					A2(
						$elm$core$List$append,
						_List_fromArray(
							[
								A2(
								$joakin$elm_canvas$Canvas$shapes,
								_List_fromArray(
									[
										$joakin$elm_canvas$Canvas$Settings$stroke($avh4$elm_color$Color$black)
									]),
								_List_fromArray(
									[
										A3(
										$joakin$elm_canvas$Canvas$rect,
										A2(
											$author$project$Lib$Coordinate$Coordinates$posToReal,
											globalData,
											_Utils_Tuple2(600, 50 + (15 * timer))),
										A2($author$project$Lib$Coordinate$Coordinates$widthToReal, globalData, 800),
										A2($author$project$Lib$Coordinate$Coordinates$heightToReal, globalData, 300 - (30 * timer)))
									]))
							]),
						A2(
							$elm$core$List$map,
							function (_v3) {
								var comModel = _v3.b;
								return A2(
									comModel.view,
									_Utils_Tuple2(comModel.data, t),
									globalData);
							},
							childComponentsList)));
			case 'OnEnd':
				return A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil);
			default:
				return A2(
					$joakin$elm_canvas$Canvas$group,
					_List_Nil,
					A2(
						$elm$core$List$append,
						_List_fromArray(
							[
								A2(
								$joakin$elm_canvas$Canvas$shapes,
								_List_fromArray(
									[
										$joakin$elm_canvas$Canvas$Settings$stroke($avh4$elm_color$Color$black)
									]),
								_List_fromArray(
									[
										A3(
										$joakin$elm_canvas$Canvas$rect,
										A2(
											$author$project$Lib$Coordinate$Coordinates$posToReal,
											globalData,
											_Utils_Tuple2(600, 50)),
										A2($author$project$Lib$Coordinate$Coordinates$widthToReal, globalData, 800),
										A2($author$project$Lib$Coordinate$Coordinates$heightToReal, globalData, 300))
									]))
							]),
						A2(
							$elm$core$List$map,
							function (_v4) {
								var comModel = _v4.b;
								return A2(
									comModel.view,
									_Utils_Tuple2(comModel.data, t),
									globalData);
							},
							childComponentsList)));
		}
	});
var $author$project$Components$Dialog$Export$component = {
	data: A2($author$project$Components$Dialog$Dialog$initDialog, 0, $author$project$Lib$Component$Base$NullComponentMsg),
	init: $author$project$Components$Dialog$Dialog$initDialog,
	name: 'Menu',
	query: F2(
		function (_v0, _v1) {
			return $author$project$Lib$Component$Base$NullComponentMsg;
		}),
	update: $author$project$Components$Dialog$Dialog$updateDialog,
	view: $author$project$Components$Dialog$Dialog$viewDialog
};
var $author$project$Components$Dialog$Export$initComponent = F2(
	function (t, ct) {
		return _Utils_update(
			$author$project$Components$Dialog$Export$component,
			{
				data: A2($author$project$Components$Dialog$Export$component.init, t, ct)
			});
	});
var $author$project$Lib$CoreEngine$GameComponents$CutScene$Model$updateModel = F5(
	function (msg, gct, ggd, globalData, _v0) {
		var d = _v0.a;
		var t = _v0.b;
		if ((gct.$ === 'GameInterCollisionMsg') && (gct.a === 'player')) {
			var talkings = d.extra;
			return _Utils_eq(
				A2($author$project$Lib$DefinedTypes$Parser$dgetLComponent, d.extra, '_Child'),
				_List_Nil) ? _Utils_Tuple3(
				_Utils_update(
					d,
					{
						extra: A3(
							$author$project$Lib$DefinedTypes$Parser$dsetLComponent,
							'_Child',
							_List_fromArray(
								[
									_Utils_Tuple2(
									'Dialog',
									A2(
										$author$project$Components$Dialog$Export$initComponent,
										0,
										$author$project$Lib$Component$Base$ComponentDictMsg(talkings)))
								]),
							d.extra)
					}),
				_List_Nil,
				ggd) : _Utils_Tuple3(d, _List_Nil, ggd);
		} else {
			var data = d.extra;
			var componentsList = A2($author$project$Lib$DefinedTypes$Parser$dgetLComponent, data, '_Child');
			var _v2 = A3(
				$elm$core$List$foldl,
				F2(
					function (_v3, _v4) {
						var comName = _v3.a;
						var comModel = _v3.b;
						var tmpComList = _v4.a;
						var tmpComMsgList = _v4.b;
						var tmpGData = _v4.c;
						var _v5 = A4(
							comModel.update,
							msg,
							$author$project$Lib$Component$Base$NullComponentMsg,
							tmpGData,
							_Utils_Tuple2(comModel.data, t));
						var tmpCom = _v5.a;
						var tmpComMsg = _v5.b;
						var gD = _v5.c;
						return _Utils_Tuple3(
							A2(
								$elm$core$List$append,
								tmpComList,
								_List_fromArray(
									[
										_Utils_Tuple2(
										comName,
										_Utils_update(
											comModel,
											{data: tmpCom}))
									])),
							A2(
								$elm$core$List$append,
								tmpComMsgList,
								_List_fromArray(
									[tmpComMsg])),
							gD);
					}),
				_Utils_Tuple3(_List_Nil, _List_Nil, globalData),
				componentsList);
			var tmpChildComponentsList = _v2.a;
			var tmpChildComponentsMsg = _v2.b;
			if (((tmpChildComponentsMsg.b && (tmpChildComponentsMsg.a.$ === 'ComponentStringMsg')) && (tmpChildComponentsMsg.a.a === 'OnEnd')) && (!tmpChildComponentsMsg.b.b)) {
				return _Utils_Tuple3(
					_Utils_update(
						d,
						{
							extra: A3($author$project$Lib$DefinedTypes$Parser$dsetLComponent, '_Child', _List_Nil, d.extra)
						}),
					_List_Nil,
					ggd);
			} else {
				return _Utils_Tuple3(
					_Utils_update(
						d,
						{
							extra: A3($author$project$Lib$DefinedTypes$Parser$dsetLComponent, '_Child', tmpChildComponentsList, d.extra)
						}),
					_List_Nil,
					ggd);
			}
		}
	});
var $author$project$Lib$CoreEngine$GameComponents$CutScene$Display$view = F3(
	function (_v0, ggd, gd) {
		var d = _v0.a;
		var t = _v0.b;
		var data = d.extra;
		var componentsList = A2($author$project$Lib$DefinedTypes$Parser$dgetLComponent, data, '_Child');
		return _List_fromArray(
			[
				_Utils_Tuple2(
				A2(
					$joakin$elm_canvas$Canvas$group,
					_List_Nil,
					_List_fromArray(
						[
							A5(
							$author$project$Lib$Render$Render$renderSprite,
							gd,
							_List_Nil,
							A2($author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera, d.position, ggd),
							_Utils_Tuple2(d.simplecheck.width, d.simplecheck.height),
							'background')
						])),
				0),
				_Utils_Tuple2(
				A2(
					$joakin$elm_canvas$Canvas$group,
					_List_Nil,
					A2(
						$elm$core$List$map,
						function (_v1) {
							var comName = _v1.a;
							var comModel = _v1.b;
							return A2(
								comModel.view,
								_Utils_Tuple2(comModel.data, t),
								gd);
						},
						componentsList)),
				0)
			]);
	});
var $author$project$Lib$CoreEngine$GameComponents$CutScene$Export$gameComponent = {data: $author$project$Lib$CoreEngine$GameComponents$CutScene$Model$initData, init: $author$project$Lib$CoreEngine$GameComponents$CutScene$Model$initModel, name: 'CutScene', update: $author$project$Lib$CoreEngine$GameComponents$CutScene$Model$updateModel, view: $author$project$Lib$CoreEngine$GameComponents$CutScene$Display$view};
var $author$project$Lib$CoreEngine$GameComponents$Exit$Model$simplecheckBox = function (_v0) {
	var w = _v0.a;
	var h = _v0.b;
	return {height: h, name: 'sp', offsetX: 0, offsetY: 0, width: w};
};
var $author$project$Lib$CoreEngine$GameComponents$Exit$Model$initData = {
	acceleration: _Utils_Tuple2(0, 0),
	collisionbox: _List_fromArray(
		[
			$author$project$Lib$CoreEngine$GameComponents$Exit$Model$simplecheckBox(
			_Utils_Tuple2(0, 0))
		]),
	extra: $elm$core$Dict$empty,
	mass: 0,
	position: _Utils_Tuple2(300, 1100),
	simplecheck: $author$project$Lib$CoreEngine$GameComponents$Exit$Model$simplecheckBox(
		_Utils_Tuple2(0, 0)),
	status: $author$project$Lib$CoreEngine$GameComponent$Base$Alive,
	uid: 999,
	velocity: _Utils_Tuple2(0, 0)
};
var $author$project$Lib$CoreEngine$GameComponents$Exit$Model$initModel = F2(
	function (_v0, gcm) {
		if (gcm.$ === 'GameExitInit') {
			var info = gcm.a;
			return {
				acceleration: _Utils_Tuple2(0, 0),
				collisionbox: _List_fromArray(
					[
						$author$project$Lib$CoreEngine$GameComponents$Exit$Model$simplecheckBox(info.initSize)
					]),
				extra: $elm$core$Dict$fromList(
					_List_fromArray(
						[
							_Utils_Tuple2(
							'togo',
							$author$project$Lib$Component$Base$CDString(info.togo))
						])),
				mass: 70,
				position: info.initPosition,
				simplecheck: $author$project$Lib$CoreEngine$GameComponents$Exit$Model$simplecheckBox(info.initSize),
				status: $author$project$Lib$CoreEngine$GameComponent$Base$Alive,
				uid: info.uid,
				velocity: _Utils_Tuple2(0, 0)
			};
		} else {
			return $author$project$Lib$CoreEngine$GameComponents$Exit$Model$initData;
		}
	});
var $author$project$Lib$CoreEngine$GameComponent$Base$GameExitScene = function (a) {
	return {$: 'GameExitScene', a: a};
};
var $author$project$Lib$CoreEngine$GameComponent$Base$GameParentMsg = function (a) {
	return {$: 'GameParentMsg', a: a};
};
var $author$project$Lib$CoreEngine$GameComponents$Exit$Model$updateModel = F5(
	function (_v0, gct, ggd, _v1, _v2) {
		var d = _v2.a;
		var t = _v2.b;
		if ((gct.$ === 'GameInterCollisionMsg') && (gct.a === 'player')) {
			return _Utils_Tuple3(
				d,
				_List_fromArray(
					[
						$author$project$Lib$CoreEngine$GameComponent$Base$GameParentMsg(
						$author$project$Lib$CoreEngine$GameComponent$Base$GameExitScene(
							A2($author$project$Lib$DefinedTypes$Parser$dgetString, d.extra, 'togo')))
					]),
				ggd);
		} else {
			return _Utils_Tuple3(d, _List_Nil, ggd);
		}
	});
var $author$project$Lib$CoreEngine$GameComponents$Exit$Display$view = F3(
	function (_v0, ggd, gd) {
		var d = _v0.a;
		var t = _v0.b;
		return _List_fromArray(
			[
				_Utils_Tuple2(
				A2(
					$joakin$elm_canvas$Canvas$group,
					_List_Nil,
					_List_fromArray(
						[
							A5(
							$author$project$Lib$Render$Render$renderSprite,
							gd,
							_List_Nil,
							A2($author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera, d.position, ggd),
							_Utils_Tuple2(d.simplecheck.width, d.simplecheck.height),
							'background')
						])),
				0)
			]);
	});
var $author$project$Lib$CoreEngine$GameComponents$Exit$Export$gameComponent = {data: $author$project$Lib$CoreEngine$GameComponents$Exit$Model$initData, init: $author$project$Lib$CoreEngine$GameComponents$Exit$Model$initModel, name: 'exit', update: $author$project$Lib$CoreEngine$GameComponents$Exit$Model$updateModel, view: $author$project$Lib$CoreEngine$GameComponents$Exit$Display$view};
var $author$project$Lib$CoreEngine$GameComponents$GoombaEmitter$Model$simplecheckBox = {height: 0, name: 'sp', offsetX: 0, offsetY: 0, width: 0};
var $author$project$Lib$CoreEngine$GameComponents$GoombaEmitter$Model$initData = {
	acceleration: _Utils_Tuple2(0, 0),
	collisionbox: _List_fromArray(
		[$author$project$Lib$CoreEngine$GameComponents$GoombaEmitter$Model$simplecheckBox]),
	extra: $elm$core$Dict$empty,
	mass: 0,
	position: _Utils_Tuple2(0, 0),
	simplecheck: $author$project$Lib$CoreEngine$GameComponents$GoombaEmitter$Model$simplecheckBox,
	status: $author$project$Lib$CoreEngine$GameComponent$Base$Alive,
	uid: 999,
	velocity: _Utils_Tuple2(0, 0)
};
var $author$project$Lib$CoreEngine$GameComponents$GoombaEmitter$Model$initModel = F2(
	function (_v0, gcm) {
		if (gcm.$ === 'GameGoombaEmitterInit') {
			var info = gcm.a;
			return {
				acceleration: _Utils_Tuple2(0, 0),
				collisionbox: _List_fromArray(
					[$author$project$Lib$CoreEngine$GameComponents$GoombaEmitter$Model$simplecheckBox]),
				extra: $elm$core$Dict$fromList(
					_List_fromArray(
						[
							_Utils_Tuple2(
							'interval',
							$author$project$Lib$Component$Base$CDInt(info.interval)),
							_Utils_Tuple2(
							'goombaVelocityX',
							$author$project$Lib$Component$Base$CDFloat(info.goombaVelocity.a)),
							_Utils_Tuple2(
							'goombaVelocityY',
							$author$project$Lib$Component$Base$CDFloat(info.goombaVelocity.b))
						])),
				mass: 0,
				position: info.initPosition,
				simplecheck: $author$project$Lib$CoreEngine$GameComponents$GoombaEmitter$Model$simplecheckBox,
				status: $author$project$Lib$CoreEngine$GameComponent$Base$Alive,
				uid: info.uid,
				velocity: _Utils_Tuple2(0, 0)
			};
		} else {
			return $author$project$Lib$CoreEngine$GameComponents$GoombaEmitter$Model$initData;
		}
	});
var $author$project$Lib$CoreEngine$GameComponents$GoombaEmitter$Model$updateModel = F5(
	function (_v0, _v1, ggd, _v2, _v3) {
		var d = _v3.a;
		var t = _v3.b;
		var interval = A2($author$project$Lib$DefinedTypes$Parser$dgetint, d.extra, 'interval');
		if (!A2($elm$core$Basics$modBy, interval, t)) {
			var v = _Utils_Tuple2(
				A2($author$project$Lib$DefinedTypes$Parser$dgetfloat, d.extra, 'goombaVelocityX'),
				A2($author$project$Lib$DefinedTypes$Parser$dgetfloat, d.extra, 'goombaVelocityY'));
			return _Utils_Tuple3(
				d,
				_List_fromArray(
					[
						$author$project$Lib$CoreEngine$GameComponent$Base$GameParentMsg(
						$author$project$Lib$CoreEngine$GameComponent$Base$GameGoombaInit(
							{initPosition: d.position, initVelocity: v, uid: 0}))
					]),
				ggd);
		} else {
			return _Utils_Tuple3(d, _List_Nil, ggd);
		}
	});
var $author$project$Lib$CoreEngine$GameComponents$GoombaEmitter$Display$view = F3(
	function (_v0, _v1, _v2) {
		return _List_Nil;
	});
var $author$project$Lib$CoreEngine$GameComponents$GoombaEmitter$Export$gameComponent = {data: $author$project$Lib$CoreEngine$GameComponents$GoombaEmitter$Model$initData, init: $author$project$Lib$CoreEngine$GameComponents$GoombaEmitter$Model$initModel, name: 'goombaemitter', update: $author$project$Lib$CoreEngine$GameComponents$GoombaEmitter$Model$updateModel, view: $author$project$Lib$CoreEngine$GameComponents$GoombaEmitter$Display$view};
var $author$project$Lib$CoreEngine$GameComponents$Spike$Model$simplecheckBox = F2(
	function (sd, ss) {
		switch (sd.$) {
			case 'HorUp':
				return {height: 20, name: 'sp', offsetX: 0, offsetY: 0, width: ss * 32};
			case 'HorDown':
				return {height: 20, name: 'sp', offsetX: 0, offsetY: 0, width: ss * 32};
			case 'VerLeft':
				return {height: ss * 32, name: 'sp', offsetX: 0, offsetY: 0, width: 20};
			default:
				return {height: ss * 32, name: 'sp', offsetX: 0, offsetY: 0, width: 20};
		}
	});
var $author$project$Lib$CoreEngine$GameComponents$Spike$Model$initData = {
	acceleration: _Utils_Tuple2(0, 0),
	collisionbox: _List_fromArray(
		[
			A2($author$project$Lib$CoreEngine$GameComponents$Spike$Model$simplecheckBox, $author$project$Lib$CoreEngine$GameComponents$Spike$Base$HorDown, 1)
		]),
	extra: $elm$core$Dict$empty,
	mass: 0,
	position: _Utils_Tuple2(300, 1100),
	simplecheck: A2($author$project$Lib$CoreEngine$GameComponents$Spike$Model$simplecheckBox, $author$project$Lib$CoreEngine$GameComponents$Spike$Base$HorUp, 1),
	status: $author$project$Lib$CoreEngine$GameComponent$Base$Alive,
	uid: 999,
	velocity: _Utils_Tuple2(0, 0)
};
var $author$project$Lib$CoreEngine$GameComponents$Spike$Model$colBox = F2(
	function (sd, ss) {
		switch (sd.$) {
			case 'HorUp':
				return {height: 18, name: 'col', offsetX: 0, offsetY: 2, width: ss * 32};
			case 'HorDown':
				return {height: 18, name: 'col', offsetX: 0, offsetY: 0, width: ss * 32};
			case 'VerLeft':
				return {height: ss * 32, name: 'col', offsetX: 2, offsetY: 0, width: 18};
			default:
				return {height: ss * 32, name: 'col', offsetX: 0, offsetY: 0, width: 18};
		}
	});
var $author$project$Lib$CoreEngine$GameComponents$Spike$Model$initModel = F2(
	function (_v0, gct) {
		if (gct.$ === 'GameSpikeInit') {
			var info = gct.a;
			return {
				acceleration: _Utils_Tuple2(0, 0),
				collisionbox: _List_fromArray(
					[
						A2($author$project$Lib$CoreEngine$GameComponents$Spike$Model$colBox, info.direction, info.spikesnum)
					]),
				extra: $elm$core$Dict$fromList(
					_List_fromArray(
						[
							_Utils_Tuple2(
							'direction',
							$author$project$Lib$Component$Base$CDInt(
								function () {
									var _v2 = info.direction;
									switch (_v2.$) {
										case 'HorUp':
											return 0;
										case 'HorDown':
											return 1;
										case 'VerLeft':
											return 2;
										default:
											return 3;
									}
								}())),
							_Utils_Tuple2(
							'number',
							$author$project$Lib$Component$Base$CDInt(info.spikesnum))
						])),
				mass: 0,
				position: info.initPosition,
				simplecheck: A2($author$project$Lib$CoreEngine$GameComponents$Spike$Model$simplecheckBox, info.direction, info.spikesnum),
				status: $author$project$Lib$CoreEngine$GameComponent$Base$Alive,
				uid: info.uid,
				velocity: _Utils_Tuple2(0, 0)
			};
		} else {
			return $author$project$Lib$CoreEngine$GameComponents$Spike$Model$initData;
		}
	});
var $author$project$Lib$CoreEngine$GameComponents$Spike$Model$updateModel = F5(
	function (_v0, gct, ggd, _v1, _v2) {
		var d = _v2.a;
		var t = _v2.b;
		if (gct.$ === 'GameInterCollisionMsg') {
			var pd = gct.b;
			return _Utils_Tuple3(
				d,
				_List_fromArray(
					[
						A2(
						$author$project$Lib$CoreEngine$GameComponent$Base$GameActorUidMsg,
						pd.uid,
						$author$project$Lib$CoreEngine$GameComponent$Base$GameStringMsg('die'))
					]),
				ggd);
		} else {
			return _Utils_Tuple3(d, _List_Nil, ggd);
		}
	});
var $author$project$Lib$CoreEngine$GameComponents$Spike$Display$renderSingleSpike = F5(
	function (d, ggd, gd, dir, num) {
		var _v0 = d.position;
		var px = _v0.a;
		var py = _v0.b;
		switch (dir) {
			case 0:
				var startx = 32 * num;
				return A5(
					$author$project$Lib$Render$Render$renderSprite,
					gd,
					_List_Nil,
					A2(
						$author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera,
						_Utils_Tuple2(px + startx, py),
						ggd),
					_Utils_Tuple2(32, 20),
					'spikeT');
			case 1:
				var startx = 32 * num;
				return A5(
					$author$project$Lib$Render$Render$renderSprite,
					gd,
					_List_Nil,
					A2(
						$author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera,
						_Utils_Tuple2(px + startx, py),
						ggd),
					_Utils_Tuple2(32, 20),
					'spikeB');
			case 2:
				var startx = 32 * num;
				return A5(
					$author$project$Lib$Render$Render$renderSprite,
					gd,
					_List_Nil,
					A2(
						$author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera,
						_Utils_Tuple2(px, py + startx),
						ggd),
					_Utils_Tuple2(20, 32),
					'spikeL');
			case 3:
				var startx = 32 * num;
				return A5(
					$author$project$Lib$Render$Render$renderSprite,
					gd,
					_List_Nil,
					A2(
						$author$project$Lib$CoreEngine$Camera$Position$getPositionUnderCamera,
						_Utils_Tuple2(px, py + startx),
						ggd),
					_Utils_Tuple2(20, 32),
					'spikeR');
			default:
				return A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil);
		}
	});
var $author$project$Lib$CoreEngine$GameComponents$Spike$Display$view = F3(
	function (_v0, ggd, gd) {
		var d = _v0.a;
		var npn = A2($author$project$Lib$DefinedTypes$Parser$dgetint, d.extra, 'number');
		var ndir = A2($author$project$Lib$DefinedTypes$Parser$dgetint, d.extra, 'direction');
		return _List_fromArray(
			[
				_Utils_Tuple2(
				A2(
					$joakin$elm_canvas$Canvas$group,
					_List_Nil,
					A2(
						$elm$core$List$map,
						function (k) {
							return A5($author$project$Lib$CoreEngine$GameComponents$Spike$Display$renderSingleSpike, d, ggd, gd, ndir, k);
						},
						A2($elm$core$List$range, 0, npn - 1))),
				0)
			]);
	});
var $author$project$Lib$CoreEngine$GameComponents$Spike$Export$gameComponent = {data: $author$project$Lib$CoreEngine$GameComponents$Spike$Model$initData, init: $author$project$Lib$CoreEngine$GameComponents$Spike$Model$initModel, name: 'spike', update: $author$project$Lib$CoreEngine$GameComponents$Spike$Model$updateModel, view: $author$project$Lib$CoreEngine$GameComponents$Spike$Display$view};
var $author$project$Scenes$Level1$Config$initActors = function (t) {
	return $elm$core$Array$fromList(
		_List_fromArray(
			[
				A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GameGoombaInit(
					A3(
						$author$project$Lib$CoreEngine$GameComponents$Goomba$Base$GoombaInit,
						_Utils_Tuple2(1200, 1800),
						_Utils_Tuple2(0, 0),
						4)),
				$author$project$Lib$CoreEngine$GameComponents$Goomba$Export$gameComponent),
				A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GameGoombaInit(
					A3(
						$author$project$Lib$CoreEngine$GameComponents$Goomba$Base$GoombaInit,
						_Utils_Tuple2(1000, 1800),
						_Utils_Tuple2(0, 0),
						5)),
				$author$project$Lib$CoreEngine$GameComponents$Goomba$Export$gameComponent),
				A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GameGoombaInit(
					A3(
						$author$project$Lib$CoreEngine$GameComponents$Goomba$Base$GoombaInit,
						_Utils_Tuple2(2000, 800),
						_Utils_Tuple2(0, 0),
						2)),
				$author$project$Lib$CoreEngine$GameComponents$Goomba$Export$gameComponent),
				A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GameGoombaInit(
					A3(
						$author$project$Lib$CoreEngine$GameComponents$Goomba$Base$GoombaInit,
						_Utils_Tuple2(3500, 500),
						_Utils_Tuple2(0, 0),
						3)),
				$author$project$Lib$CoreEngine$GameComponents$Goomba$Export$gameComponent),
				A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GameExitInit(
					A4(
						$author$project$Lib$CoreEngine$GameComponents$Exit$Base$ExitInit,
						_Utils_Tuple2(3800, 1600),
						_Utils_Tuple2(10, 160),
						'Scene1',
						9)),
				$author$project$Lib$CoreEngine$GameComponents$Exit$Export$gameComponent),
				A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GameCutSceneInit(
					A4(
						$author$project$Lib$CoreEngine$GameComponents$CutScene$Base$CutSceneInit,
						_Utils_Tuple2(100, 1800),
						_Utils_Tuple2(100, 160),
						88,
						_List_fromArray(
							[
								_Utils_Tuple3('1', 'yes jnot jeudnst', true),
								_Utils_Tuple3('1', 'no i feel bad', true)
							]))),
				$author$project$Lib$CoreEngine$GameComponents$CutScene$Export$gameComponent),
				A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GameGoombaEmitterInit(
					A4(
						$author$project$Lib$CoreEngine$GameComponents$GoombaEmitter$Base$GoombaEmitterInit,
						_Utils_Tuple2(900, 1800),
						200,
						_Utils_Tuple2(-50, 0),
						6)),
				$author$project$Lib$CoreEngine$GameComponents$GoombaEmitter$Export$gameComponent),
				A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GameSpikeInit(
					A4(
						$author$project$Lib$CoreEngine$GameComponents$Spike$Base$SpikeInit,
						_Utils_Tuple2(704, 2028),
						$author$project$Lib$CoreEngine$GameComponents$Spike$Base$HorUp,
						1,
						10)),
				$author$project$Lib$CoreEngine$GameComponents$Spike$Export$gameComponent),
				A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GameSpikeInit(
					A4(
						$author$project$Lib$CoreEngine$GameComponents$Spike$Base$SpikeInit,
						_Utils_Tuple2(736, 2048),
						$author$project$Lib$CoreEngine$GameComponents$Spike$Base$VerRight,
						3,
						11)),
				$author$project$Lib$CoreEngine$GameComponents$Spike$Export$gameComponent),
				A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GameSpikeInit(
					A4(
						$author$project$Lib$CoreEngine$GameComponents$Spike$Base$SpikeInit,
						_Utils_Tuple2(864, 2016),
						$author$project$Lib$CoreEngine$GameComponents$Spike$Base$HorDown,
						15,
						12)),
				$author$project$Lib$CoreEngine$GameComponents$Spike$Export$gameComponent),
				A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GameBulletInit(
					A4(
						$author$project$Lib$CoreEngine$GameComponents$Bullet$Base$BulletInit,
						_Utils_Tuple2(1800, 1900),
						_Utils_Tuple2(-50, 0),
						15,
						13)),
				$author$project$Lib$CoreEngine$GameComponents$Bullet$Export$gameComponent)
			]));
};
var $author$project$Lib$CoreEngine$Export$initEngine = F2(
	function (t, sm) {
		return A2($author$project$Lib$CoreEngine$Model$initModel, t, sm);
	});
var $author$project$Components$Hints$Hints$initHints = F2(
	function (t, ct) {
		if (ct.$ === 'ComponentLStringMsg') {
			var xs = ct.a;
			return $elm$core$Dict$fromList(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'hints',
						$author$project$Lib$Component$Base$CDLString(xs)),
						_Utils_Tuple2(
						'starttime',
						$author$project$Lib$Component$Base$CDInt(t))
					]));
		} else {
			return $elm$core$Dict$empty;
		}
	});
var $author$project$Components$Hints$Hints$updateHints = F4(
	function (_v0, _v1, gd, _v2) {
		var d = _v2.a;
		return _Utils_Tuple3(d, $author$project$Lib$Component$Base$NullComponentMsg, gd);
	});
var $author$project$Components$Hints$Hints$genalpha = function (k) {
	return (k < 0) ? 0 : ((k < 70) ? ((1 / 70) * k) : ((k < 170) ? 1 : ((k < 240) ? ((((-1) / 70) * k) + (24 / 7)) : 0)));
};
var $author$project$Components$Hints$Hints$viewHints = F2(
	function (_v0, gd) {
		var d = _v0.a;
		var t = _v0.b;
		var startshow = 150;
		var st = A2($author$project$Lib$DefinedTypes$Parser$dgetint, d, 'starttime');
		var elapsed = t - st;
		var qstart = elapsed - startshow;
		var stage = A2($elm$core$Basics$modBy, 280, qstart);
		var cursentn = (qstart / 280) | 0;
		var allhints = A2($author$project$Lib$DefinedTypes$Parser$dgetLString, d, 'hints');
		var curh = A2(
			$elm$core$Maybe$withDefault,
			'',
			$elm$core$List$head(
				A2($elm$core$List$drop, cursentn, allhints)));
		return (qstart < 0) ? A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil) : A2(
			$joakin$elm_canvas$Canvas$group,
			_List_fromArray(
				[
					$joakin$elm_canvas$Canvas$Settings$Advanced$alpha(
					$author$project$Components$Hints$Hints$genalpha(stage))
				]),
			_List_fromArray(
				[
					A5(
					$author$project$Lib$Render$Render$renderText,
					gd,
					30,
					curh,
					'Times New Roman',
					_Utils_Tuple2(750, 700))
				]));
	});
var $author$project$Components$Hints$Export$component = {
	data: A2($author$project$Components$Hints$Hints$initHints, 0, $author$project$Lib$Component$Base$NullComponentMsg),
	init: $author$project$Components$Hints$Hints$initHints,
	name: 'Hints',
	query: F2(
		function (_v0, _v1) {
			return $author$project$Lib$Component$Base$NullComponentMsg;
		}),
	update: $author$project$Components$Hints$Hints$updateHints,
	view: $author$project$Components$Hints$Hints$viewHints
};
var $author$project$Components$Hints$Export$initComponent = F2(
	function (t, ct) {
		return _Utils_update(
			$author$project$Components$Hints$Export$component,
			{
				data: A2($author$project$Components$Hints$Export$component.init, t, ct)
			});
	});
var $author$project$Scenes$Level1$Config$initFrontGroundComponents = function (t) {
	return $elm$core$Array$fromList(
		_List_fromArray(
			[
				A2(
				$author$project$Components$Hints$Export$initComponent,
				t,
				$author$project$Lib$Component$Base$ComponentLStringMsg(
					_List_fromArray(
						['Use W,A,D to move and jump', 'Use Esc to call the menu'])))
			]));
};
var $author$project$Scenes$Level1$Config$initCamera = A4(
	$author$project$Lib$CoreEngine$Camera$Base$CameraData,
	_Utils_Tuple2(0, 1120),
	_Utils_Tuple2(0, 0),
	_Utils_Tuple2(
		_Utils_Tuple2(32, 0),
		_Utils_Tuple2((32 * 119) - 1, (70 * 32) - 1)),
	_Utils_Tuple2(
		_Utils_Tuple2(0.2, 0.3),
		_Utils_Tuple2(0.4, 0.4)));
var $author$project$Lib$Map$Poly$buildrectT = F3(
	function (_v0, _v1, ss) {
		var x = _v0.a;
		var y = _v0.b;
		var w = _v1.a;
		var h = _v1.b;
		var ys = A2($elm$core$List$range, y, (y + h) - 1);
		var xs = A2($elm$core$List$range, x, (x + w) - 1);
		return A3(
			$elm$core$List$foldl,
			F2(
				function (i, arr) {
					return A3(
						$elm$core$List$foldl,
						F2(
							function (j, arr2) {
								return A4($tortus$elm_array_2d$Array2D$set, i, j, i + 11, arr2);
							}),
						arr,
						ys);
				}),
			ss,
			xs);
	});
var $author$project$Scenes$Level1$Map$sds = A3($tortus$elm_array_2d$Array2D$repeat, 120, 70, 0);
var $author$project$Scenes$Level1$Map$mymap = A4(
	$author$project$Lib$Map$Poly$buildrect,
	_Utils_Tuple2(75, 55),
	_Utils_Tuple2(44, 1),
	1,
	A4(
		$author$project$Lib$Map$Poly$buildrect,
		_Utils_Tuple2(60, 48),
		_Utils_Tuple2(10, 1),
		1,
		A4(
			$author$project$Lib$Map$Poly$buildrect,
			_Utils_Tuple2(47, 52),
			_Utils_Tuple2(10, 1),
			1,
			A4(
				$author$project$Lib$Map$Poly$buildrect,
				_Utils_Tuple2(41, 61),
				_Utils_Tuple2(1, 1),
				1,
				A4(
					$author$project$Lib$Map$Poly$buildrect,
					_Utils_Tuple2(27, 61),
					_Utils_Tuple2(1, 1),
					1,
					A4(
						$author$project$Lib$Map$Poly$buildrect,
						_Utils_Tuple2(27, 62),
						_Utils_Tuple2(15, 1),
						1,
						A3(
							$author$project$Lib$Map$Poly$buildrectT,
							_Utils_Tuple2(20, 64),
							_Utils_Tuple2(3, 3),
							A4(
								$author$project$Lib$Map$Poly$buildrect,
								_Utils_Tuple2(119, 0),
								_Utils_Tuple2(1, 70),
								1,
								A4(
									$author$project$Lib$Map$Poly$buildrect,
									_Utils_Tuple2(0, 0),
									_Utils_Tuple2(120, 1),
									1,
									A4(
										$author$project$Lib$Map$Poly$buildrect,
										_Utils_Tuple2(0, 68),
										_Utils_Tuple2(120, 2),
										1,
										A4(
											$author$project$Lib$Map$Poly$buildrect,
											_Utils_Tuple2(0, 0),
											_Utils_Tuple2(1, 70),
											1,
											$author$project$Scenes$Level1$Map$sds)))))))))));
var $author$project$Scenes$Level1$Config$initGameGlobalData = function (e) {
	return {
		camera: $author$project$Scenes$Level1$Config$initCamera,
		currentScene: 'Level1',
		energy: e,
		ingamepause: false,
		mapsize: _Utils_Tuple2(120, 70),
		selectobj: 1,
		solidmap: $author$project$Scenes$Level1$Map$mymap
	};
};
var $author$project$Lib$CoreEngine$GameComponent$Base$GamePlayerInit = function (a) {
	return {$: 'GamePlayerInit', a: a};
};
var $author$project$Lib$CoreEngine$GameComponents$Player$Base$PlayerInit = function (initPosition) {
	return {initPosition: initPosition};
};
var $author$project$Scenes$Level1$Config$initPlayer = F2(
	function (t, pos) {
		if (pos.$ === 'DefaultPlayerPosition') {
			return A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GamePlayerInit(
					$author$project$Lib$CoreEngine$GameComponents$Player$Base$PlayerInit(
						_Utils_Tuple2(50, 2000))),
				$author$project$Lib$CoreEngine$GameComponents$Player$Export$gameComponent);
		} else {
			var x = pos.a;
			return A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GamePlayerInit(
					$author$project$Lib$CoreEngine$GameComponents$Player$Base$PlayerInit(x)),
				$author$project$Lib$CoreEngine$GameComponents$Player$Export$gameComponent);
		}
	});
var $author$project$Lib$Scene$Base$nullEngineT = {energy: 2000, playerPosition: $author$project$Lib$Scene$Base$DefaultPlayerPosition};
var $author$project$Scenes$Level1$Export$game = F2(
	function (t, sm) {
		var engineMsg = function () {
			if (sm.$ === 'SceneEngineTMsg') {
				var x = sm.a;
				return x;
			} else {
				return $author$project$Lib$Scene$Base$nullEngineT;
			}
		}();
		return A2(
			$author$project$Lib$CoreEngine$Export$initEngine,
			t,
			$author$project$Lib$Scene$Base$SceneEngineMsg(
				{
					actors: $author$project$Scenes$Level1$Config$initActors(t),
					background: _Utils_Tuple2($elm$core$Array$empty, $author$project$Scenes$Level1$Background$background),
					chartlets: $author$project$Scenes$Level1$Config$allChartlets,
					frontground: _Utils_Tuple2(
						$author$project$Scenes$Level1$Config$initFrontGroundComponents(t),
						F3(
							function (_v0, _v1, _v2) {
								return A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil);
							})),
					globalData: $author$project$Scenes$Level1$Config$initGameGlobalData(engineMsg.energy),
					player: A2($author$project$Scenes$Level1$Config$initPlayer, t, engineMsg.playerPosition)
				}));
	});
var $author$project$Lib$CoreEngine$Export$genEngineScene = function (f) {
	return {
		init: F2(
			function (t, m) {
				return A2(f, t, m);
			}),
		update: $author$project$Lib$CoreEngine$Model$updateModel,
		view: $author$project$Lib$CoreEngine$Model$viewModel
	};
};
var $author$project$Scenes$Level1$Export$scene = $author$project$Lib$CoreEngine$Export$genEngineScene($author$project$Scenes$Level1$Export$game);
var $author$project$Scenes$Level2$Config$allChartlets = _List_Nil;
var $author$project$Scenes$Level2$Background$background = F3(
	function (_v0, _v1, gd) {
		return A5(
			$author$project$Lib$Render$Render$renderSprite,
			gd,
			_List_fromArray(
				[
					$joakin$elm_canvas$Canvas$Settings$Advanced$alpha(0.3)
				]),
			_Utils_Tuple2(0, 0),
			_Utils_Tuple2(1920, 1080),
			'background');
	});
var $author$project$Scenes$Level2$Config$initActors = function (t) {
	return $elm$core$Array$fromList(
		_List_fromArray(
			[
				A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GameGoombaInit(
					A3(
						$author$project$Lib$CoreEngine$GameComponents$Goomba$Base$GoombaInit,
						_Utils_Tuple2(1200, 1800),
						_Utils_Tuple2(0, 0),
						4)),
				$author$project$Lib$CoreEngine$GameComponents$Goomba$Export$gameComponent),
				A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GameGoombaInit(
					A3(
						$author$project$Lib$CoreEngine$GameComponents$Goomba$Base$GoombaInit,
						_Utils_Tuple2(1000, 1800),
						_Utils_Tuple2(0, 0),
						5)),
				$author$project$Lib$CoreEngine$GameComponents$Goomba$Export$gameComponent),
				A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GameGoombaInit(
					A3(
						$author$project$Lib$CoreEngine$GameComponents$Goomba$Base$GoombaInit,
						_Utils_Tuple2(2000, 800),
						_Utils_Tuple2(0, 0),
						2)),
				$author$project$Lib$CoreEngine$GameComponents$Goomba$Export$gameComponent),
				A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GameGoombaInit(
					A3(
						$author$project$Lib$CoreEngine$GameComponents$Goomba$Base$GoombaInit,
						_Utils_Tuple2(3500, 500),
						_Utils_Tuple2(0, 0),
						3)),
				$author$project$Lib$CoreEngine$GameComponents$Goomba$Export$gameComponent),
				A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GameExitInit(
					A4(
						$author$project$Lib$CoreEngine$GameComponents$Exit$Base$ExitInit,
						_Utils_Tuple2(3800, 1600),
						_Utils_Tuple2(10, 160),
						'Scene1',
						9)),
				$author$project$Lib$CoreEngine$GameComponents$Exit$Export$gameComponent),
				A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GameSpikeInit(
					A4(
						$author$project$Lib$CoreEngine$GameComponents$Spike$Base$SpikeInit,
						_Utils_Tuple2(864, 2016),
						$author$project$Lib$CoreEngine$GameComponents$Spike$Base$HorDown,
						15,
						12)),
				$author$project$Lib$CoreEngine$GameComponents$Spike$Export$gameComponent)
			]));
};
var $author$project$Scenes$Level2$Config$initFrontGroundComponents = function (_v0) {
	return $elm$core$Array$fromList(_List_Nil);
};
var $author$project$Scenes$Level2$Config$initCamera = A4(
	$author$project$Lib$CoreEngine$Camera$Base$CameraData,
	_Utils_Tuple2(0, 1120),
	_Utils_Tuple2(0, 0),
	_Utils_Tuple2(
		_Utils_Tuple2(32, 0),
		_Utils_Tuple2((32 * 119) - 1, (70 * 32) - 1)),
	_Utils_Tuple2(
		_Utils_Tuple2(0.2, 0.3),
		_Utils_Tuple2(0.4, 0.4)));
var $author$project$Scenes$Level2$Map$sds = A3($tortus$elm_array_2d$Array2D$repeat, 120, 70, 0);
var $author$project$Scenes$Level2$Map$mymap = A4(
	$author$project$Lib$Map$Poly$buildrect,
	_Utils_Tuple2(0, 0),
	_Utils_Tuple2(1, 70),
	1,
	$author$project$Scenes$Level2$Map$sds);
var $author$project$Scenes$Level2$Config$initGameGlobalData = function (e) {
	return {
		camera: $author$project$Scenes$Level2$Config$initCamera,
		currentScene: 'Level2',
		energy: e,
		ingamepause: false,
		mapsize: _Utils_Tuple2(120, 70),
		selectobj: 1,
		solidmap: $author$project$Scenes$Level2$Map$mymap
	};
};
var $author$project$Scenes$Level2$Config$initPlayer = F2(
	function (t, pos) {
		if (pos.$ === 'DefaultPlayerPosition') {
			return A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GamePlayerInit(
					$author$project$Lib$CoreEngine$GameComponents$Player$Base$PlayerInit(
						_Utils_Tuple2(50, 2000))),
				$author$project$Lib$CoreEngine$GameComponents$Player$Export$gameComponent);
		} else {
			var x = pos.a;
			return A3(
				$author$project$Lib$CoreEngine$GameComponent$ComponentHandler$initGameComponent,
				t,
				$author$project$Lib$CoreEngine$GameComponent$Base$GamePlayerInit(
					$author$project$Lib$CoreEngine$GameComponents$Player$Base$PlayerInit(x)),
				$author$project$Lib$CoreEngine$GameComponents$Player$Export$gameComponent);
		}
	});
var $author$project$Scenes$Level2$Export$game = F2(
	function (t, sm) {
		var engineMsg = function () {
			if (sm.$ === 'SceneEngineTMsg') {
				var x = sm.a;
				return x;
			} else {
				return $author$project$Lib$Scene$Base$nullEngineT;
			}
		}();
		return A2(
			$author$project$Lib$CoreEngine$Export$initEngine,
			t,
			$author$project$Lib$Scene$Base$SceneEngineMsg(
				{
					actors: $author$project$Scenes$Level2$Config$initActors(t),
					background: _Utils_Tuple2($elm$core$Array$empty, $author$project$Scenes$Level2$Background$background),
					chartlets: $author$project$Scenes$Level2$Config$allChartlets,
					frontground: _Utils_Tuple2(
						$author$project$Scenes$Level2$Config$initFrontGroundComponents(t),
						F3(
							function (_v0, _v1, _v2) {
								return A2($joakin$elm_canvas$Canvas$group, _List_Nil, _List_Nil);
							})),
					globalData: $author$project$Scenes$Level2$Config$initGameGlobalData(engineMsg.energy),
					player: A2($author$project$Scenes$Level2$Config$initPlayer, t, engineMsg.playerPosition)
				}));
	});
var $author$project$Scenes$Level2$Export$scene = $author$project$Lib$CoreEngine$Export$genEngineScene($author$project$Scenes$Level2$Export$game);
var $author$project$Scenes$Scene1$Layer1$Export$nullData = {s: 0};
var $author$project$Scenes$Scene1$Layer1$Global$ctTod = function (ldt) {
	if (ldt.$ === 'Layer1Data') {
		var x = ldt.a;
		return x;
	} else {
		return $author$project$Scenes$Scene1$Layer1$Export$nullData;
	}
};
var $author$project$Scenes$Scene1$LayerSettings$Layer1Data = function (a) {
	return {$: 'Layer1Data', a: a};
};
var $author$project$Scenes$Scene1$Layer1$Global$dToCT = function (data) {
	return $author$project$Scenes$Scene1$LayerSettings$Layer1Data(data);
};
var $author$project$Scenes$Scene1$Layer1$Global$getLayerCT = function (layer) {
	var view = F3(
		function (_v3, cd, gd) {
			var ldt = _v3.a;
			var t = _v3.b;
			return A3(
				layer.view,
				_Utils_Tuple2(
					$author$project$Scenes$Scene1$Layer1$Global$ctTod(ldt),
					t),
				cd,
				gd);
		});
	var update = F5(
		function (m, gd, lm, _v2, cd) {
			var ldt = _v2.a;
			var t = _v2.b;
			var _v0 = A5(
				layer.update,
				m,
				gd,
				lm,
				_Utils_Tuple2(
					$author$project$Scenes$Scene1$Layer1$Global$ctTod(ldt),
					t),
				cd);
			var _v1 = _v0.a;
			var rldt = _v1.a;
			var rcd = _v1.b;
			var ltm = _v1.c;
			var newgd = _v0.b;
			return _Utils_Tuple2(
				_Utils_Tuple3(
					$author$project$Scenes$Scene1$Layer1$Global$dToCT(rldt),
					rcd,
					ltm),
				newgd);
		});
	var init = F3(
		function (t, lm, cd) {
			return $author$project$Scenes$Scene1$Layer1$Global$dToCT(
				A3(layer.init, t, lm, cd));
		});
	return A4(
		$author$project$Lib$Layer$Base$Layer,
		$author$project$Scenes$Scene1$Layer1$Global$dToCT(layer.data),
		init,
		update,
		view);
};
var $author$project$Scenes$Scene1$Layer2$Export$nullData = {components: _List_Nil};
var $author$project$Scenes$Scene1$Layer2$Global$ctTod = function (ldt) {
	if (ldt.$ === 'Layer2Data') {
		var x = ldt.a;
		return x;
	} else {
		return $author$project$Scenes$Scene1$Layer2$Export$nullData;
	}
};
var $author$project$Scenes$Scene1$LayerSettings$Layer2Data = function (a) {
	return {$: 'Layer2Data', a: a};
};
var $author$project$Scenes$Scene1$Layer2$Global$dToCT = function (data) {
	return $author$project$Scenes$Scene1$LayerSettings$Layer2Data(data);
};
var $author$project$Scenes$Scene1$Layer2$Global$getLayerCT = function (layer) {
	var view = F3(
		function (_v3, cd, gd) {
			var ldt = _v3.a;
			var t = _v3.b;
			return A3(
				layer.view,
				_Utils_Tuple2(
					$author$project$Scenes$Scene1$Layer2$Global$ctTod(ldt),
					t),
				cd,
				gd);
		});
	var update = F5(
		function (m, gd, lm, _v2, cd) {
			var ldt = _v2.a;
			var t = _v2.b;
			var _v0 = A5(
				layer.update,
				m,
				gd,
				lm,
				_Utils_Tuple2(
					$author$project$Scenes$Scene1$Layer2$Global$ctTod(ldt),
					t),
				cd);
			var _v1 = _v0.a;
			var rldt = _v1.a;
			var rcd = _v1.b;
			var ltm = _v1.c;
			var newgd = _v0.b;
			return _Utils_Tuple2(
				_Utils_Tuple3(
					$author$project$Scenes$Scene1$Layer2$Global$dToCT(rldt),
					rcd,
					ltm),
				newgd);
		});
	var init = F3(
		function (t, lm, cd) {
			return $author$project$Scenes$Scene1$Layer2$Global$dToCT(
				A3(layer.init, t, lm, cd));
		});
	return A4(
		$author$project$Lib$Layer$Base$Layer,
		$author$project$Scenes$Scene1$Layer2$Global$dToCT(layer.data),
		init,
		update,
		view);
};
var $author$project$Scenes$Scene1$Layer1$Display$dview = F3(
	function (_v0, _v1, gd) {
		return A2(
			$joakin$elm_canvas$Canvas$group,
			_List_Nil,
			_List_fromArray(
				[
					A5(
					$author$project$Lib$Render$Render$renderSprite,
					gd,
					_List_Nil,
					_Utils_Tuple2(0, 0),
					_Utils_Tuple2(1920, 1080),
					'background'),
					A2(
					$joakin$elm_canvas$Canvas$shapes,
					_List_fromArray(
						[
							$joakin$elm_canvas$Canvas$Settings$fill($avh4$elm_color$Color$red)
						]),
					_List_fromArray(
						[
							A3(
							$joakin$elm_canvas$Canvas$rect,
							A2(
								$author$project$Lib$Coordinate$Coordinates$posToReal,
								gd,
								_Utils_Tuple2(100, 100)),
							A2($author$project$Lib$Coordinate$Coordinates$widthToReal, gd, 100),
							A2($author$project$Lib$Coordinate$Coordinates$heightToReal, gd, 200))
						])),
					A5(
					$author$project$Lib$Render$Render$renderText,
					gd,
					50,
					'ohohoh',
					'sans-serif',
					_Utils_Tuple2(0, 50))
				]));
	});
var $author$project$Scenes$Scene1$Layer1$Models$initModel = F3(
	function (_v0, _v1, _v2) {
		return {s: 0};
	});
var $author$project$Lib$Audio$Base$AOnce = {$: 'AOnce'};
var $author$project$Lib$Layer$Base$LayerSoundMsg = F3(
	function (a, b, c) {
		return {$: 'LayerSoundMsg', a: a, b: b, c: c};
	});
var $elm$core$Debug$log = _Debug_log;
var $author$project$Scenes$Scene1$Layer1$Models$updateModel = F5(
	function (msg, gd, _v0, _v1, cd) {
		var model = _v1.a;
		var t = _v1.b;
		if ((msg.$ === 'MouseDown') && (msg.a === 1)) {
			var _v3 = msg.b;
			var x = _v3.a;
			var y = _v3.b;
			return A4(
				$author$project$Lib$Coordinate$Coordinates$judgeMouse,
				gd,
				_Utils_Tuple2(x, y),
				_Utils_Tuple2(100, 100),
				_Utils_Tuple2(100, 100)) ? _Utils_Tuple2(
				_Utils_Tuple3(model, cd, _List_Nil),
				gd) : _Utils_Tuple2(
				_Utils_Tuple3(model, cd, _List_Nil),
				gd);
		} else {
			return (!model.s) ? A2(
				$elm$core$Debug$log,
				'Audio',
				_Utils_Tuple2(
					_Utils_Tuple3(
						_Utils_update(
							model,
							{s: 1}),
						cd,
						_List_fromArray(
							[
								_Utils_Tuple2(
								$author$project$Lib$Layer$Base$LayerParentScene,
								A3($author$project$Lib$Layer$Base$LayerSoundMsg, 'glados', './assets/audio/complain.wav', $author$project$Lib$Audio$Base$AOnce))
							])),
					gd)) : _Utils_Tuple2(
				_Utils_Tuple3(model, cd, _List_Nil),
				gd);
		}
	});
var $author$project$Scenes$Scene1$Layer1$Export$layer = {data: $author$project$Scenes$Scene1$Layer1$Export$nullData, init: $author$project$Scenes$Scene1$Layer1$Models$initModel, update: $author$project$Scenes$Scene1$Layer1$Models$updateModel, view: $author$project$Scenes$Scene1$Layer1$Display$dview};
var $author$project$Scenes$Scene1$Layer2$Display$dview = F3(
	function (_v0, _v1, gd) {
		var model = _v0.a;
		var t = _v0.b;
		return A3(
			$author$project$Lib$Component$ComponentHandler$genView,
			gd,
			t,
			$elm$core$Array$fromList(model.components));
	});
var $author$project$Scenes$Scene1$Layer2$Models$initModel = F3(
	function (_v0, _v1, _v2) {
		return {
			components: _List_fromArray(
				[
					A2($author$project$Components$Menu$Export$initComponent, 0, $author$project$Lib$Component$Base$NullComponentMsg)
				])
		};
	});
var $author$project$Lib$Component$Base$ComponentIntMsg = function (a) {
	return {$: 'ComponentIntMsg', a: a};
};
var $author$project$Lib$Component$ComponentHandler$updateSingleComponent = F6(
	function (msg, ct, gd, t, n, xs) {
		var _v0 = A2($author$project$Lib$Component$ComponentHandler$getComponent, n, xs);
		if (_v0.$ === 'Just') {
			var k = _v0.a;
			var _v1 = A4(
				k.update,
				msg,
				ct,
				gd,
				_Utils_Tuple2(k.data, t));
			var newx = _v1.a;
			var newmsg = _v1.b;
			var newgd = _v1.c;
			return _Utils_Tuple3(
				A3(
					$elm$core$Array$set,
					n,
					_Utils_update(
						k,
						{data: newx}),
					xs),
				newmsg,
				newgd);
		} else {
			return _Utils_Tuple3(xs, $author$project$Lib$Component$Base$NullComponentMsg, gd);
		}
	});
var $author$project$Scenes$Scene1$Layer2$Models$updateModel = F5(
	function (msg, gd, _v0, _v1, cd) {
		var model = _v1.a;
		var t = _v1.b;
		switch (msg.$) {
			case 'Tick':
				var components = model.components;
				var _v3 = (t === 100) ? A6(
					$author$project$Lib$Component$ComponentHandler$updateSingleComponent,
					msg,
					$author$project$Lib$Component$Base$ComponentIntMsg(50),
					gd,
					t,
					0,
					$elm$core$Array$fromList(components)) : A6(
					$author$project$Lib$Component$ComponentHandler$updateSingleComponent,
					msg,
					$author$project$Lib$Component$Base$NullComponentMsg,
					gd,
					t,
					0,
					$elm$core$Array$fromList(components));
				var newComponents = _v3.a;
				var newGlobalData = _v3.c;
				return _Utils_Tuple2(
					_Utils_Tuple3(
						_Utils_update(
							model,
							{
								components: $elm$core$Array$toList(newComponents)
							}),
						cd,
						_List_Nil),
					newGlobalData);
			case 'MouseDown':
				var components = model.components;
				var _v4 = A6(
					$author$project$Lib$Component$ComponentHandler$updateSingleComponent,
					msg,
					$author$project$Lib$Component$Base$NullComponentMsg,
					gd,
					t,
					0,
					$elm$core$Array$fromList(components));
				var newComponents = _v4.a;
				var newGlobalData = _v4.c;
				return _Utils_Tuple2(
					_Utils_Tuple3(
						_Utils_update(
							model,
							{
								components: $elm$core$Array$toList(newComponents)
							}),
						cd,
						_List_Nil),
					newGlobalData);
			default:
				return _Utils_Tuple2(
					_Utils_Tuple3(model, cd, _List_Nil),
					gd);
		}
	});
var $author$project$Scenes$Scene1$Layer2$Export$layer = {data: $author$project$Scenes$Scene1$Layer2$Export$nullData, init: $author$project$Scenes$Scene1$Layer2$Models$initModel, update: $author$project$Scenes$Scene1$Layer2$Models$updateModel, view: $author$project$Scenes$Scene1$Layer2$Display$dview};
var $author$project$Scenes$Scene1$Model$initModel = F2(
	function (t, _v0) {
		var l2l = $author$project$Scenes$Scene1$Layer2$Export$layer;
		var l1l = $author$project$Scenes$Scene1$Layer1$Export$layer;
		var icd = {plt: 0};
		var l1ct = $author$project$Scenes$Scene1$Layer1$Global$getLayerCT(
			_Utils_update(
				l1l,
				{
					data: A3($author$project$Scenes$Scene1$Layer1$Export$layer.init, t, $author$project$Lib$Layer$Base$NullLayerMsg, icd)
				}));
		var l2ct = $author$project$Scenes$Scene1$Layer2$Global$getLayerCT(
			_Utils_update(
				l2l,
				{
					data: A3($author$project$Scenes$Scene1$Layer2$Export$layer.init, t, $author$project$Lib$Layer$Base$NullLayerMsg, icd)
				}));
		return {
			commonData: icd,
			layers: _List_fromArray(
				[
					_Utils_Tuple2('Layer1', l1ct),
					_Utils_Tuple2('Layer2', l2ct)
				])
		};
	});
var $author$project$Scenes$Scene1$Model$handleLayerMsg = F2(
	function (lmsg, _v0) {
		var model = _v0.a;
		switch (lmsg.$) {
			case 'LayerStringMsg':
				var str = lmsg.a;
				return (str === 'Restart') ? _Utils_Tuple2(
					model,
					$author$project$Lib$Scene$Base$SOChangeScene(
						_Utils_Tuple2($author$project$Lib$Scene$Base$NullSceneMsg, 'Scene1'))) : _Utils_Tuple2(model, $author$project$Lib$Scene$Base$NullSceneOutputMsg);
			case 'LayerSoundMsg':
				var name = lmsg.a;
				var path = lmsg.b;
				var opt = lmsg.c;
				return _Utils_Tuple2(
					model,
					A3($author$project$Lib$Scene$Base$SOPlayAudio, name, path, opt));
			case 'LayerStopSoundMsg':
				var name = lmsg.a;
				return _Utils_Tuple2(
					model,
					$author$project$Lib$Scene$Base$SOStopAudio(name));
			default:
				return _Utils_Tuple2(model, $author$project$Lib$Scene$Base$NullSceneOutputMsg);
		}
	});
var $author$project$Scenes$Scene1$Model$updateModel = F3(
	function (msg, gd, _v0) {
		var model = _v0.a;
		var t = _v0.b;
		var _v1 = A5($author$project$Lib$Layer$LayerHandler$updateLayer, msg, gd, t, model.commonData, model.layers);
		var _v2 = _v1.a;
		var newdata = _v2.a;
		var newcd = _v2.b;
		var msgs = _v2.c;
		var newgd = _v1.b;
		var nmodel = _Utils_update(
			model,
			{commonData: newcd, layers: newdata});
		var _v3 = A3(
			$elm$core$List$foldl,
			F2(
				function (x, _v4) {
					var y = _v4.a;
					return A2(
						$author$project$Scenes$Scene1$Model$handleLayerMsg,
						x,
						_Utils_Tuple2(y, t));
				}),
			_Utils_Tuple2(nmodel, $author$project$Lib$Scene$Base$NullSceneOutputMsg),
			msgs);
		var newmodel = _v3.a;
		var newso = _v3.b;
		return _Utils_Tuple3(newmodel, newso, newgd);
	});
var $author$project$Scenes$Scene1$Model$viewModel = F2(
	function (_v0, gd) {
		var model = _v0.a;
		var t = _v0.b;
		return A4($author$project$Lib$Layer$LayerHandler$viewLayer, gd, t, model.commonData, model.layers);
	});
var $author$project$Scenes$Scene1$Export$scene = {init: $author$project$Scenes$Scene1$Model$initModel, update: $author$project$Scenes$Scene1$Model$updateModel, view: $author$project$Scenes$Scene1$Model$viewModel};
var $author$project$Lib$CoreEngine$Export$nullData = {gameGlobalData: $author$project$Lib$CoreEngine$Base$nullGameGlobalData, layers: _List_Nil};
var $author$project$Lib$CoreEngine$Global$dtToT = function (dt) {
	if (dt.$ === 'CoreEngineDataT') {
		var x = dt.a;
		return x;
	} else {
		return $author$project$Lib$CoreEngine$Export$nullData;
	}
};
var $author$project$Scenes$SceneSettings$CoreEngineDataT = function (a) {
	return {$: 'CoreEngineDataT', a: a};
};
var $author$project$Lib$CoreEngine$Global$sdata = function (d) {
	return $author$project$Scenes$SceneSettings$CoreEngineDataT(d);
};
var $author$project$Lib$CoreEngine$Global$toCT = function (sd) {
	var view = F2(
		function (_v2, vp) {
			var dt = _v2.a;
			var t = _v2.b;
			return A2(
				sd.view,
				_Utils_Tuple2(
					$author$project$Lib$CoreEngine$Global$dtToT(dt),
					t),
				vp);
		});
	var update = F3(
		function (msg, gd, _v1) {
			var dt = _v1.a;
			var t = _v1.b;
			var _v0 = A3(
				sd.update,
				msg,
				gd,
				_Utils_Tuple2(
					$author$project$Lib$CoreEngine$Global$dtToT(dt),
					t));
			var sdt = _v0.a;
			var som = _v0.b;
			var newgd = _v0.c;
			return _Utils_Tuple3(
				$author$project$Lib$CoreEngine$Global$sdata(sdt),
				som,
				newgd);
		});
	var init = F2(
		function (t, tm) {
			return $author$project$Lib$CoreEngine$Global$sdata(
				A2(sd.init, t, tm));
		});
	return {init: init, update: update, view: view};
};
var $author$project$Scenes$Home$LayerBase$CommonData = function (plt) {
	return {plt: plt};
};
var $author$project$Scenes$Home$Export$nullData = {
	commonData: $author$project$Scenes$Home$LayerBase$CommonData(0),
	layers: _List_Nil
};
var $author$project$Scenes$Home$Global$dtToT = function (dt) {
	if (dt.$ === 'HDataT') {
		var x = dt.a;
		return x;
	} else {
		return $author$project$Scenes$Home$Export$nullData;
	}
};
var $author$project$Scenes$SceneSettings$HDataT = function (a) {
	return {$: 'HDataT', a: a};
};
var $author$project$Scenes$Home$Global$sdata = function (d) {
	return $author$project$Scenes$SceneSettings$HDataT(d);
};
var $author$project$Scenes$Home$Global$toCT = function (sd) {
	var view = F2(
		function (_v2, vp) {
			var dt = _v2.a;
			var t = _v2.b;
			return A2(
				sd.view,
				_Utils_Tuple2(
					$author$project$Scenes$Home$Global$dtToT(dt),
					t),
				vp);
		});
	var update = F3(
		function (msg, gd, _v1) {
			var dt = _v1.a;
			var t = _v1.b;
			var _v0 = A3(
				sd.update,
				msg,
				gd,
				_Utils_Tuple2(
					$author$project$Scenes$Home$Global$dtToT(dt),
					t));
			var sdt = _v0.a;
			var som = _v0.b;
			var newgd = _v0.c;
			return _Utils_Tuple3(
				$author$project$Scenes$Home$Global$sdata(sdt),
				som,
				newgd);
		});
	var init = F2(
		function (t, tm) {
			return $author$project$Scenes$Home$Global$sdata(
				A2(sd.init, t, tm));
		});
	return {init: init, update: update, view: view};
};
var $author$project$Scenes$Scene1$LayerBase$CommonData = function (plt) {
	return {plt: plt};
};
var $author$project$Scenes$Scene1$Export$nullData = {
	commonData: $author$project$Scenes$Scene1$LayerBase$CommonData(0),
	layers: _List_Nil
};
var $author$project$Scenes$Scene1$Global$dtToT = function (dt) {
	if (dt.$ === 'S1DataT') {
		var x = dt.a;
		return x;
	} else {
		return $author$project$Scenes$Scene1$Export$nullData;
	}
};
var $author$project$Scenes$SceneSettings$S1DataT = function (a) {
	return {$: 'S1DataT', a: a};
};
var $author$project$Scenes$Scene1$Global$sdata = function (d) {
	return $author$project$Scenes$SceneSettings$S1DataT(d);
};
var $author$project$Scenes$Scene1$Global$toCT = function (sd) {
	var view = F2(
		function (_v2, vp) {
			var dt = _v2.a;
			var t = _v2.b;
			return A2(
				sd.view,
				_Utils_Tuple2(
					$author$project$Scenes$Scene1$Global$dtToT(dt),
					t),
				vp);
		});
	var update = F3(
		function (msg, gd, _v1) {
			var dt = _v1.a;
			var t = _v1.b;
			var _v0 = A3(
				sd.update,
				msg,
				gd,
				_Utils_Tuple2(
					$author$project$Scenes$Scene1$Global$dtToT(dt),
					t));
			var sdt = _v0.a;
			var som = _v0.b;
			var newgd = _v0.c;
			return _Utils_Tuple3(
				$author$project$Scenes$Scene1$Global$sdata(sdt),
				som,
				newgd);
		});
	var init = F2(
		function (t, tm) {
			return $author$project$Scenes$Scene1$Global$sdata(
				A2(sd.init, t, tm));
		});
	return {init: init, update: update, view: view};
};
var $author$project$Scenes$AllScenes$allScenes = _List_fromArray(
	[
		_Utils_Tuple2(
		'Scene1',
		$author$project$Scenes$Scene1$Global$toCT($author$project$Scenes$Scene1$Export$scene)),
		_Utils_Tuple2(
		'Engine',
		$author$project$Lib$CoreEngine$Global$toCT($author$project$Lib$CoreEngine$Export$scene)),
		_Utils_Tuple2(
		'Level1',
		$author$project$Lib$CoreEngine$Global$toCT($author$project$Scenes$Level1$Export$scene)),
		_Utils_Tuple2(
		'Home',
		$author$project$Scenes$Home$Global$toCT($author$project$Scenes$Home$Export$scene)),
		_Utils_Tuple2(
		'Level2',
		$author$project$Lib$CoreEngine$Global$toCT($author$project$Scenes$Level2$Export$scene))
	]);
var $author$project$Lib$Scene$SceneLoader$getScene = function (i) {
	var scenes = $author$project$Scenes$AllScenes$allScenes;
	var tests = A2(
		$elm$core$List$filter,
		function (_v2) {
			var x = _v2.a;
			return _Utils_eq(x, i);
		},
		scenes);
	var head = $elm$core$List$head(tests);
	if (head.$ === 'Just') {
		var _v1 = head.a;
		var x = _v1.b;
		return x;
	} else {
		return $author$project$Scenes$SceneSettings$nullSceneCT;
	}
};
var $author$project$Lib$Scene$SceneLoader$loadScene = F3(
	function (model, cs, tm) {
		var ls = _Utils_update(
			model,
			{currentScene: cs});
		var ld = _Utils_update(
			ls,
			{
				currentData: A2(cs.init, ls.time, tm)
			});
		return ld;
	});
var $author$project$Lib$Scene$SceneLoader$loadSceneByName = F3(
	function (model, i, tm) {
		var sc = $author$project$Lib$Scene$SceneLoader$getScene(i);
		return A3($author$project$Lib$Scene$SceneLoader$loadScene, model, sc, tm);
	});
var $author$project$Lib$Coordinate$Coordinates$maxHandW = function (_v0) {
	var w = _v0.a;
	var h = _v0.b;
	return (_Utils_cmp(w * 9, h * 16) > 0) ? _Utils_Tuple2(
		$elm$core$Basics$floor((h * 16) / 9),
		h) : _Utils_Tuple2(
		w,
		$elm$core$Basics$floor((w * 9) / 16));
};
var $author$project$Main$init = function (flags) {
	var ms = A3($author$project$Lib$Scene$SceneLoader$loadSceneByName, $author$project$Main$initModel, 'Level1', $author$project$Lib$Scene$Base$NullSceneMsg);
	var oldgd = ms.currentGlobalData;
	var _v0 = $author$project$Lib$Coordinate$Coordinates$maxHandW(
		_Utils_Tuple2(flags.windowWidth, flags.windowHeight));
	var gw = _v0.a;
	var gh = _v0.b;
	var _v1 = $author$project$Lib$Coordinate$Coordinates$getStartPoint(
		_Utils_Tuple2(flags.windowWidth, flags.windowHeight));
	var fl = _v1.a;
	var ft = _v1.b;
	var newgd = _Utils_update(
		oldgd,
		{
			browserViewPort: _Utils_Tuple2(flags.windowWidth, flags.windowHeight),
			realHeight: gh,
			realWidth: gw,
			startLeft: fl,
			startTop: ft
		});
	return _Utils_Tuple3(
		_Utils_update(
			ms,
			{currentGlobalData: newgd}),
		$elm$core$Platform$Cmd$none,
		$MartinSStewart$elm_audio$Audio$cmdNone);
};
var $author$project$Base$KeyDown = function (a) {
	return {$: 'KeyDown', a: a};
};
var $author$project$Base$KeyUp = function (a) {
	return {$: 'KeyUp', a: a};
};
var $author$project$Base$MouseDown = F2(
	function (a, b) {
		return {$: 'MouseDown', a: a, b: b};
	});
var $author$project$Base$NewWindowSize = function (a) {
	return {$: 'NewWindowSize', a: a};
};
var $author$project$Base$Tick = function (a) {
	return {$: 'Tick', a: a};
};
var $elm$time$Time$Every = F2(
	function (a, b) {
		return {$: 'Every', a: a, b: b};
	});
var $elm$time$Time$State = F2(
	function (taggers, processes) {
		return {processes: processes, taggers: taggers};
	});
var $elm$time$Time$init = $elm$core$Task$succeed(
	A2($elm$time$Time$State, $elm$core$Dict$empty, $elm$core$Dict$empty));
var $elm$time$Time$addMySub = F2(
	function (_v0, state) {
		var interval = _v0.a;
		var tagger = _v0.b;
		var _v1 = A2($elm$core$Dict$get, interval, state);
		if (_v1.$ === 'Nothing') {
			return A3(
				$elm$core$Dict$insert,
				interval,
				_List_fromArray(
					[tagger]),
				state);
		} else {
			var taggers = _v1.a;
			return A3(
				$elm$core$Dict$insert,
				interval,
				A2($elm$core$List$cons, tagger, taggers),
				state);
		}
	});
var $elm$core$Process$kill = _Scheduler_kill;
var $elm$core$Dict$merge = F6(
	function (leftStep, bothStep, rightStep, leftDict, rightDict, initialResult) {
		var stepState = F3(
			function (rKey, rValue, _v0) {
				stepState:
				while (true) {
					var list = _v0.a;
					var result = _v0.b;
					if (!list.b) {
						return _Utils_Tuple2(
							list,
							A3(rightStep, rKey, rValue, result));
					} else {
						var _v2 = list.a;
						var lKey = _v2.a;
						var lValue = _v2.b;
						var rest = list.b;
						if (_Utils_cmp(lKey, rKey) < 0) {
							var $temp$rKey = rKey,
								$temp$rValue = rValue,
								$temp$_v0 = _Utils_Tuple2(
								rest,
								A3(leftStep, lKey, lValue, result));
							rKey = $temp$rKey;
							rValue = $temp$rValue;
							_v0 = $temp$_v0;
							continue stepState;
						} else {
							if (_Utils_cmp(lKey, rKey) > 0) {
								return _Utils_Tuple2(
									list,
									A3(rightStep, rKey, rValue, result));
							} else {
								return _Utils_Tuple2(
									rest,
									A4(bothStep, lKey, lValue, rValue, result));
							}
						}
					}
				}
			});
		var _v3 = A3(
			$elm$core$Dict$foldl,
			stepState,
			_Utils_Tuple2(
				$elm$core$Dict$toList(leftDict),
				initialResult),
			rightDict);
		var leftovers = _v3.a;
		var intermediateResult = _v3.b;
		return A3(
			$elm$core$List$foldl,
			F2(
				function (_v4, result) {
					var k = _v4.a;
					var v = _v4.b;
					return A3(leftStep, k, v, result);
				}),
			intermediateResult,
			leftovers);
	});
var $elm$core$Platform$sendToSelf = _Platform_sendToSelf;
var $elm$time$Time$Name = function (a) {
	return {$: 'Name', a: a};
};
var $elm$time$Time$Offset = function (a) {
	return {$: 'Offset', a: a};
};
var $elm$time$Time$Zone = F2(
	function (a, b) {
		return {$: 'Zone', a: a, b: b};
	});
var $elm$time$Time$customZone = $elm$time$Time$Zone;
var $elm$time$Time$setInterval = _Time_setInterval;
var $elm$core$Process$spawn = _Scheduler_spawn;
var $elm$time$Time$spawnHelp = F3(
	function (router, intervals, processes) {
		if (!intervals.b) {
			return $elm$core$Task$succeed(processes);
		} else {
			var interval = intervals.a;
			var rest = intervals.b;
			var spawnTimer = $elm$core$Process$spawn(
				A2(
					$elm$time$Time$setInterval,
					interval,
					A2($elm$core$Platform$sendToSelf, router, interval)));
			var spawnRest = function (id) {
				return A3(
					$elm$time$Time$spawnHelp,
					router,
					rest,
					A3($elm$core$Dict$insert, interval, id, processes));
			};
			return A2($elm$core$Task$andThen, spawnRest, spawnTimer);
		}
	});
var $elm$time$Time$onEffects = F3(
	function (router, subs, _v0) {
		var processes = _v0.processes;
		var rightStep = F3(
			function (_v6, id, _v7) {
				var spawns = _v7.a;
				var existing = _v7.b;
				var kills = _v7.c;
				return _Utils_Tuple3(
					spawns,
					existing,
					A2(
						$elm$core$Task$andThen,
						function (_v5) {
							return kills;
						},
						$elm$core$Process$kill(id)));
			});
		var newTaggers = A3($elm$core$List$foldl, $elm$time$Time$addMySub, $elm$core$Dict$empty, subs);
		var leftStep = F3(
			function (interval, taggers, _v4) {
				var spawns = _v4.a;
				var existing = _v4.b;
				var kills = _v4.c;
				return _Utils_Tuple3(
					A2($elm$core$List$cons, interval, spawns),
					existing,
					kills);
			});
		var bothStep = F4(
			function (interval, taggers, id, _v3) {
				var spawns = _v3.a;
				var existing = _v3.b;
				var kills = _v3.c;
				return _Utils_Tuple3(
					spawns,
					A3($elm$core$Dict$insert, interval, id, existing),
					kills);
			});
		var _v1 = A6(
			$elm$core$Dict$merge,
			leftStep,
			bothStep,
			rightStep,
			newTaggers,
			processes,
			_Utils_Tuple3(
				_List_Nil,
				$elm$core$Dict$empty,
				$elm$core$Task$succeed(_Utils_Tuple0)));
		var spawnList = _v1.a;
		var existingDict = _v1.b;
		var killTask = _v1.c;
		return A2(
			$elm$core$Task$andThen,
			function (newProcesses) {
				return $elm$core$Task$succeed(
					A2($elm$time$Time$State, newTaggers, newProcesses));
			},
			A2(
				$elm$core$Task$andThen,
				function (_v2) {
					return A3($elm$time$Time$spawnHelp, router, spawnList, existingDict);
				},
				killTask));
	});
var $elm$time$Time$now = _Time_now($elm$time$Time$millisToPosix);
var $elm$time$Time$onSelfMsg = F3(
	function (router, interval, state) {
		var _v0 = A2($elm$core$Dict$get, interval, state.taggers);
		if (_v0.$ === 'Nothing') {
			return $elm$core$Task$succeed(state);
		} else {
			var taggers = _v0.a;
			var tellTaggers = function (time) {
				return $elm$core$Task$sequence(
					A2(
						$elm$core$List$map,
						function (tagger) {
							return A2(
								$elm$core$Platform$sendToApp,
								router,
								tagger(time));
						},
						taggers));
			};
			return A2(
				$elm$core$Task$andThen,
				function (_v1) {
					return $elm$core$Task$succeed(state);
				},
				A2($elm$core$Task$andThen, tellTaggers, $elm$time$Time$now));
		}
	});
var $elm$time$Time$subMap = F2(
	function (f, _v0) {
		var interval = _v0.a;
		var tagger = _v0.b;
		return A2(
			$elm$time$Time$Every,
			interval,
			A2($elm$core$Basics$composeL, f, tagger));
	});
_Platform_effectManagers['Time'] = _Platform_createManager($elm$time$Time$init, $elm$time$Time$onEffects, $elm$time$Time$onSelfMsg, 0, $elm$time$Time$subMap);
var $elm$time$Time$subscription = _Platform_leaf('Time');
var $elm$time$Time$every = F2(
	function (interval, tagger) {
		return $elm$time$Time$subscription(
			A2($elm$time$Time$Every, interval, tagger));
	});
var $elm$browser$Browser$Events$Document = {$: 'Document'};
var $elm$browser$Browser$Events$MySub = F3(
	function (a, b, c) {
		return {$: 'MySub', a: a, b: b, c: c};
	});
var $elm$browser$Browser$Events$State = F2(
	function (subs, pids) {
		return {pids: pids, subs: subs};
	});
var $elm$browser$Browser$Events$init = $elm$core$Task$succeed(
	A2($elm$browser$Browser$Events$State, _List_Nil, $elm$core$Dict$empty));
var $elm$browser$Browser$Events$nodeToKey = function (node) {
	if (node.$ === 'Document') {
		return 'd_';
	} else {
		return 'w_';
	}
};
var $elm$browser$Browser$Events$addKey = function (sub) {
	var node = sub.a;
	var name = sub.b;
	return _Utils_Tuple2(
		_Utils_ap(
			$elm$browser$Browser$Events$nodeToKey(node),
			name),
		sub);
};
var $elm$browser$Browser$Events$Event = F2(
	function (key, event) {
		return {event: event, key: key};
	});
var $elm$browser$Browser$Events$spawn = F3(
	function (router, key, _v0) {
		var node = _v0.a;
		var name = _v0.b;
		var actualNode = function () {
			if (node.$ === 'Document') {
				return _Browser_doc;
			} else {
				return _Browser_window;
			}
		}();
		return A2(
			$elm$core$Task$map,
			function (value) {
				return _Utils_Tuple2(key, value);
			},
			A3(
				_Browser_on,
				actualNode,
				name,
				function (event) {
					return A2(
						$elm$core$Platform$sendToSelf,
						router,
						A2($elm$browser$Browser$Events$Event, key, event));
				}));
	});
var $elm$browser$Browser$Events$onEffects = F3(
	function (router, subs, state) {
		var stepRight = F3(
			function (key, sub, _v6) {
				var deads = _v6.a;
				var lives = _v6.b;
				var news = _v6.c;
				return _Utils_Tuple3(
					deads,
					lives,
					A2(
						$elm$core$List$cons,
						A3($elm$browser$Browser$Events$spawn, router, key, sub),
						news));
			});
		var stepLeft = F3(
			function (_v4, pid, _v5) {
				var deads = _v5.a;
				var lives = _v5.b;
				var news = _v5.c;
				return _Utils_Tuple3(
					A2($elm$core$List$cons, pid, deads),
					lives,
					news);
			});
		var stepBoth = F4(
			function (key, pid, _v2, _v3) {
				var deads = _v3.a;
				var lives = _v3.b;
				var news = _v3.c;
				return _Utils_Tuple3(
					deads,
					A3($elm$core$Dict$insert, key, pid, lives),
					news);
			});
		var newSubs = A2($elm$core$List$map, $elm$browser$Browser$Events$addKey, subs);
		var _v0 = A6(
			$elm$core$Dict$merge,
			stepLeft,
			stepBoth,
			stepRight,
			state.pids,
			$elm$core$Dict$fromList(newSubs),
			_Utils_Tuple3(_List_Nil, $elm$core$Dict$empty, _List_Nil));
		var deadPids = _v0.a;
		var livePids = _v0.b;
		var makeNewPids = _v0.c;
		return A2(
			$elm$core$Task$andThen,
			function (pids) {
				return $elm$core$Task$succeed(
					A2(
						$elm$browser$Browser$Events$State,
						newSubs,
						A2(
							$elm$core$Dict$union,
							livePids,
							$elm$core$Dict$fromList(pids))));
			},
			A2(
				$elm$core$Task$andThen,
				function (_v1) {
					return $elm$core$Task$sequence(makeNewPids);
				},
				$elm$core$Task$sequence(
					A2($elm$core$List$map, $elm$core$Process$kill, deadPids))));
	});
var $elm$browser$Browser$Events$onSelfMsg = F3(
	function (router, _v0, state) {
		var key = _v0.key;
		var event = _v0.event;
		var toMessage = function (_v2) {
			var subKey = _v2.a;
			var _v3 = _v2.b;
			var node = _v3.a;
			var name = _v3.b;
			var decoder = _v3.c;
			return _Utils_eq(subKey, key) ? A2(_Browser_decodeEvent, decoder, event) : $elm$core$Maybe$Nothing;
		};
		var messages = A2($elm$core$List$filterMap, toMessage, state.subs);
		return A2(
			$elm$core$Task$andThen,
			function (_v1) {
				return $elm$core$Task$succeed(state);
			},
			$elm$core$Task$sequence(
				A2(
					$elm$core$List$map,
					$elm$core$Platform$sendToApp(router),
					messages)));
	});
var $elm$browser$Browser$Events$subMap = F2(
	function (func, _v0) {
		var node = _v0.a;
		var name = _v0.b;
		var decoder = _v0.c;
		return A3(
			$elm$browser$Browser$Events$MySub,
			node,
			name,
			A2($elm$json$Json$Decode$map, func, decoder));
	});
_Platform_effectManagers['Browser.Events'] = _Platform_createManager($elm$browser$Browser$Events$init, $elm$browser$Browser$Events$onEffects, $elm$browser$Browser$Events$onSelfMsg, 0, $elm$browser$Browser$Events$subMap);
var $elm$browser$Browser$Events$subscription = _Platform_leaf('Browser.Events');
var $elm$browser$Browser$Events$on = F3(
	function (node, name, decoder) {
		return $elm$browser$Browser$Events$subscription(
			A3($elm$browser$Browser$Events$MySub, node, name, decoder));
	});
var $elm$browser$Browser$Events$onKeyDown = A2($elm$browser$Browser$Events$on, $elm$browser$Browser$Events$Document, 'keydown');
var $elm$browser$Browser$Events$onKeyUp = A2($elm$browser$Browser$Events$on, $elm$browser$Browser$Events$Document, 'keyup');
var $elm$browser$Browser$Events$onMouseDown = A2($elm$browser$Browser$Events$on, $elm$browser$Browser$Events$Document, 'mousedown');
var $elm$browser$Browser$Events$Window = {$: 'Window'};
var $elm$browser$Browser$Events$onResize = function (func) {
	return A3(
		$elm$browser$Browser$Events$on,
		$elm$browser$Browser$Events$Window,
		'resize',
		A2(
			$elm$json$Json$Decode$field,
			'target',
			A3(
				$elm$json$Json$Decode$map2,
				func,
				A2($elm$json$Json$Decode$field, 'innerWidth', $elm$json$Json$Decode$int),
				A2($elm$json$Json$Decode$field, 'innerHeight', $elm$json$Json$Decode$int))));
};
var $author$project$Main$subscriptions = F2(
	function (_v0, _v1) {
		return $elm$core$Platform$Sub$batch(
			_List_fromArray(
				[
					A2($elm$time$Time$every, 15, $author$project$Base$Tick),
					$elm$browser$Browser$Events$onKeyDown(
					A2(
						$elm$json$Json$Decode$map,
						function (x) {
							return $author$project$Base$KeyDown(x);
						},
						A2($elm$json$Json$Decode$field, 'keyCode', $elm$json$Json$Decode$int))),
					$elm$browser$Browser$Events$onKeyUp(
					A2(
						$elm$json$Json$Decode$map,
						function (x) {
							return $author$project$Base$KeyUp(x);
						},
						A2($elm$json$Json$Decode$field, 'keyCode', $elm$json$Json$Decode$int))),
					$elm$browser$Browser$Events$onResize(
					F2(
						function (w, h) {
							return $author$project$Base$NewWindowSize(
								_Utils_Tuple2(w, h));
						})),
					$elm$browser$Browser$Events$onMouseDown(
					A4(
						$elm$json$Json$Decode$map3,
						F3(
							function (b, x, y) {
								return A2(
									$author$project$Base$MouseDown,
									b,
									_Utils_Tuple2(x, y));
							}),
						A2($elm$json$Json$Decode$field, 'button', $elm$json$Json$Decode$int),
						A2($elm$json$Json$Decode$field, 'clientX', $elm$json$Json$Decode$float),
						A2($elm$json$Json$Decode$field, 'clientY', $elm$json$Json$Decode$float)))
				]));
	});
var $author$project$Base$PlaySoundGotTime = F4(
	function (a, b, c, d) {
		return {$: 'PlaySoundGotTime', a: a, b: b, c: c, d: d};
	});
var $author$project$Base$SoundLoaded = F3(
	function (a, b, c) {
		return {$: 'SoundLoaded', a: a, b: b, c: c};
	});
var $author$project$Lib$Scene$SceneLoader$getCurrentScene = function (model) {
	return model.currentScene;
};
var $elm$core$Dict$isEmpty = function (dict) {
	if (dict.$ === 'RBEmpty_elm_builtin') {
		return true;
	} else {
		return false;
	}
};
var $MartinSStewart$elm_audio$Audio$AudioLoadRequest = function (a) {
	return {$: 'AudioLoadRequest', a: a};
};
var $MartinSStewart$elm_audio$Audio$ErrorThatHappensWhenYouLoadMoreThan1000SoundsDueToHackyWorkAroundToMakeThisPackageBehaveMoreLikeAnEffectPackage = {$: 'ErrorThatHappensWhenYouLoadMoreThan1000SoundsDueToHackyWorkAroundToMakeThisPackageBehaveMoreLikeAnEffectPackage'};
var $MartinSStewart$elm_audio$Audio$enumeratedResults = A2(
	$mgold$elm_nonempty_list$List$Nonempty$Nonempty,
	$elm$core$Result$Err($MartinSStewart$elm_audio$Audio$ErrorThatHappensWhenYouLoadMoreThan1000SoundsDueToHackyWorkAroundToMakeThisPackageBehaveMoreLikeAnEffectPackage),
	_Utils_ap(
		_List_fromArray(
			[
				$elm$core$Result$Err($MartinSStewart$elm_audio$Audio$FailedToDecode),
				$elm$core$Result$Err($MartinSStewart$elm_audio$Audio$NetworkError),
				$elm$core$Result$Err($MartinSStewart$elm_audio$Audio$UnknownError)
			]),
		A2(
			$elm$core$List$map,
			function (bufferId) {
				return $elm$core$Result$Ok(
					$MartinSStewart$elm_audio$Audio$File(
						{
							bufferId: $MartinSStewart$elm_audio$Audio$BufferId(bufferId)
						}));
			},
			A2($elm$core$List$range, 0, 1000))));
var $MartinSStewart$elm_audio$Audio$loadAudio = F2(
	function (userMsg, url) {
		return $MartinSStewart$elm_audio$Audio$AudioLoadRequest(
			{
				audioUrl: url,
				userMsg: A2(
					$mgold$elm_nonempty_list$List$Nonempty$map,
					function (results) {
						return _Utils_Tuple2(
							results,
							userMsg(results));
					},
					$MartinSStewart$elm_audio$Audio$enumeratedResults)
			});
	});
var $author$project$Lib$Audio$Audio$loadAudio = F5(
	function (repo, name, source, opt, t) {
		var filterrepo = A2(
			$elm$core$List$filter,
			function (_v0) {
				var n = _v0.a;
				return !_Utils_eq(n, name);
			},
			repo);
		return _Utils_ap(
			filterrepo,
			_List_fromArray(
				[
					_Utils_Tuple3(
					name,
					source,
					_Utils_Tuple2(opt, t))
				]));
	});
var $author$project$Lib$Resources$Base$saveSprite = F3(
	function (dst, name, text) {
		return A3($elm$core$Dict$insert, name, text, dst);
	});
var $author$project$Lib$Audio$Audio$stopAudio = F2(
	function (repo, s) {
		return A2(
			$elm$core$List$filter,
			function (_v0) {
				var name = _v0.a;
				return !_Utils_eq(name, s);
			},
			repo);
	});
var $author$project$Main$update = F3(
	function (_v0, msg, model) {
		switch (msg.$) {
			case 'TextureLoaded':
				if (msg.b.$ === 'Nothing') {
					var _v2 = msg.b;
					return _Utils_Tuple3(model, $elm$core$Platform$Cmd$none, $MartinSStewart$elm_audio$Audio$cmdNone);
				} else {
					var name = msg.a;
					var t = msg.b.a;
					var oldsprites = model.currentGlobalData.sprites;
					var oldgd = model.currentGlobalData;
					var newsp = A3($author$project$Lib$Resources$Base$saveSprite, oldsprites, name, t);
					var newgd = _Utils_update(
						oldgd,
						{sprites: newsp});
					return _Utils_Tuple3(
						_Utils_update(
							model,
							{currentGlobalData: newgd}),
						$elm$core$Platform$Cmd$none,
						$MartinSStewart$elm_audio$Audio$cmdNone);
				}
			case 'SoundLoaded':
				var name = msg.a;
				var opt = msg.b;
				var result = msg.c;
				if (result.$ === 'Ok') {
					var sound = result.a;
					return _Utils_Tuple3(
						model,
						A2(
							$elm$core$Task$perform,
							A3($author$project$Base$PlaySoundGotTime, name, opt, sound),
							$elm$time$Time$now),
						$MartinSStewart$elm_audio$Audio$cmdNone);
				} else {
					return _Utils_Tuple3(model, $elm$core$Platform$Cmd$none, $MartinSStewart$elm_audio$Audio$cmdNone);
				}
			case 'PlaySoundGotTime':
				var name = msg.a;
				var opt = msg.b;
				var sound = msg.c;
				var t = msg.d;
				return _Utils_Tuple3(
					_Utils_update(
						model,
						{
							audiorepo: A5($author$project$Lib$Audio$Audio$loadAudio, model.audiorepo, name, sound, opt, t)
						}),
					$elm$core$Platform$Cmd$none,
					$MartinSStewart$elm_audio$Audio$cmdNone);
			case 'NewWindowSize':
				var t = msg.a;
				var oldgd = model.currentGlobalData;
				var _v4 = $author$project$Lib$Coordinate$Coordinates$maxHandW(t);
				var gw = _v4.a;
				var gh = _v4.b;
				var _v5 = $author$project$Lib$Coordinate$Coordinates$getStartPoint(t);
				var fl = _v5.a;
				var ft = _v5.b;
				var newgd = _Utils_update(
					oldgd,
					{browserViewPort: t, realHeight: gh, realWidth: gw, startLeft: fl, startTop: ft});
				return _Utils_Tuple3(
					_Utils_update(
						model,
						{currentGlobalData: newgd}),
					$elm$core$Platform$Cmd$none,
					$MartinSStewart$elm_audio$Audio$cmdNone);
			default:
				if ($elm$core$Dict$isEmpty(model.currentGlobalData.sprites)) {
					return _Utils_Tuple3(model, $elm$core$Platform$Cmd$none, $MartinSStewart$elm_audio$Audio$cmdNone);
				} else {
					var ntmodel = _Utils_update(
						model,
						{time: model.time + 1});
					var tmodel = function () {
						if (msg.$ === 'Tick') {
							return ntmodel;
						} else {
							return model;
						}
					}();
					var cs = $author$project$Lib$Scene$SceneLoader$getCurrentScene(model);
					var cd = model.currentData;
					var cm = _Utils_Tuple2(cd, model.time);
					var _v6 = A3(cs.update, msg, model.currentGlobalData, cm);
					var sdt = _v6.a;
					var som = _v6.b;
					var newgd = _v6.c;
					var bnewmodel = _Utils_update(
						tmodel,
						{currentData: sdt, currentGlobalData: newgd});
					switch (som.$) {
						case 'SOChangeScene':
							var _v8 = som.a;
							var tm = _v8.a;
							var s = _v8.b;
							return _Utils_Tuple3(
								A3($author$project$Lib$Scene$SceneLoader$loadSceneByName, tmodel, s, tm),
								$elm$core$Platform$Cmd$none,
								$MartinSStewart$elm_audio$Audio$cmdNone);
						case 'SOPlayAudio':
							var name = som.a;
							var path = som.b;
							var opt = som.c;
							return _Utils_Tuple3(
								bnewmodel,
								$elm$core$Platform$Cmd$none,
								A2(
									$MartinSStewart$elm_audio$Audio$loadAudio,
									A2($author$project$Base$SoundLoaded, name, opt),
									path));
						case 'SOSetVolume':
							var s = som.a;
							var oldgd = bnewmodel.currentGlobalData;
							var newgd2 = _Utils_update(
								oldgd,
								{audioVolume: s});
							return _Utils_Tuple3(
								_Utils_update(
									bnewmodel,
									{currentGlobalData: newgd2}),
								$elm$core$Platform$Cmd$none,
								$MartinSStewart$elm_audio$Audio$cmdNone);
						case 'SOStopAudio':
							var name = som.a;
							return _Utils_Tuple3(
								_Utils_update(
									bnewmodel,
									{
										audiorepo: A2($author$project$Lib$Audio$Audio$stopAudio, bnewmodel.audiorepo, name)
									}),
								$elm$core$Platform$Cmd$none,
								$MartinSStewart$elm_audio$Audio$cmdNone);
						default:
							return _Utils_Tuple3(bnewmodel, $elm$core$Platform$Cmd$none, $MartinSStewart$elm_audio$Audio$cmdNone);
					}
				}
		}
	});
var $author$project$Base$TextureLoaded = F2(
	function (a, b) {
		return {$: 'TextureLoaded', a: a, b: b};
	});
var $author$project$Lib$Resources$Base$getResourcePath = function (x) {
	return 'assets/' + x;
};
var $author$project$Lib$Resources$Base$allTexture = _List_fromArray(
	[
		_Utils_Tuple2(
		'background',
		$author$project$Lib$Resources$Base$getResourcePath('img/bg.jpg')),
		_Utils_Tuple2(
		'rcloud',
		$author$project$Lib$Resources$Base$getResourcePath('img/rcloud.png')),
		_Utils_Tuple2(
		'lcloud',
		$author$project$Lib$Resources$Base$getResourcePath('img/lcloud.png')),
		_Utils_Tuple2(
		'bricksheet',
		$author$project$Lib$Resources$Base$getResourcePath('img/bricks.png')),
		_Utils_Tuple2(
		'spikeL',
		$author$project$Lib$Resources$Base$getResourcePath('img/spikeL.png')),
		_Utils_Tuple2(
		'spikeR',
		$author$project$Lib$Resources$Base$getResourcePath('img/spikeR.png')),
		_Utils_Tuple2(
		'spikeT',
		$author$project$Lib$Resources$Base$getResourcePath('img/spikeT.png')),
		_Utils_Tuple2(
		'spikeB',
		$author$project$Lib$Resources$Base$getResourcePath('img/spikeB.png'))
	]);
var $joakin$elm_canvas$Canvas$Internal$Texture$TSImageUrl = F2(
	function (a, b) {
		return {$: 'TSImageUrl', a: a, b: b};
	});
var $joakin$elm_canvas$Canvas$Texture$loadFromImageUrl = F2(
	function (url, onLoad) {
		return A2($joakin$elm_canvas$Canvas$Internal$Texture$TSImageUrl, url, onLoad);
	});
var $author$project$Lib$Resources$Base$getTexture = A2(
	$elm$core$List$map,
	function (_v0) {
		var x = _v0.a;
		var y = _v0.b;
		return A2(
			$joakin$elm_canvas$Canvas$Texture$loadFromImageUrl,
			y,
			$author$project$Base$TextureLoaded(x));
	},
	$author$project$Lib$Resources$Base$allTexture);
var $elm$virtual_dom$VirtualDom$style = _VirtualDom_style;
var $elm$html$Html$Attributes$style = $elm$virtual_dom$VirtualDom$style;
var $elm$html$Html$canvas = _VirtualDom_node('canvas');
var $joakin$elm_canvas$Canvas$cnvs = A2($elm$html$Html$canvas, _List_Nil, _List_Nil);
var $elm$virtual_dom$VirtualDom$property = F2(
	function (key, value) {
		return A2(
			_VirtualDom_property,
			_VirtualDom_noInnerHtmlOrFormAction(key),
			_VirtualDom_noJavaScriptOrHtmlJson(value));
	});
var $elm$html$Html$Attributes$property = $elm$virtual_dom$VirtualDom$property;
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$commands = function (list) {
	return A2(
		$elm$html$Html$Attributes$property,
		'cmds',
		A2($elm$json$Json$Encode$list, $elm$core$Basics$identity, list));
};
var $elm$html$Html$Attributes$height = function (n) {
	return A2(
		_VirtualDom_attribute,
		'height',
		$elm$core$String$fromInt(n));
};
var $elm$virtual_dom$VirtualDom$keyedNode = function (tag) {
	return _VirtualDom_keyedNode(
		_VirtualDom_noScript(tag));
};
var $elm$html$Html$Keyed$node = $elm$virtual_dom$VirtualDom$keyedNode;
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$empty = _List_Nil;
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$beginPath = A2($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn, 'beginPath', _List_Nil);
var $avh4$elm_color$Color$toCssString = function (_v0) {
	var r = _v0.a;
	var g = _v0.b;
	var b = _v0.c;
	var a = _v0.d;
	var roundTo = function (x) {
		return $elm$core$Basics$round(x * 1000) / 1000;
	};
	var pct = function (x) {
		return $elm$core$Basics$round(x * 10000) / 100;
	};
	return $elm$core$String$concat(
		_List_fromArray(
			[
				'rgba(',
				$elm$core$String$fromFloat(
				pct(r)),
				'%,',
				$elm$core$String$fromFloat(
				pct(g)),
				'%,',
				$elm$core$String$fromFloat(
				pct(b)),
				'%,',
				$elm$core$String$fromFloat(
				roundTo(a)),
				')'
			]));
};
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fillStyle = function (color) {
	return A2(
		$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$field,
		'fillStyle',
		$elm$json$Json$Encode$string(
			$avh4$elm_color$Color$toCssString(color)));
};
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$clearRect = F4(
	function (x, y, width, height) {
		return A2(
			$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn,
			'clearRect',
			_List_fromArray(
				[
					$elm$json$Json$Encode$float(x),
					$elm$json$Json$Encode$float(y),
					$elm$json$Json$Encode$float(width),
					$elm$json$Json$Encode$float(height)
				]));
	});
var $joakin$elm_canvas$Canvas$renderClear = F4(
	function (_v0, w, h, cmds) {
		var x = _v0.a;
		var y = _v0.b;
		return A2(
			$elm$core$List$cons,
			A4($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$clearRect, x, y, w, h),
			cmds);
	});
var $elm$json$Json$Encode$bool = _Json_wrap;
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$arc = F6(
	function (x, y, radius, startAngle, endAngle, anticlockwise) {
		return A2(
			$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn,
			'arc',
			_List_fromArray(
				[
					$elm$json$Json$Encode$float(x),
					$elm$json$Json$Encode$float(y),
					$elm$json$Json$Encode$float(radius),
					$elm$json$Json$Encode$float(startAngle),
					$elm$json$Json$Encode$float(endAngle),
					$elm$json$Json$Encode$bool(anticlockwise)
				]));
	});
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$circle = F3(
	function (x, y, r) {
		return A6($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$arc, x, y, r, 0, 2 * $elm$core$Basics$pi, false);
	});
var $elm$core$Basics$cos = _Basics_cos;
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$moveTo = F2(
	function (x, y) {
		return A2(
			$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn,
			'moveTo',
			_List_fromArray(
				[
					$elm$json$Json$Encode$float(x),
					$elm$json$Json$Encode$float(y)
				]));
	});
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$rect = F4(
	function (x, y, w, h) {
		return A2(
			$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn,
			'rect',
			_List_fromArray(
				[
					$elm$json$Json$Encode$float(x),
					$elm$json$Json$Encode$float(y),
					$elm$json$Json$Encode$float(w),
					$elm$json$Json$Encode$float(h)
				]));
	});
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$arcTo = F5(
	function (x1, y1, x2, y2, radius) {
		return A2(
			$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn,
			'arcTo',
			_List_fromArray(
				[
					$elm$json$Json$Encode$float(x1),
					$elm$json$Json$Encode$float(y1),
					$elm$json$Json$Encode$float(x2),
					$elm$json$Json$Encode$float(y2),
					$elm$json$Json$Encode$float(radius)
				]));
	});
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$bezierCurveTo = F6(
	function (cp1x, cp1y, cp2x, cp2y, x, y) {
		return A2(
			$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn,
			'bezierCurveTo',
			_List_fromArray(
				[
					$elm$json$Json$Encode$float(cp1x),
					$elm$json$Json$Encode$float(cp1y),
					$elm$json$Json$Encode$float(cp2x),
					$elm$json$Json$Encode$float(cp2y),
					$elm$json$Json$Encode$float(x),
					$elm$json$Json$Encode$float(y)
				]));
	});
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$lineTo = F2(
	function (x, y) {
		return A2(
			$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn,
			'lineTo',
			_List_fromArray(
				[
					$elm$json$Json$Encode$float(x),
					$elm$json$Json$Encode$float(y)
				]));
	});
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$quadraticCurveTo = F4(
	function (cpx, cpy, x, y) {
		return A2(
			$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn,
			'quadraticCurveTo',
			_List_fromArray(
				[
					$elm$json$Json$Encode$float(cpx),
					$elm$json$Json$Encode$float(cpy),
					$elm$json$Json$Encode$float(x),
					$elm$json$Json$Encode$float(y)
				]));
	});
var $joakin$elm_canvas$Canvas$renderLineSegment = F2(
	function (segment, cmds) {
		switch (segment.$) {
			case 'ArcTo':
				var _v1 = segment.a;
				var x = _v1.a;
				var y = _v1.b;
				var _v2 = segment.b;
				var x2 = _v2.a;
				var y2 = _v2.b;
				var radius = segment.c;
				return A2(
					$elm$core$List$cons,
					A5($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$arcTo, x, y, x2, y2, radius),
					cmds);
			case 'BezierCurveTo':
				var _v3 = segment.a;
				var cp1x = _v3.a;
				var cp1y = _v3.b;
				var _v4 = segment.b;
				var cp2x = _v4.a;
				var cp2y = _v4.b;
				var _v5 = segment.c;
				var x = _v5.a;
				var y = _v5.b;
				return A2(
					$elm$core$List$cons,
					A6($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$bezierCurveTo, cp1x, cp1y, cp2x, cp2y, x, y),
					cmds);
			case 'LineTo':
				var _v6 = segment.a;
				var x = _v6.a;
				var y = _v6.b;
				return A2(
					$elm$core$List$cons,
					A2($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$lineTo, x, y),
					cmds);
			case 'MoveTo':
				var _v7 = segment.a;
				var x = _v7.a;
				var y = _v7.b;
				return A2(
					$elm$core$List$cons,
					A2($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$moveTo, x, y),
					cmds);
			default:
				var _v8 = segment.a;
				var cpx = _v8.a;
				var cpy = _v8.b;
				var _v9 = segment.b;
				var x = _v9.a;
				var y = _v9.b;
				return A2(
					$elm$core$List$cons,
					A4($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$quadraticCurveTo, cpx, cpy, x, y),
					cmds);
		}
	});
var $elm$core$Basics$sin = _Basics_sin;
var $joakin$elm_canvas$Canvas$renderShape = F2(
	function (shape, cmds) {
		switch (shape.$) {
			case 'Rect':
				var _v1 = shape.a;
				var x = _v1.a;
				var y = _v1.b;
				var w = shape.b;
				var h = shape.c;
				return A2(
					$elm$core$List$cons,
					A4($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$rect, x, y, w, h),
					A2(
						$elm$core$List$cons,
						A2($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$moveTo, x, y),
						cmds));
			case 'Circle':
				var _v2 = shape.a;
				var x = _v2.a;
				var y = _v2.b;
				var r = shape.b;
				return A2(
					$elm$core$List$cons,
					A3($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$circle, x, y, r),
					A2(
						$elm$core$List$cons,
						A2($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$moveTo, x + r, y),
						cmds));
			case 'Path':
				var _v3 = shape.a;
				var x = _v3.a;
				var y = _v3.b;
				var segments = shape.b;
				return A3(
					$elm$core$List$foldl,
					$joakin$elm_canvas$Canvas$renderLineSegment,
					A2(
						$elm$core$List$cons,
						A2($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$moveTo, x, y),
						cmds),
					segments);
			default:
				var _v4 = shape.a;
				var x = _v4.a;
				var y = _v4.b;
				var radius = shape.b;
				var startAngle = shape.c;
				var endAngle = shape.d;
				var anticlockwise = shape.e;
				return A2(
					$elm$core$List$cons,
					A2(
						$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$moveTo,
						x + (radius * $elm$core$Basics$cos(endAngle)),
						y + (radius * $elm$core$Basics$sin(endAngle))),
					A2(
						$elm$core$List$cons,
						A6($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$arc, x, y, radius, startAngle, endAngle, anticlockwise),
						A2(
							$elm$core$List$cons,
							A2(
								$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$moveTo,
								x + (radius * $elm$core$Basics$cos(startAngle)),
								y + (radius * $elm$core$Basics$sin(startAngle))),
							cmds)));
		}
	});
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$NonZero = {$: 'NonZero'};
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fillRuleToString = function (fillRule) {
	if (fillRule.$ === 'NonZero') {
		return 'nonzero';
	} else {
		return 'evenodd';
	}
};
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fill = function (fillRule) {
	return A2(
		$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn,
		'fill',
		_List_fromArray(
			[
				$elm$json$Json$Encode$string(
				$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fillRuleToString(fillRule))
			]));
};
var $joakin$elm_canvas$Canvas$renderShapeFill = F2(
	function (maybeColor, cmds) {
		return A2(
			$elm$core$List$cons,
			$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fill($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$NonZero),
			function () {
				if (maybeColor.$ === 'Just') {
					var color = maybeColor.a;
					return A2(
						$elm$core$List$cons,
						$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fillStyle(color),
						cmds);
				} else {
					return cmds;
				}
			}());
	});
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$stroke = A2($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn, 'stroke', _List_Nil);
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$strokeStyle = function (color) {
	return A2(
		$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$field,
		'strokeStyle',
		$elm$json$Json$Encode$string(
			$avh4$elm_color$Color$toCssString(color)));
};
var $joakin$elm_canvas$Canvas$renderShapeStroke = F2(
	function (maybeColor, cmds) {
		return A2(
			$elm$core$List$cons,
			$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$stroke,
			function () {
				if (maybeColor.$ === 'Just') {
					var color = maybeColor.a;
					return A2(
						$elm$core$List$cons,
						$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$strokeStyle(color),
						cmds);
				} else {
					return cmds;
				}
			}());
	});
var $joakin$elm_canvas$Canvas$renderShapeDrawOp = F2(
	function (drawOp, cmds) {
		switch (drawOp.$) {
			case 'NotSpecified':
				return A2(
					$joakin$elm_canvas$Canvas$renderShapeStroke,
					$elm$core$Maybe$Nothing,
					A2($joakin$elm_canvas$Canvas$renderShapeFill, $elm$core$Maybe$Nothing, cmds));
			case 'Fill':
				var c = drawOp.a;
				return A2(
					$joakin$elm_canvas$Canvas$renderShapeFill,
					$elm$core$Maybe$Just(c),
					cmds);
			case 'Stroke':
				var c = drawOp.a;
				return A2(
					$joakin$elm_canvas$Canvas$renderShapeStroke,
					$elm$core$Maybe$Just(c),
					cmds);
			default:
				var fc = drawOp.a;
				var sc = drawOp.b;
				return A2(
					$joakin$elm_canvas$Canvas$renderShapeStroke,
					$elm$core$Maybe$Just(sc),
					A2(
						$joakin$elm_canvas$Canvas$renderShapeFill,
						$elm$core$Maybe$Just(fc),
						cmds));
		}
	});
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fillText = F4(
	function (text, x, y, maybeMaxWidth) {
		if (maybeMaxWidth.$ === 'Nothing') {
			return A2(
				$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn,
				'fillText',
				_List_fromArray(
					[
						$elm$json$Json$Encode$string(text),
						$elm$json$Json$Encode$float(x),
						$elm$json$Json$Encode$float(y)
					]));
		} else {
			var maxWidth = maybeMaxWidth.a;
			return A2(
				$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn,
				'fillText',
				_List_fromArray(
					[
						$elm$json$Json$Encode$string(text),
						$elm$json$Json$Encode$float(x),
						$elm$json$Json$Encode$float(y),
						$elm$json$Json$Encode$float(maxWidth)
					]));
		}
	});
var $joakin$elm_canvas$Canvas$renderTextFill = F5(
	function (txt, x, y, maybeColor, cmds) {
		return A2(
			$elm$core$List$cons,
			A4($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fillText, txt.text, x, y, txt.maxWidth),
			function () {
				if (maybeColor.$ === 'Just') {
					var color = maybeColor.a;
					return A2(
						$elm$core$List$cons,
						$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fillStyle(color),
						cmds);
				} else {
					return cmds;
				}
			}());
	});
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$strokeText = F4(
	function (text, x, y, maybeMaxWidth) {
		if (maybeMaxWidth.$ === 'Nothing') {
			return A2(
				$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn,
				'strokeText',
				_List_fromArray(
					[
						$elm$json$Json$Encode$string(text),
						$elm$json$Json$Encode$float(x),
						$elm$json$Json$Encode$float(y)
					]));
		} else {
			var maxWidth = maybeMaxWidth.a;
			return A2(
				$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn,
				'strokeText',
				_List_fromArray(
					[
						$elm$json$Json$Encode$string(text),
						$elm$json$Json$Encode$float(x),
						$elm$json$Json$Encode$float(y),
						$elm$json$Json$Encode$float(maxWidth)
					]));
		}
	});
var $joakin$elm_canvas$Canvas$renderTextStroke = F5(
	function (txt, x, y, maybeColor, cmds) {
		return A2(
			$elm$core$List$cons,
			A4($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$strokeText, txt.text, x, y, txt.maxWidth),
			function () {
				if (maybeColor.$ === 'Just') {
					var color = maybeColor.a;
					return A2(
						$elm$core$List$cons,
						$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$strokeStyle(color),
						cmds);
				} else {
					return cmds;
				}
			}());
	});
var $joakin$elm_canvas$Canvas$renderTextDrawOp = F3(
	function (drawOp, txt, cmds) {
		var _v0 = txt.point;
		var x = _v0.a;
		var y = _v0.b;
		switch (drawOp.$) {
			case 'NotSpecified':
				return A5(
					$joakin$elm_canvas$Canvas$renderTextStroke,
					txt,
					x,
					y,
					$elm$core$Maybe$Nothing,
					A5($joakin$elm_canvas$Canvas$renderTextFill, txt, x, y, $elm$core$Maybe$Nothing, cmds));
			case 'Fill':
				var c = drawOp.a;
				return A5(
					$joakin$elm_canvas$Canvas$renderTextFill,
					txt,
					x,
					y,
					$elm$core$Maybe$Just(c),
					cmds);
			case 'Stroke':
				var c = drawOp.a;
				return A5(
					$joakin$elm_canvas$Canvas$renderTextStroke,
					txt,
					x,
					y,
					$elm$core$Maybe$Just(c),
					cmds);
			default:
				var fc = drawOp.a;
				var sc = drawOp.b;
				return A5(
					$joakin$elm_canvas$Canvas$renderTextStroke,
					txt,
					x,
					y,
					$elm$core$Maybe$Just(sc),
					A5(
						$joakin$elm_canvas$Canvas$renderTextFill,
						txt,
						x,
						y,
						$elm$core$Maybe$Just(fc),
						cmds));
		}
	});
var $joakin$elm_canvas$Canvas$renderText = F3(
	function (drawOp, txt, cmds) {
		return A3($joakin$elm_canvas$Canvas$renderTextDrawOp, drawOp, txt, cmds);
	});
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$drawImage = F9(
	function (sx, sy, sw, sh, dx, dy, dw, dh, imageObj) {
		return A2(
			$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn,
			'drawImage',
			_List_fromArray(
				[
					imageObj,
					$elm$json$Json$Encode$float(sx),
					$elm$json$Json$Encode$float(sy),
					$elm$json$Json$Encode$float(sw),
					$elm$json$Json$Encode$float(sh),
					$elm$json$Json$Encode$float(dx),
					$elm$json$Json$Encode$float(dy),
					$elm$json$Json$Encode$float(dw),
					$elm$json$Json$Encode$float(dh)
				]));
	});
var $joakin$elm_canvas$Canvas$Internal$Texture$drawTexture = F4(
	function (x, y, t, cmds) {
		return A2(
			$elm$core$List$cons,
			function () {
				if (t.$ === 'TImage') {
					var image = t.a;
					return A9($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$drawImage, 0, 0, image.width, image.height, x, y, image.width, image.height, image.json);
				} else {
					var sprite = t.a;
					var image = t.b;
					return A9($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$drawImage, sprite.x, sprite.y, sprite.width, sprite.height, x, y, sprite.width, sprite.height, image.json);
				}
			}(),
			cmds);
	});
var $joakin$elm_canvas$Canvas$renderTexture = F3(
	function (_v0, t, cmds) {
		var x = _v0.a;
		var y = _v0.b;
		return A4($joakin$elm_canvas$Canvas$Internal$Texture$drawTexture, x, y, t, cmds);
	});
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$restore = A2($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn, 'restore', _List_Nil);
var $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$save = A2($joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fn, 'save', _List_Nil);
var $joakin$elm_canvas$Canvas$renderDrawable = F3(
	function (drawable, drawOp, cmds) {
		switch (drawable.$) {
			case 'DrawableText':
				var txt = drawable.a;
				return A3($joakin$elm_canvas$Canvas$renderText, drawOp, txt, cmds);
			case 'DrawableShapes':
				var ss = drawable.a;
				return A2(
					$joakin$elm_canvas$Canvas$renderShapeDrawOp,
					drawOp,
					A3(
						$elm$core$List$foldl,
						$joakin$elm_canvas$Canvas$renderShape,
						A2($elm$core$List$cons, $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$beginPath, cmds),
						ss));
			case 'DrawableTexture':
				var p = drawable.a;
				var t = drawable.b;
				return A3($joakin$elm_canvas$Canvas$renderTexture, p, t, cmds);
			case 'DrawableClear':
				var p = drawable.a;
				var w = drawable.b;
				var h = drawable.c;
				return A4($joakin$elm_canvas$Canvas$renderClear, p, w, h, cmds);
			default:
				var renderables = drawable.a;
				return A3($joakin$elm_canvas$Canvas$renderGroup, drawOp, renderables, cmds);
		}
	});
var $joakin$elm_canvas$Canvas$renderGroup = F3(
	function (drawOp, renderables, cmds) {
		var cmdsWithDraw = function () {
			switch (drawOp.$) {
				case 'NotSpecified':
					return cmds;
				case 'Fill':
					var c = drawOp.a;
					return A2(
						$elm$core$List$cons,
						$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fillStyle(c),
						cmds);
				case 'Stroke':
					var c = drawOp.a;
					return A2(
						$elm$core$List$cons,
						$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$strokeStyle(c),
						cmds);
				default:
					var fc = drawOp.a;
					var sc = drawOp.b;
					return A2(
						$elm$core$List$cons,
						$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$fillStyle(fc),
						A2(
							$elm$core$List$cons,
							$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$strokeStyle(sc),
							cmds));
			}
		}();
		return A3(
			$elm$core$List$foldl,
			$joakin$elm_canvas$Canvas$renderOne(drawOp),
			cmdsWithDraw,
			renderables);
	});
var $joakin$elm_canvas$Canvas$renderOne = F3(
	function (parentDrawOp, _v0, cmds) {
		var commands = _v0.a.commands;
		var drawable = _v0.a.drawable;
		var drawOp = _v0.a.drawOp;
		return A2(
			$elm$core$List$cons,
			$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$restore,
			A3(
				$joakin$elm_canvas$Canvas$renderDrawable,
				drawable,
				A2($joakin$elm_canvas$Canvas$mergeDrawOp, parentDrawOp, drawOp),
				_Utils_ap(
					commands,
					A2($elm$core$List$cons, $joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$save, cmds))));
	});
var $joakin$elm_canvas$Canvas$render = function (entities) {
	return A3(
		$elm$core$List$foldl,
		$joakin$elm_canvas$Canvas$renderOne($joakin$elm_canvas$Canvas$Internal$Canvas$NotSpecified),
		$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$empty,
		entities);
};
var $elm$virtual_dom$VirtualDom$attribute = F2(
	function (key, value) {
		return A2(
			_VirtualDom_attribute,
			_VirtualDom_noOnOrFormAction(key),
			_VirtualDom_noJavaScriptOrHtmlUri(value));
	});
var $elm$html$Html$Attributes$attribute = $elm$virtual_dom$VirtualDom$attribute;
var $joakin$elm_canvas$Canvas$Internal$Texture$TImage = function (a) {
	return {$: 'TImage', a: a};
};
var $joakin$elm_canvas$Canvas$Internal$Texture$decodeTextureImage = A2(
	$elm$json$Json$Decode$andThen,
	function (image) {
		return A4(
			$elm$json$Json$Decode$map3,
			F3(
				function (tagName, width, height) {
					return (tagName === 'IMG') ? $elm$core$Maybe$Just(
						$joakin$elm_canvas$Canvas$Internal$Texture$TImage(
							{height: height, json: image, width: width})) : $elm$core$Maybe$Nothing;
				}),
			A2($elm$json$Json$Decode$field, 'tagName', $elm$json$Json$Decode$string),
			A2($elm$json$Json$Decode$field, 'width', $elm$json$Json$Decode$float),
			A2($elm$json$Json$Decode$field, 'height', $elm$json$Json$Decode$float));
	},
	$elm$json$Json$Decode$value);
var $joakin$elm_canvas$Canvas$Internal$Texture$decodeImageLoadEvent = A2($elm$json$Json$Decode$field, 'target', $joakin$elm_canvas$Canvas$Internal$Texture$decodeTextureImage);
var $elm$html$Html$img = _VirtualDom_node('img');
var $elm$virtual_dom$VirtualDom$Normal = function (a) {
	return {$: 'Normal', a: a};
};
var $elm$virtual_dom$VirtualDom$on = _VirtualDom_on;
var $elm$html$Html$Events$on = F2(
	function (event, decoder) {
		return A2(
			$elm$virtual_dom$VirtualDom$on,
			event,
			$elm$virtual_dom$VirtualDom$Normal(decoder));
	});
var $elm$html$Html$Attributes$stringProperty = F2(
	function (key, string) {
		return A2(
			_VirtualDom_property,
			key,
			$elm$json$Json$Encode$string(string));
	});
var $elm$html$Html$Attributes$src = function (url) {
	return A2(
		$elm$html$Html$Attributes$stringProperty,
		'src',
		_VirtualDom_noJavaScriptOrHtmlUri(url));
};
var $joakin$elm_canvas$Canvas$renderTextureSource = function (textureSource) {
	var url = textureSource.a;
	var onLoad = textureSource.b;
	return _Utils_Tuple2(
		url,
		A2(
			$elm$html$Html$img,
			_List_fromArray(
				[
					$elm$html$Html$Attributes$src(url),
					A2($elm$html$Html$Attributes$attribute, 'crossorigin', 'anonymous'),
					A2($elm$html$Html$Attributes$style, 'display', 'none'),
					A2(
					$elm$html$Html$Events$on,
					'load',
					A2($elm$json$Json$Decode$map, onLoad, $joakin$elm_canvas$Canvas$Internal$Texture$decodeImageLoadEvent)),
					A2(
					$elm$html$Html$Events$on,
					'error',
					$elm$json$Json$Decode$succeed(
						onLoad($elm$core$Maybe$Nothing)))
				]),
			_List_Nil));
};
var $elm$html$Html$Attributes$width = function (n) {
	return A2(
		_VirtualDom_attribute,
		'width',
		$elm$core$String$fromInt(n));
};
var $joakin$elm_canvas$Canvas$toHtmlWith = F3(
	function (options, attrs, entities) {
		return A3(
			$elm$html$Html$Keyed$node,
			'elm-canvas',
			A2(
				$elm$core$List$cons,
				$joakin$elm_canvas$Canvas$Internal$CustomElementJsonApi$commands(
					$joakin$elm_canvas$Canvas$render(entities)),
				A2(
					$elm$core$List$cons,
					$elm$html$Html$Attributes$height(options.height),
					A2(
						$elm$core$List$cons,
						$elm$html$Html$Attributes$width(options.width),
						attrs))),
			A2(
				$elm$core$List$cons,
				_Utils_Tuple2('__canvas', $joakin$elm_canvas$Canvas$cnvs),
				A2($elm$core$List$map, $joakin$elm_canvas$Canvas$renderTextureSource, options.textures)));
	});
var $avh4$elm_color$Color$white = A4($avh4$elm_color$Color$RgbaSpace, 255 / 255, 255 / 255, 255 / 255, 1.0);
var $author$project$Main$view = F2(
	function (_v0, model) {
		return A3(
			$joakin$elm_canvas$Canvas$toHtmlWith,
			{height: model.currentGlobalData.realHeight, textures: $author$project$Lib$Resources$Base$getTexture, width: model.currentGlobalData.realWidth},
			_List_fromArray(
				[
					A2(
					$elm$html$Html$Attributes$style,
					'left',
					$elm$core$String$fromFloat(model.currentGlobalData.startLeft)),
					A2(
					$elm$html$Html$Attributes$style,
					'top',
					$elm$core$String$fromFloat(model.currentGlobalData.startTop)),
					A2($elm$html$Html$Attributes$style, 'position', 'fixed')
				]),
			_List_fromArray(
				[
					A2(
					$joakin$elm_canvas$Canvas$shapes,
					_List_fromArray(
						[
							$joakin$elm_canvas$Canvas$Settings$fill($avh4$elm_color$Color$white)
						]),
					_List_fromArray(
						[
							A3(
							$joakin$elm_canvas$Canvas$rect,
							_Utils_Tuple2(0, 0),
							model.currentGlobalData.realWidth,
							model.currentGlobalData.realHeight)
						])),
					A2(
					$author$project$Lib$Scene$SceneLoader$getCurrentScene(model).view,
					_Utils_Tuple2(model.currentData, model.time),
					model.currentGlobalData)
				]));
	});
var $author$project$Main$main = $MartinSStewart$elm_audio$Audio$elementWithAudio(
	{
		audio: $author$project$Common$audio,
		audioPort: {fromJS: $author$project$Main$audioPortFromJS, toJS: $author$project$Main$audioPortToJS},
		init: $author$project$Main$init,
		subscriptions: $author$project$Main$subscriptions,
		update: $author$project$Main$update,
		view: $author$project$Main$view
	});
_Platform_export({'Main':{'init':$author$project$Main$main(
	A2(
		$elm$json$Json$Decode$andThen,
		function (windowWidth) {
			return A2(
				$elm$json$Json$Decode$andThen,
				function (windowHeight) {
					return $elm$json$Json$Decode$succeed(
						{windowHeight: windowHeight, windowWidth: windowWidth});
				},
				A2($elm$json$Json$Decode$field, 'windowHeight', $elm$json$Json$Decode$int));
		},
		A2($elm$json$Json$Decode$field, 'windowWidth', $elm$json$Json$Decode$int)))(0)}});}(this));