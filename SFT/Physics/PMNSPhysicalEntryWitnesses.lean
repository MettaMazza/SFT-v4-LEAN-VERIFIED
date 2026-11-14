import SFT.Physics.PMNSPhysical
namespace SFT.Physics.PMNSPhysicalEntryWitnesses
open PMNSPhysical
structure Witness where
 name : String
 statement : String
 passed : Bool
def identityCheck : Bool := match pmnsCPStructure with
 | .error _ => false
 | .ok f => decide (f.electronWeights=originalRecord.electronWeights) && decide (f.cpPhase=(⟨1,2,by decide,by decide⟩ : Rat))
def witnesses : List Witness := [⟨"pmns","All PMNS values and weights close exactly.",identityCheck⟩]
theorem identityCheckPassed : identityCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.PMNSPhysicalEntryWitnesses
