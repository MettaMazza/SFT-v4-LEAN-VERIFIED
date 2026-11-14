from pathlib import Path
import json,hashlib,shutil,datetime
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');assert json.loads((c/'COVERAGE.json').read_text())['summary']['fully_reconstructed_claims']==625
paths=set(json.loads((w/'checkpoint957_paths.json').read_text()));paths.add('verification/TURN_956_REMOTE_RECEIPT.json')
s=json.loads((c/'CONTINUATION_STATE.json').read_text());s['live_jobs_current']={'atomicfieldsplitting958_entry_build':9926};s['atomictransitionrate957_staged'].update(registered=True,remaining=[]);s['atomicfieldsplitting958_staged']={'core':'PASS15empty;273sourcecases','proofs':'arbitrary-inputZeeman,linear/quadraticStarkandcommonadjacentspacing','measurement':'built;fullsourcecomparisonnext','remaining':['complete record/measurementcomparison','full1024lawand256empiricalchecks','paper830','register626andpush']};s['continuation_after_live_batch']='625registered;pushcheckpoint957. Preserve958entry9926. Original958law,execution andvalidationread;coreproofs/273casespass,measurementbuilt. Continue toward750.';(c/'CONTINUATION_STATE.json').write_text(json.dumps(s,indent=2)+'\n')
with (c/'TIMELINE.txt').open('a') as f:f.write('\n'+datetime.datetime.now(datetime.timezone.utc).isoformat()+' — TURN958 continuation: readgoal,current_stepandactualstate;priorworkingturnwasconcreteprogress624andpublished956. Polledexisting82347/59183;957fullnativecomparisonandregistrationcompleted625. No recheckofunchangedcompletedentries. Read958originalexecution/law/validation,translatedallfouroperations,provedallpositive-countmultiplicities andgeneralZeeman/linearStark/quadraticStarkformulas pluscommonadjacentspacing.15coredeclarationsemptyand273originalinputcasespass. Generatedfull1024grammar;firstbuildexposedhyphenatedaxisidentifiers,fixedLeanidentifiersonlyoutsidequotedsourcevalues;restartedfailedbuild9926. Recordandoriginalclassifierimplemented,built;comparisonnext. Freeze625withpaper829andoriginalchecks.\n')
repro=c/'verification/TURN_957_REPRODUCTION';repro.mkdir(exist_ok=True)
for pat in ['*atomictransition*957*.py','paper_atomictransitionrate957_addition.txt','timeline957_addition.txt','freeze957.py']:
 for p in w.glob(pat):
  q=repro/p.name;shutil.copy2(p,q);paths.add(str(q.relative_to(c)))
for p in (w/'constants-recovery').glob('AtomicTransitionRate*957.lean'):
 if 'Inspect' in p.name:continue
 q=repro/p.name;shutil.copy2(p,q);paths.add(str(q.relative_to(c)))
ready=w/'checkpoint957_ready';manifest=[]
for path in sorted(paths):
 b=(c/path).read_bytes();p=ready/path;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b);manifest.append(dict(path=path,size=len(b),sha=hashlib.sha1(f'blob {len(b)}\0'.encode()+b).hexdigest()))
(w/'checkpoint957_manifest.json').write_text(json.dumps(manifest,indent=2));print(len(manifest),sum(x['size'] for x in manifest))
