import SFT.Chemistry.ConjugatedSupport
namespace SFT.Chemistry.ResonanceEquivalent
open SFT.Host SFT.Physics.CapabilityValues
abbrev Edge := HeldLabel × HeldLabel
structure ExactMolecularEncoding where
 encoding : HeldLabel
 carrier : HeldLabel
 atoms : List HeldLabel
 adjacency : List Edge
 fibres : List HeldLabel
structure ExactEquivalentRepresentationPair where
 carrier : HeldLabel
 first : ExactMolecularEncoding
 second : ExactMolecularEncoding

def atom (label : String) : Except String HeldLabel := heldLabel "representation-atom-occurrence" label
def fibre (label : String) : Except String HeldLabel :=
 if !(Text.equal label "fold-fibre-one" || Text.equal label "fold-fibre-two") then
  .error "representation support admits exactly two Fold fibres"
 else heldLabel "representation-support-fibre" label

def sameLabels : List HeldLabel → List HeldLabel → Bool
 | [],[] => true
 | [],_::_ => false
 | _::_,[] => false
 | a::as,b::bs => ElectronCountSpin.sameLabel a b && sameLabels as bs
def sameEdge (a b : Edge) : Bool := ElectronCountSpin.sameLabel a.1 b.1 && ElectronCountSpin.sameLabel a.2 b.2
def sameEdges : List Edge → List Edge → Bool
 | [],[] => true
 | [],_::_ => false
 | _::_,[] => false
 | a::as,b::bs => sameEdge a b && sameEdges as bs
def distinctEdges : List Edge → Bool
 | [] => true
 | a::rest => !(rest.any (sameEdge a)) && distinctEdges rest

def validEncoding (value : ExactMolecularEncoding) : Except String ExactMolecularEncoding := do
 if !Text.equal value.encoding.family "molecular-representation" then throw "representation identity is invalid"
 if !Text.equal value.carrier.family "molecular-carrier" then throw "one molecular carrier must remain held"
 if value.atoms.length < 3 || !ElectronCountSpin.distinctLabels value.atoms then throw "representation atom support is incomplete"
 if value.adjacency.length != value.fibres.length || value.adjacency.isEmpty then throw "every adjacency requires one held fibre"
 if value.adjacency.any (fun (left,right)=>!(value.atoms.any (ElectronCountSpin.sameLabel left)) ||
   !(value.atoms.any (ElectronCountSpin.sameLabel right)) || ElectronCountSpin.sameLabel left right) then
  throw "representation adjacency is invalid"
 if !distinctEdges value.adjacency then throw "representation adjacency is duplicated"
 if !(value.fibres.all (fun row=>Text.equal row.family "representation-support-fibre")) then
  throw "representation fibre identity is invalid"
 pure value

def complementLabels (labels : List HeldLabel) : Except String (List HeldLabel) :=
 labels.mapM fun row=>fibre (if Text.equal row.label "fold-fibre-one" then "fold-fibre-two" else "fold-fibre-one")

def validPair (pair : ExactEquivalentRepresentationPair) : Except String ExactEquivalentRepresentationPair := do
 if !Text.equal pair.carrier.family "molecular-carrier" then throw "representation class carrier is invalid"
 if !ElectronCountSpin.sameLabel pair.first.carrier pair.carrier || !ElectronCountSpin.sameLabel pair.second.carrier pair.carrier then
  throw "different carriers cannot be representation-equivalent"
 if ElectronCountSpin.sameLabel pair.first.encoding pair.second.encoding then
  throw "an alternative representation requires a distinct encoding identity"
 if !sameLabels pair.first.atoms pair.second.atoms then throw "representation equivalence must retain every atom occurrence"
 if !sameEdges pair.first.adjacency pair.second.adjacency then throw "representation equivalence must retain complete adjacency"
 if sameLabels pair.first.fibres pair.second.fibres then throw "identical fibre assignment is one encoding, not two alternatives"
 let complement ← complementLabels pair.first.fibres
 if !sameLabels complement pair.second.fibres then throw "alternative encoding must be the complete Fold-fibre complement"
 pure pair

def representationCount (_pair : ExactEquivalentRepresentationPair) : Except String PositiveCount := count 2

def positiveIndex : Int → Bool
 | .ofNat n => n>0
 | .negSucc _ => false

def encoding (name carrierLabel : String) (atomLabels : List String)
 (adjacencyIndices : List (Int × Int)) (fibreLabels : List String) : Except String ExactMolecularEncoding := do
 let atoms ← atomLabels.mapM atom
 if adjacencyIndices.any (fun (a,b)=>!positiveIndex a || !positiveIndex b) then
  throw "representation adjacency indices must be positive"
 let adjacency ← adjacencyIndices.mapM (fun (a,b)=>do
  let left ← match ConjugatedSupport.labelAt atoms (a.toNat-1) with
   | .error _ => .error "representation adjacency index is outside its atom support"
   | .ok x => .ok x
  let right ← match ConjugatedSupport.labelAt atoms (b.toNat-1) with
   | .error _ => .error "representation adjacency index is outside its atom support"
   | .ok x => .ok x
  pure (left,right))
 let encoded ← heldLabel "molecular-representation" name
 let carrier ← heldLabel "molecular-carrier" carrierLabel
 let fibres ← fibreLabels.mapM fibre
 validEncoding ⟨encoded,carrier,atoms,adjacency,fibres⟩

def equivalentPair (carrierLabel : String) (first second : ExactMolecularEncoding) : Except String ExactEquivalentRepresentationPair := do
 let carrier ← heldLabel "molecular-carrier" carrierLabel
 validPair ⟨carrier,first,second⟩

def appendSharedSuccessor (pair : ExactEquivalentRepresentationPair) (label : String) : Except String ExactEquivalentRepresentationPair := do
 let fresh ← atom label
 if pair.first.atoms.any (ElectronCountSpin.sameLabel fresh) then throw "representation successor atom must be fresh"
 let firstLast ← ConjugatedSupport.lastFibre pair.first.atoms
 let secondLast ← ConjugatedSupport.lastFibre pair.second.atoms
 let firstFibre ← ConjugatedSupport.lastFibre pair.first.fibres
 let firstNext ← fibre (if Text.equal firstFibre.label "fold-fibre-one" then "fold-fibre-two" else "fold-fibre-one")
 let secondFibre ← ConjugatedSupport.lastFibre pair.second.fibres
 let secondNext ← fibre (if Text.equal secondFibre.label "fold-fibre-one" then "fold-fibre-two" else "fold-fibre-one")
 let first ← validEncoding ⟨pair.first.encoding,pair.carrier,pair.first.atoms++[fresh],pair.first.adjacency++[(firstLast,fresh)],pair.first.fibres++[firstNext]⟩
 let second ← validEncoding ⟨pair.second.encoding,pair.carrier,pair.second.atoms++[fresh],pair.second.adjacency++[(secondLast,fresh)],pair.second.fibres++[secondNext]⟩
 validPair ⟨pair.carrier,first,second⟩

#print axioms atom
#print axioms fibre
#print axioms sameLabels
#print axioms sameEdge
#print axioms sameEdges
#print axioms distinctEdges
#print axioms validEncoding
#print axioms complementLabels
#print axioms validPair
#print axioms representationCount
#print axioms positiveIndex
#print axioms encoding
#print axioms equivalentPair
#print axioms appendSharedSuccessor
end SFT.Chemistry.ResonanceEquivalent
