from pathlib import Path
import json,time,subprocess
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN')
for tag,low,n,cid,label,section in [('CubicPostsealValidation','cubicpostsealvalidation',949,'SFT-PHYS-VALIDATION-ATOMIC-CUBIC-SUPPORT-004','CUBIC_POSTSEAL',821),('HydrogenPostsealValidation','hydrogenpostsealvalidation',950,'SFT-PHYS-VALIDATION-ATOMIC-HYDROGEN-SPECTRUM-004','HYDROGEN_POSTSEAL',822)]:
 while True:
  log=(w/'atomicvalidation949_finish_checks.log').read_text()
  if 'Traceback' in log:raise RuntimeError(log[-3000:])
  p=w/f'{low}{n}_empirical_report.json'
  if p.exists() and json.loads(p.read_text()).get('status')=='PASS':break
  time.sleep(3)
 subprocess.run(['python3',str(w/'register_atomicvalidation949.py'),tag,low,str(n),cid,label,str(section)],check=True)
 print('Registered',n,flush=True)
