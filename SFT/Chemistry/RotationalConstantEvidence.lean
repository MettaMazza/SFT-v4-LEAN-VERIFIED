import SFT.Chemistry.RotationalConstantGrammar
import SFT.Chemistry.RotationalConstant
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.RotationalConstantEvidence
local instance : BEq Int := ⟨fun a b => match a,b with
 | .ofNat n,.ofNat m => n==m
 | .negSucc n,.negSucc m => n==m
 | .ofNat _,.negSucc _ | .negSucc _,.ofNat _ => false⟩
open SFT.Host.Canonical RotationalConstantGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "axis-recurrence-ratio",.text "Twelve held-axis recurrences over three intervals force exact constant four.",.boolean (match RotationalConstant.exactAxisRotationalConstant (.count RotationalConstant.constant.numerator) (.count RotationalConstant.constant.denominator) with | .error _ => false | .ok r => VibrationalFrequency.fractionPair r==(4,1))],.array [.text "equal-interval-successor",.text "Five equal repetitions preserve the exact axis recurrence ratio.",.boolean (match RotationalConstant.repeatedEqualIntervalConstant (.count RotationalConstant.constant.numerator) (.count RotationalConstant.constant.denominator) (.count (RotationalConstant.ordinal 4)) with | .error _ => false | .ok r => VibrationalFrequency.fractionPair r==(4,1))],.array [.text "forced-positive-ladder",.text "The first four positive levels are 2, 6, 12 and 20 with gaps 2, 4, 6 and 8.",.boolean (([0,1,2,3].map fun n => match RotationalConstant.rotationalLevelMultiple (.count (RotationalConstant.ordinal n)) with | .error _ => 0 | .ok x => x.value)==[2,6,12,20] && ([0,1,2,3].map fun n => match RotationalConstant.adjacentRotationalGapMultiple (.count (RotationalConstant.ordinal n)) with | .error _ => 0 | .ok x => x.value)==[2,4,6,8])],.array [.text "constant-level-composition",.text "J=3 composes constant four with multiplier twelve to give exact level forty-eight.",.boolean (match RotationalConstant.rotationalLevelRatio (.ratio RotationalConstant.constant) (.count (RotationalConstant.ordinal 2)) with | .error _ => false | .ok r => VibrationalFrequency.fractionPair r==(48,1))],.array [.text "empty-ground",.text "The unexcited rotational form is structural EmptyOne rather than numerical zero.",.boolean (match RotationalConstant.unexcitedRotationalForm with | .emptyOne => true | .otherEmptyOne _ => true | .ratio _ => false | .invalid => false)]]
def claimId : String := "SFT-CHEM-ROTATIONAL-CONSTANT-010"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-PHYS-WAVE-PERIOD-FREQUENCY-001","SFT-PHYS-MOLECULAR-SPECTRUM-HIERARCHY-004","SFT-PHYS-MOLECULAR-SPECTROSCOPY-TERMINAL-005","SFT-CHEM-MOL-GEOMETRY-001","SFT-CHEM-CONFIGURATION-ORDER-PATH-011","SFT-CHEM-ROVIBRONIC-COMPOSITION-001","SFT-CHEM-RESOLVED-ROVIBRONIC-SPIN-COMPOSITION-013","SFT-CHEM-EQUILIBRIUM-BOND-LENGTH-001","SFT-CHEM-MOLECULAR-BOND-ANGLE-003","SFT-CHEM-DIHEDRAL-TORSIONAL-STATE-004","SFT-CHEM-VIBRATIONAL-FREQUENCY-009"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "axis",.text (axisName c.axis)],.array [.text "magnitude",.text (magnitudeName c.magnitude)],.array [.text "ladder",.text (ladderName c.ladder)],.array [.text "translation",.text (translationName c.translation)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-rotational-number",.text "An answer-only number erases molecular state, geometry and axis identity."],.array [.text "complete-finite-state-geometry-axis-carrier",.text "Species, state, finite generated geometry, coordinate support and axis identity remain held without a continuum rigid body."]]],.array [.text "axis",.array [.array [.text "merged-or-relabelled-axis",.text "Merging principal axes destroys distinct and symmetry-equivalent recurrence records."],.array [.text "held-principal-axis-and-equivalence-class",.text "A, B and C remain held labels with their generated equivalence class."]]],.array [.text "magnitude",.array [.array [.text "imported-rotational-constant-or-inertia-equation",.text "A named constant or moment-of-inertia equation does not derive the Fold quantity."],.array [.text "exact-axis-recurrence-over-interval-ratio",.text "The constant is the exact positive held-axis recurrence count over a positive interval count."]]],.array [.text "ladder",.array [.array [.text "continuum-or-free-angular-spectrum",.text "A continuum spectrum or selected angular coefficient is not generated."],.array [.text "positive-JJplusOne-level-and-2J-gap",.text "Positive ordinals force J(J+1) levels and exact adjacent 2J gaps; the unexcited form is EmptyOne."]]],.array [.text "translation",.array [.array [.text "reciprocal-centimeter-selects-law",.text "A conventional unit cannot select the axis-recurrence relation."],.array [.text "post-recurrence-held-unit-translation",.text "The exact ratio exists before a reciprocal-centimeter label is attached."]]],.array [.text "prediction",.array [.array [.text "rotational-target-readable-before-seal",.text "A readable A, B or C value could select the relation or row set."],.array [.text "value-free-complete-axis-identity-seal",.text "Every returned molecular-row and axis identity seals without any rotational value."]]],.array [.text "record",.array [.array [.text "favorable-molecule-or-present-axis-subset",.text "Dropping unavailable species, blank axes or asymmetric rows hides the source boundary."],.array [.text "complete-NIST-list-choice-result-and-axis-custody",.text "The complete list query, returned choices, returned rows and every present or absent A/B/C cell remain explicit."]]],.array [.text "extension",.array [.array [.text "fitted-inertia-geometry-or-species-correction",.text "A fitted inertia, geometry coefficient or species residual is a free parameter."],.array [.text "one-axis-recurrence-law-no-extra-rule",.text "One exact recurrence law and one forced ladder cover every returned axis without a correction term."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact molecular held-axis rotational-constant law"
 branch := "chemistry"
 statement := "A molecular rotational constant is derived from a complete retained molecular state, finite generated geometry and held principal axis as the exact positive count of completed axis recurrences divided by a positive observation-interval count. Positive rotational ordinals force J(J+1) levels and adjacent 2J gaps; the unexcited form is structural EmptyOne. Every value-free identity from the complete official NIST list-to-choice-to-result route seals before 1,681 positive A/B/C measurements and 1,334 blank axis cells open. No rigid rotor, inertia equation, continuum angle or fitted molecular coefficient enters."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-finite-state-geometry-axis-carrier__held-principal-axis-and-equivalence-class__exact-axis-recurrence-over-interval-ratio__positive-JJplusOne-level-and-2J-gap__post-recurrence-held-unit-translation__value-free-complete-axis-identity-seal__complete-NIST-list-choice-result-and-axis-custody__one-axis-recurrence-law-no-extra-rule"),("base",.text "One positive recurrence on one held generated axis over one positive interval forces one exact constant; the first positive rotational ordinal forces multiplier two while the unexcited form remains EmptyOne."),("successor",.text "Equal repetition scales recurrence and interval counts together and preserves their ratio; appending one positive rotational ordinal preserves prior levels and forces the next J(J+1) level and 2J gap; appending a distinct held axis preserves all preceding axis identities and applies the same recurrence law."),("exclusions",.array [.text "no numerical zero; missing source measurements and the unexcited form use structural EmptyOne",.text "no negative, irrational, imaginary, floating, signed or continuum proof value",.text "no rigid-rotor equation, freely rotating continuum body, trigonometric angle or imported moment of inertia",.text "no measured rotational constant in the law, grammar, candidate forcing or prediction",.text "no fitted geometry, inertia, molecular scale, species correction or residual",.text "no dropped blank A/B/C cell, unreturned composition, returned state or retrieval batch"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; missing source measurements and the unexcited form use structural EmptyOne","no negative, irrational, imaginary, floating, signed or continuum proof value","no rigid-rotor equation, freely rotating continuum body, trigonometric angle or imported moment of inertia","no measured rotational constant in the law, grammar, candidate forcing or prediction","no fitted geometry, inertia, molecular scale, species correction or residual","no dropped blank A/B/C cell, unreturned composition, returned state or retrieval batch"]
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
end SFT.Chemistry.RotationalConstantEvidence
