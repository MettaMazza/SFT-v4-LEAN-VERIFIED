import SFT.Physics.BaryogenesisDependency
namespace SFT.Physics.BaryogenesisDependencyWitnesses
open BaryogenesisDependency
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def censusCheck : Bool := completeConditionCensus.length==8 && conditionKeys.eraseDups.length==8
def uniqueCheck : Bool := uniquePositiveProcess
def emptyRecord : ResidueRecord → Bool
 | .emptyOne => true
 | .residue _ _ => false
def omissionsCheck : Bool := [(false,true,true),(true,false,true),(true,true,false)].all
 (fun (t,c,h) => emptyRecord (retainedBaryonResidue t c h))
def witnesses : List Witness := [⟨"complete-eight-case-census","Every presence/absence combination is generated once.",censusCheck⟩,⟨"unique-positive-residue","Exactly the three-condition process retains a positive matter-oriented One residue.",uniqueCheck⟩,⟨"all-omissions-close","Removing any one required distinction returns the empty-One residue.",omissionsCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.BaryogenesisDependencyWitnesses
