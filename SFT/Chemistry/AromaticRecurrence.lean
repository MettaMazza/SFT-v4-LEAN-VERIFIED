import SFT.Chemistry.MulticentreSupport
import SFT.Chemistry.InorganicNetwork
namespace SFT.Chemistry.AromaticRecurrence
open SFT.Host SFT.Physics.CapabilityValues
open MulticentreSupport (sameLabel)
abbrev Cell := HeldLabel × HeldLabel
structure Recurrence where
 carrier : HeldLabel
 cycle : MulticentreSupport.Support
 boundary : List HeldLabel
 layers : List (List Cell)
structure Stability where
 recurrence : Recurrence
 closed : HeldLabel
 opened : HeldLabel
 transfer : PositiveCount

def fibreOne : HeldLabel := ⟨"aromatic-recurrence-fibre","fold-fibre-one",rfl,rfl⟩
def fibreTwo : HeldLabel := ⟨"aromatic-recurrence-fibre","fold-fibre-two",rfl,rfl⟩
def completeCells : List Cell := [(fibreOne,fibreOne),(fibreOne,fibreTwo),(fibreTwo,fibreOne),(fibreTwo,fibreTwo)]
def sameCell (a b : Cell) : Bool := sameLabel a.1 b.1 && sameLabel a.2 b.2
def sameLayer : List Cell → List Cell → Bool
 | [],[] => true
 | a::as,b::bs => sameCell a b && sameLayer as bs
 | [],_::_ | _::_,[] => false
def sameCellSet (xs ys : List Cell) : Bool :=
 xs.all (fun x => ys.any (sameCell x)) && ys.all (fun y => xs.any (sameCell y))

def recurrence (carrier : HeldLabel) (cycle : MulticentreSupport.Support) (boundary : List HeldLabel) (layers : List (List Cell)) : Except String Recurrence :=
 if !Text.equal carrier.family "molecular-carrier" then .error "aromatic recurrence requires one retained molecular carrier"
 else if !sameLabel cycle.molecularCarrier carrier || !sameLabel cycle.topology MulticentreSupport.surface then .error "aromatic recurrence requires one complete cycle on the same carrier"
 else if !InorganicNetwork.sameSet boundary [fibreOne,fibreTwo] then .error "aromatic recurrence requires both Fold boundary fibres exactly once"
 else if layers.isEmpty then .error "aromatic recurrence requires a positive generated cycle layer"
 else if !(layers.all (fun layer => sameLayer layer completeCells)) then .error "every recurrence layer must retain all four ordered Fold pair cells"
 else .ok ⟨carrier,cycle,boundary,layers⟩
def positiveLayerCount (r : Recurrence) := count r.layers.length
def supportSize (r : Recurrence) := r.boundary.length+(r.layers.map List.length).sum
def positiveSupportCount (r : Recurrence) := count (supportSize r)
def firstReturnTrace (r : Recurrence) : Except String (List HeldLabel) := do
 let first ← MulticentreSupport.indexNat r.cycle.centres 0
 return r.cycle.centres++[first]
def missingPairBoundary (_r : Recurrence) : Value := .emptyOne "empty-One"
def rotations : List (List Cell) := (List.range completeCells.length).map (fun i => completeCells.drop (i+1)++completeCells.take (i+1))
def perturbationClosure (_r : Recurrence) : Bool := rotations.all (fun rotation => sameCellSet rotation completeCells)

def stability (r : Recurrence) (closed opened : HeldLabel) (transfer : PositiveCount) : Except String Stability :=
 if !Text.equal closed.family "molecular-energy-state" || !Text.equal opened.family "molecular-energy-state" then .error "aromatic stability requires retained molecular energy-state identities"
 else if sameLabel closed opened then .error "closed recurrence and opened reference must remain distinct"
 else if transfer.value != 1 then .error "opening one primitive recurrence boundary requires exactly one retained transfer act"
 else .ok ⟨r,closed,opened,transfer⟩
def closedPrecedes (s : Stability) : Bool := s.transfer.value==1

def aromaticRecurrence (label : String) (centres : List String) (n : PositiveCount) : Except String Recurrence := do
 let cycle ← MulticentreSupport.surfaceSupport label centres
 recurrence cycle.molecularCarrier cycle [fibreOne,fibreTwo] (List.replicate n.value completeCells)
def appendLayer (r : Recurrence) := recurrence r.carrier r.cycle r.boundary (r.layers++[completeCells])
def aromaticStability (r : Recurrence) := stability r ⟨"molecular-energy-state","closed-recurrence",rfl,rfl⟩ ⟨"molecular-energy-state","opened-localized-reference",rfl,rfl⟩ ⟨1,by decide⟩
end SFT.Chemistry.AromaticRecurrence
