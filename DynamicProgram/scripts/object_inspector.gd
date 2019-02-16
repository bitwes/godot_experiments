func print_local_functions(obj):
	print("local\n----")
	var methods = obj.get_method_list()
	for i in range(methods.size()):
		# 65 is a magic number for methods in script, though documentation
		# says 64.  This picks up local overloads of base class methods too.
		if(methods[i]['flags'] == 65):
			print('  ', methods[i]['name'])

func print_other_functions(obj):
	print("other\n----")
	var methods = obj.get_method_list()
	for i in range(methods.size()):
		# 65 is a magic number for methods in script, though documentation
		# says 64.  This picks up local overloads of base class methods too.
		if(methods[i]['flags'] != 65):
			print('  ', methods[i]['name'], '(', methods[i]['flags'], ')')

func print_properties(obj):
	print("properties\n----")
	var props = obj.get_property_list()
	for i in range(props.size()):
		print('  ', props[i])

func print_meta(obj):
	print("meta\n----")
	var meta = obj.get_meta_list()
	for i in range(meta.size()):
		print(meta[i])

func print_info(obj):
	print('class = ', obj.get_class())
	print('script = ', obj.get_script().get_path())
	print(" -- source -- \n", obj.get_script().source_code, "\n--------")
	print_local_functions(obj)
	print_other_functions(obj)
	print_properties(obj)
	print_meta(obj)
