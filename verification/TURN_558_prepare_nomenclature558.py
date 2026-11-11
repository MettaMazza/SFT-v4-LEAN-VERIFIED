from pathlib import Path
import subprocess,json,re
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'nomenclature_spec558.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','nomenclature').replace('Unit','Nomenclature').replace('480','558');(w/('nomenclature_'+part+'558.py')).write_text(s);subprocess.run(['python3',str(w/('nomenclature_'+part+'558.py'))],check=True)
 s=(w/('Nomenclature'+part.capitalize()+'558.lean')).read_text().replace('import «work».NomenclatureCarrier558','import SFT.Chemistry.NomenclatureWord\nimport SFT.Foundation.CommonRefinement').replace('import «work».NomenclatureGrammar558','import SFT.Chemistry.NomenclatureGrammar').replace('SFT.Physics.Nomenclature','SFT.Chemistry.Nomenclature')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 if part == 'grammar':
  pieces=re.split(r'("(?:[^"\\]|\\.)*")',s)
  for i in range(0,len(pieces),2):pieces[i]=re.sub(r'\bprefix\b', '«prefix»',pieces[i])
  s=''.join(pieces)
 (r/'SFT/Chemistry'/('Nomenclature'+part.capitalize()+'.lean')).write_text(s)
(w/'nomenclature558_spec.json').write_text(json.dumps(values,indent=2))
