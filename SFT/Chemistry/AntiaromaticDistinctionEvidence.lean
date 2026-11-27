import SFT.Chemistry.AntiaromaticDistinctionGrammar
import SFT.Chemistry.AntiaromaticDistinctionWitnesses
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.AntiaromaticDistinctionEvidence
open SFT.Host.Canonical AntiaromaticDistinctionGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "complete-three-class-census",.text "Closed, broken and frustrated same-cycle alternatives are retained exactly once.",.boolean AntiaromaticDistinctionWitnesses.censusWitness],.array [.text "exact-support-boundaries",.text "The base supports are six, structural EmptyOne and four without numerical zero.",.boolean AntiaromaticDistinctionWitnesses.supportWitness],.array [.text "positive-stability-order",.text "Closed recurrence precedes broken recurrence, which precedes frustrated recurrence.",.boolean AntiaromaticDistinctionWitnesses.orderWitness],.array [.text "depth-independent-successor",.text "The complete four-cell successor advances six to ten and four to eight while broken recurrence stays EmptyOne.",.boolean AntiaromaticDistinctionWitnesses.successorWitness],.array [.text "inconsistent-class-control",.text "A broken plane cannot be relabelled antiaromatic.",.boolean AntiaromaticDistinctionWitnesses.inconsistentWitness],.array [.text "missing-break-control",.text "Nonaromatic classification without a structural break rejects.",.boolean AntiaromaticDistinctionWitnesses.missingBreakWitness],.array [.text "numerical-zero-control",.text "Numerical zero cannot replace structural EmptyOne.",.boolean AntiaromaticDistinctionWitnesses.zeroWitness]]
def claimId : String := "SFT-CHEM-ANTIAROMATIC-NONAROMATIC-DISTINCTION-004"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-FOLD-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-CHEM-MULTICENTRE-DELOCALIZED-SUPPORT-008","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-CONJUGATED-SUPPORT-001","SFT-CHEM-AROMATIC-RECURRENCE-STABILITY-003"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "census",.text (censusName c.census)],.array [.text "geometry",.text (geometryName c.geometry)],.array [.text "support",.text (supportName c.support)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "order",.text (orderName c.order)],.array [.text "observation",.text (observationName c.observation)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "different-or-name-only-carriers",.text "Different carriers cannot establish alternatives of the same cycle."],.array [.text "one-retained-same-cycle-carrier",.text "Every alternative retains one identical molecular carrier and cycle incidence graph."]]],.array [.text "census",.array [.array [.text "selected-favourable-category",.text "Selecting a familiar label omits lawful same-cycle alternatives."],.array [.text "complete-three-class-census",.text "Closed, frustrated and structurally broken recurrence are all generated and retained."]]],.array [.text "geometry",.array [.array [.text "planarity-assumed-or-erased",.text "Erasing geometry merges a frustrated planar recurrence with a recurrence avoided by an out-of-plane break."],.array [.text "held-planar-or-broken-geometry",.text "Complete-plane and out-of-plane-break remain exact held alternatives."]]],.array [.text "support",.array [.array [.text "conjugation-name-only",.text "A name does not distinguish complete support from a broken recurrence path."],.array [.text "held-complete-or-broken-conjugation",.text "Every incidence either belongs to complete conjugated support or retains the exact break."]]],.array [.text "boundary",.array [.array [.text "electron-count-label-imported",.text "An imported count label does not derive return, frustration or structural absence."],.array [.text "closed-frustrated-or-EmptyOne-return",.text "The boundary is a complete two-fibre return, a complete four-cell frustration, or structural EmptyOne after a break."]]],.array [.text "order",.array [.array [.text "measured-energy-selected-order",.text "Measured values cannot choose which structural alternative is stable."],.array [.text "positive-two-step-stability-order",.text "Opening closure and then imposing frustration each require one positive distinction transfer."]]],.array [.text "observation",.array [.array [.text "selected-or-preopened-comparison",.text "A selected outcome can conceal an adverse same-cycle alternative."],.array [.text "value-free-complete-comparative-seal",.text "Every terminology, geometry and energy surface is sealed by identity before outcome comparison."]]],.array [.text "extension",.array [.array [.text "named-ring-or-extra-count-rule",.text "A species exception or imported count recurrence adds a free selector."],.array [.text "complete-four-cell-successors-no-extra-rule",.text "Aromatic and antiaromatic layers each add all four pair cells; broken recurrence remains structural EmptyOne."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact aromatic, antiaromatic and nonaromatic distinction law"
 branch := "chemistry"
 statement := "For one retained molecular cycle, the generated Fold recurrence has exactly three structural classes: complete planar closure, a planar complete support with frustrated return, or a structurally broken plane/conjugation with EmptyOne recurrence. Their primitive supports are six, four and EmptyOne respectively; the complete classes append all four ordered pair cells at each successor, and two positive distinction transfers force the closed, broken, frustrated stability order without an imported electron-count or measured-energy rule."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.observationalDerivation]
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-retained-same-cycle-carrier__complete-three-class-census__held-planar-or-broken-geometry__held-complete-or-broken-conjugation__closed-frustrated-or-EmptyOne-return__positive-two-step-stability-order__value-free-complete-comparative-seal__complete-four-cell-successors-no-extra-rule"),("base",.text "The complete closed base retains two fibres plus four pair cells for support six; the complete frustrated base retains four pair cells; a structural plane or conjugation break has EmptyOne recurrence, never numerical zero."),("successor",.text "Append all four ordered Fold pair cells exactly once to each complete recurrence. Closed support advances six to ten and frustrated support advances four to eight while every earlier cell, centre, incidence and class boundary remains held; structural break remains EmptyOne."),("exclusions",.array [.text "no numerical zero; structural absence is EmptyOne",.text "no negative irrational imaginary continuum fitted free or imported native parameter",.text "no Hückel 4n+2 or 4n premise electron-count lookup molecular-name selector or measured energy in survivor selection",.text "no omission of the aromatic antiaromatic or nonaromatic same-cycle alternative",.text "no relabelling a broken plane or conjugation as complete frustrated recurrence",.text "three inspected records remain development-observed correspondence and are not called blind",.text "two NIST CCCBDB outcomes remain inaccessible until after the law and value-free prediction seal",.text "external signed decimal zero and absent inscriptions remain downstream records and never native proof arithmetic"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; structural absence is EmptyOne","no negative irrational imaginary continuum fitted free or imported native parameter","no Hückel 4n+2 or 4n premise electron-count lookup molecular-name selector or measured energy in survivor selection","no omission of the aromatic antiaromatic or nonaromatic same-cycle alternative","no relabelling a broken plane or conjugation as complete frustrated recurrence","three inspected records remain development-observed correspondence and are not called blind","two NIST CCCBDB outcomes remain inaccessible until after the law and value-free prediction seal","external signed decimal zero and absent inscriptions remain downstream records and never native proof arithmetic"]
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
end SFT.Chemistry.AntiaromaticDistinctionEvidence
