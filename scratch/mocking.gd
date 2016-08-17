
extends Node2D

class TestClass:
	func to_s():
		return 'TestClass to string method'
		
func to_s():
	return 'hello world'

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	var t = TestClass.new()
	var f = funcref(self, 'to_s')
	f.set_instance(t)
	print(t.to_s())
	print(t.call('to_s'))


	var f2 = FuncRef.new()
	f2.set_instance(t)
	f2.set_function('to_s')
	print(f2.call_func())
