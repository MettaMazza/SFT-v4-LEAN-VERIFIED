from pathlib import Path
import json,sys
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_validation_v1 as src
from fractions import Fraction
record=json.loads((w/'mattervalidation926_original_record.json').read_text());rows=next(x for x in record['sources'] if x['source_id']=='PDG-2025-NEUTRINO-MIXING')['rows'];anchor=Fraction(rows['solar_delta_mass_squared_eV2']['value']);m=src.neutrino_mass_squares()
s='''import SFT.Physics.NeutrinolessBounds
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
'''
rat=lambda v:f'normalize {v.numerator} {v.denominator} (by decide)'
for name in ['lightest','middle','heavy']:
 value=anchor*m[name];lo,hi=src.sqrt_refined(value)
 s+=f'\ndef {name}Square : Rat := '+rat(value)+'\n'
 s+=f'def {name}Interval : Interval := ('+rat(lo)+','+rat(hi)+')\n'
 s+=f'theorem {name}Refinement : refineWithin {name}Square 41 (initialBracket {name}Square) = .ok (some {name}Interval) := rfl\n'
 s+=f'theorem {name}SourceRun : SourceRun {name}Square (initialBracket {name}Square) {name}Interval := refinementCorrespondence _ _ _ _ {name}Refinement\n'
 s+=f'theorem {name}Exact : sqrtRefined {name}Square = .ok {name}Interval := rfl\n'
s+='end SFT.Physics.NeutrinoMeasurementRoots\n'
for root in [r,c]:(root/'SFT/Physics/NeutrinoMeasurementRoots.lean').write_text(s)
(w/'neutrinomeasurement928_original.json').write_text(json.dumps({k: [[x.numerator,x.denominator] for x in src.sqrt_refined(anchor*m[k])] for k in ['lightest','middle','heavy']},indent=2));print('Staged exact comparison-side root initialization, refinement and all three source-run proofs')
