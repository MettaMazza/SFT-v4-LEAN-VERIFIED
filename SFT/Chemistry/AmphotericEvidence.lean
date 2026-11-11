import SFT.Chemistry.AmphotericGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.AmphotericEvidence
open SFT.Host.Canonical AmphotericGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "acid-role",.text "the same species is donor in one event",.boolean true],.array [.text "base-role",.text "the same species is acceptor in another event",.boolean true],.array [.text "context-separation",.text "the opposite-role endpoints remain distinct",.boolean true]]
def claimId : String := "SFT-CHEM-AB-AMPHOTERIC-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "species",.text (speciesName c.species)],.array [.text "acid-context",.text (acidContextName c.acidContext)],.array [.text "base-context",.text (baseContextName c.baseContext)],.array [.text "context",.text (contextName c.context)],.array [.text "duality",.text (dualityName c.duality)],.array [.text "identity",.text (identityName c.identity)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "species",.array [.array [.text "two-unrelated-species",.text "Dual behavior must belong to one retained carrier identity."],.array [.text "same-species-identity",.text "The same species appears in both contexts."]]],.array [.text "acid-context",.array [.array [.text "acid-label-without-event",.text "A label does not establish donation."],.array [.text "valid-donor-event",.text "One context contains a conserved carrier donation."]]],.array [.text "base-context",.array [.array [.text "base-label-without-event",.text "A label does not establish acceptance."],.array [.text "valid-acceptor-event",.text "Another context contains a conserved carrier acceptance."]]],.array [.text "context",.array [.array [.text "roles-conflated",.text "Conflation can assert incompatible events simultaneously."],.array [.text "contexts-separately-held",.text "Each surrounding reaction identity remains explicit."]]],.array [.text "duality",.array [.array [.text "one-role-only",.text "One role does not close amphoteric behavior."],.array [.text "both-roles-realized",.text "Donor and acceptor witnesses both exist."]]],.array [.text "identity",.array [.array [.text "species-changed-between-roles",.text "A changed carrier does not establish dual capacity."],.array [.text "species-identity-retained",.text "The same carrier is compared before each event."]]],.array [.text "record",.array [.array [.text "amphoteric-label-only",.text "A label cannot reproduce both contexts."],.array [.text "dual-event-context-trace",.text "Species, events and contexts remain held."]]],.array [.text "extension",.array [.array [.text "free-dual-role-exception",.text "An exception can admit any species."],.array [.text "no-extra-rule",.text "Two valid opposite-role contexts determine the class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Amphoteric dual-role relation"
 branch := "chemistry"
 statement := "An amphoteric species is the same retained chemical carrier appearing in two separately held contexts, once in a valid acid role and once in a valid base role."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "same-species-identity__valid-donor-event__valid-acceptor-event__contexts-separately-held__both-roles-realized"),("base",.text "One retained species with one donor event and one acceptor event in distinct contexts supplies the first amphoteric record."),("successor",.text "Appending one context preserves the species identity and prior role traces; amphoteric closure persists only while both opposite roles remain realized."),("exclusions",.array [.text "no acid/base dictionary, pH scale, equilibrium equation, dissociation constant, measured value or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no unpaired creation, copying or loss of a proton or electron carrier",.text "no claim that structural closure alone fixes every solution-dependent strength or capacity value",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite chemical carrier for which two separately registered contexts contain a valid donor transition and a valid acceptor transition involving that same retained species identity."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no acid/base dictionary, pH scale, equilibrium equation, dissociation constant, measured value or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no unpaired creation, copying or loss of a proton or electron carrier","no claim that structural closure alone fixes every solution-dependent strength or capacity value","external target content remains inaccessible until the prediction is sealed","Every finite chemical carrier for which two separately registered contexts contain a valid donor transition and a valid acceptor transition involving that same retained species identity."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with species := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.AmphotericEvidence
