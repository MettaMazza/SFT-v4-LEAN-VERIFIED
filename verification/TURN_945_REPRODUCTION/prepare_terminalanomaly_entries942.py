from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.matter_flavour_terminal_anomaly_laws_v1 import ELECTRON_SPEC,MUON_SPEC
for tag,low,n,spec,checks,body in [
 ('TerminalElectronAnomaly','terminalelectron',942,ELECTRON_SPEC,['pairsCheck','retentionCheck','anomalyCheck'],'''def pairsCheck : Bool := (normalize 1 10 (by decide)).blt electronLoopCarrierExpected && electronLoopCarrierExpected.blt (normalize 1 4 (by decide))
def retentionCheck : Bool := match AlphaRatio.inverseFineStructure none with
 | .error _ => false
 | .ok inverse => match LeptonRatios.divide (wholeRatio 1) (BoundaryGrowth.asFraction inverse) with
   | .error _ => false
   | .ok alpha => add electronAnomalyRetentionExpected (multiply alpha electronLoopCarrierExpected) == wholeRatio 1
def anomalyCheck : Bool := (normalize 1 10000 (by decide)).blt terminalElectronAnomalyExpected
'''),
 ('TerminalMuonAnomaly','terminalmuon',943,MUON_SPEC,['complementsCheck','supportCheck','correctionCheck','orderedCheck'],'''def complementsCheck : Bool := match MassRatioFamily.massRatioFamily (.integer 2),MassRatioFamily.massRatioFamily (.integer 3) with
 | .ok a,.ok b => a.heavyOverLight == wholeRatio 17 && b.heavyOverLight == wholeRatio 53
 | .error _,.error _ => false
 | .error _,.ok _ => false
 | .ok _,.error _ => false
def supportCheck : Bool := match TerminalTurn.terminalTurnSupport,AlphaBlocks.fineStructureBlocks with
 | .ok s,.ok b => s*53+b.down == 853
 | .error _,.error _ => false
 | .error _,.ok _ => false
 | .ok _,.error _ => false
def correctionCheck : Bool := (normalize 1 1000000 (by decide)).blt muonGenerationCorrectionExpected
def orderedCheck : Bool := TerminalElectronAnomaly.terminalElectronAnomalyExpected.blt terminalMuonAnomalyExpected
''')]:
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
