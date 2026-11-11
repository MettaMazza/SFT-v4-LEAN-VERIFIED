import SFT.Chemistry.GroupPeriodCoordinates
namespace SFT.Chemistry.ValenceMaximum
inductive Kind where
 | combination | substitution
inductive Carrier where
 | atom (record : ElementIdentity.Atom)
 | fragment (record : EntityIdentity.Entity)
structure Boundary where
 carrier : Carrier
 context : SFT.Host.Canonical.Value
structure Trace (boundary : Boundary) where
 kind : Kind
 firstUnivalentPartner : EntityIdentity.Entity
 furtherUnivalentPartners : List EntityIdentity.Entity
 sourceTrace : SFT.Host.Canonical.Value

def count {boundary : Boundary} (trace : Trace boundary) : Nat := 1 + trace.furtherUnivalentPartners.length

def select {boundary : Boundary} (prior fresh : Trace boundary) : Trace boundary :=
 if count prior < count fresh then fresh else prior

def maximum {boundary : Boundary} : Trace boundary → List (Trace boundary) → Trace boundary
 | first, [] => first
 | first, next :: rest => maximum (select first next) rest

theorem countPositive {boundary : Boundary} (trace : Trace boundary) : 0 < count trace := by
 unfold count
 rw [Nat.add_comm]
 exact Nat.zero_lt_succ _

theorem selectionExactly {boundary : Boundary} (prior fresh : Trace boundary) :
 select prior fresh = if count prior < count fresh then fresh else prior := rfl

theorem selectPriorBound {boundary : Boundary} (prior fresh : Trace boundary) : count prior ≤ count (select prior fresh) := by
 unfold select
 split
 · rename_i h; exact Nat.le_of_lt h
 · exact Nat.le_refl _

theorem selectFreshBound {boundary : Boundary} (prior fresh : Trace boundary) : count fresh ≤ count (select prior fresh) := by
 unfold select
 split
 · exact Nat.le_refl _
 · rename_i h; exact Nat.le_of_not_gt h

theorem maximumHeld {boundary : Boundary} (first : Trace boundary) (rest : List (Trace boundary)) :
 maximum first rest ∈ first :: rest := by
 induction rest generalizing first with
 | nil => exact .head _
 | cons next rest ih =>
   have selected : select first next ∈ first :: next :: rest := by
     unfold select
     split
     · exact .tail _ (.head _)
     · exact .head _
   have transfer : ∀ x, x ∈ select first next :: rest → x ∈ first :: next :: rest := by
     intro x hx
     cases hx with
     | head => exact selected
     | tail _ held => exact .tail _ (.tail _ held)
   exact transfer _ (ih (select first next))

theorem maximumBounds {boundary : Boundary} (first : Trace boundary) (rest : List (Trace boundary))
 (trace : Trace boundary) (held : trace ∈ first :: rest) : count trace ≤ count (maximum first rest) := by
 induction rest generalizing first trace with
 | nil =>
   cases held with
   | head => exact Nat.le_refl _
   | tail _ impossible => cases impossible
 | cons next rest ih =>
   cases held with
   | head => exact Nat.le_trans (selectPriorBound _ _) (ih _ _ (.head _))
   | tail _ held =>
     cases held with
     | head => exact Nat.le_trans (selectFreshBound _ _) (ih _ _ (.head _))
     | tail _ old => exact ih _ _ (.tail _ old)

theorem maximumAppend {boundary : Boundary} (first : Trace boundary) (rest : List (Trace boundary))
 (fresh : Trace boundary) : maximum first (rest ++ [fresh]) = select (maximum first rest) fresh := by
 induction rest generalizing first with
 | nil => rfl
 | cons next rest ih => exact ih (select first next)

theorem maximumUniqueCount {boundary : Boundary} (first : Trace boundary) (rest : List (Trace boundary))
 (other : Trace boundary) (held : other ∈ first :: rest)
 (upper : ∀ trace ∈ first :: rest, count trace ≤ count other) : count other = count (maximum first rest) :=
 Nat.le_antisymm (maximumBounds _ _ _ held) (upper _ (maximumHeld _ _))

theorem typicalNonmaximumRejected {boundary : Boundary} (first : Trace boundary) (rest : List (Trace boundary))
 (typical larger : Trace boundary) (held : larger ∈ first :: rest) (strict : count typical < count larger) :
 count typical ≠ count (maximum first rest) := by
 intro same
 have h := Nat.lt_of_lt_of_le strict (maximumBounds _ _ _ held)
 rw [same] at h
 exact Nat.lt_irrefl _ h

-- The census is retained, including all combination and substitution traces.
structure Census where
 boundary : Boundary
 first : Trace boundary
 rest : List (Trace boundary)

def valence (census : Census) := count (maximum census.first census.rest)
def extend (census : Census) (fresh : Trace census.boundary) : Census :=
 ⟨census.boundary,census.first,census.rest ++ [fresh]⟩

theorem appendMaximum (census : Census) (fresh : Trace census.boundary) :
 valence (extend census fresh) =
 if valence census < count fresh then count fresh else valence census := by
 change count (maximum census.first (census.rest ++ [fresh])) = _
 rw [maximumAppend]
 unfold select valence
 split <;> rfl

theorem extensionRetainsBoundary (census : Census) (fresh : Trace census.boundary) :
 (extend census fresh).boundary = census.boundary := rfl

theorem extensionRetainsPrior (census : Census) (fresh old : Trace census.boundary)
 (held : old ∈ census.first :: census.rest) : old ∈ (extend census fresh).first :: (extend census fresh).rest := by
 cases held with
 | head => exact .head _
 | tail _ prior => exact .tail _ (SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ prior)
end SFT.Chemistry.ValenceMaximum
