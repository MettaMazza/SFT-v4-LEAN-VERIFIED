import SFT.Chemistry.MixtureSupport
open SFT.Chemistry.MixtureSupport
def main : IO Unit := do
 IO.println (toString (admitted ⟨⟨[],.text "portion",[]⟩,.text "recorded phases"⟩))
 IO.println (toString (admitted ⟨⟨[⟨"A",SFT.Foundation.ExactOperations.normalizePart 1 1 (by decide) (by decide),(by decide)⟩],.text "portion",[]⟩,.text "recorded phases"⟩))
 IO.println (toString (admitted ⟨⟨[⟨"A",SFT.Foundation.ExactOperations.normalizePart 1 2 (by decide) (by decide),(by decide)⟩,⟨"B",SFT.Foundation.ExactOperations.normalizePart 1 2 (by decide) (by decide),(by decide)⟩],.text "portion",[]⟩,.text "recorded phases"⟩))
 IO.println (toString (admitted ⟨⟨[⟨"A",SFT.Foundation.ExactOperations.normalizePart 1 3 (by decide) (by decide),(by decide)⟩,⟨"B",SFT.Foundation.ExactOperations.normalizePart 2 3 (by decide) (by decide),(by decide)⟩],.text "portion",[]⟩,.text "recorded phases"⟩))
 IO.println (toString (admitted ⟨⟨[⟨"A",SFT.Foundation.ExactOperations.normalizePart 1 3 (by decide) (by decide),(by decide)⟩,⟨"B",SFT.Foundation.ExactOperations.normalizePart 1 3 (by decide) (by decide),(by decide)⟩],.text "portion",[]⟩,.text "recorded phases"⟩))
 IO.println (toString (admitted ⟨⟨[⟨"A",SFT.Foundation.ExactOperations.normalizePart 1 2 (by decide) (by decide),(by decide)⟩,⟨"A",SFT.Foundation.ExactOperations.normalizePart 1 2 (by decide) (by decide),(by decide)⟩],.text "portion",[]⟩,.text "recorded phases"⟩))
 IO.println (toString (admitted ⟨⟨[⟨"A",SFT.Foundation.ExactOperations.normalizePart 1 4 (by decide) (by decide),(by decide)⟩,⟨"B",SFT.Foundation.ExactOperations.normalizePart 1 4 (by decide) (by decide),(by decide)⟩,⟨"C",SFT.Foundation.ExactOperations.normalizePart 1 2 (by decide) (by decide),(by decide)⟩],.text "portion",[]⟩,.text "recorded phases"⟩))
