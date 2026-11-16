import json,sys,os,subprocess,hashlib,re
from pathlib import Path
from html.parser import HTMLParser
w=Path('work');root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root))
from sft.chemistry import state_energy_order_validation_v1 as src
from sft.engine.canonical import canonical_value
class Events(HTMLParser):
 def __init__(self):super().__init__();self.events=[]
 def handle_starttag(self,tag,attrs):self.events.append(['start',tag,attrs])
 def handle_endtag(self,tag):self.events.append(['end',tag])
 def handle_data(self,data):self.events.append(['data',data])
def filehash(path):return 'sha256:'+hashlib.sha256(path.read_bytes()).hexdigest()
ih=filehash(root/src.IDENTITY_PATH);th=filehash(root/src.TARGET_PATH)
assert ih==src.IDENTITY_HASH and th==src.TARGET_HASH
identities=json.loads((root/src.IDENTITY_PATH).read_text())['rows'];targets=json.loads((root/src.TARGET_PATH).read_text())['rows'];snapshots=[]
for path,want in dict((r['snapshot_path'],r['snapshot_hash'])for r in identities).items():
 p=root/path;actual=filehash(p);assert actual==want;tokens=Events();tokens.feed(p.read_text(encoding='utf-8'));snapshots.append(dict(path=path,hash=actual,events=tokens.events))
data=dict(identity_schema=json.loads((root/src.IDENTITY_PATH).read_text())["schema"],target_schema=json.loads((root/src.TARGET_PATH).read_text())["schema"],identities=identities,targets=targets,snapshots=snapshots,identity_hash=ih,target_hash=th)
inp=w/'stateenergy1084_targets_input.json';inp.write_text(json.dumps(data))
expected=canonical_value(src._targets(root));(w/'stateenergy1084_original_targets.json').write_text(json.dumps(expected,indent=2)+'\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str((w/'turn1064_recovery').resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
with (w/'stateenergy1084_targets_output_raw.json').open('w')as out,(w/'stateenergy1084_targets_execution.log').open('w')as err:r=subprocess.run(cmd+['--run','work/StateEnergyTargetsProgram1084.lean',str(inp)],env=env,stdout=out,stderr=err)
assert r.returncode==0,r.returncode
actual=json.loads((w/'stateenergy1084_targets_output_raw.json').read_text());assert actual==expected,[i for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:5]
p=w/'turn1064_recovery/SFT/Chemistry/StateEnergyTargets.lean';names=['SFT.Chemistry.StateEnergyTargets.'+n for n in re.findall(r'^def (\w+)',p.read_text(),re.M)];audit=w/'stateenergy1084_targets_audit.lean';audit.write_text('import SFT.Chemistry.StateEnergyTargets\n'+''.join('#print axioms '+n+'\n'for n in names));a=subprocess.run(cmd+[str(audit)],env=env,capture_output=True,text=True);(w/'stateenergy1084_targets_audit.log').write_text(a.stdout+a.stderr);assert a.returncode==0 and a.stdout.count('does not depend on any axioms')==len(names),a.stdout
(w/'stateenergy1084_targets_report.json').write_text(json.dumps(dict(status='PASS',resolved_targets=len(actual),all_fields_match=True,axioms=[],declarations=names,source_sha256=hashlib.sha256(p.read_bytes()).hexdigest()),indent=2)+'\n');print('PASS306 complete native target records, all fields and Fold values;',len(names),'zero-axiom declarations')
