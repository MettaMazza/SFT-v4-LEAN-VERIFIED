import SFT.Physics.HubbleControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.HubbleEvidence
open SFT.Host.Canonical HubbleGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "occupancy",.text (occupancyName c.occupancy)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "support",.text (supportName c.support)],.array [.text "leading",.text (leadingName c.leading)],.array [.text "depth",.text (depthName c.depth)],.array [.text "orbit",.text (orbitName c.orbit)],.array [.text "deepening",.text (deepeningName c.deepening)],.array [.text "target",.text (targetName c.target)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "What carries the cosmic partition?"),("choices",.array [.array [.text "independent-density-scalars",.text "Independent scalars do not close one conserved whole."],.array [.text "one-complete-cosmic-carrier",.text "Every retained sector is a part of one complete carrier."]])],.object [("key",.text "occupancy"),("question",.text "Which structural distinction separates the parts?"),("choices",.array [.array [.text "named-matter-and-vacuum",.text "Names do not force multiplicity or orientation."],.array [.text "one-formed-class-and-two-fibre-open-complement",.text "The One supplies one retained formed class while the complete Fold supplies its two distinguishable open fibres."]])],.object [("key",.text "partition"),("question",.text "Which exact shares follow?"),("choices",.array [.array [.text "selected-or-reversed-shares",.text "Selection or reversal loses the formed/open orientation."],.array [.text "one-third-formed-two-thirds-open",.text "The oriented generator-three carrier contains the One formed class and both open Fold fibres exactly once."]])],.object [("key",.text "support"),("question",.text "Across what support is the open calibration distributed?"),("choices",.array [.array [.text "free-calibration-scale",.text "A free scale is a fitted parameter."],.array [.text "complete-depth-three-Fold-support",.text "The generator-three depth has exactly two-cubed complete word support."]])],.object [("key",.text "leading"),("question",.text "What leading correction is admitted?"),("choices",.array [.array [.text "measured-ratio-correction",.text "A measured correction would select the answer."],.array [.text "open-share-over-complete-support",.text "Two-thirds divided over eight forces one-twelfth and therefore thirteen-twelfths."]])],.object [("key",.text "depth"),("question",.text "Which deeper recurrence may refine it?"),("choices",.array [.array [.text "selected-cosmological-depth",.text "A selected depth is a parameter."],.array [.text "independently-forced-up-cover-depth",.text "The admitted cover construction fixes the deeper positive depth at seven before cosmological comparison."]])],.object [("key",.text "orbit"),("question",.text "Which recurrence record belongs to that depth?"),("choices",.array [.array [.text "arbitrary-denominator",.text "An arbitrary denominator fits a correction."],.array [.text "depth-seven-first-return-floor",.text "The positive predecessor of complete depth-seven support is 127 and its unit part first-returns in seven Folds."]])],.object [("key",.text "deepening"),("question",.text "How is one recurrence retained?"),("choices",.array [.array [.text "selected-sign-or-extra-term",.text "A sign choice or external term is not forced."],.array [.text "one-positive-orbit-part-inside-open-share",.text "Exactly one positive 1/127 recurrence part deepens the open share before the same support distribution."]])],.object [("key",.text "target"),("question",.text "May Hubble measurements select a form?"),("choices",.array [.array [.text "hubble-values-readable-before-seal",.text "That is fitting."],.array [.text "both-routes-inaccessible-until-seal",.text "Both exact ratios and all alternatives seal before external rows open."]])],.object [("key",.text "provenance"),("question",.text "How is the known V1/V2 result classified?"),("choices",.array [.array [.text "mislabel-as-unobserved-discovery",.text "The prior result was already observed."],.array [.text "observational-reconstruction-with-independent-runtime",.text "The prior record defines the obligation while no prior answer or measurement enters execution."]])],.object [("key",.text "extension"),("question",.text "May another calibration parameter enter?"),("choices",.array [.array [.text "extra-calibration-rule",.text "An added rule is a free parameter."],.array [.text "no-extra-rule",.text "The registered leading and one-native-recurrence grammar is exhausted."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-COSMO-HUBBLE-CALIBRATION-001"
  title := "Fold calibration ratio between early and late expansion routes"
  branch := "physics"
  statement := "One retained formed class and the complete two-fibre open complement partition the generator-three cosmic carrier into exact matter and vacuum shares 1/3 and 2/3. Distributing the open share over the depth-three Fold support eight forces correction 1/12 and late/early calibration ratio 13/12. The independently forced depth-seven first-return floor 127 supplies the unique registered first-recursive deepening, giving exact ratio 3305/3048."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-FOUNDATION-ONE-001", "SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-COUNT-001", "SFT-FOUNDATION-PART-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-DYNAMICAL-SYSTEMS-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-COSMO-HUBBLE-CALIBRATION-001",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-COSMO-HUBBLE-CALIBRATION-001",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [HubbleControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity HubbleControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 100000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.HubbleEvidence
