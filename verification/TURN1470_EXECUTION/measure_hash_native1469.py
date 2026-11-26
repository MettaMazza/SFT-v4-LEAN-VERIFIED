from pathlib import Path
import subprocess,json,re,hashlib
w=Path('work');expected=hashlib.sha256((w/'hash_profile1469.bin').read_bytes()).hexdigest();rows={}
for tag in ['baseline','optimized']:
 build=json.loads((w/('hash_'+tag+'1469_build.json')).read_text());exe=Path(build['executable']);assert hashlib.sha256(exe.read_bytes()).hexdigest()==build['executable_sha256']
 p=subprocess.run(['/usr/bin/time','-p',str(exe)],capture_output=True,text=True,check=True,timeout=30);assert p.stdout.strip()==expected
 rows[tag]={k:float(v)for k,v in re.findall(r'^(real|user|sys)\s+(\d+(?:\.\d+)?)',p.stderr,re.M)};print(tag,rows[tag],flush=True)
r=dict(status='PASS',input_bytes=65536,results=rows,sha256=expected,speedup=rows['baseline']['real']/rows['optimized']['real']);(w/'hash_native_timing1469_report.json').write_text(json.dumps(r,indent=2)+'\n')
