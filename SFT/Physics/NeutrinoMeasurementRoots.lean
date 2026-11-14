import SFT.Physics.NeutrinolessBounds
namespace SFT.Physics.NeutrinoMeasurementRoots
open LeptonIntervals VacuumScaleProofs VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev Interval := Rat × Rat
/-- V3's comparison-side initial bracket; distinct from its formal sqrt_bracket grid. -/
def initialBracket (value : Rat) : Interval :=
 let upper := if zero.blt value then
   NeutrinolessBounds.wholeUpper value.num.natAbs value.den (value.num.natAbs+1) 1
   else 1
 if 1<upper then (wholeRatio (upper-1),wholeRatio upper)
 else if !(value.blt (normalize 1 4 (by decide))) then (normalize 1 2 (by decide),wholeRatio 1)
 else (normalize 1 1024 (by decide),wholeRatio 1)

def needsRefinement (b : Interval) : Bool :=
 (normalize 1 (10^12) (by decide)).blt (subtract b.2 b.1)

inductive SourceRun (value : Rat) : Interval → Interval → Prop where
 | stop (b : Interval) (h : needsRefinement b = false) : SourceRun value b b
 | next (b next result : Interval) (h : needsRefinement b = true)
   (step : NeutrinolessBounds.bisectSquare b value = .ok next)
   (later : SourceRun value next result) : SourceRun value b result

def refineWithin (value : Rat) : Nat → Interval → Except String (Option Interval)
 | 0,_ => .ok none
 | fuel+1,b => if needsRefinement b then do
    let next ← NeutrinolessBounds.bisectSquare b value
    refineWithin value fuel next
   else .ok (some b)

theorem refinementCorrespondence (value : Rat) (fuel : Nat) (b result : Interval)
 (h : refineWithin value fuel b = .ok (some result)) : SourceRun value b result := by
 induction fuel generalizing b with
 | zero => cases h
 | succ fuel ih =>
   unfold refineWithin at h
   cases hc : needsRefinement b with
   | false =>
     rw [hc] at h
     have he := Option.some.inj (Except.ok.inj h)
     cases he
     exact .stop result hc
   | true =>
     rw [hc] at h
     cases hs : NeutrinolessBounds.bisectSquare b value with
     | error e => rw [hs] at h; cases h
     | ok next =>
       rw [hs] at h
       exact .next b next result hc hs (ih _ h)

def sqrtRefined (value : Rat) : Except String Interval := do
 let result ← refineWithin value 41 (initialBracket value)
 match result with
 | some b => pure b
 | none => throw "unreachable: comparison precision refinement exhausted"

def lightestSquare : Rat := normalize 749 320000000 (by decide)
def lightestInterval : Interval := (normalize 430631417527 281474976710656 (by decide),normalize 1722525671131 1125899906842624 (by decide))
theorem lightestRefinement : refineWithin lightestSquare 41 (initialBracket lightestSquare) = .ok (some lightestInterval) := rfl
theorem lightestSourceRun : SourceRun lightestSquare (initialBracket lightestSquare) lightestInterval := refinementCorrespondence _ _ _ _ lightestRefinement
theorem lightestExact : sqrtRefined lightestSquare = .ok lightestInterval := rfl

def middleSquare : Rat := normalize 24717 320000000 (by decide)
def middleInterval : Interval := (normalize 1236894578135 140737488355328 (by decide),normalize 9895156626103 1125899906842624 (by decide))
theorem middleRefinement : refineWithin middleSquare 41 (initialBracket middleSquare) = .ok (some middleInterval) := rfl
theorem middleSourceRun : SourceRun middleSquare (initialBracket middleSquare) middleInterval := refinementCorrespondence _ _ _ _ middleRefinement
theorem middleExact : sqrtRefined middleSquare = .ok middleInterval := rfl

def heavySquare : Rat := normalize 2399047 960000000 (by decide)
def heavyInterval : Interval := (normalize 56283817330027 1125899906842624 (by decide),normalize 28141908665525 562949953421312 (by decide))
theorem heavyRefinement : refineWithin heavySquare 41 (initialBracket heavySquare) = .ok (some heavyInterval) := rfl
theorem heavySourceRun : SourceRun heavySquare (initialBracket heavySquare) heavyInterval := refinementCorrespondence _ _ _ _ heavyRefinement
theorem heavyExact : sqrtRefined heavySquare = .ok heavyInterval := rfl
end SFT.Physics.NeutrinoMeasurementRoots
