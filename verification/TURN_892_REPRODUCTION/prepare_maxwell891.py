from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import relativistic_field_laws_v1 as src
tag,low,turn,specname,dimension=sys.argv[1:];dim=int(dimension);spec=getattr(src,specname);corr=json.load(open(c/'reference/CORRESPONDENCE.json'))
for m in [tag+x for x in ['Witnesses','Grammar','Controls','Evidence']]:
 for key in ['modules','evidence_modules']:
  for row in corr[key]:
   if row.get('module')=='SFT/Physics/'+m+'.lean':assert row.get('v3_claim')==spec.claim_id
(w/f'{low}{turn}_spec.json').write_text(json.dumps(asdict(spec),indent=2))
s=f'''import SFT.Physics.MaxwellCurvature
namespace SFT.Physics.{tag}Witnesses
open MaxwellCurvature
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def recordCheck : Bool := match maxwellClosure (.integer {dim}) with
 | .error _ => false
 | .ok x => x.dimension=={dim} && x.spatialCurvature=={2*dim} && x.temporalCurvature==2 && same x.totalRatio ⟨{dim},1,by decide,by decide⟩ && same x.speedSquare ⟨1,1,by decide,by decide⟩
def witnesses : List Witness := [WITNESS_ROWS]
theorem recordCheckPassed : recordCheck=true := by unfold recordCheck;rw [{'planarSource' if dim==2 else 'spatialSource'}];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (recordCheck && true)=true
 rw [recordCheckPassed]
 rfl
end SFT.Physics.{tag}Witnesses
''';(w/f'{low}_witness{turn}.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json',f'{low}{turn}_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','MaxwellCurvature')").replace("replace('SpatialThree','FreePhase')",f"replace('SpatialThree','{tag}')").replace('work/freephase_witness883.txt',f'work/{low}_witness{turn}.txt').replace("['dispersionCheck','routeCheck']","['recordCheck']");exec(compile(s,'maxwell891','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'{tag}{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['MaxwellCurvature']+[tag+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
