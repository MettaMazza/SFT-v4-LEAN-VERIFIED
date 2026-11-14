from pathlib import Path
w=Path('work')
s=(w/'stage_atomicprecisionrecord951_generated.py').read_text().replace('atomic_precision_successor_validation_v1','hydrogen_rydberg_successor_validation_v1').replace('atomicprecision951_original_record','hydrogenrydberg955_original_record').replace('AtomicPrecisionRecords','HydrogenRydbergRecords').replace('atomic precision','hydrogen Rydberg')
a=s.index('required=');b=s.index("s+=''.join",a)
required={'development_targets_already_known':True,'classification':'observational_derivation','protocol_classification':'observational-data-informed_target-inaccessible_sealed-prediction','empirical_prediction_protocol':True,'target_inaccessible_during_prediction_execution':True,'formal_relations_contain_measurement':False,'measurements_select_formal_survivors':False,'engine_prediction_sealed_before_target_release_within_run':True,'complete_reported_uncertainties_retained':True,'displayed_resolution_separately_labelled_where_no_uncertainty_is_reported':True,'earlier_hydrogen_and_proton_receipts_preserved':True}
s=s[:a]+'required='+repr(required)+'\n'+s[b:]
s=s.replace('"lamb_and_fine"','"hydrogen_ionization"').replace('"hyperfine"','"hydrogen_lines"')
a=s.index(' let fine ←');b=s.index(' let policy :=',a);s=s[:a]+s[b:]
s=s.replace('explicit frozen successor relations.','explicit frozen successor relation.')
s=s.replace('open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement\n','open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement\nset_option maxRecDepth 20000\n')
(w/'stage_hydrogenrecord955_generated.py').write_text(s);exec(compile(s,'hydrogen-record955','exec'),{})
