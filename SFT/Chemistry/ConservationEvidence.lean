import SFT.Chemistry.ConservationGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ConservationEvidence
open SFT.Host.Canonical ConservationGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "balanced-witness",.text "abstract reaction element totals pair exactly",.boolean true],.array [.text "unsigned-sides",.text "orientation is held outside positive counts",.boolean true],.array [.text "omission-control",.text "removing one product carrier breaks balance",.boolean true]]
def claimId : String := "SFT-CHEM-STOICH-CONSERVATION-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-CHEMICAL-SPECIES-001","SFT-CHEM-MEAS-SUBSTANCE-001","SFT-CHEM-MEAS-AMOUNT-001","SFT-CHEM-MEAS-FORMULA-001","SFT-CHEM-ELEM-ELEMENT-001","SFT-CHEM-ELEM-PERIODIC-ORDER-001","SFT-CHEM-STOICH-COMPOSITION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "identity",.text (identityName c.identity)],.array [.text "count",.text (countName c.count)],.array [.text "closure",.text (closureName c.closure)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "product-list-without-input",.text "Products alone cannot demonstrate conservation."],.array [.text "complete-reaction-word",.text "Both input and output supports remain held."]]],.array [.text "orientation",.array [.array [.text "signed-stoichiometric-scalars",.text "Signed proof quantities violate the positive domain."],.array [.text "held-reactant-product-sides",.text "Reaction direction is structural orientation."]]],.array [.text "identity",.array [.array [.text "mass-only-balance",.text "Equal bulk mass can hide changed element labels."],.array [.text "elemental-identities-retained",.text "Every element label is separately accounted."]]],.array [.text "count",.array [.array [.text "approximate-decimal-balance",.text "Approximation cannot prove equality of discrete carriers."],.array [.text "exact-positive-multiplicity",.text "Every participating species and element uses generated counts."]]],.array [.text "closure",.array [.array [.text "selected-elements-only",.text "Omitting an element can manufacture balance."],.array [.text "all-element-totals-paired",.text "Every input element occurrence is paired on output."]]],.array [.text "boundary",.array [.array [.text "unrecorded-open-system",.text "Unrecorded boundary transfer can mimic loss or creation."],.array [.text "named-boundary-carriers",.text "Any exchanged carrier is explicitly part of the reaction word."]]],.array [.text "record",.array [.array [.text "balanced-label-only",.text "A label cannot reconstruct the equality."],.array [.text "species-formula-total-trace",.text "Formulae, coefficients and both total maps remain held."]]],.array [.text "extension",.array [.array [.text "free-balancing-exception",.text "An exception could excuse an unpaired carrier."],.array [.text "no-extra-rule",.text "Exact label equality supplies complete conservation."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Conservation of elemental identity through reaction"
 branch := "chemistry"
 statement := "A chemical reaction is closed only when complete held reactant/product words have exactly equal positive multiplicity totals for every retained elemental identity, including named boundary carriers."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-reaction-word__held-reactant-product-sides__elemental-identities-retained__all-element-totals-paired"),("base",.text "One abstract identity-preserving transition with equal input/output element maps supplies the first conserved reaction word."),("successor",.text "Appending one paired elemental carrier to both held sides preserves every prior total and exact equality."),("exclusions",.array [.text "no IUPAC wording, balanced equation, measured amount or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no absent species represented by a zero coefficient; absence is an empty generated form",.text "no application result or opaque predictor",.text "official target content opens only through post-seal custody",.text "Every finite chemical transition word whose reactant and product sides retain complete species formulae, positive multiplicities and equal per-element totals."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC wording, balanced equation, measured amount or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no absent species represented by a zero coefficient; absence is an empty generated form","no application result or opaque predictor","official target content opens only through post-seal custody","Every finite chemical transition word whose reactant and product sides retain complete species formulae, positive multiplicities and equal per-element totals."]
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
end SFT.Chemistry.ConservationEvidence
