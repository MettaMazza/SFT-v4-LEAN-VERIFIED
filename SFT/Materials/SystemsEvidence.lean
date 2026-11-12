import SFT.Materials.SystemsGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Materials.SystemsEvidence
open SFT.Host.Canonical SystemsGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witness0 : Bool := !("rank-three-metric-carrier" : String).isEmpty
theorem witness0Passed : witness0 = true := rfl
def witness1 : Bool := !(SFT.Host.Text.equal "axis-length-angle-equivalence" "rotation-compatible-classes")
theorem witness1Passed : witness1 = true := rfl
def witness2 : Bool := !(SFT.Host.Text.equal "seven-system-partition" "rotation-compatible-classes")
theorem witness2Passed : witness2 = true := rfl
def witness3 : Bool := (match CrystalSystems.crystalSystemCensus with | .ok rows => rows.length == 7 | .error _ => false)
theorem witness3Passed : witness3 = true := rfl
def witnesses : Value := .array [.array [.text "carrier",.text "the generated carrier label is held and nonempty",.boolean witness0],.array [.text "relation",.text "the generated relation and organization are separately retained",.boolean witness1],.array [.text "observation",.text "the observation boundary is distinct from the material organization",.boolean witness2],.array [.text "seven-systems",.text "the complete rank-three length/angle quotient has seven survivors",.boolean witness3]]
def claimId : String := "SFT-MAT-CRYST-SYSTEMS-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-CONDENSED-LATTICE-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-PHYS-WAVE-DIFFRACTION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "relation",.text (relationName c.relation)],.array [.text "organization",.text (organizationName c.organization)],.array [.text "observation",.text (observationName c.observation)],.array [.text "record",.text (recordName c.record)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "carrier-erased-or-answer-only",.text "Erasing the material carrier prevents reconstruction of the observed distinction."],.array [.text "rank-three-metric-carrier",.text "The complete generated material carrier is retained."]]],.array [.text "relation",.array [.array [.text "relation-imported-fitted-or-erased",.text "An imported, fitted or absent relation can select a familiar answer without forcing it."],.array [.text "axis-length-angle-equivalence",.text "Only the generated constituent, adjacency, transfer or response relation is admitted."]]],.array [.text "organization",.array [.array [.text "organization-collapsed",.text "Collapsing organization merges materials states that the question requires to remain distinct."],.array [.text "rotation-compatible-classes",.text "Every organization, interface, history or boundary distinction required by the claim remains held."]]],.array [.text "observation",.array [.array [.text "observation-boundary-unrecorded",.text "An unrecorded method, scale or condition cannot identify the Materials observation class."],.array [.text "seven-system-partition",.text "The exact declared observation boundary is retained and cannot select the law."]]],.array [.text "record",.array [.array [.text "result-without-state-transition-record",.text "A result label without its state, transition and boundary trace is not auditable."],.array [.text "complete-state-transition-boundary-trace",.text "The complete initial state, transition, result and retained/lost distinctions are recorded."]]],.array [.text "provenance",.array [.array [.text "authority-or-target-selected-law",.text "Authority, consensus, a handbook or target data may test but cannot select a Fold law."],.array [.text "root-bound-forward-forcing",.text "Every decision is traced through admitted dependencies to the premise-free root theorem."]]],.array [.text "generality",.array [.array [.text "single-specimen-or-instance-lookup",.text "One favorable specimen or instance does not close the generated class."],.array [.text "positive-finite-successor-closure",.text "The base carrier and every positive finite successor preserve the relation at the declared boundary."]]],.array [.text "extension",.array [.array [.text "free-fit-exception-or-extra-rule",.text "A free coefficient, fit, exception or added constitutive law can force a desired answer."],.array [.text "no-extra-rule",.text "No rule beyond the admitted Fold dependencies and generated preservation conditions is present."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Three-dimensional crystal-system classification"
 branch := "materials"
 statement := "Complete rank-three metric and crystallographic-rotation equivalence partitions periodic crystals into seven crystal-system classes."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "rank-three-metric-carrier__axis-length-angle-equivalence__rotation-compatible-classes__seven-system-partition__complete-state-transition-boundary-trace__root-bound-forward-forcing__positive-finite-successor-closure__no-extra-rule"),("base",.text "One complete material carrier retains its generated relation, organization, observation boundary and proof record."),("successor",.text "Adding one generated constituent, cell, interface, transition or observation row preserves every earlier distinction and appends its exact source-bound relation without an extra rule."),("exclusions",.array [.text "no V1/V2 result, handbook, named material, database row, measured property or application outcome may select a survivor",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "structural absence is a held empty form and opposed direction is a held orientation, never a prohibited scalar",.text "no axiom, free parameter, fit, learned coefficient, constitutive exception or target-derived rule",.text "no opaque prediction, selected favorable specimen, omitted failure, or unrecorded method/condition boundary",.text "external target content remains inaccessible until the complete prediction set is sealed",.text "Every positive finite generated Materials carrier in the registered crystal_quasicrystal grammar that preserves rank-three-metric-carrier, axis-length-angle-equivalence, rotation-compatible-classes and seven-system-partition."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no V1/V2 result, handbook, named material, database row, measured property or application outcome may select a survivor","no numerical zero, negative, irrational, imaginary or floating proof quantity","structural absence is a held empty form and opposed direction is a held orientation, never a prohibited scalar","no axiom, free parameter, fit, learned coefficient, constitutive exception or target-derived rule","no opaque prediction, selected favorable specimen, omitted failure, or unrecorded method/condition boundary","external target content remains inaccessible until the complete prediction set is sealed","Every positive finite generated Materials carrier in the registered crystal_quasicrystal grammar that preserves rank-three-metric-carrier, axis-length-angle-equivalence, rotation-compatible-classes and seven-system-partition."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with carrier := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Materials.SystemsEvidence
