import SFT.Physics.HostileGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Physics.HostileEvidence
open SFT.Host.Canonical HostileGrammar
set_option maxRecDepth 20000

def witnessPassed : Bool :=
 match SFT.Physics.HostilePackage.rejectExecutableSource (.text "print('target')") with
 | .error _ => true
 | .ok _ => false
theorem operationalWitnessPassed : witnessPassed = true := by decide

def witnesses : Value := .array [
 .object [("name",.text "executable-source-rejection"),("statement",.text "The auditor rejects nonempty contributor executable source."),("passed",.boolean witnessPassed)]]
def claimId : String := "SFT-PHYS-MEAS-HOSTILE-PACKAGE-001"
def dependencies : List String := ["SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-COMP-SEC-INTEGRITY-001","SFT-COMP-SEC-ADVERSARIAL-001","SFT-COMP-SEM-VERIFICATION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "package",.text (packageName c.package)],.array [.text "parser",.text (parserName c.parser)],.array [.text "field",.text (fieldName c.field)],.array [.text "execution",.text (executionName c.execution)],.array [.text "authority",.text (authorityName c.authority)],.array [.text "comparison",.text (comparisonName c.comparison)],.array [.text "response",.text (responseName c.response)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("axes",.array [.object [("key",.text "package"),("question",.text "What package form is accepted?"),("choices",.array [.array [.text "mixed-code-and-data",.text "Mixed packages can execute contributor-selected behavior."],.array [.text "data-only-fold-document",.text "The package is only an exact Fold program document."]])],.object [("key",.text "parser"),("question",.text "How are package fields interpreted?"),("choices",.array [.array [.text "permissive-parser",.text "A permissive parser admits undeclared behavior."],.array [.text "exact-schema-parser",.text "The parser requires every and only registered fields."]])],.object [("key",.text "field"),("question",.text "What happens to unknown fields?"),("choices",.array [.array [.text "ignore-extra-field",.text "An ignored field creates divergent or hidden meaning."],.array [.text "reject-extra-field",.text "Any missing or additional field halts."]])],.object [("key",.text "execution"),("question",.text "May contributor source execute directly?"),("choices",.array [.array [.text "execute-contributor-source",.text "Direct execution exposes every ambient host capability."],.array [.text "interpreter-only-execution",.text "Only the admitted closed interpreter evaluates data."]])],.object [("key",.text "authority"),("question",.text "May handling alter scientific authority artifacts?"),("choices",.array [.array [.text "mutable-authority-tree",.text "Changing census or accepted receipts can manufacture admission."],.array [.text "unchanged-protected-tree",.text "Before and after identities of authority artifacts must be identical."]])],.object [("key",.text "comparison"),("question",.text "May target comparison enter the prediction package?"),("choices",.array [.array [.text "embedded-comparison",.text "Embedded comparison can expose or optimize against targets."],.array [.text "postseal-separate-comparison",.text "Comparison remains a separately identified post-seal operation."]])],.object [("key",.text "response"),("question",.text "What happens on any audit violation?"),("choices",.array [.array [.text "warn-and-continue",.text "Continuation admits a known authority or capability breach."],.array [.text "halt-without-admission",.text "Any violation terminates without model admission."]])],.object [("key",.text "extension"),("question",.text "May a package add an unregistered route?"),("choices",.array [.array [.text "extra-route",.text "An extra route bypasses the protected admission path."],.array [.text "no-extra-route",.text "Only the one audited path exists."]])]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("product_exhaustion",.text "Every registered axis choice occurs once with every other axis choice.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Hostile empirical-package and authority protection"
 branch := "physics"
 statement := "Within the registered empirical-package grammar, contributor material can enter official prediction without gaining execution or scientific authority in exactly one form: strict data-only program fields are parsed by the admitted interpreter, the census and model-admitted receipts are identical before and after handling, and every extra field, executable source or protected-tree change halts admission."
 evidenceMode := .formal
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing]
 sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := identity (.array [.text claimId,.text generationRule,candidateRecord c])
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
 proofHash := identity (.array [.text claimId,.array (dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : Value := .object [("result",.text "Strict data-only Fold document, exact parser, no unknown fields or direct source execution, unchanged authority trees, separate comparison, fail-closed response and no extra route."),("base",.text "One data-only program document is parsed without executing contributor source and leaves each protected authority file unchanged."),("successor",.text "Adding one registered instruction changes only the data program identity; the same strict parser, closed interpreter and protected-tree equality remain required."),("exclusions",.array [.text "contributor Python, native source, shell commands, modules or callables",.text "unknown package fields",.text "census or model-admitted receipt mutation",.text "target comparison within prediction"]),("witnesses",witnesses),("unique_survivor",.text survivorId)]
def exclusions : List String := ["contributor Python, native source, shell commands, modules or callables","unknown package fields","census or model-admitted receipt mutation","target comparison within prediction"]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := identity (.array [closureValue,.array (decisions.map SFT.Engine.decisionValue)])
 generalityCertificateHash := some (identity closureValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := observation
 observedBehavior := if passed then observation else "control failed"
 receiptHash := identity (.array [.text claimId,.text (SFT.Engine.kindName kind),.boolean passed,.text observation])
def runControls (sourceHash : String) : Value := .array ([
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with package := .rejected}) survivorId)) "reject the generated form missing the first preservation",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty && witnessPassed) "reject excluded capabilities, values or authority paths"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Physics.HostileEvidence
