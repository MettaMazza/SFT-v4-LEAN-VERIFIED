from pathlib import Path
import sys,json,ast,copy,subprocess,os,hashlib,re
w=Path('work');r=w/'turn1064_recovery';runtime=(w/'v3-runtime500').resolve();sys.path.insert(0,str(runtime))
from sft.chemistry import conjugated_support_validation_v1 as src
from sft.engine.canonical import canonical_value
rows=src._source_rows(runtime);ids=src._identities(runtime);primary=json.loads((runtime/src.PRIMARY_PATH).read_text());analysis=src.exact_analysis(rows,primary);payload=json.loads((w/'conjugated1079_original_payload.json').read_text());comparisons=payload['comparisons'];controls=payload['controls'];document=src.prediction_program_document(runtime);registration=src.experiment_registration_record(runtime)
method=next(n for n in ast.walk(ast.parse((w/'pinned1077/sft/chemistry/conjugated_support_validation_v1.py').read_text()))if isinstance(n,ast.FunctionDef)and n.name=='validate');expr=next(n.value for n in method.body if isinstance(n,ast.Assign)and any(isinstance(t,ast.Name)and t.id=='passed'for t in n.targets));expression=compile(ast.Expression(expr),'<original-v3-passed>','eval')
cases=[('original',comparisons,analysis,controls)]
for i,condition in enumerate(expr.values[1:-1]):
 key=ast.literal_eval(condition.slice if isinstance(condition,ast.Subscript)else condition.left.slice);changed=copy.deepcopy(analysis);v=changed[key];changed[key]=False if isinstance(v,bool)else 999 if isinstance(v,int)else ('changed',)if isinstance(v,tuple)else'changed';cases.append(('changed-'+key,comparisons,changed,controls))
changed=copy.deepcopy(comparisons);changed[0]['passed']=False;cases.append(('failed-comparison',changed,analysis,controls));changed=copy.deepcopy(controls);changed[next(iter(changed))]=False;cases.append(('failed-control',comparisons,analysis,changed))
q=lambda x:json.dumps(str(x),ensure_ascii=False)
def cv(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,(list,tuple)):return '.array ['+','.join(cv(v)for v in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')'for k,v in x.items())+']'
 raise TypeError(type(x))
def cmp(rows):return '['+','.join('⟨'+q(x['target_id'])+','+','.join(str(x[k]).lower()for k in ['identity_match','law_match','postseal_target_hash_match','passed'])+'⟩'for x in rows)+']'
def controlRows(c):return '['+','.join('('+q(k)+','+cv(v)+')'for k,v in c.items())+']'
expected=[];expressions=[]
for name,cs,a,c in cases:
 expected.append([name,eval(expression,{'all':all},{'comparisons':cs,'analysis':a,'controls':c})]);expressions.append('('+q(name)+',passed '+cmp(cs)+' ('+cv(a)+') '+controlRows(c)+')')
leanRows='['+','.join('⟨'+','.join([q(row['source_id']),q(row['custody_class']),q(row['source_record_role']),cv(row['source_outcome'])])+'⟩'for row in rows)+']';nativeIds='['+','.join('⟨'+','.join(q(row[k])for k in src.IDENTITY_KEYS)+'⟩'for row in ids)+']'
harness='''import SFT.Chemistry.ConjugatedSupportValidation
open SFT.Host SFT.Chemistry SFT.Chemistry.ConjugatedSupportControls
set_option maxRecDepth 100000
set_option maxHeartbeats 20000000
'''+ 'def rows : List ConjugatedSupportAnalysis.SourceRow := '+leanRows+'\ndef analysis : Canonical.Value := '+cv(analysis)+'\ndef nativeIdentities : List ConjugatedSupportPrediction.Identity := '+nativeIds+'\ndef tests : List (String × Except String Bool) := ['+','.join(expressions)+''']
def main : IO Unit := do
 ConjugatedSupportExperiment.validateSpec |> IO.ofExcept
 let document := ConjugatedSupportPrediction.programDocument nativeIdentities
 let cs ← IO.ofExcept (controls rows 10 analysis document)
 let outcomes ← tests.mapM (fun (name,test) => do let value ← IO.ofExcept test; pure (Canonical.Value.array [.text name,.boolean value]))
 IO.println (Canonical.render (.object [("controls",.object cs),("tests",.array outcomes),
 ("registration",ConjugatedSupportExperiment.registration document)]))
'''
p=w/'ConjugatedControlsProgram1080.lean';p.write_text(harness)
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)]
with (w/'conjugated1080_controls_output.json').open('w')as out,(w/'conjugated1080_controls_execution.log').open('w')as err:run=subprocess.run(cmd,env=env,stdout=out,stderr=err)
assert run.returncode==0,run.returncode
actual=json.loads((w/'conjugated1080_controls_output.json').read_text());assert actual['controls']==controls;assert actual['tests']==expected;assert actual['registration']==canonical_value(registration)
report=dict(status='PASS',controls=len(controls),pass_condition_cases=len(cases),registration_all_fields_match=True,all_fields_match=True,source_sha256={n:hashlib.sha256((r/'SFT/Chemistry'/(n+'.lean')).read_bytes()).hexdigest()for n in ['ConjugatedSupportExperiment','ConjugatedSupportControls']})
(w/'conjugated1080_controls_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS original11 controls,',len(cases),'pass-condition cases, complete registration and native spec admission')
