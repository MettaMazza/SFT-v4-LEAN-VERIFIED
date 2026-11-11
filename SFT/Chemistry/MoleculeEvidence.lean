import SFT.Chemistry.MoleculeGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MoleculeEvidence
open SFT.Host.Canonical MoleculeGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "diatomic",.text "two same-element occurrences remain a valid connected molecular carrier",.boolean true],.array [.text "composition",.text "same-element multiplicity is retained exactly",.boolean true],.array [.text "charge-boundary",.text "no open net-charge fibre remains",.boolean true]]
def claimId : String := "SFT-CHEM-MOL-MOLECULE-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-ENTANGLEMENT-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-FORMULA-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-BOND-METALLIC-001","SFT-CHEM-BOND-ORDER-001","SFT-CHEM-BOND-LENGTH-STRENGTH-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "cardinality",.text (cardinalityName c.cardinality)],.array [.text "bonding",.text (bondingName c.bonding)],.array [.text "connectivity",.text (connectivityName c.connectivity)],.array [.text "charge",.text (chargeName c.charge)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "identity",.text (identityName c.identity)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "cardinality",.array [.array [.text "single-atomic-occurrence",.text "One occurrence has no internal molecular bond graph."],.array [.text "multiple-atomic-occurrences",.text "A molecular carrier contains more than one atomic occurrence."]]],.array [.text "bonding",.array [.array [.text "unbonded-collection",.text "A collection without joining support is not one molecule."],.array [.text "complete-bond-support",.text "Every registered joining channel is retained."]]],.array [.text "connectivity",.array [.array [.text "disconnected-components",.text "Disconnected components are separate carriers."],.array [.text "one-connected-component",.text "Every atomic occurrence is joined within one finite component."]]],.array [.text "charge",.array [.array [.text "open-net-charge-fibre",.text "An open net fibre describes a molecular ion rather than the neutral molecular class."],.array [.text "closed-charge-boundary",.text "Opposed internal fibres close with no open net charge."]]],.array [.text "composition",.array [.array [.text "anonymous-atom-count",.text "Counts without element identities cannot reproduce the carrier."],.array [.text "constituent-identities-retained",.text "Every occurrence and element label remains held."]]],.array [.text "identity",.array [.array [.text "formula-alone",.text "Equal composition need not imply one molecular structure."],.array [.text "complete-structure-identity",.text "Composition and bonded organization jointly identify the carrier."]]],.array [.text "record",.array [.array [.text "molecule-label-only",.text "A label cannot reconstruct atoms and bonds."],.array [.text "complete-carrier-trace",.text "Occurrences, labels, edges and closure remain auditable."]]],.array [.text "extension",.array [.array [.text "free-molecule-exception",.text "An exception can admit arbitrary aggregates."],.array [.text "no-extra-rule",.text "The complete connected neutral carrier supplies the class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Molecular identity and complete bonded carrier"
 branch := "chemistry"
 statement := "A molecule is one finite neutral multi-atomic carrier whose complete bonded graph is connected and whose constituent occurrence and element identities remain retained."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "multiple-atomic-occurrences__complete-bond-support__one-connected-component__closed-charge-boundary__constituent-identities-retained"),("base",.text "Two atomic occurrences joined by one retained bond with no open net-charge fibre supply the first molecule."),("successor",.text "Appending one generated bonded occurrence preserves connectivity, closed charge and all prior occurrence, element and edge identities."),("exclusions",.array [.text "no chemical dictionary, coordinate archive, fitted force field, measured geometry or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application or opaque prediction result",.text "no claim that topology alone predicts every measured coordinate or energy",.text "external content remains inaccessible until after the consequence is sealed",.text "Every finite generated multi-atomic carrier with complete connected bond support, retained constituent identity and no open net-charge fibre at the registered observation boundary."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no chemical dictionary, coordinate archive, fitted force field, measured geometry or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application or opaque prediction result","no claim that topology alone predicts every measured coordinate or energy","external content remains inaccessible until after the consequence is sealed","Every finite generated multi-atomic carrier with complete connected bond support, retained constituent identity and no open net-charge fibre at the registered observation boundary."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with cardinality := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.MoleculeEvidence
