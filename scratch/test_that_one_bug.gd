extends CenterContainer

func _ready():
	var test1= get_node("Panel/TabContainer/ScrollContainer/VBoxContainer")
	print("test1 = " + str(test1))
	
	var test2= get_node("Panel/TabContainer/ScrollContainer/VBoxContainer/HBoxContainer")
	print("test2 = " + str(test2))


