from pathlib import Path
import ast,json
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work')
s=(w/'constants-recovery/SFT/Physics/FizeauExperiment.lean').read_text();s=s[:s.index('def sourceMatches')];s=s.replace('import SFT.Physics.FizeauEvidence','import SFT.Physics.FizeauEvidence\nimport SFT.Physics.FizeauRecords');s+='''def targetIds : List String := ["ARXIV-1201.0501-WITHHELD-COMPLETE-FIZEAU-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← FizeauRecords.authoritativeRecord files payload
 pure [("ARXIV-1201.0501-WITHHELD-COMPLETE-FIZEAU-RECORD",← RunningConvergenceMeasurement.field record "registered_target")]
theorem completeTargetCount : targetRows.length=5 := rfl
theorem originalVaultTarget : targetIds=["ARXIV-1201.0501-WITHHELD-COMPLETE-FIZEAU-RECORD"] := rfl
end SFT.Physics.FizeauExperiment
''';(r/'SFT/Physics/FizeauExperiment.lean').write_text(s)
s=(r/'SFT/Physics/YangMillsSpectrumValidation.lean').read_text().replace('YangMillsSpectrum','Fizeau').replace('SFT-PHYS-YANG-MILLS-SINGLET-GAP-EMPIRICAL-027','SFT-PHYS-VALIDATION-VELOCITY-COMPOSITION-034').replace('exact-yang-mills-singlet-gap-spectrum-comparator/1','exact-Fizeau-velocity-composition-comparator/1').replace('wrong Yang-Mills spectrum seal','wrong Fizeau comparison seal').replace('Yang-Mills prediction package audit failed','Fizeau prediction package audit failed').replace('Yang-Mills spectrum prediction changed','Fizeau prediction label changed').replace('FizeauMeasurement.exactSpectrumAnalysis','FizeauMeasurement.exactFizeauAnalysis')
a=s.index(' let equals :=');b=s.index(' let passed :=',a)
s=s[:a]+''' let formal := FizeauWitnesses.witnesses.all FizeauWitnesses.Witness.passed
 let allRows := yes "all_limitations_retained" && yes "air_control_retained"
 let discriminator := yes "measurement_inside_complete_relativistic_systematics_bracket" && yes "relativistic_more_than_ten_times_closer" && yes "ordinary_outside_measurement_interval"
 let tampered := replaceField target "ordinary_addition_prediction_rad_s_per_m" (← field target "water_measured_slope_rad_s_per_m")
 let tamperedAnalysis ← FizeauMeasurement.exactFizeauAnalysis tampered
 let tamperedRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault tamperedAnalysis "relativistic_more_than_ten_times_closer")
'''+s[b:];s=s.replace('formal && allRows && controls && tamperedRejected','formal && allRows && discriminator && tamperedRejected').replace('("controls",.boolean controls)','("discriminator",.boolean discriminator)')
a=s.index(' let measurements :=');b=s.index(' pure ⟨',a);tree=ast.parse((w/'velocity_composition_fizeau_validation_v1.py').read_text());n=next(n for n in ast.walk(tree)if isinstance(n,ast.Assign)and any(isinstance(t,ast.Name)and t.id=='measurements'for t in n.targets));s=s[:a]+' let measurements := '+json.dumps(ast.literal_eval(n.value),ensure_ascii=False)+'\n'+s[b:];(r/'SFT/Physics/FizeauValidation.lean').write_text(s)
