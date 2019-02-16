var Mock = load('res://scripts/mock.gd')

var _mocker = Mock.new()

var _target_path = null
var _testable_path = null
var returns = {}

func _init():
	_mocker.testable = self

func _make_testable(target_path, dest_path):
	var src_file = File.new()
	src_file.open(target_path, src_file.READ)

	var test_file = File.new()
	test_file.open(dest_path, test_file.WRITE)

	var line = ''
	while(!src_file.eof_reached()):
		line = src_file.get_line()
		# I think we just need to replace all instances of load where the
		# character before l is on [a-z][A-Z][_][0-9].  if we replace something
		# in a string or comment no big deal.  A string replacement might cause
		# a test to fail later though.  Repeat for preload.
		line = line.replace('load(', 'testable.load_mock(')
		test_file.store_string(line + "\n")
		# this won't work always
		if(line.find('extends') == 0):
			test_file.store_string(str('var testable = ', dyn_ref(), "\n"))

func load_mock(path):
	var filename = path.get_file()
	var mfile = 'user://' + filename
	_mocker.write_file(path, mfile)
	return load(mfile)

func get_new(target_path):
	_target_path = target_path
	_testable_path = 'user://__testable__' + target_path.get_file()
	_make_testable(_target_path, _testable_path)
	return load(_testable_path).new()

func dyn_ref():
	return str('instance_from_id(', get_instance_id(), ')')

func get_return_value(script_name, func_name):
	print('get return for: ', script_name, '.', func_name)
	var return_value = null
	if(returns.has(script_name)):
		return_value = returns[script_name]
	return return_value
