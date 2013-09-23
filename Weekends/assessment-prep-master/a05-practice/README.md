# JavaScript Assessment - practice

This assessment aims to evaluate your knowledge of JavaScript's basic
and intermediate features. 

Topics covered:

  * Basic syntax: function declarations, objects, etc.
  * Closures, `this`, `apply`
  * Prototypal inheritance
  * Module pattern

You have 1 hour. The specs live in the `spec/` directory. Your code
should go in the `src/` directory in the files provided. All your
functions should be namespaced under `Assessment`.

How to run the specs: open up `SpecRunner.html` in a browser.

## Basic JavaScript

### `mergeSort`

Write a function `twoSum` that takes an array as an argument and returns
true if any two of the numbers in that array sum to 0. Return false
otherwise.

### `recursiveExponent`

Write a function `factors` that takes an integer as an argument and
returns an array of its factors.

### `powCall`

Write a function `fibonnaci` that takes an integer N as its argument and
returns the Nth Fibonnaci number (not N numbers, but the Nth Fibonnaci
number).

**Hints**: Define first two fibonacci numbers as 0 and 1. For our purposes,
the first fibonacci means N=1.

## Closures + `this`

### `myApply`

Write a function `myBind` that takes a function and a context as
arugments and returns the given function bound to that context (i.e. the
`this` keyword in the function should be the provided context).

### `transpose`

Write a function `addThenDo` that takes two numbers and a callback function; it
should add the two numbers (`sum`), call the callback function, and then
return `sum`. 

## Prototypal Inheritance

### `inherits`

Write a function `inherits` that takes two constructor functions (child
and parent) and properly sets up the prototype chain. The function
should return the child constructor. Your function should not call the
parent's constructor function in setting up the prototype chain.

## Module Pattern

### `WakeboardGame`

For this portion of the assessment, do not put anything in your
`Assessment` namespace. Use the `wakeboard_game.js` file.

In this file, set up the following in a single global namespace called
`WakeboardGame`. No portion of the module should be in the global
namespace; everything should be under `WakeboardGame`.

* `WakeboardGame.Boat`
  
  * Boat constructor that takes a sponsor and sets the boats's sponsor
  * The following methods on the prototype. Each method should simply
    return the name of the method as a string (i.e. `power` should
    return "power" - you can simply hardcode this).

      * `power`
      * `turn`
      * `sink`

* `WakeboardGame.Wakeboarder`

  * Constructor that takes a name and sponsor sets the wakeboarder's name and sponsor
  * Following methods that return the stringified function name:

      * `jump`
      * `spin`
      * `grind`
      * `crash`




 


