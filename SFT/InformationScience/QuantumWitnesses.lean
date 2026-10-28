import SFT.InformationScience.QuantumExtension
namespace SFT.InformationScience.QuantumWitnesses
open QuantumSupport QuantumUnits QuantumBasis QuantumJoint QuantumObservation
open SFT.Mathematics.DiscreteObjects
structure Witness where
  name : String
  statement : String
  passed : Bool

def labels : List String := ["held-a","held-b"]
def positions : List String := ["p1","p2","p3"]
def source : List QuantitySupport.Word := match completeFoldSupport labels positions with | .error _ => [] | .ok rows => rows
def firstMap : QuantityProfile.Observation := source.map (fun word => (word,word.headD ""))
def supportCheck : Bool := decide (source.length=8) && distinct source
def unitCheck : Bool := match informationUnitTrace labels positions with | .error _ => false | .ok rows => decide (rows.length=3)
def basisCheck : Bool := match basisCorrespondence source with
 | .error _ => false | .ok rows => decide (rows.length=8) && decide ((rows.map Prod.snd).eraseDups.length=8)
def boundaryCheck : Bool := match superpositionEquivalentSupport labels positions with
 | .error _ => false | .ok row => decide (row.amplitudes="not-admitted-at-support-boundary")
def jointCheck : Bool := match jointSupport [["held-a"],["held-b"]] [["x"],["y"]] with
 | .error _ => false | .ok rows => decide (rows.length=4)
def reconstructionCheck : Bool := match observeSupport source firstMap "held-a" with
 | .error _ => false
 | .ok record => decide (record.retainedBranches.length=4) &&
   (match reconstructSupport record.reconstructionRecord with | .error _ => false | .ok restored => decide (restored=source))
def witnesses : List Witness := [
  ⟨"complete-branch-support","Two held labels over three positions generate eight exact unique branches.",supportCheck⟩,
  ⟨"unit-trace","Each of three positions independently realizes one Fold information distinction.",unitCheck⟩,
  ⟨"basis-bijection","Every branch has one unique retained basis name.",basisCheck⟩,
  ⟨"support-only-boundary","Superposition-equivalent support explicitly refuses amplitudes at this boundary.",boundaryCheck⟩,
  ⟨"joint-composition","Two one-position supports generate four exact joint pair cells.",jointCheck⟩,
  ⟨"record-reconstruction","First-label observation retains four branches and its record reconstructs all eight.",reconstructionCheck⟩
]
theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.InformationScience.QuantumWitnesses
