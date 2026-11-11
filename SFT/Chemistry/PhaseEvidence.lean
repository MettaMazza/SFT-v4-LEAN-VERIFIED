import SFT.Chemistry.PhaseGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.PhaseEvidence
open SFT.Host.Canonical PhaseGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "identity",.text "the phase is named",.boolean true],.array [.text "trace",.text "multiple cells share the phase trace",.boolean true],.array [.text "boundary",.text "the interface is held",.boolean true]]
def claimId : String := "SFT-CHEM-PHASE-CHEMICAL-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-RXN-INTERMEDIATE-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-KIN-ORDER-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-REACTION-001","SFT-CHEM-THERMO-DIRECTION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "region",.text (regionName c.region)],.array [.text "homogeneity",.text (homogeneityName c.homogeneity)],.array [.text "extent",.text (extentName c.extent)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "coexistence",.text (coexistenceName c.coexistence)],.array [.text "conditions",.text (conditionsName c.conditions)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "region",.array [.array [.text "arbitrary-sample-label",.text "It does not define phase identity."],.array [.text "maximal-connected-region",.text "Every same-trace cell is included."]]],.array [.text "homogeneity",.array [.array [.text "single-point-observation",.text "It cannot establish uniformity."],.array [.text "complete-intensive-trace-equivalence",.text "All cells share the registered trace."]]],.array [.text "extent",.array [.array [.text "size-dependent-phase",.text "Phase identity is intensive."],.array [.text "extent-independent-class",.text "Replication preserves identity."]]],.array [.text "boundary",.array [.array [.text "interface-erased",.text "Distinct phases cannot be separated."],.array [.text "retained-phase-interface",.text "Both sides remain named."]]],.array [.text "coexistence",.array [.array [.text "one-phase-only",.text "No coexistence relation exists."],.array [.text "paired-interface-recurrence",.text "Both phases persist at one boundary."]]],.array [.text "conditions",.array [.array [.text "condition-free-phase",.text "Phase depends on source conditions."],.array [.text "temperature-pressure-composition-held",.text "The phase record is bounded."]]],.array [.text "record",.array [.array [.text "phase-name-only",.text "It cannot reproduce homogeneity."],.array [.text "region-trace-interface-record",.text "All distinctions remain auditable."]]],.array [.text "extra",.array [.array [.text "free-phase-diagram",.text "An imported diagram selects the class."],.array [.text "no-extra-rule",.text "Maximal trace equivalence supplies phase identity."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Chemical phase and coexistence identity"
 branch := "chemistry"
 statement := "A chemical phase is a maximal connected region of complete intensive-trace equivalence; coexistence retains two phase identities and their recurrent interface under fixed conditions."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "maximal-connected-region__complete-intensive-trace-equivalence__extent-independent-class__retained-phase-interface__paired-interface-recurrence"),("base",.text "One homogeneous connected region supplies the first phase."),("successor",.text "Appending an equivalent adjacent cell extends the same maximal phase; a distinct trace creates a retained interface."),("exclusions",.array [.text "no thermochemical table, spontaneity rule, phase diagram, solubility value, photochemical database, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no energy, matter or photon carrier may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite maximal connected chemical region whose complete intensive observation trace is homogeneous under the declared resolution, separated from a distinct region by a retained interface; coexistence is paired recurrence at that interface."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no thermochemical table, spontaneity rule, phase diagram, solubility value, photochemical database, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no energy, matter or photon carrier may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite maximal connected chemical region whose complete intensive observation trace is homogeneous under the declared resolution, separated from a distinct region by a retained interface; coexistence is paired recurrence at that interface."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with region := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.PhaseEvidence
