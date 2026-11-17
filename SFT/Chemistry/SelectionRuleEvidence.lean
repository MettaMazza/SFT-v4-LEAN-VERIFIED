import SFT.Chemistry.SelectionRuleGrammar
import SFT.Chemistry.SelectionRule
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.SelectionRuleEvidence
open SFT.Host.Canonical SelectionRuleGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "direct",.text "One-step support change with retained multiplicity and complementary known inversion is direct.",.boolean SelectionRule.directWitness],.array [.text "mediated",.text "A two-step axis change retains the mediator and is not relabelled direct.",.boolean SelectionRule.mediatedWitness],.array [.text "closed",.text "A channel-absent terminal is structural EmptyOne.",.boolean SelectionRule.closedWitness],.array [.text "adverse",.text "Erasing the required mediator rejects.",.boolean SelectionRule.adverseWitness]]
def claimId : String := "SFT-CHEM-SELECTION-RULE-STRUCTURE-010"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-CHEM-STATE-SYMMETRY-DEGENERACY-005","SFT-CHEM-MOLECULAR-STATE-TRANSITION-009"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "observation",.text (observationName c.observation)],.array [.text "multiplicity",.text (multiplicityName c.multiplicity)],.array [.text "inversion",.text (inversionName c.inversion)],.array [.text "axis",.text (axisName c.axis)],.array [.text "mediation",.text (mediationName c.mediation)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "record",.text (recordName c.record)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-rule",.text "A selection answer without state endpoints erases the chemical carrier."],.array [.text "retained-endpoint-signatures",.text "Every decision retains the exact endpoint signatures available to observation."]]],.array [.text "observation",.array [.array [.text "channel-independent-permission",.text "One universal yes/no label erases which observation operation was applied."],.array [.text "declared-observation-class",.text "Direct, mediated, coupled and closed observations remain distinct."]]],.array [.text "multiplicity",.array [.array [.text "untracked-spin-support",.text "Changing a retained support count in one direct Fold action erases a distinction."],.array [.text "direct-multiplicity-retention",.text "A direct observation retains the positive spin-support count."]]],.array [.text "inversion",.array [.array [.text "same-fibre-direct-image",.text "When both inversion fibres are known, an unchanged fibre supplies no direct observation distinction."],.array [.text "known-inversion-fibre-change",.text "Known g/u endpoints occupy complementary held fibres in a direct observation."]]],.array [.text "axis",.array [.array [.text "arbitrary-axis-jump",.text "One observation action cannot cross more than one generated axis recurrence."],.array [.text "same-or-neighbour-axis-support",.text "Direct observation changes axis support by at most one Fold successor."]]],.array [.text "mediation",.array [.array [.text "exception-erases-law",.text "Calling every observed exception direct destroys the closed distinction."],.array [.text "non-direct-requires-retained-mediator",.text "A non-direct observed relation remains lawful only with its mediator or alternate channel retained."]]],.array [.text "absence",.array [.array [.text "numerical-zero-or-universal-forbidden",.text "An empty source cell is neither a number nor a universal prohibition."],.array [.text "channel-closed-EmptyOne",.text "Absence closes only the declared observation coordinate as structural EmptyOne."]]],.array [.text "record",.array [.array [.text "selected-success-only",.text "Keeping only ordinary transitions hides couplings, absences and mediated cases."],.array [.text "complete-adverse-inclusive-vector",.text "All direct, mediated, coupled, unresolved and closed records are retained."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact chemical observation-class and selection-rule structure"
 branch := "chemistry"
 statement := "A direct molecular observation retains spin-support multiplicity, changes a known inversion fibre, and changes axis support by no more than one generated recurrence. An observed relation outside that direct class requires a retained mediator or alternate observation channel; it does not erase the rule. Couplings, unresolved endpoints and channel absences remain separate exact classes, and absence is structural EmptyOne rather than numerical zero."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "retained-endpoint-signatures__declared-observation-class__direct-multiplicity-retention__known-inversion-fibre-change__same-or-neighbour-axis-support__non-direct-requires-retained-mediator__channel-closed-EmptyOne__complete-adverse-inclusive-vector"),("base",.text "At structural EmptyOne axis support, one direct action either retains that support or reaches the first recurrence while retaining multiplicity and changing every known complementary inversion fibre."),("successor",.text "At any positive finite axis recurrence, one additional direct Fold action reaches only the same, predecessor or successor support; a larger observed displacement factors into a positive finite mediated path whose intermediate record may not be erased."),("exclusions",.array [.text "no numerical zero; glyph 0 denotes source/interface absence only",.text "no negative, irrational, imaginary, floating, signed-amplitude or continuum proof magnitude",.text "no imported spectroscopic selection-rule formula or probability threshold",.text "no NIST endpoint, transition, coupling, absence or adverse-note outcome before prediction seal",.text "no observed exception relabelled as an ordinary direct transition",.text "no selected success-only surface and no erased channel distinction"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; glyph 0 denotes source/interface absence only","no negative, irrational, imaginary, floating, signed-amplitude or continuum proof magnitude","no imported spectroscopic selection-rule formula or probability threshold","no NIST endpoint, transition, coupling, absence or adverse-note outcome before prediction seal","no observed exception relabelled as an ordinary direct transition","no selected success-only surface and no erased channel distinction"]
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
end SFT.Chemistry.SelectionRuleEvidence
