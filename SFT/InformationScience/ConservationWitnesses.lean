import SFT.InformationScience.ConservationExtension
namespace SFT.InformationScience.ConservationWitnesses
open ConservationLedger ConservationReverse ConservationComposition
structure Witness where
  name : String
  statement : String
  passed : Bool

def source : List String := ["aa","ab","ba","bb"]
def identityMap : SFT.Mathematics.ProbabilityObservations.Observation := source.map (fun s => (s,s))
def prefixMap : SFT.Mathematics.ProbabilityObservations.Observation := [("aa","a"),("ab","a"),("ba","b"),("bb","b")]
def eraseMap : SFT.Mathematics.ProbabilityObservations.Observation := [("a","one"),("b","one")]
def isTrue : Except String Bool → Bool | .error _ => false | .ok value => value
def identityCheck : Bool := match transformationLedger source identityMap with
 | .error _ => false
 | .ok ledger => decide ((contents ledger.retainedDistinctions).length = 6) && decide (ledger.closedDistinctions = .emptyOne)
def prefixCheck : Bool := match transformationLedger source prefixMap with
 | .error _ => false
 | .ok ledger => decide ((contents ledger.retainedDistinctions).length = 4) && decide ((contents ledger.closedDistinctions).length = 2)
def reversibleCheck : Bool := isTrue (isReversible source identityMap) &&
 (match isReversible source prefixMap with | .ok false => true | .ok true => false | .error _ => false)
def reverseCheck : Bool := match reverseRecord source prefixMap with
 | .error _ => false
 | .ok rows => rows.all (fun row => match row.2 with | .unique _ => false | .heldLabels members => decide (members.length=2))
def processingCheck : Bool := isTrue (downstreamRetentionLaw source prefixMap eraseMap) &&
 (match compose source prefixMap eraseMap with
  | .error _ => false
  | .ok composite => match transformationLedger source composite with
    | .error _ => false | .ok ledger => decide (ledger.retainedDistinctions = .emptyOne))
def witnesses : List Witness := [
  ⟨"identity-conservation","Identity retains all six source distinctions and closes none.",identityCheck⟩,
  ⟨"prefix-loss","Prefix projection retains four cross-prefix distinctions and closes two exact predecessor pairs.",prefixCheck⟩,
  ⟨"reversibility-boundary","Identity is reversible while prefix projection is not.",reversibleCheck⟩,
  ⟨"reverse-record","Each prefix image retains its two possible source labels.",reverseCheck⟩,
  ⟨"data-processing","Erasing the retained prefix cannot reopen either previously closed distinction.",processingCheck⟩
]
theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.InformationScience.ConservationWitnesses
