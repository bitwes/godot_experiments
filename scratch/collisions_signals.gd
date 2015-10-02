
extends Node2D

var _godot = null
var _bird = null

func _ready():
	_godot = get_node('./godot')
	_bird = get_node('./bird')
	var parms = ['one', 'two']
	_bird.get_node('Area2D').connect('area_enter', self, '_bird_area_enter', parms)
	
	set_process(true)
	
func _process(delta):
	_bird.set_pos(_bird.get_pos() + Vector2(0, 2))
	
func _bird_area_enter(area, one, two):
	print("entered" + " " + one + " " + two)
	
