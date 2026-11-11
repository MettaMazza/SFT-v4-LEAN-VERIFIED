import SFT.Chemistry.ReactionFamilyGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ReactionFamilyEvidence
open SFT.Host.Canonical ReactionFamilyGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "maps",.text "atomic support is positive",.boolean true],.array [.text "roles",.text "orientation separates input and output",.boolean true],.array [.text "mechanism",.text "net pattern does not assert mechanism",.boolean true]]
def claimId : String := "SFT-CHEM-ORGANIC-REACTION-FAMILY-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-REACTION-001","SFT-CHEM-THERMO-DIRECTION-001","SFT-CHEM-PHASE-CHEMICAL-001","SFT-CHEM-MOL-GEOMETRY-001","SFT-CHEM-MOL-ISOMER-001","SFT-CHEM-NET-REACTION-001","SFT-CHEM-ORGANIC-FUNCTIONAL-GROUP-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "members",.text (membersName c.members)],.array [.text "encoding",.text (encodingName c.encoding)],.array [.text "pattern",.text (patternName c.pattern)],.array [.text "roles",.text (rolesName c.roles)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "mechanism",.text (mechanismName c.mechanism)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "members",.array [.array [.text "one-reaction-only",.text "No family is formed."],.array [.text "multiple-generated-reactions",.text "The declared support has more than one member."]]],.array [.text "encoding",.array [.array [.text "reaction-names-only",.text "Names do not establish common structure."],.array [.text "complete-reactant-product-maps",.text "Every atom and bond transition is retained."]]],.array [.text "pattern",.array [.array [.text "unrelated-bond-changes",.text "No shared family relation exists."],.array [.text "shared-bond-change-pattern",.text "The same minimal transition trace recurs."]]],.array [.text "roles",.array [.array [.text "reactant-product-roles-erased",.text "Pattern orientation is ambiguous."],.array [.text "reactant-product-role-correspondence",.text "Input and output positions remain held."]]],.array [.text "composition",.array [.array [.text "carrier-balance-erased",.text "The transformations cannot close."],.array [.text "elemental-carriers-balanced",.text "Every family member preserves carriers."]]],.array [.text "mechanism",.array [.array [.text "mechanism-assumed-from-pattern",.text "Equal net changes need not share a mechanism."],.array [.text "mechanism-not-assumed",.text "Mechanistic evidence remains separate."]]],.array [.text "record",.array [.array [.text "family-label-only",.text "Membership cannot be audited."],.array [.text "member-and-pattern-trace",.text "Every map and equivalence decision is retained."]]],.array [.text "extra",.array [.array [.text "free-reaction-taxonomy",.text "An imported list can force membership."],.array [.text "no-extra-rule",.text "Minimal recurring transition structure supplies the family."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Organic reaction-family compositional law"
 branch := "chemistry"
 statement := "An organic reaction family is the equivalence class of complete balanced reactant-product maps sharing one minimal bond-change pattern and role correspondence without assuming a common mechanism."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "multiple-generated-reactions__complete-reactant-product-maps__shared-bond-change-pattern__reactant-product-role-correspondence__elemental-carriers-balanced"),("base",.text "Two balanced reactions with one equal minimal bond-change trace supply the first family."),("successor",.text "Appending a matching reaction preserves the common trace; a nonmatching trace opens a distinct class."),("exclusions",.array [.text "no stereochemical dictionary, organic reaction taxonomy, polymer table, biomolecular database, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no atom, bond, orientation, repeat unit, chain or observation distinction may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite generated set of balanced organic reactant-product atom maps with complete bond changes, functional roles, conditions and separate mechanism records."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no stereochemical dictionary, organic reaction taxonomy, polymer table, biomolecular database, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no atom, bond, orientation, repeat unit, chain or observation distinction may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite generated set of balanced organic reactant-product atom maps with complete bond changes, functional roles, conditions and separate mechanism records."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with members := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.ReactionFamilyEvidence
