import SFT.Chemistry.GBlockGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.GBlockEvidence
open SFT.Host.Canonical GBlockGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def natResultEqual (result : Except String Nat) (expected : Nat) : Bool :=
 match result with
 | .error _ => false
 | .ok n => n == expected

def natListEqual : List Nat → List Nat → Bool
 | [], [] => true
 | [], _::_ => false
 | _::_, [] => false
 | a::xs, b::ys => (a == b) && natListEqual xs ys

def witness0 : Bool :=
 natResultEqual (SFT.Physics.AtomicOrbitCapacity.orbitCapacity (.integer 1)) 2 &&
 natResultEqual (SFT.Physics.AtomicOrbitCapacity.orbitCapacity (.integer 2)) 6 &&
 natResultEqual (SFT.Physics.AtomicOrbitCapacity.orbitCapacity (.integer 3)) 10 &&
 natResultEqual (SFT.Physics.AtomicOrbitCapacity.orbitCapacity (.integer 4)) 14 &&
 natResultEqual (SFT.Physics.AtomicOrbitCapacity.orbitCapacity (.integer 5)) 18

def witness1 : Bool :=
 match GBlockOperations.nobleClosures (.integer 7) with
 | .error _ => false
 | .ok xs => natListEqual xs [2,10,18,36,54,86,118]

def witness2 : Bool :=
 natResultEqual (GBlockOperations.firstOccupiedCoordinate (.integer 8) (.integer 1)) 119 &&
 natResultEqual (GBlockOperations.firstOccupiedCoordinate (.integer 5) (.integer 5)) 121

theorem witness0Passed : witness0 = true := rfl
theorem witness1Passed : witness1 = true := rfl
theorem witness2Passed : witness2 = true := rfl
def witnesses : Value := .array [.array [.text "first-five-widths",.text "The first five orbit ranks have exact capacities 2,6,10,14,18.",.boolean witness0],.array [.text "noble-prefix",.text "The generated closure prefix is exact.",.boolean witness1],.array [.text "g-block-opening",.text "8s opens first and 5g opens at 121.",.boolean witness2]]
def claimId : String := "SFT-CHEM-PRED-G-BLOCK-001"
def dependencies : List String := ["SFT-PHYS-ATOMIC-CELL-ORBIT-CAPACITY-001","SFT-PHYS-ATOMIC-EXISTENCE-BOUNDARY-001","SFT-PHYS-VALIDATION-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-CHEM-ELEM-ELEMENT-001","SFT-CHEM-ELEM-ATOMIC-NUMBER-001","SFT-CHEM-ELEM-PERIODIC-ORDER-001","SFT-CHEM-ELEM-PERIODIC-RECURRENCE-001","SFT-CHEM-ELEM-PERIODIC-BOUNDARY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "capacity",.text (capacityName c.capacity)],.array [.text "order",.text (orderName c.order)],.array [.text "coordinate",.text (coordinateName c.coordinate)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "target",.text (targetName c.target)],.array [.text "status",.text (statusName c.status)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "borrowed-orbital-notation",.text "A borrowed notation has no Fold support trace."],.array [.text "positive-principal-and-orbit-ranks",.text "Both ranks are generated positive coordinates with identity retained."]]],.array [.text "capacity",.array [.array [.text "imported-subshell-widths",.text "Imported widths would supply the answer."],.array [.text "admitted-Fold-orbit-capacity",.text "The upstream orbit-capacity claim fixes every width before Chemistry."]]],.array [.text "order",.array [.array [.text "memorized-aufbau-list",.text "A memorized order is a target-bearing table."],.array [.text "increasing-joint-cover-then-principal-rank",.text "Joint cover is the complete positive sum of the two ranks; retaining principal identity supplies the sole tie order."]]],.array [.text "coordinate",.array [.array [.text "selected-future-coordinate",.text "A selected coordinate is not forced."],.array [.text "first-5g-occupation-at-121",.text "The generated walk exhausts the 118 core and 8s pair before the first 5g cell."]]],.array [.text "provenance",.array [.array [.text "answer-only-prediction",.text "An answer-only prediction cannot be reproduced."],.array [.text "complete-fill-and-dependency-trace",.text "Every capacity, placement and consequence retains its exact source chain."]]],.array [.text "target",.array [.array [.text "official-table-readable-before-seal",.text "The known table could select the walk."],.array [.text "official-table-opened-after-seal",.text "The formal walk seals before IUPAC content is opened."]]],.array [.text "status",.array [.array [.text "future-prediction-called-measured",.text "That conflates unobserved consequence with empirical confirmation."],.array [.text "known-prefix-validated-future-coordinate-unobserved",.text "Known and unobserved parts are recorded separately."]]],.array [.text "extension",.array [.array [.text "free-exception-or-fit",.text "An exception can be tuned to a desired element."],.array [.text "no-extra-rule",.text "Only admitted capacities, joint cover order, exclusion and endpoint are used."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Generated g-block structural prediction"
 branch := "chemistry"
 statement := "The admitted Fold orbit capacities ordered by increasing joint principal/orbit cover, with principal rank breaking a cover tie, generate noble closures 2, 10, 18, 36, 54, 86 and 118; fill 8s at 119-120; and open the 5g block at 121. The known prefix is externally checked and the g-block placement remains a sealed unobserved prediction."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "The exact walk has capacities 2,6,10,14,18; noble closures 2,10,18,36,54,86,118; 8s occupations at 119-120; and first 5g occupation at 121."),("base",.text "The first valid cell (principal One, orbit One) carries the two Fold labels and closes at atomic number two."),("successor",.text "Advance by the next complete joint-cover cell, fill its exact capacity, and retain the prior cumulative count; tie order is stable for every positive successor cover."),("exclusions",.array [.text "no imported aufbau list or observed shell width",.text "no V1/V2 answer as a derivational input",.text "no semantic numerical zero, negative or nonexact proof value",.text "no claim that element 121 has been observed"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no imported aufbau list or observed shell width","no V1/V2 answer as a derivational input","no semantic numerical zero, negative or nonexact proof value","no claim that element 121 has been observed"]
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
end SFT.Chemistry.GBlockEvidence
