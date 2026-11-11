import SFT.Chemistry.ExactComposition
open SFT.Chemistry.ExactComposition SFT.Host.Canonical
def run (xs : List (String × SFT.Foundation.ExactPartCarrier.Part)) : Value :=
 let result := xs.mapM (fun x => makeComponent x.1 x.2) >>= exactComposition
 match result with
 | .error e => .object [("error",.text e)]
 | .ok rows => .object [("ok",.array (rows.map fun c => .array [.text c.identity,.integer (Int.ofNat c.part.numerator),.integer (Int.ofNat c.part.denominator)]))]
def main : IO Unit := do
 IO.println (render (run []))
 IO.println (render (run [("A",(⟨1,1,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part))]))
 IO.println (render (run [("A",(⟨1,3,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part)),("B",(⟨2,3,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part))]))
 IO.println (render (run [("A",(⟨1,2,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part)),("B",(⟨1,2,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part))]))
 IO.println (render (run [("A",(⟨1,2,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part)),("A",(⟨1,2,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part))]))
 IO.println (render (run [("A",(⟨1,3,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part)),("B",(⟨1,3,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part))]))
 IO.println (render (run [("A",(⟨1,1,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part)),("B",(⟨1,1,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part))]))
 IO.println (render (run [("",(⟨1,1,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part))]))
 IO.println (render (run [(" \t\n",(⟨1,1,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part))]))
 IO.println (render (run [(" ",(⟨1,1,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part))]))
 IO.println (render (run [(" A ",(⟨1,2,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part)),("A",(⟨1,2,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part))]))
 IO.println (render (run [("a",(⟨1,2,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part)),("A",(⟨1,2,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part))]))
 IO.println (render (run [("A",(⟨1,1000000007,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part)),("B",(⟨1000000006,1000000007,by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part))]))
