{throws, does-not-throw, equal} = require \assert

module.exports = new class ModuleExtenderAssertion
  extend: extend =
    (extend)->
      _module = (
        hello: (name)->
          "Hello #name!"
      )
      |> extend \hello, (f)->
        (name)->
          f \lorem + name
      equal (_module.hello \foo), "Hello loremfoo!"
    (extend)->
      _module = (
        bar: \foobar
        foo: \foofoo
      )
      |> extend \bar, (p)->
          p + \lorem
      |> act (get \bar) >> (equal _, \foobarlorem)
      |> (get \foo) >> (equal _, \foofoo)
  replace: replace =
    (replace)->
      _module =(
        hello:(name)->
          "Hello #name!"
      )
      |> replace \hello, (name)->
        \lorem + name
      equal (_module.hello \foo), \loremfoo
  before: before =
    (before)->
      _module =(
        hello_then:(name, cb)->
          cb "Hello #name!"
      )
      |> before \hello_then, (name, cb, next)->
        next \lorem + name, cb
      name <- _module.hello_then \foo
      equal(name, "Hello loremfoo!")
  after: after =
    (after)->
      _module =(
        hello_then:(name, cb)->
          cb "Hello #name!"
      )
      |> after \hello_then, (name, cb)->
        cb \lorem + name
      name <- _module.hello_then \foo
      equal(name, "loremHello foo!")
