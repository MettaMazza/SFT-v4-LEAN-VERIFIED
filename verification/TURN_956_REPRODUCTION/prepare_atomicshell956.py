from pathlib import Path
import shutil
w=Path('work');v=Path('/Volumes/One Touch/ernos-labs-sft-platform')
for part in ['laws','validation','execution']:shutil.copy2(v/f'sft/physics/atomic_shell_periodicity_successor_{part}_v1.py',w/f'v3-runtime500/sft/physics/atomic_shell_periodicity_successor_{part}_v1.py')
s=(w/'prepare_hydrogenrydberg955.py').read_text().replace('HydrogenRydberg','AtomicShellPeriodicity').replace('hydrogenrydberg','atomicshell').replace('955','956').replace('hydrogen_rydberg_successor_laws_v1','atomic_shell_periodicity_successor_laws_v1').replace('HYDROGEN_RYDBERG_SPEC','ATOMIC_SHELL_PERIODICITY_SPEC')
a=s.index("['protonCheck'");b=s.index(']:\n firstAxis',a)
body='''def shellCheck : Bool := (List.range 32).all (fun n => shellCapacity (.count (.integer (.ofNat (n+1)))) == .ok (2*(n+1)*(n+1)))
def fourCheck : Bool := [shellCapacity (.count (.integer 1)),shellCapacity (.count (.integer 2)),shellCapacity (.count (.integer 3)),shellCapacity (.count (.integer 4))] == [.ok 2,.ok 8,.ok 18,.ok 32]
def closuresCheck : Bool := generatedPeriodClosures (.count (.integer 7)) == .ok [2,10,18,36,54,86,118]
def widthsCheck : Bool := generatedPeriodWidths (.count (.integer 7)) == .ok [2,8,8,18,18,32,32]
'''
s=s[:a]+repr(['shellCheck','fourCheck','closuresCheck','widthsCheck'])+','+repr(body)+')'+s[b:];(w/'prepare_atomicshell956_generated.py').write_text(s);exec(compile(s,'shell-original-entry','exec'),{})
