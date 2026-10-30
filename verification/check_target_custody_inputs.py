from pathlib import Path
import sys,json,subprocess,os,hashlib,dataclasses
repo=Path('/Volumes/One Touch/ernos-labs-sft-platform');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
for name in ['sft/claim_evidence/custody.py','sft/engine/canonical.py','sft/engine/empirical.py']:
 assert (repo/name).read_bytes()==subprocess.check_output(['git','-C',str(repo),'show',pin+':'+name])
sys.dont_write_bytecode=True
import types
for name in ['sft','sft.engine','sft.claim_evidence']:
 module=types.ModuleType(name);module.__path__=[];sys.modules[name]=module
for name,path in [('sft.engine.canonical','sft/engine/canonical.py'),('sft.engine.empirical','sft/engine/empirical.py'),('sft.claim_evidence.custody','sft/claim_evidence/custody.py')]:
 module=types.ModuleType(name);sys.modules[name]=module
 exec(compile(subprocess.check_output(['git','-C',str(repo),'show',pin+':'+path]),path,'exec'),module.__dict__)
from sft.claim_evidence.custody import TargetVault,CrossPlatformCustodyExchange
from sft.engine.empirical import PredictionSeal
from sft.engine.canonical import sha256_identity
q=lambda s:json.dumps(s,ensure_ascii=False)
def value(v):
 if v is None:return '.null'
 if isinstance(v,bool):return '.boolean '+str(v).lower()
 if isinstance(v,str):return '.text '+q(v)
 if isinstance(v,int):return '.integer ('+str(v)+')'
 if isinstance(v,list):return '.array ['+','.join('('+value(x)+')' for x in v)+']'
 return '.object ['+','.join('('+q(k)+',('+value(x)+'))' for k,x in v.items())+']'
env=sha256_identity('registered-envelope');base=['exp','custodian',{'z':['held',2], 'a':{'exact':True,'empty':None}},'nonce',env]
cases=[base,['exp','custodian',{'target':'record'},'nonce',env],['Ω','custodian',{'β':-4,'a':'\n'},'nonce',env]]
for i,x in [(0,''),(0,' \t'),(1,''),(3,''),(4,'sha256:x')]:
 c=base.copy();c[i]=x;cases.append(c)
for targets in [{},{'':'bad'},{' \t':'bad'},{2:'bad'},{False:'bad'},{None:'bad'},{'ok':'held',3:'bad'}]:c=base.copy();c[2]=targets;cases.append(c)
expected=[]
for ex,cu,targets,no,en in cases:
 try:v=TargetVault(experiment_id=ex,custodian_id=cu,targets=targets,custody_nonce=no,expected_envelope_hash=en)
 except Exception as e:expected.append({'error':'CustodyHalt: '+str(e)});continue
 seal=PredictionSeal(ex,'prediction','trace',en,'seal');release=v.release(seal)
 def outcome(fn):
  try:fn();return 'ok'
  except Exception as e:return 'CustodyHalt: '+str(e)
 expected.append({'commitment':dataclasses.asdict(v.commitment),'release':dataclasses.asdict(release),'verify':outcome(lambda:CrossPlatformCustodyExchange.verify(v.commitment,release,seal)),
 'repeat':outcome(lambda:v.release(seal)),
 'tamper':outcome(lambda:CrossPlatformCustodyExchange.verify(v.commitment,dataclasses.replace(release,custodian_id='changed'),seal)),
 'tamper_all':[outcome(lambda c=c,r=r,p=p:CrossPlatformCustodyExchange.verify(c,r,p)) for c,r,p in [
 (v.commitment,dataclasses.replace(release,experiment_id='changed'),seal),
 (v.commitment,dataclasses.replace(release,prediction_seal_hash='changed'),seal),
 (v.commitment,release,dataclasses.replace(seal,envelope_hash='changed')),
 (v.commitment,dataclasses.replace(release,targets={}),seal),
 (v.commitment,dataclasses.replace(release,custody_nonce='changed'),seal),
 (v.commitment,dataclasses.replace(release,target_identity_hash='changed'),seal),
 (v.commitment,dataclasses.replace(release,release_hash='changed'),seal),
 (dataclasses.replace(v.commitment,target_ids=()),release,seal),
 (dataclasses.replace(v.commitment,target_identity_hash='changed'),release,seal),
 (v.commitment,dataclasses.replace(release,experiment_id='changed',custodian_id='changed',release_hash='changed'),seal)]]})
program='''import SFT.Physics.TargetCustodyInputs
open SFT.Physics.TargetCustody SFT.Physics.TargetCustodyInputs SFT.Host.Canonical
set_option maxRecDepth 20000
def resultText : Except String Unit → Value
 | .ok _ => .text "ok"
 | .error e => .text e
def runCase (ex cu : String) (values : List (Value × Value)) (nonce env : String) : Value :=
 match createVaultInput ex cu values nonce env with
 | .error e => .object [("error",.text e)]
 | .ok vault =>
   let prediction : PredictionSeal := ⟨ex,"prediction","trace",env,"seal"⟩
   match release vault prediction with
   | .error e => .object [("error",.text e)]
   | .ok (next,r) => .object [("commitment",commitmentValue vault.commitment),("release",releaseValue r),
       ("verify",resultText (verify vault.commitment r prediction)),
       ("repeat",match release next prediction with | .error e => .text e | .ok _ => .text "ok"),
       ("tamper",resultText (verify vault.commitment {r with custodian := "changed"} prediction)),
       ("tamper_all",.array [
         resultText (verify vault.commitment {r with experiment := "changed"} prediction),
         resultText (verify vault.commitment {r with predictionSealHash := "changed"} prediction),
         resultText (verify vault.commitment r {prediction with envelopeHash := "changed"}),
         resultText (verify vault.commitment {r with values := []} prediction),
         resultText (verify vault.commitment {r with nonce := "changed"} prediction),
         resultText (verify vault.commitment {r with targetHash := "changed"} prediction),
         resultText (verify vault.commitment {r with releaseHash := "changed"} prediction),
         resultText (verify {vault.commitment with targetIds := []} r prediction),
         resultText (verify {vault.commitment with targetHash := "changed"} r prediction),
         resultText (verify vault.commitment {r with experiment := "changed",custodian := "changed",releaseHash := "changed"} prediction)])]
def main : IO Unit := do
'''
for ex,cu,targets,no,en in cases:
 vals='['+','.join('(('+value(k)+'),('+value(v)+'))' for k,v in targets.items())+']'
 program+='  IO.println (render (runCase '+q(ex)+' '+q(cu)+' '+vals+' '+q(no)+' '+q(en)+'))\n'
Path('verification/TURN_371_CustodyInputsProgram.lean').write_text(program)
e=dict(os.environ,LEAN_PATH='/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean:'+str(Path.cwd()))
out=subprocess.check_output(['/Users/dolltrading/.elan/bin/lean','--run','verification/TURN_371_CustodyInputsProgram.lean'],env=e,text=True)
actual=[json.loads(x) for x in out.splitlines()];expected=json.loads(json.dumps(expected))
assert actual==expected,[(i,a,b) for i,(a,b) in enumerate(zip(actual,expected)) if a!=b]
Path('verification/TURN_371_CUSTODY_INPUT_OUTPUT.json').write_text(json.dumps(actual,indent=2)+'\n')
r=dict(status='PASS',cases=len(cases),source_commit=pin,fresh_native_execution=True,exchange_tamper_cases=30,scope='Canonical-value constructor with original string/non-string key admission; full valid commitment/release/hash/verification/repeat/custodian-tamper outputs. Three pinned modules executed in isolation; complete original claim program and target adapters pending.')
Path('verification/TURN_371_CUSTODY_INPUT_REPORT.json').write_text(json.dumps(r,indent=2)+'\n');print(json.dumps(r))
