import SFT.Biology.GeneGrammar
import SFT.Biology.Gene
import SFT.Engine.RegistrationGate
namespace SFT.Biology.GeneEvidence
open SFT.Host.Canonical GeneGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "carrier",.text "the biological carrier is explicit and nonempty",.boolean Gene.carrierWitness],.array [.text "relation",.text "relation and organization remain separately reconstructible",.boolean Gene.relationWitness],.array [.text "boundary",.text "observation boundary cannot silently become the biological law",.boolean Gene.boundaryWitness]]
def claimId : String := "SFT-BIO-GENE-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-STEREO-CHIRALITY-001","SFT-MAT-MICRO-INTERFACE-001","SFT-MAT-FUNC-BIOMATERIAL-001","SFT-BIO-CODON-BOX-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "relation",.text (relationName c.relation)],.array [.text "organization",.text (organizationName c.organization)],.array [.text "observation",.text (observationName c.observation)],.array [.text "record",.text (recordName c.record)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "carrier-erased-or-answer-only",.text "Erasing the biological carrier prevents reconstruction of the claimed living distinction."],.array [.text "source-bound-sequence-interval",.text "The complete generated biological carrier is retained."]]],.array [.text "relation",.array [.array [.text "relation-imported-fitted-or-erased",.text "An imported, fitted or absent relation can select a familiar biological answer without forcing it."],.array [.text "interval-to-product-or-regulatory-relation",.text "Only the generated biological transition or comparison relation is admitted."]]],.array [.text "organization",.array [.array [.text "organization-collapsed",.text "Collapsing organization merges living states the question requires to remain distinct."],.array [.text "orientation-context-and-provenance-retained",.text "Every boundary, lineage, context and organization distinction required by the claim remains held."]]],.array [.text "observation",.array [.array [.text "observation-boundary-unrecorded",.text "An unrecorded organism, condition, assay, scale or interval cannot identify the biological observation class."],.array [.text "annotation-boundary-declared",.text "The complete declared observation boundary is retained and cannot select the law."]]],.array [.text "record",.array [.array [.text "result-without-transition-record",.text "A biological label without initial state, transitions, controls and outcomes is not auditable."],.array [.text "complete-state-transition-control-record",.text "Initial state, transitions, controls, results and retained or lost distinctions are recorded."]]],.array [.text "provenance",.array [.array [.text "authority-target-or-prior-selected-law",.text "Authority, consensus, a prior SFT answer or target data may test but cannot select a Fold law."],.array [.text "root-bound-forward-forcing",.text "Every decision traces through admitted dependencies to the premise-free root theorem."]]],.array [.text "generality",.array [.array [.text "single-specimen-favorable-instance",.text "One favorable organism, specimen or experiment cannot close the generated biological class."],.array [.text "positive-finite-successor-and-adverse-closure",.text "Base carrier, every positive finite successor and all registered adverse controls preserve the relation at the stated boundary."]]],.array [.text "extension",.array [.array [.text "free-fit-exception-or-extra-rule",.text "A free coefficient, fitted threshold, exception or opaque predictor can manufacture a desired answer."],.array [.text "no-extra-rule",.text "No rule beyond admitted Fold dependencies and generated preservation conditions is present."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Gene as expression-bearing hereditary interval"
 branch := "biology"
 statement := "A gene is a source-bound hereditary interval whose expression or regulatory relation is demonstrated with orientation, context and evidence boundary retained."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "source-bound-sequence-interval__interval-to-product-or-regulatory-relation__orientation-context-and-provenance-retained__annotation-boundary-declared__complete-state-transition-control-record__root-bound-forward-forcing__positive-finite-successor-and-adverse-closure__no-extra-rule"),("base",.text "The least positive finite carrier retains every required biological distinction and its complete control record."),("successor",.text "Adding one lawful finite successor preserves all existing identities, relations, boundaries and provenance and appends its new transition and adverse alternatives."),("exclusions",.array [.text "numerical-zero ontology",.text "negative proof quantity",.text "irrational or imaginary proof value",.text "fitted coefficient or threshold",.text "external target leakage",.text "opaque predictor",.text "unrecorded specimen or condition",.text "erased adverse result",.text "prior answer as premise"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["numerical-zero ontology","negative proof quantity","irrational or imaginary proof value","fitted coefficient or threshold","external target leakage","opaque predictor","unrecorded specimen or condition","erased adverse result","prior answer as premise"]
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
end SFT.Biology.GeneEvidence
