from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.matter_flavour_terminal_proton_laws_v1 import TERMINAL_PROTON_SPEC
(w/'terminalproton940_spec.json').write_text(json.dumps(asdict(TERMINAL_PROTON_SPEC),indent=2))
s='''import SFT.Physics.TerminalProton
namespace SFT.Physics.TerminalProtonEntryWitnesses
open TerminalProton LeptonIntervals VacuumLedgerProofs
structure Witness where
 name : String
 statement : String
 passed : Bool
def complementCheck : Bool := originalRecord.heavyComplement == wholeRatio 53
def supportCheck : Bool := match compositeSupport with
 | .error _ => false
 | .ok n => n == 30
def dressingCheck : Bool := (normalize 1 (10^6) (by decide)).blt originalRecord.dressing && originalRecord.dressing.blt (normalize 1 1000 (by decide))
def retentionCheck : Bool := add originalRecord.retention originalRecord.dressing == wholeRatio 1
def witnesses : List Witness := [WITNESS_ROWS]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.TerminalProtonEntryWitnesses
''';(w/'terminalproton_witness940.txt').write_text(s)
gen=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','terminalproton940_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','TerminalProtonEntry')").replace('work/freephase_witness883.txt','work/terminalproton_witness940.txt').replace("['dispersionCheck','routeCheck']","['complementCheck','supportCheck','dressingCheck','retentionCheck']")
a=gen.index('exec(compile(s');fix='''s=s.replace("i==7","i==10").replace("= 256","= 2048").replace("⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩","⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩").replace("⟨h0,h1,h2,h3,h4,h5,h6,h7⟩","⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10⟩").replace("cases h6; cases h7","cases h6; cases h7; cases h8; cases h9; cases h10")
''';gen=gen[:a]+fix+gen[a:];exec(compile(gen,'source-eleven-axis-proton-generator','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'TerminalProtonEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));s=s.replace('{ survivor with carrier := .rejected }','{ survivor with base := .rejected }').replace('evidenceMode := .formal','evidenceMode := .empirical').replace('provenance := [.forwardForcing]','provenance := [.observationalDerivation]');p.write_text(s)
p=r/'SFT/Physics/TerminalProtonEntryGrammar.lean';p.write_text(p.read_text().replace('set_option maxRecDepth 20000','set_option maxRecDepth 20000\nset_option maxHeartbeats 100000000').replace('maxHeartbeats 20000000 in','maxHeartbeats 100000000 in').replace('maxHeartbeats 10000000 in','maxHeartbeats 100000000 in'))
for m in ['TerminalProton']+['TerminalProtonEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
print('Original eleven-axis 2048-candidate proton grammar and four witnesses prepared')
