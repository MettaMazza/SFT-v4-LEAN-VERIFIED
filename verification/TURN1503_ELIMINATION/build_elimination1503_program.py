from pathlib import Path
import os,json,subprocess,ast
w=Path('work');r=w/'turn1064_recovery';tc=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0';env=dict(os.environ,LEAN_PATH=':'.join([str(tc/'lib/lean'),str(r.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean']))
for m in ['Elimination','EliminationGrammar','EliminationEvidence']:
 p=r/'SFT/Chemistry'/f'{m}.lean'
 with(w/(m+'1503_build.log')).open('w')as log:subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192','-o',str(p.with_suffix('.olean')),str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
s=(w/'prepare_addition1501_program_native.py').read_text().replace('addition1501','elimination1503').replace('AdditionProgram1501','EliminationProgram1503').replace('SFT.Chemistry.AdditionEvidence','SFT.Chemistry.EliminationEvidence')
node=next(n for n in ast.walk(ast.parse(s))if isinstance(n,ast.For)and isinstance(n.target,ast.Name)and n.target.id=='receipt_name');old=ast.get_source_segment(s,node.iter);extra=ast.literal_eval(old)+['addition1501_program_native_build.json','addition1502_validation_native_build.json'];s=s[:s.index(old)]+repr(extra)+s[s.index(old)+len(old):]
(w/'prepare_elimination1503_program_native.py').write_text(s)
(w/'EliminationProgram1503.lean').write_text((w/'AdditionProgram1501.lean').read_text().replace('Addition','Elimination'))
subprocess.run(['python3','work/prepare_elimination1503_program_native.py'],check=True)
expected=json.load(open(w/'elimination1503_original_program.json'));source=expected['registration']['source_hash']
with(w/'elimination1503_program_output.log').open('w')as out:subprocess.run(['python3','work/prepare_elimination1503_program_native.py','--execute',source],stdout=out,stderr=subprocess.STDOUT,check=True)
actual=next(json.loads(x)for x in(w/'elimination1503_program_output.log').read_text().splitlines()if x.startswith('{')and'"registration"'in x);assert actual==expected
(w/'elimination1503_program_output.json').write_text(json.dumps(actual,indent=2)+'\n');(w/'elimination1503_program_report.json').write_text(json.dumps({'status':'PASS','candidates':256,'all_original_decisions_registration_closure_controls_and_unknown_id_match':True},indent=2)+'\n');print('PASS full256candidate programme')
