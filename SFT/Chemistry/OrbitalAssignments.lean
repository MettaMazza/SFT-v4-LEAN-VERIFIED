import SFT.Chemistry.ElectronSpinHtml
namespace SFT.Chemistry.OrbitalAssignments
open SFT.Host ElectronSpinHtml
structure Term where
 multiplicity : Nat
 symbol : String
structure Configuration where
 radial : Nat
 family : String
 symbol : String
 occupancy : Nat
def positiveDigit (c : Char) : Bool := 49 ≤ c.toNat && c.toNat ≤ 57
def termSymbol (c : Char) : Bool := ['Σ','Π','Δ','Φ'].contains c
def orbitalSymbol (c : Char) : Bool := ['σ','π','δ','φ'].contains c
def orbitalFamily (c : Char) : Bool := ['s','p','d','f','g','h'].contains c
def alphaNumeric (c : Char) : Bool := decimal c || (65 ≤ c.toNat && c.toNat ≤ 90) || (97 ≤ c.toNat && c.toNat ≤ 122)
def positiveNumber (cs : List Char) : Option (Nat × List Char) :=
 match cs with
 | [] => none
 | c::_ => if !positiveDigit c then none else
   let digits := cs.takeWhile decimal
   some (number 10 digits,cs.drop digits.length)
def termAt : List Char → Option (Term × List Char)
 | [] => none
 | c::cs => if c.toNat != 94 then none else
   match positiveNumber cs with
   | none => none
   | some (n,rest) => match rest with
     | [] => none
     | symbol::tail => if termSymbol symbol then some (⟨n,String.ofList [symbol]⟩,tail) else none
def termsAux : Nat → List Char → List Term
 | 0,_ => []
 | _+1,[] => []
 | fuel+1,c::cs => match termAt (c::cs) with
   | some (term,tail) => term::termsAux fuel tail
   | none => termsAux fuel cs
def terms (s : String) : List Term := let cs:=Text.chars s; termsAux (cs.length+1) cs
def configurationAt (previous : Option Char) (cs : List Char) : Option (Configuration × Char × List Char) :=
 if previous.any alphaNumeric then none else
 match positiveNumber cs with
 | none => none
 | some (radial,rest) => match rest with
   | [] => none
   | family::tail => if !orbitalFamily family then none else
     match tail.dropWhile SFT.Physics.CapabilityValues.whitespace with
     | [] => none
     | symbol::rest => if !orbitalSymbol symbol then none else
       let plain : Configuration := ⟨radial,String.ofList [family],String.ofList [symbol],1⟩
       match rest with
       | [] => some (plain,symbol,[])
       | c::tail => if c.toNat != 94 then some (plain,symbol,rest) else
         match positiveNumber tail with
         | none => some (plain,symbol,rest)
         | some (occupancy,remaining) =>
           let digits := tail.takeWhile decimal
           let last := digits.foldl (fun _ c => c) symbol
           some ({plain with occupancy:=occupancy},last,remaining)
def configurationsAux : Nat → Option Char → List Char → List Configuration
 | 0,_,_ => []
 | _+1,_,[] => []
 | fuel+1,previous,c::cs => match configurationAt previous (c::cs) with
   | some (row,last,tail) => row::configurationsAux fuel (some last) tail
   | none => configurationsAux fuel (some c) cs
def configurations (s : String) : List Configuration :=
 let cs:=Text.chars s; configurationsAux (cs.length+1) none cs
end SFT.Chemistry.OrbitalAssignments
