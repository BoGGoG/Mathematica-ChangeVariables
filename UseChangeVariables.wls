#!/usr/bin/env wolframscript
(* ::Package:: *)

(* ::Title:: *)
(*Examples for how to use the ChangeVariables package*)


(* ::Text:: *)
(*Author: Marco Knipfer*)


(* ::Text:: *)
(*If you find any bug or change of variables that does not give the correct answers please message me on github https://github.com/BoGGoG/Mathematica-ChangeVariables or best: Create an issue on github =)*)


(* ::Input::Initialization:: *)
packagePath = FileNameJoin[{NotebookDirectory[], "ChangeVariables.wl"}];
Get[packagePath]


(* ::Input::Initialization:: *)
?ChangeVariables


(* ::Section:: *)
(*Examples*)


(* ::Text:: *)
(*The syntax is ChangeVariables[expressions, fromVar, toVar, toVarDef].*)
(**)
(*If you want to change from x to u=x^2, then you write:*)


(* ::Input::Initialization:: *)
ChangeVariables[x f[x], x, u, (#^2&)]


(* ::Text:: *)
(*Note the two solutions, because x = +- Sqrt[u].*)


(* ::Input::Initialization:: *)
ChangeVariables[Cos[x] f[x,y], x, u, (Cos[#] &)]


(* ::Text:: *)
(*(the if condition comes from inverting the cos. This is a bug I need to fix.)*)


(* ::Text:: *)
(*Derivatives also work: x -> u = Sqrt[x]*)


(* ::Input::Initialization:: *)
ChangeVariables[x D[f[a,b,x,y,z], x], x, u, (#^(1/2)&)]


(* ::Input::Initialization:: *)
ChangeVariables[D[f[x],x], x, r, (1/#&)]


(* ::Input::Initialization:: *)
ChangeVariables[Cos[x] D[f[x,y], {x,2}], x, u, (Cos[#] &)]
