from pathlib import Path
import json,hashlib,shutil,datetime
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN')
assert json.loads((c/'COVERAGE.json').read_text())['summary']['fully_reconstructed_claims']==622
paths=set(json.loads((w/'checkpoint954_paths.json').read_text()))
paths.add('verification/TURN_953_REMOTE_RECEIPT.json')
s=json.loads((c/'CONTINUATION_STATE.json').read_text());s['live_jobs_current']={'hydrogenrydberg955_core_build':12778};s['continuation_after_live_batch']='Molecular954 full checks and registration complete622. Push checkpoint954; continue hydrogen955 from its original execution/law/validation. Core build12778; no duplicate checks. Milestone750.';(c/'CONTINUATION_STATE.json').write_text(json.dumps(s,indent=2)+'\n')
with (c/'TIMELINE.txt').open('a') as f:f.write('\n'+datetime.datetime.now(datetime.timezone.utc).isoformat()+' — TURN955 continuation: current_step and actual molecular954 logs inspected. Complete native empirical comparison and registration finished;622 entries complete. Reused results without rerunning. Read original hydrogen Rydberg execution, complete law and complete validator. Implemented exact terminal scale, route guard, interval, electron-rest composition and original line-gap guard using existing proton enclosure/reduced-mass and hydrogen ladder. Core build12778 started; not registered or published as verified. Molecular954 paper section826 and evidence frozen for publication.\n')
repro=c/'verification/TURN_954_REPRODUCTION';repro.mkdir(exist_ok=True)
for pat in ['*molecular*954*.py','paper_molecularspectroscopy954_addition.txt','timeline954_addition.txt','freeze954.py']:
 for p in w.glob(pat):
  q=repro/p.name;shutil.copy2(p,q);paths.add(str(q.relative_to(c)))
for p in (w/'constants-recovery').glob('Molecular*954.lean'):
 if 'Probe' not in p.name:
  q=repro/p.name;shutil.copy2(p,q);paths.add(str(q.relative_to(c)))
# Preserve the successful combined build as well as the earlier failure history.
p=w/'precision954_wrapper_correction_build.log';q=repro/p.name;shutil.copy2(p,q);paths.add(str(q.relative_to(c)))
ready=w/'checkpoint954_ready';manifest=[]
for path in sorted(paths):
 b=(c/path).read_bytes();p=ready/path;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b);manifest.append(dict(path=path,size=len(b),sha=hashlib.sha1(f'blob {len(b)}\0'.encode()+b).hexdigest()))
(w/'checkpoint954_manifest.json').write_text(json.dumps(manifest,indent=2));print(len(manifest),sum(x['size'] for x in manifest))
