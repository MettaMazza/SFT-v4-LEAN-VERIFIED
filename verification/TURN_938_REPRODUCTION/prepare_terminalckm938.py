from pathlib import Path
w=Path('work');r=w/'constants-recovery'
s=(w/'prepare_magneticanomaly925.py').read_text().replace('matter_flavour_laws_v1','matter_flavour_terminal_ckm_laws_v1').replace('MAGNETIC_ANOMALY_SPEC','TERMINAL_CKM_SPEC').replace('magneticanomaly925','terminalckm938').replace('magneticanomaly_witness925','terminalckm_witness938').replace('MagneticAnomalyEntry','TerminalCKMEntry').replace('MagneticAnomaly','TerminalCKM')
a=s.index("s='''");b=s.index("''';",a)
witness='''import SFT.Physics.TerminalCKM
namespace SFT.Physics.TerminalCKMEntryWitnesses
open TerminalCKM
structure Witness where
 name : String
 statement : String
 passed : Bool
def routeCheck : Bool := match slopeContribution with
 | .error _ => false
 | .ok result => result == originalContribution
def witnesses : List Witness := [WITNESS_ROWS]
theorem routeCheckPassed : routeCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.TerminalCKMEntryWitnesses
''';s=s[:a]+"s='''"+witness+s[b:];s=s.replace("['leadingCheck','bareCheck']","['routeCheck']");exec(compile(s,'mixing-original-generator','exec'),dict(globals()))
for kind in ['entry','program','independent','original']:
 s=(w/f'check_baryonphoton_{kind}931.py').read_text().replace('931','938').replace('baryonphoton','terminalckm').replace('BaryonPhotonEntry','TerminalCKMEntry').replace('BaryonPhotonTransport','TerminalCKM').replace('MATTER-BARYON-PHOTON','MATTER-MIXING-CORRESPONDENCE').replace('BARYON_PHOTON_SPEC','TERMINAL_CKM_SPEC');(w/f'check_terminalckm_{kind}938.py').write_text(s)
s=(w/'prepare_baryonphoton_native931.py').read_text().replace('931','938').replace('BaryonPhotonEntry','TerminalCKMEntry').replace('BaryonPhotonTransportProgram','TerminalCKMProgram');(w/'prepare_terminalckm_native938.py').write_text(s)
(r/'TerminalCKMProgram938.lean').write_text((r/'BaryonPhotonTransportProgram931.lean').read_text().replace('BaryonPhotonEntry','TerminalCKMEntry'))

p=r/'SFT/Physics/TerminalCKMEntryEvidence.lean';s=p.read_text().replace('evidenceMode := .formal','evidenceMode := .empirical').replace('provenance := [.forwardForcing]','provenance := [.observationalDerivation]');p.write_text(s)
import shutil
shutil.copy2(p,Path('/Volumes/One Touch/SFT v4 Full model LEAN/SFT/Physics')/p.name)
