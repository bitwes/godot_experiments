var _ts = treeless_singleton #load('treeless_singleton.gd').get_inst()


func do_something_with_treeless_singleton():
	_ts.do_something()
	print(_ts.some_state)

func get_ts():
	return _ts
