import SFT.Chemistry.AromaticRecurrence
namespace SFT.Chemistry.AntiaromaticDistinction
open SFT.Host SFT.Physics.CapabilityValues
open MulticentreSupport (sameLabel sameWord)
open AromaticRecurrence (Cell completeCells sameLayer)
inductive RecurrenceSupport where
 | emptyOne : String → RecurrenceSupport
 | positive : PositiveCount → RecurrenceSupport
structure Alternative where
 carrier : HeldLabel
 cycle : MulticentreSupport.Support
 geometry : HeldLabel
 supportState : HeldLabel
 recurrenceClass : HeldLabel
 recurrenceSupport : RecurrenceSupport
 layers : List (List Cell)
structure StabilityOrder where
 aromatic : Alternative
 nonaromatic : Alternative
 antiaromatic : Alternative
 firstTransfer : PositiveCount
 secondTransfer : PositiveCount

def completePlane : HeldLabel := ⟨"cycle-geometry-state","complete-common-plane",rfl,rfl⟩
def brokenPlane : HeldLabel := ⟨"cycle-geometry-state","out-of-plane-break",rfl,rfl⟩
def completeConjugation : HeldLabel := ⟨"cycle-support-state","complete-conjugated-support",rfl,rfl⟩
def brokenConjugation : HeldLabel := ⟨"cycle-support-state","broken-conjugated-support",rfl,rfl⟩
def aromatic : HeldLabel := ⟨"same-cycle-class","closed-aromatic-recurrence",rfl,rfl⟩
def antiaromatic : HeldLabel := ⟨"same-cycle-class","frustrated-antiaromatic-recurrence",rfl,rfl⟩
def nonaromatic : HeldLabel := ⟨"same-cycle-class","broken-nonaromatic-recurrence",rfl,rfl⟩
def hasCount (s : RecurrenceSupport) (n : Nat) : Bool := match s with
 | .emptyOne _ => false | .positive p => p.value==n
def isEmptyOne (s : RecurrenceSupport) : Bool := match s with
 | .emptyOne identity => Text.equal identity "empty-One" | .positive _ => false

def alternative (carrier : HeldLabel) (cycle : MulticentreSupport.Support)
 (geometry supportState recurrenceClass : HeldLabel) (recurrenceSupport : RecurrenceSupport)
 (layers : List (List Cell)) : Except String Alternative :=
 if !Text.equal carrier.family "molecular-carrier" || !sameLabel cycle.molecularCarrier carrier then
  .error "same-cycle classification requires one retained molecular carrier"
 else if !(sameLabel geometry completePlane || sameLabel geometry brokenPlane) then
  .error "same-cycle geometry state is invalid"
 else if !(sameLabel supportState completeConjugation || sameLabel supportState brokenConjugation) then
  .error "same-cycle conjugation state is invalid"
 else if !(layers.all (fun layer => sameLayer layer completeCells)) then
  .error "every retained recurrence layer must contain all four ordered pair cells"
 else if sameLabel recurrenceClass aromatic then
  if !sameLabel geometry completePlane || !sameLabel supportState completeConjugation || layers.isEmpty || !hasCount recurrenceSupport (2+4*layers.length) then
   .error "aromatic class requires complete planar recurrence and its two-fibre return"
  else .ok ⟨carrier,cycle,geometry,supportState,recurrenceClass,recurrenceSupport,layers⟩
 else if sameLabel recurrenceClass antiaromatic then
  if !sameLabel geometry completePlane || !sameLabel supportState completeConjugation || layers.isEmpty || !hasCount recurrenceSupport (4*layers.length) then
   .error "antiaromatic class requires complete planar support with frustrated return"
  else .ok ⟨carrier,cycle,geometry,supportState,recurrenceClass,recurrenceSupport,layers⟩
 else if sameLabel recurrenceClass nonaromatic then
  if (sameLabel geometry completePlane && sameLabel supportState completeConjugation) || !isEmptyOne recurrenceSupport || !layers.isEmpty then
   .error "nonaromatic class requires a broken planar or conjugated recurrence and structural EmptyOne"
  else .ok ⟨carrier,cycle,geometry,supportState,recurrenceClass,recurrenceSupport,layers⟩
 else .error "same-cycle recurrence class is invalid"

def sameEdges : List MulticentreSupport.Edge → List MulticentreSupport.Edge → Bool
 | [],[] => true
 | a::as,b::bs => sameLabel a.left b.left && sameLabel a.right b.right && sameEdges as bs
 | [],_::_ | _::_,[] => false
def sameCycle (a b : MulticentreSupport.Support) : Bool :=
 sameLabel a.molecularCarrier b.molecularCarrier && sameLabel a.topology b.topology &&
 sameWord a.centres b.centres && sameEdges a.edges b.edges && sameWord a.electronSupport b.electronSupport

def stabilityOrder (a n f : Alternative) (first second : PositiveCount) : Except String StabilityOrder :=
 if !(sameCycle a.cycle n.cycle && sameCycle a.cycle f.cycle) then
  .error "stability comparison requires the exact same molecular cycle"
 else if !sameLabel a.recurrenceClass aromatic || !sameLabel n.recurrenceClass nonaromatic || !sameLabel f.recurrenceClass antiaromatic then
  .error "same-cycle stability order has a changed class identity"
 else if first.value != 1 || second.value != 1 then
  .error "each adjacent same-cycle order step requires one positive distinction transfer"
 else .ok ⟨a,n,f,first,second⟩
def exactOrder (_order : StabilityOrder) : List HeldLabel := [aromatic,nonaromatic,antiaromatic]
def aromaticAlternative (r : AromaticRecurrence.Recurrence) : Except String Alternative := do
 let support ← AromaticRecurrence.positiveSupportCount r
 alternative r.carrier r.cycle completePlane completeConjugation aromatic (.positive support) r.layers
def antiaromaticAlternative (cycle : MulticentreSupport.Support) (n : PositiveCount) : Except String Alternative := do
 let support ← count (4*n.value)
 alternative cycle.molecularCarrier cycle completePlane completeConjugation antiaromatic (.positive support) (List.replicate n.value completeCells)
def nonaromaticAlternative (cycle : MulticentreSupport.Support) (breakPlane breakConjugation : Bool) : Except String Alternative :=
 if !breakPlane && !breakConjugation then .error "nonaromatic alternative must retain an exact structural break"
 else alternative cycle.molecularCarrier cycle
  (if breakPlane then brokenPlane else completePlane) (if breakConjugation then brokenConjugation else completeConjugation)
  nonaromatic (.emptyOne "empty-One") []
def census (label : String) (centres : List String) : Except String (List Alternative) := do
 let r ← AromaticRecurrence.aromaticRecurrence label centres ⟨1,by decide⟩
 let a ← aromaticAlternative r
 let n ← nonaromaticAlternative r.cycle true false
 let f ← antiaromaticAlternative r.cycle ⟨1,by decide⟩
 return [a,n,f]
def censusOrder (rows : List Alternative) : Except String StabilityOrder :=
 match rows with
 | [a,n,f] => stabilityOrder a n f ⟨1,by decide⟩ ⟨1,by decide⟩
 | [] | [_] | [_,_] | _::_::_::_::_ => .error "same-cycle census requires exactly three forced alternatives"
def appendLayer (a : Alternative) : Except String Alternative := do
 if sameLabel a.recurrenceClass aromatic then
  let n ← count a.layers.length
  let r ← AromaticRecurrence.aromaticRecurrence a.carrier.label (a.cycle.centres.map HeldLabel.label) n
  aromaticAlternative (← AromaticRecurrence.appendLayer r)
 else if sameLabel a.recurrenceClass antiaromatic then
  antiaromaticAlternative a.cycle (← count (a.layers.length+1))
 else return a
end SFT.Chemistry.AntiaromaticDistinction
