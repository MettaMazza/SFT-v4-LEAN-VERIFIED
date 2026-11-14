from pathlib import Path
import subprocess,json,sys,re
w=Path('work');rt=w/'v3-runtime500';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
def stage(rel):
 b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+rel]);p=rt/rel;p.parent.mkdir(parents=True,exist_ok=True)
 if p.exists():assert p.read_bytes()==b
 else:p.write_bytes(b)
 return b
stage('sft/physics/atomic_precision_successor_validation_v1.py');record=json.loads(stage('experiments/external_sources/physics/snapshots/atomic-precision-successor-source-record.json'))
for row in record['sources'].values():stage(row['snapshot_path'])
s=(w/'stage_terminalanomalyrecord942.py').read_text().replace('matter_flavour_terminal_anomaly_validation_v1','atomic_precision_successor_validation_v1').replace('terminalanomaly942_original_record.json','atomicprecision951_original_record.json').replace('TerminalAnomalyRecords','AtomicPrecisionRecords')
a=s.index('required=');b=s.index("s+=''.join",a);required={'development_targets_already_known':True,'classification':'observational_derivation','protocol_classification':'observational-data-informed_target-inaccessible_sealed-prediction','empirical_prediction_protocol':True,'target_inaccessible_during_prediction_execution':True,'formal_relations_contain_measurement':False,'measurements_select_formal_survivors':False,'engine_prediction_sealed_before_target_release_within_run':True,'complete_reported_uncertainties_retained':True,'earlier_leading_receipts_preserved':True,'unfavorable_results_preserved':True};s=s[:a]+'required='+repr(required)+'\n'+s[b:]
s=s.replace('Text.equal p.1 "electron" || Text.equal p.1 "muon"','Text.equal p.1 "rydberg" || Text.equal p.1 "lamb_and_fine" || Text.equal p.1 "hyperfine"').replace('!(pairs.any (fun p => Text.equal p.1 "electron")) || !(pairs.any (fun p => Text.equal p.1 "muon"))','!(pairs.any (fun p => Text.equal p.1 "rydberg")) || !(pairs.any (fun p => Text.equal p.1 "lamb_and_fine")) || !(pairs.any (fun p => Text.equal p.1 "hyperfine"))')
s=s.replace('terminal anomaly custody disclosure changed','atomic precision custody disclosure changed').replace('terminal anomaly source set changed','atomic precision source set changed').replace('terminal anomaly source record identity changed','atomic precision source record identity changed')
# Preserve additional original checks after component identities, before returning.
needle=' pure record\n';extra=''' let fine ← field (← field (← field sources "lamb_and_fine") "rows") "direct_experimental_fine_interval"
 if !sameValue ((field fine "consensus_ritz_value_used").toOption.getD .null) (.boolean false) then
  throw "atomic fine comparison admitted a consensus Ritz selector"
 let policy := (field payload "comparison_policy").toOption.getD (.object [])
 if !sameValue ((field policy "provenance").toOption.getD .null) (.text "Observation informed the explicit frozen successor relations. The executable law module contains none of these values and cannot open this record. Complete grammar enumeration, unique selection and sealing precede target release.") then
  throw "atomic precision comparison provenance changed"
 pure record
'''
s=s.replace(needle,extra)
s=s.replace('(Text.append (Text.append "terminal " pair.1) " anomaly source identity changed")','(Text.append "atomic precision component identity changed: " pair.1)')
(w/'stage_atomicprecisionrecord951_generated.py').write_text(s);exec(compile(s,'atomic-precision-original-record','exec'),{})
print('Staged original three-component atomic precision record and custody')
