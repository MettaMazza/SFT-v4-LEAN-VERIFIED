from pathlib import Path
import json,hashlib,sys,subprocess,os,dataclasses
w=Path('work');cache=w/'pinned1070';runtime=w/'v3-runtime500';ident=json.load(open(cache/'SOURCE_IDENTITIES.json'));assert ident['commit']=='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
for f in ident['files']:
 if not f['path'].startswith('sft/chemistry/rovibronic_'):continue
 b=(cache/f['path']).read_bytes();assert hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()==f['sha'];p=runtime/f['path'];p.parent.mkdir(parents=True,exist_ok=True)
 if p.exists():assert p.read_bytes()==b
 else:p.write_bytes(b)
sys.path.insert(0,str(runtime.resolve()))
from sft.chemistry import rovibronic_composition_derivation as src
from sft.engine.exact import HeldLabel,PositiveCount
from sft.engine.canonical import canonical_value
E=src._electronic_state();H=src.MolecularRovibronicState(E,('nucleus-one','nucleus-two'),(HeldLabel('molecular-isotope','protium'),)*2,PositiveCount(1),PositiveCount(1),HeldLabel('molecular-spin-state','singlet'),HeldLabel('molecular-rovibronic-observation','h2-ground-row'))
D=dataclasses.replace(H,isotope_labels=(HeldLabel('molecular-isotope','deuterium'),)*2,observation_record=HeldLabel('molecular-rovibronic-observation','d2-ground-row'))
cases=[];lean=[]
def add(name,expr,fn):
 try:
  x=fn();out={'key':x.exact_state_key,'vibration':x.vibrational_recurrence.value,'rotation':x.rotational_recurrence.value}
 except ValueError as e:out={'error':str(e)}
 cases.append([name,canonical_value(out)]);lean.append('('+json.dumps(name)+',runCase ('+expr+'))')
add('hydrogen','hydrogen',lambda:H);add('deuterium','deuterium',lambda:D)
mods=[('empty-nuclei','{hydrogen with nuclearOccurrenceIds := []}',dict(nuclear_occurrence_ids=())),('duplicate-nuclei','{hydrogen with nuclearOccurrenceIds := ["nucleus-one","nucleus-one"]}',dict(nuclear_occurrence_ids=('nucleus-one','nucleus-one'))),('missing-isotope','incomplete',dict(isotope_labels=(HeldLabel('molecular-isotope','protium'),),observation_record=HeldLabel('molecular-rovibronic-observation','incomplete'))),('wrong-isotope','{hydrogen with isotopeLabels := [wrong,protium]}',dict(isotope_labels=(HeldLabel('wrong','x'),HeldLabel('molecular-isotope','protium')))),('wrong-spin','{hydrogen with heldSpinState := wrong}',dict(held_spin_state=HeldLabel('wrong','x'))),('wrong-observation','{hydrogen with observationRecord := wrong}',dict(observation_record=HeldLabel('wrong','x'))),('empty-id-retained','{hydrogen with nuclearOccurrenceIds := ["","nucleus-two"]}',dict(nuclear_occurrence_ids=('','nucleus-two'))),('mixed-isotopes','{hydrogen with isotopeLabels := [protium,deuteriumLabel]}',dict(isotope_labels=(HeldLabel('molecular-isotope','protium'),HeldLabel('molecular-isotope','deuterium'))))]
for name,expr,kwargs in mods:add(name,expr,lambda kwargs=kwargs:dataclasses.replace(H,**kwargs))
for v in [1,2,3,8]:
 for r in [1,2,5]:add(f'ordinals-{v}-{r}',f'{{hydrogen with vibrationalOrdinal := ⟨{v},by decide⟩, rotationalOrdinal := ⟨{r},by decide⟩}}',lambda v=v,r=r:dataclasses.replace(H,vibrational_ordinal=PositiveCount(v),rotational_ordinal=PositiveCount(r)))
comparisons=[];lc=[]
for name,right,expr in [('same',H,'hydrogen'),('isotope',D,'deuterium'),('renamed-occurrences',dataclasses.replace(H,nuclear_occurrence_ids=('a','b')),'{hydrogen with nuclearOccurrenceIds := ["a","b"]}'),('other-carrier',dataclasses.replace(H,electronic_state=dataclasses.replace(E,molecular_carrier_id='other')),'{hydrogen with electronicState := {electronic with molecularCarrierId := "other"}}')]:
 try:out=src.isotopologue_distinguishable(H,right)
 except ValueError as e:out={'error':str(e)}
 comparisons.append([name,out]);lc.append('('+json.dumps(name)+',comparison ('+expr+'))')
s='''import SFT.Chemistry.MolecularRovibronicWitnesses
open SFT.Chemistry.MolecularRovibronicState SFT.Chemistry.MolecularRovibronicWitnesses SFT.Physics.CapabilityValues SFT.Host.Canonical
set_option maxRecDepth 100000
def wrong : HeldLabel := ⟨"wrong","x",by rfl,by rfl⟩
def runCase (s : State) : SFT.Host.Canonical.Value := match valid s with
 | .error e=>.object [("error",.text e)]
 | .ok s=>match exactStateKey s, vibrationalRecurrence s, rotationalRecurrence s with
   | .ok k,.ok v,.ok r=>.object [("key",keyValue k),("vibration",.integer (.ofNat v.value)),("rotation",.integer (.ofNat r.value))]
   | _,_,_=>.text "unexpected recurrence failure"
def comparison (s : State) : SFT.Host.Canonical.Value := match isotopologueDistinguishable hydrogen s with | .ok b=>.boolean b | .error e=>.object [("error",.text e)]
#eval IO.println (render (.object [("cases",.array ((['''+','.join(lean)+'''] : List (String × SFT.Host.Canonical.Value)).map fun (name,v)=>.array [.text name,v])),("comparisons",.array ((['''+','.join(lc)+'''] : List (String × SFT.Host.Canonical.Value)).map fun (name,v)=>.array [.text name,v])),("witnesses",.array (witnesses.map fun x=>.array [.text x.name,.text x.statement,.boolean x.passed]))]))
'''
p=w/'rovibronic1070_cases.lean';p.write_text(s);env=dict(os.environ,LEAN_PATH=str((w/'turn1064_recovery').resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
x=subprocess.run([sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192',str(p)],env=env,capture_output=True,text=True);(w/'rovibronic1070_operations.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-1800:]+x.stderr[-400:]
actual=json.loads(next(l for l in x.stdout.splitlines()if l.startswith('{')));expected=canonical_value({'cases':cases,'comparisons':comparisons,'witnesses':src.OPERATIONAL_WITNESSES});assert actual==expected,[k for k in actual if actual[k]!=expected[k]]
report={'status':'PASS','source_commit':ident['commit'],'state_and_guard_cases':len(cases),'comparison_cases':len(comparisons),'original_witnesses':3,'all_result_fields_match':True,'source_sha256':hashlib.sha256((cache/'sft/chemistry/rovibronic_composition_derivation.py').read_bytes()).hexdigest()};(w/'rovibronic1070_operations_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
