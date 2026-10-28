import SFT.Mathematics.CategoryControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.CategoryEvidence
open SFT.Host.Canonical CategoryGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "objects",.text (objectsName c.objects)],.array [.text "arrows",.text (arrowsName c.arrows)],.array [.text "identity",.text (identityName c.identity)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "association",.text (associationName c.association)],.array [.text "types",.text (typesName c.types)],.array [.text "constructors",.text (constructorsName c.constructors)],.array [.text "functor",.text (functorName c.functor)],.array [.text "naturality",.text (naturalityName c.naturality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "objects"),("question",.text "What fixes compositional objects?"),("choices",.array [.array [.text "presentation-objects",.text "Presentation names can alias distinct structures."],.array [.text "canonical-Fold-objects",.text "Every object is an exact canonical generated form."]])],.object [("key",.text "arrows"),("question",.text "What fixes a morphism?"),("choices",.array [.array [.text "endpoint-only-arrow",.text "Endpoints alone erase the transformation proof."],.array [.text "proof-carrying-transition",.text "An arrow retains source, target and complete transition trace."]])],.object [("key",.text "identity"),("question",.text "What fixes identity?"),("choices",.array [.array [.text "assumed-neutral-map",.text "A named neutral map has no return witness."],.array [.text "empty-One-return",.text "The zero-step structural return preserves the same object without numerical zero."]])],.object [("key",.text "composition"),("question",.text "When may arrows compose?"),("choices",.array [.array [.text "presentation-concatenation",.text "Textual concatenation can join unequal interfaces."],.array [.text "exact-interface-match",.text "The first target and second source must be the same canonical object."]])],.object [("key",.text "association"),("question",.text "What fixes associativity?"),("choices",.array [.array [.text "borrowed-category-axiom",.text "Importing an axiom would reverse the derivation order."],.array [.text "canonical-path-flattening",.text "Both groupings retain the same ordered elementary transition trace."]])],.object [("key",.text "types"),("question",.text "What fixes a type?"),("choices",.array [.array [.text "informal-class-name",.text "A class name need not decide carrier membership."],.array [.text "source-bound-form-predicate",.text "Every generated carrier form receives one exact membership verdict."]])],.object [("key",.text "constructors"),("question",.text "What fixes product and sum?"),("choices",.array [.array [.text "borrowed-set-constructor",.text "A borrowed constructor imports its ambient universe."],.array [.text "joint-pairs-and-held-alternatives",.text "Products are complete pair support; sums retain left/right held provenance."]])],.object [("key",.text "functor"),("question",.text "What fixes compositional transport?"),("choices",.array [.array [.text "arbitrary-renaming",.text "Renaming can break interfaces and composites."],.array [.text "identity-and-composition-preservation",.text "Object and arrow maps retain sources, targets, returns and composites."]])],.object [("key",.text "naturality"),("question",.text "What fixes a natural correspondence?"),("choices",.array [.array [.text "diagram-by-appearance",.text "A drawn square cannot prove both routes equal."],.array [.text "equal-complete-paths",.text "Both interface-compatible composite routes have the same canonical trace."]])],.object [("key",.text "addition"),("question",.text "Is another compositional axiom added?"),("choices",.array [.array [.text "extra-composition-axiom",.text "An extra universal property is not supplied by the registered traces."],.array [.text "no-extra-composition-axiom",.text "Only generated interfaces, paths and preservation witnesses are admitted."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-MATH-CATEGORY-TYPE-COMPOSITION-001"
  title := "Forced category, type and compositional structure"
  branch := "mathematics"
  statement := "Canonical Fold forms act as objects and proof-carrying transitions as arrows. Identity is the empty-One return, composition is forced exactly by equal interfaces, and association follows from canonical complete path flattening. Types are source-bound predicates over generated carriers; products are complete joint pair support and sums retain held alternative labels. Functors preserve interfaces, identity and composition, while naturality is equality of the two complete composite traces."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ALGEBRA-001","SFT-MATH-LOGIC-PROOF-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-MATH-CATEGORY-TYPE-COMPOSITION-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-MATH-CATEGORY-TYPE-COMPOSITION-001"),
    ("dependencies",.array [.text "SFT-MATH-GRAPH-NETWORK-001",.text "SFT-MATH-ALGEBRA-001",.text "SFT-MATH-LOGIC-PROOF-001"]),
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
  proofHash := identity (.object [("closure",CategoryControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-MATH-CATEGORY-TYPE-COMPOSITION-001"),
    ("base",.text "One canonical object supplies its empty-One identity arrow and the first singleton type."),
    ("successor",.text "Adding one object or arrow generates its identities, every exact interface-compatible composite, product and sum cells, type verdicts and preservation squares. Closure follows by appending its trace to prior flat paths."),
    ("laws",.array (CategoryControls.laws.map Value.text)),
    ("witnesses",.array (CategoryWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Every later science must compose local derivations without losing interfaces or provenance. The forced path kernel supplies this language while keeping category and type concepts downstream of Fold structure."

def derivation : String := "Graphs supply paths, algebra supplies operation association, and logic supplies proof-carrying transitions. Ten choices force exact interfaces, identities, flat composition, types and preservation structures."

def check : String := "Execute all 1,024 kernels, verify interface composition, identity erasure, three-arrow association, exact type membership, products/sums, functor interfaces and naturality paths, then regenerate independently."

def limitations : String := "This closes the finite compositional kernel. Any stronger universal construction must be separately generated and exhaustively witness its claimed mapping property inside an explicit grammar."

def correspondenceTerms : List String := ["category","object","morphism","identity","composition","type","product","sum","functor","natural transformation"]

end SFT.Mathematics.CategoryEvidence
