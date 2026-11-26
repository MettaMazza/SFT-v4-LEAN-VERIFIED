from pathlib import Path
import sys,subprocess,json,hashlib,platform
from types import SimpleNamespace
w=Path('work');stage=w/'pinned1394';repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.consciousness import nonordinary_external_v1 as src
from sft.engine.canonical import canonical_value
from sft.claim_evidence import snapshot_protected_tree
rows=[]
def retain(rel):
 p=stage/rel
 if not p.exists():
  b=subprocess.check_output(['git','-C',repo,'show',pin+':'+rel]);p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b)
 rows.append({'path':rel,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()});return p
files=[]
for relative in src.OBSERVATION_FILES:
 path=src.ROOT_DIR+'/'+relative;p=retain(path);payload=json.loads(p.read_text());identity=retain(payload['target_identity_registration_path']);assert hashlib.sha256(identity.read_bytes()).hexdigest()==payload['target_identity_registration_hash'].removeprefix('sha256:')
 files.extend([path,payload['target_identity_registration_path']])
 for row in payload['documents']:
  snapshot=retain(row['snapshot_path']);assert 'sha256:'+hashlib.sha256(snapshot.read_bytes()).hexdigest()==row['snapshot_hash'];files.append(row['snapshot_path'])
before=snapshot_protected_tree(stage);expected=canonical_value(src.BlindConsciousnessReturnExternalValidator(stage).validate(SimpleNamespace(seal_hash='native-nonordinary1395')));assert expected['passed'];assert before==snapshot_protected_tree(stage)
(w/'nonordinary1395_empirical_expected.json').write_text(json.dumps(expected,indent=2)+'\n');(w/'nonordinary1395_empirical_input.json').write_text(json.dumps({'before':canonical_value(before),'after':canonical_value(before),'files':files,'derivation_seal':'native-nonordinary1395','host':platform.system(),'implementation':platform.python_implementation()},indent=2)+'\n');(w/'nonordinary1395_empirical_files.json').write_text(json.dumps(rows,indent=2)+'\n')
label,extraction,sources,classes=src.source_target(stage);(w/'nonordinary1395_target_expected.json').write_text(json.dumps({'label':label,'extraction':extraction,'sources':sources,'classes':classes},indent=2)+'\n');(w/'nonordinary1395_registration_expected.json').write_text(json.dumps(canonical_value(src.external_registration_record()),indent=2)+'\n');(w/'nonordinary1395_prediction_expected.json').write_text(json.dumps(src.prediction_program_document(),indent=2)+'\n');print({'status':'PASS','fields':len(expected),'measurements':len(expected['measurements']),'sources':len(sources),'files':len(rows)},flush=True)
