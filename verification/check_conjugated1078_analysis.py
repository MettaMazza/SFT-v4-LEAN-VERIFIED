from pathlib import Path
import json,sys,copy,subprocess,os,hashlib,re
w=Path('work');r=w/'turn1064_recovery';runtime=(w/'v3-runtime500').resolve();sys.path.insert(0,str(runtime))
from sft.chemistry import conjugated_support_validation_v1 as src
from sft.engine.canonical import canonical_value
rows=src._source_rows(runtime);primary=json.loads((runtime/src.PRIMARY_PATH).read_text());cases=[('original',rows,primary),('omitted',rows[:-1],primary)]
for role in ['complete-conjugated-bond-and-coordinate-surface','complete-separated-double-bond-control-coordinate-surface','complete-conjugated-molecular-identity-surface','complete-uv-visible-jcamp-point-surface']:
 altered=copy.deepcopy(list(rows));index=next(i for i,x in enumerate(altered)if x['source_record_role']==role);altered[index]['source_record_role']='removed';cases.append(('missing-'+role,tuple(altered),primary))
 altered=copy.deepcopy(list(rows));other=next(i for i,x in enumerate(altered)if x['source_record_role']!=role);altered[other]['source_record_role']=role;cases.append(('duplicated-'+role,tuple(altered),primary))
altered=copy.deepcopy(list(rows));altered[1]['source_id']=altered[0]['source_id'];cases.append(('shared-source',tuple(altered),primary))
altered=copy.deepcopy(list(rows));altered[0]['custody_class']='new-identity-only-unopened-source';cases.append(('custody-substring',tuple(altered),primary))
altered=copy.deepcopy(list(rows));molecule=next(x for x in altered if x['source_record_role']=='complete-conjugated-molecular-identity-surface');molecule['source_outcome']['complete_identity_table'].append(None);cases.append(('first-match-short-circuit',tuple(altered),primary))
p=copy.deepcopy(primary);del p['exact_postseal_analysis']['complete_vibrational_table_rows'];altered=copy.deepcopy(list(rows));spectrum=next(x for x in altered if x['source_record_role']=='complete-uv-visible-jcamp-point-surface');spectrum['source_outcome']['headers'].pop('FIRSTX');cases.append(('original-key-evaluation-order',tuple(altered),p))
q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,list):return '.array ['+','.join(cv(v)for v in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')'for k,v in x.items())+']'
 raise TypeError(type(x))
expressions=[];expected=[]
for name,rs,p in cases:
 try:out={'ok':canonical_value(src.exact_analysis(rs,p))}
 except(ValueError,KeyError,StopIteration,IndexError)as e:out={'error':str(e)}
 expected.append([name,out]);leanrows='['+','.join('⟨'+','.join([q(row['source_id']),q(row['custody_class']),q(row['source_record_role']),cv(row['source_outcome'])])+'⟩'for row in rs)+']'
 expressions.append('('+q(name)+',exactAnalysis '+leanrows+' ('+cv(p)+'))')
harness='''import SFT.Chemistry.ConjugatedSupportAnalysis
open SFT.Host SFT.Chemistry.ConjugatedSupportAnalysis
set_option maxRecDepth 100000
set_option maxHeartbeats 20000000
def result : Except String J → J
 | .ok value => .object [("ok",value)]
 | .error message => .object [("error",.text message)]
def rows : List (String × Except String J) := [
'''+',\n'.join(expressions)+''']
def main : IO Unit := IO.println (Canonical.render (.array (rows.map (fun (name,value) => .array [.text name,result value]))))
'''
p=w/'ConjugatedAnalysisProgram1078.lean';p.write_text(harness)
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)]
if '--reuse-native' not in sys.argv:
 with (w/'conjugated1078_analysis_output.json').open('w')as out,(w/'conjugated1078_analysis_execution.log').open('w')as err:run=subprocess.run(cmd,env=env,stdout=out,stderr=err)
 assert run.returncode==0,run.returncode
actual=json.loads((w/'conjugated1078_analysis_output.json').read_text());assert actual==expected,[(a,b)for a,b in zip(actual,expected)if a!=b][:1]
log=(w/'conjugated1078_analysis_build3.log').read_text();names=re.findall(r"'([^']+)' does not depend on any axioms",log);assert len(names)==11 and 'depends on axioms:'not in log
report=dict(status='PASS',cases=len(cases),analysis_fields=len(expected[0][1]['ok']),original_sources=10,all_fields_match=True,axioms=[],declarations=names,source_sha256=hashlib.sha256((r/'SFT/Chemistry/ConjugatedSupportAnalysis.lean').read_bytes()).hexdigest())
(w/'conjugated1078_analysis_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS original31-field analysis and',len(cases),'source cases;11 declarations zero axioms')
