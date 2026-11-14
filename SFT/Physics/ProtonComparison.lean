import SFT.Physics.QuarkIsolation
import SFT.Physics.LeptonRatios
namespace SFT.Physics.ProtonComparison
open LeptonIntervals
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev Interval := Rat × Rat

def pairSum : Rat := normalize 1 6 (by decide)
def productValue : Rat := normalize 1 485 (by decide)
def needsRefinement (b : List Interval) : Bool :=
 (b.take 2).any (fun row => (normalize 1 (10^15) (by decide)).blt (subtract row.2 row.1))
def refine (b : List Interval) := b.map (fun row => QuarkIsolation.bisectBracket row pairSum productValue)
inductive SourceRun : List Interval → List Interval → Prop where
 | stop (b : List Interval) (h : needsRefinement b = false) : SourceRun b b
 | next (b result : List Interval) (h : needsRefinement b = true) (later : SourceRun (refine b) result) : SourceRun b result

def refineWithin : Nat → List Interval → Option (List Interval)
 | 0,_ => none
 | fuel+1,b => if needsRefinement b then refineWithin fuel (refine b) else some b

theorem refinementCorrespondence (fuel : Nat) (b result : List Interval)
 (h : refineWithin fuel b = some result) : SourceRun b result := by
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
def initialBrackets : List Interval := [(normalize 1 128 (by decide),normalize 1 64 (by decide)),(normalize 3 16 (by decide),normalize 25 128 (by decide)),(normalize 101 128 (by decide),normalize 51 64 (by decide))]
def refinedBrackets : List Interval := [(normalize 7566294310285 562949953421312 (by decide),normalize 15132588620571 1125899906842624 (by decide)),(normalize 217767466298325 1125899906842624 (by decide),normalize 108883733149163 562949953421312 (by decide)),(normalize 55812490745233 70368744177664 (by decide),normalize 892999851923729 1125899906842624 (by decide))]
theorem originalIsolation : QuarkIsolation.isolateCubicRoots pairSum productValue = .ok initialBrackets := rfl
theorem originalRefinement : refineWithin 44 initialBrackets = some refinedBrackets := rfl
theorem exactSourceRun : SourceRun initialBrackets refinedBrackets := refinementCorrespondence _ _ _ originalRefinement
def protonRatioInterval : Except String Interval := do
 let initial ← QuarkIsolation.isolateCubicRoots pairSum productValue
 let b ← match refineWithin 44 initial with
  | none => .error "unreachable: certified original proton refinement"
  | some b => .ok b
 let electron ← LeptonRatios.atIndex b 0
 let muon ← LeptonRatios.atIndex b 1
 let one := normalize 1 1 (by decide)
 let third := normalize 1 3 (by decide)
 let eUpper ← LeptonRatios.divide one (multiply electron.2 electron.2)
 let mLower ← LeptonRatios.divide one (multiply muon.1 muon.1)
 let eLower ← LeptonRatios.divide one (multiply electron.1 electron.1)
 let mUpper ← LeptonRatios.divide one (multiply muon.2 muon.2)
 pure (multiply third (subtract eUpper mLower),multiply third (subtract eLower mUpper))
def originalRatio : Interval := (normalize 6647232150008981586362187682708805392463796704398777778176 3619855159284659888504732594761554720032170662722926875 (by decide),normalize 1246356028126696348938510654095646023126189871994725466112 678722842365790259090370540028061200119822441818517025 (by decide))
theorem completeSourceRatio : protonRatioInterval = .ok originalRatio := rfl
end SFT.Physics.ProtonComparison
