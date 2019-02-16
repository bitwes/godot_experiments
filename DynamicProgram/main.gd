extends Node2D

onready var _rich = get_node('TextEdit')

func _ready():
#	_rich.connect('symbol_lookup', self, '_on_symbol_lookup')
#	_rich.text = get_file_text('res://scripts/mock.gd')
	for i in range(ClassDB.get_class_list().size()):
		_rich.text += ClassDB.get_class_list()[i] + "\n"

	var hs = load('res://resources/has_things.gd').new()
	var oi = load('res://scripts/object_inspector.gd').new()
	var inner = load('res://resources/has_things.gd').InnerClass.new()
	
	#oi.print_info(hs)
	oi.print_info(inner)
	#print(hs.get_method_list())
	print('ready')
	
func _on_symbol_lookup(s, row, col):
	print(s, '::', row, '::', col)
	
func get_file_text(path):
	var f = File.new()
	f.open(path, f.READ)
	
	var text = ''
	while(!f.eof_reached()):
		text += f.get_line() + "\n"
	f.close()
	return text