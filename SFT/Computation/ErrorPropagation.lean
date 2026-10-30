import SFT.Computation.ExactApproximate
namespace SFT.Computation.ErrorPropagation
open NumericalError NumericalLedger SFT.Foundation.ExactOperations

-- Edges retain their original endpoints; no orientation is converted to a signed value.
structure Edge where
  identity : String
  reference : List Number
  approximation : List Number

structure LocalLedger where
  edge : Edge
  rows : List Row

def transport : List Edge → Except String (List LocalLedger)
  | [] => .ok []
  | edge :: rest => do
    let rows ← exactErrorLedger edge.reference edge.approximation
    let tail ← transport rest
    pure (⟨edge,rows⟩ :: tail)

inductive Trace : List Edge → List LocalLedger → Prop where
  | base : Trace [] []
  | step (edge : Edge) (rest : List Edge) (rows : List Row) (tail : List LocalLedger)
      (localAccepted : exactErrorLedger edge.reference edge.approximation = .ok rows)
      (previous : Trace rest tail) : Trace (edge::rest) (⟨edge,rows⟩::tail)

theorem replay (edges : List Edge) (ledgers : List LocalLedger)
    (trace : Trace edges ledgers) : transport edges = .ok ledgers := by
  induction trace with
  | base => rfl
  | step edge rest rows tail localAccepted previous ih =>
    unfold transport
    rw [localAccepted]
    rw [ih]
    rfl

theorem reconstruct (edges : List Edge) (ledgers : List LocalLedger)
    (accepted : transport edges = .ok ledgers) : Trace edges ledgers := by
  induction edges generalizing ledgers with
  | nil => cases accepted; exact .base
  | cons edge rest ih =>
    unfold transport at accepted
    cases h : exactErrorLedger edge.reference edge.approximation with
    | error e => rw [h] at accepted; cases accepted
    | ok rows =>
      rw [h] at accepted
      cases t : transport rest with
      | error e => rw [t] at accepted; cases accepted
      | ok tail =>
        rw [t] at accepted
        cases accepted
        exact .step edge rest rows tail h (ih tail t)

theorem exactTransport (edges : List Edge) (ledgers : List LocalLedger) :
    transport edges = .ok ledgers ↔ Trace edges ledgers :=
  ⟨reconstruct _ _,replay _ _⟩

theorem completeDependencyRows (edges : List Edge) (ledgers : List LocalLedger)
    (trace : Trace edges ledgers) : ledgers.map LocalLedger.edge = edges := by
  induction trace with
  | base => rfl
  | step edge rest rows tail localAccepted previous ih =>
    change edge :: tail.map LocalLedger.edge = edge :: rest
    rw [ih]

theorem serialComposition (first second : List Edge) (left right : List LocalLedger)
    (a : Trace first left) (b : Trace second right) : Trace (first++second) (left++right) := by
  induction a with
  | base => exact b
  | step edge rest rows tail localAccepted previous ih => exact .step _ _ _ _ localAccepted ih

theorem localProvenance (edges : List Edge) (ledgers : List LocalLedger)
    (trace : Trace edges ledgers) : ∀ ledger, ledger ∈ ledgers →
      ledger.edge ∈ edges ∧ ledger.edge.reference ≠ [] ∧
      Rows 1 ledger.edge.reference ledger.edge.approximation ledger.rows := by
  induction trace with
  | base => intro ledger member; cases member
  | step edge rest rows tail localAccepted previous ih =>
    intro ledger member
    cases member with
    | head => exact ⟨.head _,(exactAdmission _ _ _).mp localAccepted⟩
    | tail _ member =>
      obtain ⟨found,nonempty,rows⟩ := ih ledger member
      exact ⟨.tail _ found,nonempty,rows⟩

def terminalLedger (first last : List Number) : Except String (List Row) :=
  exactErrorLedger first last

theorem terminalReconstruction (first last : List Number) (rows : List Row)
    (accepted : terminalLedger first last = .ok rows) :
    first ≠ [] ∧ Rows 1 first last rows :=
  (exactAdmission _ _ _).mp accepted

theorem orientationRetained (edges : List Edge) (ledgers : List LocalLedger)
    (trace : Trace edges ledgers) (ledger : LocalLedger) (member : ledger ∈ ledgers) :
    ∀ row, row ∈ ledger.rows → ∃ (position : Nat) (exact approximate : PositiveFraction),
      .positive exact ∈ ledger.edge.reference ∧ .positive approximate ∈ ledger.edge.approximation ∧
      row = (SFT.Host.Text.append "cell-" (toString position),errorValue exact approximate) :=
  rowProvenance _ _ _ _ (localProvenance _ _ trace ledger member).2.2

theorem successor (edges : List Edge) (ledgers : List LocalLedger)
    (trace : Trace edges ledgers) (edge : Edge) (rows : List Row)
    (accepted : exactErrorLedger edge.reference edge.approximation = .ok rows) :
    transport (edges++[edge]) = .ok (ledgers++[⟨edge,rows⟩]) :=
  replay _ _ (serialComposition _ _ _ _ trace (.step _ _ _ _ accepted .base))

-- A path records interface equality by construction, retaining every edge identity.
inductive Path : List Number → List Edge → List Number → Prop where
  | identity (value : List Number) : Path value [] value
  | step (edge : Edge) (rest : List Edge) (last : List Number)
      (tail : Path edge.approximation rest last) : Path edge.reference (edge::rest) last

theorem pathComposition (first middle last : List Number) (left right : List Edge)
    (a : Path first left middle) (b : Path middle right last) :
    Path first (left++right) last := by
  induction a with
  | identity => exact b
  | step edge rest middle tail ih => exact .step _ _ _ (ih b)

structure Propagation where
  first : List Number
  last : List Number
  edges : List Edge
  localLedgers : List LocalLedger
  interfaces : Path first edges last
  localTrace : Trace edges localLedgers
  terminal : List Row
  terminalAccepted : terminalLedger first last = .ok terminal

theorem propagationSource (result : Propagation) :
    result.localLedgers.map LocalLedger.edge = result.edges ∧
    result.first ≠ [] ∧ Rows 1 result.first result.last result.terminal :=
  ⟨completeDependencyRows _ _ result.localTrace,
    terminalReconstruction _ _ _ result.terminalAccepted⟩

theorem mergeProvenance (left right : Propagation) (interface : left.last = right.first) :
    Path left.first (left.edges++right.edges) right.last ∧
    Trace (left.edges++right.edges) (left.localLedgers++right.localLedgers) := by
  have next : Path left.last right.edges right.last := interface.symm ▸ right.interfaces
  exact ⟨pathComposition _ _ _ _ _ left.interfaces next,
    serialComposition _ _ _ _ left.localTrace right.localTrace⟩

theorem closedCellCancellation (value : PositiveFraction) :
    terminalLedger [.positive value] [.positive value] =
      .ok [("cell-1",NumericalError.one,"equal")] := by
  change rowsFrom 1 [.positive value] [.positive value] = _
  change Except.ok [("cell-1",errorValue value value)] = _
  rw [equalMarker value value rfl]

theorem terminalIndependentOfRoute (a b : Propagation)
    (sameFirst : a.first = b.first) (sameLast : a.last = b.last) :
    a.terminal = b.terminal := by
  have h := a.terminalAccepted
  rw [sameFirst,sameLast,b.terminalAccepted] at h
  exact (Except.ok.inj h).symm

end SFT.Computation.ErrorPropagation
