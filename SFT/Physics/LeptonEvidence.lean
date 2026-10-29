import SFT.Physics.LeptonControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.LeptonEvidence
open SFT.Host.Canonical LeptonGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "generator",.text (generatorName c.generator)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "pair",.text (pairName c.pair)],.array [.text "support",.text (supportName c.support)],.array [.text "predecessor",.text (predecessorName c.predecessor)],.array [.text "channel",.text (channelName c.channel)],.array [.text "sharpening",.text (sharpeningName c.sharpening)],.array [.text "roots",.text (rootsName c.roots)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "What carries three mass positions?"),("choices",.array [.array [.text "three-names-without-joint-invariants",.text "Names do not retain one cubic relation."],.array [.text "one-complete-symmetric-three-root-carrier",.text "One carrier retains all three roots through their exact symmetric invariants."]])],.object [("key",.text "generator"),("question",.text "What fixes the root count?"),("choices",.array [.array [.text "selected-three",.text "A familiar generation count cannot be assumed."],.array [.text "admitted-generator-three",.text "The independently admitted second Fold generator fixes the complete three-position carrier."]])],.object [("key",.text "partition"),("question",.text "What fixes the root sum?"),("choices",.array [.array [.text "unnormalized-root-sum",.text "An unnormalized sum adds a free scale."],.array [.text "root-sum-is-the-One",.text "The complete three-position carrier is a no-loss partition of the One."]])],.object [("key",.text "pair"),("question",.text "Which pair invariant is forced?"),("choices",.array [.array [.text "one-over-colour",.text "This omits the two Fold fibres."],.array [.text "one-over-two-colour",.text "The two Fold fibres pair once with the generator-three carrier, forcing 1/(2*3)=1/6."],.array [.text "one-over-colour-square",.text "This substitutes a colour pair for the Fold-fibre pairing."]])],.object [("key",.text "support"),("question",.text "What supplies the leading product support?"),("choices",.array [.array [.text "colour-fourth-power",.text "This stops before the complete fifth colour succession."],.array [.text "twice-colour-fifth-power",.text "Two Fold fibres carry the complete colour fifth-power support."]])],.object [("key",.text "predecessor"),("question",.text "How is the leading denominator closed?"),("choices",.array [.array [.text "support-count-itself",.text "The complete support retains the terminal One rather than the massive interior."],.array [.text "positive-predecessor-of-support",.text "The unique positive predecessor removes the terminal One without using numerical zero or a negative quantity."]])],.object [("key",.text "channel"),("question",.text "Which generated channel sharpens the product?"),("choices",.array [.array [.text "binary-channel",.text "The binary channel is not the carrier's generator identity."],.array [.text "colour-channel",.text "Only the generator-three channel is identical to the three-root carrier being sharpened."],.array [.text "successor-channel",.text "The successor channel adds an ungenerated carrier role."]])],.object [("key",.text "sharpening"),("question",.text "How does the channel refine the denominator?"),("choices",.array [.array [.text "add-channel-whole",.text "A whole channel count changes scale rather than resolves one channel part."],.array [.text "positive-take-one-channel-part",.text "One exact channel part is held from the leading support predecessor, preserving a positive denominator."]])],.object [("key",.text "roots"),("question",.text "Must irrational roots be produced?"),("choices",.array [.array [.text "solve-and-round-roots",.text "Root approximation introduces brackets and stopping choices."],.array [.text "retain-exact-symmetric-invariants",.text "Vieta-complete invariants carry the cubic without irrational or floating proof values."]])],.object [("key",.text "extension"),("question",.text "May another coefficient or selector enter?"),("choices",.array [.array [.text "extra-coefficient-or-measured-selector",.text "An added number or target-selected channel is a free parameter."],.array [.text "no-extra-rule",.text "The admitted counts, products, predecessor and channel identity exhaust the registered grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001"
  title := "Exact charged-lepton cubic invariants"
  branch := "physics"
  statement := "The forced generator-three partition supplies one exact three-root mass carrier whose symmetric invariants are root sum One, pair sum one over the two Fold fibres paired with generator three, leading product one over the positive predecessor of twice the colour fifth-power support, and sharpened product obtained by the unique generator-three channel part.  The resulting exact invariants are 1, 1/6, 1/485 and 3/1454; no irrational root is formed."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-FOUNDATION-COUNT-001", "SFT-FOUNDATION-PART-001", "SFT-FOUNDATION-PART-EQUIVALENCE-001", "SFT-FOUNDATION-FORM-ENFORCEMENT-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-ALGEBRA-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [LeptonControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity LeptonControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.LeptonEvidence
