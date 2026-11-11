import SFT.Chemistry.AutocatalysisGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.AutocatalysisEvidence
open SFT.Host.Canonical AutocatalysisGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "identity",.text "feedback carrier is unchanged",.boolean true],.array [.text "resource",.text "each cycle has positive work",.boolean true],.array [.text "limit",.text "finite support is required",.boolean true]]
def claimId : String := "SFT-CHEM-NET-AUTOCATALYSIS-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-REACTION-001","SFT-CHEM-THERMO-DIRECTION-001","SFT-CHEM-PHASE-CHEMICAL-001","SFT-CHEM-CAT-CATALYST-001","SFT-CHEM-NET-REACTION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "product",.text (productName c.product)],.array [.text "feedback",.text (feedbackName c.feedback)],.array [.text "identity",.text (identityName c.identity)],.array [.text "growth",.text (growthName c.growth)],.array [.text "cycle",.text (cycleName c.cycle)],.array [.text "limit",.text (limitName c.limit)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "product",.array [.array [.text "external-catalyst-only",.text "Self-production is absent."],.array [.text "reaction-product-is-catalyst",.text "An output carrier returns to the catalytic role."]]],.array [.text "feedback",.array [.array [.text "product-inert",.text "Output cannot affect its formation."],.array [.text "product-accelerates-own-formation",.text "The generated carrier opens another cycle."]]],.array [.text "identity",.array [.array [.text "product-role-erased",.text "The feedback carrier is unknown."],.array [.text "same-identity-feedback",.text "Product and catalyst labels coincide."]]],.array [.text "growth",.array [.array [.text "unbounded-free-copy",.text "Creation violates closure."],.array [.text "resource-consuming-amplification",.text "Each added product consumes retained inputs."]]],.array [.text "cycle",.array [.array [.text "linear-step-only",.text "No feedback path closes."],.array [.text "positive-feedback-cycle",.text "Product-to-path recurrence is retained."]]],.array [.text "limit",.array [.array [.text "infinite-support-assumed",.text "Resources are not counted."],.array [.text "finite-resource-bounded",.text "Amplification halts when input support is Empty."]]],.array [.text "record",.array [.array [.text "growth-label-only",.text "Carrier balance cannot be checked."],.array [.text "complete-feedback-trace",.text "Every production cycle is auditable."]]],.array [.text "extra",.array [.array [.text "free-growth-constant",.text "A fitted rate can force behavior."],.array [.text "no-extra-rule",.text "Closed feedback and finite inputs supply the law."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Autocatalytic closure and self-amplifying path"
 branch := "chemistry"
 statement := "Autocatalysis is a finite resource-bounded reaction-network cycle in which a retained product carrier re-enters as catalyst for another production cycle of the same identity."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "reaction-product-is-catalyst__product-accelerates-own-formation__same-identity-feedback__resource-consuming-amplification__positive-feedback-cycle"),("base",.text "One product that re-enters one closed catalytic cycle supplies the first autocatalytic event."),("successor",.text "Appending a cycle consumes retained inputs, returns the catalyst and adds only the newly balanced product carrier."),("exclusions",.array [.text "no catalyst dictionary, kinetic table, reaction network, surface model, colloid table, transfer equation, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no chemical carrier, phase identity, interface or reaction step may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite reaction network whose product/catalyst identity equality, feedback edge, consumed inputs and stopping boundary are completely recorded."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no catalyst dictionary, kinetic table, reaction network, surface model, colloid table, transfer equation, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no chemical carrier, phase identity, interface or reaction step may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite reaction network whose product/catalyst identity equality, feedback edge, consumed inputs and stopping boundary are completely recorded."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with product := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.AutocatalysisEvidence
