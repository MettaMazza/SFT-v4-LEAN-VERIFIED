from pathlib import Path
import sys,json,subprocess,os,itertools,dataclasses,hashlib,re
w=Path('work');root=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1158/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import nuclear_electronic_law_v1 as m
from sft.engine.exact import HeldLabel
q=lambda x:json.dumps(x,ensure_ascii=False)
label=lambda x:x.family+':'+x.label
word=lambda xs:';'.join(map(label,xs))
def show(x):return '|'.join([label(x.molecular_carrier),word(x.nuclear_occurrences),word(x.isotope_labels),label(x.electronic_support),label(x.electronic_state),label(x.record)])
base=dict(molecular_carrier=HeldLabel('molecular-carrier','mol'),nuclear_occurrences=(HeldLabel('nuclear-occurrence','a'),HeldLabel('nuclear-occurrence','b')),isotope_labels=(HeldLabel('molecular-isotope','H'),HeldLabel('molecular-isotope','D')),electronic_support=HeldLabel('molecular-electronic-support','e'),electronic_state=HeldLabel('molecular-electronic-state','s'),record=HeldLabel('nuclear-electronic-record','r'))
cases=[base]
for key in ['molecular_carrier','electronic_support','electronic_state','record']:
 d=base.copy();d[key]=HeldLabel('wrong-family','retained');cases.append(d)
for n in range(5):
 for isotopeN in range(5):
  d=base.copy();d['nuclear_occurrences']=tuple(HeldLabel('nuclear-occurrence','site'+str(i))for i in range(n));d['isotope_labels']=tuple(HeldLabel('molecular-isotope','H')for _ in range(isotopeN));cases.append(d)
for key in ['nuclear_occurrences','isotope_labels']:
 for values in [(HeldLabel('wrong-family','a'),HeldLabel('wrong-family','b')),(base[key][0],base[key][0])]:
  d=base.copy();d[key]=values;cases.append(d)
lean=['import SFT.Chemistry.NuclearElectronic','open SFT.Chemistry.NuclearElectronic SFT.Physics.CapabilityValues','def lab (h : HeldLabel) := h.family++":"++h.label','def word (xs : List HeldLabel) := String.intercalate ";" (xs.map lab)','def display : Except String Support → String',' | .error e => "error:"++e',' | .ok s => String.intercalate "|" [lab s.molecularCarrier,word s.nuclearOccurrences,word s.isotopeLabels,lab s.electronicSupport,lab s.electronicState,lab s.record]','def showBool : Except String Bool → String',' | .error e => "error:"++e',' | .ok b => toString b','def main : IO Unit := do'];expected=[]
def lh(h):return '(← heldLabel '+q(h.family)+' '+q(h.label)+')'
def lw(xs):return '['+','.join(lh(h)for h in xs)+']'
for d in cases:
 try:result=show(m.NuclearElectronicSupport(**d))
 except Exception as e:result='error:'+str(e)
 expected.append(result);fields=[lh(d['molecular_carrier']),lw(d['nuclear_occurrences']),lw(d['isotope_labels']),lh(d['electronic_support']),lh(d['electronic_state']),lh(d['record'])];lean.append(' IO.println (display (do construct ⟨'+','.join(fields)+'⟩))')
for a,b in itertools.product([('protium','protium'),('protium','deuterium'),('deuterium','protium'),('deuterium','deuterium')],repeat=2):
 expected.append(str(m.equal_electronic_support_isotopologues(m._state(a,'a'),m._state(b,'b'))).lower());lean.append(' IO.println (showBool (do isotopologues (← state '+q(list(a))+' "a") (← state '+q(list(b))+' "b")))')
p=w/'NuclearElectronicParity1158.lean';p.write_text('\n'.join(lean)+'\n');env=dict(os.environ,LEAN_PATH=str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean')+':'+str(root.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');a=subprocess.run([sys.executable,'work/run_lean_guarded.py',str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'),'-j1','-M8192','--run',str(p)],env=env,capture_output=True,text=True);(w/'nuclearelectronic1158_parity.log').write_text(a.stdout+a.stderr);assert a.returncode==0,a.stdout[-1200:];assert a.stdout.splitlines()==expected,[(i,x,y)for i,(x,y)in enumerate(zip(a.stdout.splitlines(),expected))if x!=y][:3]
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();names=re.findall(r'^(?:def|theorem) (\w+)',(root/'SFT/Chemistry/NuclearElectronic.lean').read_text(),re.M);log=(w/'nuclearelectronic1158_audit.log').read_text();assert log.count('does not depend on any axioms')==len(names)
(w/'nuclearelectronic1158_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),isotopologue_pairs=16,native_sha256=H(root/'SFT/Chemistry/NuclearElectronic.lean'),source_sha256=H(w/'pinned1158/sft/chemistry/nuclear_electronic_law_v1.py'),empty_axiom_declarations=len(names)),indent=2)+'\n');print('PASS',len(expected),'original outcomes;',len(names),'empty-axiom declarations')
