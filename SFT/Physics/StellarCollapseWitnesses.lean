import SFT.Physics.StellarCollapseCertificate
namespace SFT.Physics.StellarCollapseWitnesses
open StellarCollapseCertificate StellarNuclearChannels
open StellarCertificate (flag)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match ((do pure (flag (← theoremCertificate) "all_chains_strict")) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness0Passed : witness0=true := rfl
#print axioms witness0Passed
def witness1 : Bool := match ((.ok (flag bindingTerminal "unique" && flag bindingTerminal "tail_closed")) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness1Passed : witness1=true := rfl
#print axioms witness1Passed
def witness2 : Bool := match ((do let c ← supportLossCollapse; pure (flag c "outward_fusion_support_empty" && flag c "inward_gravity_retained")) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness2Passed : witness2=true := rfl
#print axioms witness2Passed
def witness3 : Bool := match ((do pure (flag (← theoremCertificate) "all_thermonuclear_finite")) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness3Passed : witness3=true := rfl
#print axioms witness3Passed
def witness4 : Bool := match ((do pure (flag (← theoremCertificate) "all_neutral_capture_closed")) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness4Passed : witness4=true := rfl
#print axioms witness4Passed
def witnesses : List Witness := [⟨"strict-stage-chain","All registered finite stage chains have strictly increasing access carriers.",witness0⟩,⟨"binding-terminal","The terminal coordinate is unique and tail-closed.",witness1⟩,⟨"support-loss","Fusion release closes at the peak while inward gravity remains.",witness2⟩,⟨"thermonuclear","Every registered positive-feedback trace terminates only on finite fuel exhaustion.",witness3⟩,⟨"neutral-capture","Every registered neutral-capture trace retains mass and recorded label rebalance.",witness4⟩]
end SFT.Physics.StellarCollapseWitnesses
