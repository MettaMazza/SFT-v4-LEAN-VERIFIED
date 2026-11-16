from pathlib import Path
import sys,json,dataclasses,subprocess,os,re,hashlib
w=Path('work');root=(w/'turn1064_recovery').resolve();sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.chemistry import orbital_support_law_v1 as src
from sft.engine.exact import PositiveCount,HeldLabel
from sft.claim_evidence.fold_language import EMPTY_ONE,EmptyOne
from sft.engine.canonical import canonical_value
q=lambda s:json.dumps(s,ensure_ascii=False)
pc=lambda n:'⟨'+str(n)+',by decide⟩'
held=lambda f,s:'⟨'+q(f)+','+q(s)+',by rfl,by rfl⟩'
def label(x):return held(x.family,x.label)
def rank(x):return '.emptyOne '+q(x.identity) if isinstance(x,EmptyOne)else '.count '+pc(x.value)
def observation(x):return '.emptyOne '+q(x.identity)if isinstance(x,EmptyOne)else '.held '+label(x)
def cell(x):return '⟨'+','.join([label(x.molecular_carrier),pc(x.radial_recurrence.value),rank(x.axis_recurrence),label(x.joining_phase),observation(x.exchange_observation),observation(x.reflection_observation)])+'⟩'
def occupied(x):return '⟨'+cell(x.cell)+',['+','.join(label(v)for v in x.electron_occurrences)+'],['+','.join(label(v)for v in x.spin_fibres)+']⟩'
expected=[];expressions=[]
def add(name,expr,fn):
 try:result=canonical_value(fn())
 except (ValueError,AttributeError)as e:result={'error':str(e)}
 expected.append([name,result]);expressions.append('('+q(name)+','+expr+')')
for symbol in ['Σ','Π','Δ','Φ','σ','π','δ','φ','s','','Ω']:
 for n in [1,2,3]:
  add('assignment-'+symbol+'-'+str(n),'result occupiedValue (occupiedSupportFromSourceAssignment "molecule" '+pc(2)+' '+q(symbol)+' '+pc(n)+')',lambda symbol=symbol,n=n:src.occupied_support_from_source_assignment('molecule',PositiveCount(2),symbol,PositiveCount(n)))
for n in range(1,21):
 add('ordinal-'+str(n),'result rankValue (axisRankFromPositiveOrdinal '+pc(n)+')',lambda n=n:src.axis_rank_from_positive_ordinal(PositiveCount(n)))
for n in [EMPTY_ONE,EmptyOne('other'),*[PositiveCount(i)for i in range(1,13)]]:
 add('rank-'+str(n),'result labelValue (axisRankLabel ('+rank(n)+'))',lambda n=n:src.axis_rank_label(n))
for molecule in ['molecule','',' ','H2+']:
 add('phase-'+repr(molecule),'result (fun xs => .array (xs.map cellValue)) (joinedPhasePair '+q(molecule)+' '+pc(1)+' ElectronCountSpin.structuralEmpty)',lambda molecule=molecule:src.joined_phase_pair(molecule,PositiveCount(1),EMPTY_ONE))
base=src.joined_phase_pair('molecule',PositiveCount(1),EMPTY_ONE)[0]
for field,value in [('molecular_carrier',HeldLabel('bad','molecule')),('joining_phase',HeldLabel('bad','fibre-a')),('joining_phase',HeldLabel('joining-phase','third')),('exchange_observation',HeldLabel('bad','g')),('reflection_observation',HeldLabel('bad','even')),('exchange_observation',HeldLabel('nuclear-exchange','g')),('reflection_observation',HeldLabel('axis-reflection','even'))]:
 args=dataclasses.asdict(base)
 # Assemble the original fields without calling the guarded constructor first.
 values={f.name:getattr(base,f.name)for f in dataclasses.fields(base)};values[field]=value
 raw=object.__new__(src.MolecularSupportCell)
 for key,v in values.items():object.__setattr__(raw,key,v)
 add('cell-'+field+'-'+value.family,'result cellValue (validCell '+cell(raw)+')',lambda values=values:src.MolecularSupportCell(**values))
for count in range(4):
 for labels in [[],['fibre-a'],['fibre-a','fibre-b'],['fibre-b','fibre-a'],['fibre-a','fibre-a'],['third']]:
  electrons=tuple(HeldLabel('electron-occurrence','e'+str(i))for i in range(count));spins=tuple(HeldLabel('electron-spin',x)for x in labels)
  expr='⟨'+cell(base)+',['+','.join(label(v)for v in electrons)+'],['+','.join(label(v)for v in spins)+']⟩'
  add('occupied-'+str(count)+'-'+','.join(labels),'result occupiedValue (validOccupied '+expr+')',lambda electrons=electrons,spins=spins:src.OccupiedMolecularSupport(base,electrons,spins))
single=src.occupied_support_from_source_assignment('molecule',PositiveCount(1),'σ',PositiveCount(1))
other=src.OccupiedMolecularSupport(src.joined_phase_pair('molecule',PositiveCount(1),EMPTY_ONE)[1],(HeldLabel('electron-occurrence','e2'),),(HeldLabel('electron-spin','fibre-b'),))
for cells in [(),(single,),(single,other),(single,single)]:
 for n in [1,2,3]:
  expr='⟨'+held('molecular-carrier','molecule')+','+pc(n)+',['+','.join(occupied(x)for x in cells)+']⟩'
  add('complete-'+str(len(cells))+'-'+str(n)+'-'+str(len(expected)),'result completeValue (validComplete '+expr+')',lambda cells=cells,n=n:src.CompleteMolecularSupport(HeldLabel('molecular-carrier','molecule'),PositiveCount(n),cells))
prefix='''import SFT.Chemistry.OrbitalSupportWitnesses
open SFT.Chemistry SFT.Chemistry.OrbitalSupport SFT.Physics.CapabilityValues
abbrev J := SFT.Host.Canonical.Value
def labelValue (x : HeldLabel) : J := .object [("family",.text x.family),("label",.text x.label)]
def countValue (x : PositiveCount) : J := .object [("value",.integer (.ofNat x.value))]
def rankValue : AxisRank → J
 | .count n => countValue n
 | .emptyOne s => .object [("identity",.text s)]
def observationValue : Observation → J
 | .held h => labelValue h
 | .emptyOne s => .object [("identity",.text s)]
def cellValue (x : MolecularSupportCell) : J := .object [("molecular_carrier",labelValue x.molecularCarrier),("radial_recurrence",countValue x.radialRecurrence),("axis_recurrence",rankValue x.axisRecurrence),("joining_phase",labelValue x.joiningPhase),("exchange_observation",observationValue x.exchangeObservation),("reflection_observation",observationValue x.reflectionObservation)]
def occupiedValue (x : OccupiedMolecularSupport) : J := .object [("cell",cellValue x.cell),("electron_occurrences",.array (x.electronOccurrences.map labelValue)),("spin_fibres",.array (x.spinFibres.map labelValue))]
def completeValue (x : CompleteMolecularSupport) : J := .object [("molecular_carrier",labelValue x.molecularCarrier),("exact_electron_count",countValue x.exactElectronCount),("occupied_cells",.array (x.occupiedCells.map occupiedValue))]
def result {A : Type} (encode : A → J) : Except String A → J
 | .ok x => encode x
 | .error e => .object [("error",.text e)]
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
'''
test=w/'orbital1075_cases.lean';test.write_text(prefix+'#eval IO.println (SFT.Host.Canonical.render (.array ((['+','.join(expressions)+'] : List (String × J)).map fun (name,value) => .array [.text name,value])))\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(root)+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
r=subprocess.run(cmd+[str(test)],env=env,capture_output=True,text=True);(w/'orbital1075_operations.log').write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout[-1800:]
actual=json.loads(r.stdout);assert actual==expected,[a[0]for a,b in zip(actual,expected)if a!=b]
names=[];digests={}
for module in ['OrbitalSupport','OrbitalSupportWitnesses']:
 p=root/'SFT/Chemistry'/(module+'.lean');s=p.read_text();ns=re.search(r'^namespace (\S+)',s,re.M)[1];names.extend(ns+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',s,re.M));digests[module]=hashlib.sha256(p.read_bytes()).hexdigest()
audit=w/'orbital1075_audit.lean';audit.write_text('import SFT.Chemistry.OrbitalSupportWitnesses\n'+''.join('#print axioms '+n+'\n'for n in names))
a=subprocess.run(cmd+[str(audit)],env=env,capture_output=True,text=True);(w/'orbital1075_audit.log').write_text(a.stdout+a.stderr);assert a.returncode==0 and a.stdout.count('does not depend on any axioms')==len(names),a.stdout
(w/'orbital1075_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),original_witnesses=5,declarations=names,axioms=[],source_sha256=digests),indent=2)+'\n')
print('PASS',len(expected),'exact source operation/guard cases; five original witnesses;',len(names),'zero-axiom declarations')
