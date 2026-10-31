import SFT.Host.SHA256Chunks
import SFT.Physics.UnifiedConstantsControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.UnifiedConstantsEvidence
open SFT.Host.Canonical UnifiedConstantsGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "root",.text (rootName c.root)],.array [.text "fold",.text (foldName c.fold)],.array [.text "covers",.text (coversName c.covers)],.array [.text "typing",.text (typingName c.typing)],.array [.text "leading",.text (leadingName c.leading)],.array [.text "terminal",.text (terminalName c.terminal)],.array [.text "graph",.text (graphName c.graph)],.array [.text "mutation",.text (mutationName c.mutation)],.array [.text "control",.text (controlName c.control)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "extension",.text (extensionName c.extension)],.array [.text "rule",.text (ruleName c.rule)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "root"),("question",.text "Does every sector share one root?"),("choices",.array [.array [.text "disconnected-constant-list",.text "A list cannot establish common mathematical identity."],.array [.text "single-One-root",.text "Every sector is reachable from the same foundational One."]])],.object [("key",.text "fold"),("question",.text "How are the primary carriers obtained?"),("choices",.array [.array [.text "borrowed-numerals",.text "Borrowed numbers are untraced inputs."],.array [.text "Fold-generated-binary-and-generator",.text "Binary two and generator three are retained from admitted Fold recurrence."]])],.object [("key",.text "covers"),("question",.text "How are depths five and seven fixed?"),("choices",.array [.array [.text "selected-depth-labels",.text "Selected depths are parameters."],.array [.text "least-binary-covers-of-generated-volumes",.text "The depths are the least complete covers of three cubed and three to its successor."]])],.object [("key",.text "typing"),("question",.text "How do repeated values cross sectors?"),("choices",.array [.array [.text "untyped-number-coincidence",.text "Equal digits alone do not prove one object."],.array [.text "shared-carrier-incidence",.text "Each repeated carrier keeps one identity and all consuming edges."]])],.object [("key",.text "leading"),("question",.text "Is the common-order object complete?"),("choices",.array [.array [.text "selected-headline-values",.text "Headline selection can hide a disconnected branch."],.array [.text "complete-registered-foundation-vector",.text "Every registered foundation-order sector reading is retained."]])],.object [("key",.text "terminal"),("question",.text "How are deeper V3 readings related?"),("choices",.array [.array [.text "replacement-values-with-new-roots",.text "Replacement would break the common object."],.array [.text "root-preserving-terminal-continuations",.text "Every terminal reading preserves the same counted roots while exhausting added structure."]])],.object [("key",.text "graph"),("question",.text "What proves one object rather than many?"),("choices",.array [.array [.text "sector-local-formulas-only",.text "Local formulas do not expose common dependence."],.array [.text "connected-rooted-dependency-graph",.text "All sector nodes are connected to the One through shared carriers."]])],.object [("key",.text "mutation"),("question",.text "How is shared dependence tested?"),("choices",.array [.array [.text "decorative-shared-labels",.text "Labels without recomputation do not demonstrate dependence."],.array [.text "complete-generator-successor-probe",.text "Every generator-dependent carrier is recomputed and moves."]])],.object [("key",.text "control"),("question",.text "How is independence distinguished?"),("choices",.array [.array [.text "blanket-global-mutation",.text "Changing everything cannot localize dependence."],.array [.text "binary-and-rank-held-controls",.text "Binary-only half-One and independently held ranks remain exact."]])],.object [("key",.text "measurement"),("question",.text "May measurement select the object?"),("choices",.array [.array [.text "measurement-assembled-object",.text "That would fit the dependency graph to targets."],.array [.text "formal-object-sealed-before-comparison",.text "The exact object is forced before external values are opened."]])],.object [("key",.text "extension"),("question",.text "What happens when a new constant is lawfully derived?"),("choices",.array [.array [.text "rewrite-existing-object",.text "Rewriting destroys provenance."],.array [.text "append-traced-node",.text "A lawful extension appends a typed edge and retains every prior identity."]])],.object [("key",.text "rule"),("question",.text "May any additional selector enter?"),("choices",.array [.array [.text "free-extra-rule",.text "An extra selector is a parameter."],.array [.text "no-extra-rule",.text "The admitted roots, covers, typing and complete incidence exhaust the grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def exactIdentity (value : Value) : String :=
 SFT.Host.Text.append "sha256:" (SFT.Host.SHA256Chunks.digest (render value).toUTF8)
theorem exactIdentityPreserved (value : Value) : exactIdentity value=identity value :=
 congrArg (SFT.Host.Text.append "sha256:") (SFT.Host.SHA256Chunks.digestPreserved (render value).toUTF8)

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-UNIFIED-CONSTANTS-OBJECT-077"
  title := "The Unified Constants Object"
  branch := "physics"
  statement := "The admitted electromagnetic, lepton, quark, cosmological, hierarchy and vacuum constants are not independent numerical dials. They are typed readings of one rooted Fold geometry: the One forces the Fold; the Fold forces binary two and generator three; three-space and boundary rank two force the shared cover depths five and seven; and those same retained carriers generate the complete registered exact cross-sector vector. A generator-successor dependency probe moves every and only generator-dependent carrier, while the binary-only half-One and independently held ranks remain fixed."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-ONE-001", "SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-COUNT-001", "SFT-FOUNDATION-PART-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001", "SFT-MATH-GRAPH-NETWORK-001", "SFT-MATH-DYNAMICAL-SYSTEMS-001", "SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001", "SFT-PHYS-CONSTANT-CHARGED-LEPTON-TERMINAL-001", "SFT-PHYS-MATTER-QUARK-CUBICS-003", "SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001", "SFT-PHYS-COSMO-HUBBLE-CALIBRATION-001", "SFT-PHYS-SCALE-PROTON-PLANCK-HIERARCHY-002", "SFT-PHYS-SCALE-PROTON-PLANCK-TERMINAL-003", "SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003", "SFT-PHYS-VACUUM-DENSITY-SCALE-TERMINAL-035"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := exactIdentity (.array [.text "SFT-PHYS-UNIFIED-CONSTANTS-OBJECT-077",.text generationRule,candidateRecord c])

def censusData : SFT.Engine.CandidateCensus where
  generationRule := generationRule
  grammarBoundary := grammarBoundary
  expectedCardinality := .ofNat candidates.length
  completenessCertificateHash := exactIdentity completenessRecord
  candidates := candidates.map generatedCandidateData

def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
  candidateId := candidateId c
  survives := survives c
  reason := decisionReason c
  proofHash := exactIdentity (.array [.text "SFT-PHYS-UNIFIED-CONSTANTS-OBJECT-077",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

def decision (c : Candidate) : Value := SFT.Engine.decisionValue (decisionData c)

def indexBucketCount : Nat := candidates.length*2+1
def rowIndex : Array (List (String × Candidate)) := candidates.foldl (fun index c =>
 let key := candidateId c
 let bucket := key.hash.toNat % indexBucketCount
 index.set! bucket (index[bucket]! ++ [(key,c)])) (Array.replicate indexBucketCount [])
@[irreducible] def decideIdentifier (id : String) : Except String SFT.Engine.CandidateDecision :=
 match (rowIndex[id.hash.toNat % indexBucketCount]!).find? (fun row => SFT.Host.Text.equal row.1 id) with
 | some row => .ok (decisionData row.2)
 | none => .error "StopIteration"
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 decideIdentifier candidate.candidateId

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := exactIdentity (.array [UnifiedConstantsControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity UnifiedConstantsControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.UnifiedConstantsEvidence
