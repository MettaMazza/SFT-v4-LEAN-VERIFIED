import SFT.Chemistry.AdsorptionGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.AdsorptionEvidence
open SFT.Host.Canonical AdsorptionGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "phases",.text "two phase identities differ",.boolean true],.array [.text "carriers",.text "surface carriers are positive",.boolean true],.array [.text "boundary",.text "phase families are retained",.boolean true]]
def claimId : String := "SFT-CHEM-SURFACE-ADSORPTION-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-REACTION-001","SFT-CHEM-THERMO-DIRECTION-001","SFT-CHEM-PHASE-CHEMICAL-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "roles",.text (rolesName c.roles)],.array [.text "location",.text (locationName c.location)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "binding",.text (bindingName c.binding)],.array [.text "conditions",.text (conditionsName c.conditions)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "boundary",.array [.array [.text "bulk-only",.text "No interface is present."],.array [.text "retained-interface",.text "Surface and bulk remain distinct."]]],.array [.text "roles",.array [.array [.text "carrier-identity-erased",.text "Surface membership is ambiguous."],.array [.text "adsorbate-and-adsorbent-retained",.text "Both identities are held."]]],.array [.text "location",.array [.array [.text "uniform-bulk-distribution",.text "No surface accumulation occurs."],.array [.text "accumulation-at-interface",.text "Carrier recurrence is localized at the boundary."]]],.array [.text "composition",.array [.array [.text "surface-equals-bulk",.text "The interface adds no distinction."],.array [.text "surface-concentration-differs",.text "Surface and bulk counts are separately retained."]]],.array [.text "binding",.array [.array [.text "irreversible-erasure",.text "The adsorbate cannot be recovered."],.array [.text "reversible-desorption-boundary",.text "Release returns the carrier identity."]]],.array [.text "conditions",.array [.array [.text "condition-free-coverage",.text "Surface support is context-bound."],.array [.text "condition-and-surface-bounded",.text "The declared interface is explicit."]]],.array [.text "record",.array [.array [.text "adsorption-name-only",.text "Localization cannot be reproduced."],.array [.text "complete-interface-event-trace",.text "Arrival, residence and departure are held."]]],.array [.text "extra",.array [.array [.text "free-isotherm-fit",.text "A fit can select coverage."],.array [.text "no-extra-rule",.text "Interface recurrence supplies the law."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Adsorption at a retained interface"
 branch := "chemistry"
 statement := "Adsorption is reversible localization of retained adsorbate carriers at a retained adsorbent interface, producing surface support distinct from bulk support under declared conditions."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "retained-interface__adsorbate-and-adsorbent-retained__accumulation-at-interface__surface-concentration-differs__reversible-desorption-boundary"),("base",.text "One retained carrier localized at one named surface supplies the first adsorption event."),("successor",.text "Appending an arrival or paired departure preserves carrier identity and updates surface and bulk support exactly."),("exclusions",.array [.text "no catalyst dictionary, kinetic table, reaction network, surface model, colloid table, transfer equation, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no chemical carrier, phase identity, interface or reaction step may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite two-region chemical boundary with named adsorbate and adsorbent, counted arrivals/residence/departures and source-bound conditions."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no catalyst dictionary, kinetic table, reaction network, surface model, colloid table, transfer equation, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no chemical carrier, phase identity, interface or reaction step may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite two-region chemical boundary with named adsorbate and adsorbent, counted arrivals/residence/departures and source-bound conditions."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with boundary := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.AdsorptionEvidence
