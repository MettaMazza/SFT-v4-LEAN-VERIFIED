from pathlib import Path
import subprocess,os
w=Path('work');env=dict(os.environ,LEAN_PATH=str((w/'turn1064_recovery').resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');lean=str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean')
for audit in [True,False]:
 args=['python3','work/run_lean_guarded.py',lean,'-j1','-M8192']+([]if audit else ['--run'])+['work/LigandStateSplitting'+('Audit'if audit else 'Program')+'1474.lean']
 with(w/('ligandsplit1474_core_audit.log'if audit else 'ligandsplit1474_core_output.json')).open('w')as out,(w/'ligandsplit1474_check_stderr.log').open('a')as err:subprocess.run(args,env=env,stdout=out,stderr=err,check=True)
subprocess.run(['python3','work/check_ligandsplit1474_core.py'],check=True)
