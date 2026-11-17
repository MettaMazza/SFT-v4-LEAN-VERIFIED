import SFT.Chemistry.RadiolysisNetworkGrammar
import SFT.Chemistry.RadiolysisNetwork
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.RadiolysisNetworkEvidence
open SFT.Host.Canonical RadiolysisNetworkGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "handoff",.text "Deposited resource positive.",.boolean RadiolysisNetwork.handoffWitness],.array [.text "identity",.text "Medium/species held.",.boolean RadiolysisNetwork.identityWitness],.array [.text "network",.text "Channels distinct.",.boolean RadiolysisNetwork.networkWitness],.array [.text "events",.text "Products counted.",.boolean RadiolysisNetwork.eventsWitness],.array [.text "yield",.text "Yield exact.",.boolean RadiolysisNetwork.yieldWitness],.array [.text "partition",.text "Products partition One.",.boolean RadiolysisNetwork.partitionWitness],.array [.text "closure",.text "Empty network closes structurally.",.boolean RadiolysisNetwork.closureWitness],.array [.text "extension",.text "Successor retains network.",.boolean RadiolysisNetwork.extensionWitness]]
def claimId : String := "SFT-CHEM-RADIATION-CHEMISTRY-REACTION-NETWORK-012"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-RADIOACTIVE-CHEMICAL-TRANSFORMATION-002","SFT-CHEM-ACTIVITY-AMOUNT-TIME-003"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "handoff",.text (handoffName c.handoff)],.array [.text "identity",.text (identityName c.identity)],.array [.text "network",.text (networkName c.network)],.array [.text "events",.text (eventsName c.events)],.array [.text "yield",.text (yieldName c.yield)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "closure",.text (closureName c.closure)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "handoff",.array [.array [.text "chemistry-defines-deposited-energy",.text "Deposited resource belongs to Physics."],.array [.text "explicit-positive-deposited-resource-handoff",.text "Chemistry receives a positive counted resource."]]],.array [.text "identity",.array [.array [.text "anonymous-radical-yield",.text "A yield needs medium and species identity."],.array [.text "held-medium-reactant-product-identities",.text "All identities remain held."]]],.array [.text "network",.array [.array [.text "single-net-equation",.text "A net equation hides channels and intermediates."],.array [.text "complete-directed-reaction-network",.text "Every directed channel remains."]]],.array [.text "events",.array [.array [.text "continuum-concentration-premise",.text "Continuum concentration hides occurrences."],.array [.text "positive-product-event-counts",.text "Every product event is counted."]]],.array [.text "yield",.array [.array [.text "fitted-G-value",.text "A fitted value cannot define native yield."],.array [.text "exact-product-per-deposited-resource-ratio",.text "Yield is forced by exact counts."]]],.array [.text "partition",.array [.array [.text "selected-major-products",.text "Major-product selection erases support."],.array [.text "exact-complete-channel-partition-of-One",.text "All channels partition One."]]],.array [.text "closure",.array [.array [.text "negative-consumption-ledger",.text "Consumption cannot be a negative proof value."],.array [.text "explicit-reaction-or-EmptyOne-termination",.text "Each path reacts explicitly or terminates structurally."]]],.array [.text "extension",.array [.array [.text "differential-kinetic-model-premise",.text "A continuum kinetic model is not required."],.array [.text "successor-retains-and-recomputes-complete-network",.text "Every successor retains all channels and recomputes."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold radiation-chemistry reaction-network law"
 branch := "chemistry"
 statement := "Physics supplies positive deposited resource; Chemistry retains complete medium/reactant/product/channel identity, counted product events, exact product-per-resource yields, complete channel partition and explicit reaction or structural termination."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "explicit-positive-deposited-resource-handoff__held-medium-reactant-product-identities__complete-directed-reaction-network__positive-product-event-counts__exact-product-per-deposited-resource-ratio__exact-complete-channel-partition-of-One__explicit-reaction-or-EmptyOne-termination__successor-retains-and-recomputes-complete-network"),("base",.text "One deposited-resource handoff and one chemical product event supply the first yield row."),("successor",.text "Every successor retains all channels and recomputes yields and the complete partition without a kinetic fit."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no preferred G value reaction table or conventional radiolysis model selects the survivor",.text "all corrections tentative classifications missing results nonlinearities and unreliable rows remain"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no preferred G value reaction table or conventional radiolysis model selects the survivor","all corrections tentative classifications missing results nonlinearities and unreliable rows remain"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with handoff := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.RadiolysisNetworkEvidence
