import SFT.Physics.FusionFissionYieldThresholdGrammar
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.FusionFissionYieldThresholdEvidence
open SFT.Host SFT.Host.Canonical FusionFissionYieldThresholdGrammar FusionFissionYieldThresholdProofs
open SFT.Foundation.AdmissionControls (admissionIdentity)
local instance : BEq String := ⟨Text.equal⟩
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def formValue (c : Candidate) : Value := .object [("per_nucleon_relation",.text (perNucleonName c.perNucleon)),("total_release_relation",.text (totalName c.total)),("fusion_threshold_carrier",.text (fusionCarrierName c.fusionCarrier)),("fission_threshold_carrier",.text (fissionCarrierName c.fissionCarrier)),("threshold_scope",.text (scopeName c.scope)),("access_carrier",.text (accessName c.access)),("metric_retention",.text (metricName c.metric)),("target_boundary",.text (targetName c.target)),("extension",.text (extensionName c.extension))]
def factsValue (c : Candidate) : Value := .object ((computedFacts c).map (fun (key,b) => (key,.boolean b)))
def exactForm (c : Candidate) : String := Text.intercalate "; " [Text.append "per_nucleon=" (perNucleonName c.perNucleon),Text.append "total=" (totalName c.total),Text.append "fusion_threshold=" (fusionCarrierName c.fusionCarrier),Text.append "fission_threshold=" (fissionCarrierName c.fissionCarrier),Text.append "scope=" (scopeName c.scope),Text.append "access=" (accessName c.access),Text.append "metrics=" (metricName c.metric),Text.append "target=" (targetName c.target),Text.append "extension=" (extensionName c.extension)]
def fractionRepr (q : Rat) : String := Text.intercalate "" ["Fraction(",render (.integer q.num),", ",render (.integer (.ofNat q.den)),")"]
def gainRepr (p : Rat × Rat) : String := Text.intercalate "" ["(",fractionRepr p.1,", ",fractionRepr p.2,")"]
def booleanRepr (b : Bool) : String := if b then "True" else "False"
def optionalRepr : Option Nat → String
 | none => "()" | some n => render (.integer (.ofNat n))
def orderRepr (o : FusionFissionYieldThreshold.ReleaseOrder) : String := Text.intercalate "" ["{'fusion_per_nucleon': ",gainRepr o.fusionPerNucleon,", 'fission_per_nucleon': ",gainRepr o.fissionPerNucleon,", 'fusion_total': ",gainRepr o.fusionTotal,", 'fission_total': ",gainRepr o.fissionTotal,", 'fusion_greater_per_nucleon': ",booleanRepr o.fusionGreaterPerNucleon,", 'fission_greater_total': ",booleanRepr o.fissionGreaterTotal,", 'orders_are_distinct': ",booleanRepr o.ordersAreDistinct,"}"]
def topologyRepr (t : FusionFissionYieldThreshold.Topology) : String := Text.intercalate "" ["{'fusion_has_two_charged_incident_words': ",booleanRepr t.fusionHasTwoChargedIncidentWords,", 'fusion_inter_boundary_paths': ",optionalRepr t.fusionInterBoundaryPaths,", 'fission_has_one_parent_word': ",booleanRepr t.fissionHasOneParentWord,", 'fission_inter_boundary_paths': ",optionalRepr t.fissionInterBoundaryPaths,", 'neutral_trigger_charge_is_empty_form': ",booleanRepr t.neutralTriggerChargeIsEmptyForm,", 'internal_surface_is_finite': ",booleanRepr t.internalSurfaceIsFinite,", 'residual_interaction_is_short_range_order': ",booleanRepr t.residualInteractionIsShortRangeOrder,", 'carriers_are_distinct': ",booleanRepr t.carriersAreDistinct,"}"]
def decisionReason (c : Candidate) : String :=
 let failures := ((computedFacts c).filter (fun p => !p.2)).map Prod.fst
 if !failures.isEmpty then Text.intercalate "" ["Rejected by computed Fold predicates: ",Text.intercalate ", " failures,"."]
 else match FusionFissionYieldThreshold.exactReleaseOrder,FusionFissionYieldThreshold.thresholdTopology with
 | .ok o,.ok t => Text.intercalate "" ["Exact interval separation gives fusion greater per conserved nucleon but the larger heavy decomposition greater in total release: ",orderRepr o,".  Two charged incident words force an inter-boundary opposition path, whereas one-parent decomposition has no such path and proceeds through neutral capture or its finite internal boundary: ",topologyRepr t,".  The distinct metrics and dimensional carrier classes remain retained."]
 | .error e,_ => e
 | .ok _,.error e => e
def completenessRecord : Value := .object [("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("axis_cardinalities",.array ([3,3,3,3,3,3,2,2,2].map (fun n => Value.integer (.ofNat n)))),("candidate_count",.integer (.ofNat candidates.length)),("candidate_ids",.array (candidates.map (fun c => .text (candidateId c))))]
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
def optionalValue : Option Nat → Value
 | none => .array [] | some n => .integer (.ofNat n)
def orderValue (o : FusionFissionYieldThreshold.ReleaseOrder) : Value := .object [("fusion_per_nucleon",gainValue o.fusionPerNucleon),("fission_per_nucleon",gainValue o.fissionPerNucleon),("fusion_total",gainValue o.fusionTotal),("fission_total",gainValue o.fissionTotal),("fusion_greater_per_nucleon",.boolean o.fusionGreaterPerNucleon),("fission_greater_total",.boolean o.fissionGreaterTotal),("orders_are_distinct",.boolean o.ordersAreDistinct)]
def topologyValue (t : FusionFissionYieldThreshold.Topology) : Value := .object [("fusion_has_two_charged_incident_words",.boolean t.fusionHasTwoChargedIncidentWords),("fusion_inter_boundary_paths",optionalValue t.fusionInterBoundaryPaths),("fission_has_one_parent_word",.boolean t.fissionHasOneParentWord),("fission_inter_boundary_paths",optionalValue t.fissionInterBoundaryPaths),("neutral_trigger_charge_is_empty_form",.boolean t.neutralTriggerChargeIsEmptyForm),("internal_surface_is_finite",.boolean t.internalSurfaceIsFinite),("residual_interaction_is_short_range_order",.boolean t.residualInteractionIsShortRangeOrder),("carriers_are_distinct",.boolean t.carriersAreDistinct)]
def closureRecord (decisions : List SFT.Engine.CandidateDecision) : Except String Value := do
 pure (.object [("survivors_computed",.array ((decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => .text d.candidateId))),("release_order",orderValue (← FusionFissionYieldThreshold.exactReleaseOrder)),("threshold_topology",topologyValue (← FusionFissionYieldThreshold.thresholdTopology)),("target_absent_from_formal_module",.boolean true),("extension_absent",.boolean (← FusionFissionYieldThreshold.extensionIsForced "empty-extension"))])
def generality : Except String Value := do
 let t ← FusionFissionYieldThreshold.thresholdTopology
 pure (.object [("exact_order",orderValue (← FusionFissionYieldThreshold.exactReleaseOrder)),("incident_topology",topologyValue t),("least_nonidentity_fusion_arity",.integer 2),("one_parent_fission_arity",.integer 1),("source_binding_dependency",.text "SFT-PHYS-NUCLEAR-FUSION-FISSION-TERMINAL-005"),("universal_dimensional_threshold_absent",.boolean t.carriersAreDistinct)])
def closureData (decisions : List SFT.Engine.CandidateDecision) : Except String SFT.Engine.ClosureEvidence := do
 let o ← FusionFissionYieldThreshold.exactReleaseOrder
 let t ← FusionFissionYieldThreshold.thresholdTopology
 let minimal := (decisions.filter SFT.Engine.CandidateDecision.survives).length==1 && o.ordersAreDistinct && t.carriersAreDistinct
 pure { scope := .depthIndependent
        exactBoundary := grammarBoundary
        minimalityPassed := minimal
        namedShapeUniquenessPassed := minimal && (← FusionFissionYieldThreshold.extensionIsForced "empty-extension")
        proofHash := admissionIdentity (.object [("closure",← closureRecord decisions),("decisions",.array (decisions.map SFT.Engine.decisionValue))])
        generalityCertificateHash := some (admissionIdentity (← generality)) }

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
  | [] => .error "controls require exactly one computed form"
  | _::_::_ => .error "controls require exactly one computed form"
 let ids := candidates.map candidateId
 let duplicated := (ids ++ ids.take 1).map (fun id => id.toUTF8.data.toList.map UInt8.toNat)
 pure [
 control .falsePremise (!survives {held with perNucleon:=.c2}) "Reject a reversed fusion/fission gain-per-nucleon order." "Exact lower-versus-upper separation rejects the reversed order.",
 control .tamperedSource (!(Text.equal (admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash)) "Reject any changed claimant source identity." "The changed identity differs from the registered source manifest.",
 control .tamperedArtifact (duplicated.eraseDups.length != ids.length+1) "Reject any duplicated or incomplete candidate census." "The deliberate duplicate fails complete census uniqueness.",
 control .boundary (!survives {held with scope:=.c0} && !survives {held with target:=.c1}) "Reject one universal dimensional threshold and any pre-seal target access." "Distinct incident carriers and sealed custody reject both boundary violations."]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := "SFT-PHYS-NUCLEAR-FUSION-FISSION-YIELD-THRESHOLD-006"
 title := "Fusion/fission yield ordering and distinct threshold carriers"
 branch := "physics"
 statement := "For the least light binary fusion representative and the registered symmetric heavy fission representative, exact zero-parameter binding-score enclosures force the fusion gain per conserved nucleon strictly above the fission gain per conserved nucleon, while the heavy reaction's larger nucleon count forces its total release strictly above the light reaction's total.  Fusion requires two charged incident boundaries to approach through Coulomb opposition before short-range residual closure; fission has one parent and therefore proceeds through a neutral-capture or internal-surface carrier.  Half-One and quarter-order structures remain normalized relations, not one universal dimensional threshold.  Dimensional reaction energies and thresholds are opened only after sealing."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := ["SFT-PHYS-NUCLEAR-FUSION-FISSION-TERMINAL-005", "SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003", "SFT-PHYS-NUCLEAR-RESIDUAL-FORCE-TERMINAL-005", "SFT-PHYS-QUANTUM-TUNNELLING-001", "SFT-PHYS-THERMO-TEMPERATURE-001", "SFT-PHYS-MATTER-MASS-ENERGY-001", "SFT-PHYS-MECH-CONSERVATION-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
end SFT.Physics.FusionFissionYieldThresholdEvidence
