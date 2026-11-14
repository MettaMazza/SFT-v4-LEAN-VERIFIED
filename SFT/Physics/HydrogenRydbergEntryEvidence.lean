import SFT.Foundation.AdmissionControls
import SFT.Physics.HydrogenRydbergEntryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.HydrogenRydbergEntryEvidence
open SFT.Host.Canonical HydrogenRydbergEntryGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "predecessor",.text (predecessorName c.predecessor)],.array [.text "mass",.text (massName c.mass)],.array [.text "correction",.text (correctionName c.correction)],.array [.text "operation",.text (operationName c.operation)],.array [.text "order",.text (orderName c.order)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "target",.text (targetName c.target)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "trace",.text (traceName c.trace)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "predecessor"),("question",.text "What happens to the admitted hydrogen and proton receipts?"),("choices",.array [.array [.text "replace-or-erase-predecessor",.text "A successor cannot rewrite either immutable derivation."],.array [.text "retain-and-compose-predecessors",.text "The ladder, alpha and terminal proton enclosure remain exact dependencies."]])],.object [("key",.text "mass"),("question",.text "How is finite nuclear mass represented?"),("choices",.array [.array [.text "imported-measured-mass-factor",.text "A measured multiplier would become a proof parameter."],.array [.text "exact-reduced-mass-from-terminal-rho",.text "The already admitted exact rho enclosure forces rho/(rho+1)."]])],.object [("key",.text "correction"),("question",.text "How is the terminal bound-state return formed?"),("choices",.array [.array [.text "untyped-coefficient-list",.text "An untyped list cannot force placement or orientation."],.array [.text "role-typed-alpha-return-chain",.text "Down, binary, colour, complete direction and up carriers fix each alpha return."]])],.object [("key",.text "operation"),("question",.text "How are opposing contributions represented?"),("choices",.array [.array [.text "signed-floating-series",.text "Signed or floating proof scalars violate the exact Fold domain."],.array [.text "ordered-positive-held-Take",.text "The sole opposing return is an ordered exact positive Take."]])],.object [("key",.text "order"),("question",.text "Where does correction order halt?"),("choices",.array [.array [.text "selected-or-open-order",.text "A chosen truncation or open series is a free choice."],.array [.text "finite-carrier-exhaustion-order",.text "The return ends after down, binary, colour, complete direction and up-square carriers act once."]])],.object [("key",.text "composition"),("question",.text "How is the atomic scale formed?"),("choices",.array [.array [.text "answer-only-decimal",.text "An answer-only decimal erases alpha, mass and gap provenance."],.array [.text "alpha-square-times-terminal-scale",.text "Alpha squared over the binary count composes with the full terminal scale and exact line gaps."]])],.object [("key",.text "target"),("question",.text "May a measured Rydberg or line enter execution?"),("choices",.array [.array [.text "measurement-readable-execution",.text "A target-readable execution cannot issue a sealed prediction."],.array [.text "target-inaccessible-until-seal",.text "The formal module contains no external atomic value or source access."]])],.object [("key",.text "provenance"),("question",.text "How is observational development recorded?"),("choices",.array [.array [.text "concealed-development-provenance",.text "Hidden prior observation would misstate the protocol."],.array [.text "disclosed-observational-prediction-protocol",.text "Observation informs the explicit relation; enumeration and sealing precede release."]])],.object [("key",.text "trace"),("question",.text "What proof chain is retained?"),("choices",.array [.array [.text "result-without-root-trace",.text "An untraced physical ratio is inadmissible."],.array [.text "complete-root-directed-trace",.text "Every carrier returns through admitted dependencies to the foundational theorem."]])],.object [("key",.text "extension"),("question",.text "May another correction be appended?"),("choices",.array [.array [.text "free-extra-term",.text "An ungenerated term is a parameter."],.array [.text "no-extra-rule",.text "The declared typed grammar is exhausted and halted."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-ATOMIC-HYDROGEN-RYDBERG-TERMINAL-005"
  title := "Terminal exact hydrogen reduced-mass and Rydberg-scale completion"
  branch := "physics"
  statement := "The terminal proton/electron enclosure forces the finite-nuclear-mass retention rho/(rho+1). The exact Fold carriers then add alpha squared over the down support and alpha cubed over the binary support, hold the complete binary-colour alpha-four return, and restore the up-square alpha-five terminal cell.  Multiplication by alpha squared over two gives the hydrogen ionization/electron-rest carrier, while the immutable three-quarter and five-thirty-sixth gaps give Lyman-alpha and Balmer-alpha."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004", "SFT-PHYS-ATOMIC-CORRECTION-HIERARCHY-004", "SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004", "SFT-PHYS-ATOMIC-HYPERFINE-TERMINAL-005", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-HYDROGEN-RYDBERG-TERMINAL-005",.text generationRule,candidateRecord c])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-HYDROGEN-RYDBERG-TERMINAL-005",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [HydrogenRydbergEntryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (SFT.Foundation.AdmissionControls.admissionIdentity HydrogenRydbergEntryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.HydrogenRydbergEntryEvidence
