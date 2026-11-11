from pathlib import Path
p=Path('work/constants-recovery/SFT/Chemistry/GBlockEvidence.lean');s=p.read_text();a=s.index('def witness0');b=s.index('def witnesses',a)
block='''def natResultEqual (result : Except String Nat) (expected : Nat) : Bool :=
 match result with
 | .error _ => false
 | .ok n => n == expected

def natListEqual : List Nat → List Nat → Bool
 | [], [] => true
 | [], _::_ => false
 | _::_, [] => false
 | a::xs, b::ys => (a == b) && natListEqual xs ys

def witness0 : Bool :=
 natResultEqual (SFT.Physics.AtomicOrbitCapacity.orbitCapacity (.integer 1)) 2 &&
 natResultEqual (SFT.Physics.AtomicOrbitCapacity.orbitCapacity (.integer 2)) 6 &&
 natResultEqual (SFT.Physics.AtomicOrbitCapacity.orbitCapacity (.integer 3)) 10 &&
 natResultEqual (SFT.Physics.AtomicOrbitCapacity.orbitCapacity (.integer 4)) 14 &&
 natResultEqual (SFT.Physics.AtomicOrbitCapacity.orbitCapacity (.integer 5)) 18

def witness1 : Bool :=
 match GBlockOperations.nobleClosures (.integer 7) with
 | .error _ => false
 | .ok xs => natListEqual xs [2,10,18,36,54,86,118]

def witness2 : Bool :=
 natResultEqual (GBlockOperations.firstOccupiedCoordinate (.integer 8) (.integer 1)) 119 &&
 natResultEqual (GBlockOperations.firstOccupiedCoordinate (.integer 5) (.integer 5)) 121

theorem witness0Passed : witness0 = true := rfl
theorem witness1Passed : witness1 = true := rfl
theorem witness2Passed : witness2 = true := rfl
'''
p.write_text(s[:a]+block+s[b:])
