from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.matter_flavour_terminal_anomaly_laws_v1 import TURN_SPEC
(w/'terminalturn941_spec.json').write_text(json.dumps(asdict(TURN_SPEC),indent=2))
s="""import SFT.Physics.TerminalTurn
namespace SFT.Physics.TerminalTurnEntryWitnesses
open TerminalTurn LeptonIntervals VacuumLedgerProofs
structure Witness where
 name : String
 statement : String
 passed : Bool
def supportCheck : Bool := match terminalTurnSupport with
 | .error _ => false
 | .ok n => n == 16
def projectionCheck : Bool := match terminalTurnProjection with
 | .error _ => false
 | .ok q => q == normalize 355 113 (by decide)
def witnesses : List Witness := [WITNESS_ROWS]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.TerminalTurnEntryWitnesses
""";(w/'terminalturn_witness941.txt').write_text(s)
gen=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','terminalturn941_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','TerminalTurnEntry')").replace('work/freephase_witness883.txt','work/terminalturn_witness941.txt').replace("['dispersionCheck','routeCheck']","['supportCheck','projectionCheck']")
a=gen.index('exec(compile(s');fix='''s=s.replace("i==7","i==8").replace("= 256","= 512").replace("⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩","⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩").replace("⟨h0,h1,h2,h3,h4,h5,h6,h7⟩","⟨h0,h1,h2,h3,h4,h5,h6,h7,h8⟩").replace("cases h6; cases h7","cases h6; cases h7; cases h8")
''';gen=gen[:a]+fix+gen[a:];exec(compile(gen,'source-eleven-axis-proton-generator','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'TerminalTurnEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));s=s.replace('provenance := [.forwardForcing]','provenance := [.observationalDerivation]');p.write_text(s)
p=r/'SFT/Physics/TerminalTurnEntryGrammar.lean';p.write_text(p.read_text().replace('set_option maxRecDepth 20000','set_option maxRecDepth 20000\nset_option maxHeartbeats 100000000'))
for suffix in ['Grammar','Controls','Evidence']:
 p=r/'SFT/Physics'/f'TerminalTurnEntry{suffix}.lean';parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',p.read_text());p.write_text(''.join(re.sub(r'\breturn\b','«return»',x) if i%2==0 else x for i,x in enumerate(parts)))
for m in ['TerminalTurn']+['TerminalTurnEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
print('Original nine-axis 512-candidate turn grammar and two witnesses prepared')
