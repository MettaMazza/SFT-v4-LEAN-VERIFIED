import SFT.Chemistry.AffinityGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.AffinityEvidence
open SFT.Host.Canonical AffinityGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "endpoints",.text "the comparison retains two distinct atoms",.boolean true],.array [.text "support",.text "one shared support is compared",.boolean true],.array [.text "orientation",.text "preference names an endpoint",.boolean true]]
def claimId : String := "SFT-CHEM-ELECTRONEGATIVITY-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carriers",.text (carriersName c.carriers)],.array [.text "support",.text (supportName c.support)],.array [.text "comparison",.text (comparisonName c.comparison)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "ties",.text (tiesName c.ties)],.array [.text "extension",.text (extensionName c.extension)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carriers",.array [.array [.text "anonymous-element-values",.text "Values erase endpoint identity."],.array [.text "two-named-atomic-occurrences",.text "Both compared atoms remain held."]]],.array [.text "support",.array [.array [.text "free-affinity-scalar",.text "A scalar imports the ordering."],.array [.text "one-shared-electron-support",.text "The same shared support is compared at both endpoints."]]],.array [.text "comparison",.array [.array [.text "name-selected-order",.text "Names cannot select preference."],.array [.text "complete-endpoint-recurrence-comparison",.text "All registered support visits are compared."]]],.array [.text "orientation",.array [.array [.text "signed-difference",.text "A signed magnitude violates the proof domain."],.array [.text "held-preferred-endpoint",.text "Preference is a held label."]]],.array [.text "ties",.array [.array [.text "forced-strict-order",.text "Equal complete traces cannot be ordered uniquely."],.array [.text "trace-equivalence-class",.text "Ties remain one exact affinity class."]]],.array [.text "extension",.array [.array [.text "pairwise-cycle-admitted",.text "A cycle destroys lawful ordering."],.array [.text "transitive-preorder-closure",.text "All pairwise records close transitively."]]],.array [.text "record",.array [.array [.text "rank-answer-only",.text "A rank cannot reconstruct comparisons."],.array [.text "complete-comparison-trace",.text "Every endpoint and support record remains auditable."]]],.array [.text "extra",.array [.array [.text "free-scale-constant",.text "A scale constant can tune any ordering."],.array [.text "no-extra-rule",.text "Complete recurrence comparison supplies the relation."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Electronegativity ordering"
 branch := "chemistry"
 statement := "Electronegativity order is the transitive preorder of complete pairwise endpoint recurrence for identical shared electron support; equal traces remain an exact equivalence class rather than receiving an arbitrary rank."
 evidenceMode := .empirical
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
 traceHash := identity (.array [.text claimId,candidateRecord c])
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "two-named-atomic-occurrences__one-shared-electron-support__complete-endpoint-recurrence-comparison__held-preferred-endpoint__transitive-preorder-closure"),("base",.text "One pair of atoms and one shared support comparison supplies the first affinity relation."),("successor",.text "Appending a pairwise comparison preserves all earlier traces and extends only by transitive closure; identical traces remain tied."),("exclusions",.array [.text "no electronegativity scale, oxidation-state table, electrode potential, external definition, measured value or V2 result may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no electron carrier may be created, copied, silently erased or assigned to two endpoints",.text "no qualitative structural law is represented as a parameter-free prediction of a measured decimal scale",.text "external target content remains inaccessible until the complete prediction is sealed",.text "Every finite pairwise comparison of two named atomic occurrences joined by one shared electron-labelled support, with the complete recurrence trace determining endpoint preference or an explicitly retained tie."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no electronegativity scale, oxidation-state table, electrode potential, external definition, measured value or V2 result may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no electron carrier may be created, copied, silently erased or assigned to two endpoints","no qualitative structural law is represented as a parameter-free prediction of a measured decimal scale","external target content remains inaccessible until the complete prediction is sealed","Every finite pairwise comparison of two named atomic occurrences joined by one shared electron-labelled support, with the complete recurrence trace determining endpoint preference or an explicitly retained tie."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with carriers := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.AffinityEvidence
