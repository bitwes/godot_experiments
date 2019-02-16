var files = []
var temp_dir = 'user://'
var prefix = '__double__'

func get_new_path(source_path):
	var fname = source_path.file_name()
	return temp_dir + prefix + fname
