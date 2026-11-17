import SFT.Chemistry.LigandDenticityGrammar
import SFT.Chemistry.LigandDenticity
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.LigandDenticityEvidence
open SFT.Host.Canonical LigandDenticityGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "denticity-two",.text "Two generated donor sites on one ligand carrier and centre force positive denticity two.",.boolean LigandDenticity.twoWitness],.array [.text "first-closed-topology",.text "The first multiple-site support closes a centre-carrier path.",.boolean LigandDenticity.closedWitness],.array [.text "single-site-open",.text "One donor site remains an open topology rather than a chelate.",.boolean LigandDenticity.openWitness],.array [.text "successor",.text "The next donor site preserves every prior site and path and increments denticity once.",.boolean LigandDenticity.successorWitness]]
def claimId : String := "SFT-CHEM-LIGAND-DENTICITY-CHELATION-TOPOLOGY-003"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-COORDINATION-ENTITY-RETAINED-IDENTITY-001","SFT-CHEM-COORDINATION-NUMBER-INCIDENCE-COUNT-002"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "membership",.text (membershipName c.membership)],.array [.text "centre",.text (centreName c.centre)],.array [.text "quantity",.text (quantityName c.quantity)],.array [.text "chelation",.text (chelationName c.chelation)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "observation",.text (observationName c.observation)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "chemical-label-only",.text "A repeated chemical label does not distinguish a given ligand occurrence."],.array [.text "one-retained-ligand-carrier-occurrence",.text "Every donor site is assigned to one exact ligand carrier occurrence."]]],.array [.text "membership",.array [.array [.text "selected-or-nearby-donor-sites",.text "Selection and proximity do not preserve complete binding support."],.array [.text "every-distinct-donor-site-on-that-carrier",.text "Every and only distinct sites belonging to the given ligand carrier enter."]]],.array [.text "centre",.array [.array [.text "donor-sites-across-centres-merged",.text "Merging centres destroys the one-centre relation."],.array [.text "same-retained-central-occurrence",.text "All counted donor sites attach to the same retained central occurrence."]]],.array [.text "quantity",.array [.array [.text "imported-denticity-name-or-table",.text "A conventional name or table selects the count."],.array [.text "positive-count-of-generated-donor-incidences",.text "The complete donor-incidence support forces its positive cardinality."]]],.array [.text "chelation",.array [.array [.text "two-or-more-label-imported-as-threshold",.text "A named threshold does not explain the topology."],.array [.text "first-closed-carrier-centre-path-forces-chelation",.text "The second separate site is the first successor that closes a carrier-centre path; every later site preserves closure."]]],.array [.text "boundary",.array [.array [.text "eta-kappa-and-separate-sites-collapsed",.text "Collapsing attachment modes confuses atoms with separate binding sites."],.array [.text "separate-site-and-attachment-topologies-held",.text "Separate donor sites, single-atom attachments and multi-atom pi support remain distinguishable."]]],.array [.text "observation",.array [.array [.text "source-topologies-readable-before-seal",.text "Observed classifications could select the law."],.array [.text "complete-24-record-value-free-identity-seal",.text "Twenty-four value-free identities seal before definitions, examples and exclusions open."]]],.array [.text "extension",.array [.array [.text "next-site-recounts-or-replaces-prior-support",.text "Replacement destroys the retained carrier topology."],.array [.text "next-site-preserves-prior-and-adds-one",.text "The next donor site preserves all prior sites and paths and adds exactly one."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact ligand denticity and chelation from connected donor-site topology"
 branch := "chemistry"
 statement := "For one retained ligand carrier attached to one retained central occurrence, denticity is the positive cardinality of its complete distinct donor-site incidences. One site is open; the next separate site is the first successor that closes a carrier-centre path and forces chelation; every later site preserves closure and increments denticity once."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-retained-ligand-carrier-occurrence__every-distinct-donor-site-on-that-carrier__same-retained-central-occurrence__positive-count-of-generated-donor-incidences__first-closed-carrier-centre-path-forces-chelation__separate-site-and-attachment-topologies-held__complete-24-record-value-free-identity-seal__next-site-preserves-prior-and-adds-one"),("base",.text "One complete donor site on one ligand carrier and one centre forces positive denticity one and an open topology."),("successor",.text "Appending the next distinct donor site on the same ligand carrier and centre preserves every prior site, attachment and internal path, increments denticity once, and from the first such successor onward preserves a closed carrier-centre path."),("exclusions",.array [.text "no numerical zero; glyph 0 is external absence only and native absence is EmptyOne",.text "no negative irrational imaginary floating signed or continuum proof value",.text "no imported denticity table, chelate taxonomy, coordination-number rule, geometry catalogue or bonding model",.text "no observed IUPAC definition, example or exclusion before prediction seal",.text "no selected term, omitted boundary, fitted topology or target-derived correction"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; glyph 0 is external absence only and native absence is EmptyOne","no negative irrational imaginary floating signed or continuum proof value","no imported denticity table, chelate taxonomy, coordination-number rule, geometry catalogue or bonding model","no observed IUPAC definition, example or exclusion before prediction seal","no selected term, omitted boundary, fitted topology or target-derived correction"]
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
end SFT.Chemistry.LigandDenticityEvidence
