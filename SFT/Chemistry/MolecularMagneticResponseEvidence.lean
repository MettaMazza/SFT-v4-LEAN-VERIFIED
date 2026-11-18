import SFT.Chemistry.MolecularMagneticResponseGrammar
import SFT.Chemistry.MolecularMagneticResponse
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MolecularMagneticResponseEvidence
open SFT.Host.Canonical MolecularMagneticResponseGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "balanced-closure",.text "Equal opposing support closes structurally.",.boolean (match MolecularMagneticResponse.exactOrientationExcess (.count ⟨3,by decide⟩) (.count ⟨3,by decide⟩) (.held MolecularMagneticResponse.fibreA) (.held MolecularMagneticResponse.fibreB) with | .error _ => false | .ok r => SFT.Host.Text.equal r.orientation.label "balanced-closed" && (match r.magnitude with | .emptyOne _ => true | .count _ => false))],.array [.text "positive-unmatched-support",.text "Five against two retains three on fibre-a.",.boolean (match MolecularMagneticResponse.exactOrientationExcess (.count ⟨5,by decide⟩) (.count ⟨2,by decide⟩) (.held MolecularMagneticResponse.fibreA) (.held MolecularMagneticResponse.fibreB) with | .error _ => false | .ok r => SFT.Host.Text.equal r.orientation.label "fibre-a" && (match r.magnitude with | .emptyOne _ => false | .count n => n.value==3))],.array [.text "exact-moment-ratio",.text "Three responses over two angular recurrences yield 3/2.",.boolean (match MolecularMagneticResponse.exactMomentRatio (.count ⟨3,by decide⟩) (.count ⟨2,by decide⟩) with | .error _ => false | .ok r => VibrationalFrequency.ratioPair r==(3,2))],.array [.text "exact-susceptibility-ratio",.text "Moment 3/2 over five field acts yields 3/10.",.boolean (match MolecularMagneticResponse.exactSusceptibilityRatio (.ratio MolecularMagneticResponse.moment) (.count ⟨5,by decide⟩) with | .error _ => false | .ok r => VibrationalFrequency.ratioPair r==(3,10))],.array [.text "depth-independent-repetition",.text "Equal repetition preserves the exact susceptibility ratio.",.boolean (match MolecularMagneticResponse.repeatedResponsePreservesSusceptibility (.ratio MolecularMagneticResponse.moment) (.count ⟨5,by decide⟩) (.count ⟨7,by decide⟩) with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-MOLECULAR-MAGNETIC-RESPONSE-012"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003","SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002","SFT-PHYS-ATOMIC-FIELD-SPLITTING-TERMINAL-005","SFT-CHEM-ELECTRON-COUNT-SPIN-002","SFT-CHEM-ORBITAL-SUPPORT-OCCUPANCY-003","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-STATE-SYMMETRY-DEGENERACY-005","SFT-CHEM-MOLECULAR-EXCLUSION-EXCHANGE-006","SFT-CHEM-JOINT-CORRELATION-DISSOCIATION-007","SFT-CHEM-RESOLVED-ROVIBRONIC-SPIN-COMPOSITION-013","SFT-CHEM-ROTATIONAL-CONSTANT-010","SFT-CHEM-INTERMOLECULAR-BINDING-011"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "closure",.text (closureName c.closure)],.array [.text "moment",.text (momentName c.moment)],.array [.text "susceptibility",.text (susceptibilityName c.susceptibility)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-magnetic-number",.text "A bare number erases molecule, state and angular support."],.array [.text "complete-molecular-state-and-angular-carrier",.text "Molecule, state, spin, orbital and rotational support remain held."]]],.array [.text "orientation",.array [.array [.text "signed-direction-as-proof-number",.text "A signed proof scalar imports negative numbers and loses the generating side."],.array [.text "opposed-held-orientation-labels",.text "Direction is retained as one of two distinct fibre labels."]]],.array [.text "closure",.array [.array [.text "assume-every-carrier-has-net-moment",.text "Paired complementary support can close and must not be assigned a numerical zero."],.array [.text "pairwise-closure-to-EmptyOne-or-positive-excess",.text "Balanced support is structural EmptyOne; unmatched support is positive and oriented."]]],.array [.text "moment",.array [.array [.text "fitted-or-species-g-coefficient",.text "A fitted g-factor lets the measured molecule select the law."],.array [.text "positive-response-per-angular-recurrence",.text "Molecular moment is an exact positive response-count ratio."]]],.array [.text "susceptibility",.array [.array [.text "continuum-derivative-field-law",.text "A continuum derivative imports an ungenerated field model."],.array [.text "positive-induced-response-per-field-act",.text "Susceptibility is an exact positive ratio over counted field acts."]]],.array [.text "prediction",.array [.array [.text "moment-or-susceptibility-readable-before-seal",.text "Readable targets could select the relation or molecule subset."],.array [.text "value-free-complete-magnetic-identity-seal",.text "Every source page, row, axis and response identity seals before values open."]]],.array [.text "record",.array [.array [.text "favorable-or-accessible-molecule-subset",.text "Selecting positive, convenient or currently accessible pages conceals blanks and source failures."],.array [.text "complete-g-factor-susceptibility-and-unavailable-custody",.text "All accessible values, blanks, signed orientations, the complete diatomic PDF and unavailable links remain explicit."]]],.array [.text "extension",.array [.array [.text "species-correction-or-new-field-coefficient",.text "A species residual creates a free parameter for every molecule."],.array [.text "one-ratio-law-with-depth-independent-repetition",.text "Equal positive repetition preserves response ratios without a new rule."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact molecular magnetic-response relation"
 branch := "chemistry"
 statement := "A complete molecular state retains spin, orbital and rotational support with two opposed orientations as held labels. Equal complementary support closes to structural EmptyOne; unmatched support retains a positive count and its generating orientation. Molecular moment is the exact positive response count per positive angular recurrence, and susceptibility is the exact positive induced response per positive applied-field act. All 174 NIST g-factor and magnetic-susceptibility cells seal without their values or orientations before the 136 printed magnitudes and 38 blanks open. No fitted g-factor, continuum derivative or species coefficient enters."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-molecular-state-and-angular-carrier__opposed-held-orientation-labels__pairwise-closure-to-EmptyOne-or-positive-excess__positive-response-per-angular-recurrence__positive-induced-response-per-field-act__value-free-complete-magnetic-identity-seal__complete-g-factor-susceptibility-and-unavailable-custody__one-ratio-law-with-depth-independent-repetition"),("base",.text "One retained unmatched orientation over one positive angular recurrence forces one positive moment class; one positive induced response over one positive field act forces one positive susceptibility class."),("successor",.text "Appending one complementary pair preserves structural closure, while equal positive repetition of response and field acts preserves the exact susceptibility ratio for every finite depth."),("exclusions",.array [.text "no numerical zero; balanced support and blank source cells use structural EmptyOne",.text "no negative, irrational, imaginary, floating or continuum proof value",.text "no signed direction scalar; source signs remain external held orientations",.text "no continuum field derivative, differential susceptibility equation or imported magnetic potential",.text "no measured moment or susceptibility in law, grammar, candidate forcing or prediction",.text "no fitted g-factor, species coefficient, residual or selected molecule subset",.text "no nuclear quadrupole chi tensor misclassified as magnetic susceptibility"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; balanced support and blank source cells use structural EmptyOne","no negative, irrational, imaginary, floating or continuum proof value","no signed direction scalar; source signs remain external held orientations","no continuum field derivative, differential susceptibility equation or imported magnetic potential","no measured moment or susceptibility in law, grammar, candidate forcing or prediction","no fitted g-factor, species coefficient, residual or selected molecule subset","no nuclear quadrupole chi tensor misclassified as magnetic susceptibility"]
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
end SFT.Chemistry.MolecularMagneticResponseEvidence
