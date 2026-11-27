import SFT.Chemistry.DefectWitnesses
namespace SFT.Chemistry.DefectDerivation
open SFT.Physics.CapabilityValues DefectChemistry

theorem referenceRetains (site expected : HeldLabel) (out : ReferenceSite)
 (h : referenceSite site expected=.ok out) : out.site=site ∧ out.expected=expected := by
 unfold referenceSite at h
 repeat first | split at h | cases h | exact ⟨rfl,rfl⟩

theorem vacancyRetains (r : ReferenceSite) (identity : String) :
 occupancy r (.emptyOne identity)=.ok ⟨r,.emptyOne identity⟩ := rfl

theorem reconciliationRetains (s : HeldLabel) (r o m a : CountOrEmpty) (out : Reconciliation)
 (h : reconciliationRow s r o m a=.ok out) :
 out.species=s ∧ out.referenceCount=r ∧ out.observedCount=o ∧ out.missing=m ∧ out.added=a := by
 unfold reconciliationRow at h
 repeat first | split at h | cases h | exact ⟨rfl,rfl,rfl,rfl,rfl⟩

theorem missingAddedExclusive (s : HeldLabel) (r o m a : CountOrEmpty) (out : Reconciliation)
 (h : reconciliationRow s r o m a=.ok out) : countEmpty out.missing=true ∨ countEmpty out.added=true := by
 obtain ⟨_,_,_,hm,ha⟩ := reconciliationRetains s r o m a out h
 rw [hm,ha]
 cases m with
 | emptyOne x => exact Or.inl rfl
 | count n =>
  cases a with
  | emptyOne x => exact Or.inr rfl
  | count k =>
   unfold reconciliationRow at h
   split at h
   · cases h
   · cases h

theorem observedSupport (os : List Occupancy) (is : List Interstitial) (xs : List String)
 (h : observedLabels os is=.ok xs) :
 ∃ localLabels otherLabels,
 (os.filter (fun row => !isEmpty row.occupant)).mapM (fun row => occurrenceSpecies row.occupant)=.ok localLabels ∧
 is.mapM (fun row => occurrenceSpecies (.label row.occurrence))=.ok otherLabels ∧ xs=localLabels++otherLabels := by
 unfold observedLabels at h
 cases hl : (os.filter (fun row => !isEmpty row.occupant)).mapM (fun row => occurrenceSpecies row.occupant) with
 | error e => rw [hl] at h; cases h
 | ok ls =>
  rw [hl] at h
  cases hr : is.mapM (fun row => occurrenceSpecies (.label row.occurrence)) with
  | error e => rw [hr] at h; cases h
  | ok rs =>
   rw [hr] at h
   cases h
   exact ⟨ls,rs,rfl,rfl,rfl⟩
end SFT.Chemistry.DefectDerivation
