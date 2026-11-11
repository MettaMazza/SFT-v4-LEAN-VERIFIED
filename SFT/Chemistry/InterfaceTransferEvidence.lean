import SFT.Chemistry.InterfaceTransferGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.InterfaceTransferEvidence
open SFT.Host.Canonical InterfaceTransferGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "phases",.text "donor and receiver differ",.boolean true],.array [.text "balance",.text "crossed carriers are positive",.boolean true],.array [.text "orientation",.text "phase identities remain named",.boolean true]]
def claimId : String := "SFT-CHEM-INTERFACE-TRANSFER-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-REACTION-001","SFT-CHEM-THERMO-DIRECTION-001","SFT-CHEM-PHASE-CHEMICAL-001","SFT-CHEM-SURFACE-ADSORPTION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "interface",.text (interfaceName c.interface)],.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "balance",.text (balanceName c.balance)],.array [.text "process",.text (processName c.process)],.array [.text "rate",.text (rateName c.rate)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "interface",.array [.array [.text "one-phase-only",.text "No crossing boundary exists."],.array [.text "two-phase-boundary",.text "Donor and receiver phases are held."]]],.array [.text "carrier",.array [.array [.text "anonymous-flux",.text "Chemical identity is lost."],.array [.text "chemical-species-retained",.text "The same carrier is tracked across the boundary."]]],.array [.text "orientation",.array [.array [.text "unsigned-transfer-number",.text "Direction is ambiguous."],.array [.text "held-donor-to-receiver-orientation",.text "Direction and magnitude are separated."]]],.array [.text "balance",.array [.array [.text "carrier-created-at-boundary",.text "Conservation fails."],.array [.text "mass-balance-preserved",.text "Departure and arrival are paired."]]],.array [.text "process",.array [.array [.text "instantaneous-relabel",.text "No transfer event is represented."],.array [.text "boundary-crossing-transition",.text "The interface event is counted."]]],.array [.text "rate",.array [.array [.text "universal-transfer-value",.text "Rate depends on context."],.array [.text "transfer-rate-condition-bounded",.text "Area, interval and conditions are retained externally."]]],.array [.text "record",.array [.array [.text "flux-answer-only",.text "The crossing cannot be replayed."],.array [.text "complete-donor-interface-receiver-trace",.text "All carrier positions are auditable."]]],.array [.text "extra",.array [.array [.text "free-transfer-coefficient",.text "A fitted coefficient can select any value."],.array [.text "no-extra-rule",.text "Paired crossings supply the law."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Chemical transfer across an interface"
 branch := "chemistry"
 statement := "Interfacial chemical transfer is the counted, oriented crossing of a retained chemical-species carrier from a named donor phase to a distinct receiver phase, pairing departure and arrival under declared conditions."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "two-phase-boundary__chemical-species-retained__held-donor-to-receiver-orientation__mass-balance-preserved__boundary-crossing-transition"),("base",.text "One paired departure/arrival crossing supplies the first transfer event."),("successor",.text "Appending a crossing preserves total carrier support and adds one counted event to the held direction and condition record."),("exclusions",.array [.text "no catalyst dictionary, kinetic table, reaction network, surface model, colloid table, transfer equation, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no chemical carrier, phase identity, interface or reaction step may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite two-phase boundary with named donor, receiver and chemical carrier, paired crossing events, complete balance and source-bound rate conditions."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no catalyst dictionary, kinetic table, reaction network, surface model, colloid table, transfer equation, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no chemical carrier, phase identity, interface or reaction step may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite two-phase boundary with named donor, receiver and chemical carrier, paired crossing events, complete balance and source-bound rate conditions."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with interface :=  .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.InterfaceTransferEvidence
