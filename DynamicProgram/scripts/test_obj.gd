var Mock = load('res://scripts/mock.gd')
var _mocker = Mock.new()

var _testables = {}

func make_testable(target_path, dest_path):
    print(ResourceLoader.get_dependencies(target_path))
    ResourceLoader = null
    _testables[target_path] = dest_path
    var src_file = File.new()
    src_file.open(target_path, src_file.READ)

    var test_file = File.new()
    test_file.open(dest_path, test_file.WRITE)

    var line = ''
    while(!src_file.eof_reached()):
        line = src_file.get_line()
        line = line.replace('load(', 'testable.load_mock(')
        test_file.store_string(line + "\n")
        if(line.find('extends') == 0):
            test_file.store_string(str('var testable = instance_from_id(', get_instance_id(), ")\n"))

func load_mock(path):
    var filename = path.get_file()
    var mfile = 'res://temp_files/' + filename
    _mocker.write_file(path, mfile)
    return load(mfile)

func get_new(target_path):
    return load(_testables[target_path]).new()

class Stub:
    func stub(method):
        return self

    func with(params):
        return self

    func to_return(return):
        return self
