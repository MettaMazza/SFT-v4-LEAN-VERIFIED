import SFT.Chemistry.ElectronSpinHtml
namespace SFT.Chemistry.HtmlUnescapeLinear
open SFT.Host
open ElectronSpinHtml (characterReference)
def unescapeChars : Nat → List Char → List Char
 | 0,cs => cs
 | _+1,[] => []
 | fuel+1,c::cs =>
   if c.toNat==38 then
    match characterReference cs with
    | some (decoded,tail) => Text.chars decoded ++ unescapeChars fuel tail
    | none => '&' :: unescapeChars fuel cs
   else c :: unescapeChars fuel cs
def unescapeAux (fuel : Nat) (cs : List Char) : String :=
 String.ofList (unescapeChars fuel cs)
def unescape (s : String) : String := let cs:=Text.chars s; unescapeAux (cs.length+1) cs
def joinWords : List (List Char) → List Char
 | [] => []
 | word::rest =>
   match rest with
   | [] => word
   | _::_ => word ++ (' ' :: joinWords rest)
def normalizeSpace (s : String) : String :=
 let state := (Text.chars s).foldl (fun (acc : List (List Char) × List Char) c =>
  if SFT.Physics.CapabilityValues.whitespace c then
   if acc.2.isEmpty then acc else (acc.2.reverse::acc.1,[])
  else (acc.1,c::acc.2)) ([],[])
 let words := (if state.2.isEmpty then state.1 else state.2.reverse::state.1).reverse
 String.ofList (joinWords words)
end SFT.Chemistry.HtmlUnescapeLinear
#print axioms SFT.Chemistry.HtmlUnescapeLinear.unescapeChars
#print axioms SFT.Chemistry.HtmlUnescapeLinear.unescapeAux
#print axioms SFT.Chemistry.HtmlUnescapeLinear.unescape
#print axioms SFT.Chemistry.HtmlUnescapeLinear.joinWords
#print axioms SFT.Chemistry.HtmlUnescapeLinear.normalizeSpace
