from pathlib import Path
w=Path('work');r=w/'turn1064_recovery';s=(w/'MolecularIonizationValidationProgram1320.lean').read_text();s=s[:s.index('def main : IO Unit')].replace('import SFT.Chemistry.MolecularIonizationValidation','import SFT.Consciousness.NonordinaryExternalValidation').replace('open SFT.Chemistry SFT.Physics','open SFT.Consciousness SFT.Physics').replace('work/pinned1320/','work/pinned1394/')
s+='''def main : IO Unit := do
 let raw ← IO.FS.readFile "work/nonordinary1395_empirical_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let before ← IO.ofExcept (field input "before" >>= protectedSnapshot)
 let after ← IO.ofExcept (field input "after" >>= protectedSnapshot)
 let derivationSeal ← IO.ofExcept (text input "derivation_seal")
 let host ← IO.ofExcept (text input "host")
 let implementation ← IO.ofExcept (text input "implementation")
 let files ← (← IO.ofExcept (items input "files")).mapM fun row => do
  let path ← IO.ofExcept row.getStr?
  let bytes ← readBytes path
  let document ← if path.endsWith ".json" then readDocument path else pure CJ.null
  return (⟨path,bytes,document⟩ : NonordinaryExternalSource.File)
 let result ← IO.ofExcept (NonordinaryExternalValidation.validate files derivationSeal host implementation before after)
 IO.println (SFT.Host.Canonical.render result)
''';(r/'NonordinaryExternalProgram1395.lean').write_text(s)
s=(w/'prepare_directionalsynaesthesia1395_programme.py').read_text().replace('DirectionalSynaesthesia','NonordinaryExternal').replace('directionalsynaesthesia','nonordinaryexternal').replace("visit('SFT.Consciousness.NonordinaryExternalEvidence')","visit('SFT.Consciousness.NonordinaryExternalValidation')")
s=s.replace("shared_modules={row['module']:row for row in shared['modules']}","shared_modules={row['module']:row for row in shared['modules']}\nfor receipt_path in [w/'polarizability1319_native_build1391.json']:\n extra=json.loads(receipt_path.read_text());assert extra['status']=='PASS'\n for row in extra['modules']:\n  if row['module']not in shared_modules:shared_modules[row['module']]=row")
(w/'prepare_nonordinaryexternal1395_programme.py').write_text(s)
