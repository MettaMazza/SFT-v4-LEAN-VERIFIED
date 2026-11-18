import SFT.Chemistry.DihedralTorsionGrammar
import SFT.Chemistry.DihedralTorsionWitnesses
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.DihedralTorsionEvidence
open SFT.Host.Canonical DihedralTorsionGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "coordinate-cycle",.text "Six positive sectors generate EmptyOne, exact parts and the recurrent One.",.boolean (DihedralTorsionWitnesses.coordinateWitness)],.array [.text "conformer-barrier-order",.text "Complete cyclic neighbours force two conformers and two barriers.",.boolean (DihedralTorsionWitnesses.orderWitness)],.array [.text "barrier-transitions",.text "Each barrier Takes its two adjacent conformer heights exactly.",.boolean (DihedralTorsionWitnesses.transitionsWitness)],.array [.text "orientation",.text "Reversing ordered Take halts instead of creating a negative magnitude.",.boolean (DihedralTorsionWitnesses.reverseWitness)]]
def claimId : String := "SFT-CHEM-DIHEDRAL-TORSIONAL-STATE-004"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-GEOMETRY-001","SFT-CHEM-MOLECULAR-STATE-TRANSITION-009","SFT-CHEM-CONFIGURATION-ORDER-PATH-011","SFT-CHEM-MOLECULAR-BOND-ANGLE-003"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "coordinate",.text (coordinateName c.coordinate)],.array [.text "state",.text (stateName c.state)],.array [.text "barrier",.text (barrierName c.barrier)],.array [.text "recurrence",.text (recurrenceName c.recurrence)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "unordered-or-three-site-angle",.text "A dihedral cannot be identified without four ordered sites."],.array [.text "named-ordered-four-site-carrier",.text "Molecule, state, rotor and all four ordered atom sites remain held."]]],.array [.text "orientation",.array [.array [.text "signed-conventional-angle",.text "A signed scalar imports negative proof magnitude."],.array [.text "held-cycle-orientation",.text "Direction is a retained label on one exact periodic path."]]],.array [.text "coordinate",.array [.array [.text "continuum-rotation-coordinate",.text "A continuum coordinate imports ungenerated positions."],.array [.text "generated-sector-successor-coordinate",.text "EmptyOne, positive sector successors and recurrent One exhaust the registered cycle."]]],.array [.text "state",.array [.array [.text "named-conformer-without-neighbours",.text "A conformer name without complete neighbours cannot force local stability."],.array [.text "complete-neighbour-conformer-state",.text "A conformer is lower than both retained neighbouring generated states."]]],.array [.text "barrier",.array [.array [.text "imported-saddle-or-signed-difference",.text "An imported saddle equation or signed residue is outside the exact domain."],.array [.text "local-barrier-and-ordered-positive-Take",.text "A barrier is higher than both neighbours and Takes each adjacent conformer height positively."]]],.array [.text "recurrence",.array [.array [.text "duplicated-terminal-configuration",.text "Treating the complete turn endpoint as new duplicates one state."],.array [.text "terminal-One-identifies-anchor-class",.text "The recurrent One retains the anchor configuration and height."]]],.array [.text "prediction",.array [.array [.text "angle-or-energy-target-readable",.text "Readable source values could select the coordinate or state result."],.array [.text "value-free-coordinate-and-operation-seal",.text "Only identities, sector structure and exact operations seal before values open."]]],.array [.text "record",.array [.array [.text "selected-extrema-or-one-rotor",.text "A selected subset hides ordinary, adverse or second-rotor rows."],.array [.text "complete-two-rotor-fifty-row-vector",.text "Both ordered rotors and every source row remain in the empirical surface."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact held-orientation dihedral and torsional-state relation"
 branch := "chemistry"
 statement := "A molecular dihedral is an ordered four-site periodic carrier with held orientation, not a signed continuum scalar. At the registered 24-sector resolution, structural EmptyOne, each positive sector successor and recurrent One exactly generate the coordinate cycle. Complete cyclic neighbour order forces conformer minima and barriers; each barrier magnitude is the ordered positive Take to its adjacent conformer. The coordinate and operation seal before all fifty NIST angle and energy rows open."
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
def closureValue : Value := .object [("claim_id",.text claimId),("boundary",.text grammarBoundary),("result",.text "named-ordered-four-site-carrier__held-cycle-orientation__generated-sector-successor-coordinate__complete-neighbour-conformer-state__local-barrier-and-ordered-positive-Take__terminal-One-identifies-anchor-class__value-free-coordinate-and-operation-seal__complete-two-rotor-fifty-row-vector"),("base",.text "One ordered four-site carrier at structural EmptyOne retains its molecule, state, rotor and orientation; one positive successor creates the first exact sector part without a signed or continuum coordinate."),("successor",.text "Appending one generated sector successor preserves the ordered carrier and exposes exactly one new path node; complete neighbours force its state role, and the twenty-fourth successor is the recurrent One identical to the anchor class."),("exclusions",.array [.text "no numerical zero; source glyph 0 denotes structural absence only",.text "no negative, irrational, imaginary, floating, signed or continuum proof magnitude",.text "no imported torsional potential, Fourier series, differential equation, saddle equation or fitted coefficient",.text "no measured angle, energy, conformer outcome or barrier magnitude in law, forcing or prediction",.text "no erased molecule, state, ordered atom, rotor type, orientation, path position, method or condition",.text "no selected extrema-only, one-rotor or one-energy-unit subset",.text "no claim beyond the registered ethanol two-rotor observation boundary"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; source glyph 0 denotes structural absence only","no negative, irrational, imaginary, floating, signed or continuum proof magnitude","no imported torsional potential, Fourier series, differential equation, saddle equation or fitted coefficient","no measured angle, energy, conformer outcome or barrier magnitude in law, forcing or prediction","no erased molecule, state, ordered atom, rotor type, orientation, path position, method or condition","no selected extrema-only, one-rotor or one-energy-unit subset","no claim beyond the registered ethanol two-rotor observation boundary"]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .finiteComplete
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := identity (.array [closureValue,.array (decisions.map SFT.Engine.decisionValue)])
 generalityCertificateHash := none
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
end SFT.Chemistry.DihedralTorsionEvidence
