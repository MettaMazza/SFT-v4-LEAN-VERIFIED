from pathlib import Path
import os,subprocess,json,hashlib
w=Path('work');r=w/'turn1064_recovery';tc=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0';env=dict(os.environ,LEAN_PATH=':'.join([str(tc/'lib/lean'),str(r.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean']))
with(w/'conformerpopulation1495_cases_output.json').open('w')as out,(w/'conformerpopulation1495_cases_execution.log').open('w')as err:
 subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192','--run','work/ConformerPopulationCases1495.lean'],env=env,stdout=out,stderr=err,check=True)
a=json.loads((w/'conformerpopulation1495_cases_output.json').read_text());b=json.loads((w/'conformerpopulation1495_cases_expected.json').read_text());assert a==b,[(x['case'],x,y)for x,y in zip(a,b)if x!=y]
(w/'conformerpopulation1495_cases_comparison_report.json').write_text(json.dumps({'status':'PASS','cases':len(a),'all_fields_match':True,'source_sha256':{'ConformerPopulation':hashlib.sha256((r/'SFT/Chemistry/ConformerPopulation.lean').read_bytes()).hexdigest()}},indent=2)+'\n');print('PASS',len(a),'fresh original cases')
