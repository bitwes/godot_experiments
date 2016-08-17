
extends Node2D

var old_script = null


func _ready():
	get_node("Button").set_text(str(get_tree().get_node_count()))
	var obj = get_node("SetScriptObj")
	obj._name = 'hello world'
	obj.update_label()




func _on_Button_pressed():
	var obj = get_node("SetScriptObj")
	old_script = obj.get_script()
	obj.set_script(load('res://set_script_obj2.gd'))
	obj._ready()
	#obj.update_label()
	get_node("Button").set_text(str(get_tree().get_node_count()))


func _on_Button_2_pressed():
	var obj = get_node("SetScriptObj")
	obj.set_script(old_script)
	obj._ready()
	obj.update_label()
	
