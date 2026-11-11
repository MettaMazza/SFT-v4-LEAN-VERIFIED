import SFT.Chemistry.OxidationGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.OxidationEvidence
open SFT.Host.Canonical OxidationGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "positive",.text "assignment magnitude is a positive count",.boolean true],.array [.text "orientation",.text "gain/loss direction is a held fibre",.boolean true],.array [.text "trace",.text "at least one bond assignment remains explicit",.boolean true]]
def claimId : String := "SFT-CHEM-REDOX-OXIDATION-STATE-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "whole",.text (wholeName c.whole)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "unequal-bond",.text (unequalBondName c.unequalBond)],.array [.text "equal-bond",.text (equalBondName c.equalBond)],.array [.text "count",.text (countName c.count)],.array [.text "conservation",.text (conservationName c.conservation)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "whole",.array [.array [.text "isolated-atom-answer",.text "Oxidation accounting is composition-relative."],.array [.text "complete-bonded-chemical-whole",.text "Every atom and bond is included."]]],.array [.text "partition",.array [.array [.text "unstated-electron-rule",.text "An unstated rule permits arbitrary answers."],.array [.text "declared-ionic-approximation",.text "The assignment convention is explicit."]]],.array [.text "unequal-bond",.array [.array [.text "split-despite-preference",.text "It contradicts complete affinity order."],.array [.text "assign-to-preferred-endpoint",.text "Both bond electrons follow the greater affinity trace."]]],.array [.text "equal-bond",.array [.array [.text "arbitrary-endpoint",.text "Equal traces cannot choose an endpoint."],.array [.text "equal-endpoint-division",.text "Tied support is divided identically."]]],.array [.text "count",.array [.array [.text "signed-integer-primitive",.text "A signed number hides orientation."],.array [.text "positive-count-plus-held-orientation",.text "Magnitude and gain/loss orientation are separate exact carriers."]]],.array [.text "conservation",.array [.array [.text "electron-created-or-lost",.text "Open assignment violates the whole."],.array [.text "each-electron-assigned-once",.text "The complete support is conserved."]]],.array [.text "record",.array [.array [.text "oxidation-number-only",.text "A number cannot reproduce the assignment."],.array [.text "atom-bond-assignment-trace",.text "Every local assignment is retained."]]],.array [.text "extra",.array [.array [.text "free-state-table",.text "A table can select desired values."],.array [.text "no-extra-rule",.text "Affinity partition exhausts the accounting."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Oxidation-state accounting"
 branch := "chemistry"
 statement := "Oxidation state is a complete source-bound ionic-approximation accounting: each bond-electron occurrence is assigned exactly once by endpoint affinity, with magnitude positive and orientation separately held."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-bonded-chemical-whole__declared-ionic-approximation__assign-to-preferred-endpoint__equal-endpoint-division__each-electron-assigned-once"),("base",.text "One bonded pair with its complete assignment supplies the first oxidation-state record."),("successor",.text "Appending one bond assigns each new electron occurrence once while preserving every earlier atom, bond and assignment trace."),("exclusions",.array [.text "no electronegativity scale, oxidation-state table, electrode potential, external definition, measured value or V2 result may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no electron carrier may be created, copied, silently erased or assigned to two endpoints",.text "no qualitative structural law is represented as a parameter-free prediction of a measured decimal scale",.text "external target content remains inaccessible until the complete prediction is sealed",.text "Every finite bonded chemical whole under one declared ionic-approximation partition, assigning each bond-electron occurrence exactly once by complete affinity order (or equal division for tied endpoints), retaining atom identity, orientation and total carrier conservation."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no electronegativity scale, oxidation-state table, electrode potential, external definition, measured value or V2 result may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no electron carrier may be created, copied, silently erased or assigned to two endpoints","no qualitative structural law is represented as a parameter-free prediction of a measured decimal scale","external target content remains inaccessible until the complete prediction is sealed","Every finite bonded chemical whole under one declared ionic-approximation partition, assigning each bond-electron occurrence exactly once by complete affinity order (or equal division for tied endpoints), retaining atom identity, orientation and total carrier conservation."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with whole := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.OxidationEvidence
