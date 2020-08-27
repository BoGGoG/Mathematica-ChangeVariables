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

You can find examples in `UseChangeVariables.wls` or in `Tests/TestChangeVariables.wls`.

Installation
----------------------------------------

- Either load the package with `Get[absoluteFilePathToPackageFile]`, where the file path is to `ChangeVariables.wl`
- Or install the package by clicking `file` -> `install`.

Features
----------------------------------------
- In some `equation` change the variable `a` to the variable `b` with definition `toVarDef` (Lambda/Pure function): `ChangeVariables[equation, a, b, toVarDef]`.
- the functions in equation can have an arbitrary amount of arguments, e.g. `f[x,y,z,a,b]`
- arbitrary amounts of derivatives `D[f[x,y], {x,1337}, {y, 42}]`.
- If your definition `toVarDef` has a non-unique inverse, e.g. `x`->`y=Cos[x]`, then `x=ArcCos[y]+2 Pi c`, where `c` is an integer.The output will show this.

Known Bugs
----------------------------------------

- I had to *blacklist* internal functions like `Plus` and `Times` in order to not transform them.
If your expression contains a function like that that I have not thought of, then you might get nonsense.
I would appreciate a quick note if you have encountered such an example.
- `ChangeVariables[Cos[x] f[x, y], x, u, (Cos[#] &)]` still has a conditional statement as output with `c` an integer, but there is actually no ambiguity left.

ToDo
----------------------------------------
- Convert more than one function at a time.
- Option for explicitly stating a function that should be blacklisted, see Known Bugs.
- Option to give inverse function as argument, e.g. if `x`->`y=Log[x]` you could give `Exp[#]&` instead and let Mathematica invert.
- Clean up source code such that it is actually readable.
- Tests.

Author
----------------------------------------
Marco Knipfer   
University of Alabama
