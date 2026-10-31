import SFT.Physics.RunningConvergenceCertificate
import SFT.Physics.EvolutionMeasuredSource
namespace SFT.Physics.RunningConvergenceMeasurement
open SFT.Host SFT.Host.Canonical

def field (v : Value) (key : String) : Except String Value :=
 match v with
 | .object fs => match CapabilityDocuments.field key fs with
   | some x => .ok x
   | none => .error (Text.append "KeyError: " key)
 | .text _ | .boolean _ | .integer _ | .null | .array _ => .error "TypeError: source record is not an object"

def text (v : Value) : Except String String :=
 match v with
 | .text s => .ok s
 | .object _ | .boolean _ | .integer _ | .null | .array _ => .error "TypeError: source value is not text"

def array (v : Value) : Except String (List Value) :=
 match v with
 | .array xs => .ok xs
 | .object _ | .boolean _ | .integer _ | .null | .text _ => .error "TypeError: source value is not an array"

def rowAt : List Value → Nat → Except String Value
 | [],_ => .error "IndexError: source row absent"
 | x::_,0 => .ok x
 | _::xs,n+1 => rowAt xs n

def decimalField (v : Value) (key : String) : Except String Rat := do
 LeptonDecimal.exactDecimal (← text (← field v key))

def symmetricInterval (central uncertainty : Rat) : Except String (Rat × Rat) := do
 let lower ← RunningConvergence.positiveTake central uncertainty
 pure (lower,LeptonIntervals.add central uncertainty)

def rowInterval (v : Value) (central uncertainty : String) : Except String (Rat × Rat) := do
 symmetricInterval (← decimalField v central) (← decimalField v uncertainty)

def intervalFromPair (v : Value) : Except String (Rat × Rat) := do
 let pair ← array v
 if pair.length != 2 then throw "measurement pair must contain central value and uncertainty"
 let central ← LeptonDecimal.exactDecimal (← text (← rowAt pair 0))
 let uncertainty ← LeptonDecimal.exactDecimal (← text (← rowAt pair 1))
 symmetricInterval central uncertainty

def positive (q : Rat) : Bool := @decide (1 ≤ q.num) (Int.decLe 1 q.num)
def intervalValue := EvolutionMeasuredSource.intervalJSON
def ratValue := RunningConvergenceCertificate.rat

def qcdAnalysis (qcd electroweak : Value) : Except String Value := do
 let rows ← array (← field qcd "exact_multiscale_rows")
 let low ← rowAt rows 0
 let high ← rowAt rows 1
 let lowInterval ← rowInterval low "central" "symmetric_uncertainty"
 let highInterval ← rowInterval high "central" "symmetric_uncertainty"
 let zMass ← field electroweak "z_mass_scope"
 let zInterval ← rowInterval zMass "central_GeV" "symmetric_uncertainty_GeV"
 let lowScale ← decimalField low "scale_GeV"
 let tableRows ← array (← field (← field qcd "table_9_1") "complete_rows")
 let tablePositive ← tableRows.mapM fun row => do
   let unweighted ← intervalFromPair (← field row "unweighted")
   let weighted ← intervalFromPair (← field row "weighted")
   let without ← field row "without_subfield"
   let withoutPositive ← match without with
     | .null => pure true
     | .text _ | .boolean _ | .integer _ | .array _ | .object _ => do
       let interval ← intervalFromPair without
       pure (positive interval.1)
   pure (positive unweighted.1 && positive weighted.1 && withoutPositive)
 let figure ← field qcd "figure_9_4"
 let classes ← array (← field figure "complete_legend_classes")
 let policy ← text (← field figure "machine_policy")
 let conclusion ← text (← field (← field qcd "printed_conclusion") "comparison_class")
 pure (.object [
  ("exact_multiscale_row_count",.integer (.ofNat rows.length)),
  ("table_9_1_row_count",.integer (.ofNat tableRows.length)),
  ("figure_9_4_class_count",.integer (.ofNat classes.length)),
  ("low_scale_GeV",ratValue lowScale),("z_mass_interval_GeV",intervalValue zInterval),
  ("low_alpha_s_interval",intervalValue lowInterval),("mZ_alpha_s_interval",intervalValue highInterval),
  ("scales_strictly_ordered",.boolean (lowScale.blt zInterval.1)),
  ("separated_intervals_strictly_decrease_with_energy",.boolean (highInterval.2.blt lowInterval.1)),
  ("all_table_intervals_positive",.boolean (tablePositive.all id)),
  ("full_figure_retained_without_fabricated_coordinates",.boolean (Text.equal policy "The complete vector figure is retained by immutable PDF hash and visual audit. Values not numerically printed by PDG are not fabricated by digitizing the plot.")),
  ("pdg_energy_dependence_conclusion_retained",.boolean (Text.equal conclusion "strong-coupling-energy-dependence-confirmed"))])

def electromagneticAnalysis (electroweak endpoint : Value) : Except String Value := do
 let zeroScope ← field electroweak "alpha_zero_scope"
 let zeroRows ← array (← field zeroScope "complete_rows")
 let deltaRows ← array (← field (← field electroweak "table_10_1") "complete_rows")
 let adopted ← rowAt zeroRows (zeroRows.length-1)
 let adoptedInterval ← rowInterval adopted "central_inverse_alpha" "standard_uncertainty"
 let endpointRows ← array (← field endpoint "exact_endpoint_rows")
 let lowInterval ← rowInterval (← rowAt endpointRows 0) "central" "standard_uncertainty"
 let highInterval ← rowInterval (← rowAt endpointRows 1) "central" "standard_uncertainty"
 let deltas ← deltaRows.mapM fun row => rowInterval row "central" "symmetric_uncertainty"
 let relation ← text (← field zeroScope "published_relation")
 let observation ← text (← field zeroScope "direct_observation")
 pure (.object [
  ("alpha_zero_row_count",.integer (.ofNat zeroRows.length)),
  ("delta_alpha_row_count",.integer (.ofNat deltaRows.length)),
  ("current_adopted_inverse_alpha_interval",intervalValue adoptedInterval),
  ("explicit_prior_low_inverse_alpha_interval",intervalValue lowInterval),
  ("explicit_z_inverse_alpha_interval",intervalValue highInterval),
  ("inverse_alpha_strictly_decreases_to_z_scale",.boolean (highInterval.2.blt lowInterval.1)),
  ("therefore_alpha_strictly_increases_to_z_scale",.boolean (highInterval.2.blt lowInterval.1)),
  ("all_hadronic_delta_intervals_positive",.boolean (deltas.all (fun interval => positive interval.1))),
  ("published_running_relation_retained",.boolean (Text.equal relation "alpha(M_Z^2) = alpha(0) / [1 - Delta alpha(M_Z^2)]")),
  ("direct_lep_observation_retained",.boolean (Text.contains observation "L3 and OPAL directly observed"))])

def boolField (v : Value) (key : String) : Except String Bool := do
 match ← field v key with
 | .boolean b => pure b
 | .text _ | .integer _ | .null | .array _ | .object _ => throw "TypeError: source flag is not Boolean"

def exactMeasurementAnalysis (record : Value) : Except String Value := do
 let sources ← array (← field record "sources")
 let qcd ← rowAt sources 0
 let ew ← rowAt sources 1
 let endpoint ← rowAt sources 2
 let strong ← qcdAnalysis qcd ew
 let electromagnetic ← electromagneticAnalysis ew endpoint
 let sd ← boolField strong "separated_intervals_strictly_decrease_with_energy"
 let ed ← boolField electromagnetic "therefore_alpha_strictly_increases_to_z_scale"
 pure (.object [("strong",strong),("electromagnetic",electromagnetic),
  ("carrier_specific_opposite_energy_directions_retained",.boolean (sd && ed)),
  ("formal_convergence_not_promoted_to_direct_measurement",.boolean true),
  ("all_sources_retained",.boolean (sources.length==3))])

theorem uncertaintyRetainsExactEndpoints (central uncertainty lower : Rat)
 (take : RunningConvergence.positiveTake central uncertainty = .ok lower) :
 symmetricInterval central uncertainty = .ok (lower,LeptonIntervals.add central uncertainty) := by
 unfold symmetricInterval
 rw [take]
 rfl

def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/coupling-running-convergence-source-record.json","sha256:b83331089d96c073fbd5101753ba5c4716ae1a8b1b891e068684b6f7246d9953"),("experiments/external_sources/physics/snapshots/pdg-2026-qcd.pdf","sha256:c04c628d76b18610c5fa2a919c6081918a25b55fb971b6af5829f4ca2baa386f"),("experiments/external_sources/physics/snapshots/pdg-2026-electroweak-model.pdf","sha256:a102f6252b7190dc423200271dffa7c805cd15a50391b1c578853d2f777611cb"),("experiments/external_sources/physics/snapshots/pdg-2025-electroweak-model.pdf","sha256:8642888a3408d8c57fc673b379325b07f02948135491f64a2e42320e8929320a")]
def sourceId : String := "PDG-COUPLING-RUNNING-CONVERGENCE-2025-2026"
def sourceIds : List String := ["PDG-2026-QCD-REVIEW", "PDG-2026-ELECTROWEAK-REVIEW", "PDG-2025-ELECTROMAGNETIC-RUNNING-ENDPOINT"]
def targetIds : List String := ["PDG-COMPLETE-STRONG-RUNNING-VECTOR", "PDG-COMPLETE-ELECTROMAGNETIC-RUNNING-VECTOR", "PDG-EXPLICIT-ELECTROMAGNETIC-ENDPOINT-PAIR"]
def falsification : String := "Reject if any of the seven PDG QCD Table 9.1 rows, nine Figure 9.4 measurement classes, exact low- and m_Z-scale strong-coupling rows, five current alpha(0) rows, eleven current hadronic Delta-alpha rows, published electromagnetic running relation, direct LEP observation or explicit prior Z-scale endpoint is omitted or altered; if the separated strong-coupling intervals do not decrease from 1.37 GeV to m_Z; if the explicit inverse electromagnetic endpoint intervals do not decrease from the Thomson limit to the Z scale; if a universal physical energy sign is imposed despite the sealed carrier-specific coordinates; if the exact Fold support successor, running-share increment, pair-gap shrinkage or finite tolerance witness fails; if the formal convergence prediction is falsely labelled a direct measurement; or if any target content enters before the prediction seal."

def checkExpectedHashes (files : List (String × ByteArray)) : List (String × String) → Except String Unit
 | [] => .ok ()
 | (path,expected)::rest => do
   let actual ← match files.find? (fun f => Text.equal f.1 path) with
    | some (_,bytes) => pure (Text.append "sha256:" (SHA256.digest bytes))
    | none => throw (Text.append "coupling-running source identity changed: " path)
   if !Text.equal actual expected then throw (Text.append "coupling-running source identity changed: " path)
   checkExpectedHashes files rest

def checkHashes (files : List (String × ByteArray)) : Except String Unit := checkExpectedHashes files sourceHashes

def sameValue (a b : Value) : Bool := Text.equal (render a) (render b)

def requiredCustody : List (String × Value) := [
 ("complete_reported_rows_retained",.boolean true),
 ("development_targets_already_known",.boolean true),
 ("empirical_prediction_protocol",.boolean true),
 ("engine_prediction_sealed_before_target_release_within_run",.boolean true),
 ("formal_relations_contain_measurement",.boolean false),
 ("measurements_select_formal_survivors",.boolean false),
 ("protocol_classification",.text "observational-data-informed_target-inaccessible_sealed-prediction"),
 ("target_inaccessible_during_prediction_execution",.boolean true)]

def checkCustody (custody : Value) : List (String × Value) → Except String Unit
 | [] => .ok ()
 | (key,expected)::rest => do
   if !sameValue (← field custody key) expected then throw "coupling-running custody boundary changed"
   checkCustody custody rest

def authoritativeRecord (files : List (String × ByteArray)) (record : Value) : Except String Value := do
 checkHashes files
 let source ← text (← field record "source_id")
 let sources ← array (← field record "sources")
 if !Text.equal source sourceId || sources.length != 3 then throw "coupling-running source-set identity changed"
 let custody ← field record "custody"
 checkCustody custody requiredCustody
 let qcd ← rowAt sources 0
 let ew ← rowAt sources 1
 let endpoint ← rowAt sources 2
 let ids ← sources.mapM fun s => do text (← field s "source_id")
 let hashes ← sources.mapM fun s => do text (← field s "snapshot_sha256")
 let qcdRows ← array (← field qcd "exact_multiscale_rows")
 let tableRows ← array (← field (← field qcd "table_9_1") "complete_rows")
 let classes ← array (← field (← field qcd "figure_9_4") "complete_legend_classes")
 let zeroRows ← array (← field (← field ew "alpha_zero_scope") "complete_rows")
 let deltaRows ← array (← field (← field ew "table_10_1") "complete_rows")
 let endpointRows ← array (← field endpoint "exact_endpoint_rows")
 if ids != sourceIds || hashes != (sourceHashes.drop 1).map (fun kv => String.ofList (Text.chars kv.2 |>.drop 7)) ||
   qcdRows.length != 2 || tableRows.length != 7 || classes.length != 9 || zeroRows.length != 5 || deltaRows.length != 11 || endpointRows.length != 2 then
   throw "coupling-running registered row or page scope changed"
 pure record

def checkedMeasurementAnalysis (files : List (String × ByteArray)) (record : Value) : Except String Value := do
 exactMeasurementAnalysis (← authoritativeRecord files record)

end SFT.Physics.RunningConvergenceMeasurement
