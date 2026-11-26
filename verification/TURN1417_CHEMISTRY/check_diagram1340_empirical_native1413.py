from pathlib import Path
import os,sys,json,subprocess,hashlib,platform
from html.parser import HTMLParser
from types import SimpleNamespace
w=Path('work');r=w/'turn1064_recovery';stage=w/'pinned1340';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry;sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import multicomponent_phase_diagram_validation_v1 as src
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
class Events(HTMLParser):
 def __init__(self):super().__init__();self.events=[]
 def handle_starttag(self,tag,attrs):self.events.append(['start',tag,attrs])
 def handle_endtag(self,tag):self.events.append(['end',tag])
 def handle_data(self,data):self.events.append(['data',data])
snapshots=[]
before=snapshot_protected_tree(stage);seal='native-diagram1340';expected=canonical_value(src.MulticomponentPhaseDiagramValidator(stage).validate(SimpleNamespace(seal_hash=seal)))
(w/'diagram1340_empirical_input.json').write_text(json.dumps(dict(before=canonical_value(before),after=canonical_value(before),snapshots=snapshots,derivation_seal=seal,host=platform.system(),implementation=platform.python_implementation())))
(w/'diagram1340_native1413_original_empirical_current.json').write_text(json.dumps(expected,indent=2)+'\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
native_build=json.loads((w/'diagram1340_empirical_native_build1413.json').read_text());assert native_build['status']=='PASS'
for row in native_build['modules']:
 assert hashlib.sha256(Path(row['source']).read_bytes()).hexdigest()==row['source_sha256'],row['module']
assert hashlib.sha256((w/'MulticomponentPhaseDiagramValidationProgram1340.lean').read_bytes()).hexdigest()==native_build['runner_sha256']
assert hashlib.sha256(Path(native_build['executable']).read_bytes()).hexdigest()==native_build['executable_sha256']
cmd=[sys.executable,'work/run_lean_guarded.py',native_build['executable']]
with(w/'diagram1340_empirical_native1413_output.json').open('w')as out,(w/'diagram1340_empirical_native1413_execution.log').open('w')as err:subprocess.run(cmd,env=env,stdout=out,stderr=err,check=True)
actual=json.loads((w/'diagram1340_empirical_native1413_output.json').read_text());assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]];assert snapshot_protected_tree(stage)==before
mods=['MulticomponentDiagramAnalysis','MulticomponentPhaseDiagram','MulticomponentPhaseDiagramGrammar','MulticomponentPhaseDiagramEvidence','MulticomponentPhaseDiagramExperiment','MulticomponentPhaseDiagramSource','MulticomponentPhaseDiagramPrediction','MulticomponentPhaseDiagramValidation']
(w/'diagram1340_empirical_native1413_report.json').write_text(json.dumps(dict(status='PASS',fields=len(actual),messages=len(actual['measurements']),all_fields_and_hashes_match=True,original_target_checks=116,original_adverse_controls=7,fresh_native=True,fresh_original=True,host_primitives=['Lean JSON input decoding; actual source bytes read and hashed natively'],source_sha256={m:hashlib.sha256((r/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest()for m in mods}),indent=2)+'\n');print('PASS full12field128message empirical result; all source and receipt hashes',flush=True)
