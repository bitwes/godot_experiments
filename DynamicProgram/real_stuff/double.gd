var testable = null

func double_object(target_path, dest_path):
	write_file(target_path, dest_path)

func write_file(target_path, dest_path):
	print('creating mock of:  ', target_path, ' at ', dest_path)

	var script_methods = get_methods(target_path)
	var f = File.new()
	f.open(dest_path, f.WRITE)
	f.store_string(str('var mocker = instance_from_id(', get_instance_id(),")\n"))
	f.store_string(str('var testable = ', testable.dyn_ref(), "\n"))
	for i in range(script_methods.size()):
		f.store_string(get_mock_method_text(target_path, script_methods[i]))
	f.close()

func get_methods(target_path):
	var obj = load(target_path).new()

	var other_methods = [] # anything not defined in the script
	var script_methods = [] # any mehtod in the script or super script
	var to_mock = [] # name indexer to avoid dupes from supers

	var methods = obj.get_method_list()
	for i in range(methods.size()):
		# 65 is a magic number for methods in script, though documentation
		# says 64.  This picks up local overloads of base class methods too.
		if(methods[i]['flags'] == 65):
			if(!to_mock.has(methods[i]['name'])):
				to_mock.append(methods[i]['name'])
				script_methods.append(methods[i])
		else:
			#print(methods[i]['name'])
			other_methods.append(methods[i])
	return script_methods

func get_arg_text(args):
	var text = ''
	for i in range(args.size()):
		text += args[i]['name']
		text += ' = null'
		if(i != args.size() -1):
			text += ', '
	return text

func get_mock_method_text(script, method_hash):
	var name = method_hash['name']
	print('mocking:  ', name)

	var body = str('func ', name, '(', get_arg_text(method_hash['args']), "):\n")
	body += str("\treturn testable.get_return_value('",script, "','", name, "')\n")
	return body

func msg_from_mock():
	return 'WE ARE HERE!'
