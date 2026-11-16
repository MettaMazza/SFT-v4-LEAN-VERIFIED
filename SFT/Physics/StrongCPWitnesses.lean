import SFT.Physics.StrongCPCertificate
namespace SFT.Physics.StrongCPWitnesses
open StrongCPHands StrongCPActions StrongCPCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match ((do let rows ← strongHandCensus; let c ← theoremCertificate; pure (rows.length==3 && c.uniqueStrongHandForm)) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness0Passed : witness0=true := rfl
#print axioms witness0Passed
def witness1 : Bool := match ((do let c ← theoremCertificate; let a ← strongAlignmentCertificate; pure (c.onlyTwoPhaseClasses && samePhase a.strongPhase ("aligned-One",SFT.Foundation.ExactOperations.one))) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness1Passed : witness1=true := rfl
#print axioms witness1Passed
def witness2 : Bool := match ((do let c ← theoremCertificate; let a ← strongAlignmentCertificate; pure (c.noExtraCompensator && sameHands a.electricDipoleCarrier ["empty-One"])) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness2Passed : witness2=true := rfl
#print axioms witness2Passed
def witness3 : Bool := match ((do let a ← sectorActionCertificate; pure (a.mediatorTotal==83 && a.crossFibrePairCount==202 && a.generatedCrossFibreActions.isEmpty)) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness3Passed : witness3=true := rfl
#print axioms witness3Passed
def witness4 : Bool := match ((do let p ← protonTransitionCertificate; let c ← theoremCertificate; pure (p.generatedImageCount==27 && c.baryonOneInvariant)) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness4Passed : witness4=true := rfl
#print axioms witness4Passed
def witnesses : List Witness := [⟨"strong-hand-census","All three nonempty hand subsets are generated and only the paired form completes colour-times-hand support.",witness0⟩,⟨"phase-census","The complete census yields only aligned One and self-antipodal half-One phase classes.",witness1⟩,⟨"no-compensator","Exact alignment leaves no strong-violation, EDM or compensator carrier.",witness2⟩,⟨"sector-actions","All 83 generated mediators preserve fibre and none of 202 cross-fibre pairs is generated.",witness3⟩,⟨"proton-invariant","All 27 complete colour-three images retain baryon One.",witness4⟩]
end SFT.Physics.StrongCPWitnesses
