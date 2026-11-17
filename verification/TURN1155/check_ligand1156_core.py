from pathlib import Path
import sys,os,subprocess,json,hashlib
w=Path('work');root=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1156/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import ligand_denticity_chelation_law_v1 as m
q=lambda x:json.dumps(x,ensure_ascii=False)
expected=[]
def label(h):return h.family+':'+h.label
def record(r):return '|'.join([label(r.ligand_carrier_occurrence),label(r.central_occurrence),str(r.positive_denticity.value),';'.join(map(label,r.ordered_donor_site_occurrences)),';'.join(map(label,r.ordered_attachment_traces)),';'.join(map(label,r.ordered_internal_connection_traces)),label(r.chelation_state),';'.join(map(label,r.closed_topology_trace))])
for n in range(1,13):expected.append(record(m.forced_ligand_denticity_and_chelation(m._entity(n),m._topology(n))))
lean='''import SFT.Chemistry.LigandDenticity
open SFT.Chemistry.LigandDenticity
open SFT.Physics.CapabilityValues
def label (h : HeldLabel) := h.family++":"++h.label
def labels (xs : List HeldLabel) := String.intercalate ";" (xs.map label)
def showRecord (r : Record) := String.intercalate "|" [label r.carrier,label r.central,toString r.denticity.value,labels r.donors,labels r.attachments,labels r.internalConnections,label r.state,labels r.closedTrace]
def main : IO Unit := do
 for n in List.range 12 do
  let e ← IO.ofExcept (entity (n+1))
  let t ← IO.ofExcept (topology (n+1))
  let r ← IO.ofExcept (forced e t)
  IO.println (showRecord r)
'''
p=w/'LigandParity1156.lean';p.write_text(lean);env=dict(os.environ,LEAN_PATH=str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean')+':'+str(root.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');a=subprocess.run([sys.executable,'work/run_lean_guarded.py',str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'),'-j1','-M8192','--run',str(p)],env=env,capture_output=True,text=True);(w/'ligand1156_parity.log').write_text(a.stdout+a.stderr);assert a.returncode==0,a.stdout[-1200:];assert a.stdout.splitlines()==expected
(w/'ligand1156_core_report.json').write_text(json.dumps(dict(status='PASS',full_record_cases=12,native_sha256=hashlib.sha256((root/'SFT/Chemistry/LigandDenticity.lean').read_bytes()).hexdigest()),indent=2)+'\n');print('PASS all8returnedfields for12sourcegenerated widths')
