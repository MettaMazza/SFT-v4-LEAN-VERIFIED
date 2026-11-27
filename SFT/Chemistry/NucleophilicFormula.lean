import SFT.Chemistry.ElectronSpinSource
namespace SFT.Chemistry.NucleophilicFormula
open SFT.Host ElectronSpinSource

def digit (c : Char) : Bool := 48≤c.toNat && c.toNat≤57
def positiveStart (c : Char) : Bool := 49≤c.toNat && c.toNat≤57
def addEntry (rows : List (String × Int)) (key : String) (value : Int) : List (String × Int) :=
 let prior := match rows.find? (fun p => Text.equal p.1 key) with | none => 0 | some p => p.2
 if rows.any (fun p => Text.equal p.1 key) then rows.map (fun p => if Text.equal p.1 key then (key,prior+value) else p) else rows++[(key,value)]
def parseParts : Nat → List Char → List (String × Int) → Except String (List (String × Int))
 | 0,_,_ => .error "ORG-007 external formula cannot be reconstructed"
 | _+1,[],rows => if rows.isEmpty then .error "ORG-007 external formula cannot be reconstructed" else .ok rows
 | fuel+1,c::cs,rows =>
  if !upper c then .error "ORG-007 external formula cannot be reconstructed" else
  let (symbol,rest) := match cs with
   | [] => ([c],[]) | d::ds => if lower d then ([c,d],ds) else ([c],cs)
  let digits := match rest with
   | [] => [] | d::_ => if positiveStart d then rest.takeWhile digit else []
  let n := if digits.isEmpty then 1 else digits.foldl (fun n d => 10*n+(d.toNat-48)) 0
  parseParts fuel (rest.drop digits.length) (addEntry rows (String.ofList symbol) (.ofNat n))
def formula (s : String) : Except String (List (String × Int)) :=
 let body := ((Text.chars s).reverse.dropWhile (fun c => c.toNat==43 || c.toNat==45)).reverse
 parseParts (body.length+1) body []
def insert (p : String × Int) : List (String × Int) → List (String × Int)
 | [] => [p]
 | q::qs => if Text.le p.1 q.1 then p::q::qs else q::insert p qs
def sorted : List (String × Int) → List (String × Int)
 | [] => [] | p::ps => insert p (sorted ps)
def sum (rows : List (List (String × Int))) : List (String × Int) :=
 sorted (rows.foldl (fun acc row => row.foldl (fun acc pair => addEntry acc pair.1 pair.2) acc) [])
def value (rows : List (String × Int)) : Canonical.Value :=
 .object (rows.map fun p => (p.1,Canonical.Value.integer p.2))
end SFT.Chemistry.NucleophilicFormula
