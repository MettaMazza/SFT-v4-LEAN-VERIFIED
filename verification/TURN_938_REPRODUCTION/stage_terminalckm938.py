from pathlib import Path
import sys,json
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.matter_flavour_terminal_ckm_laws_v1 import terminal_ckm_relation,terminal_ckm_slope_contribution
from sft.physics.matter_flavour_terminal_ckm_validation_v1 import refined_quark_roots
from sft.physics.matter_flavour_laws_v1 import isolate_cubic_roots,quark_cubic_invariants,bisect_bracket
s='''import SFT.Physics.QuarkDressing
namespace SFT.Physics.TerminalCKM
open LeptonIntervals VacuumLedgerProofs
def slopeContribution : Except String Rat := do
 let inverse ← AlphaRatio.inverseFineStructure none
 let inverseAlpha := BoundaryGrowth.asFraction inverse
 let alpha ← LeptonRatios.divide (wholeRatio 1) inverseAlpha
 let factors ← QuarkDressing.quarkDressingFactors
 let colour ← FoldFirstReturn.generatorPeriod
 let contribution ← LeptonRatios.divide (multiply alpha factors.upperUpRetention) (wholeRatio colour)
 let direct ← LeptonRatios.divide (wholeRatio 1) (multiply (wholeRatio colour) (add inverseAlpha (wholeRatio 7)))
 if !(contribution == direct) then throw "terminal CKM contribution routes disagree"
 pure contribution
structure Result where
 leadingS23 : String
 terminalContribution : Rat
 terminalS23 : String
 s12Squared : String
 s13Squared : String
 phase : Rat
def terminalCKMRelation : Except String Result := do
 let contribution ← slopeContribution
 pure ⟨"positive-difference-of-down-and-up-central-to-heavy-root-slopes",contribution,
 "leading-s23-plus-terminal-contribution","unchanged-down-light-to-central-mass-ratio",
 "s12-squared-times-terminal-s23-squared-over-six-channel-support",normalize 1 2 (by decide)⟩
'''
x=terminal_ckm_slope_contribution();s+=f'def originalContribution : Rat := normalize {x.numerator} {x.denominator} (by decide)\n';s+='''theorem exactContribution : slopeContribution=.ok originalContribution := rfl
def originalRecord : Result := ⟨"positive-difference-of-down-and-up-central-to-heavy-root-slopes",originalContribution,
 "leading-s23-plus-terminal-contribution","unchanged-down-light-to-central-mass-ratio",
 "s12-squared-times-terminal-s23-squared-over-six-channel-support",normalize 1 2 (by decide)⟩
theorem completeSourceRecord : terminalCKMRelation=.ok originalRecord := rfl
theorem contributionPositive : (normalize 1 (10^9) (by decide)).blt originalContribution=true := rfl
end SFT.Physics.TerminalCKM
'''
for root in [r,c]:(root/'SFT/Physics/TerminalCKM.lean').write_text(s)
# Same original isolation/bisection, with this source's distinct stopping precision.
s=(r/'SFT/Physics/QuarkComparison.lean').read_text();s=s[:s.index('def square (')];s=s.replace('import SFT.Physics.QuarkIsolation\nimport SFT.Physics.QuarkDressing','import SFT.Physics.QuarkComparison').replace('namespace SFT.Physics.QuarkComparison','namespace SFT.Physics.TerminalQuarkRoots').replace('(10^12)','(10^15)')
a=s.index('def downPair');b=s.index('def refinedDown');s=s[:a]+'''abbrev downPair := QuarkComparison.downPair
abbrev downProduct := QuarkComparison.downProduct
abbrev upPair := QuarkComparison.upPair
abbrev upProduct := QuarkComparison.upProduct
abbrev initialDown := QuarkComparison.initialDown
abbrev initialUp := QuarkComparison.initialUp
theorem initialSource : QuarkIsolation.rootBrackets=.ok (initialDown,initialUp) := QuarkComparison.initialSource

'''+s[b:]
import re
root_values=refined_quark_roots();steps={}
for name,values in quark_cubic_invariants().items():
 brackets=isolate_cubic_roots(values[1],values[2]);count=0
 while any(hi-lo>Fraction(1,10**15) for lo,hi in brackets):brackets=tuple(bisect_bracket(row,values[1],values[2]) for row in brackets);count+=1
 assert brackets==root_values[name];steps[name]=count+1
 def fraction(x):return f'normalize {x.numerator} {x.denominator} (by decide)'
 body='['+','.join('('+fraction(lo)+','+fraction(hi)+')' for lo,hi in brackets)+']'
 cap=name.capitalize();s=re.sub(r'def refined'+cap+r' : List Interval := .*',f'def refined{cap} : List Interval := {body}',s)
 s=s.replace(('35' if name=='down' else '33')+' '+('initialDown' if name=='down' else 'initialUp'),str(count+1)+' '+('initialDown' if name=='down' else 'initialUp'))
 s=s.replace(('35 down' if name=='down' else '33 up'),str(count+1)+' '+('down' if name=='down' else 'up'))
s+='end SFT.Physics.TerminalQuarkRoots\n'
for root in [r,c]:(root/'SFT/Physics/TerminalQuarkRoots.lean').write_text(s)
(w/'terminalckm938_refinement_steps.json').write_text(json.dumps(steps));print('original contribution',x,'source refinement stopping budgets',steps)
