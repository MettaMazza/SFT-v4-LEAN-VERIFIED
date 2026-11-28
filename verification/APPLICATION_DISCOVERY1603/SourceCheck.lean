import SFT.Applications.Discovery.Source
import SFT.Applications.Discovery.Display
open SFT.Applications.Discovery
open SFT.Applications.Discovery.Carry
open SFT.Applications.Discovery.Source
open SFT.Applications.Discovery.Display
open SFT.Host.Text

def main (args : List String) : IO Unit := do
 let corpus ← load (args.headD "work/engine_sources1603/SFT-v2")
 line (append "COUNT\t" (number (Int.ofNat corpus.entries.length)))
 for entry in corpus.entries do
  let source := entrySource corpus entry
  let result := carryVerdict source
  line (intercalate "\t" [entry.tag,entry.status,entry.wrapper,hex entry.description,hex source,(result.family.map familyName).getD "None",(result.pin.map number).getD "None",verdictName result.verdict,number (Int.ofNat result.distinctBeyond)])
