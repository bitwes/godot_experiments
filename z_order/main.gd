
extends Node2D
var _stang = null
var _car = null
var _bird = null
var _pressed = 0
# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	_stang = get_node('stang')
	_car = get_node('car')
	_bird = get_node('bird')




func _on_toggleZ_pressed():
	if(_pressed == 0):
		_stang.set_z(1)
		_car.set_z(2)
		_bird.set_z(3)
	elif(_pressed == 1):
		_stang.set_z(3)
		_car.set_z(1)
		_bird.set_z(2)	
	else:
		_stang.set_z(2)
		_car.set_z(3)
		_bird.set_z(1)
		_pressed = -1
	
	_pressed += 1