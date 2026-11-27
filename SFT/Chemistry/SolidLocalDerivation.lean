import SFT.Chemistry.SolidLocal
namespace SFT.Chemistry.SolidLocalDerivation
open SFT.Physics.CapabilityValues SolidLocal

theorem formulaEntryRetains (species : HeldLabel) (n : PositiveCount) (out : FormulaEntry)
 (h : formulaEntry species n=.ok out) : out.species=species ∧ out.primitiveCount=n := by
 unfold formulaEntry at h
 split at h
 · cases h
 · cases h; exact ⟨rfl,rfl⟩

theorem primitiveCountPositive (f : FormulaEntry) : 0<f.primitiveCount.value := f.primitiveCount.positive

theorem solidRetains (motif : HeldLabel) (occs : List HeldLabel) (bonds : List Bond)
 (formula : List FormulaEntry) (axes : List HeldLabel) (constituent : Constituent)
 (chemistryScope bulkHandoff : HeldLabel) (out : Solid)
 (h : solid motif occs bonds formula axes constituent chemistryScope bulkHandoff=.ok out) :
 out=⟨motif,occs,bonds,formula,axes,constituent,chemistryScope,bulkHandoff⟩ := by
 unfold solid at h
 cases hp : primitiveFormula occs with
 | error err => rw [hp] at h; repeat first | split at h | cases h | rfl
 | ok expected => rw [hp] at h; repeat first | split at h | cases h | rfl

theorem occurrenceRetains (species : String) (n : PositiveCount) (out : HeldLabel)
 (h : occurrence species n=.ok out) :
 out.family="species-occurrence" ∧ out.label=SFT.Host.Text.intercalate "#" [species,toString n.value] := by
 unfold occurrence heldLabel at h
 repeat first | split at h | cases h | exact ⟨rfl,rfl⟩

theorem appendDerivation (s out : Solid) (species : String) (anchor : HeldLabel)
 (h : appendOccurrence s species anchor=.ok out) :
 ∃ added, occurrence species ⟨speciesCount s.occurrences species+1,Nat.zero_lt_succ _⟩=.ok added ∧
 out.occurrences=s.occurrences++[added] ∧ out.localBonds=s.localBonds++[(anchor,added)] ∧
 primitiveFormula out.occurrences=.ok out.formula ∧
 out.motif=s.motif ∧ out.repeatAxes=s.repeatAxes ∧ out.constituent=s.constituent ∧
 out.chemistryScope=s.chemistryScope ∧ out.bulkHandoff=s.bulkHandoff := by
 unfold appendOccurrence at h
 dsimp only at h
 cases ha : occurrence species ⟨speciesCount s.occurrences species+1,Nat.zero_lt_succ _⟩ with
 | error err => rw [ha] at h; cases h
 | ok added =>
  rw [ha] at h
  change (do
   let formula ← primitiveFormula (s.occurrences++[added])
   solid s.motif (s.occurrences++[added]) (s.localBonds++[(anchor,added)]) formula s.repeatAxes s.constituent s.chemistryScope s.bulkHandoff)=.ok out at h
  cases hf : primitiveFormula (s.occurrences++[added]) with
  | error err => rw [hf] at h; cases h
  | ok formula =>
   rw [hf] at h
   have kept := solidRetains s.motif (s.occurrences++[added]) (s.localBonds++[(anchor,added)]) formula s.repeatAxes s.constituent s.chemistryScope s.bulkHandoff out h
   cases kept
   exact ⟨added,rfl,rfl,rfl,hf,rfl,rfl,rfl,rfl,rfl⟩

theorem appendCounts (s out : Solid) (species : String) (anchor : HeldLabel)
 (h : appendOccurrence s species anchor=.ok out) :
 out.occurrences.length=s.occurrences.length+1 ∧ out.localBonds.length=s.localBonds.length+1 := by
 obtain ⟨added,ha,ho,hb,rest⟩ := appendDerivation s out species anchor h
 rw [ho,hb,SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.appendLength]
 exact ⟨rfl,rfl⟩
end SFT.Chemistry.SolidLocalDerivation
