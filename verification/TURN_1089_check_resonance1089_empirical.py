from pathlib import Path
import sys,json,hashlib,subprocess,os,platform
w=Path('work');r=w/'turn1064_recovery';runtime=(w/'v3-runtime500').resolve();sys.path.insert(0,str(runtime))
from sft.chemistry import resonance_equivalent_representation_validation_v1 as src
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
expected=json.loads((w/'resonance1088_original_empirical.json').read_text());assert expected['passed'] and expected['validated_seal_hash']=='native-resonance1088'
for listFile in ['SOURCE_IDENTITIES.json','INPUT_IDENTITIES.json']:
 pin=json.loads((w/'pinned1088'/listFile).read_text());assert pin['commit']=='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
 for item in pin['files']:
  b=(runtime/item['path']).read_bytes();assert hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()==item['sha'],item['path']
before=snapshot_protected_tree(runtime);data={}
for name,path,expectedHash in [('identity',src.IDENTITY_PATH,src.IDENTITY_HASH),('target',src.TARGET_PATH,src.TARGET_HASH),('primary',src.PRIMARY_PATH,src.PRIMARY_HASH)]:
 b=(runtime/path).read_bytes();actualHash='sha256:'+hashlib.sha256(b).hexdigest();assert actualHash==expectedHash;data[name+'_hash']=actualHash;data[name+'_document']=json.loads(b)
data.update(before=canonical_value(before),after=canonical_value(before),derivation_seal='native-resonance1088',host=platform.system(),implementation=platform.python_implementation());inp=w/'resonance1089_empirical_input.json';inp.write_text(json.dumps(data))
modules=['ResonanceEquivalentComparison','ResonanceEquivalentSource','ResonanceEquivalentAnalysis','ResonanceEquivalentPrediction','ResonanceEquivalentExperiment','ResonanceEquivalentControls','ResonanceEquivalentValidation'];digests={n:hashlib.sha256((r/'SFT/Chemistry'/(n+'.lean')).read_bytes()).hexdigest()for n in modules}
(w/'resonance1089_empirical_start.json').write_text(json.dumps(dict(source_sha256=digests,expected_sha256=hashlib.sha256((w/'resonance1088_original_empirical.json').read_bytes()).hexdigest(),input_sha256=hashlib.sha256(inp.read_bytes()).hexdigest()),indent=2)+'\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run','work/ResonanceValidationProgram1089.lean',str(inp)]
with (w/'resonance1089_empirical_output_raw.json').open('w')as out,(w/'resonance1089_empirical_execution.log').open('w')as err:run=subprocess.run(cmd,env=env,stdout=out,stderr=err)
assert run.returncode==0,run.returncode
assert snapshot_protected_tree(runtime)==before
for n,sha in digests.items():assert hashlib.sha256((r/'SFT/Chemistry'/(n+'.lean')).read_bytes()).hexdigest()==sha
actual=json.loads((w/'resonance1089_empirical_output_raw.json').read_text());assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'resonance1089_empirical_output.json').write_text(json.dumps(actual,indent=2)+'\n');report=dict(status='PASS',fields=len(actual),messages=len(actual['measurements']),all_fields_and_hashes_match=True,protected_tree_unchanged=True,source_sha256=digests,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1')
(w/'resonance1089_empirical_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS complete original empirical return:',len(actual),'fields,',len(actual['measurements']),'messages, every certificate and measurement hash')
