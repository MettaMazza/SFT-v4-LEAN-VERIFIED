from pathlib import Path
import sys,os,json,dataclasses,subprocess,re,time,hashlib
w=Path('work');root=(w/'turn1064_recovery').resolve();sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.chemistry import electron_count_spin_law_v1 as src
from sft.engine.exact import PositiveCount,HeldLabel
from sft.engine.canonical import canonical_value
from sft.claim_evidence.fold_language import EMPTY_ONE,EmptyOne
expected=[];cases=[];q=lambda s:json.dumps(s,ensure_ascii=False)
def add(name,expr,fn):
 try:out=canonical_value(fn())
 except (ValueError,AssertionError) as e:out={'error':str(e) if str(e) else 'AssertionError'}
 expected.append([name,out]);cases.append('('+q(name)+','+expr+')')
def held(f,l):return '⟨'+q(f)+','+q(l)+',by rfl,by rfl⟩'
def pc(n):return '⟨'+str(n)+',by decide⟩'
for n in range(1,21):
 for width in [1,2,3,n,n+1,n+2]:
  add(f'organization-{n}-{width}',f'orgResult (buildCompleteSpinOrganization "test" {pc(n)} {pc(width)})',lambda n=n,width=width:src.build_complete_spin_organization('test',PositiveCount(n),PositiveCount(width)))
for label in ['', ' ', 'C–O']:
 add('molecular-label-'+repr(label),'orgResult (buildCompleteSpinOrganization '+q(label)+' '+pc(2)+' '+pc(1)+')',lambda label=label:src.build_complete_spin_organization(label,PositiveCount(2),PositiveCount(1)))
for n in range(1,17):
 add('parity-'+str(n),'labelResult (requiredSpinWidthParity '+pc(n)+')',lambda n=n:src.required_spin_width_parity(PositiveCount(n)))
pop=src.NuclearPopulation(HeldLabel('element-symbol','C'),PositiveCount(6),PositiveCount(2))
lp='⟨'+held('element-symbol','C')+','+pc(6)+','+pc(2)+'⟩'
for action in ['empty-One','adjoin-electron','remove-electron']:
 for n in ([0] if action=='empty-One' else [1,11,12,13]):
  transfer=src.HeldChargeTransfer(HeldLabel('electron-transfer',action),EMPTY_ONE if n==0 else PositiveCount(n))
  lt='⟨'+held('electron-transfer',action)+','+('structuralEmpty'if n==0 else '.count '+pc(n))+'⟩'
  add('electron-count-'+action+'-'+str(n),'countResult (exactElectronCount ['+lp+'] '+lt+')',lambda transfer=transfer:src.exact_electron_count((pop,),transfer))
add('empty-nuclei','countResult (exactElectronCount [] ElectronCountSpinWitnesses.neutral)',lambda:src.exact_electron_count((),src.HeldChargeTransfer(HeldLabel('electron-transfer','empty-One'),EMPTY_ONE)))
cell_specs=[('empty',[]),('pair',['fibre-a','fibre-b']),('reversed',['fibre-b','fibre-a']),('duplicate',['fibre-a','fibre-a']),('three',['fibre-a','fibre-b','fibre-c']),('foreign',['fibre-c']),('single',['fibre-a'])]
for name,labels in cell_specs:
 expr='cellResult (validCell ⟨'+held('electron-support-cell','test')+',['+','.join(held('electron-spin',x)for x in labels)+']⟩)'
 add('cell-'+name,expr,lambda labels=labels:src.SpinCell(HeldLabel('electron-support-cell','test'),tuple(HeldLabel('electron-spin',x)for x in labels)))
base=src.build_complete_spin_organization('CO',PositiveCount(14),PositiveCount(1))
mods=[('duplicate-occurrence','{s with electronOccurrenceIds := s.electronOccurrenceIds.head! :: s.electronOccurrenceIds.head! :: s.electronOccurrenceIds.drop 2}',lambda:dataclasses.replace(base,electron_occurrence_ids=(base.electron_occurrence_ids[0],)*2+base.electron_occurrence_ids[2:])),('missing-occurrence','{s with electronOccurrenceIds := s.electronOccurrenceIds.drop 1}',lambda:dataclasses.replace(base,electron_occurrence_ids=base.electron_occurrence_ids[1:])),('missing-cell','{s with cells := s.cells.drop 1}',lambda:dataclasses.replace(base,cells=base.cells[1:])),('wrong-width','{s with spinWidth := '+pc(2)+'}',lambda:dataclasses.replace(base,spin_width=PositiveCount(2))),('wrong-pair-count','{s with complementaryPairCount := .count '+pc(6)+'}',lambda:dataclasses.replace(base,complementary_pair_count=PositiveCount(6)))]
# head! requires an Inhabited proof-bearing label; use the actual first occurrence as a literal.
for name,expr,fn in mods:
 expr=expr.replace('s.electronOccurrenceIds.head!',held('electron-occurrence','electron-1'))
 add(name,'orgResult (do let s ← ElectronCountSpinWitnesses.co; validOrganization ('+expr+'))',fn)
prefix='''import SFT.Chemistry.ElectronCountSpinWitnesses
open SFT.Chemistry SFT.Chemistry.ElectronCountSpin SFT.Physics.CapabilityValues
abbrev J := SFT.Host.Canonical.Value
def labelValue (x : HeldLabel) : J := .object [("family",.text x.family),("label",.text x.label)]
def countValue (x : PositiveCount) : J := .object [("value",.integer (.ofNat x.value))]
def emptyCountValue : CountOrEmpty → J
 | .count n=>countValue n
 | .emptyOne identity=>.object [("identity",.text identity)]
def cellValue (x : SpinCell) : J := .object [("cell_id",labelValue x.cellId),("occupants",.array (x.occupants.map labelValue))]
def orgValue (x : Organization) : J := .object [("molecular_id",labelValue x.molecularId),("electron_count",countValue x.electronCount),("electron_occurrence_ids",.array (x.electronOccurrenceIds.map labelValue)),("cells",.array (x.cells.map cellValue)),("complementary_pair_count",emptyCountValue x.complementaryPairCount),("unmatched_fibre_count",emptyCountValue x.unmatchedFibreCount),("spin_width",countValue x.spinWidth)]
def result {α : Type} (encode : α → J) : Except String α → J
 | .ok a=>encode a
 | .error e=>.object [("error",.text e)]
def orgResult := result orgValue
def countResult := result countValue
def labelResult := result labelValue
def cellResult := result cellValue
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
'''
test=w/'electronspin1071_cases.lean';test.write_text(prefix+'#eval IO.println (SFT.Host.Canonical.render (.array ((['+','.join(cases)+'] : List (String × J)).map fun (name,value)=>.array [.text name,value])))\n')
(w/'electronspin1071_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(root)+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean',LEAN_NUM_THREADS='1');lean=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
receipt=w/'lean_resource_52775.json'
while True:
 try:r=json.loads(receipt.read_text())
 except json.JSONDecodeError:time.sleep(1);continue
 if r['exit'] is not None:break
 time.sleep(2)
assert r['exit']==0,r
for module in ['ElectronCountSpinWitnesses']:
 p=root/'SFT/Chemistry'/module
 with (w/(module+'1071_build.log')).open('w') as log:subprocess.run(lean+['-o',str(p)+'.olean',str(p)+'.lean'],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
names=[];digests={}
for module in ['ElectronCountSpin','ElectronCountSpinDerivation','ElectronCountSpinWitnesses']:
 p=root/'SFT/Chemistry'/(module+'.lean');s=p.read_text();ns=re.search(r'^namespace (\S+)',s,re.M)[1];names.extend(ns+'.'+x for x in re.findall(r'^(?:def|theorem) (\w+)',s,re.M));digests[module]=hashlib.sha256(p.read_bytes()).hexdigest()
p=w/'electronspin1071_audit.lean';p.write_text('import SFT.Chemistry.ElectronCountSpinWitnesses\n'+''.join('#print axioms '+n+'\n'for n in names))
o=subprocess.run(lean+[str(p)],env=env,capture_output=True,text=True);(w/'electronspin1071_audit.log').write_text(o.stdout+o.stderr);assert o.returncode==0;assert o.stdout.count('does not depend on any axioms')==len(names)
(w/'electronspin1071_audit_report.json').write_text(json.dumps(dict(status='PASS',declarations=len(names),names=names,source_sha256=digests,axioms=[]),indent=2)+'\n')
o=subprocess.run(lean+[str(test)],env=env,capture_output=True,text=True);(w/'electronspin1071_operations.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout[-1800:]+o.stderr[-400:]
actual=json.loads(o.stdout);assert actual==expected,[a[0]for a,b in zip(actual,expected)if a!=b]
(w/'electronspin1071_operations_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),all_fields_match=True,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'),indent=2)+'\n');print('PASS',len(expected),'exact original-source operation cases and full axiom audit',flush=True)
