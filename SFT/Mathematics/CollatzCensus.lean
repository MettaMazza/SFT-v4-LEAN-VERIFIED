import SFT.Mathematics.OrbitCycleSupport
namespace SFT.Mathematics.CollatzCensus
set_option maxRecDepth 200000
set_option maxHeartbeats 100000000

def next (n : Nat) : Nat := if n%2==0 then n/2 else 3*n+1

-- Retain every original while-loop state, not just its terminal value.
-- Exhaustion is explicit and must be excluded by the complete source census.
def traceWithin (n : Nat) : Nat → Option (List Nat)
 | 0 => if n==1 then some [1] else none
 | fuel+1 => if n==1 then some [1] else
     (traceWithin (next n) fuel).map (List.cons n)

def stepsWithin (n fuel : Nat) : Option Nat :=
 (traceWithin n fuel).map (fun trace => trace.length-1)

def admittedSteps (start : Int) (fuel : Nat) : Except String (Option Nat) :=
 match start with
 | .ofNat 0 => .error "the census uses positive finite starts"
 | .ofNat (n+1) => .ok (stepsWithin (n+1) fuel)
 | .negSucc _ => .error "the census uses positive finite starts"

theorem cycleOne : next 1=4 := rfl
theorem cycleFour : next 4=2 := rfl
theorem cycleTwo : next 2=1 := rfl

theorem twentySeven : stepsWithin 27 111=some 111 := by decide

theorem originalOddEvenWitness :
 (List.range 5001).all (fun i => (3*(2*i+1)+1)%2==0)=true := by decide

theorem contractionCounterexample : (3*3+1)/2=5 ∧ 3<5 := by decide

inductive Replay : Nat → List Nat → Prop
 | terminal : Replay 1 [1]
 | successor {n tail} : n≠1 → Replay (next n) tail → Replay n (n::tail)

theorem everyReturnedTraceReplays (n fuel : Nat) (trace : List Nat)
 (returned : traceWithin n fuel=some trace) : Replay n trace := by
 induction fuel generalizing n trace with
 | zero =>
   change (if n==1 then some [1] else none)=some trace at returned
   split at returned
   next one =>
     have eqn : n=1 := of_decide_eq_true one
     cases eqn
     cases Option.some.inj returned
     exact Replay.terminal
   next other => cases returned
 | succ fuel ih =>
   change (if n==1 then some [1] else (traceWithin (next n) fuel).map (List.cons n))=some trace at returned
   split at returned
   next one =>
     have eqn : n=1 := of_decide_eq_true one
     cases eqn
     cases Option.some.inj returned
     exact Replay.terminal
   next other =>
     cases found : traceWithin (next n) fuel with
     | none => rw [found] at returned; cases returned
     | some tail =>
       rw [found] at returned
       cases Option.some.inj returned
       exact Replay.successor (fun eqn => by cases eqn; contradiction) (ih _ _ found)

end SFT.Mathematics.CollatzCensus
