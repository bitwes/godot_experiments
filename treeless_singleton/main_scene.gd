extends Node2D

# Demo using it when it is autoloaded.
func _ready():
	var autoloaded = get_node("/root/treeless_singleton")
	var other_t = load("res://treeless_singleton.gd").get_inst()
	
	if(other_t == autoloaded):
		print('Got the same one.')
	else:
		print('!! It did not work !!')

	# The next set of code shows that creating an instance of something that
	# uses the treeless singleton can get to the same autoloaded one even 
	# though it is not in the tree.
	var uses = load("res://uses_treeless_singleton.gd").new()
	uses.do_something_with_treeless_singleton()
	
	if(uses.get_ts() == autoloaded):
		print('Got the same one again.')
	else:
		print('!! It did not work 2nd time !!')
