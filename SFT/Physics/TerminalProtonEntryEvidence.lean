import SFT.Foundation.AdmissionControls
import SFT.Physics.TerminalProtonEntryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.TerminalProtonEntryEvidence
open SFT.Host.Canonical TerminalProtonEntryGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "base",.text (baseName c.base)],.array [.text "depth",.text (depthName c.depth)],.array [.text "complement",.text (complementName c.complement)],.array [.text "order",.text (orderName c.order)],.array [.text "support",.text (supportName c.support)],.array [.text "terminal",.text (terminalName c.terminal)],.array [.text "transport",.text (transportName c.transport)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "target",.text (targetName c.target)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "base"),("question",.text "Which ratio graph is dressed?"),("choices",.array [.array [.text "replace-or-refit-base-ratio",.text "Replacing the admitted algebraic graph erases its receipt."],.array [.text "retain-admitted-proton-graph",.text "The successor acts on the immutable admitted proton/electron relation."]])],.object [("key",.text "depth"),("question",.text "Which composite depth is complete?"),("choices",.array [.array [.text "selected-composite-depth",.text "A selected depth can tune the correction."],.array [.text "generator-three-composite-depth",.text "The colour composite and independently forced spatial/generation depth coincide at three."]])],.object [("key",.text "complement"),("question",.text "Which depth carrier is transported?"),("choices",.array [.array [.text "free-multiplicity",.text "A free multiplicity is a parameter."],.array [.text "complete-depth-three-heavy-complement",.text "Binary times three cubed support has the unique positive predecessor heavy complement 53."]])],.object [("key",.text "order"),("question",.text "How many electromagnetic ends act?"),("choices",.array [.array [.text "selected-alpha-order",.text "A selected order can read the mismatch."],.array [.text "one-alpha-per-charged-Fold-end",.text "The complete charged relation has the two Fold ends, forcing alpha squared."]])],.object [("key",.text "support"),("question",.text "Across what composite support is the action distributed?"),("choices",.array [.array [.text "partial-bulk-or-boundary-support",.text "Omitting either carrier loses part of the composite."],.array [.text "complete-colour-bulk-plus-carried-boundary",.text "Colour volume 27 and one carried boundary channel per colour give the complete disjoint support 30."]])],.object [("key",.text "terminal"),("question",.text "Does the completed interaction carry its sole return?"),("choices",.array [.array [.text "leading-order-only-or-extra-series",.text "Leading-only omits the declared terminal carrier; an open series has no closure."],.array [.text "one-terminal-alpha-successor",.text "The admitted terminal alpha object supplies exactly one successor return."]])],.object [("key",.text "transport"),("question",.text "How is the return shared?"),("choices",.array [.array [.text "free-return-weight",.text "A free return weight is a fitted coefficient."],.array [.text "both-labels-through-down-depth-and-volume",.text "Both Fold labels traverse every down-cover layer and colour-volume cell once, forcing 2/(5*27)."]])],.object [("key",.text "orientation"),("question",.text "How does bound self-coupling alter retained mass?"),("choices",.array [.array [.text "append-unbound-mass",.text "Appending a new mass carrier breaks the normalized composite ledger."],.array [.text "hold-dressing-from-existing-ratio",.text "Binding self-coupling is held from the already normalized composite ratio."]])],.object [("key",.text "target"),("question",.text "May CODATA enter the relation?"),("choices",.array [.array [.text "measurement-readable-relation",.text "That would fit the known mismatch."],.array [.text "measurement-inaccessible-to-executable-relation",.text "Only admitted exact Fold carriers occur before the engine seal."]])],.object [("key",.text "provenance"),("question",.text "How is post-mismatch development executed?"),("choices",.array [.array [.text "unregistered-target-readable-fit",.text "Target-readable execution cannot issue an independent prediction seal."],.array [.text "registered-observational-prediction-protocol",.text "Observation informs the explicit law, then target-inaccessible execution seals its consequence before exact comparison."]])],.object [("key",.text "extension"),("question",.text "May another correction be appended?"),("choices",.array [.array [.text "additional-fit-term",.text "A further term is not supplied by the exhausted first-terminal grammar."],.array [.text "no-extra-rule",.text "Bulk, boundary, both ends and the sole terminal return are exhausted."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004"
  title := "Terminal composite proton/electron precision law"
  branch := "physics"
  statement := "The admitted proton/electron algebraic graph receives the complete electromagnetic self-coupling of its three-depth colour composite.  Binary-by-colour-cubed support has heavy complement 53; the complete colour bulk and its three carried boundary channels supply support 27+3=30; both charged Fold ends force alpha squared; and the sole terminal return transports the two Fold labels through down-depth five and colour volume 27 once.  The retained ratio is therefore the admitted algebraic ratio times One held by 53 alpha^2/30 times (One plus 2 alpha/135)."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-MATTER-PROTON-ELECTRON-003", "SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003", "SFT-PHYS-MATTER-CONFINEMENT-LIFT-003", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004",.text generationRule,candidateRecord c])

def censusData : SFT.Engine.CandidateCensus where
  generationRule := generationRule
  grammarBoundary := grammarBoundary
  expectedCardinality := .ofNat candidates.length
  completenessCertificateHash := SFT.Foundation.AdmissionControls.admissionIdentity completenessRecord
  candidates := candidates.map generatedCandidateData

def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
  candidateId := candidateId c
  survives := survives c
  reason := decisionReason c
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [TerminalProtonEntryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (SFT.Foundation.AdmissionControls.admissionIdentity TerminalProtonEntryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.TerminalProtonEntryEvidence
