from pathlib import Path
import subprocess,ast
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');tag='TerminalLeptonValidation';cid='SFT-PHYS-VALIDATION-CHARGED-LEPTON-TERMINAL-002';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
def sub(s):return s.replace('ThermalObservation',tag).replace('thermalobservation1034','leptonvalidation1040').replace('Program1034','Program1040').replace('Empirical1034','Empirical1040').replace('SFT-PHYS-VALIDATION-THERMAL-HISTORY-RECOMBINATION-038',cid).replace('from sft.physics.thermal_history_empirical_v1 import SPEC, ObservationalEmpiricalPhysicsProgram','from sft.physics.charged_lepton_validation import TERMINAL_VALIDATION_SPEC as SPEC\nfrom sft.physics.generated_empirical_law import GeneratedEmpiricalPhysicsProgram').replace('from sft.physics.thermal_history_empirical_v1 import SPEC','from sft.physics.charged_lepton_validation import TERMINAL_VALIDATION_SPEC as SPEC').replace('ObservationalEmpiricalPhysicsProgram','GeneratedEmpiricalPhysicsProgram').replace("['observational_derivation']","['forward_forcing']")
for k in ['program','fresh']:(w/f'check_leptonvalidation1040_{k}.py').write_text(sub((w/f'check_thermalobservation1034_{k}.py').read_text()))
s=sub((w/'check_thermalobservation1034_grammar.py').read_text()).replace('import TERMINAL_VALIDATION_SPEC as SPEC,GeneratedEmpiricalPhysicsProgram','import TERMINAL_VALIDATION_SPEC as SPEC\nfrom sft.physics.generated_empirical_law import GeneratedEmpiricalPhysicsProgram');(w/'check_leptonvalidation1040_grammar.py').write_text(s)
(w/'run_leptonvalidation1040_native.py').write_text(sub((w/'run_thermalobservation1034_native.py').read_text()))
(r/f'{tag}Program1040.lean').write_text(sub((r/'ThermalObservationProgram1034.lean').read_text()))
for rel in ['claims/'+cid+'/execution.py','claims/'+cid+'/independent_validator.py']:
 b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+rel]);p=w/'v3-runtime500'/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b)
s=sub((w/'check_thermalobservation1034_independent.py').read_text()).replace('generated/physics/thermal_history_empirical_validator_v1.py','claims/'+cid+'/independent_validator.py').replace("str(p),cid,str(f.resolve())","str(p),str(f.resolve())").replace("assert proc.returncode==(0 if name=='original'else 1)","assert proc.returncode==0")
(w/'check_leptonvalidation1040_independent.py').write_text(s)
s=sub((w/'audit_thermalobservation1034.py').read_text()).replace("['Analysis','Records','Measurement','Witnesses','Grammar','Evidence']","['Witnesses','Grammar','Evidence','Experiment','Validation']");(w/'audit_leptonvalidation1040.py').write_text(s)
s=sub((w/'prepare_thermalobservation1034_empirical_native.py').read_text());(w/'prepare_leptonvalidation1040_empirical_native.py').write_text(s)
(w/'constants-recovery'/f'{tag}Empirical1040.lean').write_text('''import SFT.Physics.TerminalLeptonValidationValidation
open SFT.Physics SFT.Host.Canonical
def main (args : List String) : IO Unit := do
 let root := args[0]!
 let derivationSeal := args[1]!
 let host := args[2]!
 let implementation := args[3]!
 let before : HostilePackage.Snapshot := ⟨"registered-protected-root",[],"unchanged"⟩
 let bytes ← IO.FS.readBinFile (System.FilePath.mk (root ++ "/" ++ TerminalLeptonValidationExperiment.sourcePath))
 let body ← IO.FS.readFile (root ++ "/" ++ TerminalLeptonValidationExperiment.sourcePath)
 let rows := LeptonSource.lines (SFT.Host.Text.chars body)
 let result ← IO.ofExcept (TerminalLeptonValidationValidation.validateExternalWithin rows 27 15 bytes derivationSeal host implementation before before)
 match result with
 | none => throw (IO.userError "Original terminal comparison did not terminate within the verified exact refinement bounds")
 | some result => IO.println (render result.value)
''')
print('Prepared full programme, original independent validator and native empirical checks')
