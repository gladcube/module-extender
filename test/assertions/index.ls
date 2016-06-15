{throws, does-not-throw, equal} = require \assert

module.exports = new class ModuleExtenderAssertion
  extend: extend =
    (extend)->
      (
        hello: (name)->
          "Hello #name!"
      )
      |> extend \hello, (f)->
        (name)->
          f \lorem + name
      |> (let_ _, \hello, \foo) >> (equal _, "Hello loremfoo!")
    (extend)->
      (
        bar: \foobar
        foo: \foofoo
      )
      |> extend \bar, (p)->
          p + \lorem
      |> act (get \bar) >> (equal _, \foobarlorem)
      |> (get \foo) >> (equal _, \foofoo)
  replace: replace =
    (replace)->
      (
        hello:(name)->
          "Hello #name!"
      )
      |> replace \hello, (name)->
        \lorem + name
      |> (let_ _, \hello, \foo) >> (equal _, \loremfoo)
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
