from pathlib import Path
import json,hashlib,shutil,datetime
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');assert json.loads((c/'COVERAGE.json').read_text())['summary']['fully_reconstructed_claims']==621
paths={m['path'] for m in json.loads((w/'checkpoint952_manifest.json').read_text())}
for n in [951,952,953]:paths.update(json.loads((w/f'checkpoint{n}_paths.json').read_text()))
s=json.loads((c/'CONTINUATION_STATE.json').read_text());s['terminalhyperfine953_staged']['registered']=True;s['terminalhyperfine953_staged']['remaining']=[];s['checkpoint952_publication_hold']={'resolved':'Allthree correctedwrapperaudit/nativecomparisonsPASS.951/952receiptsrefreshed;953registeredfromcorrectedcode. Superseded952blobs were never committed. Publish onlynewfrozen953manifest.'};s['live_jobs_current']={'molecularspectroscopy954_entry_build':28709,'molecularspectroscopy954_empirical_build':2817};s['continuation_after_live_batch']='Push frozen621checkpoint953 from33266951ef7660405ae43617b882cbf1ab5f4054;deduplicate againstalreadyuploaded952blobs butpublish953manifestonly. Verifyallfiles/head,thenfinish954withpreserved28709/2817. Continue toward750.';(c/'CONTINUATION_STATE.json').write_text(json.dumps(s,indent=2)+'\n')
with (c/'TIMELINE.txt').open('a') as f:f.write('\n'+datetime.datetime.now(datetime.timezone.utc).isoformat()+' — TURN953 corrected batch: all three native empirical reruns passed exact original output after restoring original validator order and passed guard. Lamb/fine source-hash receipts and correspondence refreshed;hyperfine registered621fromcorrectedaudit/config. Mathematical section825appended andcountsupdated. Frozen953supersedesunpublished952snapshot;noGitHubrefusedsupersededwrappercode. Reuseuploadedidenticalblobs,commitonlynew621manifest. Molecular954actualcodeandproofsretained;law28709/empirical2817remainlive.\n')
repro=c/'verification/TURN_953_REPRODUCTION';repro.mkdir(exist_ok=True)
files=[]
for pat in ['*terminalhyperfine*953*.py','paper_terminalhyperfine953_addition.txt','timeline953_addition.txt','recheck_precision_wrappers954.py','refresh_precision_receipts954.py','precision954_wrapper_rechecks.log','freeze953.py']:
 files.extend(w.glob(pat))
for pat in ['TerminalHyperfine*953.lean','LorentzFullAudit953.lean']:files.extend((w/'constants-recovery').glob(pat))
for p in files:
 if p.is_file():q=repro/p.name;shutil.copy2(p,q);paths.add(str(q.relative_to(c)))
# Refresh published reproduction scripts for the corrected validator order.
for low,n in [('terminallamb',951),('terminalfine',952)]:
 p=w/f'prepare_{low}_empirical{n}.py';q=c/'verification/TURN_952_REPRODUCTION'/p.name;shutil.copy2(p,q);paths.add(str(q.relative_to(c)))
ready=w/'checkpoint953_ready';manifest=[]
for path in sorted(paths):
 b=(c/path).read_bytes();p=ready/path;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b);manifest.append(dict(path=path,size=len(b),sha=hashlib.sha1(f'blob {len(b)}\0'.encode()+b).hexdigest()))
(w/'checkpoint953_manifest.json').write_text(json.dumps(manifest,indent=2));print(len(manifest),sum(x['size'] for x in manifest))
