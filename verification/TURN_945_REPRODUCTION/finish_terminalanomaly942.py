from pathlib import Path
import time,subprocess,json,os
w=Path('work').resolve();c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');lake='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lake'
def wait_log(name,allow_failed=False):
 while True:
  s=(w/name).read_text()
  if 'Build completed successfully' in s:return
  if 'error: build failed' in s:
   if allow_failed:return
   raise RuntimeError(name+' failed')
  time.sleep(10)
def build(mods,log):
 with (w/log).open('w') as f:subprocess.run([lake,'build',*mods],cwd=c,env=dict(os.environ,LEAN_NUM_THREADS='1'),stdout=f,stderr=subprocess.STDOUT,check=True)
# Preserve original running grammars. Refresh only modules affected by record correction.
wait_log('terminalanomaly942_empirical_build.log')
build(['SFT.Physics.TerminalElectronEmpiricalValidation','SFT.Physics.TerminalMuonEmpiricalValidation'],'terminalanomaly942_empirical_build_refreshed.log')
for low,n in [('terminalelectronempirical',942),('terminalmuonempirical',943)]:
 subprocess.run(['python3',str(w/f'prepare_{low}_empirical_native{n}.py')],check=True)
 subprocess.run(['python3',str(w/f'check_{low}_empirical{n}.py')],check=True)
wait_log('terminalanomaly942_law_build.log',True)
wait_log('terminalmuon943_law_build.log')
for tag,low,n in [('TerminalElectronAnomaly','terminalelectron',942),('TerminalMuonAnomaly','terminalmuon',943)]:
 build(['SFT.Physics.'+tag+'EntryEvidence'],f'{low}{n}_canonical_build.log')
 subprocess.run(['python3',str(w/f'check_{low}_entry{n}.py')],check=True)
 subprocess.run(['python3',str(w/f'audit_{low}{n}_all.py')],check=True)
previous=c/'verification/TURN_941_TERMINAL_TURN_COMPLETION.json'
while not previous.exists():time.sleep(10)
for tag,low,n,cid,receipt,section in [('TerminalElectronAnomalyEntry','terminalelectron',942,'SFT-PHYS-QED-ELECTRON-MAGNETIC-ANOMALY-004','TERMINAL_ELECTRON',814),('TerminalMuonAnomalyEntry','terminalmuon',943,'SFT-PHYS-QED-MUON-MAGNETIC-ANOMALY-004','TERMINAL_MUON',815)]:
 subprocess.run(['python3',str(w/f'register_{low}{n}.py'),tag,low,str(n),cid,receipt,str(section)],check=True)
print('COMPLETE registered610 and611',flush=True)
