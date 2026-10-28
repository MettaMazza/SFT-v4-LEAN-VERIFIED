import SFT.InformationScience.CompressionControls
import SFT.Engine.RegistrationGate
namespace SFT.InformationScience.CompressionEvidence
open SFT.Host.Canonical CompressionGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "message",.text (messageName c.message)],.array [.text "description",.text (descriptionName c.description)],.array [.text "reconstruction",.text (reconstructionName c.reconstruction)],.array [.text "parsing",.text (parsingName c.parsing)],.array [.text "redundancy",.text (redundancyName c.redundancy)],.array [.text "resources",.text (resourcesName c.resources)],.array [.text "shortening",.text (shorteningName c.shortening)],.array [.text "optimization",.text (optimizationName c.optimization)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "message"),("question",.text "What fixes the source message?"),("choices",.array [.array [.text "partial-message",.text "An omitted occurrence changes the reconstruction target."],.array [.text "complete-canonical-message",.text "Every source occurrence remains in exact order."]])],.object [("key",.text "description"),("question",.text "What representation evidence is retained?"),("choices",.array [.array [.text "opaque-short-string",.text "A short string without dictionary provenance cannot reconstruct the source."],.array [.text "dictionary-and-token-trace",.text "Every reusable block and held token occurrence is retained."]])],.object [("key",.text "reconstruction"),("question",.text "What makes compression lossless?"),("choices",.array [.array [.text "similar-output",.text "Similarity does not establish exact source identity."],.array [.text "exact-decoder-equality",.text "Decoding reproduces the complete canonical message trace."]])],.object [("key",.text "parsing"),("question",.text "What makes variable codewords separable?"),("choices",.array [.array [.text "ambiguous-concatenation",.text "One stream may admit several codeword parses."],.array [.text "prefix-or-delimiter-witness",.text "A generated boundary makes the parse unique."]])],.object [("key",.text "redundancy"),("question",.text "What identifies redundancy?"),("choices",.array [.array [.text "frequency-assumption",.text "Frequency alone does not prove reconstruction."],.array [.text "reconstructible-occurrence-trace",.text "Omitted raw occurrences are generated exactly from retained description structure."]])],.object [("key",.text "resources"),("question",.text "What is counted as compressed size?"),("choices",.array [.array [.text "payload-only",.text "Ignoring a dictionary or decoder hides required information."],.array [.text "complete-description-resource",.text "Dictionary, tokens, boundaries and decoder identity are all retained."]])],.object [("key",.text "shortening"),("question",.text "Can every fixed-width message be shortened?"),("choices",.array [.array [.text "universal-shortening-claim",.text "Strictly shorter support has fewer generated nonempty codewords than complete fixed support."],.array [.text "pigeonhole-boundary",.text "At least one full-support message cannot receive a distinct strictly shorter codeword."]])],.object [("key",.text "optimization"),("question",.text "What selects a best description?"),("choices",.array [.array [.text "tuned-score",.text "A floating objective or tie rule is unforced."],.array [.text "complete-undominated-descriptions",.text "All exact descriptions are generated and every minimal resource trace tie is retained."]])],.object [("key",.text "generality"),("question",.text "What closes arbitrary finite repetition?"),("choices",.array [.array [.text "sampled-messages",.text "Examples do not establish a fresh repeated token."],.array [.text "token-successor",.text "Appending one retained token reconstructs exactly its registered dictionary block."]])],.object [("key",.text "addition"),("question",.text "Is another compression model added?"),("choices",.array [.array [.text "extra-statistical-model",.text "A learned or fitted model can select the representation."],.array [.text "no-extra-compression-model",.text "Only exact generated dictionaries, tokens and decoding are used."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-INFO-COMPRESSION-REDUNDANCY-001"
  title := "Exact lossless compression and redundancy accounting"
  branch := "information_science"
  statement := "Lossless compression is a complete description relation whose retained dictionary and token trace reconstruct the exact canonical message. Redundancy is a message distinction or occurrence reconstructible from retained description structure. Variable codewords are uniquely parseable only with a complete delimiter or prefix-free witness. Every dictionary and token resource is counted; no fixed complete word support can injectively map all its forms into the strictly shorter nonempty support."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-MATH-COMBINATORICS-001","SFT-MATH-OPTIMIZATION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-QUANTITY-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-INFO-COMPRESSION-REDUNDANCY-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-INFO-COMPRESSION-REDUNDANCY-001"),
    ("dependencies",.array [.text "SFT-MATH-COMBINATORICS-001",.text "SFT-MATH-OPTIMIZATION-001",.text "SFT-INFO-ENCODING-DECODING-001",.text "SFT-INFO-QUANTITY-001"]),
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
  proofHash := identity (.object [("closure",CompressionControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-INFO-COMPRESSION-REDUNDANCY-001"),
    ("base",.text "One dictionary token reconstructs its one registered nonempty block and retains the complete description."),
    ("successor",.text "Appending one valid held token appends exactly its dictionary block to the reconstructed message and one token cell to the resource trace. Exact reconstruction and parsing remain local and replayable."),
    ("laws",.array (CompressionControls.laws.map Value.text)),
    ("witnesses",.array (CompressionWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Compression claims can hide information in a dictionary, parser, model or decoder. The law must force exact reconstruction and count every retained resource before shortening has scientific meaning."

def derivation : String := "Encoding supplies exact decoders; information quantity supplies resource traces; combinatorics supplies full fixed and shorter supports; optimization retains all minimal descriptions. Ten axes force lossless reconstruction, complete accounting and the universal-shortening boundary."

def check : String := "Execute all 1,024 compression kernels, reconstruct the witness message, account for dictionary and tokens, reject ambiguous prefixes, exhaust the fixed/short support boundary and independently regenerate the census."

def limitations : String := "This theorem closes finite structural compression. It does not assert a universal best compressor, a probability distribution or an asymptotic real-valued rate."

def correspondenceTerms : List String := ["lossless compression","redundancy","prefix code","dictionary coding","pigeonhole bound"]

end SFT.InformationScience.CompressionEvidence
