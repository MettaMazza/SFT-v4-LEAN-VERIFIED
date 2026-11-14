from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.matter_flavour_laws_v1 import MAGNETIC_ANOMALY_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/MagneticAnomalyEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'magneticanomaly925_spec.json').write_text(json.dumps(asdict(MAGNETIC_ANOMALY_SPEC),indent=2))
s='''import SFT.Physics.MagneticAnomaly
namespace SFT.Physics.MagneticAnomalyEntryWitnesses
open MagneticAnomaly
structure Witness where
 name : String
 statement : String
 passed : Bool
def leadingCheck : Bool := match magneticAnomalyStructure with
 | .error _ => false
 | .ok f => decide (f.phaseNormalizedLeadingAnomaly=originalRecord.phaseNormalizedLeadingAnomaly)
def bareCheck : Bool := match magneticAnomalyStructure with
 | .error _ => false
 | .ok f => decide (f.bareG=2)
def witnesses : List Witness := [WITNESS_ROWS]
theorem leadingCheckPassed : leadingCheck=true := rfl
theorem bareCheckPassed : bareCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.MagneticAnomalyEntryWitnesses
''';(w/'magneticanomaly_witness925.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','magneticanomaly925_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','MagneticAnomalyEntry')").replace('work/freephase_witness883.txt','work/magneticanomaly_witness925.txt').replace("['dispersionCheck','routeCheck']","['leadingCheck','bareCheck']");exec(compile(s,'magneticanomaly925','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'MagneticAnomalyEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['MagneticAnomaly']+['MagneticAnomalyEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
