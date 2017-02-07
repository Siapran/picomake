# picomake

A simple tool for merging splitted pico8 code back into a cart.

Requires [picotool](https://github.com/dansanderson/picotool).

## Example usage

    > ls
    depend.lua  Makefile  picorausers.p8 README.md  src

    > ls src/
    entity.lua  graphics.lua  main.lua  oop.lua 
    physics.lua  quadtree.lua  rauser.lua  world.lua

You may specify a dependancy by using the `require` statement

    > cat src/rauser.lua 
    require("oop")

    rauser = make_class(object)

    rauser.types = {
      gun = {"original", "beam", "spread", "missiles", "cannon"},
      body = {"original", "armor", "melee", "nuke", "bomb"},
      engine = {"original", "superboost", "gungine", "underwater", "hover"}
    }

    rauser.current_type = {
      gun	= 1,
      body   = 1,
      engine = 1
    }
    
Then, simply make your project:

    > make
    lua depend.lua
    p8tool build --lua code.lua ./picorausers.p8

`picorausers.p8` is now updated with your agglomerated code
