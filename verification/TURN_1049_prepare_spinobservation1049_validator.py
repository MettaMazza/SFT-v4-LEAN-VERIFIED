from pathlib import Path
import ast,json,subprocess
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work');tag='SpinCondensation';tree=ast.parse((w/'spinobservation1049_empirical.py').read_text());const={}
for n in tree.body:
 if isinstance(n,ast.Assign):
  try:const[n.targets[0].id]=ast.literal_eval(n.value)
  except (ValueError,TypeError):pass
pairs=[(const['SOURCE_PATH'],const['SOURCE_HASH']),*const['SOURCE_FILES']];q=json.dumps
s=(r/'SFT/Physics/ThermometryRecords.lean').read_text().replace('Thermometry',tag).replace('thermal-equilibrium','spin-statistics').replace('complete three-source thermometry record required','complete three-source spin-statistics record required').replace('sft-v3-spin-statistics-postseal-source-record/1','sft-v3-spin-statistics-condensation-postseal-source-record/1').replace('sha256:cf536f7516eb1c85bb075500d9c1a0ebd64bdddb544878f26a27424d08de25bf','sha256:f71da5b86f99d6569a1f33dc6fc37024cc5d458b12e625c5dbc4faf3c33ccda7')
a=s.index('def sourcePath');b=s.index('def authoritativeRecord',a);s=s[:a]+'def sourcePath : String := '+q(const['SOURCE_PATH'])+'\ndef sourceHashes : List (String × String) := ['+','.join('('+q(a)+','+q(b)+')' for a,b in pairs)+']\n'+s[b:];a=s.index('def sourceIds');b=s.index('\nend ',a);s=s[:a]+'def sourceIds : List String := '+q(const['SOURCE_IDS'])+s[b:];(r/f'SFT/Physics/{tag}Records.lean').write_text(s)
for rel,_ in pairs:
 p=w/'v3-runtime500'/rel
 if not p.exists():
  p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+rel]))
s=(w/f'constants-recovery/SFT/Physics/{tag}Experiment.lean').read_text();s=s[:s.index('def sourceMatches')];s=s.replace('import SFT.Physics.'+tag+'Evidence','import SFT.Physics.'+tag+'Evidence\nimport SFT.Physics.'+tag+'Records');tail=(r/'SFT/Physics/ThermometryExperiment.lean').read_text();tail=tail[tail.index('def targetIds'):].replace('Thermometry',tag).replace('THERMAL-EQUILIBRIUM-WITHHELD-COMPLETE-RECORD','SPIN-STATISTICS-CONDENSATION-WITHHELD-COMPLETE-RECORD');(r/f'SFT/Physics/{tag}Experiment.lean').write_text(s+tail)
s=(r/'SFT/Physics/ThermometryValidation.lean').read_text().replace('Thermometry',tag).replace('THERMAL-EQUILIBRIUM-044','SPIN-STATISTICS-CONDENSATION-046').replace('thermal-equilibrium','spin-statistics').replace('exact-spin-statistics-comparator/1','exact-spin-statistics-condensation-comparator/1').replace('exactThermalAnalysis','exactSpinStatisticsAnalysis')
a=s.index(' let empirical :=');b=s.index(' let targetIdentity',a);keys=['positive_exact_carriers','bec_interval_ordered','bec_finite_population','bec_ground_measured','bec_cooling_direction','bec_transition_observed','pauli_observed','pauli_two_spin_states','pauli_reported_factor_retained','spinor_interval_contains_forced_return','spinor_one_turn_changes','spinor_two_turns_restore','all_rows_retained'];s=s[:a]+' let empirical := '+' && '.join('yes '+q(k) for k in keys)+'\n'+''' let tamperedSpinor := replaceField target "spinor_measured_return_degrees_center" (.integer 600)
 let spinorAnalysis ← SpinCondensationMeasurement.exactSpinStatisticsAnalysis tamperedSpinor
 let spinorRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault spinorAnalysis "spinor_interval_contains_forced_return")
 let tamperedBEC := replaceField target "bec_ground_share_increases_as_temperature_is_lowered" (.boolean false)
 let becAnalysis ← SpinCondensationMeasurement.exactSpinStatisticsAnalysis tamperedBEC
 let becRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault becAnalysis "bec_cooling_direction")
 let passed := formal && empirical && spinorRejected && becRejected
'''+s[b:];s=s.replace('("tampered_rejected",.boolean tamperedRejected)','("tampered_spinor_rejected",.boolean spinorRejected),("tampered_bec_rejected",.boolean becRejected)');tree=ast.parse((w/'spinobservation1049_validation.py').read_text());n=next(n for n in ast.walk(tree) if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='measurements' for t in n.targets));a=s.index(' let measurements :=');b=s.index(' pure ⟨',a);s=s[:a]+' let measurements := '+q(ast.literal_eval(n.value))+'\n'+s[b:];(r/f'SFT/Physics/{tag}Validation.lean').write_text(s)
