import SFT.InformationScience.QuantityControls
import SFT.Engine.RegistrationGate
namespace SFT.InformationScience.QuantityEvidence
open SFT.Host.Canonical QuantityGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "pairs",.text (pairsName c.pairs)],.array [.text "observation",.text (observationName c.observation)],.array [.text "unit",.text (unitName c.unit)],.array [.text "positions",.text (positionsName c.positions)],.array [.text "quantity",.text (quantityName c.quantity)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "support"),("question",.text "What fixes possible information states?"),("choices",.array [.array [.text "partial-support",.text "Omitting a generated alternative changes every distinction count."],.array [.text "complete-canonical-support",.text "Every registered alternative occurs once."]])],.object [("key",.text "pairs"),("question",.text "What fixes possible distinctions?"),("choices",.array [.array [.text "sampled-pairs",.text "Sampling cannot prove a distinction ledger complete."],.array [.text "complete-unordered-pair-ledger",.text "Every pair of distinct support forms occurs once."]])],.object [("key",.text "observation"),("question",.text "What fixes retained distinctions?"),("choices",.array [.array [.text "assumed-resolution",.text "An assumed resolution has no source-to-image evidence."],.array [.text "exact-observation-classes",.text "Image equality classifies every pair as retained or closed."]])],.object [("key",.text "unit"),("question",.text "What supplies one native information unit?"),("choices",.array [.array [.text "imported-bit",.text "A conventional binary unit would select the answer."],.array [.text "first-Fold-distinction",.text "The minimal Fold's two held labels supply the first exact alternative distinction."]])],.object [("key",.text "positions"),("question",.text "When do several units compose?"),("choices",.array [.array [.text "word-length-only",.text "Length alone does not show each position can vary independently."],.array [.text "independent-position-witness",.text "Every position realizes the Fold distinction with all other positions held."]])],.object [("key",.text "quantity"),("question",.text "How is information quantity represented?"),("choices",.array [.array [.text "real-logarithm",.text "A logarithm imports irrational and floating proof values."],.array [.text "exact-support-and-distinction-profile",.text "The complete exact ledgers retain the quantity without a borrowed scale."]])],.object [("key",.text "composition"),("question",.text "How do information supports combine?"),("choices",.array [.array [.text "count-product-only",.text "A scalar product erases source-coordinate provenance."],.array [.text "complete-pair-support",.text "Every left state pairs once with every right state and retains both word traces."]])],.object [("key",.text "generality"),("question",.text "What closes every generated word depth?"),("choices",.array [.array [.text "depth-table",.text "A table of small supports does not prove the next position."],.array [.text "position-successor",.text "A fresh position appends every held label to every prior word."]])],.object [("key",.text "addition"),("question",.text "Is another information scale added?"),("choices",.array [.array [.text "extra-log-base-or-unit",.text "A chosen base or physical scale is a free parameter."],.array [.text "no-extra-information-scale",.text "All quantity follows from Fold units, support and observation."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-INFO-QUANTITY-001"
  title := "Exact information quantity as retained distinction structure"
  branch := "information_science"
  statement := "Information quantity is the exact structure of distinguishable alternatives retained from a complete generated support: the support trace, observation-class trace, retained distinction ledger and closed distinction ledger. The first Fold supplies one native distinction unit. Complete Fold-word support across a canonical position trace supplies one independently witnessed unit per position; composition is complete pair support and concatenated position provenance. No logarithm, real scale or semantic zero is foundational."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-INFO-QUANTITY-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-INFO-QUANTITY-001"),
    ("dependencies",.array [.text "SFT-FOUNDATION-FOLD-ASSEMBLY-001",.text "SFT-MATH-EXACT-ARITHMETIC-001",.text "SFT-MATH-COMBINATORICS-001",.text "SFT-INFO-SYMBOL-DISTINCTION-001",.text "SFT-INFO-ENCODING-DECODING-001"]),
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
  proofHash := identity (.object [("closure",QuantityControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-INFO-QUANTITY-001"),
    ("base",.text "The first Fold position has complete two-label support and one independently realized distinction unit."),
    ("successor",.text "Appending one fresh position extends every prior word once with every held label. Prior position witnesses remain, the fresh position varies across its labels for each held prefix, and all new support pairs enter exactly once."),
    ("laws",.array (QuantityControls.laws.map Value.text)),
    ("witnesses",.array (QuantityWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Information quantity must be derived from exact alternatives and observation before entropy, capacity or compression. Importing logarithms would install a conventional numerical answer and forbidden proof values."

def derivation : String := "Fold assembly supplies complete word support; symbol distinction supplies exact observation ledgers; encoding supplies representation; combinatorics supplies complete pairs. Nine structural questions force a ledger-valued quantity and independently witnessed Fold-position unit."

def check : String := "Execute all 512 quantity kernels, generate complete three-position support, compare fine and coarse ledgers, verify independent units and composition, run adverse controls and independently regenerate the product."

def limitations : String := "This theorem closes exact finite information quantity. Conventional logarithmic units may be post-seal correspondence summaries but are not SFT proof values."

def correspondenceTerms : List String := ["information content","bit","alphabet size","logarithmic information","joint information"]

end SFT.InformationScience.QuantityEvidence
