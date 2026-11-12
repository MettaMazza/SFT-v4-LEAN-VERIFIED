from pathlib import Path
import subprocess,os,json,hashlib
w=Path('work');env=os.environ.copy();env['LEAN_PATH']=str((w/'constants-recovery/.lake/build/lib/lean').resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'
r=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(w/'RotationCertificateOutputs676.lean')],capture_output=True,text=True,env=env);(w/'rotation676_certificate_outputs.tsv').write_text(r.stdout);r.check_returncode()
ns={'__name__':'source_loader'};exec((w/'matcubic_spec673.py').read_text(),ns);src=ns['namespace'];expected=src['rotation_factor_certificate']();actual=dict(line.split('\t',1) for line in r.stdout.splitlines());assert set(actual)==set(expected)
for k,v in expected.items():
 if k in ['degree_boundary','least_excluded']:assert int(actual[k])==v.value
 elif k=='survivors':assert tuple(map(int,actual[k].split(',')))==v
 elif k=='exponent_constraints':assert tuple(actual[k].split('|'))==v
 else:assert actual[k]==v
previous=json.loads((w/'rotation675_comparison.json').read_text());retained=w/'constants-recovery'
for path,digest in previous['modules'].items():assert hashlib.sha256((retained/path).read_bytes()).hexdigest()==digest
assert hashlib.sha256(ns['raw']('sft/materials/structural_counts.py').encode()).hexdigest()==previous['source_sha256']
config=json.loads((w/'rotation676_config.json').read_text());audit=(w/'rotation676_repair_audit.log').read_text();assert audit.count('does not depend on any axioms')==len(config['declarations']);assert 'depends on axioms:' not in audit
report={'source_pin':ns['pin'],'source_operation':'sft/materials/structural_counts.py: _positive_prime_factors, totient_count, allowed_crystallographic_orders, rotation_factor_certificate','certificate_fields_compared':list(actual),'fresh_certificate_execution':'PASS','reused_checks':{'receipt':'TURN_675_rotation675_comparison.json','inputs_unchanged':True,'factor_cases':65,'totient_cases':64},'declarations':config['declarations'],'axiom_dependencies':[],'modules':{f'SFT/Materials/{m}.lean':hashlib.sha256((retained/f'SFT/Materials/{m}.lean').read_bytes()).hexdigest() for m in config['modules']},'entry_complete':False,'remaining':'Source factor-degree divisibility and exponent classification; original entry grammar/controls/validator binding.'}
(w/'rotation676_comparison.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS: all six original certificate fields; 30 declarations axiom-free; unchanged prior checks retained')
