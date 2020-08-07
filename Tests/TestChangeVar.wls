#!/usr/bin/env wolframscript
(* ::Package:: *)

(* ::Title:: *)
(*Test ChangeVariables*)


(* ::Text:: *)
(*Note that implicitly we convert a function f[r] to a different function g[u] = f[1/u] (or f[fromVarDef]) and call g f again.*)
(**)
(*ChangeVariables[expression, fromVar, toVar, toVarDef]*)
(**)
(*ToDo*)
(*- write tests that actually test the correctness and not just call the function*)


(* ::Code:: *)
(*Quit[]*)


(* ::Section:: *)
(*Tests*)


(* ::Input::Initialization:: *)
packagePath = FileNameJoin[{ParentDirectory[NotebookDirectory[]], "ChangeVariables.wl"}];
Get[packagePath]


(* ::Input::Initialization:: *)
ChangeVariables[f[r], r, u, (1/# &)]


(* ::Input::Initialization:: *)
ChangeVariables[r f[r], r, u, (1/# &)]


ChangeVariables[f'[r], r, u, (1/# &)]


(* ::Input::Initialization:: *)
ChangeVariables[r*f'[r], r, u, (1/# &)]


ChangeVariables[D[f[t,r],r], r, u, (1/# &)]


ChangeVariables[D[f[r,t,x,y,z], r], r, u, (1/# &)]


ChangeVariables[D[f[t,x,y,r,z], r], r, u, (1/# &)] 


ChangeVariables[func'[r], r, u, (Cos[#] &)]


TransformNthDeriv[f[r], r, u, (1 / # &), {1}]


TransformNthDeriv[f[r], r, u, (1 / # &), {2}] // Simplify // Expand


TransformNthDeriv[f[x,r,y], r, u, (1 / # &), {1,2,3}] // Simplify // Expand


ChangeVariables[Derivative[1][f][r] + Derivative[2][g][r], r, u, (1 / # &)] // Expand


ChangeVariables[Derivative[3][f][r], r, u, (1 / # &)] // Expand


ChangeVariables[Derivative[1][f][r], r, u, (Cos[#] &)] // Expand


(* ::Input::Initialization:: *)
ChangeVariables[Cos[r] f[r], r, u, (Cos[#]&)] (* ok this is ugly, but happens because of the inverse function of the cos *)
ChangeVariables[r Cos[r] f[r], r, u, (Cos[#]&)]


(* ::Input::Initialization:: *)
ChangeVariables[Cos[r] f[r], r, u, (#^2&)]


ChangeVariables[Derivative[0,1,0,0][f][a,r,x,y], r, u, (1/# &)]
ChangeVariables[r Derivative[0,1,0,0][f][a,r,x,y], r, u, (1/# &)]
ChangeVariables[r Cos[r] Derivative[0,1,0,0][f][a,r,x,y], r, u, (1/# &)]


ChangeVariables[Derivative[0,1,2,3][f][a,x,r,y], r, u, (1/# &)] // Expand


ChangeVariables[Derivative[1,1,2,0][f][r,a, x,y], r, u, (1/# &)]


ChangeVariables[Derivative[1,1,2,0][f][a,x,y,r], r, u, (1/# &)]


ChangeVariables[Derivative[1,1,0,5][f][a,r,x,y], r, u, (1/# &)] // Expand


ChangeVariables[Derivative[2,1,1,0][f][a,r,x,y], r, u, (1/# &)] // Expand


ChangeVariables[Derivative[1,1,0,0][f][a,r,x,y], r, u, (Cos[#] &)] // Expand


(* ::Input::Initialization:: *)
ChangeVariables[Derivative[1,1,0,0][f][a,r,x,y], r, u, (#^2 &)] // Expand


(* ::Input::Initialization:: *)
ChangeVariables[r Derivative[1,1,0,0][f][a,r,x,y], r, u, (#^2 &)] // Expand


(* ::Input::Initialization:: *)
DEQ = x f[x] + x^2 g'[x] +D[h[x,t],x,t,t]+ Cos[x]
ChangeVariables[DEQ, x, y, (1/#&)] 
ChangeVariables[DEQ, x, y, (Cos[#]&)] 


(* ::Section:: *)
(*Comparison to MarkusChangeVarTest*)


ChangeVariables[D[f[x,t],x,x]+D[f[x,t],x,t], x, r, (#^(1/2)&)] // Simplify // Expand


ChangeVariables[D[f[x,t],x,x]+D[f[x,t],x,t]+g[x], x, r, (#^(1/2)&)] // Simplify // Expand


ChangeVariables[D[f[x,t],x,x]+D[f[x,t],x,t]+g[x], x, r, (#^(1/2)&)] // Simplify // Expand


(* ::Section:: *)
(*Experimental*)


(* ::Text:: *)
(*Test whatever you want here. If it's a useful test you can then put it in the section above.*)
