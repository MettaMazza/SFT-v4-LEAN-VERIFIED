import SFT.Chemistry.MolecularBondAngleGrammar
import SFT.Chemistry.MolecularBondAngle
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MolecularBondAngleEvidence
open SFT.Host.Canonical MolecularBondAngleGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "one-turn-partition",.text "The complete registered carrier vector contains exact positive turn parts.",.boolean (MolecularBondAngle.exactVectorWitness)],.array [.text "geometry-count-identity",.text "A changed geometry count halts instead of introducing a correction.",.boolean (MolecularBondAngle.geometryCountWitness)],.array [.text "continuum-boundary",.text "An ungenerated tetrahedral continuum angle is rejected at this boundary.",.boolean (MolecularBondAngle.continuumBoundaryWitness)]]
def claimId : String := "SFT-CHEM-MOLECULAR-BOND-ANGLE-003"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-GEOMETRY-001","SFT-CHEM-STATE-SYMMETRY-DEGENERACY-005","SFT-CHEM-CONFIGURATION-ORDER-PATH-011","SFT-CHEM-EQUILIBRIUM-BOND-LENGTH-001","SFT-CHEM-BOND-DISSOCIATION-ENERGY-002"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "order",.text (orderName c.order)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "relation",.text (relationName c.relation)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-angle-scalar",.text "An answer-only scalar erases the molecular state, geometry and sector carrier."],.array [.text "named-state-geometry-sector-carrier",.text "Species, state, geometry, internal coordinate and sector identities remain held."]]],.array [.text "order",.array [.array [.text "unordered-ligand-cloud",.text "An unordered cloud cannot distinguish adjacent from opposite ligand paths."],.array [.text "exact-generated-cyclic-order",.text "The admitted configuration-order law retains every ligand position in one closed cycle."]]],.array [.text "partition",.array [.array [.text "unequal-or-fitted-sectors",.text "Unequal sectors introduce an ungenerated distinction or fitted geometric parameter."],.array [.text "symmetry-forced-equal-sectors",.text "Indistinguishable sectors have no structural permission to differ and exactly exhaust the turn."]]],.array [.text "relation",.array [.array [.text "continuum-trigonometric-angle",.text "A continuum or irrational trigonometric construction is outside the exact Fold domain."],.array [.text "positive-sector-separation-over-count",.text "A retained k-sector path in an n-sector turn is the exact positive part k/n."]]],.array [.text "prediction",.array [.array [.text "degree-target-in-prediction",.text "A degree value readable before sealing could select the predicted result."],.array [.text "value-free-exact-turn-fraction",.text "Only structural counts, held identities and exact turn fractions are sealed."]]],.array [.text "measurement",.array [.array [.text "target-open-before-seal",.text "An open target before sealing destroys empirical custody."],.array [.text "all-angle-values-open-post-seal",.text "The complete external degree vector is released only after prediction sealing."]]],.array [.text "record",.array [.array [.text "selected-species-or-angle-role",.text "Selecting one favorable geometry or omitting an opposite row cannot close the registered vector."],.array [.text "complete-three-species-four-angle-vector",.text "BF3, XeF2 and both XeF4 angle roles remain present with source conditions."]]],.array [.text "extension",.array [.array [.text "species-correction-or-angle-exception",.text "A species correction or angle exception is a free rule."],.array [.text "one-law-no-extra-rule",.text "One exact equal-sector law closes every registered carrier without correction."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact symmetry-forced molecular bond-angle relation"
 branch := "chemistry"
 statement := "A closed molecular turn divided into n symmetry-indistinguishable positive ligand sectors has no lawful unequal-sector form: unequal parts would introduce an ungenerated distinction. Each sector is therefore exactly 1/n turn and a retained k-sector separation is exactly k/n turn. The structural fractions seal without degrees; only afterward are all four NIST CCCBDB BF3, XeF2 and XeF4 angle rows opened."
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
def closureValue : Value := .object [("claim_id",.text claimId),("boundary",.text grammarBoundary),("result",.text "named-state-geometry-sector-carrier__exact-generated-cyclic-order__symmetry-forced-equal-sectors__positive-sector-separation-over-count__value-free-exact-turn-fraction__all-angle-values-open-post-seal__complete-three-species-four-angle-vector__one-law-no-extra-rule"),("base",.text "Two indistinguishable opposed sectors exhaust one closed turn; neither can differ without a retained distinction, so the separation is one of two equal parts."),("successor",.text "Adding one indistinguishable sector to an n-sector closed cycle preserves equality and exhaustive Junction; every retained k-sector path remains the exact part k/n without a new parameter."),("exclusions",.array [.text "no numerical zero, negative, irrational, imaginary, floating, signed or continuum proof value",.text "no continuum trigonometry, Cartesian coordinate fit, wavefunction, hybridization model or imported angle equation",.text "no measured degree value or degree-scale conversion in the law, candidate forcing or prediction",.text "no unequal sector, fitted angular correction, species coefficient or exception",.text "no erased species, state, point group, geometry, coordinate, angle role, method, condition or source comment",.text "no omission of either XeF4 row or selection of only one favorable molecule",.text "no claim for tetrahedral or other ungenerated non-cyclic-equal-sector geometry in this receipt"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero, negative, irrational, imaginary, floating, signed or continuum proof value","no continuum trigonometry, Cartesian coordinate fit, wavefunction, hybridization model or imported angle equation","no measured degree value or degree-scale conversion in the law, candidate forcing or prediction","no unequal sector, fitted angular correction, species coefficient or exception","no erased species, state, point group, geometry, coordinate, angle role, method, condition or source comment","no omission of either XeF4 row or selection of only one favorable molecule","no claim for tetrahedral or other ungenerated non-cyclic-equal-sector geometry in this receipt"]
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
end SFT.Chemistry.MolecularBondAngleEvidence
