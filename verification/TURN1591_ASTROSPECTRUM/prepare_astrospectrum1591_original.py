from pathlib import Path
import sys,json,re,subprocess,copy,hashlib
w=Path('work');stage=w/'pinned1591';cid='SFT-ASTRO-SPECTRUM-001';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';rows=[]
def fetch(rel):
 b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+rel]);p=stage/rel;p.parent.mkdir(parents=True,exist_ok=True)
 if p.exists():assert p.read_bytes()==b
 else:p.write_bytes(b)
 rows.append({'path':rel,'sha256':hashlib.sha256(b).hexdigest()});return b.decode()
for name in ['execution.py','certificate.json','independent_validator.py']:fetch('claims/'+cid+'/'+name)
execution=(stage/'claims'/cid/'execution.py').read_text();files=re.findall(r'root\s*/\s*"([^"]+)"',execution.split('source_hash')[0])
for rel in files:fetch(rel)
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.astronomy_cosmology.empirical_program import ASTRONOMY_SPECS,GeneratedEmpiricalAstronomyProgram
from sft.engine.source import build_source_manifest
from sft.engine.canonical import canonical_value
spec=next(x for x in ASTRONOMY_SPECS if x.claim_id==cid);files.insert(10,spec.source_snapshot_path);fetch(spec.source_snapshot_path);source=build_source_manifest(stage,[stage/p for p in files]).manifest_hash;assert source==json.loads((stage/'claims'/cid/'certificate.json').read_text())['source_manifest_hash']
program=GeneratedEmpiricalAstronomyProgram(spec,source);census=program.generate_candidates();decisions=tuple(program.decide_candidate(c)for c in census.candidates);expected=canonical_value(dict(registration=program.registration,census=census,decisions=decisions,closure=program.closure_evidence(decisions),controls=program.run_controls(),unknown_id='StopIteration'));(w/'astrospectrum1591_original_program.json').write_text(json.dumps(expected,indent=2))
validator=(stage/'claims'/cid/'independent_validator.py').resolve();results=[]
for case in ['original','omitted_candidate','additional_survivor','failed_control']:
 sealed=copy.deepcopy(dict(expected,claim_id=cid,seal_hash='native-astrospectrum1591'))
 if case=='omitted_candidate':sealed['census']['candidates']=sealed['census']['candidates'][1:]
 if case=='additional_survivor':sealed['decisions'][0]['survives']=True
 if case=='failed_control':sealed['controls'][0]['passed']=False
 f=w/('astrospectrum1591_original_independent_'+case+'.json');f.write_text(json.dumps(sealed));p=subprocess.run([sys.executable,str(validator),str(f.resolve())],capture_output=True,text=True,check=True);v=json.loads(p.stdout);assert v['passed']==(case=='original');results.append(dict(case=case,result=v))
(w/'astrospectrum1591_original_report.json').write_text(json.dumps(dict(status='PASS',scope='original programme and independent controls only; native and empirical checks separate',source_commit=pin,source_manifest_hash=source,candidates=len(census.candidates),survivors=sum(d.survives for d in decisions),controls=len(expected['controls']),independent_cases=results),indent=2));(w/'astrospectrum1591_program_pin.json').write_text(json.dumps(rows,indent=2));print('Originalprogramme256candidates,1survivor,4controls; independentoriginal/3adverse PASS; boundfiles',len(files))
