from pathlib import Path
w=Path('work');r=w/'constants-recovery'
items=[('pmnsphysical', 922, 'PMNSPhysicalEntry', 'PMNSPhysical', 'PMNS_CP_SPEC', 'NEUTRINO-PMNS-CP-PHYSICAL', 'pmnsCPStructure', 'decide (f.electronWeights=originalRecord.electronWeights) && decide (f.cpPhase=(⟨1,2,by decide,by decide⟩ : Rat))')]
for low,n,tag,program,spec,cid,op,check in items:
 s=(w/'prepare_ckmfibres917.py').read_text().replace('CKM_FIBRE_SPEC',spec).replace('ckmfibres917',low+str(n)).replace('ckmfibres_witness917',low+'_witness'+str(n)).replace('CKMFibreEntry',tag).replace('CKMFibres','PMNSPhysical').replace('matrixCheck','identityCheck')
 a=s.index('def identityCheck : Bool :=');b=s.index('def witnesses',a);s=s[:a]+f'def identityCheck : Bool := match {op} with\n | .error _ => false\n | .ok f => {check}\n'+s[b:];(w/f'prepare_{low}{n}.py').write_text(s)
 for kind in ['entry','program','independent','original']:
  s=(w/f'check_ckmfibres_{kind}917.py').read_text().replace('917',str(n)).replace('ckmfibres',low).replace('CKMFibreEntry',tag).replace('CKMFibresProgram',program+'Program').replace('CKMFibres','PMNSPhysical').replace('MATTER-CKM-FIBRE',cid).replace('CKM_FIBRE_SPEC',spec);(w/f'check_{low}_{kind}{n}.py').write_text(s)
 s=(w/'prepare_ckmfibres_native917.py').read_text().replace('917',str(n)).replace('CKMFibreEntry',tag).replace('CKMFibresProgram',program+'Program');(w/f'prepare_{low}_native{n}.py').write_text(s)
 (r/f'{program}Program{n}.lean').write_text((r/'CKMFibresProgram917.lean').read_text().replace('CKMFibreEntry',tag))
import subprocess
for low,n,*_ in items:subprocess.run(['python3',str(w/f'prepare_{low}{n}.py')],check=True)
