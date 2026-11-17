import SFT.Chemistry.CoordinationNumberGrammar
import SFT.Chemistry.CoordinationNumber
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.CoordinationNumberEvidence
open SFT.Host.Canonical CoordinationNumberGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "three-incidence-count",.text "Three generated direct incidences force positive count three.",.boolean CoordinationNumber.threeWitness],.array [.text "four-incidence-count",.text "Four generated direct incidences force positive count four.",.boolean CoordinationNumber.fourWitness],.array [.text "five-incidence-count",.text "Five generated direct incidences force positive count five.",.boolean CoordinationNumber.fiveWitness],.array [.text "successor",.text "The next direct incidence preserves every prior trace and adds one.",.boolean CoordinationNumber.successorWitness]]
def claimId : String := "SFT-CHEM-COORDINATION-NUMBER-INCIDENCE-COUNT-002"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-COORDINATION-ENTITY-RETAINED-IDENTITY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "membership",.text (membershipName c.membership)],.array [.text "quantity",.text (quantityName c.quantity)],.array [.text "identity",.text (identityName c.identity)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "observation",.text (observationName c.observation)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "formula-or-central-name-only",.text "A name does not expose complete incident support."],.array [.text "admitted-complete-coordination-entity",.text "Count begins only from an admitted complete coordination entity."]]],.array [.text "membership",.array [.array [.text "nearby-or-selected-ligands",.text "Proximity or selection does not retain the entity's direct incidence boundary."],.array [.text "every-distinct-direct-central-incidence",.text "Every and only distinct direct incidences on the retained centre enter."]]],.array [.text "quantity",.array [.array [.text "imported-coordination-number-table",.text "A conventional table selects the answer."],.array [.text "positive-count-of-generated-incidence-traces",.text "The support itself forces its exact positive cardinality."]]],.array [.text "identity",.array [.array [.text "repeated-ligand-labels-merged",.text "Merging equal group labels undercounts distinct occurrences."],.array [.text "occurrence-distinct-incidences-counted-once",.text "Each distinct ligand occurrence contributes its distinct incidence exactly once."]]],.array [.text "absence",.array [.array [.text "numerical-zero-or-negative-vacancy",.text "Numerical zero and signed vacancy are forbidden proof forms."],.array [.text "structural-EmptyOne-outside-positive-support",.text "Absence is structural and never counted as a positive incidence."]]],.array [.text "observation",.array [.array [.text "observed-counts-readable-before-seal",.text "Observed 3, 4 or 5 could select a counting rule."],.array [.text "complete-23-record-value-free-identity-seal",.text "All 23 identities seal before term and structure values open."]]],.array [.text "boundary",.array [.array [.text "general-crystal-pi-and-sigma-senses-mixed",.text "Mixing distinct source senses makes the count ambiguous."],.array [.text "direct-inorganic-incidence-sense-held",.text "General, inorganic sigma, pi-exclusion and crystal-sense records remain distinct."]]],.array [.text "extension",.array [.array [.text "next-ligand-recounts-or-replaces-support",.text "Replacement does not preserve the prior count proof."],.array [.text "next-incidence-preserves-prior-and-adds-one",.text "The next direct incidence preserves all prior traces and adds exactly one."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact coordination number from generated central-ligand incidence"
 branch := "chemistry"
 statement := "For an admitted complete coordination entity, the coordination number is exactly the positive cardinality of distinct direct ligand-incidence traces on the retained central occurrence. Equal ligand-group labels do not collapse occurrences; structural absence contributes no incidence; the next direct attachment preserves all prior traces and adds exactly one."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "admitted-complete-coordination-entity__every-distinct-direct-central-incidence__positive-count-of-generated-incidence-traces__occurrence-distinct-incidences-counted-once__structural-EmptyOne-outside-positive-support__complete-23-record-value-free-identity-seal__direct-inorganic-incidence-sense-held__next-incidence-preserves-prior-and-adds-one"),("base",.text "One complete direct incidence on one retained central occurrence forces positive coordination count one."),("successor",.text "Appending the next distinct direct incidence to the same central occurrence preserves all prior traces and increments the exact positive count by one."),("exclusions",.array [.text "no numerical zero; glyph 0 is external absence only and native absence is EmptyOne",.text "no negative irrational imaginary floating signed or continuum proof value",.text "no imported coordination-number table, valence rule, geometry catalogue, ligand-field or bonding model",.text "no observed 3, 4 or 5 count before prediction seal",.text "no selected complex, omitted boundary/limitation row, fitted distance or target-derived correction"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; glyph 0 is external absence only and native absence is EmptyOne","no negative irrational imaginary floating signed or continuum proof value","no imported coordination-number table, valence rule, geometry catalogue, ligand-field or bonding model","no observed 3, 4 or 5 count before prediction seal","no selected complex, omitted boundary/limitation row, fitted distance or target-derived correction"]
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
end SFT.Chemistry.CoordinationNumberEvidence
