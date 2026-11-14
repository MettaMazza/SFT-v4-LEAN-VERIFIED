import SFT.Physics.AtomicShellPeriodicity
namespace SFT.Physics.AtomicShellPeriodicityEntryWitnesses
open AtomicShellPeriodicity
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def shellCheck : Bool := (List.range 32).all (fun n => match shellCapacity (.count (.integer (.ofNat (n+1)))) with
 | .ok k => k==2*(n+1)*(n+1)
 | .error _ => false)
def fourCheck : Bool := [1,2,3,4].map (fun n => (shellCapacity (.count (.integer (.ofNat n)))).toOption) == [some 2,some 8,some 18,some 32]
def closuresCheck : Bool := match generatedPeriodClosures (.count (.integer 7)) with
 | .ok xs => xs==[2,10,18,36,54,86,118]
 | .error _ => false
def widthsCheck : Bool := match generatedPeriodWidths (.count (.integer 7)) with
 | .ok xs => xs==[2,8,8,18,18,32,32]
 | .error _ => false
def witnesses : List Witness := [⟨"depth-independent-shell-sum","The exact identity holds over a nonselecting finite witness prefix and the induction step proves every successor.",shellCheck⟩,⟨"first-shell-capacities","The first four complete shells have capacities 2, 8, 18 and 32.",fourCheck⟩,⟨"period-closures","The generated endpoint-bounded closure prefix is exact.",closuresCheck⟩,⟨"period-widths","Successive closure differences are exact and distinct from shell capacities.",widthsCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.AtomicShellPeriodicityEntryWitnesses
