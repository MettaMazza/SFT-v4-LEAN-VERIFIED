import SFT.Physics.FiniteLoopProofs
namespace SFT.Physics.FiniteLoopEntryWitnesses
open FiniteLoop
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def outputs := (List.range 6).map (fun n => finiteLoopSum (.integer (.ofNat (n+1))))
def expected : List Rat := [⟨1,2,by decide,by decide⟩,⟨3,4,by decide,by decide⟩,⟨7,8,by decide,by decide⟩,⟨15,16,by decide,by decide⟩,⟨31,32,by decide,by decide⟩,⟨63,64,by decide,by decide⟩]
def prefixCheck : Bool := (outputs.zip expected).all (fun (a,b) => match a with | .error _ => false | .ok a => same a b)
def boundaryCheck : Bool := (List.range 16).all (fun n => match finiteLoopSum (.integer (.ofNat (n+1))) with | .error _ => false | .ok x => LeptonIntervals.zero.blt x && x.blt ⟨1,1,by decide,by decide⟩)
def witnesses : List Witness := [⟨"prefix","The first six loop sums are exact and finite.",prefixCheck⟩,⟨"finite-boundary","Every tested generated depth remains a positive rational below One.",boundaryCheck⟩]
theorem prefixCheckPassed : prefixCheck=true := by unfold prefixCheck outputs;rw [originalDepths];rfl
set_option maxRecDepth 20000 in
set_option maxHeartbeats 100000000 in
theorem boundaryCheckPassed : boundaryCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (prefixCheck && (boundaryCheck && true))=true
 rw [prefixCheckPassed,boundaryCheckPassed]
 rfl
end SFT.Physics.FiniteLoopEntryWitnesses
