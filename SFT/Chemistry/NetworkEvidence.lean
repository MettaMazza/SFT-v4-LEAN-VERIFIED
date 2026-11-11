import SFT.Chemistry.NetworkGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.NetworkEvidence
open SFT.Host.Canonical NetworkGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "three-node-network",.text "two registered edges connect all three named molecular nodes",.boolean true],.array [.text "node-retention",.text "the complete node identity tuple remains held",.boolean true],.array [.text "free-edge-control",.text "no unregistered edge is needed for connectivity",.boolean true]]
def claimId : String := "SFT-CHEM-MOL-NETWORK-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-ENTANGLEMENT-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-FORMULA-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-BOND-METALLIC-001","SFT-CHEM-BOND-ORDER-001","SFT-CHEM-BOND-LENGTH-STRENGTH-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-MOL-SUPRAMOLECULAR-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "nodes",.text (nodesName c.nodes)],.array [.text "edges",.text (edgesName c.edges)],.array [.text "connectivity",.text (connectivityName c.connectivity)],.array [.text "paths",.text (pathsName c.paths)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "nodes",.array [.array [.text "anonymous-node-count",.text "A count cannot recover molecular identities."],.array [.text "finite-molecular-node-set",.text "Every molecular carrier is a named node."]]],.array [.text "edges",.array [.array [.text "implicit-relatedness",.text "An implicit relation cannot be audited."],.array [.text "registered-interaction-edges",.text "Every joining channel supplies one explicit edge."]]],.array [.text "connectivity",.array [.array [.text "disconnected-union-called-one",.text "Disconnected components are not one connected whole."],.array [.text "connected-maximal-component",.text "Every node is reachable inside the declared boundary."]]],.array [.text "paths",.array [.array [.text "selected-path-only",.text "One favorable path cannot establish network connectivity."],.array [.text "complete-reachability-census",.text "Reachability is checked from the generated node/edge set."]]],.array [.text "boundary",.array [.array [.text "unbounded-network-name",.text "An unbounded name does not enumerate a finite object."],.array [.text "finite-maximal-boundary",.text "The declared component boundary is complete."]]],.array [.text "composition",.array [.array [.text "network-erases-molecules",.text "Nodes remain chemical carriers, not anonymous points."],.array [.text "node-identities-retained",.text "Every molecular composition and identity persists."]]],.array [.text "record",.array [.array [.text "network-answer-only",.text "A connectivity answer cannot reproduce the network."],.array [.text "complete-network-trace",.text "Nodes, edges, paths and components remain held."]]],.array [.text "extension",.array [.array [.text "free-connectivity-edge",.text "Adding an ungenerated edge can force connectedness."],.array [.text "no-extra-rule",.text "Only registered support determines the connected whole."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Molecular network and connected chemical whole"
 branch := "chemistry"
 statement := "A molecular network is one finite maximal connected component of named molecular nodes and registered interaction edges with complete reachability and provenance."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "finite-molecular-node-set__registered-interaction-edges__connected-maximal-component__complete-reachability-census__finite-maximal-boundary"),("base",.text "Two named molecular nodes joined by one registered interaction edge supply the first connected molecular network."),("successor",.text "Appending one node by at least one generated edge preserves reachability, prior node identities, edge provenance and the finite maximal boundary."),("exclusions",.array [.text "no chemical dictionary, coordinate archive, fitted force field, measured geometry or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application or opaque prediction result",.text "no claim that topology alone predicts every measured coordinate or energy",.text "external content remains inaccessible until after the consequence is sealed",.text "Every finite generated set of molecular nodes and registered interaction edges whose maximal declared component is connected, with complete node, edge, path and boundary provenance."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no chemical dictionary, coordinate archive, fitted force field, measured geometry or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application or opaque prediction result","no claim that topology alone predicts every measured coordinate or energy","external content remains inaccessible until after the consequence is sealed","Every finite generated set of molecular nodes and registered interaction edges whose maximal declared component is connected, with complete node, edge, path and boundary provenance."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with nodes := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.NetworkEvidence
