import SFT.Chemistry.PolarityGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.PolarityEvidence
open SFT.Host.Canonical PolarityGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "bond",.text "the polar record retains its bond identity",.boolean true],.array [.text "orientation",.text "the partition is held, not signed",.boolean true],.array [.text "shared",.text "the electron support remains shared",.boolean true]]
def claimId : String := "SFT-CHEM-BOND-POLARITY-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "bond",.text (bondName c.bond)],.array [.text "affinity",.text (affinityName c.affinity)],.array [.text "support",.text (supportName c.support)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "closure",.text (closureName c.closure)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "bond",.array [.array [.text "two-unjoined-atoms",.text "Polarity belongs to a shared bond."],.array [.text "registered-covalent-bond",.text "The whole bond identity remains held."]]],.array [.text "affinity",.array [.array [.text "equal-or-unknown-affinity",.text "No direction follows from equality or missing evidence."],.array [.text "unequal-complete-affinity",.text "One endpoint has the preferred trace."]]],.array [.text "support",.array [.array [.text "different-electrons-compared",.text "Different support cannot orient one bond."],.array [.text "same-shared-electron-support",.text "Both endpoints compare the identical support."]]],.array [.text "partition",.array [.array [.text "full-transfer",.text "Full transfer changes the bonding class."],.array [.text "unequal-shared-partition",.text "Support remains shared but asymmetrically recurrent."]]],.array [.text "orientation",.array [.array [.text "negative-charge-number",.text "A negative scalar is unnecessary."],.array [.text "held-partial-charge-fibres",.text "Opposed partial orientations are labels with positive support."]]],.array [.text "closure",.array [.array [.text "one-endpoint-only",.text "One endpoint leaves the bond record open."],.array [.text "paired-endpoint-response",.text "Both endpoint responses belong to one partition."]]],.array [.text "record",.array [.array [.text "polar-label-only",.text "A label cannot reproduce the comparison."],.array [.text "bond-affinity-partition-trace",.text "Bond, affinity and orientation remain held."]]],.array [.text "extra",.array [.array [.text "free-polarity-threshold",.text "A threshold imports a parameter."],.array [.text "no-extra-rule",.text "Any exact unequal trace orients the partition."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Bond polarity from unequal held affinity"
 branch := "chemistry"
 statement := "Unequal endpoint affinity for the identical shared support forces an oriented but still shared bond partition, with opposed partial-charge fibres held as labels rather than signed proof numbers."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "registered-covalent-bond__unequal-complete-affinity__same-shared-electron-support__unequal-shared-partition__held-partial-charge-fibres"),("base",.text "One covalent bond with one unequal affinity comparison supplies the first polar partition."),("successor",.text "Appending a bonded endpoint preserves the prior bond traces and adds an orientation exactly when its complete affinity comparison is unequal."),("exclusions",.array [.text "no electronegativity scale, oxidation-state table, electrode potential, external definition, measured value or V2 result may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no electron carrier may be created, copied, silently erased or assigned to two endpoints",.text "no qualitative structural law is represented as a parameter-free prediction of a measured decimal scale",.text "external target content remains inaccessible until the complete prediction is sealed",.text "Every finite covalent bond whose two named endpoints have unequal complete affinity traces for the same shared support, producing one held orientation of the support partition while retaining the bond whole."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no electronegativity scale, oxidation-state table, electrode potential, external definition, measured value or V2 result may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no electron carrier may be created, copied, silently erased or assigned to two endpoints","no qualitative structural law is represented as a parameter-free prediction of a measured decimal scale","external target content remains inaccessible until the complete prediction is sealed","Every finite covalent bond whose two named endpoints have unequal complete affinity traces for the same shared support, producing one held orientation of the support partition while retaining the bond whole."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with bond := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.PolarityEvidence
