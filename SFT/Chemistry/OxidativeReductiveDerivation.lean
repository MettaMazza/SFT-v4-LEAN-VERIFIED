import SFT.Chemistry.OxidativeReductive
namespace SFT.Chemistry.OxidativeReductiveDerivation
open SFT.Physics.CapabilityValues OxidativeReductive
theorem sameLabelsSelf (xs : List HeldLabel) : sameLabels xs xs=true := by
 induction xs with
 | nil => rfl
 | cons x xs ih => change (InorganicColour.sameLabel x x && sameLabels xs xs)=true; rw [InorganicColourDerivation.sameLabelSelf,ih]; rfl
theorem sameIncidencesSelf (xs : List (HeldLabel × HeldLabel)) : sameIncidences xs xs=true := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
  change (InorganicColour.sameLabel x.1 x.1 && InorganicColour.sameLabel x.2 x.2 && sameIncidences xs xs)=true
  rw [InorganicColourDerivation.sameLabelSelf,InorganicColourDerivation.sameLabelSelf,ih]
  rfl
theorem oxidativeRetains (ms cs src : List HeldLabel) (ps : List (HeldLabel × HeldLabel))
 (dist : List PositiveCount) (direction : HeldLabel) (out : OxidativeTrace)
 (h : oxidativeTrace ms cs src ps dist direction=.ok out) : out=⟨ms,cs,src,ps,dist,direction⟩ := by
 unfold oxidativeTrace at h
 repeat first | split at h | cases h | rfl
theorem oneMetalBase (m x y : HeldLabel) (out : OxidativeTrace) (h : oxidativeHeld [m] x y=.ok out) :
 out.metals=[m] ∧ out.carriers=[x,y] ∧ out.sourceBond=[x,y] ∧ out.products=[(m,x),(m,y)] ∧
 out.distribution.map PositiveCount.value=[2] ∧ out.direction.label="metal-support-to-two-new-incidences" := by
 have kept := oxidativeRetains [m] [x,y] [x,y] [(m,x),(m,y)] [⟨2,by decide⟩]
  ⟨"electron-transfer-orientation","metal-support-to-two-new-incidences",rfl,rfl⟩ out h
 cases kept
 exact ⟨rfl,rfl,rfl,rfl,rfl,rfl⟩
theorem twoMetalBase (m n x y : HeldLabel) (out : OxidativeTrace) (h : oxidativeHeld [m,n] x y=.ok out) :
 out.metals=[m,n] ∧ out.carriers=[x,y] ∧ out.sourceBond=[x,y] ∧ out.products=[(m,x),(n,y)] ∧
 out.distribution.map PositiveCount.value=[1,1] ∧ out.direction.label="metal-support-to-two-new-incidences" := by
 have kept := oxidativeRetains [m,n] [x,y] [x,y] [(m,x),(n,y)] [⟨1,by decide⟩,⟨1,by decide⟩]
  ⟨"electron-transfer-orientation","metal-support-to-two-new-incidences",rfl,rfl⟩ out h
 cases kept
 exact ⟨rfl,rfl,rfl,rfl,rfl,rfl⟩
theorem exactInverse (t : OxidativeTrace) : reductive t=.ok ⟨t,t.sourceBond,t.products,
 ⟨"electron-transfer-orientation","two-incidences-to-metal-support",rfl,rfl⟩⟩ := by
 unfold reductive reductiveTrace
 rw [sameLabelsSelf,sameIncidencesSelf]
 rfl
theorem inverseUnique (t : OxidativeTrace) (out : ReductiveTrace) (h : reductive t=.ok out) :
 out=⟨t,t.sourceBond,t.products,⟨"electron-transfer-orientation","two-incidences-to-metal-support",rfl,rfl⟩⟩ := by
 rw [exactInverse] at h
 cases h
 rfl
theorem inversePreserves (t : OxidativeTrace) (out : ReductiveTrace) (h : reductive t=.ok out) :
 out.oxidative=t ∧ out.restoredBond=t.sourceBond ∧ out.removedProducts=t.products ∧
 out.oxidative.metals=t.metals ∧ out.oxidative.carriers=t.carriers ∧
 out.oxidative.distribution=t.distribution ∧ out.direction.label="two-incidences-to-metal-support" := by
 have kept := inverseUnique t out h
 cases kept
 exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
theorem matchedEndpointPreserved (left right : OxidativeTrace) (out : ReductiveTrace)
 (matched : left.sourceBond=right.sourceBond) (h : reductive left=.ok out) :
 out.restoredBond=right.sourceBond := (inversePreserves left out h).2.1.trans matched
theorem noMetalRejected (x y : HeldLabel) : oxidativeHeld [] x y=.error "only the structurally generated one- and two-metal partitions are admissible" := rfl
theorem furtherMetalsRejected (a b c : HeldLabel) (rest : List HeldLabel) (x y : HeldLabel) :
 oxidativeHeld (a::b::c::rest) x y=.error "only the structurally generated one- and two-metal partitions are admissible" := rfl
end SFT.Chemistry.OxidativeReductiveDerivation
