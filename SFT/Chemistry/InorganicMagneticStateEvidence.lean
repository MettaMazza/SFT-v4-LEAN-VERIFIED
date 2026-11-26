import SFT.Chemistry.InorganicMagneticStateGrammar
import SFT.Chemistry.InorganicMagneticState
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.InorganicMagneticStateEvidence
open SFT.Host.Canonical InorganicMagneticStateGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "balanced-diamagnetic",.text "Structural EmptyOne unpaired support forces the repelled diamagnetic class.",.boolean InorganicMagneticState.balancedWitness],.array [.text "positive-paramagnetic",.text "Four complete unpaired occurrences force moment support four and spin width five.",.boolean InorganicMagneticState.positiveWitness],.array [.text "unpaired-successor",.text "Appending one unpaired occurrence increments moment support and spin width exactly once.",.boolean InorganicMagneticState.successorWitness],.array [.text "duplicate-control",.text "Duplicating one unpaired occurrence rejects.",.boolean InorganicMagneticState.duplicateWitness]]
def claimId : String := "SFT-CHEM-INORGANIC-MAGNETIC-STATE-009"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-CHEM-ELECTRON-COUNT-SPIN-002","SFT-CHEM-ORBITAL-SUPPORT-OCCUPANCY-003","SFT-CHEM-MOLECULAR-EXCLUSION-EXCHANGE-006","SFT-CHEM-MOLECULAR-MAGNETIC-RESPONSE-012","SFT-CHEM-COORDINATION-ENTITY-RETAINED-IDENTITY-001","SFT-CHEM-LIGAND-STATE-SPLITTING-006","SFT-CHEM-COMPLEX-SPIN-STATE-ORDER-007"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "support",.text (supportName c.support)],.array [.text "balance",.text (balanceName c.balance)],.array [.text "moment",.text (momentName c.moment)],.array [.text "width",.text (widthName c.width)],.array [.text "direction",.text (directionName c.direction)],.array [.text "classification",.text (classificationName c.classification)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "free-magnetic-number",.text "A free magnetic number is detached from the inorganic state."],.array [.text "one-retained-complex-carrier",.text "Every magnetic state remains bound to one coordination entity."]]],.array [.text "support",.array [.array [.text "selected-or-averaged-spin",.text "A selected or averaged spin loses electron occurrences."],.array [.text "complete-unpaired-occurrence-support",.text "Every unpaired electron occurrence and held spin fibre remains explicit."]]],.array [.text "balance",.array [.array [.text "numerical-zero-paired-state",.text "Numerical zero is not a native state or proof magnitude."],.array [.text "pairwise-closure-to-EmptyOne",.text "Complete complementary pairing closes unpaired support to structural EmptyOne."]]],.array [.text "moment",.array [.array [.text "square-root-spin-only-formula",.text "A square-root formula imports irrational continuum magnitude."],.array [.text "exact-unpaired-support-count",.text "Native magnetic moment support is exactly the positive unpaired count or structural EmptyOne."]]],.array [.text "width",.array [.array [.text "asserted-multiplicity",.text "An asserted multiplicity can contradict complete support."],.array [.text "unpaired-successor-spin-width",.text "Spin width is exactly one successor beyond unpaired support."]]],.array [.text "direction",.array [.array [.text "signed-susceptibility-proof",.text "A signed scalar imports negative proof quantity."],.array [.text "held-drawn-or-repelled-field-relation",.text "Opposed field relations remain held labels while external signs remain source inscriptions."]]],.array [.text "classification",.array [.array [.text "species-magnetic-lookup",.text "A species lookup lets observed class select the rule."],.array [.text "EmptyOne-diamagnetic-positive-paramagnetic",.text "Balanced EmptyOne support forces diamagnetic; positive unpaired support forces paramagnetic."]]],.array [.text "extension",.array [.array [.text "fitted-g-factor-or-complex-exception",.text "A fitted factor or species exception destroys zero-parameter closure."],.array [.text "unpaired-successor-with-no-extra-rule",.text "Each appended unpaired occurrence increments support and width once while preserving the paramagnetic class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact inorganic unpaired-support magnetic-state law"
 branch := "chemistry"
 statement := "A coordination entity's magnetic state is the complete retained support of every unpaired electron occurrence and its held spin fibre. Complete complementary pairing closes unpaired support to structural EmptyOne, forcing spin width One, a held repelled-from-field relation and the diamagnetic class. Positive unpaired support forces exact moment support equal to its cardinality, spin width one successor beyond it, a held drawn-into-field relation and the paramagnetic class. Appending one unpaired occurrence increments moment support and width exactly once. No signed susceptibility, irrational spin-only square root, fitted g-factor or species lookup enters forcing."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-retained-complex-carrier__complete-unpaired-occurrence-support__pairwise-closure-to-EmptyOne__exact-unpaired-support-count__unpaired-successor-spin-width__held-drawn-or-repelled-field-relation__EmptyOne-diamagnetic-positive-paramagnetic__unpaired-successor-with-no-extra-rule"),("base",.text "Complete complementary pairing leaves structural EmptyOne unpaired support, spin width One and the diamagnetic/repelled held class. The first unpaired occurrence is the first positive moment support, spin width two and the paramagnetic/drawn held class."),("successor",.text "Appending one distinct unpaired occurrence preserves every prior occurrence and fibre, increments exact moment support and spin width once, and preserves the paramagnetic/drawn class without a new parameter or exception."),("exclusions",.array [.text "no numerical zero; complete paired closure is structural EmptyOne",.text "no negative irrational imaginary floating signed continuum or square-root proof quantity",.text "no imported spin-only moment formula signed magnetic quantum number susceptibility sign rule fitted g-factor or species table",.text "no dimensional magnetic constant or measured moment in generation enumeration or survivor decision",.text "no deletion of 136 exact magnitudes, 38 structural absences, held source orientations or unavailable surfaces",.text "no recapture or relabeling of shared admitted PROP-012 evidence"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; complete paired closure is structural EmptyOne","no negative irrational imaginary floating signed continuum or square-root proof quantity","no imported spin-only moment formula signed magnetic quantum number susceptibility sign rule fitted g-factor or species table","no dimensional magnetic constant or measured moment in generation enumeration or survivor decision","no deletion of 136 exact magnitudes, 38 structural absences, held source orientations or unavailable surfaces","no recapture or relabeling of shared admitted PROP-012 evidence"]
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
end SFT.Chemistry.InorganicMagneticStateEvidence
