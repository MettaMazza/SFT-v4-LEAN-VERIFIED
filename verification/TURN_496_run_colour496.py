from pathlib import Path
import subprocess,json,os,copy,time,re
r=Path('work/constants-recovery').resolve();ir=r/'.lake/build/ir';entries=json.load(open('work/matter496_all_entries.json'));env=dict(os.environ,LEAN_NUM_THREADS='1',LEAN_STACK_SIZE_KB='65536',LEAN_MAIN_USE_THREAD='1',LEAN_PATH=str(r/'.lake/build/lib/lean'));auditcfg={}
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

modules=['ColourCouplingDerivation','ColourCouplingGrammar','ColourCouplingWitnesses','ColourCouplingControls','ColourCouplingEvidence']
names=[];ths=[];defs=[]
for m in modules:
 s=(r/'SFT/Physics'/(m+'.lean')).read_text();ns=re.search(r'^namespace (\S+)',s,re.M)[1]
 assert not re.search(r'\bsorry\b|^\s*axiom\b',s,re.M)
 for kind,n in re.findall(r'^(def|theorem|inductive|structure|abbrev) (\w+)',s,re.M):
  full=ns+'.'+n;names.append(full)
  if kind=='theorem':ths.append(full)
  if kind in ['def','theorem']:defs.append(full)
p=Path('work/Colour496Audit.lean');p.write_text('\n'.join('import SFT.Physics.'+m for m in modules)+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n')
res=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j','1','-M','1024',str(p)],env=env,text=True,capture_output=True);Path('work/colour496_audit.log').write_text(res.stdout+res.stderr);assert res.returncode==0,res.stdout+res.stderr
assert all("'"+n+"' does not depend on any axioms" in res.stdout for n in names),res.stdout
Path('work/colour496_audit_config.json').write_text(json.dumps(dict(modules=modules,declarations=names,theorems=ths,definitions_and_theorems=defs),indent=2))
executable='ColourCouplingProgram496'
subprocess.run(['/Users/dolltrading/.elan/bin/lake','env','lean','-c',executable+'.c',executable+'.lean'],cwd=r,env=env,check=True)
objs=common+['SFT/Physics/'+m for m in modules];objs=[m for m in objs if (ir/(m+'.c.o.export')).exists()]
subprocess.run([str(toolchain/'bin/clang'),*flags,str(r/(executable+'.c')),*[str(ir/(m+'.c.o.export')) for m in objs],str(Path('work/field493_initializer_bridge.o').resolve()),str(Path('work/LeastCommonReturn490.o').resolve()),str(Path('work/native483/CanonicalPackaged.o').resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/libsft__v4_SFT.a',*libs,'-Wl,-stack_size,0x10000000','-o',str(r.parent/executable)],env=env,check=True)
subprocess.run(['python3','work/check_colour496.py'],env=env,check=True)
actual=json.load(open('work/colour496_program_output.json'));sealed={**actual,'claim_id':'SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001','seal_hash':'native-colour-496'};cases=[]
for name in ['original','omitted_candidate','additional_survivor','failed_control']:
 s=copy.deepcopy(sealed)
 if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
 if name=='additional_survivor':s['decisions'][0]['survives']=True
 if name=='failed_control':s['controls'][0]['passed']=False
 p=Path('work/colour496_independent_'+name+'.json');p.write_text(json.dumps(s));out=json.loads(subprocess.check_output(['python3','work/colour496_independent.py',str(p)],text=True));assert out['passed']==(name=='original');cases.append(dict(case=name,expected=name=='original',actual=out))
Path('work/colour496_independent_report.json').write_text(json.dumps(cases,indent=2)+'\n');print('COLOUR ALL CHECKS PASS',flush=True)
