from pathlib import Path
import json,sys,subprocess,os,hashlib,re
from fractions import Fraction as F
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import decay_width_branching_lifetime_terminal_law_v1 as src
q=json.dumps
def enc(x):
 if isinstance(x,F):return [x.numerator,x.denominator]
 if isinstance(x,dict):return {k:enc(v) for k,v in x.items()}
 if isinstance(x,(list,tuple)):return list(map(enc,x))
 return x
s='''import SFT.Physics.DecayWidthBranchingLifetimeCertificate
import SFT.Host.Canonical
open SFT.Physics DecayWidthBranchingLifetimeCertificate SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def ratList (xs : List Rat) : Value := .array (xs.map frac)
def result (f : α → Value) : Except String α → Value | .ok x => f x | .error e => .object [("error",.text e)]
def certificate (c : Certificate) : Value := .object [("closed_channel",ratList c.closedChannel),("sample_partial_widths",ratList c.sampleWidths),("sample_total_width",frac c.total),("sample_branching_parts",ratList c.parts),("sample_partition",frac c.partition),("sample_lifetime",frac c.lifetime),("width_lifetime_vector",.array (c.widthLifetimeVector.map (fun (a,b) => .array [frac a,frac b]))),("successor_total_increments",ratList c.successorIncrements),("successor_partitions",ratList c.successorPartitions),("wider_state_lifetime_takes",ratList c.widerLifetimeTakes)]
#eval IO.println (render (.array [result certificate formalCertificate,
'''
axes=[('partial_width_carrier','partialWidthCarrier','PARTIAL_WIDTH_CARRIERS'),('channel_domain','channelDomain','CHANNEL_DOMAINS'),('total_width_law','totalWidthLaw','TOTAL_WIDTH_LAWS'),('branching_law','branchingLaw','BRANCHING_LAWS'),('partition_law','partitionLaw','PARTITION_LAWS'),('lifetime_law','lifetimeLaw','LIFETIME_LAWS'),('ordering_law','orderingLaw','ORDERING_LAWS'),('target_boundary','targetBoundary','TARGET_BOUNDARIES'),('extension','extension','EXTENSIONS')]
proof='import SFT.Physics.DecayWidthBranchingLifetimeCertificate\nnamespace SFT.Physics.DecayWidthBranchingLifetimeProofs\nopen DecayWidthBranchingLifetimeCertificate\nset_option maxRecDepth 100000\nset_option maxHeartbeats 100000000\n';expected=[enc(src.formal_certificate())];fields=[]
for py,lean,labels in axes:
 fn=getattr(src,py+'_is_forced')
 for i,v in enumerate((*getattr(src,labels),'bad')):
  try:expected.append(fn(v))
  except ValueError as e:expected.append({'error':str(e)})
  fields.append(f'result Value.boolean ({lean}IsForced {q(v)})')
  if v!='bad':proof+=f'theorem {lean}{i} : {lean}IsForced {q(v)} = .ok {str(fn(v)).lower()} := rfl\n'
proof+='end SFT.Physics.DecayWidthBranchingLifetimeProofs\n'
for r in [c,w/'constants-recovery']:(r/'SFT/Physics/DecayWidthBranchingLifetimeProofs.lean').write_text(proof)
p=w/'constants-recovery/DecayWidthCertificate971.lean';p.write_text(s+',\n'.join(fields)+']))\n');out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')},text=True);a=json.loads(out);assert a==expected,[(i,a[i],v) for i,v in enumerate(expected) if a[i]!=v];(w/'decaywidth971_certificate_report.json').write_text(json.dumps({'status':'PASS','certificate':a[0],'forcing_cases':len(expected)-1,'lean_sha256':hashlib.sha256((c/'SFT/Physics/DecayWidthBranchingLifetimeCertificate.lean').read_bytes()).hexdigest()},indent=2)+'\n');print('PASS complete10fieldcertificate and34forcing/invalidcases')
