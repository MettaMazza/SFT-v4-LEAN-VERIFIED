import SFT.InformationScience.CodingControls
import SFT.Engine.RegistrationGate
namespace SFT.InformationScience.CodingEvidence
open SFT.Host.Canonical CodingGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "codebook",.text (codebookName c.codebook)],.array [.text "encoding",.text (encodingName c.encoding)],.array [.text "positions",.text (positionsName c.positions)],.array [.text "difference",.text (differenceName c.difference)],.array [.text "errors",.text (errorsName c.errors)],.array [.text "detection",.text (detectionName c.detection)],.array [.text "correction",.text (correctionName c.correction)],.array [.text "redundancy",.text (redundancyName c.redundancy)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "support"),("question",.text "What fixes possible codewords?"),("choices",.array [.array [.text "partial-word-support",.text "Omission hides possible code or error images."],.array [.text "complete-generated-word-support",.text "Every held-label word over the registered positions occurs once."]])],.object [("key",.text "codebook"),("question",.text "What fixes valid words?"),("choices",.array [.array [.text "free-valid-list",.text "A free list lacks a complete source support boundary."],.array [.text "held-support-selection",.text "The codebook is an exact nonempty selection of generated words."]])],.object [("key",.text "encoding"),("question",.text "What links messages to codewords?"),("choices",.array [.array [.text "implicit-assignment",.text "An implicit assignment erases source provenance."],.array [.text "total-source-code-relation",.text "Every source message has one retained codeword."]])],.object [("key",.text "positions"),("question",.text "What makes codewords comparable?"),("choices",.array [.array [.text "unequal-or-unlabelled-positions",.text "Position changes cannot be located on unequal or anonymous carriers."],.array [.text "common-canonical-position-trace",.text "Every word uses the same retained ordered position carrier."]])],.object [("key",.text "difference"),("question",.text "What fixes codeword separation?"),("choices",.array [.array [.text "scalar-distance",.text "A scalar erases which positions and labels differ."],.array [.text "complete-difference-trace",.text "Every changed position retains both code labels; equality is empty One."]])],.object [("key",.text "errors"),("question",.text "What fixes an error family?"),("choices",.array [.array [.text "sampled-error-outputs",.text "Sampling cannot prove image supports disjoint."],.array [.text "complete-registered-error-images",.text "Every registered action image of every codeword is generated."]])],.object [("key",.text "detection"),("question",.text "What forces detection?"),("choices",.array [.array [.text "likely-corruption",.text "Likelihood imports a prior and threshold."],.array [.text "noncodeword-image",.text "Every nonidentity registered image lies outside the valid codebook."]])],.object [("key",.text "correction"),("question",.text "What forces correction?"),("choices",.array [.array [.text "nearest-codeword",.text "A metric can tie and is not structurally supplied."],.array [.text "disjoint-error-image-support",.text "Every received image belongs to at most one source codeword family."]])],.object [("key",.text "redundancy"),("question",.text "When are added positions lawful?"),("choices",.array [.array [.text "unaccounted-padding",.text "Padding without a correction witness is an unforced addition."],.array [.text "separation-forcing-positions",.text "Every added position participates in the exact disjoint-image certificate."]])],.object [("key",.text "generality"),("question",.text "What closes any registered finite error family?"),("choices",.array [.array [.text "fixed-mask-example",.text "One mask does not establish all registered actions."],.array [.text "error-action-successor",.text "A fresh action extends every codeword image family and disjointness is rechecked."]])],.object [("key",.text "addition"),("question",.text "Is another coding theorem imported?"),("choices",.array [.array [.text "extra-distance-or-rate-rule",.text "A borrowed metric or asymptotic rate can select the code."],.array [.text "no-extra-coding-rule",.text "Code status follows only from generated support and error images."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-INFO-CODING-001"
  title := "Exact finite coding, detection and correction"
  branch := "information_science"
  statement := "A finite code is a nonempty held selection of complete generated equal-position word support plus a total source/codeword relation. Codeword difference is the exact changed-position trace. A registered error family is detectable when every nonidentity image lies outside the codebook and correctable when distinct codewords have disjoint complete error-image supports. Decoding is then the unique source whose image family contains the received word. Redundancy is admitted only when those retained positions force separation."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-COMBINATORICS-001","SFT-INFO-COMPRESSION-REDUNDANCY-001","SFT-INFO-NOISE-ERROR-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-INFO-CODING-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-INFO-CODING-001"),
    ("dependencies",.array [.text "SFT-FOUNDATION-FOLD-ASSEMBLY-001",.text "SFT-MATH-COMBINATORICS-001",.text "SFT-INFO-COMPRESSION-REDUNDANCY-001",.text "SFT-INFO-NOISE-ERROR-001"]),
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
  proofHash := identity (.object [("closure",CodingControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-INFO-CODING-001"),
    ("base",.text "One registered error action generates one image per codeword; detection and support disjointness are exhaustively checked."),
    ("successor",.text "Adding one error action appends its exact image to every affected codeword family. Detection checks valid-word membership and correction checks every newly possible intersection with all other source families."),
    ("laws",.array (CodingControls.laws.map Value.text)),
    ("witnesses",.array (CodingWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Coding theory must establish correction from complete structural error alternatives. A metric or probability may summarize a sealed code later but cannot select which received forms decode uniquely."

def derivation : String := "Fold assembly supplies word support; noise supplies registered transformations and predecessor classes; compression supplies lawful redundancy; combinatorics exhausts image families. Eleven axes force finite detection and correction through exact support separation."

def check : String := "Execute all 2,048 coding kernels, exhaust width-three word support and all single-label images, verify detection, correction and decoding, reject the unprotected code and independently regenerate the census."

def limitations : String := "This theorem closes exact finite classical coding for any explicitly registered error family. Quantum codes, fault tolerance and unbounded error thresholds belong to later branches."

def correspondenceTerms : List String := ["block code","Hamming distance","error detection","error correction","repetition code"]

end SFT.InformationScience.CodingEvidence
