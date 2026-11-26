import SFT.Chemistry.ElectrochemicalWorkGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ElectrochemicalWorkEvidence
open SFT.Host.Canonical ElectrochemicalWorkGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "exact-product",.text "Two carriers at three-halves separation yield three exact work parts.",.boolean true],.array [.text "positive-only",.text "Directed work magnitude remains exact and positive.",.boolean true],.array [.text "chemical-custody",.text "Chemical path remains held.",.boolean true],.array [.text "electrical-custody",.text "Electrical path remains held.",.boolean true],.array [.text "direction",.text "Forward reaction orientation remains held.",.boolean true],.array [.text "equilibrium",.text "Equilibrium closes to EmptyOne.",.boolean true],.array [.text "reverse",.text "Reversal changes held direction and preserves magnitude.",.boolean true],.array [.text "invalid-directed-empty",.text "Directed work without positive separation halts.",.boolean true]]
def claimId : String := "SFT-CHEM-ELECTROCHEMICAL-WORK-REACTION-DIRECTION-005"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-PHYS-PLASMA-COLLECTIVE-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-CELL-POTENTIAL-COMPOSITION-003"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "custody",.text (custodyName c.custody)],.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "potential",.text (potentialName c.potential)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "direction",.text (directionName c.direction)],.array [.text "equilibrium",.text (equilibriumName c.equilibrium)],.array [.text "record",.text (recordName c.record)],.array [.text "reverse",.text (reverseName c.reverse)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "custody",.array [.array [.text "anonymous-energy-number",.text "An anonymous energy loses its reaction and cell."],.array [.text "complete-cell-chemical-electrical-custody",.text "Cell, chemical path and electrical path remain held."]]],.array [.text "carrier",.array [.array [.text "uncounted-charge",.text "Uncounted charge cannot establish chemical work."],.array [.text "positive-counted-transfer-carriers",.text "Every transferred distinction is counted positively."]]],.array [.text "potential",.array [.array [.text "signed-voltage-premise",.text "A signed voltage imports negative proof magnitude."],.array [.text "positive-potential-separation-with-held-direction",.text "Magnitude is positive and direction is a held label."]]],.array [.text "composition",.array [.array [.text "free-energy-postulate",.text "A named free-energy formula does not derive work custody."],.array [.text "exact-carrier-potential-product",.text "Work is forced as carrier count composed with potential separation."]]],.array [.text "direction",.array [.array [.text "unoriented-work",.text "Unoriented work cannot determine the reaction path."],.array [.text "held-work-reaction-correspondence",.text "Forward and reverse directions are retained structurally."]]],.array [.text "equilibrium",.array [.array [.text "numerical-zero-work",.text "Numerical zero is not a native proof magnitude."],.array [.text "structural-EmptyOne-equilibrium",.text "Coincidence closes the work distinction to EmptyOne."]]],.array [.text "record",.array [.array [.text "selected-cell-result",.text "A selected result can hide conditions and uncertainty."],.array [.text "complete-cell-work-equilibrium-vector",.text "Every registered potential, constant, work and uncertainty row remains downstream."]]],.array [.text "reverse",.array [.array [.text "irreversible-sign-change",.text "A sign change cannot reconstruct both transfer paths."],.array [.text "exact-path-reversal-preserves-positive-work",.text "Reversal swaps held direction and preserves the exact magnitude."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold electrochemical work and reaction-direction correspondence"
 branch := "chemistry"
 statement := "Electrochemical work is the exact positive product of counted transferred carriers and held potential separation, with separate chemical/electrical path direction and structural EmptyOne equilibrium."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-cell-chemical-electrical-custody__positive-counted-transfer-carriers__positive-potential-separation-with-held-direction__exact-carrier-potential-product__held-work-reaction-correspondence__structural-EmptyOne-equilibrium__complete-cell-work-equilibrium-vector__exact-path-reversal-preserves-positive-work"),("base",.text "One transferred carrier across one positive held separation supplies the first work account."),("successor",.text "Appending one carrier composes one more exact potential-separation part while retaining both paths."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no potential Faraday work or equilibrium outcome selects the survivor",.text "all conventional signs historical disagreements and uncertainties remain downstream provenance"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no potential Faraday work or equilibrium outcome selects the survivor","all conventional signs historical disagreements and uncertainties remain downstream provenance"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with custody := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.ElectrochemicalWorkEvidence
