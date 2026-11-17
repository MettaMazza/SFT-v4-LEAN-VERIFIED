from pathlib import Path
import sys,os,json,subprocess,hashlib
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1143/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
import sft.chemistry.coordination_number_law_v1 as m
from dataclasses import replace
from sft.engine.exact import HeldLabel,PositiveCount
expected=[]
def fmt(r):return '|'.join([r.entity_identity.family+':'+r.entity_identity.label,r.central_occurrence.family+':'+r.central_occurrence.label,str(r.positive_direct_incidence_count.value),','.join(x.family+':'+x.label for x in r.ordered_incidence_traces)])
for n in range(25):
 try:expected.append(fmt(m.forced_coordination_number(m._entity(n))))
 except Exception as e:expected.append('error:'+str(e))
for n in range(1,25):
 e=m._entity(n);next=m.RetainedCoordinationAttachment(PositiveCount(n+1),e.central_occurrence,HeldLabel('coordination-ligand-occurrence','L-'+str(n+1)),HeldLabel('coordination-ligand-group','L'),HeldLabel('positive-coordination-incidence','edge-'+str(n+1)))
 for s in [next,replace(next,source_occurrence=PositiveCount(n+2)),replace(next,central_occurrence=HeldLabel('coordination-central-occurrence','other')),replace(next,ligand_occurrence=e.ordered_attachments[0].ligand_occurrence),replace(next,attachment_trace=e.ordered_attachments[0].attachment_trace)]:
  try:expected.append(str(m.append_incidence_increments_coordination_number(e,s)).lower())
  except Exception as x:expected.append('error:'+str(x))
code='''import SFT.Chemistry.CoordinationNumber
open SFT.Chemistry.CoordinationNumber SFT.Chemistry.CoordinationEntity SFT.Physics.CapabilityValues
def describe : Except String Record → String
 | .error e => "error:"++e
 | .ok r => String.intercalate "|" [r.entityIdentity.family++":"++r.entityIdentity.label,r.centralOccurrence.family++":"++r.centralOccurrence.label,toString r.positiveDirectIncidenceCount.value,String.intercalate "," (r.orderedIncidenceTraces.map fun x => x.family++":"++x.label)]
def showBool : Except String Bool → String
 | .error e => "error:"++e
 | .ok b => toString b
def main : IO Unit := do
 for n in List.range 25 do
  IO.println (describe (do forcedNumber (← generatedEntity n)))
 for i in List.range 24 do
  let n := i+1
  let e ← IO.ofExcept (generatedEntity n)
  let next ← IO.ofExcept (SFT.Chemistry.CoordinationNumber.generatedAttachment (n+1))
  let skip := {next with sourceOccurrence := ⟨n+2,by omega⟩}
  let other ← IO.ofExcept (heldLabel "coordination-central-occurrence" "other")
  let old ← IO.ofExcept (SFT.Chemistry.CoordinationNumber.generatedAttachment 1)
  for s in [next,skip,{next with centralOccurrence:=other},{next with ligandOccurrence:=old.ligandOccurrence},{next with attachmentTrace:=old.attachmentTrace}] do
   IO.println (showBool (appendIncrements e s))
'''
p=w/'CoordinationNumberParity1143.lean';p.write_text(code)
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
a=subprocess.run([sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)],env=env,capture_output=True,text=True);(w/'coordinationnumber1143_parity.log').write_text(a.stdout+a.stderr);assert a.returncode==0,a.stdout[-1000:];assert a.stdout.splitlines()==expected,[(i,x,y)for i,(x,y)in enumerate(zip(a.stdout.splitlines(),expected))if x!=y][:3]
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();(w/'coordinationnumber1143_core_report.json').write_text(json.dumps({'status':'PASS','count_records':25,'successor_cases':120,'source_sha256':H(w/'pinned1143/sft/chemistry/coordination_number_law_v1.py'),'native_sha256':H(r/'SFT/Chemistry/CoordinationNumber.lean')},indent=2));print('PASS25count records and120successor/control outcomes')
