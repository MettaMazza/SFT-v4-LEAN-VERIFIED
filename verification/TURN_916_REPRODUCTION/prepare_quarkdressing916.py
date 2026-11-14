from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.matter_flavour_laws_v1 import QUARK_DRESSING_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/QuarkDressingEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'quarkdressing916_spec.json').write_text(json.dumps(asdict(QUARK_DRESSING_SPEC),indent=2))
s='''import SFT.Physics.QuarkDressing
namespace SFT.Physics.QuarkDressingEntryWitnesses
open QuarkDressing
structure Witness where
 name : String
 statement : String
 passed : Bool
def factorsCheck : Bool := match quarkDressingFactors with
 | .error _ => false
 | .ok f => (SFT.Foundation.ExactPartCarrier.asFraction SFT.Foundation.ExactOperations.one).blt f.centralDownLift && SFT.Physics.LeptonIntervals.zero.blt f.upperUpRetention && f.upperUpRetention.blt (SFT.Foundation.ExactPartCarrier.asFraction SFT.Foundation.ExactOperations.one)
def witnesses : List Witness := [WITNESS_ROWS]
theorem factorsCheckPassed : factorsCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.QuarkDressingEntryWitnesses
''';(w/'quarkdressing_witness916.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','quarkdressing916_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','QuarkDressingEntry')").replace('work/freephase_witness883.txt','work/quarkdressing_witness916.txt').replace("['dispersionCheck','routeCheck']","['factorsCheck']");exec(compile(s,'quarkdressing916','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'QuarkDressingEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['QuarkDressing']+['QuarkDressingEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
