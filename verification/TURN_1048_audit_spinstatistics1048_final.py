from pathlib import Path
import re,subprocess,os,json,hashlib
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work');mods=['SpinStatisticsCriticalExecution','SpinStatisticsCriticalSelection','SpinStatisticsGroundRecord'];names=[];hashes={}
for m in mods:
 body=(r/f'SFT/Physics/{m}.lean').read_text();hashes[m]=hashlib.sha256(body.encode()).hexdigest();ns=re.search(r'^namespace (\S+)',body,re.M)[1];names += [ns+'.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',body,re.M)]
p=w/'spinstatistics1048_final_audit.lean';p.write_text('import SFT.Physics.SpinStatisticsGroundRecord\n'+''.join('#print axioms '+n+'\n'for n in names));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},text=True,capture_output=True);(w/'spinstatistics1048_final_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and all("'"+n+"' does not depend on any axioms"in x.stdout for n in names),x.stdout[-2500:]
(w/'spinstatistics1048_final_report.json').write_text(json.dumps(dict(status='PASS',modules=mods,declarations=names,source_sha256=hashes,axioms=[]),indent=2));print('PASS',len(mods),'modules',len(names),'zeroaxiom declarations')
