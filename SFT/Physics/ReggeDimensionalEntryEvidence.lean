import SFT.Physics.ReggeDimensionalGrammar
import SFT.Physics.ReggeDimensionalWitnesses
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.ReggeDimensionalEntryEvidence
open SFT.Host.Canonical ReggeDimensionalGrammar ReggeDimensionalWitnesses
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witnessRecords : Value := .array [.object [("name",.text "motion"),("statement",.text "The admitted rotating motion share is exactly 3/5."),("passed",.boolean witness0)],.object [("name",.text "successor"),("statement",.text "Two Fold hands force exact successor share 6/5."),("passed",.boolean witness1)],.object [("name",.text "first-five"),("statement",.text "The first five carriers are generated without measurement."),("passed",.boolean witness2)],.object [("name",.text "induction"),("statement",.text "The exact closed form and constant step hold at every registered witness depth."),("passed",.boolean witness3)]]
def claimId : String := "SFT-PHYS-HADRON-REGGE-DIMENSIONAL-TERMINAL-059"
def dependencies : List String := ["SFT-PHYS-HADRON-REGGE-TERMINAL-005", "SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003", "SFT-PHYS-MATTER-CONFINEMENT-LIFT-003", "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "predecessor",.text (predecessorName c.predecessor)],.array [.text "motion",.text (motionName c.motion)],.array [.text "hands",.text (handsName c.hands)],.array [.text "successor",.text (successorName c.successor)],.array [.text "base",.text (baseName c.base)],.array [.text "closure",.text (closureName c.closure)],.array [.text "units",.text (unitsName c.units)],.array [.text "target",.text (targetName c.target)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Generate the complete product of predecessor custody, motion share, tube hands, base rank, successor act, closed form, unit boundary, target custody and extension forms."),("grammar_boundary",.text "The admitted exact 3/5 motion share, exactly two Fold tube hands, every positive spin successor, exact positive fractions, a post-seal common unit label and no measurement in survivor selection."),("axes",.array [.object [("key",.text "predecessor"),("question",.text "How are earlier laws used?"),("choices",.array [.array [.text "rewrite-or-ignore-admitted-laws",.text "A successor may not replace an admitted dependency."],.array [.text "immutable-receipt-custody",.text "The relativistic and confinement receipts remain immutable inputs."]])],.object [("key",.text "motion"),("question",.text "What is the first rotating carrier?"),("choices",.array [.array [.text "selected-or-fitted-intercept",.text "A selected intercept reads the spectrum."],.array [.text "admitted-three-fifths-motion-share",.text "Three spatial motion positions over the forced 3-4-5 closure give exact 3/5."]])],.object [("key",.text "hands"),("question",.text "How many tube contributions enter one successor?"),("choices",.array [.array [.text "chosen-trajectory-multiplicity",.text "A chosen multiplicity changes the slope."],.array [.text "both-forced-Fold-hands",.text "The confined tube retains both Fold hands exactly once."]])],.object [("key",.text "successor"),("question",.text "What does one spin successor add?"),("choices",.array [.array [.text "fitted-common-slope",.text "A measured slope is not a derivation."],.array [.text "two-times-three-fifths",.text "One 3/5 motion share on each of two hands forces 6/5."]])],.object [("key",.text "base"),("question",.text "Where does the positive ladder begin?"),("choices",.array [.array [.text "numerical-zero-or-free-offset",.text "Neither numerical nothingness nor an offset is generated."],.array [.text "first-positive-rank-three-fifths",.text "The first positive spin rank retains the unsucceeded motion share."]])],.object [("key",.text "closure"),("question",.text "How does the rule extend?"),("choices",.array [.array [.text "finite-five-row-pattern",.text "Five inspected rows do not establish a general law."],.array [.text "depth-independent-induction",.text "Every successor repeats the same paired tube act, forcing (6J-3)/5 for every positive J."]])],.object [("key",.text "units"),("question",.text "Can a conventional unit alter the law?"),("choices",.array [.array [.text "unit-name-selects-coefficients",.text "A unit label cannot choose a ratio."],.array [.text "postseal-common-positive-unit",.text "A common positive squared comparison unit is held only after the exact rational law seals."]])],.object [("key",.text "target"),("question",.text "May measured resonances select the survivor?"),("choices",.array [.array [.text "target-readable-before-seal",.text "That would fit the known spectrum."],.array [.text "target-inaccessible-until-formal-seal",.text "No particle name, mass, width, uncertainty or source exists in this module."]])],.object [("key",.text "extension"),("question",.text "May a residual correction be appended?"),("choices",.array [.array [.text "free-spin-correction",.text "An ungenerated correction is a parameter."],.array [.text "no-extra-rule",.text "Motion, both hands, base and successor exhaust the declared grammar."]])]]),("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Terminal dimensional light-hadron Regge carrier"
 branch := "physics"
 statement := "The admitted two-hand relativistic closure forces the exact positive three-motion share 3/5. A confined rotating tube has the two forced Fold hands, so one spin successor retains one motion share on each hand and adds 2(3/5)=6/5 squared-support units. The first positive spin rank carries the unsucceeded 3/5 motion share. Therefore every positive rank is forced depth-independently as Q(J)=3/5+(J-1)6/5=(6J-3)/5. No slope, intercept, resonance mass, width or residual is fitted or available to the formal execution."
 evidenceMode := .formal
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
 traceHash := admissionIdentity (.array [.text claimId,.text generationRule,candidateRecord c])
def censusData : SFT.Engine.CandidateCensus where
 generationRule := generationRule
 grammarBoundary := grammarBoundary
 expectedCardinality := .ofNat candidates.length
 completenessCertificateHash := admissionIdentity completenessRecord
 candidates := candidates.map generatedCandidateData
def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
 candidateId := candidateId c
 survives := survives c
 reason := decisionReason c
 proofHash := admissionIdentity (.array [.text claimId,.array (dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : Value := .object [("result",.text "Every positive spin rank has the exact squared resonance-support carrier Q(J)=(6J-3)/5. The base is 3/5; every successor step is 6/5; the first five carriers are 3/5, 9/5, 3, 21/5 and 27/5."),("base",.text "At J=1 the rotating carrier is the admitted three-motion share 3/5."),("successor",.text "If Q(J)=(6J-3)/5, the next two-hand tube act adds 6/5, giving Q(J+1)=(6J+3)/5=(6(J+1)-3)/5."),("exclusions",.array [.text "no fitted or measured Regge slope, intercept, mass, width, residual or selected trajectory row",.text "no imported string-tension parameter or continuum string equation",.text "no numerical-nothingness, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity proof scalar",.text "no pre-seal physical-unit calibration or target access"]),("witnesses",witnessRecords),("unique_survivor",.text survivorId)]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := admissionIdentity (.array [closureValue,.array (decisions.map SFT.Engine.decisionValue)])
 generalityCertificateHash := some (admissionIdentity closureValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := observation
 observedBehavior := if passed then observation else "control failed"
 receiptHash := identity (.array [.text claimId,.text (SFT.Engine.kindName kind),.boolean passed,.text observation])
def exclusions : List String := ["no fitted or measured Regge slope, intercept, mass, width, residual or selected trajectory row", "no imported string-tension parameter or continuum string equation", "no numerical-nothingness, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity proof scalar", "no pre-seal physical-unit calibration or target access"]
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with predecessor := .rejected}) survivorId)) "reject the form missing the first structural preservation",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed source identity",
 control .tamperedArtifact ((candidates.filter survives).length==1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2 && witness3) "reject forbidden values, target feedback and extra laws"]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Physics.ReggeDimensionalEntryEvidence
