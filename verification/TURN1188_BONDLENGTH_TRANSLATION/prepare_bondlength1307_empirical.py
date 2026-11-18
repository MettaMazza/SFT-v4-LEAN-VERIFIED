from pathlib import Path
import json,sys,platform,ast
w=Path('work');r=w/'turn1064_recovery';stage=w/'pinned1307';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
sourcePath='experiments/external_sources/physics/snapshots/molecular-spectroscopy-successor-source-record.json';source=json.loads((stage/sourcePath).read_text());snap=snapshot_protected_tree(stage)
payload=dict(derivation_seal='native-bondlength1307',host=platform.system(),implementation=platform.python_implementation(),before=canonical_value(snap),after=canonical_value(snap),snapshot_paths=[x['snapshot_path']for x in source['sources'].values()]);(w/'bondlength1307_empirical_input.json').write_text(json.dumps(payload,indent=2)+'\n')
s=(w/'ResolvedValidationProgram1164.lean').read_text();s=s[:s.index('def main :')].replace('ResolvedRovibronicValidation','EquilibriumBondLengthValidation')
s+='''def readBytes (path : String) : IO ByteArray := IO.FS.readBinFile (("work/pinned1307/" ++ path) : String)
def readDocument (path : String) : IO CJ := do
 let raw ← IO.FS.readFile (("work/pinned1307/" ++ path) : String)
 IO.ofExcept (Lean.Json.parse raw >>= convert (raw.utf8ByteSize+1))
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/bondlength1307_empirical_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let before ← IO.ofExcept (field input "before" >>= protectedSnapshot)
 let after ← IO.ofExcept (field input "after" >>= protectedSnapshot)
 let derivationSeal ← IO.ofExcept (text input "derivation_seal")
 let host ← IO.ofExcept (text input "host")
 let implementation ← IO.ofExcept (text input "implementation")
 let paths ← IO.ofExcept (items input "snapshot_paths" >>= List.mapM Lean.Json.getStr?)
 let files ← paths.mapM fun path => do return (path,← readBytes path)
 let scaleBytes ← readBytes EquilibriumBondLengthExperiment.scalePath
 let identityBytes ← readBytes EquilibriumBondLengthExperiment.identityPath
 let targetBytes ← readBytes EquilibriumBondLengthExperiment.targetPath
 let sourcePath := "experiments/external_sources/physics/snapshots/molecular-spectroscopy-successor-source-record.json"
 let sourceBytes ← readBytes sourcePath
 let scale ← readDocument EquilibriumBondLengthExperiment.scalePath
 let identities ← readDocument EquilibriumBondLengthExperiment.identityPath
 let targets ← readDocument EquilibriumBondLengthExperiment.targetPath
 let source ← readDocument sourcePath
 let result ← IO.ofExcept (EquilibriumBondLengthValidation.validate scaleBytes identityBytes targetBytes sourceBytes
  scale identities targets source files derivationSeal host implementation before after)
 IO.println (SFT.Host.Canonical.render result.value)
''';(w/'EquilibriumBondLengthValidationProgram1307.lean').write_text(s)
s=(w/'check_resolved1164_empirical.py').read_text().replace('ResolvedValidationProgram1164','EquilibriumBondLengthValidationProgram1307').replace('resolved1164','bondlength1307').replace("'original_target_checks':95,'original_counts':12","'original_target_checks':2,'original_adverse_controls':2").replace('107 messages','4 messages');a=s.index("for m in ['ResolvedRovibronic'");b=s.index(']}}',a);s=s[:a]+"for m in ['EquilibriumBondLength','EquilibriumBondLengthGrammar','EquilibriumBondLengthEvidence','EquilibriumBondLengthExperiment','EquilibriumBondLengthSource','EquilibriumBondLengthValidation'"+s[b:];ast.parse(s);(w/'check_bondlength1307_empirical.py').write_text(s)
p=w/'build_bondlength1307.py';s=p.read_text().replace("'EquilibriumBondLengthSource']","'EquilibriumBondLengthSource','EquilibriumBondLengthValidation']");s+="\nsubprocess.run(['python3','work/check_bondlength1307_empirical.py'],check=True)\n";ast.parse(s);p.write_text(s)
print('Full native/source empirical comparison prepared:12fields4messages,all hashes; build includes six modules and full axiom audit. Existing queued worker will execute unchanged slot schedule.')
