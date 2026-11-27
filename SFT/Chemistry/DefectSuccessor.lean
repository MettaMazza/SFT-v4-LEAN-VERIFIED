import SFT.Chemistry.DefectClosure
namespace SFT.Chemistry.DefectSuccessor
open SFT.Physics.CapabilityValues DefectChemistry

-- The source successor keeps the prior records as ordered prefixes;
-- the same constructor applies its full formula/reconciliation/class/origin checks.
theorem referenceExtension (motif : HeldLabel) (rs : List ReferenceSite) (os : List Occupancy)
 (is : List Interstitial) (site : ReferenceSite) (occupied : Occupancy)
 (rf of : List FormulaEntry) (rows : List Reconciliation) (cs : Classes) (org : Value) (out : Defect)
 (h : defect motif (rs++[site]) (os++[occupied]) is rf of rows cs org=.ok out) :
 out.references=rs++[site] ∧ out.occupancies=os++[occupied] ∧ out.interstitials=is ∧
 out.referenceFormula=rf ∧ out.observedFormula=of ∧ out.reconciliation=rows ∧ out.classes=cs ∧ out.origin=org := by
 have retained := DefectClosure.retains motif (rs++[site]) (os++[occupied]) is rf of rows cs org out h
 cases retained
 exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩

theorem interstitialExtension (motif : HeldLabel) (rs : List ReferenceSite) (os : List Occupancy)
 (is : List Interstitial) (added : Interstitial)
 (rf of : List FormulaEntry) (rows : List Reconciliation) (cs : Classes) (org : Value) (out : Defect)
 (h : defect motif rs os (is++[added]) rf of rows cs org=.ok out) :
 out.references=rs ∧ out.occupancies=os ∧ out.interstitials=is++[added] ∧
 out.referenceFormula=rf ∧ out.observedFormula=of ∧ out.reconciliation=rows ∧ out.classes=cs ∧ out.origin=org := by
 have retained := DefectClosure.retains motif rs os (is++[added]) rf of rows cs org out h
 cases retained
 exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
end SFT.Chemistry.DefectSuccessor
