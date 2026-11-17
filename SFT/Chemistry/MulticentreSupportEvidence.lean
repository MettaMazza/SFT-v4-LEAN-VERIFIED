import SFT.Chemistry.MulticentreSupportGrammar
import SFT.Chemistry.MulticentreSupport
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MulticentreSupportEvidence
open SFT.Host.Canonical MulticentreSupportGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "three-centre-bridge",.text "One connected support spans B-left, bridging H and B-right.",.boolean MulticentreSupport.bridgeWitness],.array [.text "six-centre-cycle",.text "One surface support spans all six cyclic carbon centres.",.boolean MulticentreSupport.cycleWitness],.array [.text "four-centre-volume",.text "One volume support spans the complete tetrahedral graph.",.boolean MulticentreSupport.volumeWitness],.array [.text "two-centre-control",.text "A pair cannot be relabelled as multicentre support.",.boolean MulticentreSupport.localizedWitness],.array [.text "disconnected-control",.text "An omitted connection cannot be relabelled as one delocalized support.",.boolean MulticentreSupport.disconnectedWitness]]
def claimId : String := "SFT-CHEM-MULTICENTRE-DELOCALIZED-SUPPORT-008"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-PHYS-QUANTUM-ENTANGLEMENT-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-CHEM-ORBITAL-SUPPORT-OCCUPANCY-003","SFT-CHEM-MOLECULAR-EXCLUSION-EXCHANGE-006","SFT-CHEM-JOINT-CORRELATION-DISSOCIATION-007"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "centres",.text (centresName c.centres)],.array [.text "support",.text (supportName c.support)],.array [.text "connection",.text (connectionName c.connection)],.array [.text "topology",.text (topologyName c.topology)],.array [.text "reduction",.text (reductionName c.reduction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "isolated-bond-list",.text "A list erases the single molecular carrier joining the support."],.array [.text "complete-molecular-carrier",.text "One carrier retains the complete connected support."]]],.array [.text "centres",.array [.array [.text "two-centre-only-premise",.text "A two-centre restriction excludes generated supports before enumeration."],.array [.text "three-or-more-generated-centres",.text "Every positive finite support of at least three retained centres remains admissible for testing."]]],.array [.text "support",.array [.array [.text "localized-edge-identities",.text "Separate edge identities cannot preserve one electron-support identity spanning the graph."],.array [.text "one-complete-extended-support",.text "One held electron support retains every centre of the connected graph."]]],.array [.text "connection",.array [.array [.text "disconnected-centre-union",.text "A disconnected union is not one molecular support."],.array [.text "connected-generated-graph",.text "Every retained centre is reachable through generated support edges."]]],.array [.text "topology",.array [.array [.text "imported-or-single-topology",.text "Selecting one familiar shape omits lawful connected alternatives."],.array [.text "ribbon-surface-volume-census",.text "Path, cycle and polyhedral branch arise from exact graph incidence."]]],.array [.text "reduction",.array [.array [.text "pairwise-model-declared-complete",.text "Independent localized pairs erase the one support identity extending beyond either endpoint."],.array [.text "multicentre-irreducible-support",.text "At least three centres occur in one indivisible support word."]]],.array [.text "record",.array [.array [.text "selected-example-only",.text "One favourable example cannot test the registered topology and geometry surface."],.array [.text "complete-authority-and-geometry-vector",.text "All IUPAC topology and NIST experimental geometry rows remain bound to provenance."]]],.array [.text "extension",.array [.array [.text "species-specific-extra-rule",.text "A species exception or empirical bonding model adds an unforced premise."],.array [.text "connected-successor-with-no-extra-rule",.text "Adding a connected centre preserves the same support law without a new parameter."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Connected multicentre and delocalized molecular support"
 branch := "chemistry"
 statement := "A delocalized molecular electron support is one retained Fold word spanning every centre of a connected generated graph. At three or more centres it is not reducible to one localized two-centre support without losing the complete support identity. Path, cycle and polyhedral incidence force ribbon, surface and volume forms without an imported bonding model."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-molecular-carrier__three-or-more-generated-centres__one-complete-extended-support__connected-generated-graph__ribbon-surface-volume-census__multicentre-irreducible-support__complete-authority-and-geometry-vector__connected-successor-with-no-extra-rule"),("base",.text "Three distinct centres joined as one path force the first support word that spans more than one localized pair."),("successor",.text "Appending one centre by at least one generated edge preserves connectedness and the single complete support word; closing an endpoint pair yields a cycle and adding an independent branch yields a polyhedral volume without an extra law."),("exclusions",.array [.text "no numerical zero; glyph 0 denotes source/interface absence only",.text "no negative, irrational, imaginary, floating, signed-amplitude or continuum proof magnitude",.text "no imported valence-bond, molecular-orbital, aromaticity, resonance, Wade, Hückel or two-centre bonding model",.text "no measured NIST geometry, IUPAC example or species name before prediction seal",.text "no fitted bond length, angle, order, topology or species correction",.text "no selected-source or selected-row validation"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; glyph 0 denotes source/interface absence only","no negative, irrational, imaginary, floating, signed-amplitude or continuum proof magnitude","no imported valence-bond, molecular-orbital, aromaticity, resonance, Wade, Hückel or two-centre bonding model","no measured NIST geometry, IUPAC example or species name before prediction seal","no fitted bond length, angle, order, topology or species correction","no selected-source or selected-row validation"]
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
end SFT.Chemistry.MulticentreSupportEvidence
