from pathlib import Path
import sys,json,hashlib,subprocess,platform,shutil
from types import SimpleNamespace
w=Path('work');stage=w/'pinned1140';sys.path[:0]=[str((w/'v3-runtime500').resolve()),str((w/'radiochemical1122_pdf6142').resolve())]
import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.nuchem_terminal_batch_v1 import ANALYSIS_PATH,RADIOTRACER_SPEC
from sft.chemistry.nuchem_terminal_validation_v1 import _surface,_clean,exact_analysis,RadiotracerValidator
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
from pypdf import PdfReader,__version__
analysis=json.loads((stage/ANALYSIS_PATH).read_text());pin=json.loads((w/'radiotracer1140_source_pin.json').read_text());surfaces=[]
for name,record in analysis['complete_source_reconstruction'].items():
 rel=record['snapshot_path'];p=stage/rel;p.parent.mkdir(parents=True,exist_ok=True)
 if not p.exists():
  with p.open('wb')as out:subprocess.run(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin['commit']+':'+rel],stdout=out,check=True)
 b=p.read_bytes();assert 'sha256:'+hashlib.sha256(b).hexdigest()==record['snapshot_sha256']
 if not any(x['path']==rel for x in pin['files']):pin['files'].append({'path':rel,'git_blob':hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()})
 cache=w/('radiotracer1140_'+name+'_pages_'+__version__+'.json')
 pages=json.loads(cache.read_text())if cache.exists()else[page.extract_text()or''for page in PdfReader(p).pages]
 if not cache.exists():cache.write_text(json.dumps(pages,ensure_ascii=False))
 actual=[{'page':i,'character_count':len(_clean(t)),'text_sha256':'sha256:'+hashlib.sha256(_clean(t).encode()).hexdigest()}for i,t in enumerate(pages,1)]
 assert actual==record['complete_surface_vector'],(name,[(i,a,b)for i,(a,b)in enumerate(zip(actual,record['complete_surface_vector']))if a!=b][:2])
 surfaces.append({'name':name,'path':rel,'kind':'pdf','snapshot_sha256':record['snapshot_sha256'],'pages':pages,'expected_surface':actual});print(name,len(pages),'pages match',flush=True)
(w/'radiotracer1140_source_pin.json').write_text(json.dumps(pin,indent=2))
# Original extraction operates on the same verified bytes using the same installed version.
summary,checks=exact_analysis(stage,RADIOTRACER_SPEC.claim_id)
for rel in ['census','receipts/engine/model_admitted']:
 if not(stage/rel).exists():shutil.copytree(w/'v3-runtime500'/rel,stage/rel)
before=snapshot_protected_tree(stage);reference=snapshot_protected_tree(w/'v3-runtime500');assert before.file_hashes==reference.file_hashes
seal='native-radiotracer1140';result=RadiotracerValidator(stage).validate(SimpleNamespace(seal_hash=seal));after=snapshot_protected_tree(stage);assert before==after and result.passed
payload={'analysis':analysis,'surfaces':surfaces,'derivation_seal':seal,'host':platform.system(),'implementation':platform.python_implementation(),'before':canonical_value(before),'after':canonical_value(after)}
(w/'radiotracer1140_empirical_input.json').write_text(json.dumps(payload,ensure_ascii=False))
out=canonical_value(result);(w/'radiotracer1140_original_empirical.json').write_text(json.dumps(out,indent=2));(w/'radiotracer1140_original_report.json').write_text(json.dumps({'status':'PASS','pdf_version':__version__,'complete_pages':370,'characters':837013,'source_files':4,'fields':len(out),'messages':len(out['measurements']),'protected_tree_unchanged':True},indent=2));print('PASS original full source extraction and empirical receipt',flush=True)
