from pathlib import Path
p=Path('work/turn1064_recovery/SFT/Chemistry');s=(p/'VibrationalFrequencyValidation.lean').read_text().replace('VibrationalFrequency','RotationalConstant').replace('PROP-009','PROP-010').replace('exact-NIST-vibrational-frequency-vector','exact-NIST-rotational-constant-vector').replace('(snapshot : RotationalConstantSource.Snapshot)','(listSnapshot choiceSnapshot snapshot : RotationalConstantSource.Snapshot)').replace('identityDocument targets primary snapshot','identityDocument targets primary listSnapshot choiceSnapshot snapshot')
a=s.index('  let identityMatch :=');b=s.index('  pure (⟨value,passed,message⟩ : Comparison)',a)
s=s[:a]+'''  let identityMatch := labelMatches word 1 (get row.row "name") && labelMatches word 2 (get row.row "species") &&
   labelMatches word 3 (get row.row "external_charge_inscription") && labelMatches word 4 (get row.row "axis_label") &&
   countMatches 9 "displayed_molecular_row" && countMatches 10 "displayed_axis_ordinal"
  let valueMatches := sameValue released (CapabilityValues.canonical row.value)
  let passed := valueMatches && identityMatch
  let present := sameValue (get row.row "measurement_present") (.boolean true)
  let inscription ← if present then field row.row "rotational_constant_inscription_cm_inverse" >>= text else pure "structural EmptyOne"
  let value := Value.object [("target_id",.text row.targetId),("displayed_molecular_row",get row.row "displayed_molecular_row"),
   ("name",get row.row "name"),("species",get row.row "species"),
   ("external_charge_inscription",get row.row "external_charge_inscription"),("axis_label",get row.row "axis_label"),
   ("measurement_present",get row.row "measurement_present"),("rotational_constant_inscription_cm_inverse",get row.row "rotational_constant_inscription_cm_inverse"),
   ("exact_positive_ratio_or_structural_EmptyOne",.boolean valueMatches),("identity_match",.boolean identityMatch),("passed",.boolean passed)]
  let message := Text.intercalate "" [row.targetId,": ",inscription," per centimeter; exact and axis-bound ",boolText passed]
'''+s[b:]
s=s.replace('get row.row "molecule_count"','get row.row "displayed_molecular_row"')
a=s.index(' let controls :');b=s.index(' let passed := comparisons.all',a)
s=s[:a]+''' let one ← CapabilityValues.count 1
 let controls : List (String × Bool) := [
  ("tampered_rotational_constant_rejected",!sameValue (CapabilityValues.canonical tampered) (CapabilityValues.canonical first.value)),
  ("tampered_blank_axis_rejected",!sameValue (CapabilityValues.canonical (.ratio one one)) (CapabilityValues.canonical (.emptyOne "empty-One"))),
  ("complete_axis_support_preserved",source.length==3015 && uniqueTargets.length==3015),
  ("complete_molecular_row_support_preserved",uniqueMolecules.length==1005),
  ("measured_and_absent_axis_cells_preserved",measured.length==1681 && absent.length==1334),
  ("complete_list_choice_query_boundary_preserved",sameValue (get primary "complete_listed_species_count") (.integer 2186) &&
   sameValue (get primary "complete_unique_formula_composition_query_count") (.integer 1193) &&
   sameValue (get primary "complete_returned_charge_state_choice_count") (.integer 1832)),
  ("unreturned_composition_boundary_preserved",sameValue (get primary "complete_listed_composition_without_returned_choice_count") (.integer 83)),
  ("all_measured_values_exact_and_positive",measured.all fun row => positive row.value),
  ("all_blank_axis_values_structural_EmptyOne",absent.all fun row => match row.value with
   | .emptyOne _ => true
   | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ | .table _ => false)]
'''+s[b:]
s=s.replace('NIST-CCCBDB-COMPLETE-DISPLAYED-FUNDAMENTAL-FREQUENCY-SURFACE','NIST-CCCBDB-COMPLETE-ROTATIONAL-CONSTANT-SURFACE')
(p/'RotationalConstantValidation.lean').write_text(s)
s=(p/'VibrationalFrequencyPrediction.lean').read_text().replace('VibrationalFrequency','RotationalConstant').replace('PROP-009','PROP-010').replace('2009','3015').replace('cells.length==15','cells.length==16').replace('complete mode and law custody','complete geometry, axis and law custody').replace('3015-row table','3015-axis table')
(p/'RotationalConstantPrediction.lean').write_text(s)
