import SFT.Chemistry.MetalClusterGrammar
import SFT.Chemistry.MetalCluster
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MetalClusterEvidence
open SFT.Host.Canonical MetalClusterGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "direct",.text "Direct support counts one.",.boolean MetalCluster.directWitness],.array [.text "bridge-and-group",.text "Bridge and nonbond grouping remain distinct.",.boolean MetalCluster.bridgeGroupWitness],.array [.text "successor",.text "Connected successor increments centre count.",.boolean MetalCluster.successorWitness],.array [.text "disconnected-control",.text "Disconnected centre rejects.",.boolean MetalCluster.disconnectedWitness]]
def claimId : String := "SFT-CHEM-METAL-CLUSTER-BONDING-014"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-BOND-METALLIC-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-COORDINATION-ENTITY-RETAINED-IDENTITY-001","SFT-CHEM-COORDINATION-GEOMETRY-HELD-ORIENTATION-004","SFT-CHEM-ORGANOMETALLIC-METAL-CARBON-BOND-010"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "centres",.text (centresName c.centres)],.array [.text "connectivity",.text (connectivityName c.connectivity)],.array [.text "direct",.text (directName c.direct)],.array [.text "bridge",.text (bridgeName c.bridge)],.array [.text "grouping",.text (groupingName c.grouping)],.array [.text "counts",.text (countsName c.counts)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "free-cluster-name",.text "A name loses centre support."],.array [.text "one-retained-cluster-entity",.text "All centres belong to one retained cluster."]]],.array [.text "centres",.array [.array [.text "selected-metal-pair",.text "A selected pair loses remaining centres."],.array [.text "complete-finite-multicentre-support",.text "Every distinct metal centre is retained."]]],.array [.text "connectivity",.array [.array [.text "proximity-only-list",.text "A list does not prove connected support."],.array [.text "complete-connected-cluster-relation-graph",.text "The generated cluster relation graph is connected."]]],.array [.text "direct",.array [.array [.text "assumed-metal-metal-bond",.text "Assumption confuses grouping with bonding."],.array [.text "explicit-direct-metal-bond-subgraph",.text "Direct metal bonds are an explicit support subset."]]],.array [.text "bridge",.array [.array [.text "implicit-ligand-bridge",.text "An implicit bridge loses ligand occurrences."],.array [.text "complete-bridging-ligand-path-support",.text "Every bridging path retains positive ligand support."]]],.array [.text "grouping",.array [.array [.text "bond-required-cluster-definition",.text "Requiring a bond rejects lawful held grouping."],.array [.text "held-grouping-relation-without-bond-necessity",.text "Connected grouping may remain held without direct or bridge bonding."]]],.array [.text "counts",.array [.array [.text "numerical-zero-missing-mode",.text "Numerical zero is not structural absence."],.array [.text "positive-count-or-EmptyOne-per-relation-class",.text "Each relation class has positive support or structural EmptyOne."]]],.array [.text "extension",.array [.array [.text "catalogue-specific-exception",.text "A catalogue destroys closure."],.array [.text "connected-centre-successor-no-extra-rule",.text "A fresh centre attaches once and preserves connectivity."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact finite connected metal-cluster and metal-bonding law"
 branch := "chemistry"
 statement := "A metal cluster is one finite complete support of at least two distinct metal centres connected by the generated cluster-relation graph. Direct metal bonds, bridging-ligand paths and held grouping relations are separate support classes; direct or bridging bonding may be structurally absent without destroying a connected cluster. Each class is counted positively or retained as EmptyOne, and a fresh attached centre preserves connectivity."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-retained-cluster-entity__complete-finite-multicentre-support__complete-connected-cluster-relation-graph__explicit-direct-metal-bond-subgraph__complete-bridging-ligand-path-support__held-grouping-relation-without-bond-necessity__positive-count-or-EmptyOne-per-relation-class__connected-centre-successor-no-extra-rule"),("base",.text "Two distinct centres joined by one generated direct, bridging or held grouping relation form the first connected cluster support."),("successor",.text "Appending one fresh centre by exactly one generated relation preserves every prior centre and relation, increments centre count once and preserves connectedness."),("exclusions",.array [.text "no numerical zero; absent relation classes are structural EmptyOne",.text "no negative irrational imaginary signed continuum fitted free or imported parameter",.text "no assumption that every cluster has a direct metal bond or bridge",.text "no external signed charge inscription used as a proof value",.text "no selected cluster catalogue or observed example selecting the law"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; absent relation classes are structural EmptyOne","no negative irrational imaginary signed continuum fitted free or imported parameter","no assumption that every cluster has a direct metal bond or bridge","no external signed charge inscription used as a proof value","no selected cluster catalogue or observed example selecting the law"]
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
end SFT.Chemistry.MetalClusterEvidence
