from pathlib import Path
import sys,json,subprocess,os,types,tempfile,dataclasses,copy
repo=Path('/Volumes/One Touch/ernos-labs-sft-platform');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';sys.dont_write_bytecode=True
for name in ['sft','sft.engine','sft.claim_evidence']:
 m=types.ModuleType(name);m.__path__=[];sys.modules[name]=m
for name in ['sft.engine.canonical','sft.engine.exact','sft.claim_evidence.fold_language','sft.claim_evidence.hostile']:
 path=name.replace('.','/')+'.py';m=types.ModuleType(name);sys.modules[name]=m;exec(compile(subprocess.check_output(['git','-C',str(repo),'show',pin+':'+path]),path,'exec'),m.__dict__)
from sft.claim_evidence.hostile import HostilePackageAuditor,ProtectedTreeSnapshot,snapshot_protected_tree
from sft.engine.canonical import canonical_value
q=lambda s:json.dumps(s,ensure_ascii=False)
def cv(v):
 if v is None:return '.null'
 if isinstance(v,bool):return '.boolean '+str(v).lower()
 if isinstance(v,str):return '.text '+q(v)
 if isinstance(v,int):return '.integer ('+str(v)+')'
 if isinstance(v,(list,tuple)):return '.array ['+','.join('('+cv(x)+')' for x in v)+']'
 return '.object ['+','.join('('+q(k)+',('+cv(x)+'))' for k,x in v.items())+']'
def fields(v):return '['+','.join('('+q(k)+',('+cv(x)+'))' for k,x in v.items())+']'
def snap(s):return '⟨'+q(s.root_identity)+',['+','.join('('+q(k)+','+q(h)+')' for k,h in s.file_hashes)+'],'+q(s.snapshot_hash)+'⟩'
base={'schema':'sft-v3-fold-program/1','program_id':'audit-case','instructions':[{'opcode':'input','destination':'held','arguments':['registered']},{'opcode':'emit','destination':'','arguments':['held']}]}
docs=[base]
for key in ['python','source','script','command','module','callable','extra']:
 d=copy.deepcopy(base);d[key]='forbidden';docs.append(d)
for key in base:
 d=copy.deepcopy(base);del d[key];docs.append(d)
for key,val in [('schema','other'),('program_id',False),('instructions',[]),('instructions',[{'opcode':'foreign','destination':'x','arguments':[]}])]:
 d=copy.deepcopy(base);d[key]=val;docs.append(d)
before=ProtectedTreeSnapshot('root',(('census/a','sha256:a'),('receipts/engine/model_admitted/r','sha256:r')),'snapshot')
afters=[before,dataclasses.replace(before,root_identity='changed'),dataclasses.replace(before,file_hashes=tuple(reversed(before.file_hashes))),dataclasses.replace(before,snapshot_hash='changed')]
program='''import SFT.Physics.HostilePackage
open SFT.Physics.HostilePackage SFT.Host.Canonical
set_option maxRecDepth 20000
def certValue (c : Certificate) : Value := .object [("auditor_id",.text c.auditorId),("package_hash",.text c.packageHash),
 ("program_hash",.text c.programHash),("executable_source_present",.boolean c.executableSourcePresent),
 ("additional_fields_present",.boolean c.additionalFieldsPresent),("protected_tree_unchanged",.boolean c.protectedTreeUnchanged),
 ("passed",.boolean c.passed),("certificate_hash",.text c.certificateHash)]
def auditValue (doc : List (String × Value)) (before after : Snapshot) : Value :=
 match auditProgram doc before after with
 | .error e => .object [("error",.text e)]
 | .ok (p,c) => .object [("program",SFT.Physics.CapabilityExecution.canonicalProgram p),("certificate",certValue c)]
def snapshotValue (s : Except String Snapshot) : Value := match s with
 | .error e => .object [("error",.text e)]
 | .ok x => .object [("root_identity",.text x.rootIdentity),("file_hashes",.array (x.fileHashes.map fun row => .array [.text row.1,.text row.2])),("snapshot_hash",.text x.snapshotHash)]
def main : IO Unit := do
'''
expected=[]
for d in docs:
 for after in afters:
  try:p,c=HostilePackageAuditor().audit_program_document(d,before,after);expected.append({'program':canonical_value(p),'certificate':canonical_value(c)})
  except Exception as e:expected.append({'error':str(e)})
  program+='  IO.println (render (auditValue '+fields(d)+' '+snap(before)+' '+snap(after)+'))\n'
sources=[None,False,3,{},[],'',' \t',"print('target')",'λ','\u2003']
for source in sources:
 try:HostilePackageAuditor.reject_executable_prediction_source(source);expected.append('ok')
 except Exception as e:expected.append(str(e))
 program+='  IO.println (render (match rejectExecutableSource ('+cv(source)+') with | .error e => .text e | .ok _ => .text "ok"))\n'
with tempfile.TemporaryDirectory(prefix='sft-hostile-') as tmp:
 root=Path(tmp)
 for stage in range(4):
  if stage==1:(root/'census').mkdir()
  if stage==2:(root/'receipts/engine/model_admitted').mkdir(parents=True)
  if stage==3:
   for rel,data in [('census/a/z',bytes([0,255,65])),('census/a-',b'held'),('census/β',b'\n'),('receipts/engine/model_admitted/r.json',b'{}')]:
    p=root/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(data)
  try:expected.append(canonical_value(snapshot_protected_tree(root)))
  except Exception as e:expected.append({'error':str(e)})
  args=[]
  for rel in ['census','receipts/engine/model_admitted']:
   directory=root/rel
   if not directory.is_dir():args.append('none');continue
   rows=[(p.relative_to(root).as_posix(),p.read_bytes()) for p in sorted(p for p in directory.rglob('*') if p.is_file())]
   args.append('(some ['+','.join('('+q(n)+',ByteArray.mk #['+','.join(str(b) for b in bs)+'])' for n,bs in rows)+'])')
  program+='  IO.println (render (snapshotValue (snapshotFromFiles '+q(root.name)+' '+args[0]+' '+args[1]+')))\n'
Path('verification/TURN_372_HostileOperationsProgram.lean').write_text(program)
env=dict(os.environ,LEAN_PATH='/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean:'+str(Path.cwd()))
out=subprocess.check_output(['/Users/dolltrading/.elan/bin/lean','--run','verification/TURN_372_HostileOperationsProgram.lean'],env=env,text=True);actual=[json.loads(x) for x in out.splitlines()];expected=json.loads(json.dumps(expected));assert actual==expected,[(i,a,b) for i,(a,b) in enumerate(zip(actual,expected)) if a!=b]
Path('verification/TURN_372_HOSTILE_OPERATIONS_OUTPUT.json').write_text(json.dumps(actual,indent=2)+'\n');r=dict(status='PASS',source_commit=pin,fresh_native_execution=True,audit_cases=len(docs)*len(afters),source_rejection_cases=len(sources),snapshot_cases=4,scope='Pinned isolated modules; exact parsed programs,all certificate fields/hashes,errors,rejection,snapshot file hashes/order and directory precedence. Source filesystem enumeration supplies native ordered file inputs.')
Path('verification/TURN_372_HOSTILE_OPERATIONS_REPORT.json').write_text(json.dumps(r,indent=2)+'\n');print(json.dumps(r))
