from pathlib import Path
import json,hashlib,shutil,subprocess,os,signal
w=Path('work');r=w/'turn1064_recovery';H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
p=w/'coordgeometry1446_optimized1472_report.json';a=json.loads(p.read_text());assert a['status']=='PASS'
assert json.loads((w/'coordgeometry1446_optimized1472_output.json').read_text())==json.loads((w/'coordgeometry1446_original_empirical.json').read_text())
for m,h in a['source_sha256'].items():assert H(r/'SFT/Chemistry'/f'{m}.lean')==h
b=json.loads((w/'coordgeometry1446_optimized_build1472.json').read_text());assert b['status']=='PASS'
for row in b['modules']:assert H(Path(row['source']))==row['source_sha256']
assert H(Path(b['executable']))==b['executable_sha256']
stream=json.loads((w/'streaming1468_equivalence.json').read_text());assert stream['status']=='PASS'
for path,h in stream['source_sha256'].items():assert H(Path(path))==h
assert H(w/'streaming1468_build.log')==stream['audit_sha256']
source=(w/'CoordinationGeometryValidationProgram1446.lean').read_text();adapted=(w/'CoordinationGeometryValidationProgram1472.lean').read_text();assert adapted.replace('\nimport SFT.Host.SHA256Streaming','').replace('SFT.Host.SHA256Streaming.digest bytes','SFT.Host.SHA256.digest bytes')==source
optimized=(w/'optimized1469/SFT/Host/SHA256.lean').read_text();assert optimized.replace('@[specialize] ','').replace('@[inline] ','')==(r/'SFT/Host/SHA256.lean').read_text()
for m in ['SHA256Window','SHA256Streaming']:assert H(w/'optimized1469/SFT/Host'/f'{m}.lean')==H(r/'SFT/Host'/f'{m}.lean')
cmd=subprocess.run(['ps','-p','5356','-o','command='],capture_output=True,text=True).stdout;stopped=[]
if '--run work/CoordinationGeometryValidationProgram1446.lean' in cmd:os.kill(5356,signal.SIGTERM);stopped.append(5356)
for suffix in ['output.json','execution.log']:
 src=w/('coordgeometry1446_optimized1472_'+suffix);dst=w/('coordgeometry1446_empirical_'+suffix)
 if dst.exists():shutil.copyfile(dst,w/('coordgeometry1446_interpreter1472_'+suffix))
 shutil.copyfile(src,dst)
a.update(native_build='work/coordgeometry1446_optimized_build1472.json',streaming_equivalence=stream)
(w/'coordgeometry1446_empirical_report.json').write_text(json.dumps(a,indent=2)+'\n')
(w/'coordgeometry1472_adoption.json').write_text(json.dumps(dict(status='PASS',stopped_superseded_pids=stopped,runner_only_digest_replacement=True,report_sha256=H(w/'coordgeometry1446_empirical_report.json')),indent=2)+'\n');print('ADOPTED full original empirical comparison')
