from pathlib import Path
import json,hashlib,shutil,datetime
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');cov=json.load(open(c/'COVERAGE.json'));assert cov['summary']['fully_reconstructed_claims']==613
paths={'verification/TURN_939_REMOTE_RECEIPT.json'}
for n in range(940,946):paths.update(json.load(open(w/f'checkpoint{n}_paths.json')))
s=json.load(open(c/'CONTINUATION_STATE.json'))
for low,n in [('terminalproton',940),('terminalturn',941),('terminalelectron',942),('terminalmuon',943),('cubicatomic',944),('hydrogen',945)]:
 receipt=json.load(open(c/next(p for p in paths if p.startswith(f'verification/TURN_{n}_') and p.endswith('_COMPLETION.json'))));assert receipt['status']=='complete';s[low+str(n)+'_staged']={'registered':True,'remaining':[],'receipt':next(p for p in paths if p.startswith(f'verification/TURN_{n}_') and p.endswith('_COMPLETION.json'))}
s['recorded_at']=datetime.datetime.now(datetime.timezone.utc).isoformat();s['continuation_after_live_batch']='Push and verify this frozen613 checkpoint from parent091bf502f44388c8d880e284e74a18d94a285ccf,then continue scientific_cursor.next in dependency order,retaining946–948 staged builds and checks. Reuse all completed940–945 evidence. No milestone pause before750.';(c/'CONTINUATION_STATE.json').write_text(json.dumps(s,indent=2))
with (c/'TIMELINE.txt').open('a') as f:f.write('\n'+s['recorded_at']+' — TURN945 verified batch checkpoint:608–613 registered in dependency order after full original source operations,zero-axiom audits,complete candidate/program comparisons and applicable empirical validators. Retained full2048 proton,512 turn,1024 electron,1024 muon,256 cubic and256 hydrogen grammars. Cumulative mathematical sections812–817 appended. Prepared frozen613 edition for authorized GitHub push;no Zenodo publication or milestone pause.\n')
repro=c/'verification/TURN_945_REPRODUCTION';repro.mkdir(exist_ok=True)
files=[]
for pattern in ['*terminalproton*940*','*terminalturn*941*','*terminalelectron*942*','*terminalmuon*943*','*terminalanomaly*942*','*cubicatomic*944*','*hydrogen*945*','paper_*94[0-5]*','timeline94[0-5]_addition.txt']:
 files.extend(w.glob(pattern))
for pattern in ['TerminalProton*940.lean','TerminalTurn*941.lean','TerminalElectron*942.lean','TerminalMuon*943.lean','TerminalAnomaly*942.lean','CubicAtomicSupport*944.lean','HydrogenAudit945.lean','HydrogenCompare945.lean','HydrogenSpectrumProgram945.lean','LorentzFullAudit94[0-5].lean']:
 files.extend((w/'constants-recovery').glob(pattern))
files += [w/n for n in ['generate_freephase883.py','spatial268.py','gen043.py','prepare_vacuum_validations879.py','prepare_vacuum_checks879.py','prepare_sector_program875.py','prepare_terminalanomaly_entries942.py','prepare_terminalanomaly_empirical942.py','prepare_terminalanomaly_audits942.py','prepare_terminalanomaly_registration942.py','freeze945.py']]
for p in files:
 if p.is_file() and p.suffix in ['.py','.txt','.json','.lean']:
  q=repro/p.name;shutil.copy2(p,q);paths.add(str(q.relative_to(c)))
ready=w/'checkpoint945_ready';ready.mkdir(exist_ok=True);manifest=[]
for path in sorted(paths):
 data=(c/path).read_bytes();dest=ready/path;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(data);manifest.append(dict(path=path,size=len(data),sha=hashlib.sha1(f'blob {len(data)}\0'.encode()+data).hexdigest()))
(w/'checkpoint945_manifest.json').write_text(json.dumps(manifest,indent=2));print(len(manifest),'files',sum(x['size'] for x in manifest),'bytes')
