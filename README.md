ChangeVariables Package for Mathematica
========================================

Summary
----------------------------------------

A package to change variables in symbolic (differential) equations in Mathematica.

Example: `x df(x,y)/dx` and transform `x->r` with the definition `r(x) = 1/x`:
```mathematica
ChangeVariables[x D[f[x,y],x], x, r, (1/# &)]
```
Output:
```mathematica
{-r (f^(1,0))[r,y]}
```

Installation
----------------------------------------

- Either load the package with `Get[absoluteFilePathToPackageFile]`, where the file path is to `ChangeVariables.wl`
- Or install the package by clicking `file` -> `install`

Features
----------------------------------------
- In some `equation` change the variable `a` to the variable `b` with definition `toVarDef` (Lambda/Pure function): `ChangeVariables[equation, a, b, toVarDef]`
- the functions in equation can have an arbitrary amount of arguments, e.g. `f[x,y,z,a,b]`
- arbitrary amounts of derivatives `D[f[x,y], {x,1337}, {y, 42}]`

Known Bugs
----------------------------------------

- I had to *blacklist* internal functions like `Plus` and `Times` in order to not transform them.
If your expression contains a function like that that I have not thought of, then you might get nonsense.
I would appreciate a quick note if you have encountered such an example.

ToDo
----------------------------------------
- Convert more than one function at a time
- Option for explicitly stating a function that should be blacklisted, see Known Bugs
- Clean up source code such that it is actually readable
- Tests
