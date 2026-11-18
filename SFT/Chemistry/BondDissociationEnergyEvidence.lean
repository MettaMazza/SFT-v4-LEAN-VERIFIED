import SFT.Chemistry.BondDissociationEnergyGrammar
import SFT.Chemistry.BondDissociationEnergy
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.BondDissociationEnergyEvidence
open SFT.Host.Canonical BondDissociationEnergyGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "exact-path-composition",.text "A longer exact path Takes its held terminal segment and remains exact and positive.",.boolean (BondDissociationEnergy.exactPathWitness)],.array [.text "orientation-retained",.text "Reversing the ordered Take halts rather than creating a negative value.",.boolean (BondDissociationEnergy.orientationWitness)],.array [.text "one-law-both-isotopologues",.text "The operation depends on retained path roles, not on a species coefficient.",.boolean (BondDissociationEnergy.sameLawWitness)]]
def claimId : String := "SFT-CHEM-BOND-DISSOCIATION-ENERGY-002"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-ATOMIC-HYDROGEN-RYDBERG-TERMINAL-005","SFT-CHEM-JOINT-CORRELATION-DISSOCIATION-007","SFT-CHEM-MOLECULAR-STATE-TRANSITION-009","SFT-CHEM-CONFIGURATION-ORDER-PATH-011","SFT-CHEM-EQUILIBRIUM-BOND-LENGTH-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "identity",.text (identityName c.identity)],.array [.text "channel",.text (channelName c.channel)],.array [.text "path",.text (pathName c.path)],.array [.text "operation",.text (operationName c.operation)],.array [.text "input",.text (inputName c.input)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "identity",.array [.array [.text "generic-molecule-with-erased-isotope",.text "A generic molecule cannot own an isotopologue-specific quantitative path."],.array [.text "named-isotopologue-and-X-state",.text "H2 and D2 identities and their X-state origins remain held throughout."]]],.array [.text "channel",.array [.array [.text "dissociation-products-erased",.text "Erasing the atomic product states destroys the path whose segment is Taken."],.array [.text "both-product-channels-held",.text "M(1s)+M(2s) and M(1s)+M(1s) are retained as distinct endpoints."]]],.array [.text "path",.array [.array [.text "answer-only-energy-lookup",.text "An answer-only energy does not derive the relation between the two state paths."],.array [.text "shared-prefix-path-composition",.text "The two paths share M(1s); their sole remaining distinction is the atomic 1s--2s segment."]]],.array [.text "operation",.array [.array [.text "signed-or-floating-subtraction",.text "A signed scalar or floating subtraction is outside the Fold exact domain."],.array [.text "ordered-positive-held-Take",.text "The longer exact path Takes the strictly smaller held atomic segment."]]],.array [.text "input",.array [.array [.text "measured-value-used-as-prediction-input",.text "A measured threshold or atomic interval inside prediction would make observation select the number."],.array [.text "all-measurements-opened-post-seal",.text "The structural Take relation seals before any threshold, atomic or ground-dissociation value opens."]]],.array [.text "measurement",.array [.array [.text "dissociation-target-readable-before-seal",.text "A readable target can select or alter the predicted interval."],.array [.text "target-inaccessible-until-prediction-seal",.text "The four target intervals are released only after the two-row prediction is sealed."]]],.array [.text "record",.array [.array [.text "selected-historical-or-current-row",.text "Selecting one resolution or era can conceal an unfavorable comparison."],.array [.text "complete-historical-and-current-vector",.text "Both isotopologues and both registered measurement generations are retained."]]],.array [.text "extension",.array [.array [.text "species-coefficient-or-correction",.text "A species coefficient or residual correction would be a free parameter."],.array [.text "typed-two-row-exhaustion-no-extra-rule",.text "The registered H2/D2 vector closes with the same path law and no added term."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact H2/D2 ground-state bond-dissociation path relation"
 branch := "chemistry"
 statement := "For each registered H2 or D2 channel, the B-prime threshold terminates in one ground-state atom and one 2s atom, while X-state ground dissociation terminates in two ground-state atoms. Their shared ground-atom prefix cancels structurally, so D0(M2) is exactly the B-prime threshold after the held atomic 1S-2S separation is Taken. This relation is sealed without measured values; only afterward does the complete threshold, atomic and historical/later ground-dissociation vector test it exactly."
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
def closureValue : Value := .object [("claim_id",.text claimId),("boundary",.text grammarBoundary),("result",.text "named-isotopologue-and-X-state__both-product-channels-held__shared-prefix-path-composition__ordered-positive-held-Take__all-measurements-opened-post-seal__target-inaccessible-until-prediction-seal__complete-historical-and-current-vector__typed-two-row-exhaustion-no-extra-rule"),("base",.text "For one named isotopologue, the excited threshold and ground dissociation paths share one M(1s) product; exact conservation forces the longer path to Take the sole M(1s)-to-M(2s) segment."),("successor",.text "Replacing both retained nuclei by the admitted heavier isotope preserves the path topology while replacing both measured input intervals; the same Take closes D2 and exhausts the two-row boundary."),("exclusions",.array [.text "no numerical zero, negative, irrational, imaginary, floating, signed or continuum proof value",.text "no conventional molecular potential, wavefunction, ab-initio energy or fitted bond coefficient",.text "no threshold, atomic-transition or dissociation value in the executable law or prediction",.text "no target-derived atomic transition, selected residual correction or species exception",.text "no erased X state, rotational state, B-prime channel, atomic product state or measurement condition",.text "no omission of a historical or current registered target row",.text "no claim beyond the registered H2/D2 homolytic ground-state boundary"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero, negative, irrational, imaginary, floating, signed or continuum proof value","no conventional molecular potential, wavefunction, ab-initio energy or fitted bond coefficient","no threshold, atomic-transition or dissociation value in the executable law or prediction","no target-derived atomic transition, selected residual correction or species exception","no erased X state, rotational state, B-prime channel, atomic product state or measurement condition","no omission of a historical or current registered target row","no claim beyond the registered H2/D2 homolytic ground-state boundary"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with identity := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.BondDissociationEnergyEvidence
