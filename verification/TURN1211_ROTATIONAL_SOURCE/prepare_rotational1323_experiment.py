from pathlib import Path
import sys,json
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__=[str((w/'pinned1323/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import rotational_constant_batch_v1 as batch
from sft.chemistry.rotational_constant_validation_v1 import prediction_program_document,experiment_registration_record
spec=batch.ROTATIONAL_CONSTANT_SPEC;q=lambda x:json.dumps(x,ensure_ascii=False)
s=(w/'turn1064_recovery/SFT/Chemistry/VibrationalFrequencyExperiment.lean').read_text().replace('VibrationalFrequency','RotationalConstant').replace('PROP-009','PROP-010').replace('vibrational-frequency','rotational-constant').replace('vibrational_frequency','rotational_constant').replace('frequency_inscription_cm_inverse','rotational_constant_inscription_cm_inverse').replace('exact_positive_recurrence_ratio_per_centimeter','exact_positive_axis_recurrence_ratio_per_centimeter').replace('all_frequency_values_absent','all_rotational_constant_values_absent').replace('complete_displayed_molecule_count','complete_displayed_molecular_row_count').replace('(.integer 145)','(.integer 1005)').replace('2009','3015').replace('all_3015_frequency','all_3015_rotational').replace('value-free-complete-displayed-vector','value-free-complete-axis-vector')
a=s.index('def claimId');b=s.index('def identities',a);literals=[('claimId',spec.claim_id),('experimentId',spec.experiment_id),('frozenRelation',spec.exact_result),('falsification',spec.falsification_condition)]
for name,const in [('identity','IDENTITY'),('target','TARGET'),('snapshot','SNAPSHOT'),('primary','PRIMARY'),('listSnapshot','LIST_SNAPSHOT'),('choiceSnapshot','CHOICE_SNAPSHOT')]:literals.extend([(name+'Path',getattr(batch,const+'_PATH')),(name+'Hash',getattr(batch,const+'_HASH'))])
s=s[:a]+''.join('def '+n+' : String := '+q(v)+'\n'for n,v in literals)+'def targetIds : List String := ['+','.join(q(x.target_id)for x in spec.target_rows)+']\n'+s[b:]
a=s.index('def identityFields');b=s.index('def predictionProgramDocument',a)
fields=[('name','molecular-name'),('species','molecular-species'),('external_charge_inscription','external-charge-inscription'),('axis_label','rotational-axis'),('measurement_kind','measurement-kind'),('measurement_unit','measurement-unit'),('source_id','source-identity'),('source_locator','source-locator')]
s=s[:a]+'def identityFields : List (String × String) := ['+','.join('('+q(k)+','+q(v)+')'for k,v in fields)+']\n'+'''def rowInstructions (row : Value) (ordinal : Nat) : Except String (List Value × List String) := do
 let rowPrefix := Text.append "rotational-constant-axis-" (toString ordinal)
 let target ← field row "target_id" >>= text
 let labeled ← identityFields.zipIdx.mapM fun ((key,family),index) => do
  let value ← field row key >>= text
  let destination := Text.intercalate "" [rowPrefix,"-label-",toString (index+1)]
  pure (instruction "label" destination [family,value],destination)
 let counted ← ["displayed_molecular_row","displayed_axis_ordinal"].zipIdx.mapM fun (key,index) => do
  let value ← field row key >>= JointCorrelationTargets.integer
  let destination := Text.intercalate "" [rowPrefix,"-count-",toString (index+1)]
  pure (instruction "count" destination [toString value],destination)
 let laws := [("source-uncertainty-status","source-row-does-not-display-uncertainty"),
 ("geometry-law","finite-generated-molecular-geometry-with-held-axis"),
 ("rotational-constant-law","positive-axis-recurrence-count-over-positive-interval-count"),
 ("rotational-ladder-law","positive-JJplusOne-level-with-adjacent-2J-gap"),
 ("measurement-absence-law","blank-axis-cell-is-structural-EmptyOne")]
 let lawRows := laws.zipIdx.map fun ((family,label),index) =>
  let destination := Text.intercalate "" [rowPrefix,"-law-",toString (11+index)]
  (instruction "label" destination [family,label],destination)
 let registers := ["premise"] ++ labeled.map Prod.snd ++ counted.map Prod.snd ++ lawRows.map Prod.snd
 pure ([instruction "label" (Text.append rowPrefix "-target") ["target-id",target]] ++ labeled.map Prod.fst ++
  counted.map Prod.fst ++ lawRows.map Prod.fst ++ [instruction "word" (Text.append rowPrefix "-word") registers],
  [Text.append rowPrefix "-target",Text.append rowPrefix "-word"])
'''+s[b:]
s=s.replace('("source_snapshot",.array [.text snapshotPath,.text snapshotHash]),','''("complete_species_list_snapshot",.array [.text listSnapshotPath,.text listSnapshotHash]),
 ("complete_choice_snapshot",.array [.text choiceSnapshotPath,.text choiceSnapshotHash]),
 ("complete_result_snapshot",.array [.text snapshotPath,.text snapshotHash]),''')
a=s.index('def expectedLabel');b=s.index('def distinct',a);raw=json.load(open(w/'rotational1323_spec.json'));dim='['+','.join('('+q(d['key'])+',['+','.join('('+q(o['name'])+','+str(o['admitted']).lower()+')'for o in d['choices'])+'])'for d in raw['dimensions'])+']'
s=s[:a]+'def expectedLabel : String := '+q(spec.expected_observation_label)+'\ndef dimensions : List (String × List (String × Bool)) := '+dim+'\ndef snapshotHashes : List String := ['+','.join(q(x.snapshot_hash)for x in spec.target_rows)+']\n'+s[b:]
(w/'turn1064_recovery/SFT/Chemistry/RotationalConstantExperiment.lean').write_text(s)
expected={'program':prediction_program_document(w/'pinned1323'),'registration':experiment_registration_record(w/'pinned1323')};(w/'rotational1323_experiment_expected.json').write_text(json.dumps(expected,indent=2)+'\n');print(len(expected['program']['instructions']),'instructions;',len(expected['registration']),'registration fields')
