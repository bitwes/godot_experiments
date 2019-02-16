extends Node2D

static func _get_instance_from_file(path, Self):
	var f = ConfigFile.new()
	var to_return = null

	f.load(path)
	var id = f.get_value('ts', 'instance_id', -1)
	if(id != -1):
		to_return = instance_from_id(id)
		# Make sure that we got an instance from instance_from_id and that the
		# instance is what we think it is.  Since the file will exist across
		# multiple runs, there's a solid chance that the instance id in there
		# is not going to be the instance we want.
		if(to_return != null and !to_return is Self):
			to_return = null

	return to_return

static func get_inst():
	var SAVE_FILE_PATH = 'user://save_file.txt'
	# I don't know if there is a dynamic way to get to this or not.  If not, then
	# we won't be able to make multiple different singletons w/o passing in the
	# path to itself to this method.
	var Self = load('treeless_singleton.gd')

	var to_return = _get_instance_from_file(SAVE_FILE_PATH, Self)
	if(to_return == null):
		to_return = Self.new()

	return to_return


var some_state = 'not set yet'
func do_something():
	print('did it')

func _write_instance_to_file(path, inst):
	var f = ConfigFile.new()
	f.set_value('ts', 'instance_id', inst.get_instance_id())
	f.save(path)

func _init():
	# The init method has to write the save file so that we can use this as
	# and autoload as well.  When used as an autoload, the engine will call
	# new() hopefully before we ever try to make one with get_inst().
	_write_instance_to_file('user://save_file.txt', self)
	print('! in _init')
