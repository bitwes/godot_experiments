extends Node2D

class BaseClass:
	var hello='w'
	func _init():
		hello='world'

class SubClass:
	extends BaseClass
	
	func _init():
		hello='goodbye'

class SubBaseWithParameter:
	extends BaseClass
	func _init(val):
		hello='with param:  ' + val

class BaseInitParam:
	var hello = 'asdf'
	
	func _init(val):
		hello = val

class SubInitParam:
	extends BaseInitParam
	func _init(val):
		hello = 'sub:  ' + val

func _ready():
	var base = BaseClass.new()
	print(base.hello)
	
	var sub = SubClass.new()
	print(sub.hello)

	var sub_with = SubBaseWithParameter.new('this works')
	print(sub_with.hello)

	var base_param = BaseInitParam.new('another one')
	print(base_param.hello)
	
	var sub_param = SubInitParam.new('yet another one')
	print(sub_param.hello)