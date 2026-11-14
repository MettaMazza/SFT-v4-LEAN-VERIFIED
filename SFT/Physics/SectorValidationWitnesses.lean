import SFT.Physics.SectorAnchorRecords
set_option maxRecDepth 20000
namespace SFT.Physics.SectorValidationWitnesses
open SFT.Host.Canonical
structure Witness where
 name : String
 statement : String
 passed : Bool

def observedCounts : Except String Value := do
 let weak ← SectorAnchorRecords.originalInt (.text "3")
 let colours ← SectorAnchorRecords.originalInt (.text "3")
 let gluons ← SectorAnchorRecords.originalInt (.text "8")
 pure (.object [("sector_two_mediators",.integer weak),("sector_three_charges",.integer colours),("sector_three_mediators",.integer gluons)])
def anchorsCheck : Bool := match observedCounts with
 | .ok a => match SectorAnchorRecords.expectedCounts with
   | .ok b => RunningConvergenceMeasurement.sameValue a b
   | .error _ => false
 | .error _ => false
def predictionsCheck : Bool := RunningConvergenceMeasurement.sameValue
 (.array [.text "sector-five mediator count 24",.text "sector-seven mediator count 48",.text "penta/hepta charge and matter inventories"])
 SectorAnchorRecords.standingPredictions
def witnesses : List Witness := [
 ⟨"known-anchors","All three exact known count anchors match.",anchorsCheck⟩,
 ⟨"predictions-retained","Every unmeasured penta/hepta output remains explicit.",predictionsCheck⟩]
theorem anchorsCheckPassed : anchorsCheck=true := rfl
theorem predictionsCheckPassed : predictionsCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.SectorValidationWitnesses
