from pathlib import Path
import subprocess
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');cid='SFT-PHYS-VALIDATION-CHARGED-LEPTON-KOIDE-002';tag='KoideValidationV2';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
def sub(s):return s.replace('TerminalLeptonValidation',tag).replace('leptonvalidation1040','koidevalidation1041').replace('1040','1041').replace('SFT-PHYS-VALIDATION-CHARGED-LEPTON-TERMINAL-002',cid).replace('TERMINAL_VALIDATION_SPEC','KOIDE_VALIDATION_SPEC').replace('ChargedLeptonTerminalValidationExternalValidator','KoideValidationExternalValidator').replace("'leptonvalidation',1041","'koidevalidation',1041")
for k in ['program','fresh','grammar','independent','empirical']:(w/f'check_koidevalidation1041_{k}.py').write_text(sub((w/f'check_leptonvalidation1040_{k}.py').read_text()))
(w/'run_koidevalidation1041_native.py').write_text(sub((w/'run_leptonvalidation1040_native.py').read_text()))
s=sub((w/'audit_leptonvalidation1040.py').read_text()).replace("'Experiment','Validation'","'Experiment','Validation','External'");(w/'audit_koidevalidation1041.py').write_text(s)
(r/f'{tag}Program1041.lean').write_text(sub((r/'TerminalLeptonValidationProgram1040.lean').read_text()))
for rel in ['claims/'+cid+'/execution.py','claims/'+cid+'/independent_validator.py']:
 b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+rel]);p=w/'v3-runtime500'/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b)
s=sub((w/'check_leptonvalidation1040_original.py').read_text()).replace(',comparison_record',',koide_source_interval');a=s.index("(w/'koidevalidation1041_original_numeric.json')");s=s[:a]+"(w/'koidevalidation1041_original_numeric.json').write_text(json.dumps([str(x) for x in koide_source_interval(root/SPEC.source_snapshot_path)],indent=2));print('PASS fresh original256programme, exactKoide interval and complete original empiricalvalidator/pinnedrecord')\n";(w/'check_koidevalidation1041_original.py').write_text(s)
s=sub((w/'prepare_leptonvalidation1040_empirical_native.py').read_text()).replace("visit('SFT.Physics.KoideValidationV2Validation')","visit('SFT.Physics.KoideValidationV2External')");(w/'prepare_koidevalidation1041_empirical_native.py').write_text(s)
(w/'constants-recovery'/f'{tag}Empirical1041.lean').write_text('''import SFT.Physics.KoideValidationV2External
open SFT.Physics SFT.Host.Canonical
def main (args : List String) : IO Unit := do
 let root := args[0]!
 let derivationSeal := args[1]!
 let host := args[2]!
 let implementation := args[3]!
 let before : HostilePackage.Snapshot := ⟨"registered-protected-root",[],"unchanged"⟩
 let body ← IO.FS.readFile (root ++ "/" ++ KoideValidationV2Experiment.sourcePath)
 let result ← IO.ofExcept (KoideValidationV2External.validate body derivationSeal host implementation before before)
 IO.println (render result.value)
''')
print('Prepared versioned Koide source-bound checks')
