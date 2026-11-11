import SFT.Physics.AtomicBoundaryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.AtomicBoundaryEvidence
open SFT.Host.Canonical AtomicBoundaryGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "charge",.text (chargeName c.charge)],.array [.text "coupling",.text (couplingName c.coupling)],.array [.text "ceiling",.text (ceilingName c.ceiling)],.array [.text "endpoint",.text (endpointName c.endpoint)],.array [.text "lower",.text (lowerName c.lower)],.array [.text "upper",.text (upperName c.upper)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "target",.text (targetName c.target)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "charge"),("question",.text "What identifies an atomic coordinate?"),("choices",.array [.array [.text "unbound-number",.text "An unbound number has no element identity."],.array [.text "positive-held-charge-count",.text "Atomic number is a positive count of held source charges."]])],.object [("key",.text "coupling"),("question",.text "How is charge compared with the field scale?"),("choices",.array [.array [.text "fitted-binding-equation",.text "A fitted equation imports the endpoint."],.array [.text "charge-over-sealed-inverse-ratio",.text "Normalization by the sealed inverse ratio gives the exact binding fraction."]])],.object [("key",.text "ceiling"),("question",.text "What bounds a bound part?"),("choices",.array [.array [.text "external-critical-charge",.text "An external critical charge is target input."],.array [.text "complete-One-ceiling",.text "A bound part cannot exceed its complete One carrier."]])],.object [("key",.text "endpoint"),("question",.text "How is the last coordinate obtained?"),("choices",.array [.array [.text "bounded-neighborhood-walk",.text "A chosen search interval does not close all successors."],.array [.text "greatest-whole-division-certificate",.text "Exact quotient/remainder order gives the unique greatest whole not exceeding the ratio."]])],.object [("key",.text "lower"),("question",.text "Is the proposed endpoint admissible?"),("choices",.array [.array [.text "endpoint-label-only",.text "A label has no inequality witness."],.array [.text "exact-lower-inequality",.text "The endpoint whole is no greater than the sealed ratio."]])],.object [("key",.text "upper"),("question",.text "Are all later coordinates excluded?"),("choices",.array [.array [.text "single-next-value-check-only",.text "One check without order closure does not exclude later values."],.array [.text "successor-above-plus-order",.text "The endpoint successor is above the ratio and every later positive successor is greater still."]])],.object [("key",.text "generality"),("question",.text "Does the proof depend on a finite scan?"),("choices",.array [.array [.text "finite-coordinate-census",.text "A finite census leaves later coordinates open."],.array [.text "depth-independent-greatest-whole-law",.text "Euclidean quotient/remainder and positive order close every successor."]])],.object [("key",.text "target"),("question",.text "May the observed table select the endpoint?"),("choices",.array [.array [.text "observed-elements-visible",.text "That would turn an observation boundary into a law."],.array [.text "observations-inaccessible-until-seal",.text "The exact endpoint seals as a standing prediction."]])],.object [("key",.text "extension"),("question",.text "May nuclear size move the structural boundary?"),("choices",.array [.array [.text "extra-size-parameter",.text "A size correction is a different, parameterized model."],.array [.text "no-extra-rule",.text "This claim is exactly the registered point-carrier One-ceiling boundary."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-ATOMIC-EXISTENCE-BOUNDARY-001"
  title := "Exact atomic existence boundary"
  branch := "physics"
  statement := "A neutral atomic coordinate remains structurally admissible only while its positive whole charge does not exceed the exact inverse fine-structure Fold ratio. The unique greatest whole below that sealed ratio is 137, with 137 below and its successor 138 above the boundary."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001", "SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001", "SFT-PHYS-MATTER-CONSERVED-LABELS-001", "SFT-CHEM-ELEM-ELEMENT-001", "SFT-CHEM-ELEM-ATOMIC-NUMBER-001", "SFT-CHEM-ELEM-PERIODIC-ORDER-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-ORDER-LATTICE-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-ATOMIC-EXISTENCE-BOUNDARY-001",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-ATOMIC-EXISTENCE-BOUNDARY-001",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [AtomicBoundaryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity AtomicBoundaryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.AtomicBoundaryEvidence
