import SFT.Physics.TerminalLeptonValidationValidation
open SFT.Physics SFT.Host.Canonical
def main (args : List String) : IO Unit := do
 let root := args[0]!
 let derivationSeal := args[1]!
 let host := args[2]!
 let implementation := args[3]!
 let before : HostilePackage.Snapshot := ⟨"registered-protected-root",[],"unchanged"⟩
 let bytes ← IO.FS.readBinFile (System.FilePath.mk (root ++ "/" ++ TerminalLeptonValidationExperiment.sourcePath))
 let body ← IO.FS.readFile (root ++ "/" ++ TerminalLeptonValidationExperiment.sourcePath)
 let rows := LeptonSource.lines (SFT.Host.Text.chars body)
 let result ← IO.ofExcept (TerminalLeptonValidationValidation.validateExternalWithin rows 27 15 bytes derivationSeal host implementation before before)
 match result with
 | none => throw (IO.userError "Original terminal comparison did not terminate within the verified exact refinement bounds")
 | some result => IO.println (render result.value)
