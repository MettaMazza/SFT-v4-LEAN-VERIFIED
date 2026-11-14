from pathlib import Path
import subprocess,json
w=Path('work');rt=w/'v3-runtime500';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
def stage(rel):
 b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+rel]);p=rt/rel;p.parent.mkdir(parents=True,exist_ok=True)
 if p.exists():assert p.read_bytes()==b
 else:p.write_bytes(b)
 return b
stage('sft/physics/molecular_spectroscopy_successor_validation_v1.py');record=json.loads(stage('experiments/external_sources/physics/snapshots/molecular-spectroscopy-successor-source-record.json'))
for row in record['sources'].values():stage(row['snapshot_path'])
s=(w/'stage_terminalanomalyrecord942.py').read_text().replace('matter_flavour_terminal_anomaly_validation_v1','molecular_spectroscopy_successor_validation_v1').replace('terminalanomaly942_original_record.json','molecular954_original_record.json').replace('TerminalAnomalyRecords','MolecularSpectroscopyRecords')
a=s.index('required=');b=s.index("s+=''.join",a);required={'development_targets_already_known':True,'classification':'observational_derivation','protocol_classification':'observational-data-informed_target-inaccessible_sealed-prediction','empirical_prediction_protocol':True,'target_inaccessible_during_prediction_execution':True,'formal_relations_contain_measurement':False,'measurements_select_formal_survivors':False,'engine_prediction_sealed_before_target_release_within_run':True,'reported_digits_retained_without_reinterpretation':True,'last_inscribed_digit_enclosures_are_comparison_resolutions_not_reported_uncertainties':True,'earlier_leading_and_adverse_receipts_preserved':True};s=s[:a]+'required='+repr(required)+'\n'+s[b:]
s=s.replace('"electron"','"hydrogen"').replace('"muon"','"deuterium"').replace('terminal anomaly custody disclosure changed','molecular spectroscopy custody disclosure changed').replace('terminal anomaly source set changed','molecular spectroscopy source set changed').replace('terminal anomaly source record identity changed','molecular spectroscopy source record identity changed').replace('(Text.append (Text.append "terminal " pair.1) " anomaly source identity changed")','(Text.append "molecular spectroscopy component identity changed: " pair.1)')
s=s.replace(' pure record\n',''' let policy := (field payload "comparison_policy").toOption.getD (.object [])
 if !sameValue ((field policy "provenance").toOption.getD .null) (.text "Observation informed the explicit frozen successor relations. The executable law module contains none of these values and cannot open this record. Complete grammar enumeration, unique selection and sealing precede target release.") then
  throw "molecular spectroscopy provenance disclosure changed"
 let predecessor := (field payload "predecessor_disposition").toOption.getD (.object [])
 if !sameValue ((field predecessor "immutable_leading_claim").toOption.getD .null) (.text "SFT-PHYS-MOLECULAR-SPECTRUM-HIERARCHY-004") then
  throw "molecular spectroscopy predecessor identity changed"
 pure record
''')
(w/'stage_molecularrecord954_generated.py').write_text(s);exec(compile(s,'original-molecular-record','exec'),{})
