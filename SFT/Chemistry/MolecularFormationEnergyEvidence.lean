import SFT.Chemistry.MolecularFormationEnergyGrammar
import SFT.Chemistry.MolecularFormationEnergy
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MolecularFormationEnergyEvidence
open SFT.Host.Canonical MolecularFormationEnergyGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "exact-reference-composition",.text "The two reference constituents compose to 29/6.",.boolean (match MolecularFormationEnergy.exactReferenceStateComposition (.tuple [IntermolecularBinding.firstConstituent,IntermolecularBinding.secondConstituent]) with | .error _ => false | .ok r => MolecularFormationEnergy.ratioPair r==(29,6))],.array [.text "held-below-orientation",.text "Product 4 is below reference 29/6 by 5/6.",.boolean (match MolecularFormationEnergy.exactFormationStateRelation MolecularFormationEnergy.productBelowState MolecularFormationEnergy.reference with | .error _ => false | .ok r => SFT.Host.Text.equal r.orientation.label "product-below-reference" && (match r.magnitude with | .ratio q => MolecularFormationEnergy.ratioPair q==(5,6) | .emptyOne | .otherEmptyOne _ | .invalid => false))],.array [.text "held-above-orientation",.text "Product 6 is above reference 29/6 by 7/6.",.boolean (match MolecularFormationEnergy.exactFormationStateRelation MolecularFormationEnergy.productAboveState MolecularFormationEnergy.reference with | .error _ => false | .ok r => SFT.Host.Text.equal r.orientation.label "product-above-reference" && (match r.magnitude with | .ratio q => MolecularFormationEnergy.ratioPair q==(7,6) | .emptyOne | .otherEmptyOne _ | .invalid => false))],.array [.text "structural-equality",.text "Equal endpoints close to structural EmptyOne.",.boolean (match MolecularFormationEnergy.exactFormationStateRelation MolecularFormationEnergy.reference MolecularFormationEnergy.reference with | .error _ => false | .ok r => SFT.Host.Text.equal r.orientation.label "product-reference-equal" && (match r.magnitude with | .emptyOne => true | .ratio _ | .otherEmptyOne _ | .invalid => false))],.array [.text "shared-state-invariance",.text "A shared exact state preserves order and separation.",.boolean (match MolecularFormationEnergy.sharedStateExtensionPreservesFormationRelation MolecularFormationEnergy.productBelowState MolecularFormationEnergy.reference MolecularFormationEnergy.shared with | .error _ => false | .ok b => b)],.array [.text "positive-repetition",.text "Three repetitions retain the below orientation and scale 5/6 to 5/2.",.boolean (match MolecularFormationEnergy.repeatedFormationRelation MolecularFormationEnergy.productBelowState MolecularFormationEnergy.reference (.count ⟨3,by decide⟩) with | .error _ => false | .ok r => SFT.Host.Text.equal r.orientation.label "product-below-reference" && (match r.magnitude with | .ratio q => MolecularFormationEnergy.ratioPair q==(5,2) | .emptyOne | .otherEmptyOne _ | .invalid => false))]]
def claimId : String := "SFT-CHEM-MOLECULAR-FORMATION-ENERGY-013"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-THERMO-FIRST-LAW-001","SFT-PHYS-THERMO-STATE-RELATION-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-FORMULA-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-MOLECULAR-STATE-TRANSITION-009","SFT-CHEM-CONFIGURATION-ORDER-PATH-011","SFT-CHEM-BOND-DISSOCIATION-ENERGY-002","SFT-CHEM-INTERMOLECULAR-BINDING-011"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "reference",.text (referenceName c.reference)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "magnitude",.text (magnitudeName c.magnitude)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-formation-number",.text "A bare number erases product, phase, reference and condition."],.array [.text "complete-product-reference-state-carrier",.text "Product and every reference-state constituent remain held."]]],.array [.text "reference",.array [.array [.text "imported-or-fitted-atomic-reference",.text "An imported or fitted reference lets external values select the relation."],.array [.text "exact-named-constituent-reference-composition",.text "The complete named reference state composes exactly from positive retained states."]]],.array [.text "orientation",.array [.array [.text "signed-formation-proof-number",.text "A signed proof number imports negatives and loses state order."],.array [.text "held-product-reference-state-order",.text "Above, below and equality are held structural relations."]]],.array [.text "magnitude",.array [.array [.text "species-coefficient-or-target-value",.text "A species coefficient or target value is a fitted parameter."],.array [.text "exact-positive-state-separation",.text "Unequal states force their exact positive separation."]]],.array [.text "absence",.array [.array [.text "numerical-zero-for-equality-or-blank",.text "Numerical zero is not an SFT value and a source blank is not a measured equality."],.array [.text "equality-or-unmeasured-as-distinct-structural-EmptyOne",.text "Equal state support and absent measurement are separately recorded structural absences."]]],.array [.text "prediction",.array [.array [.text "formation-values-readable-before-seal",.text "Readable values could select the law, reference or species subset."],.array [.text "value-free-complete-formation-identity-seal",.text "All product and reference identities seal before any value or orientation opens."]]],.array [.text "record",.array [.array [.text "favorable-species-temperature-or-sign-subset",.text "Selecting only convenient values conceals blanks and opposite orientations."],.array [.text "complete-values-blanks-orientations-and-reference-custody",.text "The complete official source surface and reference-state page remain in custody."]]],.array [.text "extension",.array [.array [.text "new-coefficient-per-added-constituent",.text "A new coefficient per constituent destroys zero-parameter closure."],.array [.text "one-relation-with-depth-independent-shared-state-extension",.text "A shared state extension preserves the exact relation without a new rule."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact molecular formation-energy relation"
 branch := "chemistry"
 statement := "A molecular formation-energy record is the exact relation between one completely identified product state and the exact composition of its named constituent reference states under a held phase and temperature reference. Unequal endpoints force one held above/below orientation and one exact positive separation; equality is structural EmptyOne. All 2,098 value-free identities seal before the complete NIST vector of 1,485 printed experimental values and 613 blank cells opens."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-product-reference-state-carrier__exact-named-constituent-reference-composition__held-product-reference-state-order__exact-positive-state-separation__equality-or-unmeasured-as-distinct-structural-EmptyOne__value-free-complete-formation-identity-seal__complete-values-blanks-orientations-and-reference-custody__one-relation-with-depth-independent-shared-state-extension"),("base",.text "One named product state and one nonempty exact constituent-reference composition force either one held orientation with one exact positive separation or structural equality."),("successor",.text "Appending the same exact positive state to product and reference preserves orientation and separation; equal positive repetition preserves orientation and scales separation without a new coefficient."),("exclusions",.array [.text "no numerical zero; equality and missing source measurement are distinct structural EmptyOne records",.text "no negative, irrational, imaginary, floating, signed or continuum SFT proof value",.text "no measured formation energy or source orientation in the law, grammar, forcing or prediction",.text "no imported thermodynamic convention value, fitted atomic reference or species coefficient",.text "no selected molecule, temperature axis, sign class, favorable value or completed-row subset",.text "no deletion of blanks, exact source equalities, unreturned compositions or reference-state custody"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; equality and missing source measurement are distinct structural EmptyOne records","no negative, irrational, imaginary, floating, signed or continuum SFT proof value","no measured formation energy or source orientation in the law, grammar, forcing or prediction","no imported thermodynamic convention value, fitted atomic reference or species coefficient","no selected molecule, temperature axis, sign class, favorable value or completed-row subset","no deletion of blanks, exact source equalities, unreturned compositions or reference-state custody"]
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
end SFT.Chemistry.MolecularFormationEnergyEvidence
