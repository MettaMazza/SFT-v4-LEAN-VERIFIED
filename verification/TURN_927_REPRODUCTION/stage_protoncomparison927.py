from pathlib import Path
import sys,json
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_validation_v1 as src
pair=Fraction(1,6);product=Fraction(1,485);b=src.isolate_cubic_roots(pair,product);initial=b;n=0
while any(u-l>Fraction(1,10**15) for l,u in b[:2]):b=tuple(src.bisect_bracket(row,pair,product) for row in b);n+=1
rat=lambda x:f'normalize {x.numerator} {x.denominator} (by decide)'
ls=lambda b:'['+','.join('('+rat(l)+','+rat(u)+')' for l,u in b)+']'
s='''import SFT.Physics.QuarkIsolation
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
'''
s+='def initialBrackets : List Interval := '+ls(initial)+'\n'
s+='def refinedBrackets : List Interval := '+ls(b)+'\n'
s+='theorem originalIsolation : QuarkIsolation.isolateCubicRoots pairSum productValue = .ok initialBrackets := rfl\n'
s+=f'theorem originalRefinement : refineWithin {n+1} initialBrackets = some refinedBrackets := rfl\n'
s+='theorem exactSourceRun : SourceRun initialBrackets refinedBrackets := refinementCorrespondence _ _ _ originalRefinement\n'
s+='''def protonRatioInterval : Except String Interval := do
 let initial ← QuarkIsolation.isolateCubicRoots pairSum productValue
'''+f' let b ← match refineWithin {n+1} initial with\n'+'''  | none => .error "unreachable: certified original proton refinement"
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
'''
lo,hi=src.proton_ratio_interval();s+='def originalRatio : Interval := ('+rat(lo)+','+rat(hi)+')\n'
s+='theorem completeSourceRatio : protonRatioInterval = .ok originalRatio := rfl\nend SFT.Physics.ProtonComparison\n'
for root in [r,c]:(root/'SFT/Physics/ProtonComparison.lean').write_text(s)
(w/'protoncomparison927_original.json').write_text(json.dumps({'refinements':n,'ratio':[[x.numerator,x.denominator] for x in [lo,hi]],'brackets':[[[x.numerator,x.denominator] for x in row] for row in b]},indent=2));print('Original proton refinement:',n,'bisections;complete exact source interval staged')
