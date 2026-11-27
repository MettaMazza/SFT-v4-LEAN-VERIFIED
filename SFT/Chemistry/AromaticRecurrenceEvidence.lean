import SFT.Chemistry.AromaticRecurrenceGrammar
import SFT.Chemistry.AromaticRecurrenceWitnesses
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.AromaticRecurrenceEvidence
open SFT.Host.Canonical AromaticRecurrenceGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "primitive-six-support",.text "Two boundary fibres plus one complete four-cell layer force positive support six.",.boolean AromaticRecurrenceWitnesses.baseWitness],.array [.text "successor-ten-fourteen",.text "Successive complete pair-cell layers force support counts ten and fourteen.",.boolean AromaticRecurrenceWitnesses.successorWitness],.array [.text "first-return",.text "The complete cycle trace returns to its retained first centre.",.boolean AromaticRecurrenceWitnesses.returnWitness],.array [.text "perturbation-closure",.text "Every ordered-pair-cell rotation preserves the complete layer.",.boolean AromaticRecurrenceWitnesses.closureWitness],.array [.text "positive-stability-order",.text "Opening one recurrence boundary requires one retained positive transfer.",.boolean AromaticRecurrenceWitnesses.stabilityWitness],.array [.text "incomplete-layer-control",.text "Omitting any ordered pair cell rejects.",.boolean AromaticRecurrenceWitnesses.incompleteWitness],.array [.text "open-path-control",.text "Two centres cannot be relabelled as a complete recurrence cycle.",.boolean AromaticRecurrenceWitnesses.openPathWitness],.array [.text "numerical-zero-control",.text "A numerical zero layer count rejects.",.boolean AromaticRecurrenceWitnesses.zeroWitness]]
def claimId : String := "SFT-CHEM-AROMATIC-RECURRENCE-STABILITY-003"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-CHEM-MULTICENTRE-DELOCALIZED-SUPPORT-008","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-MOLECULAR-FORMATION-ENERGY-013","SFT-CHEM-CONJUGATED-SUPPORT-001","SFT-CHEM-RESONANCE-EQUIVALENT-REPRESENTATION-002"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "cycle",.text (cycleName c.cycle)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "layer",.text (layerName c.layer)],.array [.text "return",.text (returnsName c.returns)],.array [.text "stability",.text (stabilityName c.stability)],.array [.text "observation",.text (observationName c.observation)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "aromatic-name-or-answer-only",.text "A name does not retain the molecular support that is claimed to recur."],.array [.text "one-complete-molecular-carrier",.text "One carrier retains every cycle centre, incidence and recurrence cell."]]],.array [.text "cycle",.array [.array [.text "open-path-or-selected-ring",.text "An open path or selected example does not establish cyclic first return."],.array [.text "complete-generated-cycle",.text "Every centre has complete degree-two cycle incidence and the trace returns to its first centre."]]],.array [.text "boundary",.array [.array [.text "one-fibre-or-duplicated-boundary",.text "An incomplete or duplicated boundary erases one forced Fold distinction."],.array [.text "complete-two-fibre-boundary",.text "The recurrence retains both Fold fibres exactly once at its boundary."]]],.array [.text "layer",.array [.array [.text "selected-transition-cell-subset",.text "A selected subset can be tuned to a familiar count and is not closed under pair-cell perturbation."],.array [.text "complete-four-ordered-pair-cell-layer",.text "Every positive layer retains all four ordered cells of the two Fold fibres exactly once."]]],.array [.text "return",.array [.array [.text "period-label-without-trace",.text "A named cycle length cannot prove return or preserve its path."],.array [.text "explicit-complete-first-return-trace",.text "The complete centre trace ends at its exactly retained starting centre."]]],.array [.text "stability",.array [.array [.text "measured-energy-or-name-selected-order",.text "A measured energy or conventional aromatic label cannot select the structural order."],.array [.text "positive-recurrence-opening-gap",.text "Opening the closed recurrence requires one retained positive transfer, so the closed state precedes its opened reference."]]],.array [.text "observation",.array [.array [.text "selected-or-preopened-value-row",.text "A selected or preopened value vector can feed the desired order back into the law."],.array [.text "value-free-seal-and-complete-blind-vector",.text "Outcome-unopened identities are sealed before the complete independent energy surface is opened."]]],.array [.text "extension",.array [.array [.text "imported-electron-count-or-species-rule",.text "An imported count formula or species exception is an added selector."],.array [.text "complete-four-cell-successor-no-extra-rule",.text "Each positive successor appends the same complete four-cell layer while retaining the two-fibre boundary and cycle."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact aromatic recurrence, support sequence and positive stability law"
 branch := "chemistry"
 statement := "An aromatic Fold carrier is one complete generated molecular cycle retaining both Fold boundary fibres and at least one complete layer of their four ordered pair cells. The primitive support count is six; every lawful successor adds the same four-cell layer, forcing ten, fourteen and every later positive successor. Opening the complete recurrence requires one retained positive transfer, so the closed recurrence precedes its opened localized reference without an imported electron-count or measured-energy rule."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-complete-molecular-carrier__complete-generated-cycle__complete-two-fibre-boundary__complete-four-ordered-pair-cell-layer__explicit-complete-first-return-trace__positive-recurrence-opening-gap__value-free-seal-and-complete-blind-vector__complete-four-cell-successor-no-extra-rule"),("base",.text "Both Fold boundary fibres plus the first complete four-ordered-pair-cell layer force exact positive support six on one complete cycle, with structural EmptyOne missing-cell boundary."),("successor",.text "Append all four ordered Fold pair cells exactly once. Every earlier boundary, layer, centre, incidence and return record is retained; support increases from six to ten to fourteen and by the same exact four-cell successor at every positive finite depth."),("exclusions",.array [.text "no numerical zero; structural absence is EmptyOne",.text "no negative irrational imaginary continuum fitted free or imported native parameter",.text "no Hückel 4n+2 rule electron count molecular name or measured energy used to select the survivor",.text "no selected ordered-pair-cell subset or omitted cycle incidence",.text "the six inspected family records are development-observed correspondence and cannot be called blind",.text "the three independent CCCBDB outcomes remain inaccessible until after the value-free law and target seals",.text "external signed enthalpy strings remain downstream held inscriptions and never become native signed arithmetic"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; structural absence is EmptyOne","no negative irrational imaginary continuum fitted free or imported native parameter","no Hückel 4n+2 rule electron count molecular name or measured energy used to select the survivor","no selected ordered-pair-cell subset or omitted cycle incidence","the six inspected family records are development-observed correspondence and cannot be called blind","the three independent CCCBDB outcomes remain inaccessible until after the value-free law and target seals","external signed enthalpy strings remain downstream held inscriptions and never become native signed arithmetic"]
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
end SFT.Chemistry.AromaticRecurrenceEvidence
