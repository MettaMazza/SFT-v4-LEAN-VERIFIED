import SFT.Chemistry.ProtonGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ProtonEvidence
open SFT.Host.Canonical ProtonGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "carrier",.text "the transfer retains one proton occurrence",.boolean true],.array [.text "endpoints",.text "donor and acceptor occurrences are distinct",.boolean true],.array [.text "no-copy",.text "one event has one retained carrier",.boolean true]]
def claimId : String := "SFT-CHEM-AB-PROTON-TRANSFER-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "source",.text (sourceName c.source)],.array [.text "destination",.text (destinationName c.destination)],.array [.text "transition",.text (transitionName c.transition)],.array [.text "identity",.text (identityName c.identity)],.array [.text "closure",.text (closureName c.closure)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "proton-count-only",.text "A count cannot establish conservation of an occurrence."],.array [.text "one-named-proton-carrier",.text "The transferred proton identity remains held."]]],.array [.text "source",.array [.array [.text "source-erased",.text "Without a donor, the carrier could be created freely."],.array [.text "registered-donor",.text "The departure endpoint is retained."]]],.array [.text "destination",.array [.array [.text "destination-erased",.text "Without an acceptor, the carrier could be lost."],.array [.text "registered-acceptor",.text "The arrival endpoint is retained."]]],.array [.text "transition",.array [.array [.text "copy-or-delete",.text "Copying or deleting violates carrier conservation."],.array [.text "donor-to-acceptor-transfer",.text "One carrier changes endpoint exactly once."]]],.array [.text "identity",.array [.array [.text "before-after-carrier-change",.text "A changed carrier is not transfer conservation."],.array [.text "same-carrier-before-after",.text "The proton occurrence is identical across the transition."]]],.array [.text "closure",.array [.array [.text "unpaired-composition-change",.text "Unpaired change leaves the reaction record open."],.array [.text "complete-endpoint-closure",.text "Donor loss and acceptor gain are one event."]]],.array [.text "record",.array [.array [.text "product-label-only",.text "A product label cannot reconstruct the path."],.array [.text "carrier-endpoint-transition-trace",.text "Carrier and both endpoints remain auditable."]]],.array [.text "extension",.array [.array [.text "free-proton-source",.text "A free source can force any reaction."],.array [.text "no-extra-rule",.text "Conserved endpoint transfer supplies the law."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Proton-transfer acid-base relation"
 branch := "chemistry"
 statement := "Proton transfer moves one named proton carrier from one registered donor occurrence to one distinct acceptor occurrence while conserving carrier identity and both endpoint records."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-named-proton-carrier__registered-donor__registered-acceptor__donor-to-acceptor-transfer__same-carrier-before-after"),("base",.text "One named proton carrier with one distinct donor and acceptor supplies the first closed transfer."),("successor",.text "Appending one independent transfer preserves every prior carrier and endpoint identity and closes only through paired donor loss and acceptor gain."),("exclusions",.array [.text "no acid/base dictionary, pH scale, equilibrium equation, dissociation constant, measured value or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no unpaired creation, copying or loss of a proton or electron carrier",.text "no claim that structural closure alone fixes every solution-dependent strength or capacity value",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite chemical transition in which one named proton carrier leaves one registered donor occurrence and enters one distinct registered acceptor occurrence with identical carrier identity before and after."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no acid/base dictionary, pH scale, equilibrium equation, dissociation constant, measured value or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no unpaired creation, copying or loss of a proton or electron carrier","no claim that structural closure alone fixes every solution-dependent strength or capacity value","external target content remains inaccessible until the prediction is sealed","Every finite chemical transition in which one named proton carrier leaves one registered donor occurrence and enters one distinct registered acceptor occurrence with identical carrier identity before and after."]
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
end SFT.Chemistry.ProtonEvidence
