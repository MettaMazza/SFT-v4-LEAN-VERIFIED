from pathlib import Path
import sys,json
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1135/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import coordination_entity_validation_v1 as v
q=lambda x:json.dumps(x,ensure_ascii=False)
files=[(v.TARGET_PATH,v.TARGET_HASH),(v.PRIMARY_PATH,v.PRIMARY_HASH),*v.SOURCE_FILES]
p=r/'SFT/Chemistry/CoordinationExperiment.lean';s=p.read_text();s=s.replace('def sourceIds', 'def sourceFiles : List (String × String) := ['+','.join('('+q(a)+','+q(b)+')'for a,b in files)+']\ndef sourceIds');p.write_text(s)
p=r/'SFT/Chemistry/CoordinationValidation.lean';s=p.read_text().replace('(sourceHashes : List (String × String × String))','(sourceHashes : List (String × String))')
s=s.replace(' let rows ← CoordinationSource.sourceRows sourceHashes actualIdentityHash identityDocument targetDocument',''' let checkedSources ← sourceFiles.mapM fun (path,expected) => do
  let actual ← match sourceHashes.find? (fun p => Text.equal p.1 path) with
   | some p => pure p.2
   | none => throw (Text.append "missing source hash: " path)
  return (path,expected,actual)
 let rows ← CoordinationSource.sourceRows checkedSources actualIdentityHash identityDocument targetDocument''');p.write_text(s)
s=Path('work/StateTransitionValidationProgram1134.lean').read_text();s=s[:s.index('def event')].replace('import SFT.Chemistry.StateTransitionValidation','import SFT.Chemistry.CoordinationValidation')
t=Path('work/StateTransitionValidationProgram1134.lean').read_text();a=t.index('def protectedSnapshot');b=t.index('def main',a);s+=t[a:b]
s+='''def sourceHash (path : String) : IO String := do
 let bytes ← IO.FS.readBinFile ("work/pinned1135/"++path)
 return SFT.Host.Text.append "sha256:" (SFT.Host.SHA256.digest bytes)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def main : IO Unit := do
 let raw ← IO.FS.readFile "work/coordination1136_empirical_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let identities ← IO.ofExcept (field input "identities" >>= convert (raw.utf8ByteSize+1))
 let targets ← IO.ofExcept (field input "targets" >>= convert (raw.utf8ByteSize+1))
 let primary ← IO.ofExcept (field input "primary" >>= convert (raw.utf8ByteSize+1))
 let identityActual ← sourceHash "experiments/external_sources/chemistry/coordination_entity_target_identities_v1.json"
 let sources ← CoordinationExperiment.sourceFiles.mapM fun (path,_) => do return (path,← sourceHash path)
 let before ← IO.ofExcept (field input "before" >>= protectedSnapshot)
 let after ← IO.ofExcept (field input "after" >>= protectedSnapshot)
 let derivationSeal ← IO.ofExcept (text input "derivation_seal")
 let host ← IO.ofExcept (text input "host")
 let implementation ← IO.ofExcept (text input "implementation")
 let result ← IO.ofExcept (CoordinationValidation.validate identityActual identities targets primary sources derivationSeal host implementation before after)
 IO.println (SFT.Host.Canonical.render result.value)
'''
Path('work/CoordinationValidationProgram1136.lean').write_text(s)
s=Path('work/check_moleculartransition1134_empirical.py').read_text().replace('moleculartransition1134','coordination1136').replace('StateTransitionValidationProgram1134','CoordinationValidationProgram1136').replace("'original_target_checks':60,'adverse_controls':12","'original_target_checks':20,'adverse_controls':6").replace("['MolecularStateTransition','StateTransitionSurface','StateTransitionPrediction','StateTransitionInscription','StateTransitionTargets','StateTransitionComparison','StateTransitionControls','StateTransitionExperiment','StateTransitionValidation']","['CoordinationEntity','CoordinationPrediction','CoordinationSource','CoordinationAnalysis','CoordinationComparison','CoordinationExperiment','CoordinationValidation']").replace('12fields80messages','12fields26messages')
Path('work/check_coordination1136_empirical.py').write_text(s)
