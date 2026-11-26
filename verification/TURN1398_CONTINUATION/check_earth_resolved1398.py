from pathlib import Path
import json,subprocess,sys,hashlib
w=Path('work');r=w/'turn1064_recovery';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';rel='sft/earth_environment/empirical_program.py'
b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+rel]);assert b==(w/'v3-runtime500'/rel).read_bytes()
subprocess.run([sys.executable,'work/prepare_earthresolved1398_programme.py'],check=True)
p=subprocess.run([sys.executable,'work/prepare_earthresolved1398_programme.py','--execute'],capture_output=True,text=True);(w/'earth_resolved1398_execution.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-700:]+p.stderr[-700:]
a=json.loads(p.stdout);e=json.loads((w/'earth_resolved1398_expected.json').read_text());assert a==e,[k for k in e if a.get(k)!=e[k]]
(w/'earth_resolved1398_output.json').write_text(json.dumps(a,indent=2)+'\n')
(w/'earth_resolved1398_report.json').write_text(json.dumps({'status':'PASS','scope':'original conditional validator continuation; not full external validation','fields':len(a),'measurements':len(a['measurements']),'v3_commit':pin,'original_source_sha256':hashlib.sha256(b).hexdigest(),'lean_source_sha256':{str(p.relative_to(r)):hashlib.sha256(p.read_bytes()).hexdigest()for p in [r/'SFT/EarthEnvironment/EarthSystemValidation.lean',r/'SFT/EarthEnvironment/EarthSystemExperiment.lean']},'full_source_guard_unchanged':True},indent=2)+'\n');print('PASS12-field conditional original continuation',flush=True)
