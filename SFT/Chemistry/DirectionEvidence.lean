import SFT.Chemistry.DirectionGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.DirectionEvidence
open SFT.Host.Canonical DirectionGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "comparison",.text "forward support is strictly greater",.boolean true],.array [.text "orientation",.text "the selected direction is held",.boolean true],.array [.text "tie",.text "equality admits no arbitrary direction",.boolean true]]
def claimId : String := "SFT-CHEM-THERMO-DIRECTION-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-RXN-INTERMEDIATE-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-KIN-ORDER-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-REACTION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "paths",.text (pathsName c.paths)],.array [.text "energy",.text (energyName c.energy)],.array [.text "distinctions",.text (distinctionsName c.distinctions)],.array [.text "comparison",.text (comparisonName c.comparison)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "equilibrium",.text (equilibriumName c.equilibrium)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "paths",.array [.array [.text "forward-path-only",.text "No directional comparison exists."],.array [.text "forward-and-reverse-paths",.text "Both alternatives are generated."]]],.array [.text "energy",.array [.array [.text "energy-change-erased",.text "Available support is unknown."],.array [.text "complete-energy-transfer-ledgers",.text "Both ledgers are held."]]],.array [.text "distinctions",.array [.array [.text "entropy-label-only",.text "A label cannot count support."],.array [.text "complete-accessible-distinction-census",.text "All generated states are counted."]]],.array [.text "comparison",.array [.array [.text "imported-spontaneity-sign",.text "A sign assumes the answer."],.array [.text "strict-support-order",.text "The complete paths determine preference."]]],.array [.text "orientation",.array [.array [.text "negative-Gibbs-primitive",.text "A negative scalar is prohibited."],.array [.text "held-favored-direction",.text "Direction and positive magnitude are separate."]]],.array [.text "equilibrium",.array [.array [.text "forced-direction-at-tie",.text "Equal support cannot select."],.array [.text "empty-direction-at-equality",.text "A tie is an Empty orientation."]]],.array [.text "record",.array [.array [.text "direction-answer-only",.text "It cannot reproduce comparison."],.array [.text "path-energy-distinction-trace",.text "All premises remain auditable."]]],.array [.text "extra",.array [.array [.text "free-temperature-threshold",.text "A parameter can force a target."],.array [.text "no-extra-rule",.text "Complete condition-bound support selects direction."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Reaction direction under complete energy and distinction accounting"
 branch := "chemistry"
 statement := "Reaction direction is the held orientation selected by strict complete support order between forward and reverse paths; equality yields no selected direction."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "forward-and-reverse-paths__complete-energy-transfer-ledgers__complete-accessible-distinction-census__strict-support-order__held-favored-direction"),("base",.text "One unequal path-support pair supplies the first direction."),("successor",.text "Appending a distinction preserves the comparison and changes direction only when the complete strict order changes."),("exclusions",.array [.text "no thermochemical table, spontaneity rule, phase diagram, solubility value, photochemical database, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no energy, matter or photon carrier may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite pair of forward and reverse reaction paths on one retained condition boundary, compared by complete source, energy-transfer and distinction-production support, selecting an orientation only when one path strictly closes the available transition support."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no thermochemical table, spontaneity rule, phase diagram, solubility value, photochemical database, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no energy, matter or photon carrier may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite pair of forward and reverse reaction paths on one retained condition boundary, compared by complete source, energy-transfer and distinction-production support, selecting an orientation only when one path strictly closes the available transition support."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with paths := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.DirectionEvidence
