# run this from the command line.
extends SceneTree
var Mock = load('res://scripts/mock.gd')
var Testable = load('res://scripts/testable.gd')

func _init():
    main()
    quit()

func main():
    var t = Testable.new()
    t.returns['res://resources/mock_me.gd'] = 'MAGIC!!'
    var inst = t.get_new('res://resources/test_me.gd')
    inst.this_is_it()

    t.returns['res://resources/mock_me.gd'] = 'MORE MAGIC!!'
    var inst2 = t.get_new('res://resources/test_me.gd')
