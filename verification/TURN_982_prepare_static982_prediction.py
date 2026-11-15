from pathlib import Path
import sys,json
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import static_exterior_clock_terminal_validation_v1 as src
s=(r/'SFT/Physics/SymmetricPrediction.lean').read_text().replace('SymmetricSourceConservation','StaticExteriorClock').replace('SymmetricPrediction','StaticPrediction').replace('SYMMETRIC-SOURCE-CONSERVATION-TERMINAL-010','STATIC-EXTERIOR-CLOCK-TERMINAL-011').replace('D9n','D9o')
a=s.index('def formalPredictionInputs');b=s.index('def experimentId');q=json.dumps
s=s[:a]+'def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do\n pure ['+','.join('('+q(k)+',.label (← CapabilityValues.heldLabel '+q(v.family)+' '+q(v.label)+'))' for k,v in src.formal_prediction_inputs().items())+']\n'+s[b:]
for root in [r,w/'constants-recovery']:(root/'SFT/Physics/StaticPrediction.lean').write_text(s)
for old,new in [('constants-recovery/SymmetricPredictionCompare980.lean','constants-recovery/StaticPredictionCompare982.lean'),('check_symmetric980_prediction.py','check_static982_prediction.py')]:
 s=(w/old).read_text().replace('symmetric_source_conservation','static_exterior_clock').replace('Symmetric','Static').replace('symmetric980','static982').replace('Compare980','Compare982');(w/new).write_text(s)
