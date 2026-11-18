import SFT.Chemistry.DihedralTorsion
namespace SFT.Chemistry.MolecularElectronAffinity
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues DihedralTorsion
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Difference where
 orientation : HeldLabel
 magnitude : Height
def boundOrientation : HeldLabel := ⟨"electron-affinity-state-order","anion-below-neutral-bound-attachment",rfl,rfl⟩
def unboundOrientation : HeldLabel := ⟨"electron-affinity-state-order","anion-above-neutral-unbound-autodetachment",rfl,rfl⟩
def coincidentOrientation : HeldLabel := ⟨"electron-affinity-state-order","coincident-no-affinity-distinction",rfl,rfl⟩
def validateDifference (d : Difference) : Except String Difference :=
 if !Text.equal d.orientation.family "electron-affinity-state-order" then
  .error "electron affinity requires held state order and an exact Fold magnitude"
 else match d.magnitude with
  | .ratio _ | .emptyOne | .otherEmptyOne _ => .ok d
  | .invalid => .error "electron affinity requires held state order and an exact Fold magnitude"
def differenceFromRatios (neutral anion : Ratio) : Difference :=
 let n := fraction neutral
 let a := fraction anion
 if same : n.numerator*a.denominator=a.numerator*n.denominator then
  ⟨coincidentOrientation,.emptyOne⟩
 else if below : a.numerator*n.denominator<n.numerator*a.denominator then
  ⟨boundOrientation,.ratio (rawRatio (LeptonTake.heldRemainder n a below))⟩
 else
  have above : n.numerator*a.denominator<a.numerator*n.denominator :=
   Nat.lt_of_le_of_ne (Nat.le_of_not_gt below) same
  ⟨unboundOrientation,.ratio (rawRatio (LeptonTake.heldRemainder a n above))⟩
def exactElectronAffinityDifference (neutral anion : Height) : Except String Difference :=
 match neutral with
 | .emptyOne | .otherEmptyOne _ | .invalid => .error "electron-affinity state heights must be exact positive ratios"
 | .ratio n => match anion with
  | .emptyOne | .otherEmptyOne _ | .invalid => .error "electron-affinity state heights must be exact positive ratios"
  | .ratio a => .ok (differenceFromRatios n a)
structure Carrier where
 species : HeldLabel
 initialState : HeldLabel
 resultingAnion : HeldLabel
 gainedCarrier : HeldLabel
 gainOrientation : HeldLabel
 gainPath : HeldLabel
 condition : HeldLabel
def validateCarrier (c : Carrier) : Except String Carrier := do
 if !([(c.species,"molecular-species"),(c.initialState,"initial-molecular-state"),
  (c.resultingAnion,"resulting-anion-state"),(c.gainedCarrier,"gained-carrier"),
  (c.gainOrientation,"held-gain-orientation"),(c.gainPath,"electron-gain-path"),
  (c.condition,"measurement-condition")].all fun (value,family) => Text.equal value.family family) then
  throw "molecular electron-affinity carrier erased a required held field"
 pure c
theorem coincidentCase (neutral anion : Ratio)
 (same : (fraction neutral).numerator*(fraction anion).denominator =
   (fraction anion).numerator*(fraction neutral).denominator) :
 differenceFromRatios neutral anion=⟨coincidentOrientation,.emptyOne⟩ := by
 unfold differenceFromRatios
 rw [dite_eq_left same]
theorem boundCase (neutral anion : Ratio)
 (below : (fraction anion).numerator*(fraction neutral).denominator <
   (fraction neutral).numerator*(fraction anion).denominator) :
 differenceFromRatios neutral anion=
 ⟨boundOrientation,.ratio (rawRatio (LeptonTake.heldRemainder (fraction neutral) (fraction anion) below))⟩ := by
 unfold differenceFromRatios
 rw [dite_eq_right (Nat.ne_of_gt below),dite_eq_left below]
theorem unboundCase (neutral anion : Ratio)
 (above : (fraction neutral).numerator*(fraction anion).denominator <
   (fraction anion).numerator*(fraction neutral).denominator) :
 differenceFromRatios neutral anion=
 ⟨unboundOrientation,.ratio (rawRatio (LeptonTake.heldRemainder (fraction anion) (fraction neutral) above))⟩ := by
 unfold differenceFromRatios
 rw [dite_eq_right (Nat.ne_of_lt above),dite_eq_right (Nat.not_lt_of_ge (Nat.le_of_lt above))]
theorem stateOrderComplete (neutral anion : Ratio) :
 (fraction neutral).numerator*(fraction anion).denominator < (fraction anion).numerator*(fraction neutral).denominator ∨
 (fraction neutral).numerator*(fraction anion).denominator = (fraction anion).numerator*(fraction neutral).denominator ∨
 (fraction anion).numerator*(fraction neutral).denominator < (fraction neutral).numerator*(fraction anion).denominator :=
 Nat.lt_trichotomy _ _
theorem positiveMagnitude (higher lower : Ratio)
 (ordered : (fraction lower).numerator*(fraction higher).denominator <
  (fraction higher).numerator*(fraction lower).denominator) :
 ((fraction higher).numerator*(fraction lower).denominator-(fraction lower).numerator*(fraction higher).denominator)*
 (LeptonTake.heldRemainder (fraction higher) (fraction lower) ordered).denominator=
 (LeptonTake.heldRemainder (fraction higher) (fraction lower) ordered).numerator*
 ((fraction higher).denominator*(fraction lower).denominator) := barrierMagnitude higher lower ordered

def higher : Ratio := ⟨⟨8,by decide⟩,⟨1,by decide⟩⟩
def lower : Ratio := ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩
def resultPair (d : Difference) : String × Option (Nat × Nat) :=
 let magnitude := match d.magnitude with
  | .ratio r => some (r.numerator.value,r.denominator.value)
  | .emptyOne | .otherEmptyOne _ | .invalid => none
 (d.orientation.label,magnitude)
theorem boundWitness : resultPair (differenceFromRatios higher lower)=("anion-below-neutral-bound-attachment",some (5,1)) := rfl
theorem unboundWitness : resultPair (differenceFromRatios lower higher)=("anion-above-neutral-unbound-autodetachment",some (5,1)) := rfl
theorem coincidentWitness : resultPair (differenceFromRatios lower lower)=("coincident-no-affinity-distinction",none) := rfl
theorem oneLawWitness : (resultPair (differenceFromRatios higher lower)).2=(resultPair (differenceFromRatios lower higher)).2 := rfl
end SFT.Chemistry.MolecularElectronAffinity
