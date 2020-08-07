(* ::Package:: *)

(* ::Text:: *)
(*Title: ChangeVariables*)
(*Purpose: To change variables in a differential equation, e.g. for f'[x] change x->u=1/x*)
(*Author: Marco Knipfer*)
(**)


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
(*Messages "examplefunction"*)


examplefunction::usage="examplefunction[] is an example. It returns \"Hello World!\""
examplefunction::usage="examplefunction[exampleinput] is an example. It returns \"Hello World!\" Sometimes exampleinput might appear in the description as well. Multiple usages are allowed."


(* ::Title:: *)
(*Begin Private/Functions Definitions*)


(* ::Text:: *)
(*Private definitions here.*)


Begin["`Private`"];


(* ::Section:: *)
(*Example Tagline of Example Function "examplefunction"*)


(* ::Subsection:: *)
(*Options*)


Options[examplefunction]={};
SyntaxInformation[examplefunction]={"ArgumentsPattern"->{_},"ArgumentsPattern"->{}};


(* ::Subsection:: *)
(*Definition 1*)


examplefunction[]:=Print["Hello World!"]


(* ::Subsection:: *)
(*Definition 2*)


examplefunction[inputstring_String]:=Print["Hello World! Let's go, "<>inputstring<>"!"]


(* ::Title:: *)
(*End Package*)


(* ::Text:: *)
(*Sets the functions of the package to be protected from changes.*)


Scan[SetAttributes[#, {Protected, ReadProtected}]&,
     Select[Symbol /@ Names["ChangeVariables`*"], Head[#] === Symbol &]];

End[];
EndPackage[];
