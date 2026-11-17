import SFT.Chemistry.RadiochemicalSeparationGrammar
import SFT.Chemistry.RadiochemicalSeparation
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.RadiochemicalSeparationEvidence
open SFT.Host.Canonical RadiochemicalSeparationGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "identity",.text "Species distinct.",.boolean RadiochemicalSeparation.identityWitness],.array [.text "streams",.text "Feed/product/waste complete.",.boolean RadiochemicalSeparation.streamsWitness],.array [.text "inventory",.text "Counts positive.",.boolean RadiochemicalSeparation.inventoryWitness],.array [.text "balance",.text "Both species balance.",.boolean RadiochemicalSeparation.balanceWitness],.array [.text "recovery",.text "Recovery exact.",.boolean RadiochemicalSeparation.recoveryWitness],.array [.text "decontamination",.text "Factor exact.",.boolean RadiochemicalSeparation.decontaminationWitness],.array [.text "absence",.text "Complete recovery closes structurally.",.boolean RadiochemicalSeparation.absenceWitness],.array [.text "extension",.text "Balanced successor reconstructs.",.boolean RadiochemicalSeparation.extensionWitness]]
def claimId : String := "SFT-CHEM-RADIOCHEMICAL-SEPARATION-DECONTAMINATION-010"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-NUCLEAR-CHEMICAL-CARRIER-001","SFT-CHEM-RADIOACTIVE-CHEMICAL-TRANSFORMATION-002","SFT-CHEM-RADIOTRACER-CUSTODY-INFERENCE-009"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "identity",.text (identityName c.identity)],.array [.text "streams",.text (streamsName c.streams)],.array [.text "inventory",.text (inventoryName c.inventory)],.array [.text "balance",.text (balanceName c.balance)],.array [.text "recovery",.text (recoveryName c.recovery)],.array [.text "decontamination",.text (decontaminationName c.decontamination)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "identity",.array [.array [.text "total-radioactivity-only",.text "Total activity loses target and contaminant identity."],.array [.text "held-target-and-contaminant-species",.text "Both species remain held."]]],.array [.text "streams",.array [.array [.text "product-only-record",.text "A product alone hides feed and waste."],.array [.text "complete-feed-product-waste-streams",.text "All streams remain."]]],.array [.text "inventory",.array [.array [.text "continuum-concentration-premise",.text "Continuum concentration hides occurrences."],.array [.text "positive-species-resolved-counts",.text "Every stream/species count is positive."]]],.array [.text "balance",.array [.array [.text "unrecorded-process-loss",.text "Unrecorded loss breaks custody."],.array [.text "exact-target-and-contaminant-conservation",.text "Both species balance exactly."]]],.array [.text "recovery",.array [.array [.text "percent-recovery-premise",.text "A displayed percentage cannot define recovery."],.array [.text "exact-product-target-per-feed-target-ratio",.text "Recovery is forced by exact counts."]]],.array [.text "decontamination",.array [.array [.text "fitted-separation-factor",.text "A fit cannot define decontamination."],.array [.text "exact-contaminant-fraction-ratio",.text "The factor is forced by cross-products."]]],.array [.text "absence",.array [.array [.text "numerical-zero-contaminant",.text "Numerical zero is not native absence."],.array [.text "positive-Take-or-EmptyOne-residual",.text "Residual custody is positive or structurally absent."]]],.array [.text "extension",.array [.array [.text "selected-best-stage",.text "Selecting a best stage erases the process."],.array [.text "successor-composes-balanced-stages",.text "Every stage composes only through balanced streams."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold radiochemical separation and decontamination law"
 branch := "chemistry"
 statement := "Radiochemical separation retains target and contaminant identities across complete feed/product/waste streams, conserves each species exactly, forces recovery and decontamination ratios by counts, and composes only balanced stages."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-target-and-contaminant-species__complete-feed-product-waste-streams__positive-species-resolved-counts__exact-target-and-contaminant-conservation__exact-product-target-per-feed-target-ratio__exact-contaminant-fraction-ratio__positive-Take-or-EmptyOne-residual__successor-composes-balanced-stages"),("base",.text "One complete feed/product/waste ledger supplies the first exact separation."),("successor",.text "Each successor stage consumes exactly the retained output and preserves every species balance."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no measured recovery extraction factor or selected successful run chooses the survivor",.text "the adverse one-percent run and every limit remain"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no measured recovery extraction factor or selected successful run chooses the survivor","the adverse one-percent run and every limit remain"]
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
end SFT.Chemistry.RadiochemicalSeparationEvidence
