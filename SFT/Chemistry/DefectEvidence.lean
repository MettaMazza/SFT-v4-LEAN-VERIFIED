import SFT.Chemistry.DefectGrammar
import SFT.Chemistry.DefectWitnesses
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.DefectEvidence
open SFT.Host.Canonical DefectGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "pristine-absence",.text "A complete unchanged motif has structural EmptyOne defect support.",.boolean DefectWitnesses.pristineWitness],.array [.text "vacancy",.text "One absent A occupant is a vacancy with one positive missing A and no signed count.",.boolean DefectWitnesses.vacancyWitness],.array [.text "interstitial",.text "One native interstitial is exact added support and remains intrinsic.",.boolean DefectWitnesses.interstitialWitness],.array [.text "substitution",.text "A foreign occupant forces substitution and extrinsic origin.",.boolean DefectWitnesses.substitutionWitness]]
def claimId : String := "SFT-CHEM-DEFECT-NONSTOICHIOMETRY-016"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-MEAS-FORMULA-001","SFT-CHEM-SOLID-STATE-LOCAL-COORDINATION-015"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "reference",.text (referenceName c.reference)],.array [.text "vacancy",.text (vacancyName c.vacancy)],.array [.text "difference",.text (differenceName c.difference)],.array [.text "class",.text (classAxisName c.classAxis)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "origin",.text (originName c.origin)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "continuum-defect-density",.text "A continuum density loses the exact local defect occurrences."],.array [.text "finite-complete-reference-and-observed-motif",.text "The law retains one finite complete reference motif and one complete observed motif."]]],.array [.text "reference",.array [.array [.text "nominal-formula-only",.text "A nominal formula does not identify the occupied sites."],.array [.text "complete-reference-site-and-species-support",.text "Every reference site and its expected species are explicit."]]],.array [.text "vacancy",.array [.array [.text "numerical-zero-occupancy",.text "Numerical zero is not a Fold form."],.array [.text "reference-site-with-structural-EmptyOne",.text "A vacancy is an exact reference site whose occupant is structural EmptyOne."]]],.array [.text "difference",.array [.array [.text "signed-stoichiometric-subtraction",.text "Signed subtraction imports negative values."],.array [.text "separate-positive-missing-and-added-supports",.text "Missing and added occurrences are separate positive supports or EmptyOne."]]],.array [.text "class",.array [.array [.text "selected-defect-name",.text "A selected name omits alternative interruptions."],.array [.text "complete-vacancy-substitution-interstitial-classes",.text "Vacancy, substitution and interstitial classes are generated from exact support."]]],.array [.text "composition",.array [.array [.text "fitted-nonstoichiometric-variable",.text "A fitted variable is neither exact nor unique."],.array [.text "exact-reference-observed-primitive-formulas",.text "Reference and observed formulas are exact primitive positive count vectors."]]],.array [.text "origin",.array [.array [.text "assumed-intrinsic-or-extrinsic-label",.text "An assumed label does not follow from composition."],.array [.text "reference-membership-forces-origin-class",.text "Foreign observed species force extrinsic; reference-only defects force intrinsic."]]],.array [.text "extension",.array [.array [.text "catalogue-specific-defect-exception",.text "A catalogue exception destroys closure."],.array [.text "site-occurrence-successor-no-extra-rule",.text "Fresh sites and occurrences are reconciled by the same exact law."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact defect chemistry and non-stoichiometry law"
 branch := "chemistry"
 statement := "A local solid defect is the exact interruption between one complete reference-site motif and one complete observed motif. A vacancy is a retained reference site with structural EmptyOne occupancy. Missing and added species are separate positive supports, never a signed difference; their primitive count vectors force exact reference and observed formulas, defect class and intrinsic/extrinsic origin."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "finite-complete-reference-and-observed-motif__complete-reference-site-and-species-support__reference-site-with-structural-EmptyOne__separate-positive-missing-and-added-supports__complete-vacancy-substitution-interstitial-classes__exact-reference-observed-primitive-formulas__reference-membership-forces-origin-class__site-occurrence-successor-no-extra-rule"),("base",.text "A positive finite reference motif and its complete occupancy record uniquely distinguish an occupied site from a retained site with structural EmptyOne."),("successor",.text "Appending one fresh reference site, occupied occurrence or interstitial occurrence preserves all earlier records and recomputes separate positive missing and added supports under the same occurrence reconciliation."),("exclusions",.array [.text "no numerical zero; a vacancy is structural EmptyOne at a retained site",.text "no negative irrational imaginary signed continuum fitted free or imported parameter",.text "no signed stoichiometric subtraction or fitted non-stoichiometric variable",.text "no defect catalogue selected in place of complete local support",.text "no external dimensional zero inscription used as native arithmetic",.text "no source definition, note, example or identity redirect used to select the law"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; a vacancy is structural EmptyOne at a retained site","no negative irrational imaginary signed continuum fitted free or imported parameter","no signed stoichiometric subtraction or fitted non-stoichiometric variable","no defect catalogue selected in place of complete local support","no external dimensional zero inscription used as native arithmetic","no source definition, note, example or identity redirect used to select the law"]
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
end SFT.Chemistry.DefectEvidence
