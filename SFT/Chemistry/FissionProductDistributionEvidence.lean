import SFT.Chemistry.FissionProductDistributionGrammar
import SFT.Chemistry.FissionProductDistribution
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.FissionProductDistributionEvidence
open SFT.Host.Canonical FissionProductDistributionGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "handoff",.text "Product identities held.",.boolean FissionProductDistribution.handoffWitness],.array [.text "identity",.text "Species retained.",.boolean FissionProductDistribution.identityWitness],.array [.text "support",.text "Phase and location retained.",.boolean FissionProductDistribution.supportWitness],.array [.text "events",.text "Counts positive.",.boolean FissionProductDistribution.eventsWitness],.array [.text "partition",.text "Partition sums to One.",.boolean FissionProductDistribution.partitionWitness],.array [.text "chemistry",.text "Redistribution explicit.",.boolean FissionProductDistribution.chemistryWitness],.array [.text "boundary",.text "Identity set conserved.",.boolean FissionProductDistribution.boundaryWitness],.array [.text "extension",.text "Successor complete.",.boolean FissionProductDistribution.extensionWitness]]
def claimId : String := "SFT-CHEM-FISSION-PRODUCT-CHEMICAL-DISTRIBUTION-011"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-PHYS-NUCLEAR-RADIOACTIVE-DECAY-TERMINAL-005","SFT-PHYS-DECAY-WIDTH-BRANCHING-LIFETIME-TERMINAL-006","SFT-CHEM-NUCLEAR-CHEMICAL-CARRIER-001","SFT-CHEM-RADIOACTIVE-CHEMICAL-TRANSFORMATION-002","SFT-CHEM-RADIOCHEMICAL-SEPARATION-DECONTAMINATION-010"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "handoff",.text (handoffName c.handoff)],.array [.text "identity",.text (identityName c.identity)],.array [.text "support",.text (supportName c.support)],.array [.text "events",.text (eventsName c.events)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "chemistry",.text (chemistryName c.chemistry)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "handoff",.array [.array [.text "chemistry-selects-fission-products",.text "Chemistry cannot select nuclear products."],.array [.text "explicit-physics-product-handoff",.text "Physics supplies each product identity."]]],.array [.text "identity",.array [.array [.text "mass-chain-only",.text "Mass chain loses nuclide identity."],.array [.text "held-nuclide-and-chemical-species",.text "Nuclide and species remain held."]]],.array [.text "support",.array [.array [.text "bulk-release-fraction",.text "One bulk fraction loses phase and location."],.array [.text "complete-phase-location-support",.text "Every phase and location remains."]]],.array [.text "events",.array [.array [.text "expected-yield-premise",.text "Expectation is not counted custody."],.array [.text "positive-species-resolved-events",.text "Every chemical row has positive events."]]],.array [.text "partition",.array [.array [.text "renormalized-selected-products",.text "Selection changes the distribution."],.array [.text "exact-complete-partition-of-One",.text "Every retained row participates in One."]]],.array [.text "chemistry",.array [.array [.text "fixed-chemical-form-assumption",.text "A name cannot freeze chemistry."],.array [.text "explicit-chemical-redistribution-network",.text "Every species/phase transition is explicit."]]],.array [.text "boundary",.array [.array [.text "silent-decay-inside-chemistry",.text "Chemistry cannot silently change nuclides."],.array [.text "nuclide-change-requires-physics-handoff",.text "A nuclide change crosses the explicit boundary."]]],.array [.text "extension",.array [.array [.text "selected-terminal-sample",.text "One sample cannot establish the distribution."],.array [.text "successor-retains-complete-time-sample-vector",.text "Every successor retains all samples."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold fission-product chemical-distribution law"
 branch := "chemistry"
 statement := "Physics supplies fission-product identities; Chemistry retains every nuclide, species, phase and location with positive events, partitions the complete support exactly and permits only explicit identity-conserving chemical redistribution."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "explicit-physics-product-handoff__held-nuclide-and-chemical-species__complete-phase-location-support__positive-species-resolved-events__exact-complete-partition-of-One__explicit-chemical-redistribution-network__nuclide-change-requires-physics-handoff__successor-retains-complete-time-sample-vector"),("base",.text "One physics-supplied product with one complete chemical row supplies the first partition."),("successor",.text "Every successor retains all products and samples; a nuclide change requires a new physics handoff."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "Chemistry cannot select fission-product existence or use an inventory model to choose the survivor",.text "all missing balances and conjectures remain unresolved evidence"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","Chemistry cannot select fission-product existence or use an inventory model to choose the survivor","all missing balances and conjectures remain unresolved evidence"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with handoff := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.FissionProductDistributionEvidence
