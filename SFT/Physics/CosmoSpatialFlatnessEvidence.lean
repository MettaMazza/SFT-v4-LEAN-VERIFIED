import SFT.Physics.CosmoSpatialFlatnessControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.CosmoSpatialFlatnessEvidence
open SFT.Host.Canonical CosmoSpatialFlatnessGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "component",.text (componentName c.component)],.array [.text "normalization",.text (normalizationName c.normalization)],.array [.text "completeness",.text (completenessName c.completeness)],.array [.text "remainder",.text (remainderName c.remainder)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "refinement",.text (refinementName c.refinement)],.array [.text "scope",.text (scopeName c.scope)],.array [.text "target",.text (targetName c.target)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "What carries total cosmic support?"),("choices",.array [.array [.text "independent-component-totals",.text "Independent totals need not form one conserved whole."],.array [.text "one-common-total-carrier",.text "All normalized components are parts of the same One."]])],.object [("key",.text "component"),("question",.text "What is one component?"),("choices",.array [.array [.text "signed-or-unbound-density-number",.text "An unbound number is not a held part."],.array [.text "exact-positive-held-part",.text "Each present component is one exact positive part with retained identity."]])],.object [("key",.text "normalization"),("question",.text "How are parts compared?"),("choices",.array [.array [.text "separate-normalizations",.text "Separate normalizations cannot close jointly."],.array [.text "common-One-normalization",.text "Every component is referred to the complete common carrier exactly once."]])],.object [("key",.text "completeness"),("question",.text "What does a complete census mean?"),("choices",.array [.array [.text "selected-visible-components",.text "A selected list can leave an unregistered remainder."],.array [.text "every-generated-part-exhausts-One",.text "Completeness requires the exact part family to assemble to the One."]])],.object [("key",.text "remainder"),("question",.text "Is curvature another independent contribution?"),("choices",.array [.array [.text "extra-curvature-scalar",.text "An extra scalar after exhaustion double-counts support."],.array [.text "unassigned-part-remainder",.text "Curvature is the status of support left outside the complete partition."]])],.object [("key",.text "absence"),("question",.text "How is no remainder represented?"),("choices",.array [.array [.text "numerical-zero-curvature",.text "Numerical zero is not an SFT proof carrier."],.array [.text "empty-One-form",.text "Exhaustion leaves structural absence, represented by the empty One form."]])],.object [("key",.text "refinement"),("question",.text "What happens when one component is split?"),("choices",.array [.array [.text "epoch-specific-fraction-table",.text "A table has no general preservation law."],.array [.text "positive-parent-preserving-split",.text "Replacing one part by positive children that sum to it preserves total closure."]])],.object [("key",.text "scope"),("question",.text "Does closure depend on epoch?"),("choices",.array [.array [.text "single-observed-epoch",.text "One epoch cannot force persistence."],.array [.text "all-finite-repartitions",.text "The refinement induction preserves closure for every finite component redistribution."]])],.object [("key",.text "target"),("question",.text "May a measured curvature value select closure?"),("choices",.array [.array [.text "curvature-record-readable-before-seal",.text "That would import the desired result."],.array [.text "curvature-record-inaccessible-until-seal",.text "The absence result and complete grammar seal before the external record opens."]])],.object [("key",.text "provenance"),("question",.text "How is the known V1 result classified?"),("choices",.array [.array [.text "mislabel-as-unobserved-discovery",.text "The prior flatness result was already observed."],.array [.text "observational-reconstruction-with-independent-runtime",.text "The prior record creates the obligation but cannot execute or select the survivor."]])],.object [("key",.text "extension"),("question",.text "May another closure rule enter?"),("choices",.array [.array [.text "extra-cosmological-closure-rule",.text "An added rule is a free premise."],.array [.text "no-extra-rule",.text "Common normalization, completeness and positive refinement exhaust the registered grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-COSMO-SPATIAL-FLATNESS-001"
  title := "Complete-partition spatial flatness and absent curvature remainder"
  branch := "physics"
  statement := "Every generated cosmic component is an exact positive part of one common total carrier. A complete component family exhausts that One, so a separate curvature remainder is the empty One form rather than a numerical zero. Every positive repartition preserves the same closure at arbitrary finite depth."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-ONE-001", "SFT-FOUNDATION-PART-001", "SFT-FOUNDATION-PART-EQUIVALENCE-001", "SFT-FOUNDATION-FOLD-ASSEMBLY-001", "SFT-PHYS-COSMO-BRANCH-BOUNDARY-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-ORDER-LATTICE-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-COSMO-SPATIAL-FLATNESS-001",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-COSMO-SPATIAL-FLATNESS-001",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [CosmoSpatialFlatnessControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity CosmoSpatialFlatnessControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.CosmoSpatialFlatnessEvidence
