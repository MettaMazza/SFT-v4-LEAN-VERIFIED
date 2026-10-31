from pathlib import Path
import subprocess
r=Path('work/constants-recovery').resolve();ir=r/'.lake/build/ir'
modules=['SFT/Host/SHA256Window','SFT/Physics/CustodyTypes','SFT/Physics/TargetCustody','SFT/Physics/ObservationExperiment','SFT/Physics/ObservationValidation','SFT/Physics/QuantityCarrier','SFT/Physics/QuantityGrammar','SFT/Physics/QuantityEvidence','SFT/Physics/QuantityExperiment','SFT/Physics/QuantityValidation','SFT/Physics/DimensionComposition','SFT/Physics/DimensionReferenceTransport','SFT/Mathematics/ExactRatioRelations','SFT/Physics/DimensionGrammar','SFT/Physics/DimensionEvidence','SFT/Physics/DimensionExperiment','SFT/Physics/DimensionValidation','SFT/Physics/UnitGrammar','SFT/Physics/UnitEvidence','SFT/Physics/UnitExperiment','SFT/Physics/UnitValidation']
for stem,num in [('Dimension',479),('Observation',480),('Quantity',480),('Unit',480)]:
 source=stem+'ValidationProgram'+str(num)+'.lean'
 out=stem+'ValidationProgram480_window'
 subprocess.run(['/Users/dolltrading/.elan/bin/lake','env','lean','-c',out+'.c',source],cwd=r,check=True)
 subprocess.run(['/Users/dolltrading/.elan/bin/leanc',str(r/(out+'.c')),*[str(ir/(m+'.c.o.export')) for m in modules],'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/libsft__v4_SFT.a','-o',str(r.parent/out)],check=True)
 script=Path('work/'+stem.lower()+'_validation'+str(num if stem!='Quantity' else 374)+'.py')
 if stem=='Observation':script=Path('work/observation_validation480.py')
 s=script.read_text()
 s=s.replace(stem+'ValidationProgram'+str(num if stem!='Quantity' else 374),out)
 s=s.replace(stem.lower()+'_validation'+str(num if stem!='Quantity' else 374)+'_',stem.lower()+'_validation480_window_')
 Path('work/'+stem.lower()+'_validation480_window.py').write_text(s)
 print(out+' linked',flush=True)
