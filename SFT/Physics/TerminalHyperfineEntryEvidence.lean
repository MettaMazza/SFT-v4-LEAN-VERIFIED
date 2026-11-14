import SFT.Foundation.AdmissionControls
import SFT.Physics.TerminalHyperfineEntryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.TerminalHyperfineEntryEvidence
open SFT.Host.Canonical TerminalHyperfineEntryGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "predecessor",.text (predecessorName c.predecessor)],.array [.text "support",.text (supportName c.support)],.array [.text "operation",.text (operationName c.operation)],.array [.text "order",.text (orderName c.order)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "closure",.text (closureName c.closure)],.array [.text "target",.text (targetName c.target)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "trace",.text (traceName c.trace)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "predecessor"),("question",.text "What does the hyperfine successor refine?"),("choices",.array [.array [.text "replace-or-erase-predecessor",.text "An immutable admitted receipt cannot be rewritten."],.array [.text "retain-and-version-predecessor",.text "The successor depends on and preserves every earlier leading and adverse receipt."]])],.object [("key",.text "support"),("question",.text "Which structural carriers enter?"),("choices",.array [.array [.text "selected-partial-support",.text "A selected subset can tune a precision value."],.array [.text "complete-typed-terminal-support",.text "Every named down/up, generator, binary, bulk, boundary and terminal carrier is used in its typed role."]])],.object [("key",.text "operation"),("question",.text "How are opposing contributions represented?"),("choices",.array [.array [.text "signed-floating-or-complex-series",.text "Signed, floating, irrational or complex proof values violate the Fold domain."],.array [.text "ordered-positive-held-parts",.text "Every opposing contribution is an ordered exact positive Take with its orientation retained."]])],.object [("key",.text "order"),("question",.text "How is correction order chosen?"),("choices",.array [.array [.text "selected-or-open-order",.text "A selected truncation or open series is a free choice."],.array [.text "finite-carrier-exhaustion-order",.text "The order ends exactly when every generated typed carrier has been consumed once."]])],.object [("key",.text "composition"),("question",.text "How are the carriers joined?"),("choices",.array [.array [.text "untyped-coefficient-list",.text "An untyped list does not force a relation."],.array [.text "role-preserving-exact-composition",.text "Carrier type fixes numerator, denominator, order and held/returned orientation."]])],.object [("key",.text "closure"),("question",.text "What terminates the law?"),("choices",.array [.array [.text "unbounded-extra-correction",.text "An unbounded correction family is not closed."],.array [.text "no-generated-carrier-remains",.text "No declared support or return remains after the terminal act."]])],.object [("key",.text "target"),("question",.text "May a measured frequency enter execution?"),("choices",.array [.array [.text "measurement-readable-execution",.text "A target-readable execution cannot issue a prediction seal."],.array [.text "target-inaccessible-until-seal",.text "The executable relation contains only admitted exact Fold carriers."]])],.object [("key",.text "provenance"),("question",.text "How is observational development recorded?"),("choices",.array [.array [.text "hidden-fit-or-forward-claim",.text "Hiding prior target knowledge or calling it blind forward forcing is invalid."],.array [.text "disclosed-observational-prediction-protocol",.text "Observation informs the explicit law; target-inaccessible enumeration and sealing precede exact comparison."]])],.object [("key",.text "trace"),("question",.text "What proof chain is retained?"),("choices",.array [.array [.text "result-without-root-trace",.text "An untraced value is inadmissible."],.array [.text "complete-root-directed-trace",.text "Every dependency returns through admitted receipts to the foundational theorem."]])],.object [("key",.text "extension"),("question",.text "May another coefficient be appended?"),("choices",.array [.array [.text "free-extra-term",.text "An extra term is a parameter."],.array [.text "no-extra-rule",.text "The declared grammar is exhausted and halted."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-ATOMIC-HYPERFINE-TERMINAL-005"
  title := "Terminal exact hydrogen hyperfine and twenty-one-centimetre successor"
  branch := "physics"
  statement := "The terminal proton/electron algebraic enclosure supplies the inverse mass carrier and exact cubic reduced-mass retention.  Both spin ends over generator three force 16/3 alpha squared.  The proton magnetic projection is the finite turn held by one generator share and both alpha hands, returned by 5 alpha/16, held by 16 alpha squared/53 and 7 alpha cubed/80, and closed by alpha fourth/135."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004", "SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004", "SFT-PHYS-QUANTUM-SPIN-001", "SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004", "SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-HYPERFINE-TERMINAL-005",.text generationRule,candidateRecord c])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-HYPERFINE-TERMINAL-005",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [TerminalHyperfineEntryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (SFT.Foundation.AdmissionControls.admissionIdentity TerminalHyperfineEntryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.TerminalHyperfineEntryEvidence
