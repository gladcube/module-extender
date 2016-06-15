## Usage

#### extend
Extend method or property in the object.
```livescript
  _module = (
    hello: (name)->
      "Hello #name!"
  )
  |> extend \hello, (f)->
    (name)->
      f \lorem + name
  name = _module.hello \foo #<=  "Hello loremfoo!"
```
#### replace
Replace method or property in the object, to the other method.

```livescript
  _module =(
    hello:(name)->
      "Hello #name!"
  )
  |> replace \hello, (name)->
    \lorem + name
  name = _module.hello \foo #<= "loremfoo"
```
#### before
Extend method in the object.
When extended method is called. extention part will be called before original part.

```livescript
  _module =(
    hello_then:(name, cb)->
      cb "Hello #name!"
  )
  |> before \hello_then, (name, cb, next)->
    next \lorem + name, cb
  name <- _module.hello_then \foo  #<= "Hello loremfoo!"

```
#### after
Extend method in the object.
When extended method is called. extention part will be called after original part.

```livescript
  _module =(
    hello_then:(name, cb)->
      cb "Hello #name!"
  )
  |> after \hello_then, (name, cb)->
    cb \lorem + name
  name <- _module.hello_then \foo #<= "loremHello foo!"
```
