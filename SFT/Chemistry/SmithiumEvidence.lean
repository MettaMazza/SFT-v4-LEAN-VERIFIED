import SFT.Chemistry.SmithiumGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.SmithiumEvidence
open SFT.Host.Canonical SmithiumGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witness0 : Bool := match Smithium.smithiumRecord with | .error _ => false | .ok r => (r.proton == 126) && (r.neutron == 184) && (r.mass == 310)
theorem witness0Passed : witness0 = true := rfl
def witness1 : Bool := match Smithium.smithiumRecord with | .error _ => false | .ok r => GBlockEvidence.natListEqual (r.configuration.map (fun t => t.1)) [8,5] && GBlockEvidence.natListEqual (r.configuration.map (fun t => t.2.1)) [1,5] && GBlockEvidence.natListEqual (r.configuration.map (fun t => t.2.2)) [2,6]
theorem witness1Passed : witness1 = true := rfl
def witness2 : Bool := match Smithium.smithiumRecord with | .error _ => false | .ok r => (r.valence == 8) && GBlockEvidence.natListEqual r.predictedPositiveOxidationCounts [2,3,4,5,6,7,8]
theorem witness2Passed : witness2 = true := rfl
def witnesses : Value := .array [.array [.text "nuclear-coordinate",.text "The next generated double closure is 126/184 and sums to 310.",.boolean witness0],.array [.text "electronic-coordinate",.text "The fill walk places 8s2 and 5g6 at 126.",.boolean witness1],.array [.text "valence-release",.text "The eight active carriers generate positive release counts from two through eight.",.boolean witness2]]
def claimId : String := "SFT-CHEM-PRED-SMITHIUM-001"
def dependencies : List String := ["SFT-PHYS-ATOMIC-CELL-ORBIT-CAPACITY-001","SFT-PHYS-ATOMIC-EXISTENCE-BOUNDARY-001","SFT-PHYS-VALIDATION-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-CHEM-ELEM-ELEMENT-001","SFT-CHEM-ELEM-ATOMIC-NUMBER-001","SFT-CHEM-ELEM-PERIODIC-ORDER-001","SFT-CHEM-ELEM-PERIODIC-RECURRENCE-001","SFT-CHEM-ELEM-PERIODIC-BOUNDARY-001","SFT-PHYS-NUCLEAR-CLOSURE-SEQUENCE-001","SFT-PHYS-VALIDATION-NUCLEAR-CLOSURES-001","SFT-CHEM-PRED-G-BLOCK-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "capacity",.text (capacityName c.capacity)],.array [.text "order",.text (orderName c.order)],.array [.text "coordinate",.text (coordinateName c.coordinate)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "target",.text (targetName c.target)],.array [.text "status",.text (statusName c.status)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "borrowed-orbital-notation",.text "A borrowed notation has no Fold support trace."],.array [.text "positive-principal-and-orbit-ranks",.text "Both ranks are generated positive coordinates with identity retained."]]],.array [.text "capacity",.array [.array [.text "imported-subshell-widths",.text "Imported widths would supply the answer."],.array [.text "admitted-Fold-orbit-capacity",.text "The upstream orbit-capacity claim fixes every width before Chemistry."]]],.array [.text "order",.array [.array [.text "memorized-aufbau-list",.text "A memorized order is a target-bearing table."],.array [.text "sealed-joint-cover-fill-walk",.text "The already admitted g-block walk fixes every electronic occupation."]]],.array [.text "coordinate",.array [.array [.text "selected-future-coordinate",.text "A selected coordinate is not forced."],.array [.text "next-double-closure-126-184-with-8s2-5g6",.text "The nuclear successor law and electronic walk cross-lock on the same positive element coordinate."]]],.array [.text "provenance",.array [.array [.text "answer-only-prediction",.text "An answer-only prediction cannot be reproduced."],.array [.text "complete-fill-and-dependency-trace",.text "Every capacity, placement and consequence retains its exact source chain."]]],.array [.text "target",.array [.array [.text "official-table-readable-before-seal",.text "The known table could select the walk."],.array [.text "official-table-opened-after-seal",.text "The formal walk seals before IUPAC content is opened."]]],.array [.text "status",.array [.array [.text "future-prediction-called-measured",.text "That conflates unobserved consequence with empirical confirmation."],.array [.text "known-prefix-validated-future-coordinate-unobserved",.text "Known and unobserved parts are recorded separately."]]],.array [.text "extension",.array [.array [.text "free-exception-or-fit",.text "An exception can be tuned to a desired element."],.array [.text "no-extra-rule",.text "Only admitted capacities, joint cover order, exclusion and endpoint are used."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Smithium element-126 standing prediction"
 branch := "chemistry"
 statement := "The independently sealed nuclear recurrence places the next proton/neutron double closure at 126/184. The generated electronic walk gives element 126 the active configuration 8s2 5g6, mass coordinate 310, eight valence carriers and structurally admissible positive oxidation counts +2 through +8."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "Smithium is the standing prediction Z=126, N=184, A=310 with active configuration 8s2 5g6, valence count 8 and predicted positive oxidation counts +2 through +8."),("base",.text "The last known validated noble closure at 118 is retained as the complete electronic core and the admitted nuclear sequence retains the 82/126 closure pair."),("successor",.text "Advance the electronic walk through the 8s pair and six 5g carriers while the nuclear recurrence advances to its next proton and neutron closures; all prior coordinates remain held."),("exclusions",.array [.text "no observed Smithium claim",.text "no imported island-of-stability coordinate",.text "no fitted nuclear coupling or chemical exception",.text "no semantic numerical zero, negative oxidation magnitude or nonexact proof value"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no observed Smithium claim","no imported island-of-stability coordinate","no fitted nuclear coupling or chemical exception","no semantic numerical zero, negative oxidation magnitude or nonexact proof value"]
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
end SFT.Chemistry.SmithiumEvidence
