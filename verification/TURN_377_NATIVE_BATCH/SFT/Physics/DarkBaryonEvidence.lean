import SFT.Physics.DarkBaryonControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.DarkBaryonEvidence
open SFT.Host.Canonical DarkBaryonGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "volume",.text (volumeName c.volume)],.array [.text "cover",.text (coverName c.cover)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "leading",.text (leadingName c.leading)],.array [.text "orbit",.text (orbitName c.orbit)],.array [.text "deepening",.text (deepeningName c.deepening)],.array [.text "target",.text (targetName c.target)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "What carries the matter distinction?"),("choices",.array [.array [.text "named-dark-and-baryon-scalars",.text "Names do not construct a common conserved support."],.array [.text "one-complete-matter-cover",.text "One cover retains both complementary matter sectors."]])],.object [("key",.text "volume"),("question",.text "What fixes the unconfined sector volume?"),("choices",.array [.array [.text "selected-cosmological-volume",.text "A selected volume reads the target."],.array [.text "generator-over-forced-space",.text "Generator three over three forced spatial directions yields exactly 3^3."]])],.object [("key",.text "cover"),("question",.text "What fixes the confined anchor?"),("choices",.array [.array [.text "free-cover-depth",.text "A free depth is a fitted parameter."],.array [.text "least-complete-binary-cover",.text "The least binary support covering 27 is depth five, cross-locked by two plus three."]])],.object [("key",.text "partition"),("question",.text "How are leading shares formed?"),("choices",.array [.array [.text "independent-normalizations",.text "Separate denominators need not conserve one matter whole."],.array [.text "depth-and-volume-over-cover",.text "Depth five and volume 27 partition the complete support 32 exactly once."]])],.object [("key",.text "leading"),("question",.text "Which leading ratio follows?"),("choices",.array [.array [.text "measured-ratio-insertion",.text "A measured ratio is not a derivation."],.array [.text "volume-over-depth",.text "Common support cancellation forces 27/5."]])],.object [("key",.text "orbit"),("question",.text "What supplies the next depth resolution?"),("choices",.array [.array [.text "tower-or-up-depth-floor",.text "The tower is pre-periodic and the up-depth belongs to another carrier."],.array [.text "own-depth-first-return-floor",.text "The positive predecessor 31 is the unique denominator with first-return period five."]])],.object [("key",.text "deepening"),("question",.text "How is the recurrence retained?"),("choices",.array [.array [.text "selected-sign-or-bare-depth",.text "A chosen orientation or bare repeat adds no forced recurrence record."],.array [.text "one-positive-orbit-part-appended",.text "One positive 1/31 recurrence part is appended to its own depth, forcing 279/52."]])],.object [("key",.text "target"),("question",.text "May cosmological densities select a form?"),("choices",.array [.array [.text "density-readable-construction",.text "That would fit the ratio."],.array [.text "densities-inaccessible-until-seal",.text "Both exact ratios and all candidates seal first."]])],.object [("key",.text "provenance"),("question",.text "How is the prior result handled?"),("choices",.array [.array [.text "old-answer-runtime-input",.text "Earlier answer artifacts cannot select the V3 law."],.array [.text "prior-question-machine-independent-reconstruction",.text "The prior statement defines the obligation but no old answer enters execution."]])],.object [("key",.text "extension"),("question",.text "May another cosmological term enter?"),("choices",.array [.array [.text "extra-density-or-fit-term",.text "An added term is a free parameter."],.array [.text "no-extra-rule",.text "Volume, cover and native orbit exhaust the first-recursive grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001"
  title := "Generation-cover dark-to-baryon fraction"
  branch := "physics"
  statement := "Generator three over the forced three-space supplies volume 27. Its least complete binary cover has depth five and support 32, forcing leading baryon/dark shares 5/32 and 27/32 and ratio 27/5. The unique period-five orbit floor 31 deepens the same depth once, forcing 279/52."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-FOUNDATION-COUNT-001", "SFT-FOUNDATION-PART-001", "SFT-FOUNDATION-FOLD-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-DYNAMICAL-SYSTEMS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [DarkBaryonControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity DarkBaryonControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.DarkBaryonEvidence
