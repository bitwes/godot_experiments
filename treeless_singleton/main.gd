# RUN THIS SCRIPT WITH THE -p option so that it will not Autoload.  Without the
# -p option the making of random things doesn't matter b/c the project autoloads
# a TreelessSingleton
extends SceneTree

var TreelessSingleton = load('treeless_singleton.gd')

var things_made = []

func make_random_amounts_of_something():
	var amount = randi() % 200
	print('making ', amount, ' things.')
	for i in range(amount):
		things_made.append(Node2D.new())

func cleanup():
	for i in range(things_made.size()):
		things_made[i].free()

func _init():
	randomize()
	# make a random number of objects so that when we create the first
	# TreelessSingleton it is less likely that the save file from the last
	# run has the right instance id in it.
	make_random_amounts_of_something()

	var t = TreelessSingleton.get_inst()
	var t2 = TreelessSingleton.get_inst()
	var uses = load('uses_treeless_singleton.gd').new()

	if(t == t2 and t2 == uses.get_ts()):
		print('Got the same one.')
	else:
		print('!! It did not work !!')

	t2.do_something()

	t2.free()
	cleanup()
	quit()
