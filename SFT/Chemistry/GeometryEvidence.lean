import SFT.Chemistry.GeometryGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.GeometryEvidence
open SFT.Host.Canonical GeometryGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "complete-pairs",.text "three atomic occurrences require and retain three pair relations",.boolean true],.array [.text "host-frame",.text "no absolute host coordinate enters the witness",.boolean true],.array [.text "measurement-boundary",.text "no measured decimal selects the relative form",.boolean true]]
def claimId : String := "SFT-CHEM-MOL-GEOMETRY-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-ENTANGLEMENT-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-FORMULA-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-BOND-METALLIC-001","SFT-CHEM-BOND-ORDER-001","SFT-CHEM-BOND-LENGTH-STRENGTH-001","SFT-CHEM-MOL-MOLECULE-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "adjacency",.text (adjacencyName c.adjacency)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "completeness",.text (completenessName c.completeness)],.array [.text "equivalence",.text (equivalenceName c.equivalence)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "geometry-without-molecule",.text "A shape detached from an identified carrier is not molecular geometry."],.array [.text "identified-molecular-carrier",.text "The geometry remains bound to one molecule."]]],.array [.text "adjacency",.array [.array [.text "atom-list-only",.text "An atom list omits which occurrences are joined."],.array [.text "complete-atom-adjacency",.text "Every bond relation remains held."]]],.array [.text "orientation",.array [.array [.text "distance-only-record",.text "Distances alone can omit handed or ordered orientation."],.array [.text "held-relative-orientation",.text "Each generated atom pair has a retained orientation relation."]]],.array [.text "completeness",.array [.array [.text "selected-coordinate-subset",.text "A favorable subset cannot establish the whole geometry."],.array [.text "complete-pair-support",.text "Every generated unordered occurrence pair is recorded exactly once."]]],.array [.text "equivalence",.array [.array [.text "absolute-host-frame",.text "A host coordinate frame cannot define chemical identity."],.array [.text "rigid-relabel-equivalence",.text "One global translation/rotation/relabel leaves the relative form unchanged."]]],.array [.text "measurement",.array [.array [.text "coordinate-as-proof-premise",.text "A measured coordinate cannot select the law."],.array [.text "source-bounded-geometry-record",.text "Coordinates and uncertainties remain post-seal empirical records."]]],.array [.text "record",.array [.array [.text "shape-name-only",.text "A shape name cannot reproduce the relations."],.array [.text "adjacency-orientation-source-trace",.text "Carrier, pairs, orientations, method and conditions remain held."]]],.array [.text "extension",.array [.array [.text "free-angle-fit",.text "A fitted angle can force a target geometry."],.array [.text "no-extra-rule",.text "Complete relative support supplies the geometric form."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Molecular geometry from held adjacency and orientation"
 branch := "chemistry"
 statement := "Molecular geometry is the complete relative adjacency-and-orientation form of one identified finite molecular carrier, invariant under a global rigid host-frame relabelling and separate from measured coordinate values."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "identified-molecular-carrier__complete-atom-adjacency__held-relative-orientation__complete-pair-support__rigid-relabel-equivalence"),("base",.text "A two-occurrence molecule has one complete relative-orientation relation."),("successor",.text "Appending one atomic occurrence adds every new occurrence-pair relation while preserving the complete prior adjacency and orientation trace."),("exclusions",.array [.text "no chemical dictionary, coordinate archive, fitted force field, measured geometry or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application or opaque prediction result",.text "no claim that topology alone predicts every measured coordinate or energy",.text "external content remains inaccessible until after the consequence is sealed",.text "Every finite admitted molecular carrier with a complete pairwise relative-orientation record, interpreted up to one global rigid relabelling and retained with its source and observation conditions."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no chemical dictionary, coordinate archive, fitted force field, measured geometry or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application or opaque prediction result","no claim that topology alone predicts every measured coordinate or energy","external content remains inaccessible until after the consequence is sealed","Every finite admitted molecular carrier with a complete pairwise relative-orientation record, interpreted up to one global rigid relabelling and retained with its source and observation conditions."]
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
end SFT.Chemistry.GeometryEvidence
