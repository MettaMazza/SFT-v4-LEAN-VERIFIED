from pathlib import Path
import sys,json,os,subprocess,hashlib,re
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1164/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.rovibronic_joint_law_v1 import ResolvedRovibronicState
from sft.engine.exact import HeldLabel,PositiveCount
from sft.claim_evidence.fold_language import EmptyOne,PositiveRatio
q=lambda x:json.dumps(x,ensure_ascii=False)
base=dict(carrier=HeldLabel('molecular-carrier','H2'),isotope_support=(HeldLabel('molecular-isotope','H'),HeldLabel('molecular-isotope','H')),electronic_state=HeldLabel('molecular-electronic-state','X'),spin_multiplicity=PositiveCount(1),vibrational_coordinate=PositiveRatio.from_pair(2,4),rotational_coordinate=EmptyOne(),transition_record=HeldLabel('molecular-transition-record','t'),source_record=HeldLabel('resolved-spectrum-record','r'))
cases=[base]
for k in ['carrier','electronic_state','transition_record','source_record']:
 d=base.copy();d[k]=HeldLabel('wrong','same');cases.append(d)
for xs in [(),(HeldLabel('wrong','H'),),base['isotope_support']*2]:
 d=base.copy();d['isotope_support']=xs;cases.append(d)
for spin in [1,3,5]:
 for v in [EmptyOne(),EmptyOne('retained-absence'),PositiveRatio.from_pair(6,9)]:
  d=base.copy();d['spin_multiplicity']=PositiveCount(spin);d['vibrational_coordinate']=v;cases.append(d)
text=['import SFT.Chemistry.ResolvedRovibronic','open SFT.Chemistry.ResolvedRovibronic SFT.Physics.CapabilityValues','open SFT.Chemistry.AnalyticalAccuracy (ratio)','def coord : CoordinateKey → String',' | .emptyOne x => "empty:"++x',' | .positive n d => toString n++"/"++toString d','def showState : Except String State → String',' | .error e => "error:"++e',' | .ok s =>','   let (c,i,e,m,v,r,t,src) := jointKey s','   String.intercalate "|" [c,String.intercalate "," i,e,toString m,coord v,coord r,t,src]','def main : IO Unit := do'];expected=[]
def label(h):return '(← heldLabel '+q(h.family)+' '+q(h.label)+')'
def coord(x):return '.emptyOne '+q(x.identity) if isinstance(x,EmptyOne) else '.positive (← ratio '+str(x.numerator.value)+' '+str(x.denominator.value)+')'
def coordtxt(x):return 'empty:'+x.identity if isinstance(x,EmptyOne) else str(x.numerator.value)+'/'+str(x.denominator.value)
for d in cases:
 try:
  s=ResolvedRovibronicState(**d);expected.append('|'.join([s.carrier.label,','.join(x.label for x in s.isotope_support),s.electronic_state.label,str(s.spin_multiplicity.value),coordtxt(s.vibrational_coordinate),coordtxt(s.rotational_coordinate),s.transition_record.label,s.source_record.label]))
 except Exception as e:expected.append('error:'+str(e))
 fields=[label(d['carrier']),'['+','.join(label(x) for x in d['isotope_support'])+']',label(d['electronic_state']),'(← count '+str(d['spin_multiplicity'].value)+')',coord(d['vibrational_coordinate']),coord(d['rotational_coordinate']),label(d['transition_record']),label(d['source_record'])];text.append(' IO.println (showState (do construct ⟨'+','.join(fields)+'⟩))')
p=w/'ResolvedCore1164.lean';p.write_text('\n'.join(text)+'\n');env=dict(os.environ,LEAN_PATH=str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean')+':'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');cmd=[sys.executable,'work/run_lean_guarded.py',str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'),'-j1','-M8192'];a=subprocess.run(cmd+['--run',str(p)],env=env,capture_output=True,text=True);(w/'resolved1164_core.log').write_text(a.stdout+a.stderr);assert a.returncode==0,a.stdout[-1800:];assert a.stdout.splitlines()==expected
names=[]
for m in ['ResolvedRovibronic','ResolvedRovibronicAnalysis']:
 names+=['SFT.Chemistry.'+m+'.'+x for x in re.findall(r'^(?:def|theorem)\s+(\w+)',(r/'SFT/Chemistry'/f'{m}.lean').read_text(),re.M)]
p=w/'ResolvedCoreAudit1164.lean';p.write_text('import SFT.Chemistry.ResolvedRovibronic\nimport SFT.Chemistry.ResolvedRovibronicAnalysis\n'+'\n'.join('#print axioms '+n for n in names)+'\n');a=subprocess.run(cmd+[str(p)],env=env,capture_output=True,text=True);(w/'resolved1164_core_audit.log').write_text(a.stdout+a.stderr);assert a.returncode==0 and a.stdout.count('does not depend on any axioms')==len(names),a.stdout[-1000:]
(w/'resolved1164_core_report.json').write_text(json.dumps({'status':'PASS','cases':len(cases),'empty_axiom_declarations':len(names),'names':names,'module_sha256':{m:hashlib.sha256((r/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest() for m in ['ResolvedRovibronic','ResolvedRovibronicAnalysis']}},indent=2)+'\n');print('PASS',len(cases),'source outcomes;',len(names),'empty-axiom declarations')
