import SFT.Chemistry.ExtendedExtraction
open SFT.Chemistry.ExtendedExtraction SFT.Host.Canonical
def result (v : Value) : Value := match resolveAll v [] [] with
 | .error e => .object [("error",.text e)]
 | .ok _ => .object [("ok",.boolean true)]
def main : IO Unit := do
 IO.println (render (result (.object [("schema",.text "sft-v3-chemistry-extended-source-derived-observations/1"),("observations",.array [])])))
 IO.println (render (result (.object [("schema",.text "sft-v3-chemistry-extended-source-derived-observations/1"),("observations",.array [.object []])])))
 IO.println (render (result (.object [("schema",.text "sft-v3-chemistry-extended-source-derived-observations/1"),("observations",.array [.object [("target_id",.text "valid")],.object []])])))
 IO.println (render (result (.object [("schema",.text "sft-v3-chemistry-extended-source-derived-observations/1"),("observations",.array [.object [("target_id",.array [])]])])))
 IO.println (render (result (.object [("schema",.text "sft-v3-chemistry-extended-source-derived-observations/1"),("observations",.array [.object [("target_id",.object [])]])])))
 IO.println (render (result (.object [("schema",.text "sft-v3-chemistry-extended-source-derived-observations/1"),("observations",.array [.object [("target_id",.boolean true)],.object [("target_id",.integer (1))]])])))
 IO.println (render (result (.object [("schema",.text "sft-v3-chemistry-extended-source-derived-observations/1"),("observations",.array [.object [("target_id",.boolean false)],.object [("target_id",.integer (0))]])])))
 IO.println (render (result (.object [("schema",.text "sft-v3-chemistry-extended-source-derived-observations/1"),("observations",.array [.object [("target_id",.text "same")],.object [("target_id",.text "same")]])])))
 IO.println (render (result (.object [("schema",.text "sft-v3-chemistry-extended-source-derived-observations/1"),("observations",.array [.null])])))
 IO.println (render (result (.object [("schema",.text "sft-v3-chemistry-extended-source-derived-observations/1"),("observations",.array [.object [("target_id",.null)]])])))
 IO.println (render (result (.object [("schema",.text "sft-v3-chemistry-extended-source-derived-observations/1"),("observations",.array [.object [("target_id",.text "1")],.object [("target_id",.integer (1))]])])))
