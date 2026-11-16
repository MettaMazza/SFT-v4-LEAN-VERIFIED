from pathlib import Path
import ast,json,subprocess
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work');tag='CriticalObservation';tree=ast.parse((w/'criticalobservation1051_empirical.py').read_text());const={}
for n in tree.body:
 if isinstance(n,ast.Assign):
  try:const[n.targets[0].id]=ast.literal_eval(n.value)
  except (ValueError,TypeError):pass
pairs=[(const['SOURCE_PATH'],const['SOURCE_HASH']),*const['SOURCE_FILES']];q=json.dumps
s=(r/'SFT/Physics/SpinCondensationRecords.lean').read_text().replace('SpinCondensation',tag).replace('spin-statistics','criticality/turbulence').replace('sft-v3-criticality/turbulence-condensation-postseal-source-record/1','sft-v3-criticality-universality-turbulence-postseal-source-record/1').replace('sha256:f71da5b86f99d6569a1f33dc6fc37024cc5d458b12e625c5dbc4faf3c33ccda7','sha256:0601d19640943c4b99eb8cccf061e3115c520773eac5e762bf7c5b7440339b25').replace('.length != 3','.length != 4').replace('complete three-source','complete four-source')
a=s.index('def sourcePath');b=s.index('def authoritativeRecord',a);s=s[:a]+'def sourcePath : String := '+q(const['SOURCE_PATH'])+'\ndef sourceHashes : List (String × String) := ['+','.join('('+q(a)+','+q(b)+')'for a,b in pairs)+']\n'+s[b:];a=s.index('def sourceIds');b=s.index('\nend ',a);s=s[:a]+'def sourceIds : List String := '+q(const['SOURCE_IDS'])+s[b:];(r/f'SFT/Physics/{tag}Records.lean').write_text(s)
for rel,_ in pairs:
 p=w/'v3-runtime500'/rel
 if not p.exists():
  p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+rel]))
s=(w/f'constants-recovery/SFT/Physics/{tag}Experiment.lean').read_text();s=s[:s.index('def sourceMatches')];s=s.replace('import SFT.Physics.'+tag+'Evidence','import SFT.Physics.'+tag+'Evidence\nimport SFT.Physics.'+tag+'Records');tail=(r/'SFT/Physics/SpinCondensationExperiment.lean').read_text();tail=tail[tail.index('def targetIds'):].replace('SpinCondensation',tag).replace('SPIN-STATISTICS-CONDENSATION-WITHHELD-COMPLETE-RECORD','CRITICALITY-UNIVERSALITY-TURBULENCE-WITHHELD-COMPLETE-RECORD').replace('targetRows.length=3','targetRows.length=4');(r/f'SFT/Physics/{tag}Experiment.lean').write_text(s+tail)
s=(r/'SFT/Physics/SpinCondensationValidation.lean').read_text().replace('SpinCondensation',tag).replace('SPIN-STATISTICS-CONDENSATION-046','CRITICALITY-UNIVERSALITY-TURBULENCE-048').replace('spin-statistics','criticality/turbulence').replace('exact-criticality/turbulence-condensation-comparator/1','exact-criticality-universality-turbulence-comparator/1').replace('exactSpinStatisticsAnalysis','exactCriticalityAnalysis')
tree=ast.parse((w/'criticalobservation1051_validation.py').read_text());keys=ast.literal_eval(next(n.value for n in ast.walk(tree)if isinstance(n,ast.Assign)and any(isinstance(t,ast.Name)and t.id=='empirical_keys'for t in n.targets)))
a=s.index(' let empirical :=');b=s.index(' let targetIdentity',a);s=s[:a]+' let empirical := '+' && '.join('yes '+q(k)for k in keys)+'\n'+''' let tampered := replaceField target "turbulence_measured_structure_center" (.integer 620)
 let ta ← CriticalObservationMeasurement.exactCriticalityAnalysis tampered
 let structureRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault ta "structure_interval_contains_two_thirds")
 let relabelled := replaceField target "manganite_expected_complete_vector_matches" (.array (["La00","La02","La04","La06","La08"].map Value.text))
 let ra ← CriticalObservationMeasurement.exactCriticalityAnalysis relabelled
 let relabelledRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault ra "manganite_expected_matches_exact")
 let rows ← RunningConvergenceMeasurement.array (← field target "manganite_rows")
 let removed := replaceField target "manganite_rows" (.array rows.dropLast)
 let da ← CriticalObservationMeasurement.exactCriticalityAnalysis removed
 let removedRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault da "manganite_complete_five_rows")
 let reversed := replaceField target "turbulence_spectrum_orientation" (.text "rising")
 let sa ← CriticalObservationMeasurement.exactCriticalityAnalysis reversed
 let reversedRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault sa "spectrum_falling_orientation")
 let passed := formal && empirical && structureRejected && relabelledRejected && removedRejected && reversedRejected
'''+s[b:];s=s.replace('("tampered_spinor_rejected",.boolean spinorRejected),("tampered_bec_rejected",.boolean becRejected)','("controls",.array [.boolean structureRejected,.boolean relabelledRejected,.boolean removedRejected,.boolean reversedRejected])');n=next(n for n in ast.walk(tree)if isinstance(n,ast.Assign)and any(isinstance(t,ast.Name)and t.id=='measurements'for t in n.targets));a=s.index(' let measurements :=');b=s.index(' pure ⟨',a);s=s[:a]+' let measurements := '+q(ast.literal_eval(n.value))+'\n'+s[b:];(r/f'SFT/Physics/{tag}Validation.lean').write_text(s)
