import SFT.Chemistry.AntiaromaticDistinctionDerivation
namespace SFT.Chemistry.AntiaromaticDistinctionWitnesses
open SFT.Physics.CapabilityValues AntiaromaticDistinction
open MulticentreSupport (sameLabel sameWord)
def base := census "carrier" ["a","b","c","d"]
def censusWitness : Bool := match base with
 | .error _ => false
 | .ok rows => sameWord (rows.map Alternative.recurrenceClass) [aromatic,nonaromatic,antiaromatic]
def supportWitness : Bool := match base with
 | .ok [a,n,f] => hasCount a.recurrenceSupport 6 && isEmptyOne n.recurrenceSupport && hasCount f.recurrenceSupport 4
 | .error _ | .ok [] | .ok [_] | .ok [_,_] | .ok (_::_::_::_::_) => false
def orderWitness : Bool := match (do censusOrder (← base)) with
 | .error _ => false | .ok s => sameWord (exactOrder s) [aromatic,nonaromatic,antiaromatic]
def successorWitness : Bool := match base with
 | .ok [a,n,f] => match appendLayer a,appendLayer n,appendLayer f with
  | .ok a,.ok n,.ok f => hasCount a.recurrenceSupport 10 && isEmptyOne n.recurrenceSupport && hasCount f.recurrenceSupport 8
  | .error _,_,_ | .ok _,.error _,_ | .ok _,.ok _,.error _ => false
 | .error _ | .ok [] | .ok [_] | .ok [_,_] | .ok (_::_::_::_::_) => false
def inconsistentWitness : Bool := match base with
 | .ok [_,_,f] => match alternative f.carrier f.cycle brokenPlane completeConjugation antiaromatic (.positive ⟨4,by decide⟩) [AromaticRecurrence.completeCells] with
  | .error _ => true | .ok _ => false
 | .error _ | .ok [] | .ok [_] | .ok [_,_] | .ok (_::_::_::_::_) => false
def missingBreakWitness : Bool := match base with
 | .ok [_,n,_] => match nonaromaticAlternative n.cycle false false with
  | .error _ => true | .ok _ => false
 | .error _ | .ok [] | .ok [_] | .ok [_,_] | .ok (_::_::_::_::_) => false
def zeroWitness : Bool := match count 0 with | .error _ => true | .ok _ => false
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem censusPassed : censusWitness=true := by decide
theorem supportPassed : supportWitness=true := by decide
theorem orderPassed : orderWitness=true := by decide
theorem successorPassed : successorWitness=true := by decide
theorem inconsistentPassed : inconsistentWitness=true := by decide
theorem missingBreakPassed : missingBreakWitness=true := by decide
theorem zeroPassed : zeroWitness=true := by decide
end SFT.Chemistry.AntiaromaticDistinctionWitnesses
