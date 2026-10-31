import SFT.Physics.QuantumPhysicalSpectra
import SFT.QuantumComputation.ReversibleComposition
namespace SFT.Physics.QuantumPhysicalEntanglement
open SFT.Foundation.Count.TraceDerivation
open SFT.QuantumComputation.ReversibleModel

def factorizes {L R : Type} (rows : List (L × R)) (left : List L) (right : List R) : Prop :=
  ∀ l r, (l,r) ∈ rows ↔ l ∈ left ∧ r ∈ right

def crossClosed {L R : Type} (rows : List (L × R)) : Prop :=
  ∀ l r l' r', (l,r) ∈ rows → (l',r') ∈ rows → (l,r') ∈ rows

theorem productForcesCrossClosure {L R : Type} (rows : List (L × R))
    (left : List L) (right : List R) (product : factorizes rows left right) : crossClosed rows := by
  intro l r l' r' first second
  exact (product l r').mpr ⟨((product l r).mp first).1,((product l' r').mp second).2⟩

theorem crossClosureGivesFullMarginalProduct {L R : Type} (rows : List (L × R))
    (closed : crossClosed rows) : factorizes rows (rows.map Prod.fst) (rows.map Prod.snd) := by
  intro l r
  constructor
  · intro held
    exact ⟨memMap Prod.fst (l,r) rows held,memMap Prod.snd (l,r) rows held⟩
  · intro ⟨hl,hr⟩
    obtain ⟨a,ha,al⟩ := memMapPreimage Prod.fst l rows hl
    obtain ⟨b,hb,br⟩ := memMapPreimage Prod.snd r rows hr
    cases a with
    | mk a ar => cases b with
      | mk bl b => cases al; cases br; exact closed a ar bl b ha hb

theorem factorizationCriterion {L R : Type} (rows : List (L × R)) :
    (∃ left right, factorizes rows left right) ↔ crossClosed rows := by
  constructor
  · intro ⟨left,right,h⟩; exact productForcesCrossClosure rows left right h
  · intro h; exact ⟨rows.map Prod.fst,rows.map Prod.snd,crossClosureGivesFullMarginalProduct rows h⟩

def entangled {L R : Type} (rows : List (L × R)) : Prop := ¬ ∃ left right, factorizes rows left right

theorem missingCrossWordExcludesEveryIndependentProduct {L R : Type} (rows : List (L × R))
    (l l' : L) (r r' : R) (first : (l,r) ∈ rows) (second : (l',r') ∈ rows)
    (missing : (l,r') ∉ rows) : entangled rows := by
  intro ⟨left,right,h⟩
  exact missing (productForcesCrossClosure rows left right h l r l' r' first second)

theorem entanglementExactlyNonclosed {L R : Type} (rows : List (L × R)) :
    entangled rows ↔ ¬ crossClosed rows := by
  constructor
  · intro h closed; exact h ((factorizationCriterion rows).mpr closed)
  · intro h product; exact h ((factorizationCriterion rows).mp product)

-- The complete original branch stays beside its two constituent observations.
def jointLedger {L R : Type} (p : QuantumPhysicalState.Prepared)
    (left : Word × String → L) (right : Word × String → R) :=
  p.state.branches.map (fun branch => (branch,left branch,right branch))

def jointSupport {L R : Type} (p : QuantumPhysicalState.Prepared)
    (left : Word × String → L) (right : Word × String → R) :=
  p.state.branches.map (fun branch => (left branch,right branch))

theorem completeBranchLedgerRetained {L R : Type} (p : QuantumPhysicalState.Prepared)
    (left : Word × String → L) (right : Word × String → R) :
    (jointLedger p left right).map Prod.fst = p.state.branches := by
  change (p.state.branches.map (fun b => (b,left b,right b))).map Prod.fst = p.state.branches
  induction p.state.branches with
  | nil => rfl
  | cons b bs ih => exact congrArg (List.cons b) ih

def record {L R : Type} (p : QuantumPhysicalState.Prepared)
    (left : Word × String → L) (right : Word × String → R) := (p,jointLedger p left right)

theorem commonPreparationRetained {L R : Type} (p : QuantumPhysicalState.Prepared)
    (left : Word × String → L) (right : Word × String → R) :
    (record p left right).1.preparation = p.preparation ∧
      (record p left right).1.sourceIdentity = p.sourceIdentity := ⟨rfl,rfl⟩

theorem originalIndependentCompositionSupport (left right result : State)
    (accepted : SFT.QuantumComputation.ReversibleComposition.compose left right = .ok result) (word : Word) :
    word ∈ support result ↔ ∃ l, l ∈ left.branches ∧ ∃ r, r ∈ right.branches ∧
      word = SFT.QuantumComputation.ReversibleComposition.jointWord l.1 r.1 :=
  SFT.QuantumComputation.ReversibleComposition.compositionSupport left right result accepted word
end SFT.Physics.QuantumPhysicalEntanglement
