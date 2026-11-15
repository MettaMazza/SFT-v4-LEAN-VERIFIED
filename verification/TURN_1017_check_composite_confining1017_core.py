from pathlib import Path
import sys,json,subprocess,os,re,hashlib,concurrent.futures
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');runtime=w/'v3-runtime500';sys.path.insert(0,str(runtime.resolve()))
from sft.physics import composite_confining_sector_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
rel='sft/physics/composite_confining_sector_terminal_law_v1.py';pinned=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+rel]);assert (runtime/rel).read_bytes()==pinned
expected=[];expr=[]
def arg(x):return '(.boolean '+str(x).lower()+')' if isinstance(x,bool) else '(.integer ('+str(x)+'))'
def check(f,args,name,out):
 try:expected.append({'ok':canonical_value(f(*args))})
 except ValueError as e:expected.append({'error':str(e)})
 expr.append('out '+out+' ('+name+' '+ ' '.join(arg(a) for a in args)+')')
sectors=list(range(-2,65))+[100,128,False,True]
for sector in sectors:
 check(src.orbit_partition,[sector],'orbitPartition','orbitsValue')
 check(src.sector_certificate,[sector],'sectorCertificate','certificateValue')
 for label in (list(range(-1,sector+1))+[False,True] if isinstance(sector,int) and 2<sector<=32 else [-1,0,1,2,True,False]):
  check(src.orbit_from_label,[label,sector],'orbitFromLabel','inputList')
check(src.registered_sector_census,[],'registeredSectorCensus','certificates')
header='''import SFT.Physics.CompositeConfiningOrbits
import SFT.Host.Canonical
open SFT.Physics.CompositeConfining SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def rational (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def natValue (n : Nat) : Value := .integer (.ofNat n)
def nats (xs : List Nat) : Value := .array (xs.map natValue)
def rationals (xs : List Rat) : Value := .array (xs.map rational)
def pairs (xs : List (Nat × Nat)) : Value := .array (xs.map (fun (a,b) => .array [natValue a,natValue b]))
def inputValue : SFT.Physics.GeneratorOperations.CountInput → Value
 | .integer n => .integer n
 | .boolean b => .boolean b
def inputList (xs : List SFT.Physics.GeneratorOperations.CountInput) : Value := .array (xs.map inputValue)
def orbitsValue (xs : List (List Nat)) : Value := .array (xs.map nats)
def certificateValue (c : SectorCertificate) : Value := .object [
 ("sector",inputValue c.sector),("denominator",natValue c.denominator),("modes",nats c.modes),
 ("mode_count",natValue c.modeCount),("orbits",orbitsValue c.orbits),("orbit_sizes",nats c.orbitSizes),
 ("antipodal_pairs",pairs c.antipodalPairs),("antipodal_pair_count",natValue c.antipodalPairCount),
 ("coupling",rational c.coupling),("denominator_preserved",.boolean c.denominatorPreserved),
 ("Fold_is_bijective",.boolean c.foldIsBijective),("orbits_are_complete",.boolean c.orbitsAreComplete),
 ("pairs_are_complete",.boolean c.pairsAreComplete),("pairs_reassemble_One",.boolean c.pairsReassembleOne)]
def certificates (xs : List SectorCertificate) : Value := .array (xs.map certificateValue)
def out (f : α → Value) : Except String α → Value | .ok x => .object [("ok",f x)] | .error e => .object [("error",.text e)]
'''
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')}
def batch(i):
 p=w/f'constants-recovery/CompositeConfining1017_{i}.lean';p.write_text(header+'#eval IO.println (render (.array ['+',\n'.join(expr[i:i+100])+']))\n');x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/f'composite_confining1017_batch{i}.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];return json.loads(x.stdout)
with concurrent.futures.ThreadPoolExecutor(max_workers=8) as pool:actual=[a for rows in pool.map(batch,range(0,len(expr),100)) for a in rows]
assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:5]
p=r/'SFT/Physics/CompositeConfiningOrbits.lean';s=p.read_text();names=['SFT.Physics.CompositeConfining.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',s,re.M)];q=w/'composite_confining1017_core_audit.lean';q.write_text('import SFT.Physics.CompositeConfiningOrbits\n'+''.join('#print axioms '+n+'\n' for n in names));x=subprocess.run([lean,str(q)],env=env,capture_output=True,text=True);(w/'composite_confining1017_core_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'composite_confining1017_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),axioms=[],declarations=names,source_sha256=hashlib.sha256(p.read_bytes()).hexdigest(),original_sha256=hashlib.sha256(pinned).hexdigest(),scope='Original orbit order, Boolean label representation, partition and all14certificate fields; general loop bound and partition proofs remain separate obligations'),indent=2));print('PASS',len(expected),'source outputs;',len(names),'empty-axiom declarations')
