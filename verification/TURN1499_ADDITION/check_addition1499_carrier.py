from pathlib import Path
import sys,json,copy,subprocess,os,hashlib
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__.insert(0,str((w/'pinned_addition1499/sft/chemistry').resolve()))
from sft.chemistry import addition_reaction_law_v3 as v
from sft.chemistry.addition_reaction_law_v1 import AdditionBond,AdditionState,FreeAdditionSupport
from sft.engine.exact import HeldLabel
from sft.engine.canonical import canonical_value
states=[]
for result in [v._simple_example('same'),v._simple_example('adjacent'),v._simple_example('nonadjacent'),v._simple_example('adjacent',3),v._cycloaddition_example()]:states += [canonical_value(result.source),canonical_value(result.terminal)]
base=states[0]
for case in ['duplicate_atom','wrong_identity','duplicate_support','bond_outside','free_outside']:
 s=copy.deepcopy(base)
 if case=='duplicate_atom':s['atoms'].append(s['atoms'][0])
 if case=='wrong_identity':s['identity']['family']='wrong-family'
 if case=='duplicate_support':s['bonds'].append(s['bonds'][0])
 if case=='bond_outside':s['bonds'][0]['right']={'family':'addition-atom-occurrence','label':'outside'}
 if case=='free_outside':s['free_supports']=[{'owner':{'family':'addition-atom-occurrence','label':'outside'},'held_support':{'family':'addition-held-support','label':'outside-support'}}]
 states.append(s)
def held(d):return HeldLabel(**d)
expected=[]
for s in states:
 try:
  actual=AdditionState(held(s['identity']),tuple(map(held,s['atoms'])),tuple(AdditionBond(held(b['left']),held(b['right']),held(b['held_support']))for b in s['bonds']),tuple(FreeAdditionSupport(held(b['owner']),held(b['held_support']))for b in s['free_supports']));expected.append({'value':canonical_value(actual)})
 except ValueError as e:expected.append({'error':str(e)})
(w/'addition1499_carrier_input.json').write_text(json.dumps(states,indent=2)+'\n');(w/'addition1499_carrier_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
tc=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0';env=dict(os.environ,LEAN_PATH=':'.join([str(tc/'lib/lean'),str(r.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean']))
with(w/'addition1499_carrier_output.json').open('w')as out,(w/'addition1499_carrier_run.log').open('w')as err:subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192','--run','work/AdditionCarrierCases1499.lean'],env=env,stdout=out,stderr=err,check=True)
assert json.load(open(w/'addition1499_carrier_output.json'))==expected
(w/'addition1499_carrier_report.json').write_text(json.dumps(dict(status='PASS',valid_current_v3_states=10,original_rejection_cases=5,all_nested_fields_match=True,source_sha256=hashlib.sha256((r/'SFT/Chemistry/AdditionCarrier.lean').read_bytes()).hexdigest()),indent=2)+'\n');print('PASS10currentv3statesand5originalrejections')
