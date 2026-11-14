import SFT.Physics.NuclearBindingMeasurement
namespace SFT.Physics.FusionFissionMeasurement
open SFT.Host SFT.Host.Canonical LeptonIntervals RunningConvergenceMeasurement NuclearBindingMeasuredRows
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def payloadBoundary (payload : Value) : Except String Value := do
 if !sameValue ((field payload "source_id").toOption.getD .null) (.text "AMDC-AME2020-MASS-1-BINDING-2021") then throw "AME2020 source identifier changed"
 let custody := (field payload "custody").toOption.getD (.object [])
 if !sameValue ((field custody "development_targets_already_known").toOption.getD .null) (.boolean true) then throw "AME2020 fusion/fission custody disclosure changed"
 if !sameValue ((field custody "protocol_classification").toOption.getD .null) (.text "observational-data-informed_target-inaccessible_sealed-prediction") then throw "AME2020 fusion/fission custody disclosure changed"
 if !sameValue ((field custody "empirical_prediction_protocol").toOption.getD .null) (.boolean true) then throw "AME2020 fusion/fission custody disclosure changed"
 if !sameValue ((field custody "target_inaccessible_during_prediction_execution").toOption.getD .null) (.boolean true) then throw "AME2020 fusion/fission custody disclosure changed"
 if !sameValue ((field custody "formal_relations_contain_measurement").toOption.getD .null) (.boolean false) then throw "AME2020 fusion/fission custody disclosure changed"
 if !sameValue ((field custody "measurements_select_formal_survivors").toOption.getD .null) (.boolean false) then throw "AME2020 fusion/fission custody disclosure changed"
 if !sameValue ((field custody "engine_prediction_sealed_before_target_release_within_run").toOption.getD .null) (.boolean true) then throw "AME2020 fusion/fission custody disclosure changed"
 if !sameValue ((field custody "complete_reported_uncertainties_retained").toOption.getD .null) (.boolean true) then throw "AME2020 fusion/fission custody disclosure changed"
 if !sameValue ((field custody "no_fitted_mass_formula_coefficient").toOption.getD .null) (.boolean true) then throw "AME2020 fusion/fission custody disclosure changed"
 if !sameValue ((field custody "irrational_radius_not_admitted").toOption.getD .null) (.boolean true) then throw "AME2020 fusion/fission custody disclosure changed"
 let census := (field payload "complete_numeric_binding_census").toOption.getD (.object [])
 if !sameValue ((field census "positive_composite_row_count").toOption.getD .null) (.integer 2548) then throw "AME2020 positive-composite census changed"
 let boundary ← match array ((field census "singleton_empty_binding_boundary_rows").toOption.getD .null) with
  | .error _ => .error "AME2020 singleton boundary census changed"
  | .ok rows => .ok rows
 if boundary.length != 2 then throw "AME2020 singleton boundary census changed"
 pure payload

def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let raw ← match files.find? (fun p => Text.equal p.1 NuclearBindingRecords.rawPath) with
  | none => .error (Text.append "FileNotFoundError: " NuclearBindingRecords.rawPath)
  | some pair => .ok pair.2
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) NuclearBindingRecords.sourceHash || !Text.equal (Text.append "sha256:" (SHA256Chunks.digest raw)) NuclearBindingRecords.rawHash then throw "AME2020 fusion/fission source identity changed"
 payloadBoundary payload
def parseLine (line : List Char) : Except String (Option Row) := do
 if line.length < 79 then pure none else
  match LeptonDecimal.exponent (segment line 4 9),LeptonDecimal.exponent (segment line 9 14),LeptonDecimal.exponent (segment line 14 19) with
  | some n,some z,some a =>
    if a < 2 then pure none else
     let bindingRaw := segment line 54 67
     let uncertaintyRaw := segment line 68 78
     if bindingRaw.isEmpty || Text.equal (String.ofList bindingRaw) "*" || Text.contains (String.ofList bindingRaw) "#" then pure none else
      match inscription bindingRaw,inscription uncertaintyRaw with
      | some binding,some uncertainty =>
        if !uncertainty.blt binding || !zero.blt uncertainty then throw "AME2020 positive-composite interval left the positive domain"
        let lower ← RunningConvergence.positiveTake binding uncertainty
        pure (some ⟨a,z,n,String.ofList (segment line 20 23),binding,uncertainty,lower,add binding uncertainty⟩)
      | none,none => pure none
      | none,some _ => pure none
      | some _,none => pure none
  | none,_,_ => pure none
  | some _,none,_ => pure none
  | some _,some _,none => pure none
def rowsFromText (raw : String) : Except String (List Row) := do
 let parsed ← (LeptonDecimal.split '\n' (Text.chars raw)).mapM parseLine
 let rows := parsed.flatMap (fun row => match row with | none => [] | some row => [row])
 if rows.length != 2548 then throw "complete AME2020 positive-composite census changed"
 pure rows
def measuredBindingRows (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String (List Row) := do
 let _ ← authoritativeRecord bytes files payload
 let raw ← match files.find? (fun p => Text.equal p.1 NuclearBindingRecords.rawPath) with
  | none => .error (Text.append "FileNotFoundError: " NuclearBindingRecords.rawPath)
  | some pair => .ok (String.ofList (Text.decode pair.2.size pair.2.data.toList))
 rowsFromText raw
def rowValue (r : Row) : Value := .object [("mass_count",.integer r.mass),("charge_count",.integer r.charge),("neutron_count",.integer r.neutrons),("element",.text r.element),("binding_keV_per_nucleon",NuclearBindingMeasurement.fractionValue r.binding),("uncertainty_keV_per_nucleon",NuclearBindingMeasurement.fractionValue r.uncertainty),("lower_keV_per_nucleon",NuclearBindingMeasurement.fractionValue r.lower),("upper_keV_per_nucleon",NuclearBindingMeasurement.fractionValue r.upper)]
def measurementAnalysis (rows : List Row) : Except String Value := do
 if rows.length != 2548 then throw "measurement analysis requires the complete positive-composite census"
 let ranked := (NuclearBindingMeasurement.ranked rows.zipIdx).map Prod.fst
 let (peak,rest) ← match ranked with
  | [] => .error "IndexError"
  | first::rest => .ok (first,rest)
 let rivalUpper ← match rest with
  | [] => .error "max() arg is an empty sequence"
  | first::tail => .ok (tail.foldl (fun best row => if best.blt row.upper then row.upper else best) first.upper)
 let d ← rowByCoordinate rows 2 1
 let h ← rowByCoordinate rows 4 2
 let u ← rowByCoordinate rows 238 92
 let p ← rowByCoordinate rows 119 46
 pure (.object [("row_count",.integer (.ofNat rows.length)),("fusion_anchor_rows",.array [rowValue d,rowValue h]),("fission_anchor_rows",.array [rowValue u,rowValue p]),("peak_row",rowValue peak),("rival_upper",NuclearBindingMeasurement.fractionValue rivalUpper),("fusion_higher_after_uncertainty",.boolean (d.upper.blt h.lower)),("fission_higher_after_uncertainty",.boolean (u.upper.blt p.lower)),("reversed_fusion_rejected",.boolean (!h.upper.blt d.lower)),("reversed_fission_rejected",.boolean (!p.upper.blt u.lower)),("peak_separated_from_every_rival",.boolean (rivalUpper.blt peak.lower))])
theorem originalRecord : payloadBoundary NuclearBindingRecords.registeredRecord = .ok NuclearBindingRecords.registeredRecord := rfl
end SFT.Physics.FusionFissionMeasurement
