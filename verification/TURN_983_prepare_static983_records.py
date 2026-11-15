from pathlib import Path
import sys,json,hashlib,subprocess
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=w/'v3-runtime500';sys.path.insert(0,str(root.resolve()));from sft.physics import static_exterior_clock_terminal_validation_v1 as src
q=json.dumps
def val(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,(list,tuple)):return '.array ['+','.join(map(val,x))+']'
 return '.object ['+','.join('('+q(k)+','+val(v)+')' for k,v in x.items())+']'
for rel,h in src.source_hashes().items():
 data=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+rel]);assert 'sha256:'+hashlib.sha256(data).hexdigest()==h;p=root/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(data)
s='''import SFT.Physics.StaticExteriorClockEvidence
import SFT.Physics.PostNewtonianRecords
namespace SFT.Physics.StaticRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
open PostNewtonianRecords (getDefault requiredFields fileBytes)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
'''
s+='def sourceId : String := '+q(src.SOURCE_ID)+'\ndef sourcePath : String := '+q(src.SOURCE_RECORD_PATH)+'\ndef sourceHash : String := '+q(src.SOURCE_RECORD_HASH)+'\ndef sourceHashes : List (String × String) := ['+','.join('('+q(k)+','+q(v)+')' for k,v in src.source_hashes().items())+']\ndef requiredKeys : List String := '+q(list(src.REQUIRED_TARGET_ROWS))+'\n'
for name,values in [('historicalAnchors',dict(v1_source_entry='D9o',v1_exterior_coefficient='One-take-horizon-radius-over-radius',v1_horizon_radius='two-G-M-over-c-squared')),('theoryAnchors',dict(external_time_coefficient='One-take-two-G-M-over-radius',external_horizon_radius='two-m-equals-two-G-M-over-c-squared',external_spherical_vacuum_radiation='absent')),('nistAnchors',dict(zip(['nist_predicted_fractional_gradient_per_mm','nist_full_cloud_corrected_gradient_per_mm','nist_split_cloud_corrected_gradient_per_mm','nist_fractional_frequency_uncertainty'],['-1.09e-19','-9.8(2.3)e-20','-1.28(27)e-19','7.6e-21']))),('scopeAnchors',dict(nist_measures_universal_Fold_clock_fraction=False,completed_infinity_used_in_v3=False,irrational_clock_rate_used_in_v3=False,measured_parameter_fitted_into_v3=False)),('requiredCustody',dict(formal_claim_contains_historical_or_external_target_values=False,target_inaccessible_during_prediction_execution=True,prediction_sealed_before_target_release_within_run=True,all_historical_prerequisite_theory_measurement_and_scope_rows_retained=True,targets_select_formal_survivor=False))]:s+='def '+name+' : Value := '+val(values)+'\n'
claims=[(getattr(src,n+'_PATH'),'SFT-PHYS-'+c) for n,c in [('WEAK','GRAVITY-WEAK-FIELD-FLUX-003'),('CLOCK','GRAVITY-STATIC-CLOCK-003'),('HORIZON','GRAVITY-STRONG-FIELD-HORIZON-003'),('REDSHIFT','GRAVITY-REDSHIFT-EQUIVALENCE-003'),('MEASURED','VALIDATION-GRAVITY-CLOCK-EQUIVALENCE-003')]]
s+='def prerequisiteClaims : List (String × String) := ['+','.join('('+q(k)+','+q(v)+')' for k,v in claims)+']\n'
s+='''def payloadBoundary (record : Value) : Except String Value := do
 let target := getDefault record "registered_target" (.object [])
 let keys ← match target with
  | .object fields => .ok (fields.map Prod.fst)
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "D9o target record changed"
 if !sameValue (getDefault record "source_id") (.text sourceId) || (← array (getDefault record "snapshots" (.array []))).length != 9 || keys.length != 34 || !(keys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)==requiredKeys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)) then throw "D9o target record changed"
 if !requiredFields target historicalAnchors then throw "D9o historical relation changed"
 if !requiredFields target theoryAnchors then throw "D9o theory relation changed"
 if !requiredFields target nistAnchors then throw "D9o NIST values changed"
 if !requiredFields target scopeAnchors then throw "D9o scope row changed"
 pure record
def historicalBoundary (v1 prerequisites : Value) : Except String Unit := do
 let rows ← array (← field v1 "rows")
 let row ← match rows.find? (fun item => sameValue (getDefault item "v1_claim_id") (.text "D9o")) with
  | none => .error "StopIteration"
  | some item => .ok item
 let observation ← text (← field row "prior_result_observation")
 if !(["A(r)=take(ONE,ratio(rs,r))","r^2*dA/dr constant (=rs)","rs=2GM/c^2"].all (Text.contains observation)) then throw "D9o V1 row changed"
 let _ ← prerequisiteClaims.mapM (fun (relative,claim) => do
  let record ← field prerequisites relative
  if !sameValue (getDefault record "claim_id") (.text claim) then throw "D9o prerequisite changed"
  pure ())
 pure ()
def custodyBoundary (record : Value) : Except String Value := do
 if !requiredFields (getDefault record "custody" (.object [])) requiredCustody then throw "D9o custody changed"
 pure record
def authoritativeRecord (files : List (String × ByteArray)) (payload v1 prerequisites : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "D9o source changed: " relative)
  pure ())
 let record ← payloadBoundary payload
 let _ ← historicalBoundary v1 prerequisites
 custodyBoundary record
end SFT.Physics.StaticRecords
'''
for c in [r,w/'constants-recovery']:(c/'SFT/Physics/StaticRecords.lean').write_text(s)
record=src.experiment_registration_record();record['prediction_program']='DYNAMIC_DOCUMENT';literal=val(record).replace('.text "DYNAMIC_DOCUMENT"','document');s=(r/'SFT/Physics/SymmetricExperiment.lean').read_text().replace('Symmetric','Static');a=s.index('def targetIds');b=s.index('def releasedTargets');s=s[:a]+'def targetIds : List String := '+q(list(src.TARGET_IDS))+'\ndef frozenRelation : String := '+q(record['frozen_relation'])+'\ndef falsification : String := '+q(src.FALSIFICATION_CONDITION)+'\ndef registrationRecord : Except String Value := do\n let document ← predictionProgramDocument\n pure ('+literal+')\n'+s[b:];s=s.replace('D9N-WITHHELD-HISTORICAL-THEORY-AND-GW-RECORD',src.TARGET_IDS[0])
for c in [r,w/'constants-recovery']:(c/'SFT/Physics/StaticExperiment.lean').write_text(s)
print('Ten original source identities and34orderedtargetguards prepared')
