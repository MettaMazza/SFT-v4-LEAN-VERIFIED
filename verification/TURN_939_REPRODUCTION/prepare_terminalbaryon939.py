from pathlib import Path
w=Path('work');r=w/'constants-recovery'
s=(w/'prepare_magneticanomaly925.py').read_text().replace('matter_flavour_laws_v1','matter_flavour_terminal_ckm_laws_v1').replace('MAGNETIC_ANOMALY_SPEC','TERMINAL_BARYON_PHOTON_SPEC').replace('magneticanomaly925','terminalbaryon939').replace('magneticanomaly_witness925','terminalbaryon_witness939').replace('MagneticAnomalyEntry','TerminalBaryonEntry').replace('MagneticAnomaly','TerminalBaryon')
a=s.index("s='''");b=s.index("''';",a)
witness='''import SFT.Physics.TerminalBaryon
namespace SFT.Physics.TerminalBaryonEntryWitnesses
open TerminalBaryon
structure Witness where
 name : String
 statement : String
 passed : Bool
def halfCheck : Bool := terminalBaryonRelation.imbalanceShare == LeptonIntervals.normalize 1 2 (by decide)
def witnesses : List Witness := [WITNESS_ROWS]
theorem halfCheckPassed : halfCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.TerminalBaryonEntryWitnesses
''';s=s[:a]+"s='''"+witness+s[b:];s=s.replace("['leadingCheck','bareCheck']","['halfCheck']");exec(compile(s,'mixing-original-generator','exec'),dict(globals()))
for kind in ['entry','program','independent','original']:
 s=(w/f'check_baryonphoton_{kind}931.py').read_text().replace('931','939').replace('baryonphoton','terminalbaryon').replace('BaryonPhotonEntry','TerminalBaryonEntry').replace('BaryonPhotonTransport','TerminalBaryon').replace('MATTER-BARYON-PHOTON','MATTER-MIXING-CORRESPONDENCE').replace('BARYON_PHOTON_SPEC','TERMINAL_BARYON_PHOTON_SPEC');(w/f'check_terminalbaryon_{kind}939.py').write_text(s)
s=(w/'prepare_baryonphoton_native931.py').read_text().replace('931','939').replace('BaryonPhotonEntry','TerminalBaryonEntry').replace('BaryonPhotonTransportProgram','TerminalBaryonProgram');(w/'prepare_terminalbaryon_native939.py').write_text(s)
(r/'TerminalBaryonProgram939.lean').write_text((r/'BaryonPhotonTransportProgram931.lean').read_text().replace('BaryonPhotonEntry','TerminalBaryonEntry'))

p=r/'SFT/Physics/TerminalBaryonEntryEvidence.lean';s=p.read_text().replace('evidenceMode := .formal','evidenceMode := .empirical').replace('provenance := [.forwardForcing]','provenance := [.observationalDerivation]');p.write_text(s)
import shutil
shutil.copy2(p,Path('/Volumes/One Touch/SFT v4 Full model LEAN/SFT/Physics')/p.name)

for kind in ['original','program','independent']:
 p=w/f'check_terminalbaryon_{kind}939.py';s=p.read_text().replace('matter_flavour_completion_laws_v1','matter_flavour_terminal_ckm_laws_v1').replace('matter_flavour_completion_validator_v1','matter_flavour_terminal_ckm_validator_v1').replace('SFT-PHYS-MATTER-MIXING-CORRESPONDENCE-003','SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004').replace("=='formal'","=='empirical'").replace("==['forward_forcing']","==['observational_derivation']");p.write_text(s)
