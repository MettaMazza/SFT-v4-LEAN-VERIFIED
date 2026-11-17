from pathlib import Path
import ast,json
w=Path('work');r=w/'turn1064_recovery'
def translated(s):
 return s.replace('death1161','patient1234').replace('LifeDeath','PatientIdentity').replace('1161','1234').replace('SFT-BIO-LIFE-DEATH-001','SFT-MED-PATIENT-IDENTITY-001').replace('BIOLOGY_SPECS','MEDICINE_SPECS').replace('Biology','Medicine').replace('biology','medicine')
for stem in ['check_death1161_program.py','check_death1161_empirical.py','LifeDeathValidationProgram1161.lean']:
 s=translated((w/stem).read_text())
 s=s.replace('from sft.medicine.generated_law import','from sft.medicine.empirical_program import').replace("'sft/medicine/generated_law.py'","'sft/medicine/empirical_program.py'").replace("'sft/medicine/derivation.py'","'sft/medicine/generated_law.py'")
 s=s.replace("'PatientIdentitySource','PatientIdentityExperiment'","'PatientIdentitySource','PatientIdentitySeal','PatientIdentityExperiment'").replace("'original_snapshots':17","'original_snapshots':24,'source_records':13,'captured_sources':11,'failed_sources':2")
 dest=stem.replace('death1161','patient1234').replace('LifeDeath','PatientIdentity').replace('1161','1234')
 if dest.endswith('.py'):ast.parse(s)
 (w/dest).write_text(s)
(r/'PatientIdentityProgram1234.lean').write_text(translated((r/'LifeDeathProgram1161.lean').read_text()))
mods=['PatientIdentity'+s for s in ['','Grammar','Evidence','Source','Seal','Experiment','Validation']]
s='''from pathlib import Path
import os,subprocess
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean',LEAN_NUM_THREADS='1')
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'
'''+ 'mods='+repr(mods)+'''
for mod in mods:
 p=r/'SFT/Medicine'/(mod+'.lean')
 with (w/('patient1234_'+mod+'_build.log')).open('w')as log:
  subprocess.run(['python3','work/run_lean_guarded.py',lean,'-j1','-M8192','-o',str(p.with_suffix('.olean')),str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
 print(mod+' compiled',flush=True)
'''
ast.parse(s);(w/'build_patient1234_all.py').write_text(s)
# Check the original execution manifest before any native launch.
s=(w/'check_patient1234_program.py').read_text();end=s.index("p=subprocess.run(lean+");exec(compile(s[:end],'patient-original-manifest','exec'),{})
print('Original PatientIdentity execution manifest matches its pinned certificate; seven-module native checks prepared.')
