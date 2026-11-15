import SFT.Physics.ProtonRadius
import SFT.Mathematics.LimitComputations
namespace SFT.Physics.ProtonRadiusWitnesses
open ProtonRadius SFT.Mathematics.LimitComputations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def edgeCheck : Bool := match protonInnerSite with
 | .error _ => false
 | .ok a => match protonEdgeShare with
  | .error _ => false
  | .ok b => equalRat (LeptonIntervals.add a b) one
def leadingCheck : Bool := match colourFibreSupport with
 | .error _ => false
 | .ok n => match leadingRadiusMultiplier with
  | .error _ => false
  | .ok q => n==6 && equalRat q (VacuumLedgerProofs.wholeRatio 4)
def chargeCheck : Bool := match completeChargeSupport with | .error _ => false | .ok n => n==10
def terminalCheck : Bool := match terminalRadiusCoefficient with
 | .error _ => false
 | .ok q => equalRat q (LeptonIntervals.normalize 10069574419808 2519231977345 (by decide))
def censusCheck : Bool := match structuralFormulaCensus with
 | .error _ => false
 | .ok rows => rows.length==9 && (rows.filter FormulaRow.structurallySelected).length==1
def witnesses : List Witness := [⟨"tripling-edge","The inner and outer tripling faces close exactly to the One.",edgeCheck⟩,⟨"complete-leading-support","Six complete colour/Fold paths send the two-thirds edge to four.",leadingCheck⟩,⟨"complete-charge-support","Nine ordered internal colour cells and one external charge close to ten.",chargeCheck⟩,⟨"terminal-coefficient","One terminal alpha traversal gives the exact retained coefficient.",terminalCheck⟩,⟨"complete-alternative-census","All three charge-support and three transport-order controls are retained with one structural survivor.",censusCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.ProtonRadiusWitnesses
