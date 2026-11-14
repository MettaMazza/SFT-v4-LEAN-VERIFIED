import SFT.Physics.GravitySelfSource
namespace SFT.Physics.GravitonPolarization
open SFT.Foundation ExactCast ExactPartCarrier FractionReduction
open GeneratorOperations
structure Result where
 symmetricComponents : Nat
 gaugeComponents : Nat
 physicalPolarizations : Option Nat

def gravitonPolarizations : CountInput → Except String Result
 | .boolean _ => .error "metric count requires at least planar spacetime count"
 | .integer (.negSucc _) => .error "metric count requires at least planar spacetime count"
 | .integer (.ofNat dimension) => do
  if dimension<3 then throw "metric count requires at least planar spacetime count"
  let binary ← AlphaCovers.binaryCount
  let symmetric := dimension*(dimension+1)/binary
  let gauge := binary*dimension
  if symmetric==gauge then pure ⟨symmetric,gauge,none⟩
  else if gauge<symmetric then pure ⟨symmetric,gauge,some (symmetric-gauge)⟩
  else throw "gauge count exceeds symmetric support"

theorem originalFour : gravitonPolarizations (.integer 4)=.ok ⟨10,8,some 2⟩ := by
 unfold gravitonPolarizations
 rw [AlphaCovers.binaryCountTwo]
 rfl

theorem originalPlanar : gravitonPolarizations (.integer 3)=.ok ⟨6,6,none⟩ := by
 unfold gravitonPolarizations
 rw [AlphaCovers.binaryCountTwo]
 rfl

theorem fourthDimensionIncrement : 10-6=4 ∧ 8-6=2 ∧ 4-2=2 := ⟨rfl,rfl,rfl⟩

theorem everyReturnedPartition (input : CountInput) (record : Result)
 (returned : gravitonPolarizations input=.ok record) :
 record.symmetricComponents=record.gaugeComponents+record.physicalPolarizations.getD 0 := by
 cases input with
 | boolean b => cases returned
 | integer z =>
  cases z with
  | negSucc n => cases returned
  | ofNat d =>
   unfold gravitonPolarizations at returned
   dsimp only at returned
   split at returned
   · cases returned
   · rw [AlphaCovers.binaryCountTwo] at returned
     dsimp only [Except.bind,Bind.bind] at returned
     split at returned
     · rename_i same
       cases returned
       have eq : d*(d+1)/2=2*d := of_decide_eq_true (show decide (d*(d+1)/2=2*d)=true from same)
       change d*(d+1)/2=2*d+0
       rw [Nat.add_zero]
       exact eq
     · split at returned
       · rename_i less
         cases returned
         change d*(d+1)/2=2*d+(d*(d+1)/2-2*d)
         exact (subtractAdd _ _ (Nat.le_of_lt less)).symm.trans (Nat.add_comm _ _)
       · cases returned
end SFT.Physics.GravitonPolarization
