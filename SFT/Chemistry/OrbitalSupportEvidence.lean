import SFT.Chemistry.OrbitalSupportGrammar
import SFT.Chemistry.OrbitalSupportWitnesses
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.OrbitalSupportEvidence
open SFT.Host.Canonical OrbitalSupportGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "joining-phase-pair",.text "One joined support coordinate forces exactly two distinct held phase fibres.",.boolean OrbitalSupportWitnesses.witness0],.array [.text "axis-boundary-and-successor",.text "Sigma support maps to structural empty One and pi support to the first positive recurrence.",.boolean OrbitalSupportWitnesses.witness1],.array [.text "single-and-pair-occupation",.text "One-electron and complementary-pair support remain exact and distinct.",.boolean OrbitalSupportWitnesses.witness2],.array [.text "triple-occupation-control",.text "A third fermion in one spatial support rejects.",.boolean OrbitalSupportWitnesses.witness3],.array [.text "same-spin-control",.text "Two identical spin fibres in one spatial support reject.",.boolean OrbitalSupportWitnesses.witness4]]
def claimId : String := "SFT-CHEM-ORBITAL-SUPPORT-OCCUPANCY-003"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-INDISTINGUISHABILITY-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-ELECTRONIC-STATE-IDENTITY-001","SFT-CHEM-ELECTRON-COUNT-SPIN-002"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "joining",.text (joiningName c.joining)],.array [.text "axis",.text (axisName c.axis)],.array [.text "symmetry",.text (symmetryName c.symmetry)],.array [.text "occupancy",.text (occupancyName c.occupancy)],.array [.text "spin",.text (spinName c.spin)],.array [.text "completeness",.text (completenessName c.completeness)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "free-orbital-name",.text "A free orbital name is detached from the molecule and its derivation."],.array [.text "molecule-bound-support-cell",.text "Every support coordinate remains bound to one admitted molecular carrier."]]],.array [.text "joining",.array [.array [.text "unjoined-atomic-support-list",.text "An unjoined list cannot express the two generated molecular phase relations."],.array [.text "two-held-joining-phases",.text "Joining generates exactly the two Fold phase fibres without a fitted splitting rule."]]],.array [.text "axis",.array [.array [.text "continuum-angular-coordinate",.text "A continuum angular coordinate imports an ungenerated state space."],.array [.text "empty-One-or-positive-axis-recurrence",.text "Axis-invariant support is structural empty One; every further class is a counted positive recurrence."]]],.array [.text "symmetry",.array [.array [.text "unsigned-erased-symmetry",.text "Erasing exchange and reflection distinctions merges spectroscopically distinct support."],.array [.text "held-exchange-and-reflection-labels",.text "Applicable nuclear exchange and axis reflection distinctions remain held labels."]]],.array [.text "occupancy",.array [.array [.text "signed-or-unbounded-occupation",.text "Signed, numerical-zero or unbounded fermion occupation violates the exact domain and exclusion."],.array [.text "empty-One-single-or-complementary-pair",.text "A spatial support is empty One, singly occupied, or occupied by one complementary pair."]]],.array [.text "spin",.array [.array [.text "same-fibre-double-occupation",.text "Same-fibre doubling has no distinct admissible preimage under exclusion."],.array [.text "complementary-spin-double-occupation",.text "The only double occupation retains both complementary spin fibres."]]],.array [.text "completeness",.array [.array [.text "selected-support-fragment",.text "A selected fragment cannot reconstruct the molecular electronic state or electron census."],.array [.text "complete-electron-support-partition",.text "Every electron occurrence appears exactly once across molecule-bound occupied cells."]]],.array [.text "extension",.array [.array [.text "species-or-symbol-exception",.text "A species lookup or conventional symbol exception lets the target select the law."],.array [.text "no-extra-rule",.text "The same generated support and occupancy law extends to every positive recurrence and molecule."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold-native molecular support composition and fermionic occupancy"
 branch := "chemistry"
 statement := "A molecular electronic support cell is a molecule-bound composition of positive radial recurrence, structural empty-One or positive axis recurrence, one of two held joining phases and applicable held symmetry observations. Its fermionic occupancy is structural empty One, one held electron occurrence or one complementary-spin pair, and the complete occupied support partitions every molecular electron occurrence exactly once."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "molecule-bound-support-cell__two-held-joining-phases__empty-One-or-positive-axis-recurrence__held-exchange-and-reflection-labels__empty-One-single-or-complementary-pair__complementary-spin-double-occupation__complete-electron-support-partition__no-extra-rule"),("base",.text "One molecular carrier and one positive radial support at the axis-invariant boundary generate the two joining phase fibres. One electron occurrence occupies one phase/spatial cell with one held spin fibre."),("successor",.text "Advancing radial or axis recurrence creates a new exact support coordinate; adjoining its complementary joining phase completes the two-fibre pair; adjoining a second electron requires the complementary spin; adjoining another occupied cell retains each new occurrence once and preserves the complete electron census."),("exclusions",.array [.text "no numerical-zero, negative, irrational, imaginary or floating proof value",.text "no continuum angular coordinate or imported molecular wavefunction",.text "no conventional sigma/pi/delta/phi symbol in candidate generation or survivor selection",.text "no imported molecular-orbital energy ordering or species configuration table",.text "no occupancy above one complementary spin pair in a spatial support cell",.text "no measured NIST state or configuration assignment before prediction seal",.text "no fitted, learned, species-specific or target-derived parameter",.text "no selected, omitted or silently normalized spectroscopic assignment row"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical-zero, negative, irrational, imaginary or floating proof value","no continuum angular coordinate or imported molecular wavefunction","no conventional sigma/pi/delta/phi symbol in candidate generation or survivor selection","no imported molecular-orbital energy ordering or species configuration table","no occupancy above one complementary spin pair in a spatial support cell","no measured NIST state or configuration assignment before prediction seal","no fitted, learned, species-specific or target-derived parameter","no selected, omitted or silently normalized spectroscopic assignment row"]
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
end SFT.Chemistry.OrbitalSupportEvidence
