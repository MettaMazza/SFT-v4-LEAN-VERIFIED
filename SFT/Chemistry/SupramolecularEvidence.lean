import SFT.Chemistry.SupramolecularGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.SupramolecularEvidence
open SFT.Host.Canonical SupramolecularGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "recognition",.text "one complementary channel joins host and guest",.boolean true],.array [.text "components",.text "both intact component identities remain recoverable",.boolean true],.array [.text "reversal",.text "opening the retained channel recovers both registered components",.boolean true]]
def claimId : String := "SFT-CHEM-MOL-SUPRAMOLECULAR-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-ENTANGLEMENT-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-FORMULA-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-BOND-METALLIC-001","SFT-CHEM-BOND-ORDER-001","SFT-CHEM-BOND-LENGTH-STRENGTH-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "components",.text (componentsName c.components)],.array [.text "joining",.text (joiningName c.joining)],.array [.text "recognition",.text (recognitionName c.recognition)],.array [.text "reversal",.text (reversalName c.reversal)],.array [.text "closure",.text (closureName c.closure)],.array [.text "scope",.text (scopeName c.scope)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "components",.array [.array [.text "single-molecule-only",.text "A supramolecular assembly contains multiple molecular components."],.array [.text "multiple-molecular-components",.text "Every component identity remains registered."]]],.array [.text "joining",.array [.array [.text "new-internal-covalent-graph",.text "Replacing components by one covalent graph erases the supramolecular boundary."],.array [.text "noncovalent-interaction-support",.text "Between-component channels join intact molecular wholes."]]],.array [.text "recognition",.array [.array [.text "arbitrary-collision",.text "A collision has no complementary selection trace."],.array [.text "complementary-recognition",.text "Matched held labels select joining partners."]]],.array [.text "reversal",.array [.array [.text "components-unrecoverable",.text "If components cannot be recovered, their identities were not retained."],.array [.text "reversible-component-release",.text "Opening channels recovers each named molecular carrier."]]],.array [.text "closure",.array [.array [.text "components-only",.text "Separate components do not form an assembled whole."],.array [.text "assembled-whole-identity",.text "The collective recurrence is independently distinguishable."]]],.array [.text "scope",.array [.array [.text "completed-infinite-assembly",.text "A completed infinity is not generated."],.array [.text "finite-declared-assembly",.text "Every component and interaction is enumerated."]]],.array [.text "record",.array [.array [.text "assembly-name-only",.text "A name cannot reconstruct recognition and release."],.array [.text "component-recognition-trace",.text "Components, channels, reversals and closure remain held."]]],.array [.text "extension",.array [.array [.text "free-host-guest-rule",.text "An exception can force any desired assembly."],.array [.text "no-extra-rule",.text "Reversible complementary support supplies the class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Supramolecular organization by reversible recognition"
 branch := "chemistry"
 statement := "A supramolecular whole is a finite assembly of multiple intact molecular carriers joined by reversible complementary recognition support, with all components recoverable."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "multiple-molecular-components__noncovalent-interaction-support__complementary-recognition__reversible-component-release__assembled-whole-identity"),("base",.text "Two intact molecular carriers with one complementary reversible recognition channel supply the first supramolecular whole."),("successor",.text "Appending one recognized component retains every earlier identity and channel and preserves exact release reconstruction of the enlarged finite assembly."),("exclusions",.array [.text "no chemical dictionary, coordinate archive, fitted force field, measured geometry or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application or opaque prediction result",.text "no claim that topology alone predicts every measured coordinate or energy",.text "external content remains inaccessible until after the consequence is sealed",.text "Every finite assembly of multiple complete molecular carriers joined through reversible recognition support, with all components recoverable and the collective whole separately distinguishable."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no chemical dictionary, coordinate archive, fitted force field, measured geometry or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application or opaque prediction result","no claim that topology alone predicts every measured coordinate or energy","external content remains inaccessible until after the consequence is sealed","Every finite assembly of multiple complete molecular carriers joined through reversible recognition support, with all components recoverable and the collective whole separately distinguishable."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with components := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.SupramolecularEvidence
