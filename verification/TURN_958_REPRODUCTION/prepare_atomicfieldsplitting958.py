from pathlib import Path
w=Path('work');s=(w/'prepare_hydrogenrydberg955.py').read_text().replace('HydrogenRydberg','AtomicFieldSplitting').replace('hydrogenrydberg','atomicfieldsplitting').replace('955','958').replace('hydrogen_rydberg_successor_laws_v1','atomic_field_splitting_successor_laws_v1').replace('HYDROGEN_RYDBERG_SPEC','ATOMIC_FIELD_SPLITTING_SPEC')
a=s.index("['protonCheck'");b=s.index(']:\n firstAxis',a)
body='''set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def multiplicityCheck : Bool := [1,2,3,4,5,6].map (fun n => (magneticSublevelCount (.count (.integer (.ofNat n)))).toOption)==[some 2,some 3,some 4,some 5,some 6,some 7]
def zeemanCheck : Bool := match zeemanShiftMagnitude (.fraction (normalize 3 2 (by decide))) (.count (.integer 2)) (.fraction (normalize 2 5 (by decide))) with
 | .error _ => false
 | .ok doubled => match zeemanShiftMagnitude (.fraction (normalize 3 2 (by decide))) (.count (.integer 2)) (.fraction (normalize 1 5 (by decide))) with
  | .error _ => false
  | .ok base => doubled == multiply (wholeRatio 2) base
def linearCheck : Bool := match linearStarkMagnitude (.fraction (normalize 4 7 (by decide))) (.fraction (normalize 2 5 (by decide))) with
 | .error _ => false
 | .ok doubled => match linearStarkMagnitude (.fraction (normalize 4 7 (by decide))) (.fraction (normalize 1 5 (by decide))) with
  | .error _ => false
  | .ok base => doubled == multiply (wholeRatio 2) base
def quadraticCheck : Bool := match quadraticStarkMagnitude (.fraction (normalize 4 7 (by decide))) (.fraction (normalize 2 5 (by decide))) with
 | .error _ => false
 | .ok doubled => match quadraticStarkMagnitude (.fraction (normalize 4 7 (by decide))) (.fraction (normalize 1 5 (by decide))) with
  | .error _ => false
  | .ok base => doubled == multiply (wholeRatio 4) base
'''
s=s[:a]+repr(['multiplicityCheck','zeemanCheck','linearCheck','quadraticCheck'])+','+repr(body)+')'+s[b:];(w/'prepare_atomicfieldsplitting958_generated.py').write_text(s);exec(compile(s,'field-original-entry','exec'),{})

# Preserve exact source text while making hyphenated axis names legal Lean identifiers.
import re,shutil
r=w/"constants-recovery";c=Path("/Volumes/One Touch/SFT v4 Full model LEAN")
for suffix in ['Grammar','Controls','Evidence']:
 p=r/'SFT/Physics'/f'AtomicFieldSplittingEntry{suffix}.lean'
 parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',p.read_text())
 corrected=''.join(x.replace('electric-degenerate','electricDegenerate').replace('Electric-degenerate','ElectricDegenerate').replace('electric-nondegenerate','electricNondegenerate').replace('Electric-nondegenerate','ElectricNondegenerate') if i%2==0 else x for i,x in enumerate(parts))
 p.write_text(corrected);shutil.copy2(p,c/'SFT/Physics'/p.name)
