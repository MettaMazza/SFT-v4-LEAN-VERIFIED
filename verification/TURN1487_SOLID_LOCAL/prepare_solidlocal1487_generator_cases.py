from pathlib import Path
import json,sys,itertools,dataclasses
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned_solidlocal1485/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.solid_state_local_coordination_law_v1 import local_solid
from sft.engine.exact import PositiveCount
from sft.claim_evidence.fold_language import EmptyOne,EMPTY_ONE
q=lambda x:json.dumps(x,ensure_ascii=False)
def encode(x):
 if isinstance(x,PositiveCount):return x.value
 if isinstance(x,EmptyOne):return {'emptyOne':x.identity}
 if dataclasses.is_dataclass(x):return {f.name:encode(getattr(x,f.name))for f in dataclasses.fields(x)}
 if isinstance(x,(tuple,list)):return [encode(z)for z in x]
 return x
cases=[]
for a,b,rank in itertools.product(range(1,4),range(1,4),range(1,5)):cases.append(('AB',[('A',a),('B',b)],[(('A',1),('B',1))],rank,None))
for second in [None,1,2,'custom']:cases.append(('host',[('H',2),('G',1)],[(('H',1),('G',1))],3,second))
for sp in ['', ' ', 'α', 'A#1','A#2','A#+1','A#-1','A# 1 ','A#١','A#１','A#1_0','A#_1','A#1_','A#1__0','A#x','A#','A##1','A#1#x','A#\t2\n','A#\x1c1','A#\u200b1',"A#'x",'A#"x','A#\\x']:
 cases.append(('M',[(sp,2)],[],1,None));cases.append(('M',[(sp,2)],[((sp,1),(sp,2))],1,None))
for edges in [[],[(('A',1),('A',1))],[(('A',1),('Z',1))],[(('A',0),('B',1))],[(('A',-1),('B',1))],[(('A',1),('B',1)),(('B',1),('A',1))],[(('A',1),('B',1))]*2]:cases.append(('M',[('A',2),('B',2)],edges,2,None))
cases += [('M',[],[],1,None),('',[('A',1)],[],1,None),('M',[('A',1),('A',2)],[],1,None)]
expected=[];expressions=[]
def count(n):return '⟨'+str(n)+',by decide⟩'
def key(k):return '('+q(k[0])+','+str(k[1])+')'
for motif,counts,bonds,rank,second in cases:
 try:
  sc=EMPTY_ONE if second is None else EmptyOne(second) if isinstance(second,str) else PositiveCount(second)
  result=local_solid(motif,tuple((s,PositiveCount(n))for s,n in counts),tuple(bonds),PositiveCount(rank),sc);expected.append({'ok':encode(result)})
 except Exception as e:expected.append({'error':str(e)})
 secondlean='.emptyOne '+q('empty-One'if second is None else second)if second is None or isinstance(second,str)else '.count '+count(second)
 expressions.append('encode (SolidLocalGenerator.localSolid '+q(motif)+' ['+','.join('('+q(s)+','+count(n)+')'for s,n in counts)+'] ['+','.join('('+key(a)+','+key(b)+')'for a,b in bonds)+'] '+count(rank)+' ('+secondlean+'))')
s=(w/'SolidLocalConstructProgram1486.lean').read_text().split('def main')[0].replace('import SFT.Chemistry.SolidLocal','import SFT.Chemistry.SolidLocalGenerator')+'\ndef main : IO Unit := IO.println (Canonical.render (.array ['+','.join(expressions)+']))\n'
s=s.replace('open SFT.Chemistry.SolidLocal','open SFT.Chemistry SFT.Chemistry.SolidLocal')
(w/'SolidLocalGeneratorProgram1487.lean').write_text(s);(w/'solidlocal1487_generator_expected.json').write_text(json.dumps(expected,ensure_ascii=False)+'\n')
s=(w/'check_solidlocal1486_construct.py').read_text().replace('solidlocal1486_construct','solidlocal1487_generator').replace('SolidLocalConstructProgram1486','SolidLocalGeneratorProgram1487').replace("modules=['SolidLocal']","modules=['SolidLocal','SolidLocalGenerator']");(w/'check_solidlocal1487_generator.py').write_text(s)
print('Prepared',len(cases),'full original local_solid comparisons')
