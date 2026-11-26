import SFT.Chemistry.InorganicColourDerivation
import SFT.Chemistry.ComplexSpinStateDerivation
namespace SFT.Chemistry.InorganicMagneticState
open SFT.Host SFT.Physics.CapabilityValues
open InorganicColour (distinctLabels)
open ComplexSpinState (ExactCount number exactCount sameCount)
structure Support where
 complexIdentity : HeldLabel
 occurrences : List HeldLabel
 fibres : List HeldLabel
def support (identity : HeldLabel) (occurrences fibres : List HeldLabel) : Except String Support :=
 if !Text.equal identity.family "coordination-entity" then
  .error "magnetic state requires one retained coordination entity"
 else if occurrences.length != fibres.length then
  .error "every unpaired occurrence requires one held spin fibre"
 else if !distinctLabels occurrences then
  .error "unpaired electron support cannot duplicate an occurrence"
 else if occurrences.any (fun x => !Text.equal x.family "electron-occurrence") then
  .error "unpaired support contains an invalid electron occurrence"
 else if fibres.any (fun x => !Text.equal x.family "electron-spin" || !(Text.equal x.label "fibre-a" || Text.equal x.label "fibre-b")) then
  .error "unpaired support must retain one of the two forced spin fibres"
 else .ok ⟨identity,occurrences,fibres⟩
def unpairedCount (s : Support) : ExactCount := exactCount s.occurrences.length
def spinWidth (s : Support) : PositiveCount := ⟨number (unpairedCount s)+1,Nat.zero_lt_succ _⟩
structure MagneticState where
 support : Support
 momentSupport : ExactCount
 spinWidth : PositiveCount
 fieldRelation : HeldLabel
 magneticClass : HeldLabel
def isEmpty : ExactCount → Bool
 | .empty _ => true
 | .positive _ => false
def magneticState (s : Support) (moment : ExactCount) (width : PositiveCount) (relation classLabel : HeldLabel) : Except String MagneticState := do
 if !sameCount moment (unpairedCount s) || width.value != (spinWidth s).value then
  throw "magnetic state must preserve complete unpaired support exactly"
 if !Text.equal relation.family "held-field-relation" || !(Text.equal relation.label "drawn-into-field" || Text.equal relation.label "repelled-from-field") then
  throw "field response is a held direction, not a signed scalar"
 if !Text.equal classLabel.family "inorganic-magnetic-class" || !(Text.equal classLabel.label "paramagnetic" || Text.equal classLabel.label "diamagnetic") then
  throw "magnetic class is outside the forced pair"
 if isEmpty moment then
  if !Text.equal classLabel.label "diamagnetic" || !Text.equal relation.label "repelled-from-field" then
   throw "balanced paired support forces the diamagnetic class"
 else
  if !Text.equal classLabel.label "paramagnetic" || !Text.equal relation.label "drawn-into-field" then
   throw "positive unpaired support forces the paramagnetic class"
 return ⟨s,moment,width,relation,classLabel⟩
def relationName (s : Support) : String := if isEmpty (unpairedCount s) then "repelled-from-field" else "drawn-into-field"
def className (s : Support) : String := if isEmpty (unpairedCount s) then "diamagnetic" else "paramagnetic"
def forced (s : Support) : Except String MagneticState := do
 magneticState s (unpairedCount s) (spinWidth s)
  (← heldLabel "held-field-relation" (relationName s))
  (← heldLabel "inorganic-magnetic-class" (className s))
def occurrence (index : Nat) : Except String HeldLabel := heldLabel "electron-occurrence" (Text.append "unpaired-" (toString index))
def fibre (index : Nat) : Except String HeldLabel := heldLabel "electron-spin" (if index%2 != 0 then "fibre-a" else "fibre-b")
def complete (label : String) (n : ExactCount) : Except String Support := do
 let indices := (List.range (number n)).map (fun i => i+1)
 support (← heldLabel "coordination-entity" label) (← indices.mapM occurrence) (← indices.mapM fibre)
def appendSuccessor (s : Support) : Except String Support := do
 let next := s.occurrences.length+1
 support s.complexIdentity (s.occurrences++[← occurrence next]) (s.fibres++[← fibre next])
def balanced : Except String MagneticState := do forced (← complete "balanced" (.empty "empty-One"))
def high : Except String MagneticState := do forced (← complete "high" (.positive ⟨4,by decide⟩))
def successor : Except String MagneticState := do
 let h ← high
 forced (← appendSuccessor h.support)
def balancedWitness : Bool := match balanced with
 | .error _ => false
 | .ok s => isEmpty s.momentSupport && s.spinWidth.value==1 && Text.equal s.magneticClass.label "diamagnetic"
def positiveWitness : Bool := match high with
 | .error _ => false
 | .ok s => number s.momentSupport==4 && s.spinWidth.value==5 && Text.equal s.magneticClass.label "paramagnetic"
def successorWitness : Bool := match successor with
 | .error _ => false
 | .ok s => number s.momentSupport==5 && s.spinWidth.value==6 && Text.equal s.magneticClass.label "paramagnetic"
def duplicateControl : Except String Support := do
 let e ← heldLabel "electron-occurrence" "same"
 support (← heldLabel "coordination-entity" "bad") [e,e]
  [← heldLabel "electron-spin" "fibre-a",← heldLabel "electron-spin" "fibre-b"]
def duplicateWitness : Bool := match duplicateControl with
 | .error _ => true | .ok _ => false
theorem balancedPassed : balancedWitness=true := by decide
theorem positivePassed : positiveWitness=true := by decide
theorem successorPassed : successorWitness=true := by decide
theorem duplicatePassed : duplicateWitness=true := by decide
end SFT.Chemistry.InorganicMagneticState
