from pathlib import Path
import sys,json,itertools,dataclasses
w=Path('work');stage=w/'pinned1135';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import coordination_entity_law_v1 as v
from sft.engine.exact import HeldLabel,PositiveCount
from sft.engine.canonical import canonical_value
C=['coordination-central-occurrence','Fe-one'];E=['coordination-entity','example-entity'];M=['coordination-central-element','Fe']
def a(n,group='a'):
 return dict(number=n,central=C,ligand=['coordination-ligand-occurrence','ligand-'+str(n)],group=['coordination-ligand-group',group],trace=['positive-coordination-incidence','trace-'+str(n)])
def attachment(x):return v.RetainedCoordinationAttachment(PositiveCount(x['number']),HeldLabel(*x['central']),HeldLabel(*x['ligand']),HeldLabel(*x['group']),HeldLabel(*x['trace']))
def ent(rows):return dict(entity=E,element=M,central=C,rows=rows)
cases=[]
for n in range(1,17):
 rows=[a(i, 'same-group' if i%2 else 'other-group')for i in range(1,n+1)]
 cases += [dict(op='identity',**ent(rows)),dict(op='append',**ent(rows),successor=a(n+1))]
for n in range(0,7):
 rows=[a(i)for i in range(1,n+1)];cases.append(dict(op='entity',**ent(rows)))
 if n:
  for k in range(n):
   for field,val in [('number',n+2),('central',['coordination-central-occurrence','different']),('ligand',rows[0]['ligand']),('trace',rows[0]['trace'])]:
    changed=[dict(x)for x in rows];changed[k][field]=val;cases.append(dict(op='entity',**ent(changed)))
  for number in [1,n,n+1,n+2]:
   for field,val in [('central',C),('central',['coordination-central-occurrence','different']),('ligand',rows[0]['ligand']),('trace',rows[0]['trace'])]:
    successor=a(number);successor[field]=val;cases.append(dict(op='append',**ent(rows),successor=successor))
for field in ['entity','element','central']:
 x=ent([a(1)]);x[field]=['wrong-family','valid'];cases.append(dict(op='entity',**x))
for flags in itertools.product([False,True],repeat=4):
 x=a(1)
 for field,invalid in zip(['central','ligand','group','trace'],flags):
  if invalid:x[field]=['wrong-family','valid']
 cases.append(dict(op='attachment',attachment=x))
outputs=[]
for x in cases:
 try:
  if x['op']=='attachment':result=attachment(x['attachment'])
  else:
   entity=v.CompleteCoordinationEntity(HeldLabel(*x['entity']),HeldLabel(*x['element']),HeldLabel(*x['central']),tuple(attachment(y)for y in x['rows']))
   if x['op']=='identity':result=v.forced_coordination_entity_identity_law(entity)
   elif x['op']=='append':result=v.append_ligand_preserves_coordination_identity(entity,attachment(x['successor']))
   else:result=entity
  outputs.append(dict(ok=canonical_value(result)))
 except Exception as e:outputs.append(dict(error=str(e)))
(w/'coordination1135_input.json').write_text(json.dumps(cases)+'\n');(w/'coordination1135_expected.json').write_text(json.dumps(outputs)+'\n');print('Original cases',len(cases))
