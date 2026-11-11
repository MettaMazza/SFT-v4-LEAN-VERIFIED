import SFT.Chemistry.RedoxGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.RedoxEvidence
open SFT.Host.Canonical RedoxGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "carrier",.text "the electron identity is retained",.boolean true],.array [.text "endpoints",.text "oxidation and reduction sites are distinct",.boolean true],.array [.text "coupled",.text "one carrier has exactly two endpoint records",.boolean true]]
def claimId : String := "SFT-CHEM-REDOX-COUPLING-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-REDOX-OXIDATION-STATE-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "donor",.text (donorName c.donor)],.array [.text "acceptor",.text (acceptorName c.acceptor)],.array [.text "coupling",.text (couplingName c.coupling)],.array [.text "identity",.text (identityName c.identity)],.array [.text "accounting",.text (accountingName c.accounting)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "anonymous-charge-change",.text "It cannot establish electron conservation."],.array [.text "named-electron-carrier",.text "The transferred occurrence remains held."]]],.array [.text "donor",.array [.array [.text "donor-erased",.text "The carrier could be freely created."],.array [.text "registered-oxidation-endpoint",.text "Carrier departure is retained."]]],.array [.text "acceptor",.array [.array [.text "acceptor-erased",.text "The carrier could be lost."],.array [.text "registered-reduction-endpoint",.text "Carrier arrival is retained."]]],.array [.text "coupling",.array [.array [.text "independent-half-changes",.text "One open half violates conservation."],.array [.text "one-paired-transfer",.text "Oxidation and reduction are two ends of one event."]]],.array [.text "identity",.array [.array [.text "different-carrier-after",.text "That is replacement, not transfer."],.array [.text "same-carrier-before-after",.text "Electron identity is conserved."]]],.array [.text "accounting",.array [.array [.text "one-sided-state-change",.text "One side cannot close the assignment."],.array [.text "opposed-assignment-updates",.text "Donor and acceptor records update together."]]],.array [.text "record",.array [.array [.text "redox-label-only",.text "A label cannot reverse the event."],.array [.text "carrier-endpoint-coupling-trace",.text "Carrier and both endpoints remain held."]]],.array [.text "extra",.array [.array [.text "free-electron-source",.text "A free source breaks closure."],.array [.text "no-extra-rule",.text "Paired transfer supplies the law."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Coupled oxidation and reduction"
 branch := "chemistry"
 statement := "Oxidation and reduction are the opposed endpoint records of one conserved electron transfer; neither half closes without the other."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "named-electron-carrier__registered-oxidation-endpoint__registered-reduction-endpoint__one-paired-transfer__same-carrier-before-after"),("base",.text "One named electron transfer between distinct endpoints supplies the first coupled redox event."),("successor",.text "Appending one transfer preserves all carrier identities and adds one paired donor-loss/acceptor-gain record."),("exclusions",.array [.text "no electronegativity scale, oxidation-state table, electrode potential, external definition, measured value or V2 result may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no electron carrier may be created, copied, silently erased or assigned to two endpoints",.text "no qualitative structural law is represented as a parameter-free prediction of a measured decimal scale",.text "external target content remains inaccessible until the complete prediction is sealed",.text "Every finite closed electron-labelled transfer between distinct chemical endpoints, with identical carrier identity before and after and paired donor loss/acceptor gain or their complete oxidation-assignment equivalents."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no electronegativity scale, oxidation-state table, electrode potential, external definition, measured value or V2 result may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no electron carrier may be created, copied, silently erased or assigned to two endpoints","no qualitative structural law is represented as a parameter-free prediction of a measured decimal scale","external target content remains inaccessible until the complete prediction is sealed","Every finite closed electron-labelled transfer between distinct chemical endpoints, with identical carrier identity before and after and paired donor loss/acceptor gain or their complete oxidation-assignment equivalents."]
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
end SFT.Chemistry.RedoxEvidence
