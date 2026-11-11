from pathlib import Path
import subprocess,os
s=Path('work/build_gblock_native655.py').read_text();exec(s[:s.index('modules=')])
modules=['PeriodicEndpoint','PeriodicEndpointGrammar','PeriodicEndpointEvidence','GBlockOperations','GBlockOrder','GBlockFirstOccupation','GBlockTraversal','GBlockFilling','GBlockWitnesses','GBlockGrammar','GBlockEvidence']
extra=['SFT/Physics/MatterHadrons','SFT/Physics/MatterConservedLabels','SFT/Physics/MatterExchange','SFT/Physics/MatterSpectrum','SFT/Physics/ColourCouplingDerivation','SFT/Physics/AtomicOrbitCapacity','SFT/Physics/AtomicBoundary','SFT/Physics/NuclearClosure']+['SFT/Mathematics/'+m for m in ['OrbitLoopCompletion','OrbitOrderExistence','OrbitReplayCorrespondence','OrbitNumberWitnessBase','OrbitOrderIdentity','OrbitTilingCount','OrbitCyclotomic','OrbitCycleSupport','OrbitBinaryDepth']]
objs=list(dict.fromkeys(common+extra+['SFT/Chemistry/'+m for m in modules]));objs=[m for m in objs if (ir/(m+'.c.o.export')).exists()]
program='PeriodicEndpointProgram655'
for m in ['PeriodicEndpoint','PeriodicEndpointGrammar','PeriodicEndpointEvidence']:
 subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-O2','-c',str(ir/('SFT/Chemistry/'+m+'.c')),'-o',str(ir/('SFT/Chemistry/'+m+'.c.o.export'))],check=True)
subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-c',program+'.c',program+'.lean'],cwd=r,env=env,check=True)
objs=list(dict.fromkeys(common+extra+['SFT/Chemistry/'+m for m in modules]));objs=[m for m in objs if (ir/(m+'.c.o.export')).exists()]
subprocess.run([str(toolchain/'bin/clang'),*flags,str(r/(program+'.c')),*[str(ir/(m+'.c.o.export')) for m in objs],str(Path('work/field533_initializer_bridge.o').resolve()),str(Path('work/LeastCommonReturn533.o').resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/libsft__v4_SFT.a',*libs,'-Wl,-stack_size,0x10000000','-o',str(r.parent/program)],env=env,check=True)
subprocess.run(['python3','work/check_periodicendpoint_native655.py',str(r.parent/program)],check=True)
