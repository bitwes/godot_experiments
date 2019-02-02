This is a proof of concept repo, and not a reusable tool.  I'm still not sure if this is even a good idea.  But I've wanted this so I tried to make it.

This is a Singleton that works without having to use Autoload.  It allows scripts that are not in the tree to get to the same instance of an object.

You can still Autoload it, and most likely you would.  If you do, this also works as a nice way to give objects NOT in the tree access to the tree since the autoloaded one would have reference to the tree.

This uses a file in `user://` to store an instance id.  When you call `get_inst` it will try to load that instance id and make sure that it is the type of object it should be.  If that works then the instance from that file is returned, otherwise it makes a new one.

The actual class writes the file (not `get_inst`) in the `_init` method.  It does that so Autoload will work (the engine will call `new` when autoloading).  Because of this it requires you to be sure that you NEVER call `new` and always use the static `get_inst` method.  If you accidentally call `new` then you'll end up with 2 or more instances of the singleton.

I have no idea if this will actually work in practice but here it is.  I've heard talk that Godot is planning on putting something like this into the engine eventually but I don't know when it will happen.
