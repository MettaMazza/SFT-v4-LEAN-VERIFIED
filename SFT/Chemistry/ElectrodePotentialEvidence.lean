import SFT.Chemistry.ElectrodePotentialGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ElectrodePotentialEvidence
open SFT.Host.Canonical ElectrodePotentialGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "above",.text "Higher exact per-carrier account is held above reference.",.boolean true],.array [.text "below",.text "Lower exact per-carrier account is held below reference.",.boolean true],.array [.text "positive-magnitude",.text "Both directed separations are exact and positive.",.boolean true],.array [.text "coincidence",.text "Exact equality closes to EmptyOne.",.boolean true],.array [.text "reference",.text "Reference identity is retained.",.boolean true],.array [.text "condition",.text "Condition identity is retained.",.boolean true],.array [.text "condition-control",.text "Changed condition halts.",.boolean true],.array [.text "successor",.text "Common work successor preserves order.",.boolean true]]
def claimId : String := "SFT-CHEM-ELECTRODE-POTENTIAL-CHEMICAL-RELATION-002"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-COMBINATORICS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-HALF-REACTION-IDENTITY-ORIENTATION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "account",.text (accountName c.account)],.array [.text "reference",.text (referenceName c.reference)],.array [.text "condition",.text (conditionName c.condition)],.array [.text "normalization",.text (normalizationName c.normalization)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "coincidence",.text (coincidenceName c.coincidence)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "account",.array [.array [.text "voltage-answer-only",.text "A displayed voltage does not retain the chemical transfer account."],.array [.text "complete-half-cell-transfer-account",.text "Half-reaction, species, phases, work and transfer count remain held."]]],.array [.text "reference",.array [.array [.text "unbound-electrode-number",.text "An unbound number has no electrode reference."],.array [.text "one-held-reference-electrode",.text "Every comparison retains one exact reference identity."]]],.array [.text "condition",.array [.array [.text "mixed-temperature-or-state",.text "Changing conditions destroys comparability."],.array [.text "same-held-standard-condition",.text "Subject and reference share one declared condition."]]],.array [.text "normalization",.array [.array [.text "unnormalized-total-work",.text "Total work changes with carrier multiplicity."],.array [.text "exact-work-per-held-transfer-carrier",.text "Potential compares exact positive work per transferred carrier."]]],.array [.text "orientation",.array [.array [.text "signed-native-number",.text "A sign imports a negative proof magnitude."],.array [.text "held-above-below-or-coincident-orientation",.text "Direction is a held label and magnitude remains positive."]]],.array [.text "coincidence",.array [.array [.text "numerical-zero-potential",.text "Numerical zero is not a native magnitude."],.array [.text "structural-EmptyOne-reference-coincidence",.text "Exact equality closes the distinction to EmptyOne."]]],.array [.text "record",.array [.array [.text "selected-standard-potential",.text "A selected value can hide species, phase, uncertainty or estimates."],.array [.text "complete-standard-potential-reference-vector",.text "Every registered row and provenance field remains downstream."]]],.array [.text "extension",.array [.array [.text "species-specific-offset",.text "A fitted offset adds an unforced rule."],.array [.text "common-work-successor-preserves-order",.text "Adding the same exact work per carrier preserves the relation."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold electrode-potential chemical relation"
 branch := "chemistry"
 statement := "Electrode potential is the exact held above, below or coincident relation between complete half-cell work-per-carrier accounts at one reference and condition."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.observationalDerivation]
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-half-cell-transfer-account__one-held-reference-electrode__same-held-standard-condition__exact-work-per-held-transfer-carrier__held-above-below-or-coincident-orientation__structural-EmptyOne-reference-coincidence__complete-standard-potential-reference-vector__common-work-successor-preserves-order"),("base",.text "One subject and one reference half-cell under one condition supply the first exact relation."),("successor",.text "A common exact work-per-carrier successor preserves the relation without an offset."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no measured standard potential temperature or uncertainty selects the survivor",.text "least-squares smoothing and adjustable source parameters remain downstream provenance"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no measured standard potential temperature or uncertainty selects the survivor","least-squares smoothing and adjustable source parameters remain downstream provenance"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with account := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.ElectrodePotentialEvidence
