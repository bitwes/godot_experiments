var _ts = load('treeless_singleton.gd').get_inst()


func do_something_with_treeless_singleton():
	_ts.do_something()

func get_ts():
	return _ts
