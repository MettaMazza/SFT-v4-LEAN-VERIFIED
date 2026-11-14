from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.matter_flavour_laws_v1 import NEUTRINO_SPLITTING_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/NeutrinoSplittingEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'neutrinosplitting920_spec.json').write_text(json.dumps(asdict(NEUTRINO_SPLITTING_SPEC),indent=2))
s='''import SFT.Physics.NeutrinoLadder
namespace SFT.Physics.NeutrinoSplittingEntryWitnesses
open NeutrinoLadder
structure Witness where
 name : String
 statement : String
 passed : Bool
def identityCheck : Bool := match neutrinoSplittingStructure with
 | .error _ => false
 | .ok f => decide (f.rungRatio=(⟨33,1,by decide,by decide⟩ : Rat)) && decide (f.translationRatio=(⟨3,100,by decide,by decide⟩ : Rat))
def witnesses : List Witness := [WITNESS_ROWS]
theorem identityCheckPassed : identityCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.NeutrinoSplittingEntryWitnesses
''';(w/'neutrinosplitting_witness920.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','neutrinosplitting920_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','NeutrinoSplittingEntry')").replace('work/freephase_witness883.txt','work/neutrinosplitting_witness920.txt').replace("['dispersionCheck','routeCheck']","['identityCheck']");exec(compile(s,'neutrinosplitting920','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'NeutrinoSplittingEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['NeutrinoLadder']+['NeutrinoSplittingEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
