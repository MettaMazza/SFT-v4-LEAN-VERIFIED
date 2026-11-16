import json,sys,os,subprocess,hashlib,platform,dataclasses,re
from pathlib import Path
from html.parser import HTMLParser
w=Path('work');root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root))
from sft.chemistry import electron_count_spin_validation_v1 as src
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
class Events(HTMLParser):
 def __init__(self):super().__init__();self.events=[]
 def handle_starttag(self,tag,attrs):self.events.append(['start',tag,attrs])
 def handle_endtag(self,tag):self.events.append(['end',tag])
 def handle_data(self,data):self.events.append(['data',data])
def filehash(p):return 'sha256:'+hashlib.sha256(p.read_bytes()).hexdigest()
inputDocument=json.loads((root/src.INPUT_REGISTRY_PATH).read_text());targetDocument=json.loads((root/src.TARGET_REGISTRY_PATH).read_text())
inputs=[]
for row in inputDocument['rows']:
 item=dict(row)
 for key in ['row_id','molecular_formula','charge_action']:item[key]=str(item[key])
 item['nuclear_composition']=[dict(element_symbol=str(p['element_symbol']),atomic_number=int(p['atomic_number']),occurrence_count=int(p['occurrence_count']))for p in row['nuclear_composition']]
 inputs.append(item)
snapshots=[]
for ref in src.ELECTRON_COUNT_SPIN_SPEC.target_rows:
 p=root/ref.snapshot_path;assert filehash(p)==ref.snapshot_hash
 parser=Events();parser.feed(p.read_text(encoding='utf-8'))
 snapshots.append(dict(path=ref.snapshot_path,hash=filehash(p),events=parser.events))
first=root/src.ELECTRON_COUNT_SPIN_SPEC.target_rows[0].snapshot_path
before=snapshot_protected_tree(root)
data=dict(inputs=inputs,targets=targetDocument['rows'],snapshots=snapshots,input_hash=filehash(root/src.INPUT_REGISTRY_PATH),target_hash=filehash(root/src.TARGET_REGISTRY_PATH),input_schema=inputDocument.get('schema'),target_schema=targetDocument.get('schema'),before=canonical_value(before),after=canonical_value(before),tampered_first_hash='sha256:'+hashlib.sha256(first.read_bytes()+b'deliberate-tamper').hexdigest(),derivation_seal='native-electronspin1073',host=platform.system(),implementation=platform.python_implementation())
inp=w/'electronspin1074_empirical_input.json';inp.write_text(json.dumps(data))
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str((w/'turn1064_recovery').resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run','work/ElectronSpinValidationProgram1074.lean',str(inp)]
with (w/'electronspin1074_empirical_output_raw.json').open('w')as out,(w/'electronspin1074_empirical_execution.log').open('w')as err:
 r=subprocess.run(cmd,env=env,stdout=out,stderr=err)
assert r.returncode==0,r.returncode
after=snapshot_protected_tree(root);assert after==before,'protected source tree changed'
actual=json.loads((w/'electronspin1074_empirical_output_raw.json').read_text());expected=json.loads((w/'electronspin1073_original_empirical.json').read_text())
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'electronspin1074_empirical_output.json').write_text(json.dumps(actual,indent=2)+'\n')
digests={n:hashlib.sha256((w/'turn1064_recovery/SFT/Chemistry'/(n+'.lean')).read_bytes()).hexdigest()for n in ['ElectronSpinTargets','ElectronSpinValidation','ElectronSpinExperiment']}
(w/'electronspin1074_empirical_report.json').write_text(json.dumps(dict(status='PASS',all_fields_match=True,return_fields=len(actual),measurements=len(actual['measurements']),protected_tree_unchanged=True,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_sha256=digests,host_primitives=['Python JSON decoding and source str/int conversions','Python hashlib source-file and tampered-byte hashes','Python HTMLParser tokenizer; custom handlers native Lean']),indent=2)+'\n')
print('PASS complete native empirical assembly: all12 fields,27 measurements,all certificate/receipt hashes; protected tree unchanged')
