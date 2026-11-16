from pathlib import Path
import json
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');exec((w/'particlemode1056_spec_loader.py').read_text());q=lambda x:json.dumps(x,ensure_ascii=False)
fields=['fibres','coordinates','cover','placement','mass','dual','reach','transition']
s='import SFT.Physics.ParticleModeCertificate\nnamespace SFT.Physics.ParticleModeWitnesses\nopen ParticleModeCertificate\nset_option maxRecDepth 100000\nset_option maxHeartbeats 100000000\nstructure Witness where\n name : String\n statement : String\n passed : Bool\ndef readFlag (field : Certificate → Bool) (result : Except String Certificate) : Bool :=\n match result with | .error _ => false | .ok c => field c\n'
for i,f in enumerate(fields):
 s+=f'def witness{i} : Bool := readFlag Certificate.{f} theoremCertificate\ntheorem witness{i}Passed : witness{i}=true := congrArg (readFlag Certificate.{f}) originalCompleteCertificate\n#print axioms witness{i}Passed\n'
s+='def witnesses : List Witness := ['+','.join('⟨'+q(v.name)+','+q(v.statement)+',witness'+str(i)+'⟩'for i,v in enumerate(SPEC.witnesses))+']\nend SFT.Physics.ParticleModeWitnesses\n';(r/'SFT/Physics/ParticleModeWitnesses.lean').write_text(s)
s=(w/'prepare_quantumsupport1054_evidence.py').read_text().replace('quantumsupport1054','particlemode1056').replace('QuantumSupport','ParticleMode').replace('range(7)','range(8)').replace('provenance := [.forwardForcing,.observationalDerivation]','provenance := [.forwardForcing]').replace('with depth :=','with fibre :=');(w/'prepare_particlemode1056_evidence.py').write_text(s)
