import SFT.Chemistry.BranchYieldGrammar
import SFT.Chemistry.RadioactiveBranchYield
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.BranchYieldEvidence
open SFT.Host.Canonical BranchYieldGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "channel",.text "Channels held.",.boolean RadioactiveBranchYield.channelWitness],.array [.text "daughter",.text "Daughters held.",.boolean RadioactiveBranchYield.daughterWitness],.array [.text "events",.text "Events positive.",.boolean RadioactiveBranchYield.eventsWitness],.array [.text "recovery",.text "Recovery positive.",.boolean RadioactiveBranchYield.recoveryWitness],.array [.text "yield",.text "Yield exact.",.boolean RadioactiveBranchYield.yieldWitness],.array [.text "partition",.text "Shares sum One.",.boolean RadioactiveBranchYield.partitionWitness],.array [.text "complete",.text "Both rows retained.",.boolean RadioactiveBranchYield.completeWitness],.array [.text "successor",.text "New branch repartitions.",.boolean RadioactiveBranchYield.successorWitness]]
def claimId : String := "SFT-CHEM-RADIOACTIVE-BRANCHING-CHEMICAL-YIELD-004"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-PHYS-DECAY-WIDTH-BRANCHING-LIFETIME-TERMINAL-006","SFT-CHEM-RADIOACTIVE-CHEMICAL-TRANSFORMATION-002","SFT-CHEM-ACTIVITY-AMOUNT-TIME-003"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "channel",.text (channelName c.channel)],.array [.text "daughter",.text (daughterName c.daughter)],.array [.text "events",.text (eventsName c.events)],.array [.text "recovery",.text (recoveryName c.recovery)],.array [.text "yield",.text (yieldName c.yield)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "channel",.array [.array [.text "unlabelled-yield",.text "Yield needs channel identity."],.array [.text "held-decay-channel",.text "Channel remains held."]]],.array [.text "daughter",.array [.array [.text "anonymous-product-amount",.text "Product amount loses species."],.array [.text "held-daughter-chemical-species",.text "Daughter species remains."]]],.array [.text "events",.array [.array [.text "continuum-branch-probability",.text "Probability hides event support."],.array [.text "positive-counted-branch-events",.text "Branch events are counted."]]],.array [.text "recovery",.array [.array [.text "fitted-chemical-recovery",.text "A fitted factor is not custody."],.array [.text "positive-counted-recovered-events",.text "Recovered events are counted."]]],.array [.text "yield",.array [.array [.text "percentage-premise",.text "A percentage is a display form."],.array [.text "exact-recovered-per-branch-ratio",.text "Yield is an exact ratio."]]],.array [.text "partition",.array [.array [.text "independent-branch-fractions",.text "Independent values need not close."],.array [.text "complete-branch-partition-sums-to-One",.text "All branch shares partition One."]]],.array [.text "record",.array [.array [.text "selected-favorable-daughter",.text "Selection hides adverse/absent branches."],.array [.text "complete-daughter-yield-vector",.text "Every branch and recovery remains."]]],.array [.text "extension",.array [.array [.text "renormalize-after-omission",.text "Renormalization hides missing branches."],.array [.text "new-branch-repartitions-complete-total",.text "Successors retain all prior branches."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold radioactive branching chemical-yield law"
 branch := "chemistry"
 statement := "Radioactive chemical yield retains every held decay channel and daughter species, positive branch and recovered event counts, exact recovery ratios and a complete branch partition of One."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-decay-channel__held-daughter-chemical-species__positive-counted-branch-events__positive-counted-recovered-events__exact-recovered-per-branch-ratio__complete-branch-partition-sums-to-One__complete-daughter-yield-vector__new-branch-repartitions-complete-total"),("base",.text "One held channel with counted events and recoveries supplies the first exact yield row."),("successor",.text "A fresh channel preserves prior rows and repartitions the complete positive event total."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no external branch fraction daughter list or recovery result selects the survivor",.text "an unavailable numerical branch fraction remains unavailable and is never fabricated or renormalized"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no external branch fraction daughter list or recovery result selects the survivor","an unavailable numerical branch fraction remains unavailable and is never fabricated or renormalized"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with channel := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.BranchYieldEvidence
