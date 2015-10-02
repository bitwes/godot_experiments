extends Node2D

var continue_button = null
var fr_wait_on_continue = funcref(self, "wait_on_continue");
var _finished = true
var functions = ["wait_for_nothing", "wait_on_continue", "wait_for_nothing", "wait_on_continue"]
var _method_result = null
var current_function = 0

func call_method(name):
	_finished = false
	_method_result = self.call(name)
	if(!_method_result):
		_finished = true
	else:
		print("Waiting on " + name)

func _ready():
	continue_button = get_node("continueButton")
	
	
func _process(delta):
	if(!_method_result or (_method_result and !_method_result.is_valid())):
		if(current_function < functions.size()):
			call_method(functions[current_function])
			current_function += 1
		else:
			print("ran all of them")
			set_process(false)
		
func wait_for_nothing():
	print("I just run, no waiting")

func wait_on_continue():
	print("start wait_on_continue")
	yield(continue_button, "pressed")
	print("yielding again")
	for z in range(200000):
		pass
	print("end wait_on_continue")
	#_finished = true

func _on_continueButton_pressed():
	print("continue pressed")

func _on_yieldButton_pressed():
	print("------start _on_yieldButton_pressed")
	yield(continue_button, "pressed")
	print("------end _on_yieldButton_pressed")

func _on_callYieldMethodButton_pressed():
	print('------start:  _on_callYieldMethodButton_pressed')
	wait_on_continue()
	print('------end:  _on_callYieldMethodButton_pressed')

func _on_callYieldMethodCheckStatusButton_pressed():
	set_process(true)
	