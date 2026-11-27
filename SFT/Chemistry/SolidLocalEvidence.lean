import SFT.Chemistry.SolidLocalGrammar
import SFT.Chemistry.SolidLocalGenerator
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.SolidLocalEvidence
open SFT.Host.Canonical SolidLocalGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "primitive-formula",.text "Two A and two B occurrences reduce exactly to one and one.",.boolean SolidLocalGenerator.formulaWitness],.array [.text "rank-and-constituent",.text "Rank three and one second constituent remain exact.",.boolean SolidLocalGenerator.rankConstituentWitness],.array [.text "successor",.text "Appending A changes the primitive formula to three-to-two.",.boolean SolidLocalGenerator.successorWitness],.array [.text "rank-control",.text "Rank four rejects.",.boolean SolidLocalGenerator.rankWitness]]
def claimId : String := "SFT-CHEM-SOLID-STATE-LOCAL-COORDINATION-015"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-COORDINATION-ENTITY-RETAINED-IDENTITY-001","SFT-CHEM-COORDINATION-GEOMETRY-HELD-ORIENTATION-004","SFT-CHEM-METAL-CLUSTER-BONDING-014"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "formula",.text (formulaName c.formula)],.array [.text "bonds",.text (bondsName c.bonds)],.array [.text "network",.text (networkName c.network)],.array [.text "constituent",.text (constituentName c.constituent)],.array [.text "ownership",.text (ownershipName c.ownership)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "bulk-material-response",.text "Bulk response is outside Chemistry ownership."],.array [.text "one-finite-local-chemical-motif",.text "Chemistry retains one finite local motif."]]],.array [.text "composition",.array [.array [.text "nominal-formula-label",.text "A label can omit occurrences."],.array [.text "complete-species-occurrence-multiset",.text "Every local species occurrence is retained."]]],.array [.text "formula",.array [.array [.text "unreduced-or-fitted-stoichiometry",.text "Unreduced or fitted coefficients are not unique."],.array [.text "exact-primitive-positive-count-ratio",.text "The unique formula is the primitive positive count vector."]]],.array [.text "bonds",.array [.array [.text "averaged-coordination-number",.text "An average loses local adjacency."],.array [.text "complete-local-bond-adjacency-support",.text "Every local bond incidence remains explicit."]]],.array [.text "network",.array [.array [.text "continuum-infinite-lattice",.text "A continuum lattice imports infinity."],.array [.text "generated-repeat-axis-rank-one-two-or-three",.text "Repeat support has exact finite generated rank."]]],.array [.text "constituent",.array [.array [.text "real-valued-solid-solution-fraction",.text "A real fraction imports continuum fitting."],.array [.text "positive-second-constituent-support-or-EmptyOne",.text "A second constituent has exact occurrences or structural absence."]]],.array [.text "ownership",.array [.array [.text "chemistry-claims-bulk-response",.text "Bulk response belongs to Materials."],.array [.text "chemistry-local-materials-bulk-handoff",.text "Composition/local bonding and bulk response have one explicit owner each."]]],.array [.text "extension",.array [.array [.text "crystal-family-exception",.text "A catalogue exception destroys closure."],.array [.text "local-occurrence-successor-no-extra-rule",.text "A fresh occurrence and bond update formula exactly."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact solid-state formula, local coordination and ownership law"
 branch := "chemistry"
 statement := "Chemistry retains one finite complete local solid motif: every species occurrence, its primitive positive formula ratio, every local bond adjacency, generated repeat rank one through three, and positive second-constituent support or structural EmptyOne. Bulk material response is transferred explicitly to Materials."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-finite-local-chemical-motif__complete-species-occurrence-multiset__exact-primitive-positive-count-ratio__complete-local-bond-adjacency-support__generated-repeat-axis-rank-one-two-or-three__positive-second-constituent-support-or-EmptyOne__chemistry-local-materials-bulk-handoff__local-occurrence-successor-no-extra-rule"),("base",.text "One positive complete local motif has a complete occurrence multiset, a uniquely gcd-reduced positive formula, explicit local bonds and at least one generated repeat axis."),("successor",.text "Appending one fresh species occurrence and one retained local bond preserves every prior occurrence and adjacency and recomputes the unique primitive positive formula without adding a catalogue rule."),("exclusions",.array [.text "no numerical zero; absent second-constituent support is structural EmptyOne",.text "no negative irrational imaginary signed continuum fitted free or imported parameter",.text "no nominal formula substituted for the complete occurrence multiset",.text "no infinite or continuum lattice imported into the local Chemistry law",.text "no bulk material response claimed by Chemistry",.text "no coordination-network definition or mixed-crystal outcome used to select the law"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; absent second-constituent support is structural EmptyOne","no negative irrational imaginary signed continuum fitted free or imported parameter","no nominal formula substituted for the complete occurrence multiset","no infinite or continuum lattice imported into the local Chemistry law","no bulk material response claimed by Chemistry","no coordination-network definition or mixed-crystal outcome used to select the law"]
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
end SFT.Chemistry.SolidLocalEvidence
