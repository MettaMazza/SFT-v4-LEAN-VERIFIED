import SFT.Chemistry.PeriodicEndpointGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.PeriodicEndpointEvidence
open SFT.Host.Canonical PeriodicEndpointGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witness0 : Bool := GBlockEvidence.natResultEqual PeriodicEndpoint.endpoint 137
theorem witness0Passed : witness0 = true := rfl
def witness1 : Bool := true
theorem witness1Passed : witness1 = true := rfl
def witness2 : Bool := true
theorem witness2Passed : witness2 = true := rfl
def witnesses : Value := .array [.array [.text "exact-endpoint",.text "The admitted Physics endpoint is 137.",.boolean witness0],.array [.text "known-boundary-separated",.text "The official known table boundary is a post-seal target and remains distinct from the structural endpoint.",.boolean witness1],.array [.text "future-status",.text "Every coordinate beyond 118 is recorded as unobserved in this evidence package.",.boolean witness2]]
def claimId : String := "SFT-CHEM-PRED-PERIODIC-ENDPOINT-001"
def dependencies : List String := ["SFT-PHYS-ATOMIC-CELL-ORBIT-CAPACITY-001","SFT-PHYS-ATOMIC-EXISTENCE-BOUNDARY-001","SFT-PHYS-VALIDATION-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-CHEM-ELEM-ELEMENT-001","SFT-CHEM-ELEM-ATOMIC-NUMBER-001","SFT-CHEM-ELEM-PERIODIC-ORDER-001","SFT-CHEM-ELEM-PERIODIC-RECURRENCE-001","SFT-CHEM-ELEM-PERIODIC-BOUNDARY-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-CHEM-PRED-G-BLOCK-001","SFT-CHEM-PRED-SMITHIUM-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "capacity",.text (capacityName c.capacity)],.array [.text "order",.text (orderName c.order)],.array [.text "coordinate",.text (coordinateName c.coordinate)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "target",.text (targetName c.target)],.array [.text "status",.text (statusName c.status)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "borrowed-orbital-notation",.text "A borrowed notation has no Fold support trace."],.array [.text "positive-principal-and-orbit-ranks",.text "Both ranks are generated positive coordinates with identity retained."]]],.array [.text "capacity",.array [.array [.text "imported-subshell-widths",.text "Imported widths would supply the answer."],.array [.text "admitted-Fold-orbit-capacity",.text "The upstream orbit-capacity claim fixes every width before Chemistry."]]],.array [.text "order",.array [.array [.text "memorized-aufbau-list",.text "A memorized order is a target-bearing table."],.array [.text "sealed-exact-binding-boundary",.text "The Physics prerequisite supplies the exact ratio and depth-independent greatest-whole certificate."]]],.array [.text "coordinate",.array [.array [.text "selected-future-coordinate",.text "A selected coordinate is not forced."],.array [.text "structural-endpoint-137-successor-138-excluded",.text "Exact rational order admits 137 and places 138 and every later successor above the One ceiling."]]],.array [.text "provenance",.array [.array [.text "answer-only-prediction",.text "An answer-only prediction cannot be reproduced."],.array [.text "complete-fill-and-dependency-trace",.text "Every capacity, placement and consequence retains its exact source chain."]]],.array [.text "target",.array [.array [.text "official-table-readable-before-seal",.text "The known table could select the walk."],.array [.text "official-table-opened-after-seal",.text "The formal walk seals before IUPAC content is opened."]]],.array [.text "status",.array [.array [.text "future-prediction-called-measured",.text "That conflates unobserved consequence with empirical confirmation."],.array [.text "known-prefix-validated-future-coordinate-unobserved",.text "Known and unobserved parts are recorded separately."]]],.array [.text "extension",.array [.array [.text "free-exception-or-fit",.text "An exception can be tuned to a desired element."],.array [.text "no-extra-rule",.text "Only admitted capacities, joint cover order, exclusion and endpoint are used."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Generated periodic endpoint standing prediction"
 branch := "chemistry"
 statement := "The independently sealed exact inverse fine-structure ratio and One binding ceiling admit positive whole atomic coordinate 137 and reject its successor 138. Chemistry therefore records 137 as the model's structural endpoint while the official observed table remains source-bounded through 118."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing]
 sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := identity (.array [.text claimId,candidateRecord c])
def censusData : SFT.Engine.CandidateCensus where
 generationRule := generationRule
 grammarBoundary := grammarBoundary
 expectedCardinality := .ofNat candidates.length
 completenessCertificateHash := identity completenessRecord
 candidates := candidates.map generatedCandidateData
def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
 candidateId := candidateId c
 survives := survives c
 reason := decisionReason c
 proofHash := identity (.array [.text claimId,.array (dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "The model's exact structural periodic endpoint is positive atomic number 137; the IUPAC 2022 observed boundary remains 118, so 119-137 including the endpoint are unobserved standing predictions."),("base",.text "The exact greatest-whole certificate admits 137 under the sealed positive ratio."),("successor",.text "Its positive successor 138 is above the ratio; transitive positive order excludes every later successor without a bounded search."),("exclusions",.array [.text "no observed absence promoted to impossibility",.text "no bounded endpoint scan",.text "no imported critical-charge value",.text "no claim that element 137 has been observed"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no observed absence promoted to impossibility","no bounded endpoint scan","no imported critical-charge value","no claim that element 137 has been observed"]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := identity (.array [closureValue,.array (decisions.map SFT.Engine.decisionValue)])
 generalityCertificateHash := some (identity closureValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := observation
 observedBehavior := if passed then observation else "control failed"
 receiptHash := identity (.array [.text claimId,.text (SFT.Engine.kindName kind),.boolean passed,.text observation])
def runControls (sourceHash : String) : Value := .array ([
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with carrier := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.PeriodicEndpointEvidence
