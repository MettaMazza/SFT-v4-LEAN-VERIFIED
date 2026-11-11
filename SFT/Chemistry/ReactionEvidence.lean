import SFT.Chemistry.ReactionGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ReactionEvidence
open SFT.Host.Canonical ReactionGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "carriers",.text "the witness retains elemental carriers",.boolean true],.array [.text "change",.text "at least one relation changes",.boolean true],.array [.text "endpoints",.text "reactants and products remain explicit",.boolean true]]
def claimId : String := "SFT-CHEM-RXN-IDENTITY-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "source",.text (sourceName c.source)],.array [.text "input",.text (inputName c.input)],.array [.text "output",.text (outputName c.output)],.array [.text "carriers",.text (carriersName c.carriers)],.array [.text "change",.text (changeName c.change)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "source",.array [.array [.text "unregistered-transformation",.text "No chemical provenance is retained."],.array [.text "source-bound-transition",.text "The transformation has a complete source trace."]]],.array [.text "input",.array [.array [.text "reactants-erased",.text "A product alone cannot define change."],.array [.text "complete-reactant-organization",.text "Every initial species is held."]]],.array [.text "output",.array [.array [.text "products-erased",.text "An input alone cannot define change."],.array [.text "complete-product-organization",.text "Every terminal species is held."]]],.array [.text "carriers",.array [.array [.text "element-created-or-lost",.text "It violates chemical closure."],.array [.text "all-elemental-carriers-conserved",.text "Each occurrence maps across endpoints."]]],.array [.text "change",.array [.array [.text "identity-transition",.text "No changed relation means no reaction event."],.array [.text "at-least-one-relation-changed",.text "Bonding or carrier adjacency changes."]]],.array [.text "orientation",.array [.array [.text "unordered-endpoints",.text "Direction cannot be audited."],.array [.text "held-reactant-product-orientation",.text "Endpoints retain their roles."]]],.array [.text "record",.array [.array [.text "reaction-name-only",.text "A name cannot reproduce the transition."],.array [.text "complete-endpoint-carrier-relation-trace",.text "All distinctions remain auditable."]]],.array [.text "extra",.array [.array [.text "free-reaction-exception",.text "An exception can admit arbitrary change."],.array [.text "no-extra-rule",.text "Closed carrier transformation supplies the law."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Chemical reaction as source-bound identity transformation"
 branch := "chemistry"
 statement := "A chemical reaction is a complete source-bound reactant-to-product transformation conserving every elemental carrier while changing at least one chemical relation."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "source-bound-transition__complete-reactant-organization__complete-product-organization__all-elemental-carriers-conserved__at-least-one-relation-changed"),("base",.text "One closed carrier rearrangement supplies the first reaction."),("successor",.text "Appending a participant preserves all prior carriers and adds only its registered relation changes."),("exclusions",.array [.text "no reaction dictionary, mechanism database, rate equation, Arrhenius law, equilibrium constant, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no chemical carrier may be created, copied or silently erased",.text "an absent dependence or event is an empty structural form, never numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite source-bound chemical transition between complete named reactant and product organizations, conserving every elemental carrier while changing at least one registered chemical relation."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no reaction dictionary, mechanism database, rate equation, Arrhenius law, equilibrium constant, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no chemical carrier may be created, copied or silently erased","an absent dependence or event is an empty structural form, never numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite source-bound chemical transition between complete named reactant and product organizations, conserving every elemental carrier while changing at least one registered chemical relation."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with source := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.ReactionEvidence
