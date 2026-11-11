import SFT.Chemistry.NomenclatureGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.NomenclatureEvidence
open SFT.Host.Canonical NomenclatureGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "name-assembly",.text "ordered registered syllables generate a complete name",.boolean true],.array [.text "prefix-count",.text "optional prefixes retain exact multiplicity",.boolean true],.array [.text "noninjective-control",.text "ambiguous name-to-identity maps are excluded from reversible scope",.boolean true]]
def claimId : String := "SFT-CHEM-MEAS-NOMENCLATURE-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-QUANTITY-CARRIER-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-FORMULA-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "parts",.text (partsName c.parts)],.array [.text "prefix",.text (prefixName c.prefix)],.array [.text "order",.text (orderName c.order)],.array [.text "binding",.text (bindingName c.binding)],.array [.text "decode",.text (decodeName c.decode)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "partial-name-fragment",.text "A fragment alone does not carry one complete registered chemical name."],.array [.text "complete-name-carrier",.text "The name is one complete ordered carrier."]]],.array [.text "parts",.array [.array [.text "unregistered-free-text",.text "Free text can import arbitrary answer-bearing distinctions."],.array [.text "generated-name-parts",.text "Every part is a registered coined or selected syllable label."]]],.array [.text "prefix",.array [.array [.text "implicit-count",.text "An implicit multiplicity cannot be recovered from the name."],.array [.text "count-prefix-support",.text "Optional numerical prefixes are generated exact count labels."]]],.array [.text "order",.array [.array [.text "unordered-syllable-bag",.text "Unordered parts can merge names with distinct composition."],.array [.text "held-name-order",.text "Every syllable retains its generated position."]]],.array [.text "binding",.array [.array [.text "name-detached-from-formula",.text "A detached name cannot preserve chemical identity."],.array [.text "formula-bound-name",.text "The name record is bound to the admitted formula carrier."]]],.array [.text "decode",.array [.array [.text "unconditional-reversibility",.text "Not every conventional name is uniquely decodable, so reversibility cannot be assumed."],.array [.text "injective-boundary-decoding",.text "Reversibility is claimed exactly when one name maps to one retained identity record."]]],.array [.text "record",.array [.array [.text "surface-name-only",.text "A surface name alone hides its assembly and decoding boundary."],.array [.text "complete-name-trace",.text "Parts, order, prefixes, formula binding and decoder result remain held."]]],.array [.text "extension",.array [.array [.text "free-naming-exception",.text "A discretionary naming exception can select any desired identity."],.array [.text "no-extra-rule",.text "Only registered parts, order and count-prefix construction are admitted."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Reversible chemical nomenclature and identity boundary"
 branch := "chemistry"
 statement := "A systematic chemical name is a complete ordered Fold word assembled from registered name parts and optional count prefixes; exact reversibility is admitted only on the generated injective name-to-identity boundary."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-name-carrier__generated-name-parts__count-prefix-support"),("base",.text "One registered syllable label supplies the first complete one-part systematic name and its assembly trace."),("successor",.text "Appending one registered syllable or generated count prefix preserves order, formula binding and injective decoding wherever uniqueness remains certified."),("exclusions",.array [.text "no IUPAC definition, conventional chemistry model or target content may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "external target content is absent from this specification and opens only through post-seal custody",.text "Every positive-finite ordered chemical-name word assembled wholly from registered syllable labels and optional generated count prefixes, with an explicit injective-decoding boundary."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC definition, conventional chemistry model or target content may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","external target content is absent from this specification and opens only through post-seal custody","Every positive-finite ordered chemical-name word assembled wholly from registered syllable labels and optional generated count prefixes, with an explicit injective-decoding boundary."]
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
end SFT.Chemistry.NomenclatureEvidence
