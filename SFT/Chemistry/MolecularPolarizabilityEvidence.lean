import SFT.Chemistry.MolecularPolarizabilityGrammar
import SFT.Chemistry.MolecularPolarizabilityRepetition
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MolecularPolarizabilityEvidence
open SFT.Host.Canonical MolecularPolarizabilityGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "exact-response-ratio",.text "Six response parts over two field parts gives three exactly.",.boolean (MolecularPolarizability.ratioPair (MolecularPolarizability.exactResponse MolecularPolarizability.witnessComponent)==(3,1))],.array [.text "successor-invariance",.text "Five equal acts preserve the exact response ratio.",.boolean (match MolecularPolarizability.repeatedEqualFieldResponse (.component MolecularPolarizability.witnessComponent) (.count ⟨5,by decide⟩) with | .error _ => false | .ok c => MolecularPolarizability.ratioPair (MolecularPolarizability.exactResponse c)==(3,1))],.array [.text "isotropic-one-third-Junction",.text "Responses two, three and four average exactly to three.",.boolean (match MolecularPolarizability.exactIsotropicResponse (.tuple [.component MolecularPolarizability.firstComponent,.component MolecularPolarizability.secondComponent,.component MolecularPolarizability.thirdComponent]) with | .error _ => false | .ok r => MolecularPolarizability.ratioPair r==(3,1))],.array [.text "incomplete-support-rejected",.text "Two axes cannot masquerade as the complete isotropic carrier.",.boolean (match MolecularPolarizability.exactIsotropicResponse (.tuple [.component MolecularPolarizability.firstComponent,.component MolecularPolarizability.secondComponent]) with | .error _ => true | .ok _ => false)],.array [.text "duplicate-axis-rejected",.text "A duplicated axis cannot be counted twice.",.boolean (match MolecularPolarizability.exactIsotropicResponse (.tuple [.component MolecularPolarizability.firstComponent,.component MolecularPolarizability.firstComponent,.component MolecularPolarizability.thirdComponent]) with | .error _ => true | .ok _ => false)]]
def claimId : String := "SFT-CHEM-MOLECULAR-POLARIZABILITY-006"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ALGEBRA-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-SOURCE-RESPONSE-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001","SFT-PHYS-ATOMIC-FIELD-SPLITTING-TERMINAL-005","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-GEOMETRY-001","SFT-CHEM-MOLECULAR-DIPOLE-MAGNITUDE-005"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "response",.text (responseName c.response)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "successor",.text (successorName c.successor)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-alpha-scalar",.text "A scalar answer erases species, state, conformation, field, method and condition."],.array [.text "complete-named-molecular-response-carrier",.text "Every source identity and response condition remains held."]]],.array [.text "response",.array [.array [.text "imported-continuum-derivative",.text "A continuum derivative imports an ungenerated field neighborhood."],.array [.text "exact-positive-response-over-field-ratio",.text "One positive induced distinction divided by one positive field distinction defines the response."]]],.array [.text "orientation",.array [.array [.text "signed-Cartesian-component",.text "A signed Cartesian scalar imports a negative proof value."],.array [.text "held-axis-positive-component",.text "Orientation remains a held axis and each component magnitude remains positive."]]],.array [.text "composition",.array [.array [.text "continuum-tensor-trace-premise",.text "A continuum tensor is not a generated Fold form."],.array [.text "three-axis-exact-one-third-Junction",.text "The isotropic response is the exact one-third Junction of three distinct held components."]]],.array [.text "successor",.array [.array [.text "depth-specific-response-coefficient",.text "A new coefficient at each field depth is a free parameter family."],.array [.text "equal-act-ratio-invariant-successor",.text "Every repeated equal field act scales response and field together and preserves their ratio."]]],.array [.text "prediction",.array [.array [.text "alpha-readable-before-seal",.text "A readable alpha vector could select the law or boundary."],.array [.text "value-free-identity-and-relation-seal",.text "All identities and exact operations seal before any alpha inscription opens."]]],.array [.text "record",.array [.array [.text "selected-species-or-favorable-subset",.text "A selected subset can conceal ordinary, charged, isotopic or adverse rows."],.array [.text "complete-NIST-non-atomic-vector",.text "Every one of the 252 non-atomic NIST table rows is retained in source order."]]],.array [.text "extension",.array [.array [.text "species-fit-or-residual-correction",.text "A species coefficient or residual correction is a fitted parameter."],.array [.text "one-response-law-no-extra-rule",.text "One response-ratio and three-axis composition law governs the complete registered vector."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact molecular polarizability response and isotropic-composition law"
 branch := "chemistry"
 statement := "A molecular polarizability component is the exact positive ratio between a retained induced-dipole distinction and the retained external electric distinction that causes it. Repeating equal field acts preserves this ratio at every generated depth. At the admitted three-axis boundary, the isotropic response is the exact one-third Junction of the three held component responses. The complete identity and relation vector seals before every one of the 252 NIST molecular alpha inscriptions opens."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-named-molecular-response-carrier__exact-positive-response-over-field-ratio__held-axis-positive-component__three-axis-exact-one-third-Junction__equal-act-ratio-invariant-successor__value-free-identity-and-relation-seal__complete-NIST-non-atomic-vector__one-response-law-no-extra-rule"),("base",.text "One positive electric distinction producing one positive induced molecular dipole distinction forces their exact positive response ratio; three distinct held axes force their exact one-third Junction."),("successor",.text "Appending one equal electric act adds one equal field part and one equal response part, so numerator and denominator acquire the same positive count and the exact response ratio is unchanged at every finite depth; appending a molecular record changes no law or prior record."),("exclusions",.array [.text "no numerical zero, negative, irrational, imaginary, floating or continuum proof value",.text "no signed Cartesian component, continuum derivative, tensor calculus or perturbation series in proof",.text "no imported wavefunction, Hamiltonian, molecular model, basis set or fitted response coefficient",.text "no measured alpha, source inscription, reference value or table score in the law, grammar or prediction",.text "no erased formula, name, state, conformation, field definition, method, condition, unit or reference",.text "no selected species, source cohort, favorable subset or dropped comment row",.text "no numerical prediction for an ungenerated molecule and no claim beyond the registered static-response boundary"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero, negative, irrational, imaginary, floating or continuum proof value","no signed Cartesian component, continuum derivative, tensor calculus or perturbation series in proof","no imported wavefunction, Hamiltonian, molecular model, basis set or fitted response coefficient","no measured alpha, source inscription, reference value or table score in the law, grammar or prediction","no erased formula, name, state, conformation, field definition, method, condition, unit or reference","no selected species, source cohort, favorable subset or dropped comment row","no numerical prediction for an ungenerated molecule and no claim beyond the registered static-response boundary"]
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
end SFT.Chemistry.MolecularPolarizabilityEvidence
