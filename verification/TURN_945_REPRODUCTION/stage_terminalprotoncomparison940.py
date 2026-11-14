from pathlib import Path
import sys,re,json
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.matter_flavour_terminal_proton_validation_v1 import refined_roots,terminal_proton_prediction_interval
from sft.physics.matter_flavour_laws_v1 import isolate_cubic_roots,bisect_bracket
s=(r/'SFT/Physics/ProtonComparison.lean').read_text().replace('import SFT.Physics.QuarkIsolation\nimport SFT.Physics.LeptonRatios','import SFT.Physics.TerminalProton').replace('namespace SFT.Physics.ProtonComparison','namespace SFT.Physics.TerminalProtonComparison').replace('end SFT.Physics.ProtonComparison','end SFT.Physics.TerminalProtonComparison').replace('(10^15)','(10^18)')
s=re.sub(r'def pairSum : Rat := .*','abbrev pairSum := ProtonComparison.pairSum',s);s=re.sub(r'def productValue : Rat := .*','abbrev productValue := ProtonComparison.productValue',s);s=re.sub(r'def initialBrackets : List Interval := .*','abbrev initialBrackets := ProtonComparison.initialBrackets',s)
s=s.replace('theorem originalIsolation : QuarkIsolation.isolateCubicRoots pairSum productValue = .ok initialBrackets := rfl','theorem originalIsolation : QuarkIsolation.isolateCubicRoots pairSum productValue = .ok initialBrackets := ProtonComparison.originalIsolation')
b=isolate_cubic_roots(Fraction(1,6),Fraction(1,485));steps=0
while any(hi-lo>Fraction(1,10**18) for lo,hi in b[:2]):b=tuple(bisect_bracket(x,Fraction(1,6),Fraction(1,485)) for x in b);steps+=1
assert b==refined_roots()
def rat(x):return f'normalize ({x.numerator}) {x.denominator} (by decide)'
def pair(x):return '('+rat(x[0])+','+rat(x[1])+')'
s=re.sub(r'def refinedBrackets : List Interval := .*','def refinedBrackets : List Interval := ['+','.join(pair(x) for x in b)+']',s).replace('refineWithin 44','refineWithin '+str(steps+1))
s=s.replace(' pure (multiply third (subtract eUpper mLower),multiply third (subtract eLower mUpper))',''' let base := (multiply third (subtract eUpper mLower),multiply third (subtract eLower mUpper))
 let retention ← TerminalProton.retention
 let result := (multiply base.1 retention,multiply base.2 retention)
 let dressing ← TerminalProton.dressing
 if !result.1.blt result.2 || !(add retention dressing == one) then
  throw "terminal proton exact enclosure failed"
 pure result''')
s=re.sub(r'def originalRatio : Interval := .*','def originalRatio : Interval := '+pair(terminal_proton_prediction_interval()),s)
for root in [r,c]:(root/'SFT/Physics/TerminalProtonComparison.lean').write_text(s)
(w/'terminalproton940_refinement_steps.json').write_text(json.dumps({'refinements':steps,'budget_including_stop':steps+1}));print('exact source refinements',steps)
