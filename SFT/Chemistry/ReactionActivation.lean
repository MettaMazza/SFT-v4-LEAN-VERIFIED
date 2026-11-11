import SFT.Foundation.FoldFibres
import SFT.Chemistry.ReactionMechanism
namespace SFT.Chemistry.ReactionActivation
abbrev PositiveCount := SFT.Physics.CapabilityValues.PositiveCount
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
structure Raw where
 sourceSupport : PositiveCount
 reactantBoundary : HeldLabel
 transitionBoundary : HeldLabel
 productBoundary : HeldLabel

def admit (r : Raw) : Except String Raw :=
 let families := [r.reactantBoundary.family,r.transitionBoundary.family,r.productBoundary.family]
 if ["reactant-boundary","transition-boundary","product-boundary"].all
    (fun required => families.any fun actual => SFT.Host.Text.equal required actual) then .ok r
 else .error "activation witness requires all three held boundaries"

structure State where
 boundary : HeldLabel
 reference : HeldLabel
 support : PositiveCount
 sourceOccurrences : List HeldLabel
 completeSupport : sourceOccurrences.length=support.value

def count (state : State) := state.support.value
def select (prior fresh : State) : State :=
 if count prior < count fresh then fresh else prior

def maximum : State → List (State) → State
 | first, [] => first
 | first, next :: rest => maximum (select first next) rest

theorem countPositive (trace : State) : 0 < count trace := by
 exact trace.support.positive

theorem selectionExactly (prior fresh : State) :
 select prior fresh = if count prior < count fresh then fresh else prior := rfl

theorem selectPriorBound (prior fresh : State) : count prior ≤ count (select prior fresh) := by
 unfold select
 split
 · rename_i h; exact Nat.le_of_lt h
 · exact Nat.le_refl _

theorem selectFreshBound (prior fresh : State) : count fresh ≤ count (select prior fresh) := by
 unfold select
 split
 · exact Nat.le_refl _
 · rename_i h; exact Nat.le_of_not_gt h

theorem maximumHeld (first : State) (rest : List (State)) :
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

theorem maximumBounds (first : State) (rest : List (State))
 (trace : State) (held : trace ∈ first :: rest) : count trace ≤ count (maximum first rest) := by
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

theorem maximumAppend (first : State) (rest : List (State))
 (fresh : State) : maximum first (rest ++ [fresh]) = select (maximum first rest) fresh := by
 induction rest generalizing first with
 | nil => rfl
 | cons next rest ih => exact ih (select first next)

theorem maximumUniqueCount (first : State) (rest : List (State))
 (other : State) (held : other ∈ first :: rest)
 (upper : ∀ trace ∈ first :: rest, count trace ≤ count other) : count other = count (maximum first rest) :=
 Nat.le_antisymm (maximumBounds _ _ _ held) (upper _ (maximumHeld _ _))


structure Path where
 mechanism : ReactionMechanism.BoundMechanism
 first : State
 rest : List State
 reference : HeldLabel
 sameReference : ∀ state∈first::rest, state.reference=reference
 endpointWord : (first::rest).map (fun s => s.boundary.label)=
  mechanism.firstState::ReactionMechanism.outputs mechanism.mechanism.raw.steps

def peak (p : Path) := maximum p.first p.rest
def increment (p : Path) := count (peak p)-count p.first

theorem peakAboveReactants (p : Path) : count p.first ≤ count (peak p) := maximumBounds _ _ _ (.head _)
theorem incrementExactlyReaches (p : Path) : increment p+count p.first=count (peak p) :=
 SFT.Foundation.FractionReduction.subtractAdd _ _ (peakAboveReactants p)
theorem leastCrossing (p : Path) (added : Nat) (crosses : count (peak p) ≤ added+count p.first) :
 increment p ≤ added := by
 apply SFT.Foundation.FoldFibres.cancelAddedBound (increment p) added (count p.first)
 rw [incrementExactlyReaches]
 exact crosses
theorem smallerFails (p : Path) (added : Nat) (smaller : added<increment p) :
 ¬count (peak p) ≤ added+count p.first := fun crosses => Nat.not_lt_of_ge (leastCrossing p added crosses) smaller

theorem everyBoundaryReached (p : Path) (state : State) (held : state∈p.first::p.rest) :
 count state ≤ increment p+count p.first := by
 rw [incrementExactlyReaches]
 exact maximumBounds _ _ _ held

theorem peakIsSourceBoundary (p : Path) : peak p∈p.first::p.rest := maximumHeld _ _

theorem peakUniqueSupport (p : Path) (other : State) (held : other∈p.first::p.rest)
 (upper : ∀ s∈p.first::p.rest, count s≤count other) : count other=count (peak p) :=
 maximumUniqueCount _ _ _ held upper

theorem successorPeak (p : Path) (fresh : State) :
 maximum p.first (p.rest++[fresh])=if count (peak p)<count fresh then fresh else peak p :=
 maximumAppend _ _ _

theorem successorRetainsPrior (p : Path) (fresh old : State) (held : old∈p.first::p.rest) :
 old∈p.first::(p.rest++[fresh]) := by
 cases held with
 | head => exact .head _
 | tail _ h => exact .tail _ (SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ h)

structure Barrier where
 raw : Raw
 accepted : admit raw=.ok raw
 path : Path
 positiveIncrement : 0<increment path
 supportBinding : raw.sourceSupport.value=increment path
 reactantBinding : raw.reactantBoundary=path.first.boundary
 transitionBinding : raw.transitionBoundary=(peak path).boundary
 product : State
 productTerminal : (path.first::path.rest).getLast?=some product
 uniqueHighest : ∀ state∈path.first::path.rest, count state=count (peak path) → state.boundary=(peak path).boundary
 productBinding : raw.productBoundary=product.boundary

theorem noAlternativeHighestBoundary (b : Barrier) (state : State)
 (held : state∈b.path.first::b.path.rest) (same : count state=count (peak b.path)) :
 state.boundary=b.raw.transitionBoundary := (b.uniqueHighest state held same).trans b.transitionBinding.symm

theorem peakRetainsReference (p : Path) : (peak p).reference=p.reference :=
 p.sameReference _ (peakIsSourceBoundary p)

theorem registeredSupportCrosses (b : Barrier) :
 b.raw.sourceSupport.value+count b.path.first=count (peak b.path) := by
 rw [b.supportBinding]; exact incrementExactlyReaches _
theorem registeredSupportLeast (b : Barrier) (added : Nat)
 (crosses : count (peak b.path)≤added+count b.path.first) : b.raw.sourceSupport.value≤added := by
 rw [b.supportBinding]; exact leastCrossing _ _ crosses

theorem referenceTranslationCancels (high low offset : Nat) :
 (high+offset)-(low+offset)=high-low := SFT.Foundation.FractionReduction.addSubtractSame _ _ _

theorem twoStatePeak (reactant transition : State) (higher : count reactant<count transition) :
 maximum reactant [transition]=transition := by
 change (if count reactant<count transition then transition else reactant)=transition
 rw [if_pos higher]

theorem baseIncrement (reactant added : PositiveCount) :
 (reactant.value+added.value)-reactant.value=added.value := by
 rw [Nat.add_comm]
 exact SFT.Foundation.ExactCast.addSubtract _ _

theorem successorIncrement (p : Path) (fresh : State) :
 count (maximum p.first (p.rest++[fresh]))-count p.first =
 if count (peak p)<count fresh then count fresh-count p.first else increment p := by
 rw [maximumAppend]
 unfold select peak increment
 split <;> rfl
end SFT.Chemistry.ReactionActivation
