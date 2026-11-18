from pathlib import Path
import subprocess,json,hashlib,re,sys,dataclasses
w=Path('work');stage=w/'pinned1308';repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-CHEM-OPERATIONAL-CLASSICAL-QUANTUM-CORRESPONDENCE-015';rows={}
def fetch(rel):
 b=subprocess.check_output(['git','-C',repo,'show',pin+':'+rel]);p=stage/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b);rows[rel]={'path':rel,'sha256':hashlib.sha256(b).hexdigest()};return p
for name in ['execution.py','certificate.json','independent_validator.py','WHY_DERIVATION_CHECK.md','STATUS.md']:fetch('claims/'+cid+'/'+name)
files=re.findall(r'root\s*/\s*"([^"]+)"',(stage/'claims'/cid/'execution.py').read_text().split('source_hash =')[0])
for rel in files:fetch(rel)
sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.classical_quantum_correspondence_batch_v1 import CLASSICAL_QUANTUM_SPEC as spec,GeneratedOperationalChemistryProgram
from sft.chemistry.classical_quantum_correspondence_law_v1 import CERTIFICATE
from sft.engine.source import build_source_manifest
from sft.engine.canonical import canonical_value
spec.validate();cert=json.loads((stage/'claims'/cid/'certificate.json').read_text());assert build_source_manifest(stage,[stage/f for f in files]).manifest_hash==cert['source_manifest_hash']
program=GeneratedOperationalChemistryProgram(spec,cert['source_manifest_hash']);census=program.generate_candidates();decisions=tuple(program.decide_candidate(c)for c in census.candidates)
expected=canonical_value(dict(registration=program.registration,census=census,decisions=decisions,closure=program.closure_evidence(decisions),controls=program.run_controls(),unknown_id='StopIteration'))
for suffix,obj in [('spec',dataclasses.asdict(spec)),('original_program',expected),('original_certificate',canonical_value(CERTIFICATE)),('source_pin',dict(commit=pin,execution_files=files,files=list(rows.values())))]:
 (w/('correspondence1308_'+suffix+'.json')).write_text(json.dumps(obj,indent=2)+'\n')
assert len(census.candidates)==256 and CERTIFICATE['passed']
(w/'correspondence1308_original_report.json').write_text(json.dumps(dict(status='PASS',candidates=256,certificate_fields=len(CERTIFICATE),witnesses=len(spec.operational_witnesses)),indent=2)+'\n')
print('Pinned source manifest verified; original256candidate programme and11field certificate retained.')
