import SFT.Chemistry.SolutionSupport
open SFT.Chemistry.SolutionSupport
def half : SFT.Foundation.ExactPartCarrier.Part := SFT.Foundation.ExactOperations.normalizePart 1 2 (by decide) (by decide)
def main : IO Unit := do
 IO.println (toString (admitted ⟨[⟨⟨"A",half,(by decide)⟩,"p",.solvent⟩,⟨⟨"B",half,(by decide)⟩,"p",.solute⟩],"p","liquid",.text "context",.text "portion",[]⟩))
 IO.println (toString (admitted ⟨[⟨⟨"A",half,(by decide)⟩,"p",.solvent⟩,⟨⟨"B",half,(by decide)⟩,"p",.solute⟩],"p","solid",.text "context",.text "portion",[]⟩))
 IO.println (toString (admitted ⟨[⟨⟨"A",half,(by decide)⟩,"p",.solvent⟩,⟨⟨"B",half,(by decide)⟩,"p",.solute⟩],"p","gas",.text "context",.text "portion",[]⟩))
 IO.println (toString (admitted ⟨[⟨⟨"A",half,(by decide)⟩,"p",.solvent⟩,⟨⟨"B",half,(by decide)⟩,"p",.solute⟩],"p","unclassified",.text "context",.text "portion",[]⟩))
 IO.println (toString (admitted ⟨[⟨⟨"A",half,(by decide)⟩,"p",.solvent⟩,⟨⟨"B",half,(by decide)⟩,"q",.solute⟩],"p","liquid",.text "context",.text "portion",[]⟩))
 IO.println (toString (admitted ⟨[⟨⟨"A",half,(by decide)⟩,"p",.solvent⟩,⟨⟨"B",half,(by decide)⟩,"p",.solvent⟩],"p","liquid",.text "context",.text "portion",[]⟩))
 IO.println (toString (admitted ⟨[⟨⟨"A",half,(by decide)⟩,"p",.solute⟩,⟨⟨"B",half,(by decide)⟩,"p",.solute⟩],"p","liquid",.text "context",.text "portion",[]⟩))
