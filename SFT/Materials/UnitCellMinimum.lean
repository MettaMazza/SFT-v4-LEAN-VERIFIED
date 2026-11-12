import SFT.Materials.UnitCellReconstruction
namespace SFT.Materials.UnitCellMinimum
open UnitCellReconstruction SFT.Mathematics.DiscreteObjects

-- Count distinct retained seed sites, not translation steps or fitted values.
def seedSites (t : Trace) : List String := (t.siteSteps.map Prod.snd).eraseDups
def size (t : Trace) : Nat := (seedSites t).length

-- A trace may use only original held seeds and original adjacency rows.
def sourceSeedCheck (t : Trace) : Bool :=
 t.siteSteps.all (fun row => has t.lattice.cells.graph.nodes row.2) &&
 t.relationSteps.all (fun row => has t.lattice.cells.graph.edges row.2)

def admissible (t : Trace) : Prop := sourceSeedCheck t=true ∧ reconstructsOnce t

def admissibleCheck (t : Trace) : Bool := sourceSeedCheck t && reconstructionCheck t

theorem admissibleCheckMeaning (t : Trace) : admissibleCheck t=true ↔ admissible t := by
 constructor
 · intro h
   have p := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp h
   exact ⟨p.1,(reconstructionCheckMeaning t).mp p.2⟩
 · intro h
   exact (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
     ⟨h.1,(reconstructionCheckMeaning t).mpr h.2⟩

-- Retain every minimum: no order-dependent choice of one basis is installed.
def minimalCheck (family : List Trace) (t : Trace) : Bool :=
 admissibleCheck t && family.all (fun other =>
   !admissibleCheck other || decide (size t ≤ size other))

def minima (family : List Trace) : List Trace := family.filter (minimalCheck family)

theorem alternativeCheckMeaning (t other : Trace) :
 (!admissibleCheck other || decide (size t ≤ size other))=true ↔
 (admissible other → size t ≤ size other) := by
 cases h : admissibleCheck other with
 | false =>
   constructor
   · intro _ exactOther
     have yes := (admissibleCheckMeaning other).mpr exactOther
     rw [h] at yes; cases yes
   · intro _; rfl
 | true =>
   constructor
   · intro test _
     exact of_decide_eq_true test
   · intro bound
     exact decide_eq_true (bound ((admissibleCheckMeaning other).mp h))

theorem minimalCheckMeaning (family : List Trace) (t : Trace) :
 minimalCheck family t=true ↔
 admissible t ∧ ∀ other, other∈family → admissible other → size t ≤ size other := by
 constructor
 · intro passed
   have h := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp passed
   refine ⟨(admissibleCheckMeaning t).mp h.1,?_⟩
   intro other held
   exact (alternativeCheckMeaning t other).mp
     ((SFT.Mathematics.DiscreteObjects.allTrueIffMembers _ _).mp h.2 other held)
 · intro h
   apply (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
   exact ⟨(admissibleCheckMeaning t).mpr h.1,
     (SFT.Mathematics.DiscreteObjects.allTrueIffMembers _ _).mpr
       (fun other held => (alternativeCheckMeaning t other).mpr (h.2 other held))⟩

theorem minimumMembership (family : List Trace) (t : Trace) :
 t∈minima family ↔ t∈family ∧ admissible t ∧
 (∀ other, other∈family → admissible other → size t ≤ size other) := by
 constructor
 · intro held
   have h := (filterMemberIff _ _ _).mp held
   exact ⟨h.1,(minimalCheckMeaning family t).mp h.2⟩
 · intro h
   exact (filterMemberIff _ _ _).mpr
     ⟨h.1,(minimalCheckMeaning family t).mpr h.2⟩

theorem minimumSizeUnique (family : List Trace) (a b : Trace)
 (ha : a∈minima family) (hb : b∈minima family) : size a=size b := by
 have aa := (minimumMembership family a).mp ha
 have bb := (minimumMembership family b).mp hb
 exact Nat.le_antisymm (aa.2.2 b bb.1 bb.2.1) (bb.2.2 a aa.1 aa.2.1)

theorem largerReconstructionExcluded (family : List Trace) (a b : Trace)
 (ha : a∈family) (exactA : admissible a) (larger : size a<size b) :
 ¬ b∈minima family := by
 intro held
 have lower := ((minimumMembership family b).mp held).2.2 a ha exactA
 exact Nat.not_le_of_gt larger lower

theorem sameFamilySameMinima (left right : List Trace)
 (same : ∀ t, t∈left ↔ t∈right) (t : Trace) :
 t∈minima left ↔ t∈minima right := by
 constructor
 · intro held
   have h := (minimumMembership left t).mp held
   apply (minimumMembership right t).mpr
   exact ⟨(same t).mp h.1,h.2.1,fun other ho exactOther => h.2.2 other ((same other).mpr ho) exactOther⟩
 · intro held
   have h := (minimumMembership right t).mp held
   apply (minimumMembership left t).mpr
   exact ⟨(same t).mpr h.1,h.2.1,fun other ho exactOther => h.2.2 other ((same other).mp ho) exactOther⟩

theorem leastInNonemptyFamily (first : Trace) (rest : List Trace) :
 ∃ best, best∈first::rest ∧ ∀ other, other∈first::rest → size best≤size other := by
 induction rest generalizing first with
 | nil =>
   refine ⟨first,List.Mem.head [],?_⟩
   intro other held
   cases held with
   | head => exact Nat.le_refl _
   | tail _ h => cases h
 | cons next tail ih =>
   obtain ⟨best,present,bound⟩ := ih next
   cases Nat.le_total (size first) (size best) with
   | inl smaller =>
     refine ⟨first,List.Mem.head _,?_⟩
     intro other held
     cases held with
     | head => exact Nat.le_refl _
     | tail _ h => exact Nat.le_trans smaller (bound other h)
   | inr smaller =>
     refine ⟨best,List.Mem.tail first present,?_⟩
     intro other held
     cases held with
     | head => exact smaller
     | tail _ h => exact bound other h

theorem minimumExists (family : List Trace) (witness : Trace)
 (held : witness∈family) (valid : admissible witness) :
 ∃ best, best∈minima family := by
 have hw : witness∈family.filter admissibleCheck :=
   (filterMemberIff _ _ _).mpr ⟨held,(admissibleCheckMeaning witness).mpr valid⟩
 cases h : family.filter admissibleCheck with
 | nil => rw [h] at hw; cases hw
 | cons first rest =>
   obtain ⟨best,present,bound⟩ := leastInNonemptyFamily first rest
   have inFilter : best∈family.filter admissibleCheck := by rw [h]; exact present
   have bestParts := (filterMemberIff _ _ _).mp inFilter
   refine ⟨best,(minimumMembership family best).mpr ⟨bestParts.1,
     (admissibleCheckMeaning best).mp bestParts.2,?_⟩⟩
   intro other member exactOther
   have otherHeld := (filterMemberIff admissibleCheck family other).mpr
     ⟨member,(admissibleCheckMeaning other).mpr exactOther⟩
   rw [h] at otherHeld
   exact bound other otherHeld
end SFT.Materials.UnitCellMinimum
