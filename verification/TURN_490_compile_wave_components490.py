from pathlib import Path
import subprocess,os,re
r=Path('work/constants-recovery');env=dict(os.environ,LEAN_PATH=str((r/'.lake/build/lib/lean').resolve()))
for n in ['WaveSuperposition','WaveInterference','WaveDiffraction','WavePolarization','WaveDispersion','WaveResonance','WaveEnergyMomentum']:
 if not (r/'SFT/Physics'/ (n+'.lean')).exists():continue
 p=Path('work')/(n+'490_build.log')
 with p.open('w') as f:a=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M2048','-o',str(r/'.lake/build/lib/lean/SFT/Physics'/(n+'.olean')),str(r/'SFT/Physics'/(n+'.lean'))],stdout=f,stderr=subprocess.STDOUT,env=env)
 print(n,a.returncode,p.read_text(),flush=True)
 if a.returncode:raise SystemExit(a.returncode)
