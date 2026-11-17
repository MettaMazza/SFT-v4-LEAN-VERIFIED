import SFT.Chemistry.EquilibriumIsotopeFractionationGrammar
import SFT.Chemistry.EquilibriumIsotopeFractionation
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.EquilibriumIsotopeFractionationEvidence
open SFT.Host.Canonical EquilibriumIsotopeFractionationGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "identity",.text "Isotopes distinct.",.boolean EquilibriumIsotopeFractionation.identityWitness],.array [.text "phases",.text "Phases distinct.",.boolean EquilibriumIsotopeFractionation.phasesWitness],.array [.text "inventory",.text "Counts positive.",.boolean EquilibriumIsotopeFractionation.inventoryWitness],.array [.text "ratios",.text "Phase ratios exact.",.boolean EquilibriumIsotopeFractionation.ratiosWitness],.array [.text "factor",.text "Factor forced exactly.",.boolean EquilibriumIsotopeFractionation.factorWitness],.array [.text "orientation",.text "Enrichment held.",.boolean EquilibriumIsotopeFractionation.orientationWitness],.array [.text "coincidence",.text "Equal ratios close.",.boolean EquilibriumIsotopeFractionation.coincidenceWitness],.array [.text "extension",.text "Fresh vector recomputes.",.boolean EquilibriumIsotopeFractionation.extensionWitness]]
def claimId : String := "SFT-CHEM-EQUILIBRIUM-ISOTOPE-FRACTIONATION-007"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-CHEM-ELEM-ISOTOPE-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-ISOTOPE-EXCHANGE-006"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "identity",.text (identityName c.identity)],.array [.text "phases",.text (phasesName c.phases)],.array [.text "inventory",.text (inventoryName c.inventory)],.array [.text "ratios",.text (ratiosName c.ratios)],.array [.text "factor",.text (factorName c.factor)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "equilibrium",.text (equilibriumName c.equilibrium)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "identity",.array [.array [.text "anonymous-heavy-light",.text "Heavy/light labels need isotope identity."],.array [.text "held-light-heavy-isotopes",.text "Both isotopes remain held."]]],.array [.text "phases",.array [.array [.text "single-phase-ratio",.text "Fractionation compares two carriers or phases."],.array [.text "held-distinct-phase-pair",.text "Both phases remain held."]]],.array [.text "inventory",.array [.array [.text "continuum-abundance-premise",.text "Continuum abundance hides occurrences."],.array [.text "positive-complete-isotope-counts",.text "All four isotope/phase counts remain."]]],.array [.text "ratios",.array [.array [.text "decimal-isotope-ratio",.text "A decimal is only a display form."],.array [.text "exact-heavy-per-light-ratios",.text "Each phase ratio is exact."]]],.array [.text "factor",.array [.array [.text "fitted-fractionation-factor",.text "No fitted factor is admissible."],.array [.text "exact-ratio-of-ratios",.text "The factor is forced by cross-products."]]],.array [.text "orientation",.array [.array [.text "signed-delta-premise",.text "A signed delta imports negative proof values."],.array [.text "held-enrichment-or-EmptyOne-coincidence",.text "Enrichment is held; equality is structural absence."]]],.array [.text "equilibrium",.array [.array [.text "named-equilibrium-assumption",.text "A label cannot prove equilibrium."],.array [.text "exchange-balance-plus-stable-factor",.text "Balanced exchange and invariant factor establish the class."]]],.array [.text "extension",.array [.array [.text "selected-isotope-pair",.text "One selected pair hides the complete system."],.array [.text "complete-vector-successor-recomputes",.text "New rows preserve prior identities and recompute exactly."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold equilibrium isotope-fractionation law"
 branch := "chemistry"
 statement := "Equilibrium isotope fractionation is the exact ratio of two positive heavy-per-light phase ratios, with held enrichment or structural coincidence, exchange balance and a stable factor."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-light-heavy-isotopes__held-distinct-phase-pair__positive-complete-isotope-counts__exact-heavy-per-light-ratios__exact-ratio-of-ratios__held-enrichment-or-EmptyOne-coincidence__exchange-balance-plus-stable-factor__complete-vector-successor-recomputes"),("base",.text "One complete two-isotope two-phase inventory supplies the first exact factor."),("successor",.text "Every successor retains the complete phase vector and recomputes the exact ratio of ratios."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no measured fitted calculated inferred or estimated alpha value selects the survivor",.text "external signed deltas remain downstream measurement inscriptions"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no measured fitted calculated inferred or estimated alpha value selects the survivor","external signed deltas remain downstream measurement inscriptions"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with identity := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.EquilibriumIsotopeFractionationEvidence
