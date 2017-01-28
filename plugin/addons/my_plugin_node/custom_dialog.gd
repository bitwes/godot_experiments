tool
extends WindowDialog

var SomeObj = preload('some_obj.gd')

func _enter_tree():
    set_title('Hello World')

func _ready():
	var so = SomeObj.new()
