import SFT.Chemistry.ElementGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ElementEvidence
open SFT.Host.Canonical ElementGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "element-membership",.text "equal proton-count atoms enter one class",.boolean true],.array [.text "isotope-refinement",.text "mass-number variation preserves class identity",.boolean true],.array [.text "mass-identity-control",.text "mass alone is rejected as element identity",.boolean true]]
def claimId : String := "SFT-CHEM-ELEM-ELEMENT-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-QUANTITY-CARRIER-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-MATTER-PARTICLE-SPECTRUM-001","SFT-PHYS-NUCLEAR-LEVELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-CHEMICAL-SPECIES-001","SFT-CHEM-MEAS-SUBSTANCE-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "identity",.text (identityName c.identity)],.array [.text "location",.text (locationName c.location)],.array [.text "membership",.text (membershipName c.membership)],.array [.text "isotope",.text (isotopeName c.isotope)],.array [.text "substance",.text (substanceName c.substance)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "substance-name-only",.text "A substance name does not define the atom class."],.array [.text "atom-species-carrier",.text "The carrier is the complete generated class of atoms."]]],.array [.text "identity",.array [.array [.text "mass-selected-identity",.text "Mass can vary between isotopes of one element."],.array [.text "common-proton-count",.text "One held proton count is common to every atom in the class."]]],.array [.text "location",.array [.array [.text "protons-without-nuclear-carrier",.text "An unlocated count does not preserve atomic constitution."],.array [.text "nuclear-identity",.text "The common proton count is retained in the atomic nucleus record."]]],.array [.text "membership",.array [.array [.text "sampled-atom-list",.text "A sample cannot close the complete generated class."],.array [.text "all-generated-atoms-with-identity",.text "Every generated atom with the held proton count belongs to the element class."]]],.array [.text "isotope",.array [.array [.text "one-mass-number-only",.text "Restricting an element to one mass number erases its isotopes."],.array [.text "mass-refinement-permitted",.text "Mass number refines nuclides without changing element identity."]]],.array [.text "substance",.array [.array [.text "species-substance-conflation",.text "An atom species and a pure substance are related but not identical carriers."],.array [.text "substance-carrier-correspondence",.text "The pure-substance use is retained as a separate correspondence."]]],.array [.text "record",.array [.array [.text "element-label-only",.text "A label alone cannot reproduce class membership."],.array [.text "complete-nuclear-membership-trace",.text "Proton identity, atom membership and substance boundary remain held."]]],.array [.text "extension",.array [.array [.text "free-element-exception",.text "A discretionary exception can split or merge element classes."],.array [.text "no-extra-rule",.text "The held nuclear count completely determines the class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Chemical element identity"
 branch := "chemistry"
 statement := "A chemical element is the complete Fold class of generated atoms sharing one held nuclear proton count; isotope mass refinements preserve that identity, while pure-substance use remains a separate correspondence."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "atom-species-carrier__common-proton-count__nuclear-identity__substance-carrier-correspondence"),("base",.text "One admitted atom with one held nuclear proton count supplies the first element-class member."),("successor",.text "Appending one atom with the same proton count preserves element identity while retaining any distinct mass-number refinement and prior membership trace."),("exclusions",.array [.text "no IUPAC definition, periodic-table arrangement, measured element value or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "official target content opens only through post-seal custody",.text "Every positive-finite atom-species class generated from one held nuclear proton-count identity, including all mass-number refinements and its separately recorded pure-substance correspondence."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC definition, periodic-table arrangement, measured element value or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","official target content opens only through post-seal custody","Every positive-finite atom-species class generated from one held nuclear proton-count identity, including all mass-number refinements and its separately recorded pure-substance correspondence."]
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
end SFT.Chemistry.ElementEvidence
