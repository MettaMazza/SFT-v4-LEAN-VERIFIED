from pathlib import Path
import re,subprocess,os
r=Path('work/constants-recovery');modules=['WaveSuperposition','WaveInterference','WaveDiffraction','WavePolarization','WaveDispersion','WaveResonance','WaveEnergyMomentum'];names=[]
for m in modules:
 s=(r/'SFT/Physics'/(m+'.lean')).read_text()
 names += ['SFT.Physics.'+m+'.'+n for _,n in re.findall(r'^(def|theorem|structure) (\w+)',s,re.M)]
p=Path('work/WaveComponents490Audit.lean');p.write_text('\n'.join('import SFT.Physics.'+m for m in modules)+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n')
x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M1024',str(p)],env=dict(os.environ,LEAN_PATH=str((r/'.lake/build/lib/lean').resolve())),capture_output=True,text=True);Path('work/wave490_component_audit.log').write_text(x.stdout+x.stderr)
assert x.returncode==0,x.stdout+x.stderr
assert all("'"+n+"' does not depend on any axioms" in x.stdout for n in names),x.stdout
print(len(names),'declarations zero axioms')
