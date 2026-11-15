import SFT.Physics.SymmetryActionWitnesses
import SFT.Physics.SymmetryActionExampleCensus
namespace SFT.Physics.SymmetryActionEntryWitnesses
open SymmetryActionWitnesses
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def checked : Except String Bool → Bool | .ok x => x | .error _ => false
def oddCoreCheck : Bool := checked (allReducedFoldPartsPreserveOddCore (.integer 128))
def dyadicCheck : Bool := checked (allDyadicPartsDescend (.integer 8))
def chargeCheck : Bool := checked completeChargeWitness
def incidenceCheck : Bool := checked incidenceCarrierWitness
def telescopingCheck : Bool := checked telescopingWitness
def detourCheck : Bool := checked allSmallPathsObeyActionBoundary
def witnesses : List Witness := [⟨"odd-core-invariance","Every reduced rational control part through denominator 128 preserves its exact odd core.",oddCoreCheck⟩,⟨"dyadic-fixed-point-descent","Every reduced dyadic part through depth eight loses one binary layer per Fold and reaches the One.",dyadicCheck⟩,⟨"complete-charge-symmetry","The two-by-two fibre partition has exactly four preserving bijections.",chargeCheck⟩,⟨"incidence-carrier-symmetry","The complete edge-labelled example retains only its exact preserving bijections.",incidenceCheck⟩,⟨"telescoping-descent","A complete exact descent telescopes to endpoint separation.",telescopingCheck⟩,⟨"detour-bound","Every exhaustively generated small exact path respects the action boundary.",detourCheck⟩]
theorem oddCoreCheckPassed : oddCoreCheck=true := rfl
theorem dyadicCheckPassed : dyadicCheck=true := rfl
theorem sourceChargeList : SymmetryActionClasses.chargePreservingBijections charges=.ok [[0,1,2,3],[0,1,3,2],[1,0,2,3],[1,0,3,2]] := by
 unfold SymmetryActionClasses.chargePreservingBijections
 change SymmetryActionClasses.selectCharges charges (SymmetryActionIndexArrangements.arrangementsCore [0,1,2,3])=_
 rw [SymmetryActionExampleCensus.indices0123]
 rfl
theorem chargeCheckPassed : chargeCheck=true := by
 unfold chargeCheck completeChargeWitness
 rw [sourceChargeList]
 rfl
theorem incidenceCheckPassed : incidenceCheck=true := by
 unfold incidenceCheck incidenceCarrierWitness SymmetryActionClasses.completeSymmetryClass
 rw [sourceChargeList]
 rfl
theorem telescopingCheckPassed : telescopingCheck=true := rfl
theorem detourCheckPassed : detourCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (oddCoreCheck && (dyadicCheck && (chargeCheck && (incidenceCheck && (telescopingCheck && (detourCheck && true))))))=true
 rw [oddCoreCheckPassed,dyadicCheckPassed,chargeCheckPassed,incidenceCheckPassed,telescopingCheckPassed,detourCheckPassed]
 rfl
end SFT.Physics.SymmetryActionEntryWitnesses
