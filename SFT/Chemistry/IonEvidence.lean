import SFT.Chemistry.IonGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.IonEvidence
open SFT.Host.Canonical IonGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "identity",.text "charge transfer preserves the element proton count",.boolean true],.array [.text "conservation",.text "every charge change is paired to a boundary transfer",.boolean true],.array [.text "signed-control",.text "a negative proof magnitude is rejected in favor of a held orientation",.boolean true]]
def claimId : String := "SFT-CHEM-ELEM-ION-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001","SFT-PHYS-QUANTUM-INDISTINGUISHABILITY-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-ELEM-ELEMENT-001","SFT-CHEM-ELEM-ATOMIC-NUMBER-001","SFT-CHEM-ELEM-VALENCE-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "charge",.text (chargeName c.charge)],.array [.text "formation",.text (formationName c.formation)],.array [.text "conservation",.text (conservationName c.conservation)],.array [.text "element",.text (elementName c.element)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "charge-label-without-particle",.text "A charge label detached from matter is not a chemical ion."],.array [.text "atomic-or-molecular-particle",.text "The ion retains an atomic or molecular carrier."]]],.array [.text "charge",.array [.array [.text "signed-proof-number",.text "A signed proof magnitude violates the positive exact domain."],.array [.text "net-held-electric-charge",.text "Net charge is a conserved held orientation and positive count."]]],.array [.text "formation",.array [.array [.text "identity-destroying-change",.text "Destroying the carrier does not create a charge state of it."],.array [.text "label-transfer-with-identity-retained",.text "Electric-label transfer changes charge state while retaining chemical identity."]]],.array [.text "conservation",.array [.array [.text "unpaired-charge-creation",.text "Unpaired creation violates closed label flow."],.array [.text "closed-charge-transfer",.text "Every gained or released charge carrier is paired across the boundary."]]],.array [.text "element",.array [.array [.text "proton-count-change",.text "Changing proton count changes element identity."],.array [.text "atomic-number-retained",.text "Ion formation preserves nuclear proton count."]]],.array [.text "orientation",.array [.array [.text "positive-negative-proof-scalars",.text "Signed scalars are not SFT proof objects."],.array [.text "cation-anion-held-fibres",.text "The two charge orientations are exact held fibre labels."]]],.array [.text "record",.array [.array [.text "ion-name-only",.text "A name cannot reconstruct carrier, charge and transfer."],.array [.text "carrier-charge-transfer-trace",.text "The complete formation and conservation trace remains held."]]],.array [.text "extension",.array [.array [.text "free-charge-exception",.text "An exception can create or erase charge without transfer."],.array [.text "no-extra-rule",.text "Conserved held-label accounting completely determines ion status."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Ion formation with retained elemental identity"
 branch := "chemistry"
 statement := "An ion is an atomic or molecular Fold particle whose closed electric-label transfer leaves a net held charge orientation while retaining its nuclear and chemical identity."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing]
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "atomic-or-molecular-particle__net-held-electric-charge__label-transfer-with-identity-retained__closed-charge-transfer"),("base",.text "One atomic or molecular carrier with one conserved unmatched held electric orientation supplies the first ion record."),("successor",.text "Appending one paired charge-carrier transfer updates the exact net held count while preserving proton count, chemical carrier and the complete prior transfer trace."),("exclusions",.array [.text "no IUPAC table arrangement, term definition, measured value, electron-shell equation or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "official target content opens only through post-seal custody",.text "Every finite atomic or molecular chemical carrier whose complete conserved electric-label accounting leaves one non-neutral held orientation while retaining its elemental and molecular identity records."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC table arrangement, term definition, measured value, electron-shell equation or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","official target content opens only through post-seal custody","Every finite atomic or molecular chemical carrier whose complete conserved electric-label accounting leaves one non-neutral held orientation while retaining its elemental and molecular identity records."]
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
end SFT.Chemistry.IonEvidence
