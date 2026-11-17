import SFT.Chemistry.StateSymmetryGrammar
import SFT.Chemistry.StateSymmetryWitnesses
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.StateSymmetryEvidence
open SFT.Host.Canonical StateSymmetryGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "sigma-singlet-class",.text "Axis-invariant singlet support forces one component.",.boolean StateSymmetryWitnesses.sigmaClass],.array [.text "pi-doublet-class",.text "First axis recurrence and spin width two force four retained components.",.boolean StateSymmetryWitnesses.piClass],.array [.text "signature-distinction",.text "Changing carrier, axis or held labels changes equivalence class.",.boolean StateSymmetryWitnesses.distinctSignatures],.array [.text "orientation-control",.text "An axis-invariant support with two orientations rejects.",.boolean StateSymmetryWitnesses.badOrientation],.array [.text "component-census-control",.text "An incomplete degeneracy class rejects.",.boolean StateSymmetryWitnesses.incompleteClass]]
def claimId : String := "SFT-CHEM-STATE-SYMMETRY-DEGENERACY-005"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-INDISTINGUISHABILITY-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-CHEM-ELECTRON-COUNT-SPIN-002","SFT-CHEM-ORBITAL-SUPPORT-OCCUPANCY-003","SFT-CHEM-STATE-ENERGY-ORDER-004"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "identity",.text (identityName c.identity)],.array [.text "spin",.text (spinName c.spin)],.array [.text "axis",.text (axisName c.axis)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "symmetry",.text (symmetryName c.symmetry)],.array [.text "class",.text (classAxisName c.classAxis)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "cross-carrier-equivalence",.text "States on different molecules cannot share one declared chemical equivalence class."],.array [.text "one-molecule-equivalence",.text "Every equivalence comparison retains one molecular carrier."]]],.array [.text "identity",.array [.array [.text "energy-only-equivalence",.text "Equal or nearby energy alone erases support and symmetry distinctions."],.array [.text "complete-symmetry-signature",.text "Equivalence requires equality of every retained state/symmetry coordinate."]]],.array [.text "spin",.array [.array [.text "unsigned-or-absent-multiplicity",.text "Erasing positive spin width loses generated component support."],.array [.text "positive-spin-multiplicity",.text "Spin multiplicity remains a positive generated count from held-spin organization."]]],.array [.text "axis",.array [.array [.text "continuum-or-zero-projection",.text "A continuum coordinate or numerical zero violates the generated axis grammar."],.array [.text "empty-One-or-positive-axis-rank",.text "Axis invariance is structural EmptyOne and every non-invariant class a positive recurrence."]]],.array [.text "orientation",.array [.array [.text "free-degeneracy-number",.text "An asserted degeneracy count is an unforced parameter."],.array [.text "one-or-complementary-orientation-support",.text "Axis invariance retains one orientation; positive axis rank forces the complementary orientation pair."]]],.array [.text "symmetry",.array [.array [.text "erased-sign-labels",.text "Erasing inversion, reflection and component labels merges distinguishable terms."],.array [.text "held-symmetry-label-composition",.text "Every applicable symmetry distinction remains a held label; absence remains EmptyOne."]]],.array [.text "class",.array [.array [.text "unbounded-anonymous-members",.text "Anonymous or unbounded members cannot certify degeneracy."],.array [.text "complete-positive-component-class",.text "The equivalence class enumerates exactly spin width times axis-orientation support."]]],.array [.text "extension",.array [.array [.text "term-table-exception",.text "A species or term lookup lets source assignments select the law."],.array [.text "no-extra-rule",.text "The same finite signature and component law applies at every positive multiplicity and axis recurrence."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Finite electronic-state equivalence, degeneracy and retained symmetry"
 branch := "chemistry"
 statement := "At one molecular carrier, electronic states are equivalent exactly when their complete positive-spin, axis-support, inversion, reflection and component signatures agree. Axis-invariant support retains one orientation; every positive axis recurrence retains the complementary orientation pair; the finite equivalence class contains exactly the positive spin multiplicity times the positive orientation count, with every applicable symmetry distinction held and every absent distinction represented only by structural EmptyOne."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-molecule-equivalence__complete-symmetry-signature__positive-spin-multiplicity__empty-One-or-positive-axis-rank__one-or-complementary-orientation-support__held-symmetry-label-composition__complete-positive-component-class__no-extra-rule"),("base",.text "One molecular carrier, spin width One and axis-invariant EmptyOne support force one retained state component; every absent optional symmetry coordinate remains structural EmptyOne."),("successor",.text "Advancing positive spin width adds one component per retained axis orientation; advancing from axis invariance to a positive recurrence forces the complementary orientation pair; adjoining a held symmetry label refines rather than erases the equivalence class."),("exclusions",.array [.text "no numerical zero; glyph 0 is source/interface notation for absence only",.text "no negative, irrational, imaginary, floating or continuum proof value",.text "no imported point group, character table or conventional degeneracy formula in candidate generation",.text "no measured NIST term or symmetry label before prediction seal",.text "no asserted free degeneracy count or species exception",.text "no omitted or normalized-away term assignment",.text "source component glyph 0 normalizes only to structural EmptyOne"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; glyph 0 is source/interface notation for absence only","no negative, irrational, imaginary, floating or continuum proof value","no imported point group, character table or conventional degeneracy formula in candidate generation","no measured NIST term or symmetry label before prediction seal","no asserted free degeneracy count or species exception","no omitted or normalized-away term assignment","source component glyph 0 normalizes only to structural EmptyOne"]
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
end SFT.Chemistry.StateSymmetryEvidence
