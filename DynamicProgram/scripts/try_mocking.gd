extends Node2D
var Mock = load('res://scripts/mock.gd')

func _init():
	mock_mock_me()
	mock_extends_mock_me()

func mock_extends_mock_me():
	var m = Mock.new()
	var dest = 'res://temp_files/made_an_extended_mock.gd'
	m.mock_object('res://resources/extends_mock_me.gd', dest)
	
	var mocked = load(dest).new()
	mocked.print_hello_world()
	mocked.this_has_parameters(1, 2)
	delete_file(dest)


func mock_mock_me():
	var m = Mock.new()
	var dest = 'res://temp_files/made_a_mock.gd'
	m.mock_object('res://resources/mock_me.gd', dest)

	var mocked = load(dest).new()
	mocked.print_hello_world()
	delete_file(dest)


func delete_file(path):
	var d = Directory.new()
	d.open(path.get_base_dir())
	d.remove(path)
