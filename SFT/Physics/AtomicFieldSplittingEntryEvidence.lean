import SFT.Foundation.AdmissionControls
import SFT.Physics.AtomicFieldSplittingEntryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.AtomicFieldSplittingEntryEvidence
open SFT.Host.Canonical AtomicFieldSplittingEntryGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "predecessor",.text (predecessorName c.predecessor)],.array [.text "multiplicity",.text (multiplicityName c.multiplicity)],.array [.text "direction",.text (directionName c.direction)],.array [.text "magnetic",.text (magneticName c.magnetic)],.array [.text "spacing",.text (spacingName c.spacing)],.array [.text "electric-degenerate",.text (electricDegenerateName c.electricDegenerate)],.array [.text "electric-nondegenerate",.text (electricNondegenerateName c.electricNondegenerate)],.array [.text "order",.text (orderName c.order)],.array [.text "target",.text (targetName c.target)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "predecessor"),("question",.text "How are existing magnetic/electric orientation laws used?"),("choices",.array [.array [.text "replace-field-predecessors",.text "A successor cannot rewrite admitted receipts."],.array [.text "compose-immutable-field-predecessors",.text "Magnetic handedness and electric displacement remain exact dependencies."]])],.object [("key",.text "multiplicity"),("question",.text "How is a J-level orientation support counted?"),("choices",.array [.array [.text "selected-line-count",.text "A chosen multiplet width imports the answer."],.array [.text "complete-held-orientation-successor",.text "All doubled angular positions plus the retained successor class give exactly 2J+1."]])],.object [("key",.text "direction"),("question",.text "How are opposing shifts represented?"),("choices",.array [.array [.text "signed-energy-scalar",.text "Negative proof scalars violate the domain."],.array [.text "held-side-label-and-positive-distance",.text "Side is a label; displacement from the empty central class is a positive count."]])],.object [("key",.text "magnetic"),("question",.text "How does weak magnetic response compose?"),("choices",.array [.array [.text "chosen-field-polynomial",.text "A chosen response polynomial is a parameter."],.array [.text "one-field-act-per-held-orientation",.text "One field act on one held orientation forces a linear magnitude g*m*B."]])],.object [("key",.text "spacing"),("question",.text "What separates adjacent Zeeman classes?"),("choices",.array [.array [.text "unequal-free-spacing",.text "Free spacings destroy the generated orientation order."],.array [.text "one-common-positive-field-step",.text "Adjacent positive orientation distances differ by one act, so their magnitude spacing is the common g*B carrier."]])],.object [("key",.text "electric-degenerate"),("question",.text "What survives in a degenerate electric support?"),("choices",.array [.array [.text "erase-first-displacement",.text "Erasure loses the held cross-state channel."],.array [.text "held-first-order-dipole-channel",.text "Degenerate partners retain the first displacement act, forcing a linear Stark magnitude."]])],.object [("key",.text "electric-nondegenerate"),("question",.text "What survives without that partner?"),("choices",.array [.array [.text "free-first-order-shift",.text "A first-order scalar without a retained partner is ungenerated."],.array [.text "paired-first-act-closes-then-square",.text "The opposed first acts close to the empty form; the first retained magnitude uses two field acts and is quadratic."]])],.object [("key",.text "order"),("question",.text "Can linear and quadratic Stark laws be conflated?"),("choices",.array [.array [.text "universal-single-order",.text "One order erases the degeneracy discriminator."],.array [.text "degeneracy-typed-response-order",.text "The retained support class uniquely selects first or second positive order."]])],.object [("key",.text "target"),("question",.text "May external splitting data enter execution?"),("choices",.array [.array [.text "external-target-readable",.text "Target-readable execution cannot seal a prediction."],.array [.text "target-inaccessible-until-seal",.text "No external coefficient, splitting or source is accessible to the formal module."]])],.object [("key",.text "extension"),("question",.text "May another field coefficient or response rule be added?"),("choices",.array [.array [.text "free-coefficient-or-rule",.text "An ungenerated response is a parameter."],.array [.text "no-extra-rule",.text "Orientation, side, field act and degeneracy exhaust the declared grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-ATOMIC-FIELD-SPLITTING-TERMINAL-005"
  title := "Terminal exact atomic Zeeman and Stark field-splitting completion"
  branch := "physics"
  statement := "Complete held angular support forces 2J+1 magnetic sublevels.  Opposing directions remain labels and every displacement magnitude is positive; one weak-field act therefore forces linear Zeeman shifts g*m*B with equal adjacent spacing g*B.  In electric response a retained degenerate partner preserves the first dipole act and forces a linear Stark shift.  Without that partner the opposed first acts close to the empty form and the first retained response uses two field acts, forcing a quadratic shift."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-ATOMIC-TRANSITION-SELECTION-004", "SFT-PHYS-ATOMIC-SHELL-PERIODICITY-TERMINAL-005", "SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003", "SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001", "SFT-PHYS-QUANTUM-SPIN-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-ORDER-LATTICE-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-FIELD-SPLITTING-TERMINAL-005",.text generationRule,candidateRecord c])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-FIELD-SPLITTING-TERMINAL-005",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [AtomicFieldSplittingEntryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (SFT.Foundation.AdmissionControls.admissionIdentity AtomicFieldSplittingEntryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.AtomicFieldSplittingEntryEvidence
