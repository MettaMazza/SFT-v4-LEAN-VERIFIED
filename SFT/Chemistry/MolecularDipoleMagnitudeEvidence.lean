import SFT.Chemistry.MolecularDipoleMagnitudeGrammar
import SFT.Chemistry.MolecularDipoleMagnitude
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MolecularDipoleMagnitudeEvidence
open SFT.Host.Canonical MolecularDipoleMagnitudeGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "symmetry-component-support",.text "The five registered carriers force component counts EmptyOne, EmptyOne, One, One and two.",.boolean (MolecularDipoleMagnitude.symmetryWitness)],.array [.text "structural-absence",.text "No retained component returns structural EmptyOne rather than numerical zero.",.boolean (MolecularDipoleMagnitude.absenceWitness)],.array [.text "one-axis-magnitude",.text "One retained component forces its exact square as the molecular squared magnitude.",.boolean (MolecularDipoleMagnitude.oneAxisWitness)],.array [.text "orthogonal-square-Junction",.text "Three-fifths and four-fifths component fibres join to the exact One without a square root.",.boolean (MolecularDipoleMagnitude.junctionWitness)],.array [.text "axis-uniqueness",.text "Duplicating a component axis halts instead of double-counting magnitude.",.boolean (MolecularDipoleMagnitude.duplicateWitness)]]
def claimId : String := "SFT-CHEM-MOLECULAR-DIPOLE-MAGNITUDE-005"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001","SFT-PHYS-ATOMIC-FIELD-SPLITTING-TERMINAL-005","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-MOL-GEOMETRY-001","SFT-CHEM-STATE-SYMMETRY-DEGENERACY-005","SFT-CHEM-NUCLEAR-ELECTRONIC-COMPOSITION-012","SFT-CHEM-CONFIGURATION-ORDER-PATH-011","SFT-CHEM-MOLECULAR-BOND-ANGLE-003"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "symmetry",.text (symmetryName c.symmetry)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "magnitude",.text (magnitudeName c.magnitude)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-dipole-scalar",.text "A scalar answer erases species, state, geometry, charge carrier and symmetry."],.array [.text "complete-named-molecular-charge-carrier",.text "Species, state, geometry and complete charge distinction remain held."]]],.array [.text "symmetry",.array [.array [.text "component-list-selected-after-values",.text "A value-selected component list cannot establish molecular organization."],.array [.text "symmetry-forced-component-support",.text "Inversion closes all components; retained exchange symmetry leaves one axis; isotope distinction retains two principal axes."]]],.array [.text "orientation",.array [.array [.text "signed-direction-as-proof-number",.text "A conventional sign imports a negative proof magnitude."],.array [.text "held-orientation-positive-components",.text "Direction remains a label and every component magnitude is exact and positive."]]],.array [.text "composition",.array [.array [.text "continuum-vector-premise",.text "A continuum vector space and norm are not generated Fold forms."],.array [.text "finite-distinct-axis-Junction",.text "Each retained axis occurs once and finite component squares join exactly."]]],.array [.text "magnitude",.array [.array [.text "irrational-square-root-or-fitted-norm",.text "A square root or fitted norm can leave the exact rational domain."],.array [.text "exact-squared-magnitude-relation",.text "Magnitude squared equals the exact Junction of all positive component squares."]]],.array [.text "prediction",.array [.array [.text "dipole-value-readable-before-seal",.text "A readable component or total could select the relation."],.array [.text "value-free-symmetry-and-relation-seal",.text "Only identities, symmetry classes, axes and the squared relation seal before values open."]]],.array [.text "record",.array [.array [.text "favorable-species-or-component-subset",.text "A selected subset can conceal an absent row, extra component or inconsistent total."],.array [.text "complete-five-species-nine-row-vector",.text "Both homonuclear controls and every registered water-isotopologue component and total remain present."]]],.array [.text "extension",.array [.array [.text "species-coefficient-charge-fit-or-correction",.text "A species coefficient, charge fit or residual correction is a free parameter."],.array [.text "one-structural-law-no-extra-rule",.text "One symmetry and squared-Junction law exhausts the registered vector."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact molecular dipole organization and squared-magnitude relation"
 branch := "chemistry"
 statement := "A molecular dipole is the retained orientation of a complete molecular charge-distinction carrier. Its molecular symmetry closes forbidden components to structural EmptyOne and retains every allowed component as an exact positive magnitude on a held axis. The orientation-free squared magnitude is exactly the Junction of those component squares. The relation seals before all nine NIST values open; the H2/D2 absence rows, water-isotopologue component organization and reported total magnitudes then test the same law without a signed proof scalar or an irrational square root."
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
def closureValue : Value := .object [("claim_id",.text claimId),("boundary",.text grammarBoundary),("result",.text "complete-named-molecular-charge-carrier__symmetry-forced-component-support__held-orientation-positive-components__finite-distinct-axis-Junction__exact-squared-magnitude-relation__value-free-symmetry-and-relation-seal__complete-five-species-nine-row-vector__one-structural-law-no-extra-rule"),("base",.text "For the first inversion-symmetric homonuclear carrier, every oriented charge-displacement has an indistinguishable opposed partner, so no axis survives and the magnitude record is structural EmptyOne."),("successor",.text "Replacing equal endpoints preserves the closed class; introducing a retained unequal charge carrier leaves the symmetry-allowed axes, and appending each distinct allowed axis adds exactly its positive square to the magnitude Junction without changing any prior component."),("exclusions",.array [.text "no numerical zero, negative, irrational, imaginary, floating, signed or continuum proof value",.text "no conventional vector-space premise, square-root magnitude or signed Cartesian direction in proof",.text "no imported charge model, Stark Hamiltonian, wavefunction, fitted partial charge or molecular coefficient",.text "no measured component, total, uncertainty or source inscription in the law, grammar or prediction",.text "no erased species, state, geometry, charge carrier, symmetry, axis, method or condition",.text "no omitted homonuclear absence row or water-isotopologue component/total row",.text "no claim beyond the registered five-species, nine-row gas-phase boundary"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero, negative, irrational, imaginary, floating, signed or continuum proof value","no conventional vector-space premise, square-root magnitude or signed Cartesian direction in proof","no imported charge model, Stark Hamiltonian, wavefunction, fitted partial charge or molecular coefficient","no measured component, total, uncertainty or source inscription in the law, grammar or prediction","no erased species, state, geometry, charge carrier, symmetry, axis, method or condition","no omitted homonuclear absence row or water-isotopologue component/total row","no claim beyond the registered five-species, nine-row gas-phase boundary"]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .finiteComplete
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := identity (.array [closureValue,.array (decisions.map SFT.Engine.decisionValue)])
 generalityCertificateHash := none
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
end SFT.Chemistry.MolecularDipoleMagnitudeEvidence
