import SFT.Physics.CosmoCompleteBudgetControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.CosmoCompleteBudgetEvidence
open SFT.Host.Canonical CosmoCompleteBudgetGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "pinning",.text (pinningName c.pinning)],.array [.text "free",.text (freeName c.free)],.array [.text "global",.text (globalName c.global)],.array [.text "internal",.text (internalName c.internal)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "closure",.text (closureName c.closure)],.array [.text "target",.text (targetName c.target)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "support"),("question",.text "What carries the budget?"),("choices",.array [.array [.text "selected-density-denominator",.text "A selected denominator fits observations."],.array [.text "least-generator-volume-binary-cover",.text "The least complete binary cover of generator volume 27 fixes depth five and support 32."]])],.object [("key",.text "boundary"),("question",.text "What is retained at each cover depth?"),("choices",.array [.array [.text "free-pinned-count",.text "A free count is a parameter."],.array [.text "complete-two-state-boundary-pair",.text "Boundary rank two supplies exactly one retained pair per depth."]])],.object [("key",.text "pinning"),("question",.text "Which states form the matter carrier?"),("choices",.array [.array [.text "named-matter-share",.text "A name does not construct a share."],.array [.text "all-depth-boundary-pairs",.text "Two pinned states at each of five depths force ten matter states."]])],.object [("key",.text "free"),("question",.text "Which states form the vacuum carrier?"),("choices",.array [.array [.text "selected-vacuum-share",.text "A selected share reads the target."],.array [.text "complete-unpinned-complement",.text "The remaining twenty-two states are the complete free complement within support 32."]])],.object [("key",.text "global"),("question",.text "Which exact global shares follow?"),("choices",.array [.array [.text "leading-one-third-two-thirds-only",.text "The earlier leading partition ignores the admitted depth-five boundary discriminator."],.array [.text "five-sixteenths-and-eleven-sixteenths",.text "Ten and twenty-two over 32 reduce exactly to 5/16 and 11/16."]])],.object [("key",.text "internal"),("question",.text "How is matter partitioned?"),("choices",.array [.array [.text "new-baryon-dark-parameter",.text "A new ratio is free."],.array [.text "admitted-five-to-twenty-seven-partition",.text "The upstream law fixes baryon/dark shares 5/32 and 27/32 within matter."]])],.object [("key",.text "composition"),("question",.text "How are absolute component shares formed?"),("choices",.array [.array [.text "independent-component-normalizations",.text "Independent denominators need not close."],.array [.text "global-matter-times-internal-shares",.text "Multiplying the global matter share by both complete internal shares forces 25/512 and 135/512."]])],.object [("key",.text "closure"),("question",.text "Does the full budget exhaust the One?"),("choices",.array [.array [.text "separate-rounded-total",.text "Rounded values cannot prove closure."],.array [.text "exact-four-part-One-closure",.text "Vacuum plus baryon plus cold dark is exactly the One, with baryon plus cold dark exactly matter."]])],.object [("key",.text "target"),("question",.text "May Planck values select the budget?"),("choices",.array [.array [.text "planck-budget-readable-before-seal",.text "That would fit four targets."],.array [.text "all-planck-rows-inaccessible-until-seal",.text "Every exact component and alternative seals before any external row opens."]])],.object [("key",.text "provenance"),("question",.text "How is the later V2 refinement handled?"),("choices",.array [.array [.text "erase-leading-law-or-mislabel-discovery",.text "The leading law and later observed refinement must both remain visible."],.array [.text "disclosed-successor-observational-reconstruction",.text "The earlier leading law is preserved while the later structural discriminator is independently rebuilt."]])],.object [("key",.text "extension"),("question",.text "May another density parameter enter?"),("choices",.array [.array [.text "extra-budget-rule",.text "An added rule is a free parameter."],.array [.text "no-extra-rule",.text "Cover, boundary and admitted internal partition exhaust the registered present-budget grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-COSMO-COMPLETE-BUDGET-001"
  title := "Depth-five Fold cosmic energy budget"
  branch := "physics"
  statement := "The least binary support covering the generator-three spatial volume has depth five and 32 states. The complete Fold boundary pair pins two states at each depth, forcing ten pinned matter states and twenty-two free vacuum states: matter 5/16 and vacuum 11/16. The independently reconstructed five-to-twenty-seven matter partition then forces baryon 25/512 and cold dark 135/512."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001", "SFT-PHYS-COSMO-SPATIAL-FLATNESS-001", "SFT-FOUNDATION-COUNT-001", "SFT-FOUNDATION-PART-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-COSMO-COMPLETE-BUDGET-001",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-COSMO-COMPLETE-BUDGET-001",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [CosmoCompleteBudgetControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity CosmoCompleteBudgetControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.CosmoCompleteBudgetEvidence
