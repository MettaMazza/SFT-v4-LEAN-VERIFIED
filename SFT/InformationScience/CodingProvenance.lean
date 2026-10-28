import SFT.InformationScience.CodingActions
namespace SFT.InformationScience.CodingProvenance
open NoiseRelation CodingActions
open SFT.Mathematics.DiscreteObjects
abbrev SourceMap := List (String × Word)

def TotalSourceCode (sources : List String) (codes : List Word) (encoding : SourceMap) : Prop :=
  ∀ source, source ∈ sources → ∃ code, code ∈ codes ∧ (source,code) ∈ encoding ∧
    ∀ other, (source,other) ∈ encoding → other = code

theorem totalCodeword (sources : List String) (codes : List Word) (encoding : SourceMap)
    (total : TotalSourceCode sources codes encoding) (source : String) (member : source ∈ sources) :
    ∃ code, code ∈ codes ∧ (source,code) ∈ encoding ∧
      ∀ other, (source,other) ∈ encoding → other = code := total source member

theorem encodedImageRecovered (sources : List String) (codes : List Word) (encoding : SourceMap)
    (total : TotalSourceCode sources codes encoding) (family : Images)
    (separate : correction codes family = true) (source : String) (member : source ∈ sources) :
    ∃ code, (source,code) ∈ encoding ∧ ∀ received, received ∈ family code →
      decode codes family received = .uniqueSource code := by
  obtain ⟨code,hc,row,_⟩ := total source member
  exact ⟨code,row,fun received hr => correctableDecode codes family code received separate hc hr⟩

theorem addedActionsRecoverEncoded (sources : List String) (codes : List Word) (encoding : SourceMap)
    (total : TotalSourceCode sources codes encoding) (family added : Images)
    (old : correction codes family = true) (oldNew : CrossDisjoint codes family added)
    (newOld : CrossDisjoint codes added family) (newNew : correction codes added = true)
    (source : String) (member : source ∈ sources) :
    ∃ code, (source,code) ∈ encoding ∧ ∀ received, received ∈ extend family added code →
      decode codes (extend family added) received = .uniqueSource code :=
  encodedImageRecovered sources codes encoding total (extend family added)
    ((correctionSuccessor _ _ _).mpr ⟨old,oldNew,newOld,newNew⟩) source member

end SFT.InformationScience.CodingProvenance
