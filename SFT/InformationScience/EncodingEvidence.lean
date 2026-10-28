import SFT.InformationScience.EncodingControls
import SFT.Engine.RegistrationGate
namespace SFT.InformationScience.EncodingEvidence
open SFT.Host.Canonical EncodingGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "source",.text (sourceName c.source)],.array [.text "support",.text (supportName c.support)],.array [.text "coverage",.text (coverageName c.coverage)],.array [.text "image",.text (imageName c.image)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "decoder",.text (decoderName c.decoder)],.array [.text "loss",.text (lossName c.loss)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "source"),("question",.text "What fixes the encoded domain?"),("choices",.array [.array [.text "partial-source",.text "An omitted source symbol has no representation row."],.array [.text "complete-canonical-source",.text "Every source symbol occurs once in the registered domain."]])],.object [("key",.text "support"),("question",.text "What fixes possible codewords?"),("choices",.array [.array [.text "free-code-token",.text "A free token has no generated Fold-word provenance."],.array [.text "generated-code-support",.text "Every codeword is an exact generated held-label word."]])],.object [("key",.text "coverage"),("question",.text "How much of the source is encoded?"),("choices",.array [.array [.text "partial-map",.text "A partial map leaves at least one source without a codeword."],.array [.text "total-source-map",.text "Every source has one encoding row."]])],.object [("key",.text "image"),("question",.text "How many held codewords may one source receive?"),("choices",.array [.array [.text "unheld-multiple-images",.text "Multiple images do not identify the codeword actually retained."],.array [.text "single-retained-codeword",.text "Each source has exactly one held codeword image."]])],.object [("key",.text "provenance"),("question",.text "What representation evidence is kept?"),("choices",.array [.array [.text "source-code-link-erased",.text "Erasing links prevents reconstruction of source classes."],.array [.text "complete-source-code-relation",.text "Every exact source-to-code pair is retained."]])],.object [("key",.text "decoder"),("question",.text "What fixes exact decoding?"),("choices",.array [.array [.text "guessed-preimage",.text "A used codeword can have several source predecessors."],.array [.text "singleton-class-left-inverse",.text "Every used code class is singleton and the inverse map returns its source."]])],.object [("key",.text "loss"),("question",.text "How is a many-to-one encoding treated?"),("choices",.array [.array [.text "silent-loss",.text "Silent merging falsely claims unavailable distinctions remain."],.array [.text "declared-closed-source-classes",.text "Every merged source family is retained as an explicit loss class."]])],.object [("key",.text "composition"),("question",.text "When may encodings compose?"),("choices",.array [.array [.text "presentation-concatenation",.text "Concatenation can join unequal code interfaces."],.array [.text "complete-interface-map",.text "Every first-stage codeword has exactly one second-stage image."]])],.object [("key",.text "generality"),("question",.text "What closes arbitrary finite source size?"),("choices",.array [.array [.text "sampled-codebooks",.text "Examples do not establish a fresh source row."],.array [.text "source-successor",.text "A fresh source adds one exact encoding row and updates one code class."]])],.object [("key",.text "addition"),("question",.text "Is an external representation rule added?"),("choices",.array [.array [.text "extra-code-convention",.text "A borrowed numeral or lexical convention can select the code."],.array [.text "no-extra-code-convention",.text "Only generated code support and exact relations are used."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-INFO-ENCODING-DECODING-001"
  title := "Exact encoding, decoding and declared representational loss"
  branch := "information_science"
  statement := "An admitted encoding is a total single-valued source-bound map from a complete canonical source alphabet into generated codeword support, retaining every source-to-code relation. Exact decoding exists exactly when every used codeword class contains one source and the decoder is the resulting left inverse. A many-to-one encoding is lawful only as declared lossy representation whose complete closed-source classes remain recorded."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-DISCRETE-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-SYMBOL-DISTINCTION-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-INFO-ENCODING-DECODING-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-INFO-ENCODING-DECODING-001"),
    ("dependencies",.array [.text "SFT-FOUNDATION-FOLD-ASSEMBLY-001",.text "SFT-MATH-DISCRETE-001",.text "SFT-MATH-CATEGORY-TYPE-COMPOSITION-001",.text "SFT-INFO-SYMBOL-DISTINCTION-001"]),
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
  proofHash := identity (.object [("closure",EncodingControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-INFO-ENCODING-DECODING-001"),
    ("base",.text "One source symbol maps to one generated codeword and its singleton inverse decodes exactly."),
    ("successor",.text "Adding one fresh source adds exactly one encoding pair. A fresh codeword preserves singleton decoding; a used codeword extends its closed source class and changes the representation status to declared lossy."),
    ("laws",.array (EncodingControls.laws.map Value.text)),
    ("witnesses",.array (EncodingWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Information requires lawful representation before quantity, compression or channels can be discussed. Encoding must expose exactly which distinctions it preserves and which it closes."

def derivation : String := "Fold assembly supplies generated codewords; symbol law supplies canonical sources and distinctions; discrete maps supply totality; compositional mathematics supplies exact interfaces. Ten structural axes force the total relation, inverse and declared-loss kernel."

def check : String := "Execute all 1,024 encoding kernels, verify total lossless mapping, decoder left inverse, lossy-class retention and interface composition, run adverse controls and independently regenerate the census."

def limitations : String := "This theorem closes finite encoding and decoding structure. It does not yet assign code length value, compression optimality, channel reliability or correction power."

def correspondenceTerms : List String := ["alphabet","codeword","encoder","decoder","injective code","lossy representation"]

end SFT.InformationScience.EncodingEvidence
