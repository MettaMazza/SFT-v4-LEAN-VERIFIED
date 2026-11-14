from pathlib import Path
import json,hashlib,shutil,datetime
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');assert json.loads((c/'COVERAGE.json').read_text())['summary']['fully_reconstructed_claims']==623
paths=set(json.loads((w/'checkpoint955_paths.json').read_text()));paths.update(['verification/TURN_954_REMOTE_RECEIPT.json','verification/TURN_954_MOLECULAR_SPECTROSCOPY_COMPLETION.json'])
s=json.loads((c/'CONTINUATION_STATE.json').read_text());s['live_jobs_current']={'atomicshell956_entry_build':18959,'atomicshell956_full_checks':37553,'atomicshell956_registration':24428};s['hydrogenrydberg955_staged']['remaining']=[];s['hydrogenrydberg955_staged']['registered']=True;s['atomictransitionrate957_staged']={'source':'sft/physics/atomic_transition_rate_successor_laws_v1.py','core_build':'PASS','core_axioms':'14empty','source_comparison':'PASS114rate,11exponent,10ratio,9lifetime cases','remaining':['complete source successor/suppression proof correspondence','entry grammar/controls and empirical binding','register after956']};s['continuation_after_live_batch']='623registeredwith955completechecks. Pushfrozen955; preserve95618959/37553/24428.957corestagedbutnotregistered. Continue toward750.';(c/'CONTINUATION_STATE.json').write_text(json.dumps(s,indent=2)+'\n')
with (c/'TIMELINE.txt').open('a') as f:f.write('\n'+datetime.datetime.now(datetime.timezone.utc).isoformat()+' — TURN955 verified checkpoint: complete hydrogen native law,all1024decisions,all256empiricaldecisions,originalfourindependentcases andentireempiricalvalidator output passed.234declarations emptyaxioms;623registered andpaper827appended. Shell956core/record/measurement checks retained;full entry18959 andcheck37553withregistrar24428preserved. Implemented next957original four transition-rate operations andguards,exact lifetime sum,universal2L+1exponent/successor;14declarations empty,144sourcecases matched. Remaining957source-specific successor/suppression proof correspondence,grammar andvalidator binding not registered. Freezingverified955paths forGitHub.\n')
repro=c/'verification/TURN_955_REPRODUCTION';repro.mkdir(exist_ok=True)
for pat in ['*hydrogen*955*.py','paper_hydrogenrydberg955_addition.txt','timeline955_addition.txt','freeze955.py','hydrogenshell955956_correction_build.log']:
 for p in w.glob(pat):
  q=repro/p.name;shutil.copy2(p,q);paths.add(str(q.relative_to(c)))
for p in (w/'constants-recovery').glob('Hydrogen*955.lean'):
 q=repro/p.name;shutil.copy2(p,q);paths.add(str(q.relative_to(c)))
ready=w/'checkpoint955_ready';manifest=[]
for path in sorted(paths):
 b=(c/path).read_bytes();p=ready/path;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b);manifest.append(dict(path=path,size=len(b),sha=hashlib.sha1(f'blob {len(b)}\0'.encode()+b).hexdigest()))
(w/'checkpoint955_manifest.json').write_text(json.dumps(manifest,indent=2));print(len(manifest),sum(x['size'] for x in manifest))
