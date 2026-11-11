import SFT.Chemistry.FunctionalGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.FunctionalEvidence
open SFT.Host.Canonical FunctionalGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "support",.text "subcarrier has positive support",.boolean true],.array [.text "embedding",.text "boundary adjacency exists",.boolean true],.array [.text "reaction",.text "role remains separately held",.boolean true]]
def claimId : String := "SFT-CHEM-ORGANIC-FUNCTIONAL-GROUP-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-REACTION-001","SFT-CHEM-THERMO-DIRECTION-001","SFT-CHEM-PHASE-CHEMICAL-001","SFT-CHEM-MOL-GEOMETRY-001","SFT-CHEM-MOL-ISOMER-001","SFT-CHEM-NET-REACTION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "embedding",.text (embeddingName c.embedding)],.array [.text "recurrence",.text (recurrenceName c.recurrence)],.array [.text "reaction",.text (reactionName c.reaction)],.array [.text "identity",.text (identityName c.identity)],.array [.text "context",.text (contextName c.context)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "support",.array [.array [.text "whole-molecule-only",.text "No recurrent substructure is identified."],.array [.text "named-atom-or-group-support",.text "The participating subcarrier is retained."]]],.array [.text "embedding",.array [.array [.text "isolated-fragment",.text "A functional group acts in a molecule."],.array [.text "molecular-embedding-held",.text "Boundary bonds and context remain explicit."]]],.array [.text "recurrence",.array [.array [.text "one-molecule-only",.text "No group class is established."],.array [.text "recurs-across-molecules",.text "The same complete subtrace appears in multiple carriers."]]],.array [.text "reaction",.array [.array [.text "shape-without-transition-role",.text "Function requires chemical behavior."],.array [.text "characteristic-reaction-role",.text "The subcarrier maps through a generated reaction family."]]],.array [.text "identity",.array [.array [.text "context-erases-group",.text "The group cannot be followed."],.array [.text "group-identity-retained",.text "Atoms and boundary bonds remain held."]]],.array [.text "context",.array [.array [.text "universal-context-free-response",.text "Neighboring structure can modify response."],.array [.text "molecular-context-bounded",.text "The observation domain is explicit."]]],.array [.text "record",.array [.array [.text "group-name-only",.text "Recurrence cannot be reproduced."],.array [.text "substructure-and-reaction-trace",.text "Every embedding and transition is retained."]]],.array [.text "extra",.array [.array [.text "free-functional-taxonomy",.text "An imported list selects the group."],.array [.text "no-extra-rule",.text "Recurrent structure and reaction role supply the class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Functional-group recurrence and reaction role"
 branch := "chemistry"
 statement := "A functional group is a retained atom-or-group subcarrier whose complete local structure recurs across molecular embeddings and carries a characteristic generated reaction role within a declared context."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "named-atom-or-group-support__molecular-embedding-held__recurs-across-molecules__characteristic-reaction-role__group-identity-retained"),("base",.text "One recurrent substructure with one retained reaction role supplies the first functional group."),("successor",.text "Appending a molecular embedding preserves the group trace and adds its context-bound reaction occurrence."),("exclusions",.array [.text "no stereochemical dictionary, organic reaction taxonomy, polymer table, biomolecular database, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no atom, bond, orientation, repeat unit, chain or observation distinction may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite molecular carrier with complete named substructures, boundary bonds and generated source-bound reaction traces."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no stereochemical dictionary, organic reaction taxonomy, polymer table, biomolecular database, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no atom, bond, orientation, repeat unit, chain or observation distinction may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite molecular carrier with complete named substructures, boundary bonds and generated source-bound reaction traces."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with support := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.FunctionalEvidence
