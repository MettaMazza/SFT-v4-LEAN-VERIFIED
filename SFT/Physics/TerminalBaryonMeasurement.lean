import SFT.Physics.TerminalBaryon
namespace SFT.Physics.TerminalBaryonMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals
open TerminalMatterRecords QuarkComparison TerminalBaryon
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def label : String := "terminal-baryon-to-photon-prediction-lies-inside-independent-PDG-BBN-and-Planck-derived-intervals__observational-derivation-disclosed"
def classificationRows (rows : Value) : Except String String := do
 let prediction ← predictionInterval
 let bbn ← field rows "bbn_baryon_to_photon_ratio"
 let lower ← decimalField bbn "strict_lower"
 let upper ← decimalField bbn "strict_upper"
 let planck ← field rows "planck_derived_baryon_to_photon_ratio"
 let centre ← decimalField planck "value"
 let uncertainty ← decimalField planck "standard_uncertainty"
 if !lower.blt prediction.1 || prediction.2.blt prediction.1 || !prediction.2.blt upper then
  throw "terminal baryon prediction left the independent BBN interval"
 if !overlaps prediction (subtract centre uncertainty,add centre uncertainty) then
  throw "terminal baryon prediction missed the PDG Planck-derived interval"
 pure label
def classificationFromRecord (record : Value) : Except String String := do
 classificationRows (← sourceRowsFromRecord record "PDG-2025-BIG-BANG-COSMOLOGY")
def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 classificationRows (← sourceRows bytes files payload "PDG-2025-BIG-BANG-COSMOLOGY")
theorem originalClassification : classificationFromRecord registeredRecord=.ok label := rfl
def contributionCheck : Bool := match TerminalBaryon.predictionInterval with
 | .error _ => false
 | .ok p => (normalize 1 (10^12) (by decide)).blt p.1
theorem contributionCheckPassed : contributionCheck=true := rfl
end SFT.Physics.TerminalBaryonMeasurement
