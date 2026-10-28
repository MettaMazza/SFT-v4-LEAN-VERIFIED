import SFT.InformationScience.ClassicalExtension
namespace SFT.InformationScience.ClassicalWitnesses
open ClassicalSupport ClassicalLedger ClassicalResolution ClassicalWhole
structure Witness where
  name : String
  statement : String
  passed : Bool

def source : List String := ["aa","ab","ba","bb"]
def fine : SFT.Mathematics.ProbabilityObservations.Observation := source.map (fun s => (s,s))
def prefixMap : SFT.Mathematics.ProbabilityObservations.Observation := [("aa","a"),("ab","a"),("ba","b"),("bb","b")]
def unequalMap : SFT.Mathematics.ProbabilityObservations.Observation := [("aa","held"),("ab","held"),("ba","held"),("bb","other")]
def heldCheck : Bool := match classicalState source "aa" with
 | .error _ => false | .ok state => decide (state = ⟨"aa",source⟩)
def halfCheck : Bool := match probabilityLedger source prefixMap with
 | .error _ => false | .ok rows => rows.all (fun row => decide (row.exactSupportPart.numerator=1) && decide (row.exactSupportPart.denominator=2) && decide (row.microstates.length=2))
def unequalCheck : Bool := match probabilityLedger source unequalMap with
 | .error _ => false | .ok rows => decide (rows.map (fun row => (row.exactSupportPart.numerator,row.exactSupportPart.denominator)) = [(3,4),(1,4)])
def resolutionCheck : Bool :=
 (match resolveObservation source fine "aa" with | .error _ => false | .ok result => decide (result = .classicalState "aa")) &&
 (match resolveObservation source prefixMap "a" with | .error _ => false | .ok result => decide (result = .unresolvedClass ["aa","ab"]))
def pushforwardCheck : Bool := match pushforwardLedger source prefixMap with
 | .error _ => false
 | .ok rows => pushforwardWhole rows && (match rows with | [] => false | row :: _ => decide (row.predecessors = ["aa","ab"]))
def realizationCheck : Bool := match deterministicRealization source prefixMap with
 | .error _ => false | .ok rows => rows.all (fun row => row.members.all (fun cell => decide (cell.2 = "deterministic-member")))
def witnesses : List Witness := [
  ⟨"classical-held-state","A held aa state retains its complete four-state provenance.",heldCheck⟩,
  ⟨"exact-half-classes","Prefix observation produces two exact one-over-two deterministic classes.",halfCheck⟩,
  ⟨"exact-unequal-parts","A three-member class and one-member class retain exact three-over-four and one-over-four parts.",unequalCheck⟩,
  ⟨"resolution-boundary","Fine observation resolves aa while prefix observation retains the unresolved aa/ab class.",resolutionCheck⟩,
  ⟨"pushforward-whole","Deterministic prefix pushforward retains both predecessors and reconstructs the exact whole.",pushforwardCheck⟩,
  ⟨"deterministic-realization","Every probabilistic prefix row exposes its deterministic member trace.",realizationCheck⟩
]
theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.InformationScience.ClassicalWitnesses
