import SFT.Physics.TerminalCKMComparison
import SFT.Physics.TerminalMatterRecords
namespace SFT.Physics.TerminalCKMMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals
open VacuumLedgerProofs QuarkComparison TerminalCKMComparison TerminalMatterRecords
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def label : String := "terminal-CKM-s12-s23-s13-and-J-all-overlap-complete-PDG-three-sigma-intervals__observational-derivation-disclosed"
def threeSigmaSquared (row : Value) : Except String Interval := do
 let centre ← decimalField row "value"
 let lowerUncertainty ← decimalField row "lower_uncertainty"
 let upperUncertainty ← decimalField row "upper_uncertainty"
 let lower := subtract centre (multiply (wholeRatio 3) lowerUncertainty)
 let upper := add centre (multiply (wholeRatio 3) upperUncertainty)
 if !(normalize 1 (10^12) (by decide)).blt lower then
  throw "registered positive interval crossed its declared boundary"
 pure (square lower,square upper)
def checksForRows (rows : Value) : Except String (List (String × Bool)) := do
 let p ← predictionIntervals
 [("s12_squared",p.s12Squared,"sin_theta12"),("s23_squared",p.s23Squared,"sin_theta23"),
  ("s13_squared",p.s13Squared,"sin_theta13"),("jarlskog_squared",p.jarlskogSquared,"jarlskog")].mapM fun (name,prediction,source) => do
  let target ← threeSigmaSquared (← field rows source)
  pure (name,overlaps prediction target)
def classificationRows (rows : Value) : Except String String := do
 let checks ← checksForRows rows
 if !(checks.all fun p => p.2) then
  let detail := Text.intercalate ", " (checks.map fun (name,passed) => Text.join ["'",name,"': ",if passed then "True" else "False"])
  throw (Text.join ["terminal CKM complete comparison failed: {",detail,"}"])
 pure label
def classificationFromRecord (record : Value) : Except String String := do
 classificationRows (← sourceRowsFromRecord record "PDG-2025-CKM-MATRIX")
def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 classificationRows (← sourceRows bytes files payload "PDG-2025-CKM-MATRIX")
theorem originalClassification : classificationFromRecord registeredRecord=.ok label := rfl
def completeCheck : Bool := match classificationFromRecord registeredRecord with
 | .error _ => false
 | .ok result => Text.equal result label
theorem completeCheckPassed : completeCheck=true := rfl
def contributionCheck : Bool := (normalize 1 (10^9) (by decide)).blt TerminalCKM.originalContribution
theorem contributionCheckPassed : contributionCheck=true := TerminalCKM.contributionPositive
end SFT.Physics.TerminalCKMMeasurement
