import SFT.InformationScience.MutualExtension
namespace SFT.InformationScience.MutualWitnesses
open MutualDecisions MutualParts
structure Witness where
  name : String
  statement : String
  passed : Bool

def support : List String := ["aa","ab","ba","bb"]
def leftMap : SFT.Mathematics.ProbabilityObservations.Observation := [("aa","a"),("ab","a"),("ba","b"),("bb","b")]
def rightMap : SFT.Mathematics.ProbabilityObservations.Observation := [("aa","a"),("ab","b"),("ba","a"),("bb","b")]
def halfCheck : Bool := match MutualConditional.conditionalLedger support rightMap leftMap with
 | .error _ => false
 | .ok rows => rows.all (fun row => match row.exactGivenPart with
   | .emptyOne => false | .part p => decide (p.numerator=1) && decide (p.denominator=2))
def isTrue : Except String Bool → Bool | .error _ => false | .ok value => value
def gridCheck : Bool := isTrue (factorizes support leftMap rightMap)
def emptyCheck : Bool := match dependenceLedger support leftMap rightMap with
 | .ok .emptyOne => true | .ok (.cells _) => false | .error _ => false
def copyCheck : Bool := isTrue (conditionallyResolved support leftMap leftMap)
def dependentCheck : Bool := (match factorizes support leftMap leftMap with | .ok false => true | .ok true => false | .error _ => false) &&
 (match dependenceLedger support leftMap leftMap with | .ok (.cells _) => true | .ok .emptyOne => false | .error _ => false)
def witnesses : List Witness := [
  ⟨"conditional-parts","Conditioning the second coordinate on the first yields two exact half-parts in each given class.",halfCheck⟩,
  ⟨"factorized-grid","The complete two-by-two coordinate grid factorizes exactly.",gridCheck⟩,
  ⟨"empty-dependence","A factorized grid has structural empty-One dependence ledger.",emptyCheck⟩,
  ⟨"resolved-copy","An observation is conditionally resolved by an exact copy of itself.",copyCheck⟩,
  ⟨"dependent-copy","Two identical nontrivial views do not factorize and retain their responsible cells.",dependentCheck⟩
]
theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.InformationScience.MutualWitnesses
