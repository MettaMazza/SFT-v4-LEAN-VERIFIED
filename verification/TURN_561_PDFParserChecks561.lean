import SFT.Chemistry.PeriodicPDF
import SFT.Host.Canonical
open SFT.Chemistry SFT.Host.Canonical
def main : IO Unit := do
 let b ← IO.FS.readBinFile "/Users/dolltrading/Documents/Codex/2026-10-26/p/work/periodic561_io/case0.bin"
 match PeriodicPDF.strings [b] with
 | .error _ => IO.println "error"
 | .ok ss => IO.println (render (.array (ss.map Value.text)))
 let b ← IO.FS.readBinFile "/Users/dolltrading/Documents/Codex/2026-10-26/p/work/periodic561_io/case1.bin"
 match PeriodicPDF.strings [b] with
 | .error _ => IO.println "error"
 | .ok ss => IO.println (render (.array (ss.map Value.text)))
 let b ← IO.FS.readBinFile "/Users/dolltrading/Documents/Codex/2026-10-26/p/work/periodic561_io/case2.bin"
 match PeriodicPDF.strings [b] with
 | .error _ => IO.println "error"
 | .ok ss => IO.println (render (.array (ss.map Value.text)))
 let b ← IO.FS.readBinFile "/Users/dolltrading/Documents/Codex/2026-10-26/p/work/periodic561_io/case3.bin"
 match PeriodicPDF.strings [b] with
 | .error _ => IO.println "error"
 | .ok ss => IO.println (render (.array (ss.map Value.text)))
 let b ← IO.FS.readBinFile "/Users/dolltrading/Documents/Codex/2026-10-26/p/work/periodic561_io/case4.bin"
 match PeriodicPDF.strings [b] with
 | .error _ => IO.println "error"
 | .ok ss => IO.println (render (.array (ss.map Value.text)))
 let b ← IO.FS.readBinFile "/Users/dolltrading/Documents/Codex/2026-10-26/p/work/periodic561_io/case5.bin"
 match PeriodicPDF.strings [b] with
 | .error _ => IO.println "error"
 | .ok ss => IO.println (render (.array (ss.map Value.text)))
 let b ← IO.FS.readBinFile "/Users/dolltrading/Documents/Codex/2026-10-26/p/work/periodic561_io/case6.bin"
 match PeriodicPDF.strings [b] with
 | .error _ => IO.println "error"
 | .ok ss => IO.println (render (.array (ss.map Value.text)))
 let b ← IO.FS.readBinFile "/Users/dolltrading/Documents/Codex/2026-10-26/p/work/periodic561_io/case7.bin"
 match PeriodicPDF.strings [b] with
 | .error _ => IO.println "error"
 | .ok ss => IO.println (render (.array (ss.map Value.text)))
 let b ← IO.FS.readBinFile "/Users/dolltrading/Documents/Codex/2026-10-26/p/work/periodic561_io/case8.bin"
 match PeriodicPDF.strings [b] with
 | .error _ => IO.println "error"
 | .ok ss => IO.println (render (.array (ss.map Value.text)))
 let b ← IO.FS.readBinFile "/Users/dolltrading/Documents/Codex/2026-10-26/p/work/periodic561_io/case9.bin"
 match PeriodicPDF.strings [b] with
 | .error _ => IO.println "error"
 | .ok ss => IO.println (render (.array (ss.map Value.text)))
 let b ← IO.FS.readBinFile "/Users/dolltrading/Documents/Codex/2026-10-26/p/work/periodic561_io/case10.bin"
 match PeriodicPDF.strings [b] with
 | .error _ => IO.println "error"
 | .ok ss => IO.println (render (.array (ss.map Value.text)))
 let b ← IO.FS.readBinFile "/Users/dolltrading/Documents/Codex/2026-10-26/p/work/periodic561_io/case11.bin"
 match PeriodicPDF.strings [b] with
 | .error _ => IO.println "error"
 | .ok ss => IO.println (render (.array (ss.map Value.text)))
 let b ← IO.FS.readBinFile "/Users/dolltrading/Documents/Codex/2026-10-26/p/work/periodic561_io/case12.bin"
 match PeriodicPDF.strings [b] with
 | .error _ => IO.println "error"
 | .ok ss => IO.println (render (.array (ss.map Value.text)))
