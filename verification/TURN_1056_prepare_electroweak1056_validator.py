from pathlib import Path
import ast,json
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work');tag='ElectroweakMeasured';record=json.load(open(w/'weakobservation1056_record.json'));keys=list(record['registered_target']);q=json.dumps
s='''import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ElectroweakMeasuredAnalysis
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.ElectroweakMeasuredMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement ElectroweakMeasuredAnalysis
-- Decoder for the hash-bound original source record and its two declared controls.
-- General converted-Fraction analysis remains exactAnalysis, over arbitrary Rat inputs.
def originalRecordTarget (v : Value) : Except String Target := do
'''
for i,k in enumerate(keys[:8]):s+=' let q'+str(i)+' ← decimalField v '+q(k)+'\n'
s+=' .ok ⟨'+','.join('q'+str(i)for i in range(8))+','+','.join('ThermometryMeasurement.literalBoolean (PostNewtonianRecords.getDefault v '+q(k)+') true' for k in keys[8:])+'⟩\n'
s+='''def ratio (v : Rat) : Value := .object [("__fraction__",.array [.integer v.num,.integer (.ofNat v.den)])]
def pair (v : Rat × Rat) : Value := .array [ratio v.1,ratio v.2]
def analysisValue (a : Analysis) : Value := .object [
 ("direct_on_shell_interval",pair a.directOnShellInterval),
 ("compatible_WZ_squared_interval",pair a.compatibleWZSquaredInterval),
 ("all_input_WZ_squared_method_record",pair a.allInputWZSquaredMethodRecord),
 ("forced_sine_inside_direct_interval",.boolean a.forcedSineInsideDirectInterval),
 ("forced_cosine_inside_compatible_WZ_interval",.boolean a.forcedCosineInsideCompatibleWZInterval),
 ("exact_partition",.boolean a.exactPartition),
 ("incompatible_input_disclosure_retained",.boolean a.incompatibleInputDisclosureRetained),
 ("poor_consistency_disclosure_retained",.boolean a.poorConsistencyDisclosureRetained),
 ("inconsistent_aggregate_not_used_as_target",.boolean a.inconsistentAggregateNotUsedAsTarget),
 ("all_source_rows_retained",.boolean a.allSourceRowsRetained)]
def exactElectroweakAnalysis (v : Value) : Except String Value := do
 .ok (analysisValue (← exactAnalysis (← originalRecordTarget v)))
end SFT.Physics.ElectroweakMeasuredMeasurement
'''
# Follow the project's already established canonical Fraction serialization.
s=s.replace('def ratio (v : Rat) : Value := .object [("__fraction__",.array [.integer v.num,.integer (.ofNat v.den)])]','def ratio := RunningConvergenceCertificate.rat')
(r/f'SFT/Physics/{tag}Measurement.lean').write_text(s)
s=(w/f'constants-recovery/SFT/Physics/{tag}Experiment.lean').read_text();s=s[:s.index('def sourceMatches')];s=s.replace('import SFT.Physics.'+tag+'Evidence','import SFT.Physics.'+tag+'Evidence\nimport SFT.Physics.'+tag+'Records');tail=(r/'SFT/Physics/QuantumSupportObservationExperiment.lean').read_text();tail=tail[tail.index('def targetIds'):].replace('QuantumSupportObservation',tag).replace('NATURE-STORZ-2023-WITHHELD-COMPLETE-BELL-RECORD','PDG-ELECTROWEAK-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD').replace('targetRows.length=5','targetRows.length=2');(r/f'SFT/Physics/{tag}Experiment.lean').write_text(s+tail)
s=(r/'SFT/Physics/QuantumSupportObservationValidation.lean').read_text().replace('QuantumSupportObservation',tag).replace('QUANTUM-SUPPORT-UNCERTAINTY-050','ELECTROWEAK-MEASURED-VALUE-053').replace('quantum-support Bell','electroweak successor').replace('exact-quantum-support-Bell-comparator/1','exact-electroweak-measured-value-successor/1').replace('exactQuantumSupportBellAnalysis','exactElectroweakAnalysis').replace('yes "all_rows_retained"','yes "all_source_rows_retained"')
a=s.index(' let empirical :=');b=s.index(' let targetIdentity',a)
s=s[:a]+''' let empirical := yes "forced_sine_inside_direct_interval" && yes "forced_cosine_inside_compatible_WZ_interval" && yes "exact_partition" && yes "incompatible_input_disclosure_retained" && yes "poor_consistency_disclosure_retained" && yes "inconsistent_aggregate_not_used_as_target" && yes "all_source_rows_retained"
 let tamperedDirect := replaceField target "on_shell_sin_squared_center" (.text "0.22000")
 let directAnalysis ← ElectroweakMeasuredMeasurement.exactElectroweakAnalysis tamperedDirect
 let directRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault directAnalysis "forced_sine_inside_direct_interval")
 let tamperedW := replaceField target "compatible_w_mass_GeV" (.text "81")
 let wAnalysis ← ElectroweakMeasuredMeasurement.exactElectroweakAnalysis tamperedW
 let wRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault wAnalysis "forced_cosine_inside_compatible_WZ_interval")
 let passed := formal && empirical && directRejected && wRejected
'''+s[b:]
a=s.index(' let comparison :');b=s.index(' let measurements :=',a)
s=s[:a]+''' let comparison : Value := .object [("seal",.text derivationSeal),("sources",hashes),("target",.text targetIdentity),("analysis",analysis),("tampered_direct_rejected",.boolean directRejected),("tampered_w_rejected",.boolean wRejected)]
'''+s[b:]
vt=ast.parse((w/'weakobservation1056_validation.py').read_text());n=next(n for n in ast.walk(vt)if isinstance(n,ast.Assign)and any(isinstance(t,ast.Name)and t.id=='measurements'for t in n.targets));a=s.index(' let measurements :=');b=s.index(' pure ⟨',a);s=s[:a]+' let measurements := '+q(ast.literal_eval(n.value))+'\n'+s[b:];(r/f'SFT/Physics/{tag}Validation.lean').write_text(s)
