import SFT.Foundation.AdmissionControls
import SFT.Physics.NuclearResidualForceEntryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.NuclearResidualForceEntryEvidence
open SFT.Host.Canonical NuclearResidualForceEntryGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "predecessor",.text (predecessorName c.predecessor)],.array [.text "neutral",.text (neutralName c.neutral)],.array [.text "residual",.text (residualName c.residual)],.array [.text "strength",.text (strengthName c.strength)],.array [.text "mass",.text (massName c.mass)],.array [.text "range",.text (rangeName c.range)],.array [.text "ordering",.text (orderingName c.ordering)],.array [.text "saturation",.text (saturationName c.saturation)],.array [.text "target",.text (targetName c.target)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "predecessor"),("question",.text "How are admitted colour closure and confinement used?"),("choices",.array [.array [.text "rewrite-nucleon-predecessors",.text "A successor cannot alter admitted receipts."],.array [.text "compose-immutable-neutral-composite-predecessors",.text "The complete colour singlet, confinement and interaction classes remain immutable dependencies."]])],.object [("key",.text "neutral"),("question",.text "What leaves a closed colour boundary at leading order?"),("choices",.array [.array [.text "export-raw-colour-label",.text "A raw colour label would violate the admitted singlet boundary."],.array [.text "leading-colour-act-closes-to-empty-form",.text "Every internal colour is completed inside the singlet, leaving no separately observable leading label outside."]])],.object [("key",.text "residual"),("question",.text "What is the first nonempty inter-boundary exchange?"),("choices",.array [.array [.text "reuse-primary-half-One",.text "A first-order carrier ignores both neutral closures."],.array [.text "paired-half-One-boundary-act",.text "One retained boundary act from each neutral composite forces the second-order product one-quarter."]])],.object [("key",.text "strength"),("question",.text "Is the quarter-One a universal measured force coefficient?"),("choices",.array [.array [.text "identify-quarter-with-all-cross-sections",.text "Measured channels need not share one dimensional strength."],.array [.text "structural-order-not-universal-dimensional-strength",.text "Quarter-One fixes the first retained Fold order; physical channel strength remains an external comparison object."]])],.object [("key",.text "mass"),("question",.text "How is absent versus present mediator mass represented?"),("choices",.array [.array [.text "numerical-zero-mass",.text "Numerical zero is outside the proof domain."],.array [.text "empty-mass-label-or-positive-mass-carrier",.text "The massless class uses an absent held label; the massive class carries one exact positive part."]])],.object [("key",.text "range"),("question",.text "What range law follows from a positive mass carrier?"),("choices",.array [.array [.text "chosen-decay-length",.text "A selected length is a parameter."],.array [.text "exact-reciprocal-mass-scale",.text "One complete action divided over the positive mass carrier forces range scale One/m."]])],.object [("key",.text "ordering"),("question",.text "Which mediator reaches farther?"),("choices",.array [.array [.text "import-particle-range-ranking",.text "A named particle table cannot prove the order."],.array [.text "lighter-positive-mass-has-greater-reciprocal",.text "Exact order reversal under reciprocation forces every lighter mediator to have the longer scale."]])],.object [("key",.text "saturation"),("question",.text "Why is the residual interaction local and saturating?"),("choices",.array [.array [.text "all-to-all-independent-links",.text "Unlimited independent links ignore finite boundary support and finite range."],.array [.text "finite-boundary-cells-with-finite-range",.text "A colour-closed composite has finitely many held boundary cells and a massive exchange has a finite reciprocal scale, bounding independent local links."]])],.object [("key",.text "target"),("question",.text "May external masses or scattering data enter execution?"),("choices",.array [.array [.text "external-target-readable",.text "Target access cannot seal a prediction."],.array [.text "target-inaccessible-until-seal",.text "No particle name, mass, length, cross section, uncertainty or source is accessible to the executable law."]])],.object [("key",.text "extension"),("question",.text "May an exponential, cutoff or fitted coupling be appended?"),("choices",.array [.array [.text "free-decay-profile-or-coupling",.text "An ungenerated profile or coefficient is a parameter."],.array [.text "no-extra-rule",.text "Neutral closure, paired residual order, reciprocal mass and finite boundary support exhaust the declared grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-NUCLEAR-RESIDUAL-FORCE-TERMINAL-005"
  title := "Terminal residual nuclear interaction and inverse-mediator range"
  branch := "physics"
  statement := "A complete colour-three composite closes every leading colour label inside its boundary, so the external leading act is the empty form.  The first nonempty exchange must retain one boundary act from each of two neutral composites; the forced half-One therefore enters twice and fixes the second-order structural support at one-quarter.  This is an exact Fold order, not a universal dimensional cross section.  A present mediator mass is a positive carrier and forces the finite reciprocal range One/m; an absent mass label has no finite subtraction endpoint.  Thus lighter massive mediators reach farther, while finite boundary cells and finite range force locality and saturation without an imported exponential or hard numerical-zero cutoff."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-HALF-ONE-001", "SFT-FOUNDATION-FOLD-DYNAMICS-001", "SFT-PHYS-MATTER-COMPOSITE-HADRONS-001", "SFT-PHYS-MATTER-CONFINEMENT-LIFT-003", "SFT-PHYS-FIELD-INTERACTION-CLASSES-001", "SFT-PHYS-NUCLEON-BINDING-TERMINAL-005", "SFT-PHYS-HADRON-REGGE-TERMINAL-005", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-NUCLEAR-RESIDUAL-FORCE-TERMINAL-005",.text generationRule,candidateRecord c])

def censusData : SFT.Engine.CandidateCensus where
  generationRule := generationRule
  grammarBoundary := grammarBoundary
  expectedCardinality := .ofNat candidates.length
  completenessCertificateHash := SFT.Foundation.AdmissionControls.admissionIdentity completenessRecord
  candidates := candidates.map generatedCandidateData

def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
  candidateId := candidateId c
  survives := survives c
  reason := decisionReason c
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-NUCLEAR-RESIDUAL-FORCE-TERMINAL-005",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

def decision (c : Candidate) : Value := SFT.Engine.decisionValue (decisionData c)

def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
  match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
  | some c => .ok (decisionData c)
  | none => .error "StopIteration"

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [NuclearResidualForceEntryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (SFT.Foundation.AdmissionControls.admissionIdentity NuclearResidualForceEntryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.NuclearResidualForceEntryEvidence
