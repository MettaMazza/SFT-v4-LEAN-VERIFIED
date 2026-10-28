import SFT.InformationScience.CompressionSupport
namespace SFT.InformationScience.CompressionCanonical
open CompressionSupport QuantitySupport CompressionDescription

theorem inheritedFixedSupport (labels positions : List String) (full : List CompressionDescription.Word)
    (h : completeWordSupport labels positions = .ok full) : fixedSupport labels positions = .ok full := by
  have p := (supportAdmission _ _).mp ⟨full,h⟩
  exact (fixedAdmission _ _ _).mpr ⟨p.1,p.2.2.1,supportResult _ _ _ h⟩

theorem inheritedNoInjectiveShortCode (labels positions : List String) (full : List CompressionDescription.Word)
    (h : completeWordSupport labels positions = .ok full)
    (code : CompressionDescription.Word → CompressionDescription.Word)
    (injective : ∀ a, a ∈ full → ∀ b, b ∈ full → code a = code b → a = b)
    (shortCodes : ∀ word, word ∈ full → code word ∈ shorterNonemptySupport labels positions) : False := by
  exact noInjectiveShortCode _ _ _ (inheritedFixedSupport _ _ _ h)
    ((supportAdmission _ _).mp ⟨full,h⟩).2.1 code injective shortCodes

end SFT.InformationScience.CompressionCanonical
