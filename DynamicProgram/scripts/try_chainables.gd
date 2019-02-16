extends SceneTree
# ------------------------------
# ------------------------------
class Chainable:
    var _obj = null
    func expect(obj):
        _obj = obj
        return self

    func to_have_method(name):
        return _obj.has_method(name)

    func to_eq(value):
        return _obj == value

    func to_ne(value):
        return _obj != value

# ------------------------------
# ------------------------------
class Thing:
    func some_method():
        pass

# ##############################################################################
# ##############################################################################
var c = Chainable.new()
func _init():
    main()
    quit()

func expect(obj):
    return c.expect(obj)

func main():
    var t = Thing.new()

    print(expect(t).to_have_method('some_method'))
    print(expect('a').to_eq('a'))
    print(expect(1).to_ne(15))
