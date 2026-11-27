from pathlib import Path
import os,subprocess,json,hashlib
w=Path('work');r=w/'turn1064_recovery';tc=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0';env=dict(os.environ,LEAN_PATH=':'.join([str(tc/'lib/lean'),str(r.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean']))
with(w/'nucleophilic1497_path_cases_output.json').open('w')as out,(w/'nucleophilic1497_path_cases_execution.log').open('w')as err:subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192','--run','work/NucleophilicPathCases1497.lean'],env=env,stdout=out,stderr=err,check=True)
a=json.loads((w/'nucleophilic1497_path_cases_output.json').read_text());b=json.loads((w/'nucleophilic1497_path_cases_expected.json').read_text());assert a==b
p={'status':'PASS','rejection_cases':7,'all_original_error_messages_match':True,'source_sha256':{m:hashlib.sha256((r/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest()for m in ['NucleophilicCarrier','NucleophilicPath','NucleophilicWitnesses']}};(w/'nucleophilic1497_path_cases_report.json').write_text(json.dumps(p,indent=2)+'\n');print('PASS seven original path/extension rejection cases')
