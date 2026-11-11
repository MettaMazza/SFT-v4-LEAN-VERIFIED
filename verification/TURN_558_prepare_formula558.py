from pathlib import Path
import subprocess,json,re
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'formula_spec558.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','formula').replace('Unit','Formula').replace('480','558');(w/('formula_'+part+'558.py')).write_text(s);subprocess.run(['python3',str(w/('formula_'+part+'558.py'))],check=True)
 s=(w/('Formula'+part.capitalize()+'558.lean')).read_text().replace('import «work».FormulaCarrier558','import SFT.Chemistry.FormulaComposition\nimport SFT.Foundation.CommonRefinement').replace('import «work».FormulaGrammar558','import SFT.Chemistry.FormulaGrammar').replace('SFT.Physics.Formula','SFT.Chemistry.Formula')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 s=s.replace('{survivor with carrier := .rejected}', '{survivor with domain := .rejected}')
 if part == 'grammar':
  pieces=re.split(r'("(?:[^"\\]|\\.)*")',s)
  for i in range(0,len(pieces),2):pieces[i]=re.sub(r'\bstructure\b(?! Candidate where)', '«structure»',pieces[i])
  s=''.join(pieces)
 (r/'SFT/Chemistry'/('Formula'+part.capitalize()+'.lean')).write_text(s)
(w/'formula558_spec.json').write_text(json.dumps(values,indent=2))
