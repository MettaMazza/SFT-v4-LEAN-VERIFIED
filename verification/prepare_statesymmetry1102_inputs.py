from pathlib import Path
import json,sys,hashlib,platform,types
from html.parser import HTMLParser
w=Path('work');root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root))
from sft.chemistry import state_symmetry_validation_v1 as src
from sft.engine.canonical import canonical_value
from sft.claim_evidence import snapshot_protected_tree
class Events(HTMLParser):
 def __init__(self):super().__init__();self.events=[]
 def handle_starttag(self,t,a):self.events.append(['start',t,a])
 def handle_endtag(self,t):self.events.append(['end',t])
 def handle_data(self,s):self.events.append(['data',s])
identities=json.loads((root/src.IDENTITY_PATH).read_text());targets=json.loads((root/src.TARGET_PATH).read_text());snaps=[]
for path in dict.fromkeys(x['snapshot_path'] for x in identities['rows']):
 b=(root/path).read_bytes();h='sha256:'+hashlib.sha256(b).hexdigest();assert h==next(x['snapshot_hash']for x in identities['rows']if x['snapshot_path']==path)
 p=Events();p.feed(b.decode());snaps.append({'path':path,'actual_hash':h,'events':p.events})
first=(root/identities['rows'][0]['snapshot_path']).read_bytes();before=snapshot_protected_tree(root)
seal='native-statesymmetry1102'
expected=canonical_value(src.StateSymmetryValidator(root).validate(types.SimpleNamespace(seal_hash=seal)))
assert expected['passed'];assert snapshot_protected_tree(root)==before
(w/'statesymmetry1102_original_empirical.json').write_text(json.dumps(expected,ensure_ascii=False,indent=2)+'\n')
data={'identity_hash':src.IDENTITY_HASH,'identity_document':identities,'target_hash':src.TARGET_HASH,'target_document':targets,'snapshots':snaps,'tampered_first_hash':'sha256:'+hashlib.sha256(first+b'tampered').hexdigest(),'derivation_seal':seal,'host':platform.system(),'implementation':platform.python_implementation(),'before':canonical_value(before),'after':canonical_value(before)}
(w/'statesymmetry1102_input.json').write_text(json.dumps(data,ensure_ascii=False))
(w/'statesymmetry1102_prepared.json').write_text(json.dumps({'status':'ORIGINAL_VALIDATOR_PASS_NATIVE_PENDING','fields':len(expected),'messages':len(expected['measurements']),'snapshots':len(snaps),'html_events':sum(len(x['events'])for x in snaps),'protected_tree_unchanged':True,'original_validator_sha256':hashlib.sha256(Path(src.__file__).read_bytes()).hexdigest(),'input_sha256':hashlib.sha256((w/'statesymmetry1102_input.json').read_bytes()).hexdigest()},indent=2)+'\n')
print('Original validator PASS:',len(expected),'fields;',len(expected['measurements']),'messages; all22 snapshots, protected tree unchanged')
