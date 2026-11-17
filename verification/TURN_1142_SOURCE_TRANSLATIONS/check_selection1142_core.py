from pathlib import Path
import sys,os,json,hashlib,subprocess,itertools
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1142/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
import sft.chemistry.selection_rule_law_v1 as m
from sft.claim_evidence.fold_language import EMPTY_ONE
J=lambda x:json.dumps(x,ensure_ascii=False)
lean=['import SFT.Chemistry.SelectionRule','open SFT.Chemistry.SelectionRule','def showSignature : Option StateSignature → String',' | none => "none"',' | some s => String.intercalate ":" [s.state.family,s.state.label,toString s.multiplicity.value,s.inversion.family,s.inversion.label,s.axis.family,s.axis.label]','def showRecord : Except String (SelectionRecord Unit) → String',' | .error e => "error:"++e',' | .ok r => String.intercalate "|" [showSignature r.initial,showSignature r.terminal,r.observationClass.family,r.observationClass.label,(match r.mediatorOrAbsence with | .emptyOne => "EMPTY_ONE" | .held h => h.family++":"++h.label | .other _ => "OTHER"),r.retainedRecord.family,r.retainedRecord.label]','def main : IO Unit := do']
expected=[]
axes=['Σ','Π','Δ','Φ','other'];inversions=['g','u','?'];sigs=[]
for idx,(mult,inv,axis)in enumerate(itertools.product([1,2],inversions,axes)):
 sigs.append(m.signature('S'+str(idx),mult,inv,axis));lean.append(f' let s{idx} ← IO.ofExcept (signature "S{idx}" {mult} {J(inv)} {J(axis)})')
for i,a in enumerate(sigs):
 for j,b in enumerate(sigs):
  expected.append(str(m.direct_observation_allowed(a,b)).lower())
lean += [' for a in ['+','.join('s'+str(i)for i in range(len(sigs)))+'] do','  for b in ['+','.join('s'+str(i)for i in range(len(sigs)))+'] do','   IO.println (toString (directObservationAllowed a b))']
def sig(s):return 'none' if s is None else ':'.join([s.state.family,s.state.label,str(s.multiplicity.value),s.inversion.family,s.inversion.label,s.axis.family,s.axis.label])
def display(r):return '|'.join([sig(r.initial),sig(r.terminal),r.observation_class.family,r.observation_class.label,'EMPTY_ONE'if r.mediator_or_absence is EMPTY_ONE else r.mediator_or_absence.family+':'+r.mediator_or_absence.label,r.retained_record.family,r.retained_record.label])
indices=[None,0,1,4,5,15]
for i,j,observed,coupled,mediator in itertools.product(indices,indices,[False,True],[False,True],[None,'bridge','']):
 a=None if i is None else sigs[i];b=None if j is None else sigs[j]
 try:out=display(m.classify_observation(a,b,'record',observed=observed,coupled=coupled,mediator=mediator))
 except Exception as e:out='error:'+str(e)
 expected.append(out);aa='none'if i is None else f'(some s{i})';bb='none'if j is None else f'(some s{j})';mm='none'if mediator is None else f'(some {J(mediator)})'
 pass
lean += [' for a in [none,some s0,some s1,some s4,some s5,some s15] do','  for b in [none,some s0,some s1,some s4,some s5,some s15] do','   for observed in [false,true] do','    for coupled in [false,true] do','     for mediator in [none,some "bridge",some ""] do','      IO.println (showRecord (classifyObservation a b "record" observed coupled mediator))']
p=w/'SelectionParity1142.lean';p.write_text('\n'.join(lean)+'\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
a=subprocess.run([sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)],env=env,capture_output=True,text=True);(w/'selection1142_parity.log').write_text(a.stdout+a.stderr);assert a.returncode==0,a.stdout[-1500:]
actual=a.stdout.splitlines();assert actual==expected,[(i,x,y)for i,(x,y)in enumerate(zip(actual,expected))if x!=y][:3]
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
(w/'selection1142_core_report.json').write_text(json.dumps({'status':'PASS','direct_cases':900,'classification_cases':432,'source_sha256':H(w/'pinned1142/sft/chemistry/selection_rule_law_v1.py'),'native_sha256':H(r/'SFT/Chemistry/SelectionRule.lean')},indent=2));print('PASS 900 direct cases and432 exact classification outcomes')
