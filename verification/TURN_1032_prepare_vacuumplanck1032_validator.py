from pathlib import Path
import ast,json
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work')
s=(w/'constants-recovery/SFT/Physics/VacuumPlanckExperiment.lean').read_text();s=s[:s.index('def sourceMatches')];s=s.replace('import SFT.Physics.VacuumPlanckEvidence','import SFT.Physics.VacuumPlanckEvidence\nimport SFT.Physics.VacuumPlanckRecords');tail=(r/'SFT/Physics/FizeauExperiment.lean').read_text();tail=tail[tail.index('def targetIds'):].replace('Fizeau','VacuumPlanck').replace('ARXIV-1201.0501-WITHHELD-COMPLETE-FIZEAU-RECORD','PLANCK-CODATA-WITHHELD-COMPLETE-VACUUM-SCALE-RECORD');s+=tail;(r/'SFT/Physics/VacuumPlanckExperiment.lean').write_text(s)
s=(r/'SFT/Physics/FizeauValidation.lean').read_text().replace('Fizeau','VacuumPlanck').replace('SFT-PHYS-VALIDATION-VELOCITY-COMPOSITION-034','SFT-PHYS-VALIDATION-VACUUM-DENSITY-SCALE-036').replace('exact-VacuumPlanck-velocity-composition-comparator/1','exact-vacuum-density-Planck-comparator/1').replace('wrong VacuumPlanck comparison seal','wrong vacuum-density comparison seal').replace('VacuumPlanck prediction package audit failed','vacuum-density prediction package audit failed').replace('VacuumPlanck prediction label changed','vacuum-density prediction label changed').replace('exactVacuumPlanckAnalysis','exactVacuumAnalysis')
a=s.index(' let allRows :=');b=s.index(' let targetIdentity ←',a)
s=s[:a]+''' let allRows := yes "all_rows_retained"
 let empirical := yes "share_inside_interval" && yes "normalized_inside_interval" && yes "central_budget_closes" && yes "dimensional_transport_positive" && yes "local_floor_outside_global_interval" && yes "half_one_mode_mean_outside_global_interval" && yes "primary_hubble_correction_retained" && allRows
 let tampered := replaceField target "planck_vacuum_fraction_central" (.text "0.6000")
 let tamperedAnalysis ← VacuumPlanckMeasurement.exactVacuumAnalysis tampered
 let tamperedRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault tamperedAnalysis "share_inside_interval")
 let passed := formal && empirical && tamperedRejected
'''+s[b:];s=s.replace('("all_rows",.boolean allRows),("discriminator",.boolean discriminator)','("empirical",.boolean empirical)').replace('.array [.text VacuumPlanckRecords.sourceId]','.array (VacuumPlanckRecords.sourceIds.map Value.text)')
a=s.index(' let measurements :=');b=s.index(' pure ⟨',a);tree=ast.parse((w/'vacuum_density_planck_validation_v1.py').read_text());n=next(n for n in ast.walk(tree)if isinstance(n,ast.Assign)and any(isinstance(t,ast.Name)and t.id=='measurements'for t in n.targets));s=s[:a]+' let measurements := '+json.dumps(ast.literal_eval(n.value),ensure_ascii=False)+'\n'+s[b:];(r/'SFT/Physics/VacuumPlanckValidation.lean').write_text(s)
