import SFT.Physics.QuarkComparison
namespace SFT.Physics.TerminalQuarkRoots
open LeptonIntervals
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev Interval := Rat × Rat

def precision : Rat := normalize 1 (10^15) (by decide)
def needsRefinement (brackets : List Interval) : Bool :=
 brackets.any (fun row => precision.blt (subtract row.2 row.1))
def refine (pairSum product : Rat) (brackets : List Interval) :=
 brackets.map (fun row => QuarkIsolation.bisectBracket row pairSum product)

inductive SourceRun (pairSum product : Rat) : List Interval → List Interval → Prop where
 | stop (b : List Interval) (h : needsRefinement b = false) : SourceRun pairSum product b b
 | next (b result : List Interval) (h : needsRefinement b = true)
   (later : SourceRun pairSum product (refine pairSum product b) result) : SourceRun pairSum product b result

/-- Proof evaluation budget; successful results are certified against the original uncapped loop. -/
def refineWithin (pairSum product : Rat) : Nat → List Interval → Option (List Interval)
 | 0,_ => none
 | fuel+1,b => if needsRefinement b then refineWithin pairSum product fuel (refine pairSum product b) else some b

theorem refinementCorrespondence (pairSum product : Rat) (fuel : Nat) (b result : List Interval)
 (h : refineWithin pairSum product fuel b = some result) : SourceRun pairSum product b result := by
 induction fuel generalizing b with
 | zero => cases h
 | succ fuel ih =>
   unfold refineWithin at h
   cases hc : needsRefinement b with
   | false =>
     rw [hc] at h
     have he := Option.some.inj h
     cases he
     exact .stop result hc
   | true =>
     rw [hc] at h
     exact .next b result hc (ih _ h)

abbrev downPair := QuarkComparison.downPair
abbrev downProduct := QuarkComparison.downProduct
abbrev upPair := QuarkComparison.upPair
abbrev upProduct := QuarkComparison.upProduct
abbrev initialDown := QuarkComparison.initialDown
abbrev initialUp := QuarkComparison.initialUp
theorem initialSource : QuarkIsolation.rootBrackets=.ok (initialDown,initialUp) := QuarkComparison.initialSource

def refinedDown : List Interval := [(normalize 29565302218591 1125899906842624 (by decide),normalize 923915694331 35184372088832 (by decide)),(normalize 32625432524185 281474976710656 (by decide),normalize 130501730096741 1125899906842624 (by decide)),(normalize 241458218631823 281474976710656 (by decide),normalize 965832874527293 1125899906842624 (by decide))]
theorem exactDown : refineWithin downPair downProduct 45 initialDown = some refinedDown := rfl
theorem sourceDown : SourceRun downPair downProduct initialDown refinedDown := refinementCorrespondence _ _ _ _ _ exactDown

def refinedUp : List Interval := [(normalize 578336531095 140737488355328 (by decide),normalize 4626692248761 1125899906842624 (by decide)),(normalize 98182672820103 1125899906842624 (by decide),normalize 12272834102513 140737488355328 (by decide)),(normalize 15985789715215 17592186044416 (by decide),normalize 1023090541773761 1125899906842624 (by decide))]
theorem exactUp : refineWithin upPair upProduct 43 initialUp = some refinedUp := rfl
theorem sourceUp : SourceRun upPair upProduct initialUp refinedUp := refinementCorrespondence _ _ _ _ _ exactUp

def refinedQuarkRoots : Except String (List Interval × List Interval) := do
 let cubics ← QuarkInvariants.cubicInvariants
 let (down,up) ← QuarkIsolation.rootBrackets
 let d := refineWithin (BoundaryGrowth.asFraction cubics.down.2.1) (BoundaryGrowth.asFraction cubics.down.2.2) 45 down
 let u := refineWithin (BoundaryGrowth.asFraction cubics.up.2.1) (BoundaryGrowth.asFraction cubics.up.2.2) 43 up
 match d with
 | none => throw "unreachable: certified original down refinement"
 | some ds => match u with
   | none => throw "unreachable: certified original up refinement"
   | some us => pure (ds,us)
theorem completeRefinedRoots : refinedQuarkRoots = .ok (refinedDown,refinedUp) := rfl

end SFT.Physics.TerminalQuarkRoots
