{obj-to-pairs, at, pairs-to-obj} = require \prelude-ls
{$_when, $_at, return_, before, after} = require \glad-functions

module.exports =
  extend: extend = (key, f, module)-->
    module
    |> obj-to-pairs
    |> $_when ((at 0) >> (is key)),
      $_at 1, f
    |> pairs-to-obj
  replace: (key, f, module)-->
    extend key, (return_ f), module
  before: (key, cb, module)-->
    extend key, (before _, cb), module
  after: (key, cb, module)-->
    extend key, (after _, cb), module

