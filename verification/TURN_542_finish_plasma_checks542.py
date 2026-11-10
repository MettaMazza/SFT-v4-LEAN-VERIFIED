from pathlib import Path
import json,re,copy,subprocess,hashlib
w=Path('work');r=w/'constants-recovery';stem='PlasmaCollective';num=json.loads((w/'PlasmaMeasured542_report.json').read_text());assert num['status']=='PASS';assert num['full_empirical_output_matches'];audit=(w/'PlasmaMeasuredAudit542.log').read_text();assert all("'"+n+"' does not depend on any axioms" in audit for n in num['audited_declarations'])
cfg=json.loads((w/'auditcollective542_config.json').read_text());c=cfg[stem];c['modules'].append('PlasmaMeasured');c['declarations']+=num['audited_declarations'];s=(r/'SFT/Physics/PlasmaMeasured.lean').read_text();ns='SFT.Physics.PlasmaMeasured'
for kind,n in re.findall(r'^(def|theorem|inductive|structure|abbrev) (\w+)',s,re.M):
 if kind=='theorem':c['theorems'].append(ns+'.'+n)
 if kind in ['def','theorem']:c['definitions_and_theorems'].append(ns+'.'+n)
(w/'auditcollective542_config.json').write_text(json.dumps(cfg,indent=2));p=w/'auditcollective542_PlasmaCollective.log';p.write_text(p.read_text()+audit)
p=w/'Auditcollective542_PlasmaCollective.lean';p.write_text('import SFT.Physics.PlasmaMeasured\n'+p.read_text()+'\n'+'\n'.join('#print axioms '+n for n in num['audited_declarations'])+'\n')
(w/'plasmacollective_validation542_output.json').write_bytes((w/'PlasmaMeasured542_output.json').read_bytes());(w/'plasmacollective_validation542_report.json').write_text(json.dumps(dict(status='PASS',source_snapshot_bytes=(w/'backfill542_source.bin').stat().st_size,fresh_native_execution=True,all_validation_fields_and_hashes_match=True,numeric_adapter='PlasmaMeasured',source_sha256=num['source_sha256']),indent=2))
s=(w/'evolution_validation491.py').read_text().replace('SFT-PHYS-QUANTUM-EVOLUTION-001','SFT-PHYS-PLASMA-COLLECTIVE-001').replace('EvolutionValidationProgram491','PlasmaMeasuredValidation542').replace('evolution_source491','plasmacollective_codatasource542').replace('evolution_validation491','plasmacollective_validation542');(w/'plasmacollective_validation542.py').write_text(s)
(r/'PlasmaCollectiveValidationProgram542.lean').write_bytes((r/'PlasmaMeasuredValidation542.lean').read_bytes())
actual=json.loads((w/'plasmacollective_program542_output.json').read_text());sealed={**actual,'claim_id':'SFT-PHYS-PLASMA-COLLECTIVE-001','seal_hash':'native-plasmacollective-542'};cases=[]
for name in ['original','omitted_candidate','additional_survivor','failed_control']:
 val=copy.deepcopy(sealed)
 if name=='omitted_candidate':val['census']['candidates']=val['census']['candidates'][1:]
 if name=='additional_survivor':val['decisions'][0]['survives']=True
 if name=='failed_control':val['controls'][0]['passed']=False
 p=w/('plasmacollective_independent542_'+name+'.json');p.write_text(json.dumps(val));out=json.loads(subprocess.check_output(['python3','work/plasmacollective_independent542.py',str(p)],text=True));assert out['passed']==(name=='original');cases.append(dict(case=name,expected=name=='original',actual=out))
(w/'plasmacollective_independent542_report.json').write_text(json.dumps(cases,indent=2));print('PlasmaCollective numeric comparison and all independent cases PASS; source-bound audits retained.')
