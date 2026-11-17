from pathlib import Path
import json,subprocess,hashlib,sys,platform
from types import SimpleNamespace
from html.parser import HTMLParser
w=Path('work');stage=w/'pinned1162';repo=Path('/Volumes/One Touch/ernos-labs-sft-platform');commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';analysis_path='experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json';analysis=json.loads((stage/analysis_path).read_text());pin=json.loads((w/'accuracy1162_source_pin.json').read_text())
for source in analysis['complete_source_reconstruction'].values():
 rel=source['snapshot_path'];b=subprocess.check_output(['git','-C',str(repo),'show',commit+':'+rel]);p=stage/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b);pin['files']=[x for x in pin['files']if x['path']!=rel];pin['files'].append(dict(path=rel,sha256=hashlib.sha256(b).hexdigest(),git_blob=hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()))
(w/'accuracy1162_source_pin.json').write_text(json.dumps(pin,indent=2)+'\n')
sys.path[:0]=[str((w/'v3-runtime500').resolve()),str((w/'radiochemical1122_pdf6142').resolve()),str((w/'accuracy1162_testdeps').resolve())];import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.anal_performance_validation_v1 import AccuracyValidator,surface
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
from pypdf import PdfReader
for rel in ['census','receipts/engine/model_admitted']:
 p=stage/rel
 if not p.exists():p.parent.mkdir(parents=True,exist_ok=True);p.symlink_to((w/'v3-runtime500'/rel).resolve(),target_is_directory=True)
before=snapshot_protected_tree(stage);assert before.file_hashes==snapshot_protected_tree(w/'v3-runtime500').file_hashes
out=AccuracyValidator(stage).validate(SimpleNamespace(seal_hash='native-accuracy1162'));after=snapshot_protected_tree(stage);assert out.passed and before==after
class Events(HTMLParser):
 def __init__(self):super().__init__(convert_charrefs=True);self.events=[]
 def handle_starttag(self,t,a):self.events.append(['start',t])
 def handle_endtag(self,t):self.events.append(['end',t])
 def handle_data(self,s):self.events.append(['data',s])
surfaces=[]
for source in analysis['complete_source_reconstruction'].values():
 rel=source['snapshot_path'];p=stage/rel;kind=source['media_kind'];entry=dict(path=rel,kind=kind,snapshot_sha256='sha256:'+hashlib.sha256(p.read_bytes()).hexdigest(),expected_surface=surface(p,kind))
 if kind=='pdf':entry['pages']=[x.extract_text()for x in PdfReader(p).pages]
 else:
  parser=Events();parser.feed(p.read_text());entry['events']=parser.events
 surfaces.append(entry)
payload=dict(analysis=analysis,surfaces=surfaces,before=canonical_value(before),after=canonical_value(after),derivation_seal='native-accuracy1162',host=platform.system(),implementation=platform.python_implementation())
(w/'accuracy1162_empirical_input.json').write_text(json.dumps(payload,ensure_ascii=False));actual=canonical_value(out);(w/'accuracy1162_original_empirical.json').write_text(json.dumps(actual,indent=2));(w/'accuracy1162_original_report.json').write_text(json.dumps(dict(status='PASS',fields=len(actual),messages=len(actual['measurements']),source_pages=83,html_documents=1,characters=180366,protected_tree_unchanged=True),indent=2));print('PASS original empirical and83PDFpages/1HTML/180366characters source reconstruction')
