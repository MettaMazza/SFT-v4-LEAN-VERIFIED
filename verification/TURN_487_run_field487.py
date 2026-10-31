from pathlib import Path
import subprocess,json,os,copy,time,re
r=Path('work/constants-recovery').resolve();ir=r/'.lake/build/ir';entries=json.load(open('work/field487_entries.json'));env=dict(os.environ,LEAN_NUM_THREADS='1',LEAN_PATH=str(r/'.lake/build/lib/lean'));auditcfg={}
common=['SFT/Host/SHA256Window','SFT/Physics/CustodyTypes','SFT/Physics/TargetCustody','SFT/Physics/DimensionComposition','SFT/Physics/DimensionReferenceTransport','SFT/Mathematics/ExactRatioRelations','SFT/Physics/QuantityCarrier','SFT/Physics/ReferenceRealization','SFT/Physics/MechanicalEvents','SFT/Physics/MechanicalDuration','SFT/Physics/MechanicalLocation','SFT/Physics/MechanicalVelocity','SFT/Physics/MechanicalInertia','SFT/Physics/MechanicalMomentum','SFT/Physics/MechanicalAcceleration','SFT/Physics/MechanicalForce','SFT/Mathematics/FoldScalar','SFT/Physics/MechanicalWorkEnergy','SFT/Physics/MechanicalPower','SFT/Physics/MechanicalAngularMotion','SFT/Physics/MechanicalAngularMomentum','SFT/Physics/MechanicalCompositeCentre','SFT/Physics/MechanicalConservation','SFT/Physics/MechanicalConstraintOscillation','SFT/Physics/FieldSourceResponse','SFT/Physics/FieldGeometricDilution','SFT/Physics/FieldGravitation','SFT/Physics/FieldElectricDistinction','SFT/Physics/FieldElectricPotential']
for stem,key,component in entries:
 modules=[stem+t for t in ['Grammar','Evidence','Experiment','Validation','ValidationProofs']];names=[];ths=[];defs=[]
 for m in [component]+modules:
  s=(r/'SFT/Physics'/(m+'.lean')).read_text();ns=re.search(r'^namespace (\S+)',s,re.M)[1]
  for kind,n in re.findall(r'^(def|theorem|inductive|structure|abbrev) (\w+)',s,re.M):
   name=ns+'.'+n;names.append(name)
   if kind=='theorem':ths.append(name)
   if kind in ['def','theorem']:defs.append(name)
  assert not re.search(r'\bsorry\b|^\s*axiom\b',s,re.M)
 auditcfg[stem]=dict(modules=[component]+modules,declarations=names,theorems=ths,definitions_and_theorems=defs)
 p=Path('work/Audit487_'+stem+'.lean');p.write_text('\n'.join('import SFT.Physics.'+m for m in [component]+modules)+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n')
 res=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j','1','-M','1024',str(p)],env=env,text=True,capture_output=True);Path('work/audit487_'+stem+'.log').write_text(res.stdout+res.stderr);assert res.returncode==0,res.stderr+res.stdout
 assert all("'"+n+"' does not depend on any axioms" in res.stdout for n in names)
 # Object files for unchanged prerequisites come from the retained archive; changed/new files are explicit.
 objs=common+['SFT/Physics/'+m for m in modules if not m.endswith('Proofs')]
 objs=[p for p in objs if (ir/(p+'.c.o.export')).exists()]
 for tail in ['Program','ValidationProgram']:
  executable=stem+tail+'487';subprocess.run(['/Users/dolltrading/.elan/bin/lake','env','lean','-c',executable+'.c',executable+'.lean'],cwd=r,env=env,check=True)
  subprocess.run(['/Users/dolltrading/.elan/bin/leanc',str(r/(executable+'.c')),*[str(ir/(m+'.c.o.export')) for m in objs],'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/libsft__v4_SFT.a','-o',str(r.parent/executable)],env=env,check=True)
 for check in ['program','validation']:
  start=time.monotonic();res=subprocess.run(['python3','work/'+stem.lower()+'_'+check+'487.py'],env=env,text=True,capture_output=True);Path('work/'+stem.lower()+'_'+check+'487.log').write_text(res.stdout+res.stderr);print(stem,check,'exit',res.returncode,'seconds',round(time.monotonic()-start,2),flush=True);assert res.returncode==0,res.stdout+res.stderr
 actual=json.load(open('work/'+stem.lower()+'_program487_output.json'));sealed={**actual,'claim_id':'SFT-PHYS-FIELD-'+key.replace('_','-')+'-001','seal_hash':'native-'+stem.lower()+'-487'};cases=[]
 for name in ['original','omitted_candidate','additional_survivor','failed_control']:
  s=copy.deepcopy(sealed)
  if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
  if name=='additional_survivor':s['decisions'][0]['survives']=True
  if name=='failed_control':s['controls'][0]['passed']=False
  p=Path('work/'+stem.lower()+'_independent487_'+name+'.json');p.write_text(json.dumps(s));out=json.loads(subprocess.check_output(['python3','work/'+stem.lower()+'_independent487.py',str(p)],text=True));assert out['passed']==(name=='original');cases.append(dict(case=name,expected=name=='original',actual=out))
 Path('work/'+stem.lower()+'_independent487_report.json').write_text(json.dumps(cases,indent=2)+'\n');Path('work/audit487_config.json').write_text(json.dumps(auditcfg,indent=2)+'\n');print(stem,'all checks PASS',flush=True);subprocess.run(['python3','work/register_field487.py',stem],check=True)
Path('work/audit487_config.json').write_text(json.dumps(auditcfg,indent=2)+'\n')
