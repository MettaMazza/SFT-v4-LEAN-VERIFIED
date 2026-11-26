from pathlib import Path
import sys,importlib.util,json,dataclasses,copy
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
p=w/'pinned_coordisomer1473/sft/chemistry/coordination_isomerism_law_v1.py';spec=importlib.util.spec_from_file_location('coordisomer_original1473',p);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
def enc(x):
 if isinstance(x,m.HeldLabel):return {'family':x.family,'label':x.label}
 if isinstance(x,m.PositiveCount):return x.value
 if isinstance(x,m.EmptyOne):return {'empty':x.identity}
 if dataclasses.is_dataclass(x):return {f.name:enc(getattr(x,f.name)) for f in dataclasses.fields(x)}
 if isinstance(x,(list,tuple)):return [enc(y) for y in x]
 return x
def decform(d):
 c=lambda v:m.EmptyOne(v['empty']) if 'empty' in v else m.HeldLabel(v['family'],v['label'])
 return m.FiniteCoordinationForm(tuple(c(v) for v in d['composition_labels']),tuple(c(v) for v in d['attachment_labels']),tuple(tuple(c(v) for v in xs) for xs in d['orientation_words']),tuple(tuple(m.PositiveCount(n) for n in xs) for xs in d['adjacency_pairs']))
rows=[];outputs=[]
def add(row):
 try:
  form=decform(row['form']);op=row['op']
  if op=='construct':out=form
  elif op=='canonical':out=m._canonical(form,row.get('orientation',True))
  elif op=='mirror':out=m._mirror(form)
  elif op=='forced':out=m.forced_coordination_isomer_relation(form,decform(row['right']))
  elif op=='extend':
   c=row['composition'];a=row['attachment'];cells=tuple(m.EmptyOne(x['empty']) if 'empty'in x else m.HeldLabel(x['family'],x['label']) for x in row['word']);prior=m.EmptyOne() if row['prior'] is None else tuple(m.PositiveCount(n) for n in row['prior']);out=m.extend_coordination_form(form,m.HeldLabel(c['family'],c['label']),m.HeldLabel(a['family'],a['label']),cells,prior)
  outputs.append({'ok':enc(out)})
 except Exception as e:outputs.append({'error':str(e)})
 rows.append(row)
base=enc(m._BASE)
for f in [m._BASE,m._CHIRAL,m._SUCCESSOR,m._mirror(m._CHIRAL)]:
 for op in ['construct','canonical','mirror']:add(dict(op=op,form=enc(f)))
 add(dict(op='canonical',form=enc(f),orientation=False))
for left,right in [(m._BASE,m._BASE),(m._BASE,m._form('mode-two')),(m._BASE,m._form('mode-one','fibre-one')),(m._CHIRAL,m._mirror(m._CHIRAL)),(m._BASE,m._CHIRAL)]:add(dict(op='forced',form=enc(left),right=enc(right)))
for field,value in [('composition_labels',[]),('attachment_labels',[]),('orientation_words',[[{'empty':'empty-One'}]*3]*2),('orientation_words',[[{'empty':'empty-One'}]]*2),('adjacency_pairs',[[1,1]]),('adjacency_pairs',[[1,3]]),('adjacency_pairs',[[1,2],[2,1]])]:
 d=copy.deepcopy(base);d[field]=value;add(dict(op='construct',form=d))
for field,index,family,label in [('composition_labels',0,'wrong','L'),('attachment_labels',0,'wrong','mode-one')]:
 d=copy.deepcopy(base);d[field][index]=dict(family=family,label=label);add(dict(op='construct',form=d))
d=copy.deepcopy(base);d['orientation_words'][0][0]['label']='fibre-three';add(dict(op='construct',form=d))
d=copy.deepcopy(base);d['composition_labels'][0]['label']='different';add(dict(op='forced',form=base,right=d))
for prior in [None,[],[1,2],[1,1],[3]]:add(dict(op='extend',form=base,composition={'family':'coordination-composition-label','label':'L'},attachment={'family':'coordination-attachment-mode','label':'mode-one'},word=[{'family':'fold-orientation-fibre','label':'fibre-two'},{'family':'fold-orientation-fibre','label':'fibre-two'},{'empty':'empty-One'}],prior=prior))
(w/'coordisomer1473_core_cases.json').write_text(json.dumps(rows)+'\n');(w/'coordisomer1473_core_expected.json').write_text(json.dumps(outputs,indent=2)+'\n');print(len(rows),'fresh pinned source cases')
