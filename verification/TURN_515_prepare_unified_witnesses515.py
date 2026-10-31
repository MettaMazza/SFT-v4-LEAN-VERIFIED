from pathlib import Path
import ast,json,re,subprocess
r=Path('work/constants-recovery');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';src=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':sft/physics/unified_constants_object_law_v1.py'],text=True);tree=ast.parse(src)
t=Path('work/spatial268.py').read_text();part=t[t.index('spec=next'):t.index('template=Path')].replace("=='SPATIAL_THREE_SPEC'","=='SPEC'").replace("cid='SFT-PHYS-SPACE-DIMENSION-THREE-001'","cid=lit('claim_id')");exec(part)
constants['DEPENDENCIES']=ast.literal_eval(next(n.value for n in tree.body if isinstance(n,ast.Assign) and getattr(n.targets[0],'id','')=='DEPENDENCIES'))
s='''import SFT.Physics.UnifiedConstants
namespace SFT.Physics.UnifiedConstantsWitnesses
open UnifiedConstantsCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 16000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def passed : Except String Bool → Bool
 | .error _ => false
 | .ok value => value
'''
for i,proj in enumerate(['.1','.2.1','.2.2.1','.2.2.2.1','.2.2.2.2']):
 s+='def check'+str(i)+' : Bool := passed ((theoremCertificate.map fiveChecks).map (fun v => v'+proj+'))\n'
rows=[(literal(w.args[0]),literal(w.args[1])) for w in kw['witnesses'].elts];assert len(rows)==5
s+='def witnesses : List Witness := ['+','.join('⟨'+q(n)+','+q(t)+',check'+str(i)+'⟩' for i,(n,t) in enumerate(rows))+']\n'
for i in range(5):s+='theorem check'+str(i)+'Passed : check'+str(i)+'=true := by\n unfold check'+str(i)+'\n rw [allOriginalChecks]\n rfl\n'
s+='theorem allWitnessesPass : witnesses.all Witness.passed=true := by\n change ('+' && '.join('check'+str(i) for i in range(5))+' && true)=true\n rw ['+','.join('check'+str(i)+'Passed' for i in range(5))+']\n rfl\nend SFT.Physics.UnifiedConstantsWitnesses\n';(r/'SFT/Physics/UnifiedConstantsWitnesses.lean').write_text(s)
s=t[t.index("s='''import SFT.Physics.SpatialThreeGrammar"):].replace('SpatialThree','UnifiedConstants').replace('survivor with carrier :=','survivor with root :=');exec(compile(s,'original-unified-controls','exec'))
p=r/'SFT/Physics/UnifiedConstantsEvidence.lean';s=p.read_text();component=(r/'SFT/Physics/CosmicComponentTransportEvidence.lean').read_text();start=component.index('def indexBucketCount');end=component.index('\ndef ',component.index('def decideCandidate',start)+4)
a=s.index('def decideCandidate');b=s.index('\ndef ',a+4)
s=s[:a]+component[start:end].replace('CosmicComponentTransport','UnifiedConstants')+s[b:]
s='import SFT.Host.SHA256Chunks\n'+s
start=component.index('def exactIdentity');end=component.index('\ndef ',start+4)
# Include the adjacent all-preimage equality theorem as well.
end=component.index('def candidateRecord',start)
s=s[:s.index('def registrationData')]+component[start:end]+s[s.index('def registrationData'):]
s=s.replace('identity (','exactIdentity (').replace('identity completenessRecord','exactIdentity completenessRecord')
# Restore the theorem right side, which intentionally compares the old identity.
s=s.replace('= exactIdentity value','= identity value')
p.write_text(s)
print('Original five witnesses, controls, closure and formal registration assembled')
