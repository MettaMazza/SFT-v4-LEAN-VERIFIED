import SFT.Physics.QuantumPhysicalSpin
namespace SFT.Physics.QuantumPhysicalIdentity

structure Pair (Constituent : Type) where
  left : Constituent
  right : Constituent

def exchange {Constituent : Type} (p : Pair Constituent) : Pair Constituent := ⟨p.right,p.left⟩

theorem exchangeTwice {Constituent : Type} (p : Pair Constituent) : exchange (exchange p) = p := by
  cases p; rfl

-- Each registered observation supplies its complete transition/composition trace.
def indistinguishable {Constituent Trace : Type} (observations : List (Pair Constituent → Trace))
    (p : Pair Constituent) : Prop := ∀ observe ∈ observations, observe (exchange p) = observe p

def ledger {Constituent Trace : Type} (observations : List (Pair Constituent → Trace))
    (p : Pair Constituent) := observations.map (fun observe => observe p)

theorem fullLedgerPreserved {Constituent Trace : Type} (observations : List (Pair Constituent → Trace))
    (p : Pair Constituent) (same : indistinguishable observations p) :
    ledger observations (exchange p) = ledger observations p := by
  induction observations with
  | nil => rfl
  | cons observe rest ih =>
    change observe (exchange p) :: ledger rest (exchange p) = observe p :: ledger rest p
    rw [same observe (.head _),ih (fun f hf => same f (.tail _ hf))]

theorem exchangedIdentityPreserved {Constituent Trace : Type} (observations : List (Pair Constituent → Trace))
    (p : Pair Constituent) (same : indistinguishable observations p) : indistinguishable observations (exchange p) := by
  intro observe held
  rw [exchangeTwice]
  exact (same observe held).symm

theorem changedObservableDistinguishes {Constituent Trace : Type} (observations : List (Pair Constituent → Trace))
    (p : Pair Constituent) (observe : Pair Constituent → Trace) (held : observe ∈ observations)
    (changed : observe (exchange p) ≠ observe p) : ¬ indistinguishable observations p :=
  fun same => changed (same observe held)

theorem observationExtensionExactly {Constituent Trace : Type} (observations : List (Pair Constituent → Trace))
    (observe : Pair Constituent → Trace) (p : Pair Constituent) :
    indistinguishable (observe :: observations) p ↔
      observe (exchange p) = observe p ∧ indistinguishable observations p := by
  constructor
  · intro h; exact ⟨h observe (.head _),fun f hf => h f (.tail _ hf)⟩
  · intro h f hf
    cases hf with
    | head => exact h.1
    | tail _ hf => exact h.2 f hf

theorem bothConstituentsRetained {Constituent : Type} (p : Pair Constituent) :
    (exchange p).left = p.right ∧ (exchange p).right = p.left := ⟨rfl,rfl⟩

theorem fullLedgerExactly {Constituent Trace : Type} (observations : List (Pair Constituent → Trace))
    (p : Pair Constituent) : ledger observations (exchange p) = ledger observations p ↔
      indistinguishable observations p := by
  constructor
  · intro equal
    induction observations with
    | nil => intro observe held; cases held
    | cons observe rest ih =>
      have both := List.cons.inj equal
      intro f hf
      cases hf with
      | head => exact both.1
      | tail _ hf => exact ih both.2 f hf
  · exact fullLedgerPreserved observations p
end SFT.Physics.QuantumPhysicalIdentity
