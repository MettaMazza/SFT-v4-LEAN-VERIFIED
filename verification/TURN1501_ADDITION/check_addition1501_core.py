from pathlib import Path
import json,os,subprocess,hashlib,re
w=Path('work');r=w/'turn1064_recovery';tc=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0';env=dict(os.environ,LEAN_PATH=':'.join([str(tc/'lib/lean'),str(r.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean']))
for name,out in [('AdditionTransformCases1501','addition1501_transform_output'),('AdditionWitnessOutput1501','addition1501_witness_output')]:
 with(w/(out+'.json')).open('w')as f,(w/(out+'.log')).open('w')as e:subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192','--run',str(w/(name+'.lean'))],env=env,stdout=f,stderr=e,check=True)
assert json.load(open(w/'addition1501_transform_output.json'))==json.load(open(w/'addition1501_transform_expected.json'))
assert json.load(open(w/'addition1501_witness_output.json'))==[True]*9
mods=['AdditionCarrier','AdditionGraph','AdditionTransform','AdditionWitnesses','AdditionGrammar','AdditionEvidence'];names=[]
for m in mods:names+=['SFT.Chemistry.'+m+'.'+n for n in re.findall(r'^(?:def|theorem)\s+(\w+)',(r/'SFT/Chemistry'/(m+'.lean')).read_text(),re.M)]
a=w/'AdditionCurrentAudit1501.lean';a.write_text('\n'.join('import SFT.Chemistry.'+m for m in mods)+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n')
with(w/'addition1501_current_audit.log').open('w')as f:subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192',str(a)],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
s=(w/'addition1501_current_audit.log').read_text();assert s.count('does not depend on any axioms')==len(names);assert 'depends on axioms'not in s
out={'status':'PASS','full_original_transform_results':5,'original_rejections':6,'returned_fields':10,'computed_original_witnesses':9,'kernel_witness_equality_theorem':'pending; runtime equality is not substituted for this proof','axiom_free_declarations':len(names),'source_sha256':{m:hashlib.sha256((r/'SFT/Chemistry'/(m+'.lean')).read_bytes()).hexdigest()for m in mods},'declarations':names,'whole_entry_complete':False}
(w/'addition1501_current_report.json').write_text(json.dumps(out,indent=2)+'\n');print('PASS',len(names),'empty-axiom declarations;five complete transforms,six rejections,nine computed witnesses')
