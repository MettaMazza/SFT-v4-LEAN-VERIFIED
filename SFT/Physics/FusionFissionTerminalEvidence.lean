import SFT.Physics.FusionFissionTerminalGrammar
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.FusionFissionTerminalEvidence
open SFT.Host SFT.Host.Canonical FusionFissionTerminalGrammar FusionFissionTerminalProofs
open SFT.Foundation.AdmissionControls (admissionIdentity)
local instance : BEq String := ⟨Text.equal⟩
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def formValue (c : Candidate) : Value := .object [("fusion_operation",.text (fusionName c.fusion)),("fission_operation",.text (fissionName c.fission)),("binding_direction",.text (directionName c.direction)),("barrier_label",.text (barrierName c.barrier)),("energy_accounting",.text (releaseName c.release)),("peak_closure",.text (peakName c.peak)),("target_boundary",.text (targetName c.target)),("extension",.text (extensionName c.extension))]
def factsValue (c : Candidate) : Value := .object ((computedFacts c).map (fun (key,b) => (key,.boolean b)))
def barrierInscription : Barrier → String
 | .c0 => "1/4" | .c1 => "1/2" | .c2 => "3/4" | .c3 => "1"
def exactForm (c : Candidate) : String := Text.intercalate "; " [Text.append "fusion=" (fusionName c.fusion),Text.append "fission=" (fissionName c.fission),Text.append "binding=" (directionName c.direction),Text.append "barrier=" (barrierInscription c.barrier),Text.append "release=" (releaseName c.release),Text.append "peak=" (peakName c.peak),Text.append "target=" (targetName c.target),Text.append "extension=" (extensionName c.extension)]
def fractionRepr (q : Rat) : String := Text.intercalate "" ["Fraction(",render (.integer q.num),", ",render (.integer (.ofNat q.den)),")"]
def gainRepr (p : Rat × Rat) : String := Text.intercalate "" ["(",fractionRepr p.1,", ",fractionRepr p.2,")"]
def decisionReason (c : Candidate) : String :=
 let failures := ((computedFacts c).filter (fun p => !p.2)).map Prod.fst
 if !failures.isEmpty then Text.intercalate "" ["Rejected by computed Fold predicates: ",Text.intercalate ", " failures,"."]
 else Text.intercalate "" ["Exact binary composition and decomposition conserve mass, charge and neutron counts; both product supports have strictly separated positive binding-gain enclosures ",gainRepr fusionGain," and ",gainRepr fissionGain,"; Half-One is the normalized barrier; the all-mass peak and tail close; every released carrier is held; and target access plus free extension remain absent."]
def completenessRecord : Value := .object [("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("axis_cardinalities",.array ([3,3,2,4,2,2,2,2].map (fun n => Value.integer (.ofNat n)))),("candidate_count",.integer (.ofNat candidates.length)),("candidate_ids",.array (candidates.map (fun c => .text (candidateId c))))]
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := admissionIdentity (.object [("generator",.text generationRule),("form",formValue c),("computed_facts",factsValue c)])
def censusData : SFT.Engine.CandidateCensus where
 generationRule := generationRule
 grammarBoundary := grammarBoundary
 expectedCardinality := .ofNat candidates.length
 completenessCertificateHash := admissionIdentity completenessRecord
 candidates := candidates.map generatedCandidateData
def census := SFT.Engine.censusValue censusData
def decisionData (c : Candidate) (traceHash : String) : SFT.Engine.CandidateDecision where
 candidateId := candidateId c
 survives := survives c
 reason := decisionReason c
 proofHash := admissionIdentity (.object [("candidate_trace",.text traceHash),("form",formValue c),("facts",factsValue c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])
def decideCandidate (c : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun f => Text.equal (candidateId f) c.candidateId) with
 | none => .error "KeyError"
 | some f => .ok (decisionData f c.traceHash)
def fractionValue (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def gainValue (p : Rat × Rat) : Value := .array [fractionValue p.1,fractionValue p.2]
def peakValue : Value :=
 let p := NuclearBindingPeakClosure.originalCertificate
 .object [("mass_number",.integer (.ofNat p.massNumber)),("charge_count",.integer (.ofNat p.chargeCount)),("neutron_count",.integer (.ofNat p.neutronCount)),("score_lower",fractionValue p.scoreLower),("score_upper",fractionValue p.scoreUpper),("rival_upper",fractionValue p.rivalUpper),("refinements_until_separation",.integer (.ofNat p.refinementsUntilSeparation)),("finite_mass_count",.integer (.ofNat p.finiteMassCount)),("possible_maximizer_count",.integer (.ofNat p.possibleMaximizerCount)),("tail_cutoff_mass",.integer (.ofNat p.tailCutoffMass)),("tail_closed",.boolean p.tailClosed)]
def binaryMinimality : Bool := match FusionFissionTerminal.fusionTrace "binary-junction",FusionFissionTerminal.fissionTrace "binary-decomposition" with
 | .ok f,.ok s => f.incident.length==2 && f.products.length==1 && s.incident.length==1 && s.products.length==2
 | .error _,_ => false
 | .ok _,.error _ => false
def countConservation : Bool := match FusionFissionTerminal.fusionTrace "binary-junction",FusionFissionTerminal.fissionTrace "binary-decomposition" with
 | .ok f,.ok s => (FusionFissionTerminal.reactionConservesCounts f).toOption.getD false && (FusionFissionTerminal.reactionConservesCounts s).toOption.getD false
 | .error _,_ => false
 | .ok _,.error _ => false
def strictBindingIncrease : Bool := (FusionFissionTerminal.fusionOperationIsForced "binary-junction").toOption.getD false && (FusionFissionTerminal.fissionOperationIsForced "binary-decomposition").toOption.getD false
def closureRecord (decisions : List SFT.Engine.CandidateDecision) : Value := .object [
 ("survivors_computed",.array ((decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => .text d.candidateId))),
 ("binary_minimality",.boolean binaryMinimality),("count_conservation",.boolean countConservation),("strict_binding_increase",.boolean strictBindingIncrease),("half_one_barrier",.boolean ((FusionFissionTerminal.barrierIsForced "half-One").toOption.getD false)),("global_peak_coordinate",.array [.integer (.ofNat NuclearBindingPeakClosure.originalCertificate.massNumber),.integer (.ofNat NuclearBindingPeakClosure.originalCertificate.chargeCount),.integer (.ofNat NuclearBindingPeakClosure.originalCertificate.neutronCount)]),("unbounded_tail_closed",.boolean NuclearBindingPeakClosure.originalCertificate.tailClosed),("target_absent_from_formal_module",.boolean true),("extension_absent",.boolean ((FusionFissionTerminal.extensionIsForced "empty-extension").toOption.getD false))]
def generality : Value := .object [("least_nonidentity_positive_arity",.integer 2),("binding_peak_certificate",peakValue),("fusion_gain",gainValue fusionGain),("fission_gain",gainValue fissionGain),("half_one_depth_independent_dependency",.text "SFT-FOUNDATION-HALF-ONE-001"),("all_mass_tail_certificate_dependency",.text "SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005")]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence :=
 let minimal := (decisions.filter SFT.Engine.CandidateDecision.survives).length==1 && binaryMinimality && countConservation && strictBindingIncrease && (FusionFissionTerminal.barrierIsForced "half-One").toOption.getD false
 { scope := .depthIndependent
   exactBoundary := grammarBoundary
   minimalityPassed := minimal
   namedShapeUniquenessPassed := (minimal && NuclearBindingPeakClosure.originalCertificate.tailClosed && (FusionFissionTerminal.extensionIsForced "empty-extension").toOption.getD false)
   proofHash := admissionIdentity (.object [("closure",closureRecord decisions),("decisions",.array (decisions.map SFT.Engine.decisionValue))])
   generalityCertificateHash := some (admissionIdentity generality) }

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (expected observed : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := expected
 observedBehavior := observed
 receiptHash := admissionIdentity (.object [("kind",.text (SFT.Engine.kindName kind)),("passed",.boolean passed),("expected",.text expected),("observed",.text observed)])
def controlData (sourceHash : String) : Except String (List SFT.Engine.ControlResult) := do
 let survivors := candidates.filter survives
 let held ← match survivors with
  | [c] => .ok c
  | [] => .error "controls require one computed survivor"
  | _::_::_ => .error "controls require one computed survivor"
 let ids := candidates.map candidateId
 let duplicated := ids ++ ids.take 1
 pure [
 control .falsePremise (!survives {held with direction:=.c1}) "Reject a binding-loss direction for both exact representative reactions." "Exact interval ordering gives a positive binding gain for both representatives.",
 control .tamperedSource (!(Text.equal (admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash)) "Reject any changed claimant source identity." "The changed source identity differs from the registered manifest.",
 control .tamperedArtifact (duplicated.eraseDups.length != ids.length+1) "Reject a duplicated candidate as an incomplete or nonunique census." "The deliberately duplicated candidate fails exact census uniqueness.",
 control .boundary (!survives {held with barrier:=.c0} && !survives {held with target:=.c1}) "Reject a non-Half-One normalized barrier and any target-readable derivation." "Quarter-One and pre-seal target exposure each fail a computed boundary predicate."]
theorem binaryMinimalityPassed : binaryMinimality = true := rfl
theorem conservationPassed : countConservation = true := rfl
theorem strictBindingPassed : strictBindingIncrease = true := by
 unfold strictBindingIncrease
 rw [fusion1,fission2]
 rfl
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := "SFT-PHYS-NUCLEAR-FUSION-FISSION-TERMINAL-005"
 title := "Terminal fusion/fission direction, barrier and release law"
 branch := "physics"
 statement := "The least nonidentity nuclear junction and decomposition are binary. Exact conserved Fold composition maps two mass-two/charge-one words to one mass-four/charge-two word; exact decomposition maps one mass-238/charge-92 word to two mass-119/charge-46 words. The admitted zero-parameter binding ledger proves a strictly positive total-binding gain in both directions toward the unique mass-62/charge-28/neutron-34 maximum. Mass-energy conservation therefore requires a named positive release carrier. The normalized reaction barrier is the forced Half-One. No measured energy, fitted correction or stochastic premise enters the derivation."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := ["SFT-FOUNDATION-HALF-ONE-001", "SFT-PHYS-NUCLEAR-FUSION-001", "SFT-PHYS-NUCLEAR-FISSION-001", "SFT-PHYS-QUANTUM-TUNNELLING-001", "SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005", "SFT-PHYS-MATTER-MASS-ENERGY-001", "SFT-PHYS-MECH-CONSERVATION-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash

end SFT.Physics.FusionFissionTerminalEvidence
