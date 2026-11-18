from pathlib import Path
import os,subprocess
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean',LEAN_NUM_THREADS='1')
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'
mods=['EvidenceSynthesis', 'EvidenceSynthesisGrammar', 'EvidenceSynthesisEvidence', 'EvidenceSynthesisSource',  'EvidenceSynthesisExperiment', 'EvidenceSynthesisValidation']
for mod in mods:
 p=r/'SFT/Medicine'/(mod+'.lean')
 with (w/('evidencesynthesis1287_'+mod+'_build.log')).open('w')as log:
  subprocess.run(['python3','work/run_lean_guarded.py',lean,'-j1','-M8192','-o',str(p.with_suffix('.olean')),str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
 print(mod+' compiled',flush=True)
