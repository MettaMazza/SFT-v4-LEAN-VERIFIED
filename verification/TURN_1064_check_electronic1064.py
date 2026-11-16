from pathlib import Path
from dataclasses import asdict
import json,sys,subprocess,os,copy,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');runtime=w/'v3-runtime500';sys.path.insert(0,str(runtime.resolve()))
rel='sft/chemistry/electronic_structure_derivation.py';b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+rel]);p=runtime/rel
if p.exists():assert p.read_bytes()==b
else:p.write_bytes(b)
from sft.chemistry.electronic_structure_derivation import MolecularElectronicState,electronic_count,same_electronic_state,distinguishable_electronic_states
from sft.engine.exact import HeldLabel
q=json.dumps
base=dict(molecular_carrier_id='molecule-one',electron_occurrence_ids=('electron-one','electron-two'),held_spin_labels=(HeldLabel('electron-spin','fibre-a'),HeldLabel('electron-spin','fibre-b')),joint_support=(('electron-one',HeldLabel('molecular-electronic-support','joined-region')),('electron-two',HeldLabel('molecular-electronic-support','joined-region'))),observation_signature=HeldLabel('molecular-electronic-state','state-a'))
cases=[('original',base)]
def add(name,**kw):cases.append((name,{**base,**kw}))
add('emptyCarrier',molecular_carrier_id=' \t\n');add('unicodeBlank',molecular_carrier_id='\u3000');add('emptyOccurrences',electron_occurrence_ids=());add('duplicateOccurrences',electron_occurrence_ids=('electron-one','electron-one'));add('missingSpin',held_spin_labels=base['held_spin_labels'][:1]);add('wrongSpin',held_spin_labels=(HeldLabel('other','x'),base['held_spin_labels'][1]));add('missingSupport',joint_support=base['joint_support'][:1]);add('duplicateSupport',joint_support=(base['joint_support'][0],base['joint_support'][0]));add('extraSupport',joint_support=base['joint_support']+(('third',base['joint_support'][0][1]),));add('wrongSupportFamily',joint_support=(('electron-one',HeldLabel('other','joined-region')),base['joint_support'][1]));add('wrongSignatureFamily',observation_signature=HeldLabel('other','state-a'));add('differentCarrier',molecular_carrier_id='molecule-two');add('differentSignature',observation_signature=HeldLabel('molecular-electronic-state','state-b'));add('swappedPairs',held_spin_labels=tuple(reversed(base['held_spin_labels'])),joint_support=tuple(reversed(base['joint_support'])));add('renamedOccurrences',electron_occurrence_ids=('x','y'),joint_support=(('x',base['joint_support'][0][1]),('y',base['joint_support'][1][1])));add('distinctSupport',joint_support=(('electron-one',HeldLabel('molecular-electronic-support','split')),('electron-two',HeldLabel('molecular-electronic-support','split'))))
def label(v):return '⟨'+q(v.family)+','+q(v.label)+',by rfl,by rfl⟩'
def state(d):return '⟨'+q(d['molecular_carrier_id'])+','+q(d['electron_occurrence_ids'])+',['+','.join(label(v)for v in d['held_spin_labels'])+'],['+','.join('('+q(k)+','+label(v)+')'for k,v in d['joint_support'])+'],'+label(d['observation_signature'])+'⟩'
s='''import SFT.Chemistry.MolecularElectronicWitnesses
open SFT.Chemistry.MolecularElectronicState SFT.Chemistry.MolecularElectronicWitnesses SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def evaluate (input : State) : Value := match valid input with
 | .error e=>.text e
 | .ok v=>.object [("count",match electronicCount v with | .ok n=>.integer (.ofNat n.value) | .error e=>.text e),("same",.boolean (sameElectronicState originalA v)),("distinction",match distinguishableElectronicStates originalA v with | .ok b=>.boolean b | .error e=>.text e)]
'''
expected=[];left=MolecularElectronicState(**base)
for name,d in cases:
 try:
  v=MolecularElectronicState(**d)
  try:dist=distinguishable_electronic_states(left,v)
  except ValueError as e:dist=str(e)
  out=dict(count=electronic_count(v).value,same=same_electronic_state(left,v),distinction=dist)
 except ValueError as e:out=str(e)
 expected.append(out);s+='#eval IO.println (render (evaluate ('+state(d)+')))\n'
p=w/'electronic1064_cases.lean';p.write_text(s);x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'electronic1064_check.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=[json.loads(l)for l in x.stdout.splitlines()if l.startswith(('{','"'))];assert actual==expected,[(cases[i][0],a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b];(w/'electronic1064_report.json').write_text(json.dumps(dict(status='PASS',complete_outputs=len(cases),source_sha256=hashlib.sha256(b).hexdigest(),lean_sha256=hashlib.sha256((r/'SFT/Chemistry/MolecularElectronicState.lean').read_bytes()).hexdigest()),indent=2));print('PASS',len(cases),'source operations and guards')
