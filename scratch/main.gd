
extends Node2D

var _dbg = null
var thread = Thread.new()

func _ready():
	_dbg = load("res://bitwes_tools/scripts/debug.gd").new()
	add_child(_dbg)
	_dbg.set_pos(Vector2(0, 39))
	_dbg.show()
	
	var my_array = []
	my_array.append(true)
	my_array.append(false)
	my_array.append("a string")
	my_array.append(0.15)
	my_array.append(1)
	my_array.append({})
	my_array.append({'asdf':'asdf'})
	my_array.append([])
	my_array.append([1, 2, 3])
	
	for i in range(my_array.size()):
		print_type(my_array[i])

func print_something(something):
	for i in range (200):
		_dbg.p(something + " " + str(i))
	call_deferred("thread_done")
	
func thread_done():
	thread.wait_to_finish()
	_dbg.p("thread_done")

func _on_startThreadButton_pressed():
	_dbg.p("starting thread")
	thread = Thread.new()
	var dont_know = thread.start(self, "print_something", "a")
	_dbg.p("is_active = " + str(thread.is_active()))
	#thread.wait_to_finish()
	_dbg.p("is_active = " + str(thread.is_active()))
	_dbg.p("done")


func _on_killThreadButton_pressed():
	thread.queue_free()

func print_type(some_var):
	_dbg.p(typeof(some_var))
	if(str(some_var) == 'False' or str(some_var) == 'True'):
		print("probably a boolean")
	else:
		print("probably a dictionary")



class some_data:
	var data = null
	var type = null
	