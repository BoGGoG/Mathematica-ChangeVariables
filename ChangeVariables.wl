(* ::Package:: *)

(* ::Text:: *)
(*Title: ChangeVariables*)
(*Purpose: To change variables in a differential equation, e.g. for f'[x] change x->u=1/x*)
(*Author: Marco Knipfer*)
(**)
(*Note: I am sorry for this mess, it is pretty unreadable right now.*)
(**)
(*ToDo: Clean up, refactor, bring the trash out and clean the house.*)


(* ::Title:: *)
(*Begin Package*)


BeginPackage["ChangeVariables`"];

Unprotect["ChangeVariables`*"];
ClearAll["ChangeVariables`*", "ChangeVariables`Private`*"];


(* ::Chapter:: *)
(*Messages & Public Declarations*)


(* ::Text:: *)
(*Messages and documentation for public facing functions go here. *)


(* ::Section::Closed:: *)
(*Messages "ChangeVariables"*)


(* ::Input::Initialization:: *)
ChangeVariables::usage="ChangeVar[expression, fromVar, toVar, toVarDef] takes the expression and converts fromVar to toVar by using its definition toVarDef.
	toVarDef is a lambda (pure) function.
Example:
	- expression = f[t, x]
	- fromVar = x
	- toVar = u
	- toVarDef = (1/# &) (* means u=1/x in lambda form*)
Works for arbitrary functions with arbitrary amounts of arguments.

WARNING: There is a problem with internal functions like Times, Plus, ...
	They need to be 'filtered out' in the function containsNoForbiddenFunction. If you encounter mistakes in the change of variables this might be the reason. It is a nasty 'bug' because there is no message or error message, it's simply wrong if there is a function that is not listed in containsNoForbiddenFunction. More details  on this in the Definition of containsNoForbiddenFunction. I might add an option for white or blacklisting of functions at some point.
";


(* ::Section:: *)
(*Messages "TransformNthDeriv*)


TransformNthDeriv::usage="Internal function, just public for testing. Usage:
TransformNthDeriv[f[r], r, u, (1 / # &), {1}] transforms the first derivative of f with respect to r with the definition u=1/r.";


(* ::Title:: *)
(*Begin Private/Functions Definitions*)


(* ::Text:: *)
(*Private definitions here.*)


Begin["`Private`"];


(* ::Section:: *)
(*splitCoords*)


(* ::Input::Initialization:: *)
splitCoords[coords_, fromVarPos_] := Block[{xs, ys},
xs = coords[[1;;fromVarPos-1]];
ys = coords[[fromVarPos+1;;]];
{xs, ys}
]


(* ::Section:: *)
(*splitDerivsList*)


(* ::Input::Initialization:: *)
splitDerivsList[derivsList_, fromVarPos_] := Block[{ndxs, ndys, ndr},
ndxs = derivsList[[1;;fromVarPos-1]];
ndys = derivsList[[fromVarPos+1;;]];
ndr = derivsList[[fromVarPos]];
{ndxs, ndr, ndys}
];


(* ::Section:: *)
(*TransformNthDeriv*)


(* ::Input::Initialization:: *)
TransformNthDeriv[function_, fromVar_, toVar_, toVarDef_, derivsList_] := Block[{preFactor, expr, op, fromVarPos,dx, ys, ndxs, ndys, ndr, tmpFunction},
coords = function/.f_[arguments___]->arguments; (* sequence! *)
fromVarPos = Position[List@coords, fromVar][[1,1]];

{xs, ys} = splitCoords[List@coords, fromVarPos];
{ndxs, ndr, ndys} = splitDerivsList[derivsList, fromVarPos];


(* set derivatives wrt. fromVar to zero *)
tmpFunction = Apply[Derivative[##][Head@function][coords]&][Join[ndxs, {0}, ndys]];
preFactor =1/ D[toVarDef[toVar], toVar];
op[expr_] := preFactor* D[expr/.{fromVar -> toVar}, toVar];
Nest[op, tmpFunction, ndr] 
]


(* ::Section:: *)
(*getFromVarDef*)


(* ::Input::Initialization:: *)
getFromVarDef[fromVar_, toVar_, toVarDef_] := Block[{},
	Solve[toVarDef[fromVar] == toVar, fromVar]
];


(* ::Section:: *)
(*containsNoForbiddenFunction*)


(* ::Input::Initialization:: *)
(* Say we want r \[Rule] u = 1/r, then the problem is that I want to transform f[r] \[Rule] f[u], but not r f[r] to u f[u], but 1/u f[u]
Also I don't want 1/u f[1/u].
But r f[r] is internally Times[r,f[r]] so I need to filter out the times, because otherwise it would also math for f_[x__, r, y__]
Thus this ugly function
*) 
containsNoForbiddenFunction[f_] := Block[{forbiddenFunctions, checkList},
forbiddenFunctions = {Plus, Minus, Times, Cos, Sin, Tan, Exp, Log, ArcCos, ArcSin, Power}; (* basically every built in function, is there a way to find all build in functions? *)
checkList = Map[FreeQ[f, #]&, forbiddenFunctions];
And@@checkList
]


(* ::Section:: *)
(*ChangeVariables*)


(* ::Input::Initialization:: *)
ChangeVariables[expression_, fromVar_, toVar_, toVarDef_] := Block[{derivRule, funcRule,ndx, ndy,f,  xs, ys, ddd, factorRule},

derivRule = Derivative[nd___][f_][xs___,fromVar, ys___] :> TransformNthDeriv[f[xs,fromVar,ys], fromVar, toVar, toVarDef, List@nd];
funcRule = f_[xs___, fromVar, ys___]/;FreeQ[f, Times]/;containsNoForbiddenFunction[f]-> f[xs, toVar, ys];
factorRule = getFromVarDef[fromVar, toVar, toVarDef];
transformedExpressions = expression /. derivRule /.funcRule /. factorRule  // Simplify; (* might be more because of inverse functions *)
DeleteDuplicates[transformedExpressions]
];


(* ::Title:: *)
(*End Package*)


(* ::Text:: *)
(*Sets the functions of the package to be protected from changes.*)


Scan[SetAttributes[#, {Protected, ReadProtected}]&,
     Select[Symbol /@ Names["ChangeVariables`*"], Head[#] === Symbol &]];

End[];
EndPackage[];
