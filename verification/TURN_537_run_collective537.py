from pathlib import Path
import subprocess,json,os,copy,time,re
r=Path('work/constants-recovery').resolve();ir=r/'.lake/build/ir';entries=json.load(open('work/collective537_entries.json'));env=dict(os.environ,LEAN_NUM_THREADS='1',LEAN_HOST_STACK_SIZE='8192',LEAN_PATH=str(r/'.lake/build/lib/lean'));auditcfg=json.load(open('work/auditcollective537_config.json')) if Path('work/auditcollective537_config.json').exists() else {}
common=['SFT/Host/SHA256Window','SFT/Physics/CustodyTypes','SFT/Physics/TargetCustody','SFT/Physics/DimensionComposition','SFT/Physics/DimensionReferenceTransport','SFT/Mathematics/ExactRatioRelations','SFT/Physics/QuantityCarrier','SFT/Physics/ReferenceRealization','SFT/Physics/MechanicalEvents','SFT/Physics/MechanicalDuration','SFT/Physics/MechanicalLocation','SFT/Physics/MechanicalVelocity','SFT/Physics/MechanicalInertia','SFT/Physics/MechanicalMomentum','SFT/Physics/MechanicalAcceleration','SFT/Physics/MechanicalForce','SFT/Mathematics/FoldScalar','SFT/Physics/MechanicalWorkEnergy','SFT/Physics/MechanicalPower','SFT/Physics/MechanicalAngularMotion','SFT/Physics/MechanicalAngularMomentum','SFT/Physics/MechanicalCompositeCentre','SFT/Physics/MechanicalConservation','SFT/Physics/MechanicalConstraintOscillation','SFT/Physics/FieldSourceResponse','SFT/Physics/FieldGeometricDilution','SFT/Physics/FieldGravitation','SFT/Physics/FieldElectricDistinction','SFT/Physics/FieldElectricPotential','SFT/Physics/FieldMagneticOrientation','SFT/Physics/FieldMagnetic','SFT/Physics/FieldInduction','SFT/Physics/FieldElectromagnetic','SFT/Physics/FieldGaugeEquivalence','SFT/Physics/FieldLocality','SFT/Physics/FieldRadiation','SFT/Physics/FieldInteractionClasses','SFT/Physics/FieldSourceContinuity','SFT/Physics/FieldActionReaction','SFT/Physics/WavePeriodFrequency','SFT/Physics/WavePropagation','SFT/Physics/WaveSpeedRelation']
common += ['SFT/Physics/ThermoMicroMacro', 'SFT/Physics/ThermoTemperature', 'SFT/Physics/ThermoTemperatureOrder', 'SFT/Physics/ThermoEquilibrium', 'SFT/Physics/ThermoEquilibriumExchange', 'SFT/Physics/ThermoHeatWork', 'SFT/Physics/ThermoHeatWorkClasses', 'SFT/Physics/ThermoFirstLaw','SFT/Physics/ThermoFirstLawBalance','SFT/Physics/ThermoEntropy','SFT/Physics/ThermoSecondLaw','SFT/Physics/ThermoThirdLaw','SFT/Physics/ThermoStatisticalWeight','SFT/Physics/ThermoStateRelation','SFT/Physics/ThermoPhaseEquilibrium','SFT/Physics/ThermoKineticTransport','SFT/Physics/ThermoFluctuation','SFT/Physics/ThermoIrreversibility','SFT/Physics/ThermoResponse']


common += ['SFT/Physics/CollectiveCoarseGrain','SFT/Physics/CollectiveDensity','SFT/Physics/CollectivePressure']
for stem,key,component in entries:
 if stem in ["Superposition","Interference","Diffraction","Polarization","Dispersion"]:continue # Already passed and registered; do not rerun.
 required=[r/'.lake/build/lib/lean/SFT/Physics'/(stem+'ValidationProofs.olean')]+[ir/('SFT/Physics/'+m+'.c.o.export') for m in [component]+[stem+t for t in ['Grammar','Evidence','Experiment','Validation']]]
 assert all(p.exists() for p in required), "Required build artifacts missing"
 modules=[stem+t for t in ['Grammar','Evidence','Experiment','Validation','ValidationProofs']];names=[];ths=[];defs=[]
 for m in (['FieldMagneticOrientation'] if stem=='Magnetic' else [])+[component]+modules:
  s=(r/'SFT/Physics'/(m+'.lean')).read_text();ns=re.search(r'^namespace (\S+)',s,re.M)[1]
  for kind,n in re.findall(r'^(def|theorem|inductive|structure|abbrev) (\w+)',s,re.M):
   name=ns+'.'+n;names.append(name)
   if kind=='theorem':ths.append(name)
   if kind in ['def','theorem']:defs.append(name)
  assert not re.search(r'\bsorry\b|^\s*axiom\b',s,re.M)
 auditcfg[stem]=dict(modules=(['FieldMagneticOrientation'] if stem=='Magnetic' else [])+[component]+modules,declarations=names,theorems=ths,definitions_and_theorems=defs)
 p=Path('work/Auditcollective537_'+stem+'.lean');p.write_text('\n'.join('import SFT.Physics.'+m for m in (['FieldMagneticOrientation'] if stem=='Magnetic' else [])+[component]+modules)+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n')
 res=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j','1','-M','1024',str(p)],env=env,text=True,capture_output=True);Path('work/auditcollective537_'+stem+'.log').write_text(res.stdout+res.stderr);assert res.returncode==0,res.stderr+res.stdout
 assert all("'"+n+"' does not depend on any axioms" in res.stdout for n in names)
 # Object files for unchanged prerequisites come from the retained archive; changed/new files are explicit.
 objs=common+['SFT/Physics/'+m for m in modules if not m.endswith('Proofs')]
 objs=[p for p in objs if (ir/(p+'.c.o.export')).exists()]
 for tail in ['Program','ValidationProgram']:
  executable=stem+tail+'537';subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-c',executable+'.c',executable+'.lean'],cwd=r,env=env,check=True)
  subprocess.run(['/Users/dolltrading/.elan/bin/leanc',str(r/(executable+'.c')),*[str(ir/(m+'.c.o.export')) for m in objs],str(Path('work/field533_initializer_bridge.o').resolve()),str(Path('work/LeastCommonReturn533.o').resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/libsft__v4_SFT.a','-o',str(r.parent/executable)],env=env,check=True)
 for check in ['program','validation']:
  start=time.monotonic();res=subprocess.run(['python3','work/'+stem.lower()+'_'+check+'537.py'],env=env,text=True,capture_output=True);Path('work/'+stem.lower()+'_'+check+'537.log').write_text(res.stdout+res.stderr);print(stem,check,'exit',res.returncode,'seconds',round(time.monotonic()-start,2),flush=True);assert res.returncode==0,res.stdout+res.stderr
 actual=json.load(open('work/'+stem.lower()+'_program537_output.json'));sealed={**actual,'claim_id':json.load(open('work/collective537_metadata.json'))[stem]['claim_id'],'seal_hash':'native-'+stem.lower()+'-537'};cases=[]
 for name in ['original','omitted_candidate','additional_survivor','failed_control']:
  s=copy.deepcopy(sealed)
  if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
  if name=='additional_survivor':s['decisions'][0]['survives']=True
  if name=='failed_control':s['controls'][0]['passed']=False
  p=Path('work/'+stem.lower()+'_independent537_'+name+'.json');p.write_text(json.dumps(s));out=json.loads(subprocess.check_output(['python3','work/'+stem.lower()+'_independent537.py',str(p)],text=True));assert out['passed']==(name=='original');cases.append(dict(case=name,expected=name=='original',actual=out))
 Path('work/'+stem.lower()+'_independent537_report.json').write_text(json.dumps(cases,indent=2)+'\n');Path('work/auditcollective537_config.json').write_text(json.dumps(auditcfg,indent=2)+'\n');print(stem,'all checks PASS',flush=True)
Path('work/auditcollective537_config.json').write_text(json.dumps(auditcfg,indent=2)+'\n')
