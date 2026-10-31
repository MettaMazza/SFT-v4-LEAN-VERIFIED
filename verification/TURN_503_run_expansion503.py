from pathlib import Path
import subprocess,json,os,copy,time,re
r=Path('work/constants-recovery').resolve();ir=r/'.lake/build/ir';entries=json.load(open('work/expansion503_entries.json'));env=dict(os.environ,LEAN_NUM_THREADS='1',LEAN_STACK_SIZE_KB='65536',LEAN_MAIN_USE_THREAD='1',LEAN_PATH=str(r/'.lake/build/lib/lean'));auditcfg={}
common=['SFT/Host/SHA256Window','SFT/Physics/CustodyTypes','SFT/Physics/TargetCustody','SFT/Physics/DimensionComposition','SFT/Physics/DimensionReferenceTransport','SFT/Mathematics/ExactRatioRelations','SFT/Physics/QuantityCarrier','SFT/Physics/ReferenceRealization','SFT/Physics/MechanicalEvents','SFT/Physics/MechanicalDuration','SFT/Physics/MechanicalLocation','SFT/Physics/MechanicalVelocity','SFT/Physics/MechanicalInertia','SFT/Physics/MechanicalMomentum','SFT/Physics/MechanicalAcceleration','SFT/Physics/MechanicalForce','SFT/Mathematics/FoldScalar','SFT/Physics/MechanicalWorkEnergy','SFT/Physics/MechanicalPower','SFT/Physics/MechanicalAngularMotion','SFT/Physics/MechanicalAngularMomentum','SFT/Physics/MechanicalCompositeCentre','SFT/Physics/MechanicalConservation','SFT/Physics/MechanicalConstraintOscillation','SFT/Physics/FieldSourceResponse','SFT/Physics/FieldGeometricDilution','SFT/Physics/FieldGravitation','SFT/Physics/FieldElectricDistinction','SFT/Physics/FieldElectricPotential','SFT/Physics/FieldMagneticOrientation','SFT/Physics/FieldMagnetic','SFT/Physics/FieldInduction','SFT/Physics/FieldElectromagnetic','SFT/Physics/FieldGaugeEquivalence','SFT/Physics/FieldLocality','SFT/Physics/FieldRadiation','SFT/Physics/FieldInteractionClasses','SFT/Physics/FieldSourceContinuity','SFT/Physics/FieldActionReaction','SFT/Physics/WavePeriodFrequency','SFT/Physics/WavePropagation','SFT/Physics/WaveSpeedRelation']
common += ['SFT/Physics/WaveSuperposition', 'SFT/Physics/WaveInterference', 'SFT/Physics/WaveDiffraction', 'SFT/Physics/WavePolarization', 'SFT/Physics/WaveDispersion', 'SFT/Physics/WaveResonance', 'SFT/Physics/WaveEnergyMomentum', 'SFT/Physics/QuantumPhysicalState', 'SFT/Physics/QuantumPhysicalEvolution', 'SFT/Physics/QuantumPhysicalObservable', 'SFT/Physics/QuantumPhysicalWeight']
common += ['SFT/Mathematics/LeastCommonReturn']
common += ['SFT/Physics/QuantumPhysicalIncompatibility', 'SFT/Physics/QuantumPhysicalSpin', 'SFT/QuantumComputation/InformationUnit', 'SFT/QuantumComputation/ReversibleInterpretation', 'SFT/QuantumComputation/ReversibleExecution', 'SFT/QuantumComputation/ReversibleWitnesses', 'SFT/QuantumComputation/ReversibleCorrection', 'SFT/QuantumComputation/ReversibleFaults', 'SFT/QuantumComputation/ReversibleObservation', 'SFT/QuantumComputation/ReversibleComposition', 'SFT/QuantumComputation/ReversibleApplication', 'SFT/QuantumComputation/ReversiblePhase', 'SFT/QuantumComputation/ReversibleModel', 'SFT/QuantumComputation/ClassicalCorrespondence', 'SFT/QuantumComputation/Algorithms', 'SFT/QuantumComputation/Circuit', 'SFT/QuantumComputation/Measurement', 'SFT/QuantumComputation/GateLaw', 'SFT/QuantumComputation/PhaseInterference', 'SFT/QuantumComputation/Complexity', 'SFT/QuantumComputation/Superposition']
subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-c','work/field493_initializer_bridge.c','-o','work/field493_initializer_bridge.o'],check=True)
toolchain=Path('/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0')
flags=['-I',str(toolchain/'include'),'-fstack-clash-protection','-ffp-contract=off','-fdata-sections','-ffunction-sections','-fvisibility=hidden','--sysroot',str(toolchain),'-nostdinc','-isystem',str(toolchain/'include/clang')]
libs=['-L',str(toolchain/'lib'),'-L',str(toolchain/'lib/libc'),'-fuse-ld=/usr/bin/ld','-L',str(toolchain/'lib/lean'),'-lleancpp','-lInit','-lStd','-lLean','-lleanrt','-lc++','-lLake','-lLeanExport','-lgmp','-luv','-lssl','-lcrypto','-Wl,-dead_strip','-Wno-unused-command-line-argument']

common += ['SFT/Physics/QuantumPhysicalIdentity', 'SFT/Physics/QuantumPhysicalExclusion']
common += ['SFT/Physics/QuantumPhysicalTunnelling', 'SFT/Physics/QuantumPhysicalSpectra', 'SFT/Physics/QuantumPhysicalEntanglement', 'SFT/Physics/QuantumPhysicalBell']
common += ['SFT/Physics/QuantumPhysicalContextuality', 'SFT/Physics/QuantumPhysicalDecoherence']
common += ['SFT/Physics/QuantumPhysicalClassicalLimit', 'SFT/Physics/QuantumPhysicalNoSignalling']
common += ['SFT/Physics/MatterMassEnergy', 'SFT/Physics/MatterAntiparticle']
common += ['SFT/Physics/EvolutionGrammar','SFT/Physics/EvolutionEvidence','SFT/Physics/EvolutionExperiment']
common += ['SFT/Physics/MatterExchange','SFT/Physics/MatterConservedLabels']
common += ['SFT/Physics/MatterSpectrum', 'SFT/Physics/MatterHadrons', 'SFT/Physics/MatterScattering', 'SFT/Physics/MatterDecay']
common += ['SFT/Physics/MatterMixing', 'SFT/Physics/NuclearBinding', 'SFT/Physics/NuclearLevels', 'SFT/Physics/NuclearRadioactivity']
common += ['SFT/Physics/NuclearReactions', 'SFT/Physics/NuclearFission']
common += ['SFT/Physics/SpacetimeEvent', 'SFT/Physics/SpacetimeInterval', 'SFT/Physics/SpacetimeCausalOrder','SFT/Physics/SpacetimeInertial','SFT/Physics/SpacetimeLimitSpeed','SFT/Physics/SpacetimeClockRate','SFT/Physics/SpacetimeLengthRelation','SFT/Physics/GravityEquivalence','SFT/Physics/GravityCurvature','SFT/Physics/GravityGeodesic','SFT/Physics/GravityGeodesicSelection','SFT/Physics/GravityGeodesicBridge','SFT/Physics/GravityFieldSource','SFT/Physics/GravityWave','SFT/Physics/BoundarySupport','SFT/Physics/GravityHorizon','SFT/Physics/CosmoRedshift']
for stem,key,component in entries:
 if False:continue # Passed checks already; registration resumed separately.
 required=[r/'.lake/build/lib/lean/SFT/Physics'/(stem+'ValidationProofs.olean')]+[ir/('SFT/Physics/'+m+'.c.o.export') for m in [component]+[stem+t for t in ['Grammar','Evidence','Experiment','Validation']]]
 while not all(p.exists() for p in required):
  time.sleep(2)
 modules=[stem+t for t in ['Grammar','Evidence','Experiment','Validation','ValidationProofs']]+[];names=[];ths=[];defs=[]
 for m in (['FieldMagneticOrientation'] if stem=='Magnetic' else [])+[component]+modules:
  s=(r/'SFT/Physics'/(m+'.lean')).read_text();ns=re.search(r'^namespace (\S+)',s,re.M)[1]
  for kind,n in re.findall(r'^(def|theorem|inductive|structure|abbrev) (\w+)',s,re.M):
   name=ns+'.'+n;names.append(name)
   if kind=='theorem':ths.append(name)
   if kind in ['def','theorem']:defs.append(name)
  assert not re.search(r'\bsorry\b|^\s*axiom\b',s,re.M)
 auditcfg[stem]=dict(modules=(['FieldMagneticOrientation'] if stem=='Magnetic' else [])+[component]+modules,declarations=names,theorems=ths,definitions_and_theorems=defs)
 p=Path('work/Auditexpansion503_'+stem+'.lean');p.write_text('\n'.join('import SFT.Physics.'+m for m in (['FieldMagneticOrientation'] if stem=='Magnetic' else [])+[component]+modules)+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n')
 res=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j','1','-M','1024',str(p)],env=env,text=True,capture_output=True);Path('work/auditexpansion503_'+stem+'.log').write_text(res.stdout+res.stderr);assert res.returncode==0,res.stderr+res.stdout
 assert all("'"+n+"' does not depend on any axioms" in res.stdout for n in names)
 # Object files for unchanged prerequisites come from the retained archive; changed/new files are explicit.
 objs=common+['SFT/Physics/'+component]+['SFT/Physics/'+m for m in modules if not m.endswith('Proofs')]
 objs=list(dict.fromkeys(p for p in objs if (ir/(p+'.c.o.export')).exists()))
 for tail in ['Program','ValidationProgram']:
  executable=stem+tail+'503';subprocess.run(['/Users/dolltrading/.elan/bin/lake','env','lean','-c',executable+'.c',executable+'.lean'],cwd=r,env=env,check=True)
  subprocess.run([str(toolchain/'bin/clang'),*flags,str(r/(executable+'.c')),*[str(ir/(m+'.c.o.export')) for m in objs],str(Path('work/field493_initializer_bridge.o').resolve()),str(Path('work/LeastCommonReturn490.o').resolve()),*([str(Path('work/native491').resolve()/(m+'.o')) for m in ['LeptonDecimal','EvolutionMeasuredSource']]+[str(Path('work/native503/MassEnergyMeasured.o').resolve())] if stem=='MassEnergy' else []),str(Path('work/native483/CanonicalPackaged.o').resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/libsft__v4_SFT.a',*libs,'-Wl,-stack_size,0x10000000','-o',str(r.parent/executable)],env=env,check=True)
 for check in ['program','validation']:
  start=time.monotonic();res=subprocess.run(['python3','work/'+stem.lower()+'_'+check+'503.py'],env=env,text=True,capture_output=True);Path('work/'+stem.lower()+'_'+check+'503.log').write_text(res.stdout+res.stderr);print(stem,check,'exit',res.returncode,'seconds',round(time.monotonic()-start,2),flush=True);assert res.returncode==0,res.stdout+res.stderr
 actual=json.load(open('work/'+stem.lower()+'_program503_output.json'));sealed={**actual,'claim_id':json.load(open('work/expansion503_metadata.json'))[stem]['claim_id'],'seal_hash':'native-'+stem.lower()+'-503'};cases=[]
 for name in ['original','omitted_candidate','additional_survivor','failed_control']:
  s=copy.deepcopy(sealed)
  if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
  if name=='additional_survivor':s['decisions'][0]['survives']=True
  if name=='failed_control':s['controls'][0]['passed']=False
  p=Path('work/'+stem.lower()+'_independent503_'+name+'.json');p.write_text(json.dumps(s));out=json.loads(subprocess.check_output(['python3','work/'+stem.lower()+'_independent503.py',str(p)],text=True));assert out['passed']==(name=='original');cases.append(dict(case=name,expected=name=='original',actual=out))
 Path('work/'+stem.lower()+'_independent503_report.json').write_text(json.dumps(cases,indent=2)+'\n');Path('work/auditexpansion503_config.json').write_text(json.dumps(auditcfg,indent=2)+'\n');print(stem,'all checks PASS',flush=True)
Path('work/auditexpansion503_config.json').write_text(json.dumps(auditcfg,indent=2)+'\n')
