import SFT.Physics.StellarNuclearChannels
import SFT.Physics.StellarCertificate
namespace SFT.Physics.StellarNuclearClosure
open StellarNuclearStages StellarNuclearChannels SFT.Foundation.CommonRefinement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem originalFuelDomain (n : Nat) : thermonuclearRecurrence (.integer (.ofNat (n+1)))=.ok (fuelRows (n+1)) := rfl
theorem completeFuelTraceLength (fuel : Nat) : (fuelRows fuel).length=fuel+1 := by
 unfold fuelRows
 rw [appendLength,mapLength]
 exact congrArg (fun k=>k+1) ((VacuumSpectrum.rangeLoopLength fuel []).trans (Nat.add_zero fuel))
private theorem appendedTerminal (rows : List FuelRow) (terminal : FuelRow) : (rows++[terminal]).getLast?=some terminal := by
 induction rows with
 | nil=>rfl
 | cons r rows ih=>
  cases rows with
  | nil=>rfl
  | cons s rest=>exact ih
theorem originalFuelTerminal (fuel : Nat) : (fuelRows fuel).getLast?=some ⟨fuel+1,fuel,"finite-fuel-exhausted"⟩ := appendedTerminal _ _
private theorem activeBeforeTerminal (rows : List FuelRow) (terminal : FuelRow) : (rows++[terminal]).dropLast=rows := by
 induction rows with
 | nil=>rfl
 | cons r rows ih=>
  cases rows with
  | nil=>rfl
  | cons s rest=>exact congrArg (List.cons r) ih
theorem originalActiveFuelRows (fuel : Nat) : (fuelRows fuel).dropLast=(List.range fuel).map (fun i=>⟨i+1,i+1,"runaway-recurrence"⟩) := activeBeforeTerminal _ _
private theorem everyActiveState (indices : List Nat) :
 ((indices.map (fun i=>(⟨i+1,i+1,"runaway-recurrence"⟩ : FuelRow))).all (fun row=>SFT.Host.Text.equal row.state "runaway-recurrence"))=true := by
 induction indices with
 | nil=>rfl
 | cons i rest ih=>exact ih
theorem originalNoInteriorFixedPoint (fuel : Nat) :
 ((fuelRows fuel).dropLast.all (fun row=>SFT.Host.Text.equal row.state "runaway-recurrence"))=true := by
 rw [originalActiveFuelRows]
 exact everyActiveState _
theorem originalNeutralMassRetention (n : Nat) :
 (neutralCaptureTrace (.integer (.ofNat (n+1)))).map (fun c=>StellarCertificate.flag c "mass_support_retained")=.ok true := by
 change Except.ok (((List.range (n+1)).map (fun i=> (SFT.Host.Canonical.Value.object [("capture",.integer (.ofNat (i+1))),("incident_charge_path",.array [])]))).length == ((List.range (n+1)).map (fun i=> (SFT.Host.Canonical.Value.object [("retained_mass_step",.integer (.ofNat (i+1))),("label_rebalance",.text "radioactive-successor")]))).length && ((List.range (n+1)).map (fun i=> (SFT.Host.Canonical.Value.object [("retained_mass_step",.integer (.ofNat (i+1))),("label_rebalance",.text "radioactive-successor")]))).length == n+1) = Except.ok true
 rw [mapLength,mapLength]
 have len : (List.range (n+1)).length=n+1 := (VacuumSpectrum.rangeLoopLength (n+1) []).trans (Nat.add_zero _)
 rw [len]
 have same : ((n+1)==(n+1))=true := naturalEqualityReflexive _
 rw [same]
 rfl
#print axioms originalNeutralMassRetention
#print axioms originalFuelDomain
#print axioms completeFuelTraceLength
#print axioms originalFuelTerminal
#print axioms originalActiveFuelRows
#print axioms originalNoInteriorFixedPoint
end SFT.Physics.StellarNuclearClosure
