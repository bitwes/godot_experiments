
extends Node2D

var dbg = null

func _ready():
	dbg = load("res://bitwes_tools/scripts/debug.gd").new()
	add_child(dbg)
	dbg.set_pos(Vector2(0, 39))
	dbg.show()

	var er = Caller.new()
	er.dbg = dbg
	add_child(er)
	
	var ee = Callee.new()
	ee.dbg = dbg
	add_child(ee)
	
	er.call_methods(ee, ['method1', 'method2', 'wait', 'method3', 'wait2x', 'method1', 'wait2x', 'method2'])

class Caller:
	extends Node2D
	var dbg = null
	var _wait = false
	var timer = Timer.new()
	
	func _ready():
		add_child(timer)
		timer.set_one_shot(true)
		timer.set_wait_time(1)

	func call_methods(obj, methods):
		obj.caller = self
		var call_return = null
		dbg.p("########### START ###########")
		for method in methods:
			call_return = obj.call(method)
			if(call_return != null):
				_wait = true
				while(_wait):
					dbg.p('-- waiting --')
					timer.start()
					yield(timer, 'timeout')
		dbg.p("########### END ###########")
	
	func done_waiting():
		_wait=false
		emit_signal('donewaiting')
		
class Callee:
	extends Node2D
	var dbg = null
	var timer = Timer.new()
	var caller = null

	func _ready():
		add_child(timer)
		timer.set_one_shot(true)
		timer.set_wait_time(5)
	
	func method1():
		dbg.p('in method numero uno')
	
	func method2():
		dbg.p('in method 2')
	
	func method3():
		dbg.p("in method tres")
	
	func wait():
		dbg.p("starting wait")
		timer.start()
		yield(timer, 'timeout')
		dbg.p("ending wait")
		caller.done_waiting()

	func wait2x():
		dbg.p("starting wait2x")
		timer.start()
		yield(timer, 'timeout')
		dbg.p("back, gonna wait again")
		timer.start()
		yield(timer, 'timeout')		
		caller.done_waiting()