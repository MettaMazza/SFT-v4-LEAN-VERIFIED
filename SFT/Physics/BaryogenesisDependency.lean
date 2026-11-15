import SFT.Physics.LandauerDemonLedger
import SFT.Foundation.FoldControls
namespace SFT.Physics.BaryogenesisDependency
open LeptonIntervals
open SFT.Mathematics.LimitComputations (equalRat)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def one : Rat := normalize 1 1 (by decide)
inductive ResidueRecord where
 | emptyOne
 | residue (orientation : String) (support : Rat)
def processCarriers (tally conjugacy hold : Bool) : List Rat × List Rat :=
 let matter := [one]
 let antimatter := [one]
 let matter := if tally then matter++[one] else matter
 let antimatter := if tally && !conjugacy then antimatter++[one] else antimatter
 if hold then (matter,antimatter) else (matter.take 1,antimatter.take 1)
def support (xs : List Rat) : Rat := subtract (xs.foldl add one) one
def retainedBaryonResidue (tally conjugacy hold : Bool) : ResidueRecord :=
 let carriers := processCarriers tally conjugacy hold
 let matter := support carriers.1
 let antimatter := support carriers.2
 if equalRat matter antimatter then .emptyOne
 else if antimatter.blt matter then .residue "matter" (subtract matter antimatter)
 else .residue "antimatter" (subtract antimatter matter)
def isPositiveResidue : ResidueRecord → Bool
 | .emptyOne => false
 | .residue _ _ => true
structure ConditionRow where
 baryonTallyChanges : Bool
 conjugatePathsDistinguished : Bool
 reverseCompletionHeld : Bool
 residue : ResidueRecord
 positiveResidue : Bool
def conditionRow (tally conjugacy hold : Bool) : ConditionRow :=
 let residue := retainedBaryonResidue tally conjugacy hold
 ⟨tally,conjugacy,hold,residue,isPositiveResidue residue⟩
def completeConditionCensus : List ConditionRow :=
 [false,true].flatMap (fun tally => [false,true].flatMap (fun conjugacy => [false,true].map (conditionRow tally conjugacy)))
def positiveRows : List ConditionRow := completeConditionCensus.filter ConditionRow.positiveResidue
def checkResidue : ResidueRecord → Bool
 | .emptyOne => false
 | .residue orientation q => SFT.Host.Text.equal orientation "matter" && equalRat q one
def checkPositiveRows : List ConditionRow → Bool
 | [] => false
 | [row] => row.baryonTallyChanges && row.conjugatePathsDistinguished && row.reverseCompletionHeld && checkResidue row.residue
 | _::_::_ => false
def uniquePositiveProcess : Bool := checkPositiveRows positiveRows
theorem originalInitialPair (conjugacy hold : Bool) : processCarriers false conjugacy hold=([one],[one]) := by
 cases conjugacy <;> cases hold <;> rfl
theorem originalPairedAppend : processCarriers true false true=([one,one],[one,one]) := rfl
theorem originalHeldAppend : processCarriers true true true=([one,one],[one]) := rfl
theorem originalReverseCloses (tally conjugacy : Bool) : processCarriers tally conjugacy false=([one],[one]) := by
 cases tally <;> cases conjugacy <;> rfl
theorem originalResidueFormula (tally conjugacy hold : Bool) :
 retainedBaryonResidue tally conjugacy hold=
 (if tally && conjugacy && hold then .residue "matter" one else .emptyOne) := by
 cases tally <;> cases conjugacy <;> cases hold <;> rfl
theorem originalPositiveIffTriple (tally conjugacy hold : Bool) :
 isPositiveResidue (retainedBaryonResidue tally conjugacy hold)=true ↔
 tally=true ∧ conjugacy=true ∧ hold=true := by
 cases tally <;> cases conjugacy <;> cases hold
 all_goals constructor <;> intro h
 all_goals first | exact ⟨rfl,rfl,rfl⟩ | rfl | exact False.elim (Bool.noConfusion h) | exact False.elim (Bool.noConfusion h.1) | exact False.elim (Bool.noConfusion h.2.1) | exact False.elim (Bool.noConfusion h.2.2)
theorem originalEightRows : completeConditionCensus.length=8 := rfl
theorem originalUniquePositiveRow : positiveRows=[conditionRow true true true] := rfl
theorem originalUniqueProcess : uniquePositiveProcess=true := rfl
def conditionKeys : List (Bool × Bool × Bool) := completeConditionCensus.map
 (fun r => (r.baryonTallyChanges,r.conjugatePathsDistinguished,r.reverseCompletionHeld))
theorem originalEveryCondition (tally conjugacy hold : Bool) :
 (tally,conjugacy,hold) ∈ conditionKeys := by
 cases tally <;> cases conjugacy <;> cases hold
 all_goals repeat first | exact List.mem_cons_self | apply List.mem_cons_of_mem
theorem originalConditionsDistinct : conditionKeys.Pairwise (fun a b => a≠b) := by decide
end SFT.Physics.BaryogenesisDependency
