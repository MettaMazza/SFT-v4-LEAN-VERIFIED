import SFT.Chemistry.BondClosure
import SFT.Host.Canonical
open SFT.Chemistry.BondClosure SFT.Host.Canonical
def result (raw : Raw) : Value := match makeSupport raw with
 | .error e => .object [("error",.text e)]
 | .ok support => .object [("left",.text support.raw.left),("right",.text support.raw.right),("count",.integer (Int.ofNat (joiningMultiplicity support))),("stable",.boolean support.raw.stable)]
def main : IO Unit := do
 IO.println (render (result ⟨"A","B",[⟨"joining","one",(by decide),(by decide)⟩],true⟩))
 IO.println (render (result ⟨"A","B",[],true⟩))
 IO.println (render (result ⟨"A","B",[⟨"joining","one",(by decide),(by decide)⟩],false⟩))
 IO.println (render (result ⟨"A","A",[⟨"joining","one",(by decide),(by decide)⟩],true⟩))
 IO.println (render (result ⟨"","B",[⟨"joining","one",(by decide),(by decide)⟩],true⟩))
 IO.println (render (result ⟨"A","\u2003",[⟨"joining","one",(by decide),(by decide)⟩],true⟩))
 IO.println (render (result ⟨" A ","A",[⟨"joining","one",(by decide),(by decide)⟩],true⟩))
 IO.println (render (result ⟨"group-A","group-B",[⟨"joining","one",(by decide),(by decide)⟩,⟨"joining","two",(by decide),(by decide)⟩],true⟩))
 IO.println (render (result ⟨"A","B",[⟨"joining","one",(by decide),(by decide)⟩,⟨"joining","one",(by decide),(by decide)⟩],true⟩))
