from pathlib import Path
import json,sys,dataclasses,itertools
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned_inorgnetwork1490/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.inorganic_acid_base_redox_network_law_v1 import *
from sft.claim_evidence.fold_language import EmptyOne,EMPTY_ONE
from sft.engine.exact import HeldLabel,PositiveCount
q=lambda x:json.dumps(x,ensure_ascii=False)
ls=lambda xs:'['+','.join(xs)+']'
def enc(x):
 if isinstance(x,PositiveCount):return x.value
 if isinstance(x,EmptyOne):return {'emptyOne':x.identity}
 if dataclasses.is_dataclass(x):return {f.name:enc(getattr(x,f.name))for f in dataclasses.fields(x)}
 if isinstance(x,(tuple,list)):return list(map(enc,x))
 return x
lab=lambda x:'⟨'+q(x.family)+','+q(x.label)+',by decide,by decide⟩'
num=lambda n:'⟨'+str(n)+',by decide⟩'
def lew(x):return '⟨'+','.join([lab(x.step),lab(x.pair_provider),lab(x.pair_acceptor),ls(map(lab,x.electron_pair)),lab(x.adduct)])+'⟩'
def red(x):return '⟨'+','.join([lab(x.step),lab(x.electron_donor),lab(x.electron_acceptor),ls(map(lab,x.electron_support))])+'⟩'
def support(xs,fn):return '.emptyOne '+q(xs.identity)if isinstance(xs,EmptyOne)else '.rows '+ls(map(fn,xs))
def net(x):return '⟨'+','.join([lab(x.network),ls(map(lab,x.species)),'('+support(x.acid_base_steps,lew)+')','('+support(x.redox_steps,red)+')',ls(map(lab,x.ordered_path))])+'⟩'
def sw(x):return '.lewis '+lew(x)if isinstance(x,ExactLewisAdductStep)else '.redox '+red(x)if isinstance(x,ExactRedoxStep)else '.other (.label '+lab(x)+')'
expected=[];expressions=[]
def add(kind,fn,expr):
 try:
  v=fn();out={'value':enc(v)}
  if kind=='Lewis':out['participants']=enc(v.participants)
  elif kind=='Redox':out.update(participants=enc(v.participants),transfer_count=v.transfer_count.value)
  else:out['step_count']=v.step_count.value
  expected.append({'ok':out})
 except Exception as e:expected.append({'error':str(e)})
 expressions.append('emit'+kind+' ('+expr+')')
for label,p,a,ad in itertools.product(['x',''],['B','A'],['A'],['P','B','A']):
 add('Lewis',lambda label=label,p=p,a=a,ad=ad:lewis_step(label,p,a,ad),'lewisStep '+' '.join(map(q,[label,p,a,ad])))
for label,d,a,n in itertools.product(['x',''],['D','A'],['A'],[1,2,3,5]):
 add('Redox',lambda label=label,d=d,a=a,n=n:redox_step(label,d,a,PositiveCount(n)),'redoxStep '+' '.join(map(q,[label,d,a]))+' '+num(n))
a=lewis_step('pair','B','A','P');r=redox_step('red','D','E',PositiveCount(2))
for label in ['reverse','', 'red']:
 add('Redox',lambda label=label:reverse_redox(r,label),'reverseRedox '+red(r)+' '+q(label))
# Direct source guards, preserving their original priority.
ld={f.name:getattr(a,f.name)for f in dataclasses.fields(a)}
lcases=[ld]
for k,vs in [('step',[HeldLabel('wrong','x')]),('pair_provider',[a.pair_acceptor,HeldLabel('wrong','B')]),('pair_acceptor',[a.adduct]),('adduct',[a.pair_provider]),('electron_pair',[(),(a.electron_pair[0],),a.electron_pair*2,(a.electron_pair[0],)*2,(HeldLabel('wrong','e'),a.electron_pair[1])])]:
 for v in vs:lcases.append(dict(ld,**{k:v}))
for d in lcases:
 add('Lewis',lambda d=d:ExactLewisAdductStep(**d),'lewis '+lab(d['step'])+' '+lab(d['pair_provider'])+' '+lab(d['pair_acceptor'])+' '+ls(map(lab,d['electron_pair']))+' '+lab(d['adduct']))
rd={f.name:getattr(r,f.name)for f in dataclasses.fields(r)};rcases=[rd]
for k,vs in [('step',[HeldLabel('wrong','x')]),('electron_donor',[r.electron_acceptor,HeldLabel('wrong','D')]),('electron_support',[(),(r.electron_support[0],)*2,(HeldLabel('wrong','e'),)])]:
 for v in vs:rcases.append(dict(rd,**{k:v}))
for d in rcases:add('Redox',lambda d=d:ExactRedoxStep(**d),'redox '+lab(d['step'])+' '+lab(d['electron_donor'])+' '+lab(d['electron_acceptor'])+' '+ls(map(lab,d['electron_support'])))
for sp,acid,rx,path in itertools.product([('B','A','P','D','E'),('B','A'),('D','E'),(),('B','A','P','D','E','B')],[(a,),()],[(r,),()],[('pair','red'),('red','pair'),('pair',),('red',),('pair','pair'),()]):
 add('Network',lambda sp=sp,acid=acid,rx=rx,path=path:reaction_network('N',sp,acid,rx,path),'reactionNetwork "N" '+ls(map(q,sp))+' '+ls(map(lew,acid))+' '+ls(map(red,rx))+' '+ls(map(q,path)))
n= reaction_network('N',('B','A','P'),(a,),(),('pair',))
for step in [r,redox_step('pair','D','E',PositiveCount(1)),redox_step('R','B','A',PositiveCount(3))]:
 add('Network',lambda step=step:append_redox_step(n,step),'appendRedox '+net(n)+' '+red(step))
# Raw tuple versus EmptyOne, custom identity and wrong transition-class rows.
for acid,rx in [((),(r,)),(EmptyOne('custom'),(r,)),((a,),()),((a,),EmptyOne('custom')),((r,),(r,)),((HeldLabel('x','y'),),(r,)),((a,),(a,)),((a,),(HeldLabel('x','y'),))]:
 path=('red',)if isinstance(acid,EmptyOne)or not acid else ('pair',)if isinstance(rx,EmptyOne)or not rx else ('pair','red')
 d=dict(network=HeldLabel('inorganic-reaction-network','N'),species=tuple(chemical_species(s)for s in ('B','A','P','D','E')),acid_base_steps=acid,redox_steps=rx,ordered_path=tuple(HeldLabel('inorganic-network-step',s)for s in path))
 add('Network',lambda d=d:ExactInorganicReactionNetwork(**d),'InorganicNetworkBoundary.networkInput '+lab(d['network'])+' '+ls(map(lab,d['species']))+' ('+support(acid,sw)+') ('+support(rx,sw)+') '+ls(map(lab,d['ordered_path'])))
header='''import SFT.Chemistry.InorganicNetworkBoundary
import SFT.Host.Canonical
open SFT.Chemistry SFT.Chemistry.InorganicNetwork SFT.Physics.CapabilityValues SFT.Host
abbrev J := Canonical.Value
def labelJ (x : HeldLabel) : J := .object [("family",.text x.family),("label",.text x.label)]
def labels (xs : List HeldLabel) : J := .array (xs.map labelJ)
def lewisJ (s : Lewis) : J := .object [("step",labelJ s.step),("pair_provider",labelJ s.provider),("pair_acceptor",labelJ s.acceptor),("electron_pair",labels s.pair),("adduct",labelJ s.adduct)]
def redoxJ (s : Redox) : J := .object [("step",labelJ s.step),("electron_donor",labelJ s.donor),("electron_acceptor",labelJ s.acceptor),("electron_support",labels s.electrons)]
def supportJ {α : Type} (f : α → J) : Support α → J
 | .emptyOne s => .object [("emptyOne",.text s)] | .rows xs => .array (xs.map f)
def networkJ (s : Network) : J := .object [("network",labelJ s.network),("species",labels s.species),("acid_base_steps",supportJ lewisJ s.acid),("redox_steps",supportJ redoxJ s.redox),("ordered_path",labels s.path)]
def emitLewis : Except String Lewis → J
 | .error e => .object [("error",.text e)]
 | .ok s => .object [("ok",.object [("value",lewisJ s),("participants",labels (lewisParticipants s))])]
def emitRedox : Except String Redox → J
 | .error e => .object [("error",.text e)]
 | .ok s => .object [("ok",.object [("value",redoxJ s),("participants",labels (redoxParticipants s)),("transfer_count",.integer (.ofNat s.electrons.length))])]
def emitNetwork : Except String Network → J
 | .error e => .object [("error",.text e)]
 | .ok s => .object [("ok",.object [("value",networkJ s),("step_count",.integer (.ofNat s.path.length))])]
set_option maxHeartbeats 20000000
set_option maxRecDepth 20000
'''
(w/'InorganicNetworkCasesProgram1490.lean').write_text(header+'def main : IO Unit := IO.println (Canonical.render (.array ['+','.join(expressions)+']))\n')
(w/'inorgnetwork1490_cases_expected.json').write_text(json.dumps(expected,ensure_ascii=False))
s=(w/'check_defect1488_cases.py').read_text().replace('defect1488_cases','inorgnetwork1490_cases').replace('DefectCasesProgram1488','InorganicNetworkCasesProgram1490').replace("['DefectChemistry']","['InorganicNetwork','InorganicNetworkBoundary']");(w/'check_inorgnetwork1490_cases.py').write_text(s)
print('Prepared',len(expected),'full original outputs and guards')
