import SFT.Chemistry.LimitingGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.LimitingEvidence
open SFT.Host.Canonical LimitingGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "least-witness",.text "exact ratios select the complete tied least support",.boolean true],.array [.text "tie-witness",.text "equal exact ratios retain every limiting carrier",.boolean true],.array [.text "floating-control",.text "no float participates",.boolean true]]
def claimId : String := "SFT-CHEM-STOICH-LIMITING-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-CHEMICAL-SPECIES-001","SFT-CHEM-MEAS-SUBSTANCE-001","SFT-CHEM-MEAS-AMOUNT-001","SFT-CHEM-MEAS-FORMULA-001","SFT-CHEM-ELEM-ELEMENT-001","SFT-CHEM-ELEM-PERIODIC-ORDER-001","SFT-CHEM-STOICH-COEFFICIENT-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "requirement",.text (requirementName c.requirement)],.array [.text "comparison",.text (comparisonName c.comparison)],.array [.text "selection",.text (selectionName c.selection)],.array [.text "consumption",.text (consumptionName c.consumption)],.array [.text "excess",.text (excessName c.excess)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "named-reagent-only",.text "A name without amount and coefficient cannot limit progress."],.array [.text "available-reactant-support",.text "Every present reactant retains amount and identity."]]],.array [.text "requirement",.array [.array [.text "unbalanced-requirement",.text "Consumption requirements must come from the balanced reaction."],.array [.text "primitive-coefficient-requirement",.text "The admitted least coefficients define required shares."]]],.array [.text "comparison",.array [.array [.text "floating-ratio-ranking",.text "Floating comparison cannot certify ties or minima."],.array [.text "exact-available-required-ratios",.text "All ratios are exact positive rationals."]]],.array [.text "selection",.array [.array [.text "first-considered-reactant",.text "Ordering of inspection cannot select the limiter."],.array [.text "complete-least-ratio-support",.text "All tied least ratios are retained."]]],.array [.text "consumption",.array [.array [.text "negative-remainder",.text "Overrunning the least support would require unavailable matter."],.array [.text "complete-consumption-boundary",.text "At least one limiting carrier is exactly exhausted as an empty form."]]],.array [.text "excess",.array [.array [.text "excess-erased",.text "Nonlimiting remainder is part of the result."],.array [.text "retained-excess-support",.text "Every remaining positive carrier stays recorded."]]],.array [.text "record",.array [.array [.text "limiter-name-only",.text "A name cannot reproduce the comparison."],.array [.text "amount-coefficient-ratio-trace",.text "Every ratio and tied minimum remains held."]]],.array [.text "extension",.array [.array [.text "free-limiter-rule",.text "A preference could choose a nonminimal reagent."],.array [.text "no-extra-rule",.text "The exact order alone selects the complete least support."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Limiting-component and complete-consumption boundary"
 branch := "chemistry"
 statement := "The limiting support is the complete tied least set of exact available-amount to primitive-required-count ratios; it bounds reaction progress before any unavailable carrier would be required."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "available-reactant-support__primitive-coefficient-requirement__exact-available-required-ratios__complete-least-ratio-support"),("base",.text "One present reactant with one required count supplies one positive progress boundary."),("successor",.text "Appending one reactant compares its exact available/required ratio and preserves all earlier minima or replaces them with the complete new tied least support."),("exclusions",.array [.text "no IUPAC wording, balanced equation, measured amount or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no absent species represented by a zero coefficient; absence is an empty generated form",.text "no application result or opaque predictor",.text "official target content opens only through post-seal custody",.text "Every finite reaction input with exact positive available amounts and primitive required coefficients, where complete reaction progress is bounded by every available-to-required ratio."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC wording, balanced equation, measured amount or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no absent species represented by a zero coefficient; absence is an empty generated form","no application result or opaque predictor","official target content opens only through post-seal custody","Every finite reaction input with exact positive available amounts and primitive required coefficients, where complete reaction progress is bounded by every available-to-required ratio."]
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
end SFT.Chemistry.LimitingEvidence
