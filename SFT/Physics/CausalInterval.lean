import SFT.Physics.GravityFlux
import SFT.Physics.TwoHandDirac
namespace SFT.Physics.CausalInterval
open SFT.Foundation.ExactPartCarrier LeptonIntervals
structure Result where
 intervalSquare : Option Rat
 causalClass : String

def exactInterval (temporal spatial : Rat) : Except String Result := do
 if !(zero.blt spatial && !temporal.blt spatial) then
  throw "interval requires a causal exact spatial carrier"
 let remainder ← GravityFlux.positiveTake (.fraction (multiply temporal temporal)) (.fraction (multiply spatial spatial))
 match remainder with
 | none => pure ⟨none,"boundary-massless"⟩
 | some value => pure ⟨some value,"interior-massive"⟩

structure WitnessResult where
 intervalSquare : Option Rat
 causalClass : String
 properTime : Rat

def intervalWitness : Except String WitnessResult := do
 let interval ← exactInterval ⟨1,1,by decide,by decide⟩ ⟨3,5,by decide,by decide⟩
 let proper : Rat := ⟨4,5,by decide,by decide⟩
 match interval.intervalSquare with
 | none => .error "generated causal triple did not close"
 | some value =>
  let square := multiply proper proper
  if !value.blt square && !square.blt value then pure ⟨some value,interval.causalClass,proper⟩
  else throw "generated causal triple did not close"

theorem originalMassiveRecord : intervalWitness=.ok ⟨some ⟨16,25,by decide,by decide⟩,"interior-massive",⟨4,5,by decide,by decide⟩⟩ := rfl

theorem originalBoundary : exactInterval ⟨1,1,by decide,by decide⟩ ⟨1,1,by decide,by decide⟩=
 .ok ⟨none,"boundary-massless"⟩ := rfl

theorem originalPartition : add (multiply (⟨3,5,by decide,by decide⟩ : Rat) ⟨3,5,by decide,by decide⟩)
 (multiply (⟨4,5,by decide,by decide⟩ : Rat) ⟨4,5,by decide,by decide⟩)=⟨1,1,by decide,by decide⟩ := rfl

theorem everyReturnedTake (temporal spatial : Rat) (record : Result)
 (returned : exactInterval temporal spatial=.ok record) :
 GravityFlux.positiveTake (.fraction (multiply temporal temporal)) (.fraction (multiply spatial spatial))=.ok record.intervalSquare := by
 unfold exactInterval at returned
 split at returned
 · cases returned
 · generalize ht : GravityFlux.positiveTake (.fraction (multiply temporal temporal)) (.fraction (multiply spatial spatial))=taken at returned ⊢
   cases taken with
   | error message => cases returned
   | ok value =>
    cases value with
    | none => cases returned;rfl
    | some value => cases returned;rfl

theorem everyReturnedClass (temporal spatial : Rat) (record : Result)
 (returned : exactInterval temporal spatial=.ok record) :
 (record.intervalSquare=none ∧ record.causalClass="boundary-massless") ∨
 (∃ value,record.intervalSquare=some value ∧ record.causalClass="interior-massive") := by
 unfold exactInterval at returned
 split at returned
 · cases returned
 · generalize GravityFlux.positiveTake (.fraction (multiply temporal temporal)) (.fraction (multiply spatial spatial))=taken at returned
   cases taken with
   | error message => cases returned
   | ok value =>
    cases value with
    | none => cases returned;exact Or.inl ⟨rfl,rfl⟩
    | some value => cases returned;exact Or.inr ⟨value,rfl,rfl⟩
end SFT.Physics.CausalInterval
