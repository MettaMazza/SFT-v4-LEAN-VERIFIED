from pathlib import Path
import os,sys,subprocess,json,hashlib
w=Path('work');r=w/'turn1064_recovery';start=int(sys.argv[1]);count=int(sys.argv[2]);tag=f'grandlock1112_{start}_{count}'
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
modules=['GrandLockEntryEvidence','GrandLockGrammar','GrandLockGrammarBase'];hashes={m:hashlib.sha256((r/'SFT/Physics'/f'{m}.lean').read_bytes()).hexdigest()for m in modules}
with(w/(tag+'.jsonl')).open('w')as out,(w/(tag+'.log')).open('w')as err:
 subprocess.run([sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run','work/GrandLockRemaining1112.lean',str(start),str(count)],env=env,stdout=out,stderr=err,check=True)
actual=[json.loads(line)for line in(w/(tag+'.jsonl')).read_text().splitlines()];expected=json.loads((w/'pinned1070/claims/SFT-PHYS-GRAND-LOCK-TERMINAL-075/elimination_receipt.json').read_text())['decisions'];assert len(actual)==count and actual==expected[start:start+count]
for m,h in hashes.items():assert hashlib.sha256((r/'SFT/Physics'/f'{m}.lean').read_bytes()).hexdigest()==h
report={'status':'PASS','start':start,'count':count,'unchanged_original_decideCandidate':True,'all_fields_and_hashes_match':True,'source_sha256':hashes};(w/(tag+'_report.json')).write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
