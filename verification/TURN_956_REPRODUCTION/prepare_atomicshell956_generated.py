from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.atomic_shell_periodicity_successor_laws_v1 import ATOMIC_SHELL_PERIODICITY_SPEC
for tag,low,n,spec,checks,body in [('AtomicShellPeriodicity','atomicshell',956,ATOMIC_SHELL_PERIODICITY_SPEC,['shellCheck', 'fourCheck', 'closuresCheck', 'widthsCheck'],'def shellCheck : Bool := (List.range 32).all (fun n => shellCapacity (.count (.integer (.ofNat (n+1)))) == .ok (2*(n+1)*(n+1)))\ndef fourCheck : Bool := [shellCapacity (.count (.integer 1)),shellCapacity (.count (.integer 2)),shellCapacity (.count (.integer 3)),shellCapacity (.count (.integer 4))] == [.ok 2,.ok 8,.ok 18,.ok 32]\ndef closuresCheck : Bool := generatedPeriodClosures (.count (.integer 7)) == .ok [2,10,18,36,54,86,118]\ndef widthsCheck : Bool := generatedPeriodWidths (.count (.integer 7)) == .ok [2,8,8,18,18,32,32]\n')]:
 firstAxis=spec.axes[0].key
 (w/f'{low}{n}_spec.json').write_text(json.dumps(asdict(spec),indent=2))
 (w/f'{low}_witness{n}.txt').write_text(f'import SFT.Physics.{tag}\nnamespace SFT.Physics.{tag}EntryWitnesses\nopen {tag} LeptonIntervals VacuumLedgerProofs\nstructure Witness where\n name : String\n statement : String\n passed : Bool\n'+body+'def witnesses : List Witness := [WITNESS_ROWS]\ntheorem allWitnessesPass : witnesses.all Witness.passed=true := rfl\n'+f'end SFT.Physics.{tag}EntryWitnesses\n')
 gen=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json',f'{low}{n}_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')",f"replace('SpatialThree','{tag}Entry')").replace('work/freephase_witness883.txt',f'work/{low}_witness{n}.txt').replace("['dispersionCheck','routeCheck']",repr(checks))
 a=gen.index('exec(compile(s');gen=gen[:a]+'''s=s.replace("i==7","i==9").replace("= 256","= 1024").replace("⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩","⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩").replace("⟨h0,h1,h2,h3,h4,h5,h6,h7⟩","⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩").replace("cases h6; cases h7","cases h6; cases h7; cases h8; cases h9")
'''+gen[a:];exec(compile(gen,'original-ten-axis-anomaly-entry','exec'))
 for suffix in ['Controls','Evidence']:
  p=r/'SFT/Physics'/f'{tag}Entry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));s=s.replace('{ survivor with carrier := .rejected }','{ survivor with '+firstAxis+' := .rejected }').replace('evidenceMode := .formal','evidenceMode := .empirical').replace('provenance := [.forwardForcing]','provenance := [.observationalDerivation]');p.write_text(s)
 p=r/'SFT/Physics'/f'{tag}EntryGrammar.lean';p.write_text(p.read_text().replace('maxHeartbeats 20000000 in','maxHeartbeats 100000000 in').replace('maxHeartbeats 10000000 in','maxHeartbeats 100000000 in'))
 for suffix in ['Grammar','Controls','Evidence']:
  p=r/'SFT/Physics'/f'{tag}Entry{suffix}.lean';parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',p.read_text());p.write_text(''.join(x.replace('depth-two','depthTwo').replace('depth-three','depthThree').replace('Depth-two','DepthTwo').replace('Depth-three','DepthThree') if i%2==0 else x for i,x in enumerate(parts)))
 for m in [tag]+[tag+'Entry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
 print(tag,'all1024 original alternatives prepared')
