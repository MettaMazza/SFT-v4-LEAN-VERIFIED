import SFT.Chemistry.InorganicMagneticState
namespace SFT.Chemistry.InorganicMagneticStateDerivation
open SFT.Physics.CapabilityValues InorganicMagneticState
open ComplexSpinState (number exactCount)
theorem completeSupportCount (s : Support) : number (unpairedCount s)=s.occurrences.length :=
 ComplexSpinStateDerivation.exactCountNumber _
theorem completeSupportWidth (s : Support) : (spinWidth s).value=s.occurrences.length+1 :=
 congrArg (fun n => n+1) (completeSupportCount s)
theorem supportRetains (identity : HeldLabel) (occurrences fibres : List HeldLabel) (result : Support)
 (accepted : support identity occurrences fibres=.ok result) : result=⟨identity,occurrences,fibres⟩ := by
 unfold support at accepted
 split at accepted
 · cases accepted
 · split at accepted
   · cases accepted
   · split at accepted
     · cases accepted
     · split at accepted
       · cases accepted
       · split at accepted
         · cases accepted
         · cases accepted; rfl
theorem appendedRetains (s result : Support) (accepted : appendSuccessor s=.ok result) :
 result.complexIdentity=s.complexIdentity ∧
 ∃ e f, result.occurrences=s.occurrences++[e] ∧ result.fibres=s.fibres++[f] := by
 unfold appendSuccessor at accepted
 dsimp only at accepted
 cases he : occurrence (s.occurrences.length+1) with
 | error e => rw [he] at accepted; cases accepted
 | ok e =>
  rw [he] at accepted
  cases hf : fibre (s.occurrences.length+1) with
  | error f => rw [hf] at accepted; cases accepted
  | ok f =>
   rw [hf] at accepted
   have kept := supportRetains s.complexIdentity (s.occurrences++[e]) (s.fibres++[f]) result accepted
   cases kept
   exact ⟨rfl,e,f,rfl,rfl⟩
theorem appendedCount (s result : Support) (accepted : appendSuccessor s=.ok result) :
 number (unpairedCount result)=number (unpairedCount s)+1 := by
 have kept := appendedRetains s result accepted
 rcases kept.2 with ⟨e,f,he,hf⟩
 rw [completeSupportCount,completeSupportCount,he,SFT.Foundation.CommonRefinement.appendLength]
 rfl
theorem appendedWidth (s result : Support) (accepted : appendSuccessor s=.ok result) :
 (spinWidth result).value=(spinWidth s).value+1 :=
 congrArg (fun n => n+1) (appendedCount s result accepted)
theorem appendedPositive (s result : Support) (accepted : appendSuccessor s=.ok result) :
 0<number (unpairedCount result) := by
 rw [appendedCount s result accepted]
 exact Nat.zero_lt_succ _
theorem positiveClass (s : Support) (positive : 0<number (unpairedCount s)) :
 relationName s="drawn-into-field" ∧ className s="paramagnetic" := by
 unfold relationName className
 cases h : unpairedCount s with
 | empty identity => rw [h] at positive; cases positive
 | positive n => exact ⟨rfl,rfl⟩
theorem appendedClass (s result : Support) (accepted : appendSuccessor s=.ok result) :
 relationName result="drawn-into-field" ∧ className result="paramagnetic" :=
 positiveClass result (appendedPositive s result accepted)
def firstPositive : Except String MagneticState := do forced (← complete "first" (.positive ⟨1,by decide⟩))
def firstWitness : Bool := match firstPositive with
 | .error _ => false
 | .ok m => number m.momentSupport==1 && m.spinWidth.value==2 &&
  SFT.Host.Text.equal m.fieldRelation.label "drawn-into-field" && SFT.Host.Text.equal m.magneticClass.label "paramagnetic"
theorem firstPassed : firstWitness=true := by decide
end SFT.Chemistry.InorganicMagneticStateDerivation
