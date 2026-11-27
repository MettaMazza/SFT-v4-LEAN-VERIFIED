from pathlib import Path
import os,subprocess,json,hashlib
w=Path('work');r=w/'turn1064_recovery';tc=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0';env=dict(os.environ,LEAN_PATH=':'.join([str(tc/'lib/lean'),str(r.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean']))
with(w/'electrophilic1498_paths_output.json').open('w')as out,(w/'electrophilic1498_paths_execution.log').open('w')as err:subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192','--run','work/ElectrophilicPaths1498.lean'],env=env,stdout=out,stderr=err,check=True)
a=json.loads((w/'electrophilic1498_paths_output.json').read_text());b=json.loads((w/'electrophilic1498_paths_expected.json').read_text());assert a==b
p={'status':'PASS','complete_returned_objects':3,'all_nested_fields_match':True,'source_sha256':{m:hashlib.sha256((r/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest()for m in ['ElectrophilicCarrier','ElectrophilicPath','ElectrophilicWitnesses']}};(w/'electrophilic1498_paths_report.json').write_text(json.dumps(p,indent=2)+'\n');print('PASS complete original carrier and both original path objects')
