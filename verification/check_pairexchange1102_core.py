from pathlib import Path
import json,sys,itertools,subprocess,os,re,hashlib
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.chemistry import pair_exchange_law_v1 as src
from sft.engine.canonical import canonical_value
from sft.engine.exact import HeldLabel,PositiveCount,InadmissibleExactValue
q=lambda s:json.dumps(s,ensure_ascii=False)
held=lambda x:'⟨'+q(x.family)+','+q(x.label)+',by rfl,by rfl⟩'
pc=lambda n:'⟨'+str(n)+',by decide⟩'
expected=[];expr=[];kinds={}
def add(kind,fn,expression):
 try:result={'ok':canonical_value(fn())}
 except InadmissibleExactValue as e:result={'error':str(e)}
 expected.append(result);expr.append(expression);kinds[kind]=kinds.get(kind,0)+1
labels=[src.PRESERVING_EXCHANGE,src.ALTERNATING_EXCHANGE,HeldLabel('wrong-family','preserving-exchange'),HeldLabel('exchange-class','unknown')]
for a,b in itertools.product(labels,repeat=2):add('exchange',lambda a=a,b=b:src.exchange_product(a,b),'labelResult (exchangeProduct '+held(a)+' '+held(b)+')')
for n in range(1,10):add('builder',lambda n=n:src.pair_state_from_multiplicity('H2','test',PositiveCount(n)),'stateResult (fromMultiplicity "H2" "test" '+pc(n)+')')
for m,spin,spatial,total,cell in itertools.product([1,2,3,4],[src.PRESERVING_EXCHANGE,src.ALTERNATING_EXCHANGE],[src.PRESERVING_EXCHANGE,src.ALTERNATING_EXCHANGE],[src.PRESERVING_EXCHANGE,src.ALTERNATING_EXCHANGE],[src.SAME_CELL_ADMITTED,src.SAME_CELL_EXCLUDED]):
 args=[HeldLabel('molecular-carrier','H2'),HeldLabel('molecular-electronic-state','test'),PositiveCount(m),spin,spatial,total,cell]
 native='⟨'+','.join(pc(x.value)if isinstance(x,PositiveCount)else held(x)for x in args)+'⟩'
 add('constructor',lambda args=args:src.MolecularElectronPairState(*args),'stateResult (validate '+native+')')
for m,n in itertools.product([1,3],range(1,6)):
 add('occupancy',lambda m=m,n=n:src.explicit_occupancy_compatible(src.pair_state_from_multiplicity('H2','test',PositiveCount(m)),PositiveCount(n)),'boolResult (do let state ← fromMultiplicity "H2" "test" '+pc(m)+'; occupancyCompatible state '+pc(n)+')')
for mol,support,a,b in [('H2','same','singlet','triplet'),('H2','same','same','same'),('','same','a','b'),('H2','','a','b')]:add('same_support',lambda mol=mol,support=support,a=a,b=b:src.build_same_support_pair(mol,support,a,b),'pairResult (buildSameSupport '+' '.join(q(x)for x in [mol,support,a,b])+')')
s='''import SFT.Chemistry.PairExchange
open SFT.Chemistry.PairExchange SFT.Physics.CapabilityValues
abbrev J := SFT.Host.Canonical.Value
def labelValue (h : HeldLabel) : J := .object [("family",.text h.family),("label",.text h.label)]
def stateValue (s : PairState) : J := .object [
 ("molecular_carrier",labelValue s.molecularCarrier),("state_identity",labelValue s.stateIdentity),
 ("positive_spin_multiplicity",.object [("value",.integer (.ofNat s.multiplicity.value))]),
 ("spin_exchange",labelValue s.spinExchange),("spatial_exchange",labelValue s.spatialExchange),
 ("total_exchange",labelValue s.totalExchange),("same_cell_status",labelValue s.sameCellStatus)]
def pairValue (p : SameSupportPair) : J := .object [
 ("molecular_carrier",labelValue p.molecularCarrier),("support_identity",labelValue p.supportIdentity),
 ("singlet_state",stateValue p.singlet),("triplet_state",stateValue p.triplet)]
def result {α : Type} (encode : α → J) : Except String α → J
 | .error e => .object [("error",.text e)]
 | .ok v => .object [("ok",encode v)]
def labelResult := result labelValue
def stateResult := result stateValue
def pairResult := result pairValue
def boolResult := result SFT.Host.Canonical.Value.boolean
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
'''+',\n'.join(expr)+']))\n'
p=w/'PairExchangeCoreProgram1102.lean';p.write_text(s)
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
with(w/'pairexchange1102_core_output.json').open('w')as out,(w/'pairexchange1102_core_execution.log').open('w')as err:subprocess.run([sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)],env=env,stdout=out,stderr=err,check=True)
actual=json.loads((w/'pairexchange1102_core_output.json').read_text());assert actual==expected,[(i,a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:1]
log=(w/'pairexchange1102_core_build.log').read_text();names=re.findall(r"'([^']+)' does not depend on any axioms",log);assert len(names)==15 and 'depends on axioms:'not in log
(w/'pairexchange1102_core_report.json').write_text(json.dumps({'status':'PASS','cases':kinds,'total_cases':len(expected),'axioms':[],'declarations':names,'source_sha256':hashlib.sha256((r/'SFT/Chemistry/PairExchange.lean').read_bytes()).hexdigest(),'scope':'Original pair constructors, exchange table, occupancy and same-support assembly, with existing complete spin census reused; not full entry completion.'},indent=2)+'\n');print('PASS',len(expected),'original cases,',len(names),'empty-axiom declarations')
