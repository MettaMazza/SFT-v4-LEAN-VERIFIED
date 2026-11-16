from pathlib import Path
import sys,json,subprocess,os,re,hashlib
w=Path('work');r=w/'turn1064_recovery';runtime=(w/'v3-runtime500').resolve();sys.path.insert(0,str(runtime))
from sft.chemistry import conjugated_support_validation_v1 as src
from sft.engine.canonical import canonical_value
identity=json.loads((runtime/src.IDENTITY_PATH).read_text());document=json.loads((runtime/src.TARGET_PATH).read_text());expected=canonical_value(src._source_rows(runtime));q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,list):return '.array ['+','.join(cv(v)for v in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')'for k,v in x.items())+']'
 raise TypeError(type(x))
p=w/'ConjugatedSourceProgram1079.lean';p.write_text('''import SFT.Chemistry.ConjugatedSupportSource
open SFT.Host SFT.Chemistry.ConjugatedSupportSource SFT.Chemistry.ConjugatedSupportAnalysis
set_option maxRecDepth 100000
set_option maxHeartbeats 20000000
'''+ 'def identityDocument : J := '+cv(identity)+'\ndef targetDocument : J := '+cv(document)+'''
def result : Except String (List J) → J
 | .ok rows => .object [("ok",.array rows)]
 | .error message => .object [("error",.text message)]
def main : IO Unit := IO.println (Canonical.render (.array [
 result (sourceRows identityHash targetHash primaryHash identityDocument targetDocument),
 result (sourceRows "changed" targetHash primaryHash identityDocument targetDocument),
 result (sourceRows identityHash "changed" primaryHash identityDocument targetDocument),
 result (sourceRows identityHash targetHash "changed" identityDocument targetDocument)]))
''')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)]
with (w/'conjugated1079_source_output.json').open('w')as out,(w/'conjugated1079_source_execution.log').open('w')as err:run=subprocess.run(cmd,env=env,stdout=out,stderr=err)
assert run.returncode==0,run.returncode
actual=json.loads((w/'conjugated1079_source_output.json').read_text());assert actual==[{'ok':expected},{'error':'ORG-001 identity changed'},{'error':'ORG-001 external evidence changed'},{'error':'ORG-001 external evidence changed'}]
log=(w/'conjugated1079_source_build.log').read_text();names=re.findall(r"'([^']+)' does not depend on any axioms",log);assert len(names)==12 and 'depends on axioms:'not in log
report=dict(status='PASS',registered_rows=len(expected),source_hash_controls=3,all_fields_and_payload_hashes_match=True,axioms=[],declarations=names,source_sha256=hashlib.sha256((r/'SFT/Chemistry/ConjugatedSupportSource.lean').read_bytes()).hexdigest())
(w/'conjugated1079_source_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS complete10 source rows/payload hashes and three hash controls;12 declarations zero axioms')
