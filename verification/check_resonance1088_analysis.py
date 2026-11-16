from pathlib import Path
import json,sys,copy,subprocess,os,hashlib,re
w=Path('work');r=w/'turn1064_recovery';runtime=(w/'v3-runtime500').resolve();sys.path.insert(0,str(runtime))
from sft.chemistry import resonance_equivalent_representation_validation_v1 as src
from sft.engine.canonical import canonical_value
rows=src._source_rows(runtime);primary=json.loads((runtime/src.PRIMARY_PATH).read_text());cases=[('original',rows,primary),('omitted',rows[:-1],primary)]
altered=copy.deepcopy(list(rows));altered[1]['source_id']=altered[0]['source_id'];cases.append(('shared-source',tuple(altered),primary))
for custody in ['family-development-observed','family-identity-opened-by-admitted-ORG-001','other']:
 altered=copy.deepcopy(list(rows));altered[0]['custody_class']=custody;cases.append(('custody-'+custody,tuple(altered),primary))
p=copy.deepcopy(primary);del p['exact_postseal_analysis'];cases.append(('missing-postseal',rows,p))
p=copy.deepcopy(primary);p['exact_postseal_analysis']={};cases.append(('empty-postseal',rows,p))
p=copy.deepcopy(primary);p['exact_postseal_analysis']['base_atom_count']=97;cases.append(('postseal-source-overwrite',rows,p))
p=copy.deepcopy(primary);p['exact_postseal_analysis']['additional-source-field']='kept';cases.append(('postseal-extra-field',rows,p))
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
harness='''import SFT.Chemistry.ResonanceEquivalentAnalysis
open SFT.Host SFT.Chemistry.ResonanceEquivalentAnalysis
set_option maxRecDepth 100000
set_option maxHeartbeats 20000000
def result : Except String J → J
 | .ok value => .object [("ok",value)]
 | .error message => .object [("error",.text message)]
def rows : List (String × Except String J) := [
'''+',\n'.join(expressions)+''']
def main : IO Unit := IO.println (Canonical.render (.array (rows.map (fun (name,value) => .array [.text name,result value]))))
'''
p=w/'ResonanceAnalysisProgram1088.lean';p.write_text(harness)
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)]
if '--reuse-native' not in sys.argv:
 with (w/'resonance1088_analysis_output.json').open('w')as out,(w/'resonance1088_analysis_execution.log').open('w')as err:run=subprocess.run(cmd,env=env,stdout=out,stderr=err)
 assert run.returncode==0,run.returncode
actual=json.loads((w/'resonance1088_analysis_output.json').read_text());assert actual==expected,[(a,b)for a,b in zip(actual,expected)if a!=b][:1]
log=(w/'resonance1088_analysis_build.log').read_text();names=re.findall(r"'([^']+)' does not depend on any axioms",log);assert len(names)==4 and 'depends on axioms:'not in log
report=dict(status='PASS',cases=len(cases),analysis_fields=len(expected[0][1]['ok']),original_sources=4,all_fields_match=True,axioms=[],declarations=names,source_sha256=hashlib.sha256((r/'SFT/Chemistry/ResonanceEquivalentAnalysis.lean').read_bytes()).hexdigest())
(w/'resonance1088_analysis_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS original',len(expected[0][1]['ok']),'field analysis and',len(cases),'source cases; four declarations zero axioms')
