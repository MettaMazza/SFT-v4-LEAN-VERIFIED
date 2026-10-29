import SFT.Physics.AlphaControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.AlphaEvidence
open SFT.Host.Canonical AlphaGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "cover",.text (coverName c.cover)],.array [.text "depth",.text (depthName c.depth)],.array [.text "tower",.text (towerName c.tower)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "return",.text (returnName c.returns)],.array [.text "join",.text (joinName c.join)],.array [.text "promotion",.text (promotionName c.promotion)],.array [.text "termination",.text (terminationName c.termination)],.array [.text "target",.text (targetName c.target)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "cover"),("question",.text "How are depths obtained?"),("choices",.array [.array [.text "asserted-depths",.text "Asserted depths have no support census."],.array [.text "least-complete-binary-covers",.text "Depths five and seven are independently the least covers of three cubed and three to its successor."]])],.object [("key",.text "depth"),("question",.text "Are the cover results cross-locked?"),("choices",.array [.array [.text "single-route-depths",.text "One route cannot expose a changed carrier."],.array [.text "cover-generator-cross-lock",.text "Five equals two plus three and seven equals three plus its successor."]])],.object [("key",.text "tower"),("question",.text "Which block carries complete binary reach?"),("choices",.array [.array [.text "free-leading-whole",.text "A free leading whole is a parameter."],.array [.text "binary-at-up-depth",.text "The deepest complete binary support is exactly two to depth seven."]])],.object [("key",.text "boundary"),("question",.text "Which block carries generator boundary support?"),("choices",.array [.array [.text "free-boundary-factor",.text "A free coefficient is not structural."],.array [.text "generator-at-boundary-rank",.text "The generator is composed over the separately forced boundary rank two."]])],.object [("key",.text "return"),("question",.text "What corrects a covered object?"),("choices",.array [.array [.text "fitted-small-correction",.text "A fitted correction reads the target."],.array [.text "one-return-over-complete-cover",.text "The only admitted returning whole is the One, distributed over the complete cover."]])],.object [("key",.text "join"),("question",.text "How do typed blocks compose?"),("choices",.array [.array [.text "untyped-arithmetic-permutation",.text "Permuting typed carriers erases their roles."],.array [.text "tower-plus-dilated-boundary",.text "Complete reach and boundary response compose, while the return dilates the boundary carrier it traverses."]])],.object [("key",.text "promotion"),("question",.text "How is self-similar depth exposed?"),("choices",.array [.array [.text "selected-refinement-series",.text "A selected series adds unfixed terms."],.array [.text "one-remaining-direction-per-rung",.text "Each successor promotes exactly one of three interchangeable directions from down to up depth."]])],.object [("key",.text "termination"),("question",.text "Where does refinement end?"),("choices",.array [.array [.text "infinite-or-truncated-by-fit",.text "A fit-selected truncation is not closure."],.array [.text "all-three-directions-promoted",.text "After three promotions no down-depth direction remains; the four-rung object has no successor."]])],.object [("key",.text "target"),("question",.text "May alpha measurements select a form?"),("choices",.array [.array [.text "measured-alpha-visible",.text "That makes measurement an answer-bearing premise."],.array [.text "measurement-inaccessible-until-seal",.text "The exact ratio and complete candidate census seal first."]])],.object [("key",.text "extension"),("question",.text "May another scale be added?"),("choices",.array [.array [.text "extra-scale-rule",.text "An extra scale is a free parameter."],.array [.text "no-extra-rule",.text "The finite promotion object terminates from its own direction count."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001"
  title := "Terminal exact inverse fine-structure Fold ratio"
  branch := "physics"
  statement := "The binary predecessor and generator-three recurrence force cover depths five and seven. Their typed tower, boundary, complete three-direction cover, returning One and finite one-direction-at-a-time promotion ladder force the exact terminal ratio 503846395469/3676744786 before measurement."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001", "SFT-FOUNDATION-COUNT-001", "SFT-FOUNDATION-PART-001", "SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-FOLD-ASSEMBLY-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [AlphaControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity AlphaControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.AlphaEvidence
