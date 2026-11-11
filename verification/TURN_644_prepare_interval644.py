from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'interval_spec644.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','interval').replace('Unit','InverseSquareInterval').replace('480','644');(w/('interval_'+part+'644.py')).write_text(s);subprocess.run(['python3',str(w/('interval_'+part+'644.py'))],check=True)
 s=(w/('InverseSquareInterval'+part.capitalize()+'644.lean')).read_text().replace('import «work».InverseSquareIntervalCarrier644','import SFT.Physics.InverseSquareInterval').replace('import «work».InverseSquareIntervalGrammar644','import SFT.Physics.InverseSquareIntervalGrammar\nimport SFT.Physics.InverseSquareInterval')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a)
  ws=['decide (InverseSquareInterval.exponents InverseSquareInterval.reportedLower InverseSquareInterval.reportedUpper = [2])','decide (1*InverseSquareInterval.reportedLower.denominator < InverseSquareInterval.reportedLower.numerator)','decide (InverseSquareInterval.reportedUpper.numerator < 3*InverseSquareInterval.reportedUpper.denominator)']
  s=s[:a]+''.join('def witness'+str(i)+' : Bool := '+v+'\ntheorem witness'+str(i)+'Passed : witness'+str(i)+' = true := rfl\n' for i,v in enumerate(ws))+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean witness'+str(i)+']' for i,x in enumerate(values['operational_witnesses']))+']\n'+s[b:]
 s=s.replace('set_option maxRecDepth 20000','set_option maxRecDepth 20000\nset_option maxHeartbeats 100000000')
 (r/'SFT/Physics'/('InverseSquareInterval'+part.capitalize()+'.lean')).write_text(s)
(w/'interval644_spec.json').write_text(json.dumps(values,indent=2))
