from pathlib import Path
import ast,json
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work');tag='ThermalObservation'
s=(w/'constants-recovery/SFT/Physics/ThermalObservationExperiment.lean').read_text();s=s[:s.index('def sourceMatches')];s=s.replace('import SFT.Physics.ThermalObservationEvidence','import SFT.Physics.ThermalObservationEvidence\nimport SFT.Physics.ThermalObservationRecords');tail=(r/'SFT/Physics/VacuumPlanckExperiment.lean').read_text();tail=tail[tail.index('def targetIds'):].replace('VacuumPlanck',tag).replace('PLANCK-CODATA-WITHHELD-COMPLETE-VACUUM-SCALE-RECORD','THERMAL-HISTORY-WITHHELD-COMPLETE-OBSERVATION-RECORD');s+=tail;s=s.replace("targetRows.length=5","targetRows.length=6");(r/f'SFT/Physics/{tag}Experiment.lean').write_text(s)
s=(r/'SFT/Physics/VacuumPlanckValidation.lean').read_text().replace('VacuumPlanck',tag).replace('SFT-PHYS-VALIDATION-VACUUM-DENSITY-SCALE-036','SFT-PHYS-VALIDATION-THERMAL-HISTORY-RECOMBINATION-038').replace('exact-vacuum-density-Planck-comparator/1','exact-thermal-history-comparator/1').replace('vacuum-density comparison seal','thermal-history comparison seal').replace('vacuum-density prediction package audit failed','thermal-history prediction package audit failed').replace('vacuum-density prediction label changed','thermal-history prediction label changed').replace('exactVacuumAnalysis','exactThermalAnalysis')
a=s.index(' let allRows :=');b=s.index(' let targetIdentity ←',a)
s=s[:a]+''' let allRows := yes "all_rows_retained"
 let empirical := yes "exact_one_inside_temperature_interval" && yes "exact_quarter_excluded" && yes "deuterium_positive_minor_channel" && yes "finite_positive_recombination_support" && yes "complete_seven_tt_peaks" && yes "finite_eighteen_peak_record" && yes "angular_integer_multiple_claim_rejected" && yes "freezeout_sequence_retained" && yes "analytic_quarter_label_retained" && allRows
 let tampered := replaceField target "cmb_temperature_exponent_central" (.text "1.100")
 let tamperedAnalysis ← ThermalObservationMeasurement.exactThermalAnalysis tampered
 let tamperedRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault tamperedAnalysis "exact_one_inside_temperature_interval")
 let passed := formal && empirical && tamperedRejected
'''+s[b:]
s=s.replace(',("prediction_seal",.text predictionSeal.sealHash)','').replace(',("trace",.text execution.traceHash)','')
a=s.index(' let measurements :=');b=s.index(' pure ⟨',a);tree=ast.parse((w/'thermal_history_validation_v11034.py').read_text());n=next(n for n in ast.walk(tree)if isinstance(n,ast.Assign)and any(isinstance(t,ast.Name)and t.id=='measurements'for t in n.targets));s=s[:a]+' let measurements := '+json.dumps(ast.literal_eval(n.value),ensure_ascii=False)+'\n'+s[b:];(r/f'SFT/Physics/{tag}Validation.lean').write_text(s)
