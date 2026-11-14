from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.gravity_spacetime_laws_v1 import EQUIVALENCE_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/RedshiftEquivalenceEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'redshift902_spec.json').write_text(json.dumps(asdict(EQUIVALENCE_SPEC),indent=2))
s='''import SFT.Physics.RedshiftEquivalence
namespace SFT.Physics.RedshiftEquivalenceEntryWitnesses
open RedshiftEquivalence
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def equivalenceCheck : Bool := match redshiftEquivalence (.fraction ⟨1,4,by decide,by decide⟩) (.fraction ⟨1,1,by decide,by decide⟩) with
 | .error _ => false
 | .ok x => same x.gravitationalRedshift ⟨1,4,by decide,by decide⟩ && same x.acceleratedDoppler ⟨1,4,by decide,by decide⟩
def witnesses : List Witness := [WITNESS_ROWS]
theorem equivalenceCheckPassed : equivalenceCheck=true := by unfold equivalenceCheck;rw [originalRecord];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (equivalenceCheck && true)=true
 rw [equivalenceCheckPassed]
 rfl
end SFT.Physics.RedshiftEquivalenceEntryWitnesses
''';(w/'redshift_witness902.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','redshift902_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','RedshiftEquivalenceEntry')").replace('work/freephase_witness883.txt','work/redshift_witness902.txt').replace("['dispersionCheck','routeCheck']","['equivalenceCheck']");exec(compile(s,'redshift902','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'RedshiftEquivalenceEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['RedshiftEquivalence']+['RedshiftEquivalenceEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
