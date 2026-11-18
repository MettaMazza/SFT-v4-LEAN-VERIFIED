from pathlib import Path
import json,re
w=Path('work');r=w/'turn1064_recovery'
modules=['MolecularMeasurement','MolecularMeasurementGrammar','MolecularMeasurementEvidence','MolecularMeasurementSource','MolecularMeasurementAnalysis','MolecularMeasurementExperiment','MolecularMeasurementValidation']
names=[f'SFT.Chemistry.{m}.{n}'for m in modules for n in re.findall(r'^(?:def|theorem)\s+(\w+)',(r/'SFT/Chemistry'/f'{m}.lean').read_text(),re.M)]
scopes={
'MolecularMeasurement':('sft/chemistry/molecular_measurement_law_v1.py:MolecularObservationMap/__post_init__/reconstructs/_witnesses; molecular_measurement_batch_v1.py:induction_base/induction_step','Exact eight fields; six held-family guards; nonempty retained word; retained/closed family and overlap guards; reconstruction by retained label membership; original three witnesses; accepted-record preservation and observation-history base/successor.'),
'MolecularMeasurementGrammar':('sft/chemistry/molecular_measurement_law_v1.py:DIMENSIONS; molecular_measurement_batch_v1.py:MOLECULAR_MEASUREMENT_SPEC','All eight original axes and256literal alternatives,all original decisions,exhaustiveness and unique surviving form.'),
'MolecularMeasurementEvidence':('sft/chemistry/generated_observational_law.py','Exact registration,census,all decisions,closure and original controls bound to three executed witnesses.'),
'MolecularMeasurementSource':('sft/chemistry/molecular_measurement_validation_v1.py:_rows','Exact two registry hashes,nine component hashes,metadata hash,330identity/target rows,target dictionary,row ordinals,CSV header and cell reconstruction; preserved registered bytes.'),
'MolecularMeasurementAnalysis':('sft/chemistry/molecular_measurement_validation_v1.py:MolecularMeasurementValidator.validate','All330row comparisons and15counts,including172positive entry/exit intervals,70positive tracking durations andone retained zero-duration boundary.'),
'MolecularMeasurementExperiment':('sft/chemistry/molecular_measurement_validation_v1.py:prediction_program_document/experiment_registration_record','Original eight-field prediction,registration,330target references,exact source identities and input envelope.'),
'MolecularMeasurementValidation':('sft/chemistry/molecular_measurement_validation_v1.py:MolecularMeasurementValidator.validate','Complete capability-closed execution,sealing,custody,isolation,original five adverse checks and12field345message empirical receipt.')}
(w/'quantum1235_scopes.json').write_text(json.dumps(scopes,indent=2)+'\n')
s=(w/'register_resolved1164.py').read_text().replace('resolved1164','quantum1235').replace('TURN1164_RESOLVED','TURN1235_QUANTUM').replace('TURN1164','TURN1235').replace('SFT-CHEM-RESOLVED-ROVIBRONIC-SPIN-COMPOSITION-013','SFT-CHEM-MOLECULAR-QUANTUM-MEASUREMENT-REDUCTION-014').replace('==129','=='+str(len(names))).replace('+129','+'+str(len(names)))
a=s.index(';scopes=');b=s.index('\noldNames=',a);s=s[:a]+';scopes='+repr(scopes)+s[b:]
s=s.replace('original_target_rows=95','original_target_rows=330').replace('measurement_messages=107','measurement_messages=345').replace('12field107message','12field345message').replace('complete95row1235cell reconstruction','complete330row796cell reconstruction')
a=s.index("with(r/'ZENODO_PAPER_DRAFT.txt').open('a')");b=s.index('\nnextId=',a)
s=s[:a]+'''with(r/'ZENODO_PAPER_DRAFT.txt').open('a')as f:f.write('\\nMolecular quantum measurement reduction is complete. All '''+str(len(names))+''' audited declarations have empty axiom dependencies. All 256 original candidate decisions and every programme field match V3; the independent validator accepts the original record and rejects all three adverse cases. All 330 rows,796 cells,15 counts and all12 fields345 messages of the empirical receipt agree. Completion receipt: '+receipt+'. Timeline TURN1235.\\n')
with(r/'TIMELINE.txt').open('a')as f:f.write('\\nTURN1235 registration — '+now+' — Molecular quantum measurement reduction complete at '+str(newCount)+'. Original constructor/reconstruction cases,''' + str(len(names))+''' empty-axiom declarations,full256programme,three independent adverse cases and12field345message empirical comparison passed. Source hashes and dependencies checked;updated count,correspondence,paper andtimeline.\\n')
'''+s[b:]
(w/'register_quantum1235.py').write_text(s)
# This audit aggregation runs only after the actual individual checks, retaining current source hashes.
a='''from pathlib import Path
import json,hashlib
w=Path('work');r=w/'turn1064_recovery';names=[];hashes={}
for file in ['quantum1235_entry_audit_report.json','quantum1235_interfaces_audit_report.json']:
 a=json.loads((w/file).read_text());assert a['status']=='PASS';names+=a['declarations']
 for m,h in a['source_sha256'].items():
  rel='SFT/Chemistry/'+m+'.lean';assert hashlib.sha256((r/rel).read_bytes()).hexdigest()==h;hashes[rel]=h
assert len(names)==len(set(names))=='''+str(len(names))+'''
(w/'quantum1235_full_audit_report.json').write_text(json.dumps(dict(status='PASS',declarations=names,source_sha256=hashes),indent=2)+'\\n')
''';(w/'aggregate_quantum1235_audit.py').write_text(a)
print('Prepared source-specific registration for',len(names),'declarations; no completion recorded')
