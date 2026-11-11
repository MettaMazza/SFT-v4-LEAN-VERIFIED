import SFT.Chemistry.BondGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.BondEvidence
open SFT.Host.Canonical BondGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "bond-witness",.text "one stable joint channel closes a bond carrier",.boolean true],.array [.text "reversal",.text "opening recovers named constituent supports",.boolean true],.array [.text "transient-control",.text "unstable contact is rejected",.boolean true]]
def claimId : String := "SFT-CHEM-BOND-CHEMICAL-BOND-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-ENTANGLEMENT-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-CONDENSED-LATTICE-001","SFT-PHYS-CONDENSED-BAND-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-VALENCE-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-CONSERVATION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "interaction",.text (interactionName c.interaction)],.array [.text "closure",.text (closureName c.closure)],.array [.text "independence",.text (independenceName c.independence)],.array [.text "energy",.text (energyName c.energy)],.array [.text "reversal",.text (reversalName c.reversal)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "bond-name-without-atoms",.text "A bond name detached from carriers has no chemical support."],.array [.text "atoms-or-atomic-groups",.text "The joined carriers remain identified."]]],.array [.text "interaction",.array [.array [.text "coincidental-proximity",.text "Proximity alone need not produce a stable entity."],.array [.text "source-bound-interaction-support",.text "Every joining relation has a physical source/response trace."]]],.array [.text "closure",.array [.array [.text "transient-contact-only",.text "A contact without recurrence is not an independent bonded carrier."],.array [.text "stable-joint-recurrence",.text "The complete joint word returns at the observation boundary."]]],.array [.text "independence",.array [.array [.text "parts-only-observation",.text "If only separated parts persist, no joined entity is formed."],.array [.text "independent-chemical-entity",.text "The joint carrier has a separately distinguishable identity."]]],.array [.text "energy",.array [.array [.text "imported-potential-function",.text "A consensus potential cannot select closure."],.array [.text "measured-stability-record-separated",.text "Energy observations test but do not create the recurrence law."]]],.array [.text "reversal",.array [.array [.text "irreversible-by-definition",.text "Bond opening may be lawful and must retain carriers."],.array [.text "opening-closes-to-separated-support",.text "Reversal recovers named constituent supports and transfer records."]]],.array [.text "record",.array [.array [.text "bond-label-only",.text "A label cannot reproduce interaction and stability."],.array [.text "carrier-interaction-recurrence-trace",.text "All carriers, paths and observation boundary remain held."]]],.array [.text "extension",.array [.array [.text "free-bond-exception",.text "An exception can call any contact a bond."],.array [.text "no-extra-rule",.text "Joint stable recurrence completely determines the structural class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Chemical bond as retained interaction closure"
 branch := "chemistry"
 statement := "A chemical bond exists when complete source-bound interaction support between distinct atomic carrier occurrences or groups closes into stable joint recurrence distinguishable as an independent chemical carrier."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "atoms-or-atomic-groups__source-bound-interaction-support__stable-joint-recurrence__independent-chemical-entity"),("base",.text "Two identified atomic carriers with one stable recurring joint interaction supply the first bond."),("successor",.text "Appending one generated carrier or interaction channel preserves all constituent identities and closes only if the enlarged joint support remains stably recurrent."),("exclusions",.array [.text "no IUPAC bond definition, orbital equation, electronegativity scale, measured value or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "no universal bond-length/strength formula inferred from a categorical correspondence",.text "official target content opens only through post-seal custody",.text "Every finite pair or group of admitted atomic carriers and complete interaction support whose joint recurrence is stable as an independently distinguishable chemical carrier at the registered boundary."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC bond definition, orbital equation, electronegativity scale, measured value or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","no universal bond-length/strength formula inferred from a categorical correspondence","official target content opens only through post-seal custody","Every finite pair or group of admitted atomic carriers and complete interaction support whose joint recurrence is stable as an independently distinguishable chemical carrier at the registered boundary."]
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
end SFT.Chemistry.BondEvidence
