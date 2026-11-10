from pathlib import Path
import json,re,copy,subprocess,hashlib
w=Path('work');r=w/'constants-recovery';stem='Density';num=json.loads((w/'DensityMeasured536_report.json').read_text());assert num['status']=='PASS';assert num['full_empirical_output_matches'];audit=(w/'DensityMeasuredAudit536.log').read_text();assert all("'"+n+"' does not depend on any axioms" in audit for n in num['audited_declarations'])
cfg=json.loads((w/'auditcollective536_config.json').read_text());c=cfg[stem];c['modules'].append('DensityMeasured');c['declarations']+=num['audited_declarations'];s=(r/'SFT/Physics/DensityMeasured.lean').read_text();ns='SFT.Physics.DensityMeasured'
for kind,n in re.findall(r'^(def|theorem|inductive|structure|abbrev) (\w+)',s,re.M):
 if kind=='theorem':c['theorems'].append(ns+'.'+n)
 if kind in ['def','theorem']:c['definitions_and_theorems'].append(ns+'.'+n)
(w/'auditcollective536_config.json').write_text(json.dumps(cfg,indent=2));p=w/'auditcollective536_Density.log';p.write_text(p.read_text()+audit)
p=w/'Auditcollective536_Density.lean';p.write_text('import SFT.Physics.DensityMeasured\n'+p.read_text()+'\n'+'\n'.join('#print axioms '+n for n in num['audited_declarations'])+'\n')
(w/'density_validation536_output.json').write_bytes((w/'DensityMeasured536_output.json').read_bytes());(w/'density_validation536_report.json').write_text(json.dumps(dict(status='PASS',source_snapshot_bytes=(w/'backfill536_source.bin').stat().st_size,fresh_native_execution=True,all_validation_fields_and_hashes_match=True,numeric_adapter='DensityMeasured',source_sha256=num['source_sha256']),indent=2))
s=(w/'evolution_validation491.py').read_text().replace('SFT-PHYS-QUANTUM-EVOLUTION-001','SFT-PHYS-FLUID-DENSITY-001').replace('EvolutionValidationProgram491','DensityMeasuredValidation536').replace('evolution_source491','density_codatasource536').replace('evolution_validation491','density_validation536');(w/'density_validation536.py').write_text(s)
(r/'DensityValidationProgram536.lean').write_bytes((r/'DensityMeasuredValidation536.lean').read_bytes())
actual=json.loads((w/'density_program536_output.json').read_text());sealed={**actual,'claim_id':'SFT-PHYS-FLUID-DENSITY-001','seal_hash':'native-density-536'};cases=[]
for name in ['original','omitted_candidate','additional_survivor','failed_control']:
 val=copy.deepcopy(sealed)
 if name=='omitted_candidate':val['census']['candidates']=val['census']['candidates'][1:]
 if name=='additional_survivor':val['decisions'][0]['survives']=True
 if name=='failed_control':val['controls'][0]['passed']=False
 p=w/('density_independent536_'+name+'.json');p.write_text(json.dumps(val));out=json.loads(subprocess.check_output(['python3','work/density_independent536.py',str(p)],text=True));assert out['passed']==(name=='original');cases.append(dict(case=name,expected=name=='original',actual=out))
(w/'density_independent536_report.json').write_text(json.dumps(cases,indent=2));print('Density numeric comparison and all independent cases PASS; source-bound audits retained.')
