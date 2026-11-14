from pathlib import Path
import json
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');trace=json.loads((w/'quark926_refinement_trace.json').read_text())
s='''import SFT.Physics.QuarkIsolation
import SFT.Physics.QuarkDressing
namespace SFT.Physics.QuarkComparison
open LeptonIntervals
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev Interval := Rat × Rat

def precision : Rat := normalize 1 (10^12) (by decide)
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

def downPair : Rat := normalize 1 8 (by decide)
def downProduct : Rat := normalize 1 383 (by decide)
def upPair : Rat := normalize 1 12 (by decide)
def upProduct : Rat := normalize 1 3071 (by decide)
def initialDown : List Interval := [(normalize 1 64 (by decide),normalize 1 32 (by decide)),(normalize 7 64 (by decide),normalize 1 8 (by decide)),(normalize 27 32 (by decide),normalize 55 64 (by decide))]
def initialUp : List Interval := [(normalize 1 256 (by decide),normalize 1 128 (by decide)),(normalize 11 128 (by decide),normalize 23 256 (by decide)),(normalize 29 32 (by decide),normalize 233 256 (by decide))]
theorem initialSource : QuarkIsolation.rootBrackets = .ok (initialDown,initialUp) := rfl
'''
for name,row in trace.items():
 vals='['+','.join('('+','.join(f'normalize {n} {d} (by decide)' for n,d in b)+')' for b in row['result'])+']'
 cap=name.capitalize();s+=f'\ndef refined{cap} : List Interval := {vals}\n'
 s+=f'theorem exact{cap} : refineWithin {name}Pair {name}Product {row["steps"]+1} initial{cap} = some refined{cap} := rfl\n'
 s+=f'theorem source{cap} : SourceRun {name}Pair {name}Product initial{cap} refined{cap} := refinementCorrespondence _ _ _ _ _ exact{cap}\n'
s+='''
def refinedQuarkRoots : Except String (List Interval × List Interval) := do
 let cubics ← QuarkInvariants.cubicInvariants
 let (down,up) ← QuarkIsolation.rootBrackets
 let d := refineWithin (BoundaryGrowth.asFraction cubics.down.2.1) (BoundaryGrowth.asFraction cubics.down.2.2) 35 down
 let u := refineWithin (BoundaryGrowth.asFraction cubics.up.2.1) (BoundaryGrowth.asFraction cubics.up.2.2) 33 up
 match d with
 | none => throw "unreachable: certified original down refinement"
 | some ds => match u with
   | none => throw "unreachable: certified original up refinement"
   | some us => pure (ds,us)
theorem completeRefinedRoots : refinedQuarkRoots = .ok (refinedDown,refinedUp) := rfl

def square (x : Rat) := multiply x x
/-- V3 has no additional positivity guard on this operation. -/
def squareRatioInterval (numerator denominator : Interval) : Except String Interval := do
 let lower ← LeptonRatios.divide numerator.1 denominator.2
 let upper ← LeptonRatios.divide numerator.2 denominator.1
 pure (square lower,square upper)
def scaled (x : Interval) (factor : Rat) : Interval := (multiply x.1 factor,multiply x.2 factor)
def inverted (x : Interval) : Except String Interval := do
 let lower ← LeptonRatios.divide (normalize 1 1 (by decide)) x.2
 let upper ← LeptonRatios.divide (normalize 1 1 (by decide)) x.1
 pure (lower,upper)
def overlaps (x y : Interval) : Bool := !y.2.blt x.1 && !x.2.blt y.1
structure QuarkPredictions where
 sOverD : Interval
 bOverS : Interval
 tOverC : Interval

def quarkPredictionIntervals : Except String QuarkPredictions := do
 let (down,up) ← refinedQuarkRoots
 let factors ← QuarkDressing.quarkDressingFactors
 let d0 ← LeptonRatios.atIndex down 0
 let d1 ← LeptonRatios.atIndex down 1
 let d2 ← LeptonRatios.atIndex down 2
 let u1 ← LeptonRatios.atIndex up 1
 let u2 ← LeptonRatios.atIndex up 2
 let sd ← squareRatioInterval d1 d0
 let bs ← squareRatioInterval d2 d1
 let tc ← squareRatioInterval u2 u1
 let inv ← LeptonRatios.divide (normalize 1 1 (by decide)) factors.centralDownLift
 pure ⟨scaled sd factors.centralDownLift,scaled bs inv,scaled tc factors.upperUpRetention⟩

structure CKMPredictions where
 s12Squared : Interval
 s23Squared : Interval
 s13Squared : Interval
 jarlskogSquared : Interval

def ckmPredictionIntervals : Except String CKMPredictions := do
 let (down,up) ← refinedQuarkRoots
 let d0 ← LeptonRatios.atIndex down 0
 let d1 ← LeptonRatios.atIndex down 1
 let d2 ← LeptonRatios.atIndex down 2
 let u1 ← LeptonRatios.atIndex up 1
 let u2 ← LeptonRatios.atIndex up 2
 let s12 ← squareRatioInterval d0 d1
 let dl ← LeptonRatios.divide d1.1 d2.2
 let du ← LeptonRatios.divide d1.2 d2.1
 let ul ← LeptonRatios.divide u1.1 u2.2
 let uu ← LeptonRatios.divide u1.2 u2.1
 let s23 := (subtract dl uu,subtract du ul)
 if !zero.blt s23.1 then throw "CKM positive slope separation failed"
 let s23sq := (square s23.1,square s23.2)
 let s13l ← LeptonRatios.divide (multiply s12.1 s23sq.1) (normalize 6 1 (by decide))
 let s13u ← LeptonRatios.divide (multiply s12.2 s23sq.2) (normalize 6 1 (by decide))
 let one := normalize 1 1 (by decide)
 let first := (multiply s12.1 (subtract one s12.1),multiply s12.2 (subtract one s12.2))
 let second := (multiply s23sq.1 (subtract one s23sq.1),multiply s23sq.2 (subtract one s23sq.2))
 let third := (multiply s13l (square (subtract one s13u)),multiply s13u (square (subtract one s13l)))
 pure ⟨s12,s23sq,(s13l,s13u),(multiply (multiply first.1 second.1) third.1,multiply (multiply first.2 second.2) third.2)⟩
end SFT.Physics.QuarkComparison
'''
for root in [r,c]:(root/'SFT/Physics/QuarkComparison.lean').write_text(s)
print('Staged original precision refinement, source-run proofs and all quark/CKM prediction operations')
