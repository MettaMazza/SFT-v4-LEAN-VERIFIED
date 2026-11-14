from pathlib import Path
import json,sys,shutil
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import POTENTIAL_PHASE_SPEC
(w/'potentialphase884_spec.json').write_text(json.dumps(asdict(POTENTIAL_PHASE_SPEC),indent=2))
s=(w/'freephase_witness883.txt').read_text().replace('FreePhaseWitnesses','PotentialPhaseWitnesses').replace('def original := freeParticlePhase (.fraction ⟨1,3,by decide,by decide⟩) (.fraction ⟨1,4,by decide,by decide⟩)','def original := potentialPhaseEvolution (.fraction ⟨1,3,by decide,by decide⟩) (.fraction ⟨1,8,by decide,by decide⟩) (.fraction ⟨1,4,by decide,by decide⟩)').replace('dispersionCheck','compositionCheck').replace('routeCheck','totalCheck').replace('t.dispersion','t.2.2.2').replace('⟨1,2,by decide,by decide⟩','⟨17,24,by decide,by decide⟩').replace('t.phaseAfter','t.2.2.1').replace('⟨5,6,by decide,by decide⟩','⟨3,8,by decide,by decide⟩').replace('originalAssembly','originalPotentialAssembly');(w/'potentialphase_witness884.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','potentialphase884_spec.json').replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','PotentialPhase')").replace('work/freephase_witness883.txt','work/potentialphase_witness884.txt').replace("['dispersionCheck','routeCheck']","['compositionCheck','totalCheck']");exec(compile(s,'potential884','exec'))
import re
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'PotentialPhase{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for suffix in ['Witnesses','Grammar','Controls','Evidence']:shutil.copy2(r/'SFT/Physics'/f'PotentialPhase{suffix}.lean',c/'SFT/Physics'/f'PotentialPhase{suffix}.lean')
