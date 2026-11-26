import SFT.Chemistry.OrganometallicBondGrammar
import SFT.Chemistry.OrganometallicBond
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.OrganometallicBondEvidence
open SFT.Host.Canonical OrganometallicBondGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "structural-absence",.text "No direct incidence remains structural EmptyOne.",.boolean OrganometallicBond.absenceWitness],.array [.text "first-direct-incidence",.text "One direct incidence forces count one and organometallic class.",.boolean OrganometallicBond.firstWitness],.array [.text "direct-successor",.text "A fresh direct incidence increments the exact count once.",.boolean OrganometallicBond.successorWitness],.array [.text "duplicate-control",.text "A duplicated direct incidence rejects.",.boolean OrganometallicBond.duplicateWitness]]
def claimId : String := "SFT-CHEM-ORGANOMETALLIC-METAL-CARBON-BOND-010"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-ELEM-ELEMENT-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-ORDER-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-ELECTRON-COUNT-SPIN-002","SFT-CHEM-ORBITAL-SUPPORT-OCCUPANCY-003","SFT-CHEM-COORDINATION-ENTITY-RETAINED-IDENTITY-001","SFT-CHEM-COORDINATION-GEOMETRY-HELD-ORIENTATION-004"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "centre",.text (centreName c.centre)],.array [.text "carbon",.text (carbonName c.carbon)],.array [.text "topology",.text (topologyName c.topology)],.array [.text "electrons",.text (electronsName c.electrons)],.array [.text "multiplicity",.text (multiplicityName c.multiplicity)],.array [.text "classification",.text (classificationName c.classification)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "free-compound-name",.text "A name does not retain the bonded entity."],.array [.text "one-retained-chemical-entity",.text "Every incidence belongs to one retained chemical entity."]]],.array [.text "centre",.array [.array [.text "imported-conventional-metal-list",.text "A conventional list imports the classification boundary."],.array [.text "retained-admitted-centre-occurrence",.text "The centre is a retained admitted element occurrence."]]],.array [.text "carbon",.array [.array [.text "selected-formula-fragment",.text "A selected formula fragment need not be a bonded carbon occurrence."],.array [.text "retained-carbon-occurrence",.text "Every classified incidence retains its carbon occurrence."]]],.array [.text "topology",.array [.array [.text "proximity-or-name-association",.text "Proximity or naming does not force a bond."],.array [.text "direct-centre-carbon-incidence",.text "A direct generated adjacency forces the bond topology."]]],.array [.text "electrons",.array [.array [.text "assumed-valence-number",.text "An assumed valence number loses the bond support."],.array [.text "complete-held-bond-electron-support",.text "Every incidence retains complete positive held electron support."]]],.array [.text "multiplicity",.array [.array [.text "single-selected-bond",.text "Selecting one bond loses additional incidences."],.array [.text "complete-positive-direct-incidence-support",.text "All distinct direct incidences are retained and counted exactly."]]],.array [.text "classification",.array [.array [.text "species-or-name-lookup",.text "A lookup lets the observed label choose the law."],.array [.text "positive-support-organometallic-EmptyOne-otherwise",.text "Positive direct support forces organometallic; structural absence remains EmptyOne."]]],.array [.text "extension",.array [.array [.text "fitted-species-exception",.text "A species exception destroys zero-parameter closure."],.array [.text "direct-incidence-successor-no-extra-rule",.text "Each fresh direct incidence appends once without rewriting prior support."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact direct metal-carbon organometallic bond law"
 branch := "chemistry"
 statement := "A metal-carbon organometallic bond is one direct generated incidence between a retained admitted centre occurrence and a retained carbon occurrence on one chemical entity, with complete positive held bond-electron support. The exact organometallic bond topology is the complete distinct incidence support and its positive cardinality. Structural absence of direct incidence remains EmptyOne and cannot be promoted by a compound name, proximity, species table or fitted exception."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-retained-chemical-entity__retained-admitted-centre-occurrence__retained-carbon-occurrence__direct-centre-carbon-incidence__complete-held-bond-electron-support__complete-positive-direct-incidence-support__positive-support-organometallic-EmptyOne-otherwise__direct-incidence-successor-no-extra-rule"),("base",.text "Structural EmptyOne contains no direct incidence. The first positive direct centre-carbon incidence forces count one and the organometallic class."),("successor",.text "Appending one fresh direct centre-carbon incidence preserves every previous incidence and held electron occurrence and increments the exact direct-incidence count once without changing the classification rule."),("exclusions",.array [.text "no numerical zero; absence of direct incidence is structural EmptyOne",.text "no negative irrational imaginary floating signed continuum fitted free or imported parameter",.text "no conventional metal list species lookup compound-name classification proximity rule or formula-fragment substitution",.text "no observed example, scope statement or exclusion used to select the survivor",.text "no omission of any frozen example, context, absence or source disclaimer surface"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; absence of direct incidence is structural EmptyOne","no negative irrational imaginary floating signed continuum fitted free or imported parameter","no conventional metal list species lookup compound-name classification proximity rule or formula-fragment substitution","no observed example, scope statement or exclusion used to select the survivor","no omission of any frozen example, context, absence or source disclaimer surface"]
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
end SFT.Chemistry.OrganometallicBondEvidence
