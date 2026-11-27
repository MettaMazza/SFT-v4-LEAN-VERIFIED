from pathlib import Path
import json,sys,dataclasses
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned_defect1488/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.defect_nonstoichiometry_law_v1 import *
from sft.engine.exact import HeldLabel,PositiveCount
from sft.claim_evidence.fold_language import EmptyOne
q=lambda x:json.dumps(x,ensure_ascii=False)
def encode(x):
 if isinstance(x,PositiveCount):return x.value
 if isinstance(x,EmptyOne):return {'emptyOne':x.identity}
 if dataclasses.is_dataclass(x):return {f.name:encode(getattr(x,f.name))for f in dataclasses.fields(x)}
 if isinstance(x,(tuple,list)):return [encode(z)for z in x]
 return x
L=lambda xs:'['+','.join(xs)+']'
def lab(x):return '⟨'+q(x.family)+','+q(x.label)+',by decide,by decide⟩'
def cnt(x):return '.emptyOne '+q(x.identity)if isinstance(x,EmptyOne)else '.count ⟨'+str(x.value)+',by decide⟩'
def val(x):return '.emptyOne '+q(x.identity)if isinstance(x,EmptyOne)else '.label '+lab(x)
def ref(x):return '⟨'+lab(x.site)+','+lab(x.expected_species)+'⟩'
def occ(x):return '⟨'+ref(x.reference)+',('+val(x.occupant)+')⟩'
def inter(x):return '⟨'+lab(x.site)+','+lab(x.occurrence)+'⟩'
def formula(x):return '⟨'+lab(x.species)+',⟨'+str(x.count.value)+',by decide⟩⟩'
def row(x):return '⟨'+lab(x.species)+','+','.join('('+cnt(getattr(x,k))+')'for k in ['reference_count','observed_count','missing_support','added_support'])+'⟩'
def classes(x):return '.emptyOne '+q(x.identity)if isinstance(x,EmptyOne)else '.support '+L(map(lab,x))
def expr(d):return 'defect '+lab(d['motif'])+' '+L(map(ref,d['reference_sites']))+' '+L(map(occ,d['site_occupancies']))+' '+L(map(inter,d['interstitials']))+' '+L(map(formula,d['reference_formula']))+' '+L(map(formula,d['observed_formula']))+' '+L(map(row,d['reconciliation']))+' ('+classes(d['defect_classes'])+') ('+val(d['origin_class'])+')'
cases=[]
for state in [defect_state('P',('A','A','B','B'),('A','A','B','B')),defect_state('V',('A','A','B','B'),('A',EMPTY_ONE,'B','B')),defect_state('I',('A','A','B','B'),('A','A','B','B'),('A',)),defect_state('S',('A','A','B','B'),('A','C','B','B'))]:
 d={f.name:getattr(state,f.name)for f in dataclasses.fields(state)};cases.append(d)
 mutations=[('motif',HeldLabel('wrong','M')),('reference_sites',()),('reference_sites',d['reference_sites']+(d['reference_sites'][0],)),('site_occupancies',d['site_occupancies'][:-1]),('site_occupancies',tuple(reversed(d['site_occupancies']))),('reference_formula',()),('observed_formula',()),('reconciliation',()),('defect_classes',(HeldLabel('defect-class','unknown'),)),('origin_class',HeldLabel('defect-origin','unknown'))]
 if d['interstitials']:mutations.append(('interstitials',d['interstitials']*2))
 for k,v in mutations:cases.append(dict(d,**{k:v}))
# Same site with different expected species is a distinct ReferenceSite in the original.
r1=ReferenceSite(HeldLabel('reference-solid-site','site'),species('A'));r2=ReferenceSite(r1.site,species('B'))
os=(SiteOccupancy(r1,occurrence('A','x')),SiteOccupancy(r2,occurrence('B','x')))
cases.append(dict(motif=HeldLabel('local-solid-motif','duplicate-site-different-species'),reference_sites=(r1,r2),site_occupancies=os,interstitials=(),reference_formula=primitive_formula(('A','B')),observed_formula=primitive_formula(('A','B')),reconciliation=reconcile_species((r1,r2),os,()),defect_classes=EMPTY_ONE,origin_class=EMPTY_ONE))
expected=[];expressions=[]
for d in cases:
 try:expected.append({'ok':encode(ExactDefectChemistry(**d))})
 except Exception as e:expected.append({'error':str(e)})
 expressions.append('result ('+expr(d)+')')
header=(w/'DefectCasesProgram1488.lean').read_text().split('def main')[0]
(w/'DefectConstructProgram1489.lean').write_text(header+'set_option maxHeartbeats 4000000\nset_option maxRecDepth 10000\ndef main : IO Unit := IO.println (Canonical.render (.array ['+','.join(expressions)+']))\n')
(w/'defect1489_construct_expected.json').write_text(json.dumps(expected))
s=(w/'check_defect1488_cases.py').read_text().replace('defect1488_cases','defect1489_construct').replace('DefectCasesProgram1488','DefectConstructProgram1489');(w/'check_defect1489_construct.py').write_text(s)
print('Prepared',len(cases),'original full constructor checks')
