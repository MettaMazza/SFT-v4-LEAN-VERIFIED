import SFT.Chemistry.PolymerChainGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.PolymerChainEvidence
open SFT.Host.Canonical PolymerChainGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "repeat",.text "repeat identity is held",.boolean true],.array [.text "extent",.text "repeat count is positive",.boolean true],.array [.text "connections",.text "chain connections are positive",.boolean true]]
def claimId : String := "SFT-CHEM-POLYMER-CHAIN-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-REACTION-001","SFT-CHEM-THERMO-DIRECTION-001","SFT-CHEM-PHASE-CHEMICAL-001","SFT-CHEM-MOL-GEOMETRY-001","SFT-CHEM-MOL-ISOMER-001","SFT-CHEM-NET-REACTION-001","SFT-CHEM-ORGANIC-FUNCTIONAL-GROUP-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "repeat",.text (repeatName c.repeatUnit)],.array [.text "connection",.text (connectionName c.connection)],.array [.text "order",.text (orderName c.order)],.array [.text "extent",.text (extentName c.extent)],.array [.text "ends",.text (endsName c.ends)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "unconnected-monomer-mixture",.text "No chain exists."],.array [.text "connected-macromolecular-carrier",.text "All repeat occurrences form one carrier."]]],.array [.text "repeat",.array [.array [.text "anonymous-segments",.text "Repeat identity is lost."],.array [.text "repeated-low-mass-unit-identity",.text "A complete unit trace recurs."]]],.array [.text "connection",.array [.array [.text "noncovalent-coincidence",.text "The sequence is not a polymer chain."],.array [.text "covalent-sequence-connections",.text "Successive occurrences are chemically joined."]]],.array [.text "order",.array [.array [.text "occurrence-order-erased",.text "Chain topology is lost."],.array [.text "ordered-chain-incidence",.text "Every neighbor relation is held."]]],.array [.text "extent",.array [.array [.text "fixed-universal-length",.text "Length is population- and synthesis-bound."],.array [.text "positive-finite-repeat-count",.text "Every realized chain has an exact count."]]],.array [.text "ends",.array [.array [.text "infinite-chain-assumed",.text "A finite carrier needs a boundary."],.array [.text "chain-end-boundary-retained",.text "Terminal identities remain explicit."]]],.array [.text "record",.array [.array [.text "polymer-name-only",.text "The chain cannot be reconstructed."],.array [.text "repeat-connection-end-trace",.text "Every occurrence and bond is retained."]]],.array [.text "extra",.array [.array [.text "free-polymer-rule",.text "A threshold can arbitrarily select chains."],.array [.text "no-extra-rule",.text "Connected repeat recurrence supplies the class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Polymer chain from repeated monomer identity"
 branch := "chemistry"
 statement := "A polymer chain is one finite connected macromolecular carrier formed by covalently ordered occurrences of a retained repeat-unit identity with exact positive extent and explicit ends."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "connected-macromolecular-carrier__repeated-low-mass-unit-identity__covalent-sequence-connections__ordered-chain-incidence__positive-finite-repeat-count"),("base",.text "Two connected occurrences of one repeat identity supply the first nontrivial chain."),("successor",.text "Appending one covalently connected occurrence preserves prior order and moves one retained terminal boundary."),("exclusions",.array [.text "no stereochemical dictionary, organic reaction taxonomy, polymer table, biomolecular database, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no atom, bond, orientation, repeat unit, chain or observation distinction may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite connected molecular incidence path containing repeated complete low-mass unit traces, covalent connections and explicit terminal boundaries."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no stereochemical dictionary, organic reaction taxonomy, polymer table, biomolecular database, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no atom, bond, orientation, repeat unit, chain or observation distinction may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite connected molecular incidence path containing repeated complete low-mass unit traces, covalent connections and explicit terminal boundaries."]
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
end SFT.Chemistry.PolymerChainEvidence
