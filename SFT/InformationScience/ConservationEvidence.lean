import SFT.InformationScience.ConservationControls
import SFT.Engine.RegistrationGate
namespace SFT.InformationScience.ConservationEvidence
open SFT.Host.Canonical ConservationGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "map",.text (mapName c.map)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "accounting",.text (accountingName c.accounting)],.array [.text "loss",.text (lossName c.loss)],.array [.text "reversal",.text (reversalName c.reversal)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "conservation",.text (conservationName c.conservation)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "support"),("question",.text "What fixes possible inputs?"),("choices",.array [.array [.text "partial-input-support",.text "Omission hides distinctions that may be lost."],.array [.text "complete-canonical-source",.text "Every registered source form occurs once."]])],.object [("key",.text "map"),("question",.text "What fixes transformation?"),("choices",.array [.array [.text "partial-or-multivalued-rule",.text "An incomplete or multivalued rule cannot account for every source."],.array [.text "total-single-valued-map",.text "Each source has exactly one held image."]])],.object [("key",.text "provenance"),("question",.text "What connects images to sources?"),("choices",.array [.array [.text "image-only-output",.text "Image-only output erases which sources entered each result."],.array [.text "exact-predecessor-fibres",.text "Every image retains its complete source class."]])],.object [("key",.text "accounting"),("question",.text "What fixes conserved information?"),("choices",.array [.array [.text "output-cardinality-only",.text "A count erases which distinctions survive."],.array [.text "complete-source-pair-partition",.text "Every source pair is classified exactly as retained or closed."]])],.object [("key",.text "loss"),("question",.text "What constitutes information loss?"),("choices",.array [.array [.text "lower-score-assertion",.text "A score does not identify unavailable predecessors."],.array [.text "non-singleton-image-fibre",.text "Loss is the exact source distinctions closed inside an image fibre."]])],.object [("key",.text "reversal"),("question",.text "What forces reversibility?"),("choices",.array [.array [.text "assumed-inverse",.text "An inverse cannot choose among merged predecessors."],.array [.text "singleton-fibre-or-held-record",.text "Singleton fibres reverse directly; merged fibres require retained predecessor labels."]])],.object [("key",.text "composition"),("question",.text "How does loss propagate?"),("choices",.array [.array [.text "fresh-downstream-distinction",.text "A deterministic image map has no source for a distinction already closed."],.array [.text "retained-pair-subset",.text "A downstream map can preserve or close an upstream distinction but cannot reopen it."]])],.object [("key",.text "conservation"),("question",.text "What is information conservation?"),("choices",.array [.array [.text "unchanged-scalar",.text "An unchanged scalar can hide exchanges among distinctions."],.array [.text "retained-plus-closed-exhaustion",.text "The two exact ledgers disjointly exhaust all source distinctions."]])],.object [("key",.text "generality"),("question",.text "What closes arbitrary finite maps?"),("choices",.array [.array [.text "sampled-transformations",.text "Examples do not prove a fresh source image accounted."],.array [.text "source-successor-map-cell",.text "A fresh source adds one held map cell and all new pair comparisons."]])],.object [("key",.text "addition"),("question",.text "May information appear without a source?"),("choices",.array [.array [.text "unrecorded-created-distinction",.text "A new distinction without source or record violates provenance."],.array [.text "no-extra-information-source",.text "All output distinctions trace to separated source images or declared external input."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-INFO-CONSERVATION-LOSS-001"
  title := "Exact information conservation, loss and transformation"
  branch := "information_science"
  statement := "An information transformation is a total single-valued map over complete source support. Every source distinction is conserved as an image distinction or closed inside an exact predecessor fibre; these two ledgers are disjoint and exhaustive. Reversibility is forced exactly by singleton fibres. An irreversible transformation can be reversed only when a retained predecessor label resolves each non-singleton fibre. Under composition, downstream retained distinctions are a subset of those retained upstream, so a map creates no unrecorded source distinction."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-INFO-MUTUAL-CONDITIONAL-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-INFO-CONSERVATION-LOSS-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-INFO-CONSERVATION-LOSS-001"),
    ("dependencies",.array [.text "SFT-MATH-DYNAMICAL-SYSTEMS-001",.text "SFT-MATH-LOGIC-PROOF-001",.text "SFT-INFO-ENCODING-DECODING-001",.text "SFT-INFO-CHANNEL-CAPACITY-001",.text "SFT-INFO-MUTUAL-CONDITIONAL-001"]),
    ("record",candidateRecord c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])

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
  proofHash := identity (.object [("closure",ConservationControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-INFO-CONSERVATION-LOSS-001"),
    ("base",.text "One source maps to one held image, has one singleton fibre and structural empty-One pair ledgers."),
    ("successor",.text "Adding one fresh source adds one image membership and one pair against each prior source. Image equality places each new pair exactly in the retained or closed ledger and updates one predecessor fibre."),
    ("laws",.array (ConservationControls.laws.map Value.text)),
    ("witnesses",.array (ConservationWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Information conservation and loss require pair-level accounting: image counts alone cannot show which source alternatives remain recoverable or what record reversal requires."

def derivation : String := "Encoding supplies inverse classes, channels supply relations, mutual information supplies joint incidence and dynamics supplies composition. Ten axes force exhaustive pair accounting and the compositional loss law."

def check : String := "Execute all 1,024 kernels; compare identity, prefix projection and total erasure, verify exact pair ledgers, reverse records and downstream subset law, then independently regenerate the product."

def limitations : String := "This theorem closes exact finite deterministic information transformation. Thermodynamic energy costs and operational quantum measurement belong to later physical and quantum branches."

def correspondenceTerms : List String := ["data processing","information loss","reversible map","many-to-one map","sufficient record"]

end SFT.InformationScience.ConservationEvidence
