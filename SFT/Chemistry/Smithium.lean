import SFT.Chemistry.GBlockWitnesses
namespace SFT.Chemistry.Smithium
open GBlockOperations SFT.Physics
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

structure Record where
 proton : Nat
 neutron : Nat
 mass : Nat
 configuration : List (Nat × Nat × Nat)
 valence : Nat
 predictedPositiveOxidationCounts : List Nat
 deriving Repr

def atIndex : List Nat → Nat → Except String Nat
 | [], _ => .error "IndexError: tuple index out of range"
 | x::_, 0 => .ok x
 | _::xs, n+1 => atIndex xs n

-- Exact six-field assembly in gblock_predictions.py::smithium_record.
def smithiumRecord : Except String Record := do
 let closures ← NuclearClosure.closurePrefix (.integer 8)
 let proton ← atIndex closures 6
 let neutron ← atIndex closures 7
 let s ← subshellOccupation (.integer (.ofNat proton)) (.integer 8) (.integer 1)
 let g ← subshellOccupation (.integer (.ofNat proton)) (.integer 5) (.integer 5)
 if !(s.length == 1) || !(g.length == 1) then .error "ValueError: Smithium electronic support did not close"
 else
  let valence := s.headD 0 + g.headD 0
  .ok ⟨proton,neutron,proton+neutron,[(8,1,s.headD 0),(5,5,g.headD 0)],valence,
   (List.range (valence-1)).map (fun n => n+2)⟩

theorem nuclearProton : (do let xs ← NuclearClosure.closurePrefix (.integer 8); atIndex xs 6) = .ok 126 := rfl

theorem nuclearNeutron : (do let xs ← NuclearClosure.closurePrefix (.integer 8); atIndex xs 7) = .ok 184 := rfl

theorem retainedEightSPair : subshellOccupation (.integer 126) (.integer 8) (.integer 1) = .ok [2] := rfl

theorem fiveGSix : subshellOccupation (.integer 126) (.integer 5) (.integer 5) = .ok [6] := rfl

theorem exactRecord : smithiumRecord = .ok ⟨126,184,310,[(8,1,2),(5,5,6)],8,[2,3,4,5,6,7,8]⟩ := rfl
end SFT.Chemistry.Smithium
