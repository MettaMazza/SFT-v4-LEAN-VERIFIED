from pathlib import Path
import json
w=Path('work');r=w/'turn1064_recovery/SFT/Chemistry'
s=(w/'prepare_resolved1164_experiment.py').read_text().replace('1164','1235').replace('rovibronic_joint_validation_v1','molecular_measurement_validation_v1').replace('rovibronic_joint_batch_v1','molecular_measurement_batch_v1').replace('ROVIBRONIC_JOINT_SPEC','MOLECULAR_MEASUREMENT_SPEC').replace('ResolvedRovibronic','MolecularMeasurement').replace('jointKeyWitness','retainedWitness').replace('spinWitness','closedWitness').replace('erasureWitness','overlapWitness');exec(s,{})
s=(r/'ResolvedRovibronicValidation.lean').read_text().replace('ResolvedRovibronic','MolecularMeasurement').replace('complete-resolved-H2-HD-D2-comparator/1','complete-NIST-CaH-measurement-comparator/1').replace('external-resolved-spectrum-row','external-molecular-measurement-row').replace('ELEC-013','ELEC-014').replace('ELEC-012','ELEC-014').replace('NuclearElectronicSource.Snapshot','MolecularMeasurementSource.Snapshot').replace('NuclearElectronicTargets.rows','MolecularMeasurementSource.rows').replace('NuclearElectronicTargets.readRow','MolecularMeasurementAnalysis.readRow').replace('sha256:b8a3cb16b0fbdc53a01846492e71b38585d0a7c5336b755f3f9ea21ba48d7421','sha256:5f34dcfb27bb36ca8931e5a26dcfd290285708c7b4a4412884ff794273416eef').replace('NIST-CHEMISTRY-WEBBOOK-SRD69-H2-HD-D2-RESOLVED-DIATOMIC-SURFACE-2026','NIST-MDS2-3389-CAH-QUANTUM-STATE-TRACKING-CONTROL-V1.0.1')
a=s.index('def measurement');b=s.index('structure Validation',a);s=s[:a]+'''def measurement (row : Value) : Except String String := do
 return Text.intercalate "" [← rowText row "target_id",": file ",← rowText row "file",
  " row ",integerText (← rowInt row "row_ordinal")," cells ",integerText (← rowInt row "cell_count"),
  " pass ",boolText (rowPassed row)]
'''+s[b:]
a=s.index(' let comparisons ←');b=s.index(' let targetIdentity',a);s=s[:a]+''' let comparisons := rows.map fun row => MolecularMeasurementAnalysis.rowComparison row released
 let source ← JointCorrelationTargets.field identityDocument "source"
 let components ← JointCorrelationTargets.field source "components" >>= NuclearElectronicTargets.list
 let counts ← MolecularMeasurementAnalysis.counts rows components.length
 let expected : List (String × Nat) := [("package_components",9),("csv_files",8),("rows",330),("cells",796),
  ("real_time_readouts",50),("J2_entry_exit_intervals",117),("J1_entry_exit_intervals",55),
  ("prepared_sublevel_rows",6),("recovery_classes",4),("tracking_intervals",71),
  ("pressure_control_rows",4),("appearance_time_rows",23),("positive_entry_exit_intervals",172),
  ("positive_tracking_intervals",70),("EmptyOne_tracking_boundary",1)]
 let countsExact := counts.length==expected.length && (counts.zip expected).all (fun ((a,n),(b,m)) => Text.equal a b && n==m)
 let absence := counts.any (fun (k,n) => Text.equal k "EmptyOne_tracking_boundary" && n==1)
 let noPredecessor := rows.all fun r => match r.source with
  | .object fs => fs.all (fun (k,_) => !(Text.chars "predecessor").isInfixOf_internal (Text.chars (Text.lowerAscii k)))
  | .null | .integer _ | .text _ | .boolean _ | .array _ => false
 let adverse : List (String × Bool) := [("exact_complete_counts",countsExact),("all_rows",comparisons.all rowPassed),
  ("omission_rejected",(rows.take (rows.length-1)).length != 330),
  ("zero_duration_retained",absence),("unrecorded_predecessor_not_in_dataset",noPredecessor)]
 let passed := adverse.all Prod.snd
'''+s[b:];(r/'MolecularMeasurementValidation.lean').write_text(s)
# Exact original programme and independent adversarial comparisons.
s=(w/'check_resolved1164_program.py').read_text().replace('1164','1235').replace('resolved','quantum').replace('ResolvedRovibronic','MolecularMeasurement').replace('rovibronic_joint_batch_v1','molecular_measurement_batch_v1').replace('ROVIBRONIC_JOINT_SPEC','MOLECULAR_MEASUREMENT_SPEC')
a=s.index('fixed=');b=s.index('\nmanifest=',a);files=json.loads((w/'quantum1235_source_pin.json').read_text())['execution_files'];s=s[:a]+'fixed='+repr(tuple(files))+s[b:];(w/'check_quantum1235_program.py').write_text(s)
(w/'turn1064_recovery/MolecularMeasurementProgram1235.lean').write_text((w/'turn1064_recovery/ResolvedRovibronicProgram1164.lean').read_text().replace('ResolvedRovibronic','MolecularMeasurement'))
s=(w/'build_quantum1235.py').read_text();s=s.replace("['MolecularMeasurement','MolecularMeasurementGrammar','MolecularMeasurementEvidence']","['MolecularMeasurementSource','MolecularMeasurementAnalysis','MolecularMeasurementExperiment','MolecularMeasurementValidation']").replace('quantum1235_entry_audit','quantum1235_interfaces_audit');(w/'build_quantum1235_interfaces.py').write_text(s)
print('Staged source,analysis,experiment,full empirical validation and programme comparison')
