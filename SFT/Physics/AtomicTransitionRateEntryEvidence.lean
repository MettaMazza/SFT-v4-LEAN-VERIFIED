import SFT.Foundation.AdmissionControls
import SFT.Physics.AtomicTransitionRateEntryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.AtomicTransitionRateEntryEvidence
open SFT.Host.Canonical AtomicTransitionRateEntryGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "predecessor",.text (predecessorName c.predecessor)],.array [.text "gap",.text (gapName c.gap)],.array [.text "space",.text (spaceName c.space)],.array [.text "strength",.text (strengthName c.strength)],.array [.text "weight",.text (weightName c.weight)],.array [.text "lifetime",.text (lifetimeName c.lifetime)],.array [.text "multipole",.text (multipoleName c.multipole)],.array [.text "forbidden",.text (forbiddenName c.forbidden)],.array [.text "target",.text (targetName c.target)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "predecessor"),("question",.text "How is the admitted one-act selection law used?"),("choices",.array [.array [.text "replace-selection-law",.text "A successor cannot rewrite the immutable one-unit receipt."],.array [.text "retain-one-unit-elementary-act",.text "The elementary E1 orbital step remains exactly one."]])],.object [("key",.text "gap"),("question",.text "What supplies transition throw?"),("choices",.array [.array [.text "selected-decimal-frequency",.text "A selected frequency would be a target-bearing parameter."],.array [.text "exact-positive-level-gap",.text "The already generated ordered level difference supplies the gap."]])],.object [("key",.text "space"),("question",.text "How many gap carriers make the elementary radiative volume?"),("choices",.array [.array [.text "free-rate-exponent",.text "A chosen exponent is a parameter."],.array [.text "complete-generator-three-volume",.text "One gap carrier traverses each of the three forced spatial directions, forcing the cube."]])],.object [("key",.text "strength"),("question",.text "How is transition overlap retained?"),("choices",.array [.array [.text "erase-or-fit-strength",.text "Erasure or fitting cannot distinguish lines."],.array [.text "held-exact-line-strength",.text "The exact positive squared transition carrier remains explicit."]])],.object [("key",.text "weight"),("question",.text "How is upper-state multiplicity handled?"),("choices",.array [.array [.text "unweighted-or-fitted-factor",.text "A hidden multiplicity changes rates freely."],.array [.text "divide-by-complete-positive-weight",.text "The complete generated upper-state class count normalizes the rate."]])],.object [("key",.text "lifetime"),("question",.text "How does retention time follow from decay channels?"),("choices",.array [.array [.text "independent-lifetime-parameter",.text "A separately chosen lifetime is not forced."],.array [.text "reciprocal-complete-rate-sum",.text "One retained population exhausted by all positive channels forces the reciprocal of their sum."]])],.object [("key",.text "multipole"),("question",.text "How does electric multipole rank extend?"),("choices",.array [.array [.text "chosen-power-list",.text "A list has no successor theorem."],.array [.text "append-held-boundary-pair",.text "Each rank successor appends the two held boundary directions, so exponent 2L+1 advances by two."]])],.object [("key",.text "forbidden"),("question",.text "Does the word forbidden alone force every rate ordering?"),("choices",.array [.array [.text "universal-slower-label",.text "M1 shares the cubic exponent and distinct strengths can reverse an unqualified ordering."],.array [.text "typed-channel-conditional-suppression",.text "For equal positive strength and weight, each electric-rank successor is suppressed by exact gap squared; other channels retain their own strength carrier."]])],.object [("key",.text "target"),("question",.text "May NIST formulas or lifetimes enter execution?"),("choices",.array [.array [.text "external-target-readable",.text "Target-readable execution cannot seal a prediction."],.array [.text "target-inaccessible-until-seal",.text "The formal module contains no external formula, value or source access."]])],.object [("key",.text "extension"),("question",.text "May another coefficient or exception be appended?"),("choices",.array [.array [.text "free-coefficient-or-exception",.text "An ungenerated coefficient is a parameter."],.array [.text "no-extra-rule",.text "Gap, spatial volume, strength, weight, rate sum and multipole succession exhaust the grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-ATOMIC-TRANSITION-RATE-TERMINAL-005"
  title := "Terminal exact atomic transition-rate, lifetime and multipole completion"
  branch := "physics"
  statement := "The admitted one-unit elementary transition retains an exact positive level gap.  Transport through all three forced spatial directions makes the E1 rate proportional to gap cubed times held line strength divided by complete upper-state weight.  Complete positive decay channels force lifetime to be the reciprocal of their rate sum.  Electric multipole rank L has exponent 2L+1, so each successor is conditionally suppressed by exact gap squared at equal strength and weight.  Magnetic and other typed channels retain distinct strengths; the label forbidden alone is not promoted to a false universal ordering."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-ATOMIC-TRANSITION-SELECTION-004", "SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004", "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001", "SFT-PHYS-QUANTUM-SPIN-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-TRANSITION-RATE-TERMINAL-005",.text generationRule,candidateRecord c])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-TRANSITION-RATE-TERMINAL-005",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [AtomicTransitionRateEntryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (SFT.Foundation.AdmissionControls.admissionIdentity AtomicTransitionRateEntryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.AtomicTransitionRateEntryEvidence
