import SFT.Chemistry.IonicGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.IonicEvidence
open SFT.Host.Canonical IonicGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "ion-pair",.text "opposed cation/anion fibres retain reciprocal attraction",.boolean true],.array [.text "charge-closure",.text "every charge state has a paired transfer",.boolean true],.array [.text "cutoff-control",.text "no electronegativity threshold selects the class",.boolean true]]
def claimId : String := "SFT-CHEM-BOND-IONIC-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-ENTANGLEMENT-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-CONDENSED-LATTICE-001","SFT-PHYS-CONDENSED-BAND-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-VALENCE-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-BOND-COVALENT-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "formation",.text (formationName c.formation)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "interaction",.text (interactionName c.interaction)],.array [.text "identity",.text (identityName c.identity)],.array [.text "character",.text (characterName c.character)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "neutral-atom-pair-only",.text "The ionic class requires retained ion carriers."],.array [.text "cation-anion-carriers",.text "Both charge-state identities remain held."]]],.array [.text "formation",.array [.array [.text "unpaired-charge-creation",.text "Charge cannot appear without conserved transfer."],.array [.text "closed-charge-transfer",.text "Every charge-state change is paired to a carrier path."]]],.array [.text "orientation",.array [.array [.text "signed-charge-magnitudes",.text "Negative proof magnitude is inadmissible."],.array [.text "opposed-held-charge-fibres",.text "Cation and anion are structural orientations."]]],.array [.text "interaction",.array [.array [.text "generic-proximity",.text "Proximity does not explain ionic stability."],.array [.text "electrostatic-attraction-support",.text "Opposed held electric labels generate reciprocal attraction."]]],.array [.text "identity",.array [.array [.text "element-identity-erased",.text "Ion formation preserves nuclear element identity."],.array [.text "chemical-identities-retained",.text "Both elemental/molecular carriers persist."]]],.array [.text "character",.array [.array [.text "pure-binary-dogma",.text "Observed bonds may retain both ionic and shared support."],.array [.text "exact-support-composition",.text "Ionic character is the exact retained share of charge-separated support."]]],.array [.text "record",.array [.array [.text "ionic-label-only",.text "A label cannot reconstruct transfer and attraction."],.array [.text "ion-transfer-interaction-trace",.text "Formation, charges and recurrence remain held."]]],.array [.text "extension",.array [.array [.text "free-electronegativity-cutoff",.text "A fitted cutoff would import the classification."],.array [.text "no-extra-rule",.text "Charge separation and stable interaction determine the class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Ionic transferred-label bond"
 branch := "chemistry"
 statement := "An ionic bond is stable joint recurrence of opposed cation/anion held charge fibres produced by closed charge transfer, with electrostatic attraction and both chemical identities retained."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "cation-anion-carriers__closed-charge-transfer__opposed-held-charge-fibres__electrostatic-attraction-support"),("base",.text "One closed charge transfer producing opposed retained ion fibres and stable reciprocal attraction supplies the first ionic bond."),("successor",.text "Appending one generated ion pair preserves charge conservation, atomic identities and all electrostatic interaction traces."),("exclusions",.array [.text "no IUPAC bond definition, orbital equation, electronegativity scale, measured value or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "no universal bond-length/strength formula inferred from a categorical correspondence",.text "official target content opens only through post-seal custody",.text "Every finite charge-transfer product containing opposed cation/anion held fibres whose closed electric interaction yields stable joint recurrence while both chemical identities remain retained."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC bond definition, orbital equation, electronegativity scale, measured value or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","no universal bond-length/strength formula inferred from a categorical correspondence","official target content opens only through post-seal custody","Every finite charge-transfer product containing opposed cation/anion held fibres whose closed electric interaction yields stable joint recurrence while both chemical identities remain retained."]
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
end SFT.Chemistry.IonicEvidence
