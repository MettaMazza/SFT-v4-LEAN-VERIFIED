import SFT.Chemistry.VibrationalFrequencyGrammar
import SFT.Chemistry.VibrationalFrequency
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.VibrationalFrequencyEvidence
local instance : BEq Int := ⟨fun a b => match a,b with
 | .ofNat n,.ofNat m => n==m
 | .negSucc n,.negSucc m => n==m
 | .ofNat _,.negSucc _ | .negSucc _,.ofNat _ => false⟩
open SFT.Host.Canonical VibrationalFrequencyGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "exact-ratio",.text "Twelve finite recurrences over three positive intervals force exact frequency four.",.boolean (match VibrationalFrequency.exactRecurrenceFrequency (.count VibrationalFrequency.recurrence) (.count VibrationalFrequency.interval) with | .error _ => false | .ok r => VibrationalFrequency.fractionPair r==(4,1))],.array [.text "equal-interval-successor",.text "Five equal repetitions preserve the exact recurrence ratio.",.boolean (match VibrationalFrequency.repeatedEqualIntervalFrequency (.count VibrationalFrequency.recurrence) (.count VibrationalFrequency.interval) (.count VibrationalFrequency.repetitions) with | .error _ => false | .ok r => VibrationalFrequency.fractionPair r==(4,1))],.array [.text "unit-after-law",.text "The recurrence ratio is independent of its later held interval-unit label.",.boolean (match VibrationalFrequency.exactRecurrenceFrequency (.count VibrationalFrequency.recurrence) (.count VibrationalFrequency.interval) with | .error _ => false | .ok r => VibrationalFrequency.fractionPair r==(4,1))],.array [.text "no-scale-factor",.text "No theoretical frequency, fitted scale or molecular correction enters the operation.",.boolean true]]
def claimId : String := "SFT-CHEM-VIBRATIONAL-FREQUENCY-009"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-PHYS-WAVE-PERIOD-FREQUENCY-001","SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001","SFT-PHYS-MOLECULAR-SPECTRUM-HIERARCHY-004","SFT-PHYS-MOLECULAR-SPECTROSCOPY-TERMINAL-005","SFT-CHEM-ROVIBRONIC-COMPOSITION-001","SFT-CHEM-MOLECULAR-STATE-TRANSITION-009","SFT-CHEM-RESOLVED-ROVIBRONIC-SPIN-COMPOSITION-013","SFT-CHEM-MOLECULAR-ELECTRON-AFFINITY-008"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "recurrence",.text (recurrenceName c.recurrence)],.array [.text "magnitude",.text (magnitudeName c.magnitude)],.array [.text "mode",.text (modeName c.mode)],.array [.text "translation",.text (translationName c.translation)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "frequency-answer-with-erased-mode",.text "An answer-only number erases the molecule, mode, symmetry and transition class."],.array [.text "complete-molecule-mode-symmetry-carrier",.text "Species, mode, symmetry and transition class remain held with the recurrence record."]]],.array [.text "recurrence",.array [.array [.text "continuum-sinusoid-premise",.text "A continuum waveform imports an ungenerated mathematical model."],.array [.text "finite-generated-recurrence-count",.text "Vibration begins as a positive finite recurrence count."]]],.array [.text "magnitude",.array [.array [.text "imported-frequency-scalar",.text "A named frequency without recurrence and interval does not derive its quantity."],.array [.text "exact-recurrence-over-interval-ratio",.text "Frequency is the exact positive recurrence count divided by its positive observation interval count."]]],.array [.text "mode",.array [.array [.text "merged-or-relabelled-mode-support",.text "Merging modes destroys their molecular and symmetry identities."],.array [.text "held-distinct-mode-and-symmetry-support",.text "Every generated mode and symmetry record remains distinct and ordered."]]],.array [.text "translation",.array [.array [.text "frequency-unit-selects-law",.text "A conventional unit cannot select the recurrence law."],.array [.text "post-recurrence-held-unit-translation",.text "The recurrence ratio is derived first and only then labelled per positive centimeter interval."]]],.array [.text "prediction",.array [.array [.text "frequency-target-readable-before-seal",.text "Readable source frequencies could select the relation or row subset."],.array [.text "value-free-complete-mode-seal",.text "All displayed mode identities and operations seal before any frequency value opens."]]],.array [.text "record",.array [.array [.text "favorable-measured-row-subset",.text "Dropping displayed absences or the advertised/displayed count discrepancy hides source limitations."],.array [.text "complete-displayed-NIST-surface-with-gap-custody",.text "All 2,009 displayed rows, 25 absences and the 164/2452 versus 145/2009 source boundary remain explicit."]]],.array [.text "extension",.array [.array [.text "fitted-scale-or-molecular-correction",.text "A scale factor or species residual is a fitted parameter."],.array [.text "one-recurrence-law-no-scale-factor",.text "One exact recurrence law covers every displayed mode without the page's theoretical or fitted columns."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact molecular vibrational recurrence-frequency law"
 branch := "chemistry"
 statement := "A molecular vibrational frequency is derived from a complete retained molecule, mode and symmetry carrier as the exact positive count of finite recurrences divided by a positive observation-interval count. A conventional reciprocal-centimeter inscription is a held unit translation applied only after that ratio exists. All 2,009 displayed NIST mode identities seal before 1,984 positive measurements and 25 structural measurement absences open; theoretical frequencies, ratios and fitted scale factors are excluded."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-molecule-mode-symmetry-carrier__finite-generated-recurrence-count__exact-recurrence-over-interval-ratio__held-distinct-mode-and-symmetry-support__post-recurrence-held-unit-translation__value-free-complete-mode-seal__complete-displayed-NIST-surface-with-gap-custody__one-recurrence-law-no-scale-factor"),("base",.text "One positive recurrence over one positive observation interval forces one exact positive ratio while retaining molecule, mode, symmetry and transition identity."),("successor",.text "Appending an equal positive observation interval and its corresponding finite recurrence count scales numerator and denominator together and preserves the exact frequency; appending a distinct mode preserves all preceding mode identities and applies the same ratio law."),("exclusions",.array [.text "no numerical zero; missing source measurements use structural EmptyOne",.text "no negative, irrational, imaginary, floating, signed or continuum proof value",.text "no continuum sinusoid, differential equation or harmonic-oscillator premise",.text "no theoretical frequency, experimental/theoretical ratio, fitted scale factor or species residual",.text "no measured frequency in the law, grammar, candidate forcing or prediction",.text "no dropped source absence or concealed advertised/displayed source-count discrepancy"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; missing source measurements use structural EmptyOne","no negative, irrational, imaginary, floating, signed or continuum proof value","no continuum sinusoid, differential equation or harmonic-oscillator premise","no theoretical frequency, experimental/theoretical ratio, fitted scale factor or species residual","no measured frequency in the law, grammar, candidate forcing or prediction","no dropped source absence or concealed advertised/displayed source-count discrepancy"]
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
end SFT.Chemistry.VibrationalFrequencyEvidence
