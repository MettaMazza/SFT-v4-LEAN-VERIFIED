import SFT.Chemistry.ElectronCountSpin
namespace SFT.Chemistry.ConjugatedSupport
open SFT.Host SFT.Physics.CapabilityValues

def atom (label : String) : Except String HeldLabel := heldLabel "conjugated-atom-occurrence" label
def fibre (label : String) : Except String HeldLabel :=
 if !(Text.equal label "fold-fibre-one" || Text.equal label "fold-fibre-two") then
 .error "conjugated support admits exactly the two forced Fold fibres"
 else heldLabel "conjugated-support-fibre" label
structure ExactConjugatedSupport where
 carrier : HeldLabel
 atoms : List HeldLabel
 supportFibres : List HeldLabel

def validSupport (support : ExactConjugatedSupport) : Except String ExactConjugatedSupport := do
 if !Text.equal support.carrier.family "molecular-carrier" then
  throw "conjugated support requires one retained molecular carrier"
 if support.atoms.length < 3 || !ElectronCountSpin.distinctLabels support.atoms then
  throw "conjugated support requires at least three distinct atom occurrences"
 if !(support.atoms.all (fun row => Text.equal row.family "conjugated-atom-occurrence")) then
  throw "conjugated atom identity is invalid"
 if support.supportFibres.length != support.atoms.length-1 then
  throw "every adjacent atom pair must retain exactly one support fibre"
 if !(support.supportFibres.all (fun row => Text.equal row.family "conjugated-support-fibre" &&
  (Text.equal row.label "fold-fibre-one" || Text.equal row.label "fold-fibre-two"))) then
  throw "support contains a non-Fold fibre"
 if (support.supportFibres.zip support.supportFibres.tail).any (fun pair => ElectronCountSpin.sameLabel pair.1 pair.2) then
  throw "adjacent support fibres must alternate"
 return support

def atomCount (support : ExactConjugatedSupport) : Except String PositiveCount := count support.atoms.length
def supportCount (support : ExactConjugatedSupport) : Except String PositiveCount := count support.supportFibres.length

def labelAt : List HeldLabel → Nat → Except String HeldLabel
 | [],_ => .error "tuple index out of range"
 | a::_,0 => .ok a
 | _::rest,n+1 => labelAt rest n

def incidences (support : ExactConjugatedSupport) : Except String (List (HeldLabel × HeldLabel × HeldLabel)) :=
 (List.range support.supportFibres.length).mapM fun index => do
  let left ← labelAt support.atoms index
  let held ← labelAt support.supportFibres index
  let right ← labelAt support.atoms (index+1)
  pure (left,held,right)

def conjugatedSupport (carrierLabel : String) (atomLabels fibreLabels : List String) : Except String ExactConjugatedSupport := do
 let carrier ← heldLabel "molecular-carrier" carrierLabel
 let atoms ← atomLabels.mapM atom
 let fibres ← fibreLabels.mapM fibre
 validSupport ⟨carrier,atoms,fibres⟩

def lastFibre : List HeldLabel → Except String HeldLabel
 | [] => .error "tuple index out of range"
 | a::[] => .ok a
 | _::b::rest => lastFibre (b::rest)

def appendOpposedFibre (support : ExactConjugatedSupport) (atomLabel : String) : Except String ExactConjugatedSupport := do
 let fresh ← atom atomLabel
 if support.atoms.any (ElectronCountSpin.sameLabel fresh) then
  throw "successor atom occurrence must be fresh"
 let last ← lastFibre support.supportFibres
 let next ← fibre (if Text.equal last.label "fold-fibre-one" then "fold-fibre-two" else "fold-fibre-one")
 validSupport ⟨support.carrier,support.atoms++[fresh],support.supportFibres++[next]⟩

#print axioms atom
#print axioms fibre
#print axioms validSupport
#print axioms atomCount
#print axioms supportCount
#print axioms labelAt
#print axioms incidences
#print axioms conjugatedSupport
#print axioms lastFibre
#print axioms appendOpposedFibre
end SFT.Chemistry.ConjugatedSupport
