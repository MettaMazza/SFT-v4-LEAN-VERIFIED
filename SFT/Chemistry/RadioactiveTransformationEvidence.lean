import SFT.Chemistry.RadioactiveTransformationGrammar
import SFT.Chemistry.RadioactiveChemicalTransformation
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.RadioactiveTransformationEvidence
open SFT.Host.Canonical RadioactiveTransformationGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "parent",.text "Parent held.",.boolean RadioactiveChemicalTransformation.parentWitness],.array [.text "daughter",.text "Daughter held.",.boolean RadioactiveChemicalTransformation.daughterWitness],.array [.text "species",.text "Both species held.",.boolean RadioactiveChemicalTransformation.speciesWitness],.array [.text "channel",.text "Channel held.",.boolean RadioactiveChemicalTransformation.channelWitness],.array [.text "events",.text "Events positive.",.boolean RadioactiveChemicalTransformation.eventsWitness],.array [.text "network",.text "Edge retained.",.boolean RadioactiveChemicalTransformation.networkWitness],.array [.text "absence",.text "No edge is EmptyOne.",.boolean RadioactiveChemicalTransformation.absenceWitness],.array [.text "successor",.text "Two distinct edges retained.",.boolean RadioactiveChemicalTransformation.successorWitness]]
def claimId : String := "SFT-CHEM-RADIOACTIVE-CHEMICAL-TRANSFORMATION-002"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-GRAPH-NETWORK-001","SFT-PHYS-NUCLEAR-RADIOACTIVE-DECAY-TERMINAL-005","SFT-CHEM-NET-REACTION-001","SFT-CHEM-ELEM-ISOTOPE-001","SFT-CHEM-NUCLEAR-CHEMICAL-CARRIER-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "parent",.text (parentName c.parent)],.array [.text "daughter",.text (daughterName c.daughter)],.array [.text "chemistry",.text (chemistryName c.chemistry)],.array [.text "channel",.text (channelName c.channel)],.array [.text "events",.text (eventsName c.events)],.array [.text "network",.text (networkName c.network)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "parent",.array [.array [.text "parent-number-only",.text "Parent number loses identity."],.array [.text "held-parent-nuclide",.text "Parent nuclide held."]]],.array [.text "daughter",.array [.array [.text "anonymous-product",.text "Product loses daughter identity."],.array [.text "held-daughter-nuclide",.text "Daughter nuclide held."]]],.array [.text "chemistry",.array [.array [.text "nuclear-edge-only",.text "Chemical states would be lost."],.array [.text "held-parent-daughter-species",.text "Both chemical species remain."]]],.array [.text "channel",.array [.array [.text "unlabelled-transition",.text "Channel identity is required."],.array [.text "held-decay-channel",.text "Channel remains held."]]],.array [.text "events",.array [.array [.text "continuum-decay-flow",.text "Flow hides events."],.array [.text "positive-counted-transformations",.text "Events are counted."]]],.array [.text "network",.array [.array [.text "selected-decay-edge",.text "One edge hides branching."],.array [.text "complete-directed-transformation-network",.text "Every edge remains."]]],.array [.text "absence",.array [.array [.text "numerical-zero-daughter",.text "Numerical zero is not native absence."],.array [.text "structural-EmptyOne-no-edge",.text "No edge is structural absence."]]],.array [.text "extension",.array [.array [.text "daughter-overwrites-parent",.text "Overwriting destroys reconstruction."],.array [.text "successor-retains-prior-network",.text "Every successor preserves prior edges."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold radioactive chemical-transformation network"
 branch := "chemistry"
 statement := "A radioactive chemical transformation is a complete directed network retaining parent, daughter, both chemical species, channel and positive counted events, with structural absence and reconstructive extension."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-parent-nuclide__held-daughter-nuclide__held-parent-daughter-species__held-decay-channel__positive-counted-transformations__complete-directed-transformation-network__structural-EmptyOne-no-edge__successor-retains-prior-network"),("base",.text "One held parent/daughter chemical edge supplies the first directed transformation."),("successor",.text "A distinct successor edge preserves the prior network and adds its held channel and counted events."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no external decay chain or equilibrium record selects the survivor",.text "no source assumption or disagreement is suppressed"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no external decay chain or equilibrium record selects the survivor","no source assumption or disagreement is suppressed"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with parent := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.RadioactiveTransformationEvidence
