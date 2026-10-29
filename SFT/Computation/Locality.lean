import SFT.Computation.DistributedKnowledge
namespace SFT.Computation.Locality
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation

-- A radius is the length of the retained registered communication trace.
structure Network where
  processes : List String
  rows : List (String × String)

def admittedRow (n : Network) (a b : String) : Prop :=
  a ∈ n.processes ∧ b ∈ n.processes ∧ (a,b) ∈ n.rows

inductive Reach (n : Network) : String → List (String × String) → String → Prop where
  | identity (p) : p ∈ n.processes → Reach n p [] p
  | next (a b c trace) : admittedRow n a b → Reach n b trace c → Reach n a ((a,b)::trace) c

def neighborhood (n : Network) (p : String) (radius : Nat) : List String :=
  match radius with
  | 0 => n.processes.filter (fun q => decide (q = p))
  | r+1 => n.processes.filter (fun q => decide (q = p) ||
      n.processes.any (fun b => has n.rows (p,b) && has (neighborhood n b r) q))

theorem identityNeighborhood (n : Network) (p q : String) :
  q ∈ neighborhood n p 0 ↔ q ∈ n.processes ∧ q = p := by
  constructor
  · intro h; have x := (filterMemberIff _ _ _).mp h; exact ⟨x.1,of_decide_eq_true x.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem neighborhoodHeld (n : Network) (p q : String) (radius : Nat)
    (h : q ∈ neighborhood n p radius) : q ∈ n.processes := by
  cases radius with
  | zero => exact ((filterMemberIff _ _ _).mp h).1
  | succ r => exact ((filterMemberIff _ _ _).mp h).1

theorem traceEndpoints (n : Network) (a b : String) (trace : List (String × String))
    (h : Reach n a trace b) : a ∈ n.processes ∧ b ∈ n.processes := by
  induction h with
  | identity p held => exact ⟨held,held⟩
  | next a b c trace edge rest ih => exact ⟨edge.1,ih.2⟩

theorem traceRows (n : Network) (a b : String) (trace : List (String × String))
    (h : Reach n a trace b) : ∀ edge, edge ∈ trace → edge ∈ n.rows := by
  induction h with
  | identity p held => intro edge mem; cases mem
  | next a b c trace row rest ih =>
    intro edge mem; cases mem with
    | head => exact row.2.2
    | tail _ mem => exact ih edge mem

theorem serial (n : Network) (a b c : String) (first second : List (String × String))
    (h : Reach n a first b) (k : Reach n b second c) : Reach n a (first ++ second) c := by
  induction h with
  | identity p held => exact k
  | next a b d trace row rest ih => exact .next _ _ _ _ row (ih k)

theorem traceExtension (first second : Network)
    (processes : ∀ p, p ∈ first.processes → p ∈ second.processes)
    (rows : ∀ edge, edge ∈ first.rows → edge ∈ second.rows)
    (a b : String) (trace : List (String × String)) (h : Reach first a trace b) : Reach second a trace b := by
  induction h with
  | identity p held => exact .identity p (processes p held)
  | next a b c trace edge rest ih => exact .next _ _ _ _ ⟨processes _ edge.1,processes _ edge.2.1,rows _ edge.2.2⟩ ih

theorem neighborhoodTrace (n : Network) (p q : String) (radius : Nat)
    (start : p ∈ n.processes) (held : q ∈ neighborhood n p radius) :
    ∃ trace, Reach n p trace q ∧ trace.length ≤ radius := by
  induction radius generalizing p with
  | zero =>
    have h := (identityNeighborhood _ _ _).mp held
    cases h.2; exact ⟨[],.identity _ start,Nat.le_refl 0⟩
  | succ r ih =>
    have h := (filterMemberIff _ _ _).mp held
    cases eq : decide (q = p) with
    | true =>
      have same := of_decide_eq_true eq
      cases same; exact ⟨[],.identity _ start,Nat.zero_le _⟩
    | false =>
      rw [eq] at h
      obtain ⟨b,hb,edge⟩ := (anyTrueIff _ _).mp h.2
      have pair := (andTrue _ _).mp edge
      obtain ⟨trace,reached,bound⟩ := ih b hb ((hasIff _ _).mp pair.2)
      exact ⟨(p,b)::trace,.next _ _ _ _ ⟨start,hb,(hasIff _ _).mp pair.1⟩ reached,Nat.succ_le_succ bound⟩

theorem identityAtRadius (n : Network) (p : String) (radius : Nat) (held : p ∈ n.processes) :
    p ∈ neighborhood n p radius := by
  cases radius with
  | zero => exact (identityNeighborhood _ _ _).mpr ⟨held,rfl⟩
  | succ r => exact (filterMemberIff _ _ _).mpr ⟨held,by rw [decide_eq_true (Eq.refl p)]; rfl⟩

theorem traceNeighborhood (n : Network) (p q : String) (trace : List (String × String))
    (h : Reach n p trace q) (radius : Nat) (bound : trace.length ≤ radius) :
    q ∈ neighborhood n p radius := by
  induction h generalizing radius with
  | identity p held => exact identityAtRadius n p radius held
  | next a b c trace edge rest ih =>
    cases radius with
    | zero => cases bound
    | succ r =>
      have within := ih r (Nat.le_of_succ_le_succ bound)
      apply (filterMemberIff _ _ _).mpr
      refine ⟨(traceEndpoints _ _ _ _ rest).2,?_⟩
      have any : n.processes.any (fun b => has n.rows (a,b) && has (neighborhood n b r) c) = true :=
        (anyTrueIff _ _).mpr ⟨b,edge.2.1,(andTrue _ _).mpr ⟨(hasIff _ _).mpr edge.2.2,(hasIff _ _).mpr within⟩⟩
      rw [any]
      cases decide (c = a) <;> rfl

theorem exactNeighborhood (n : Network) (p q : String) (radius : Nat) (held : p ∈ n.processes) :
    q ∈ neighborhood n p radius ↔ ∃ trace, Reach n p trace q ∧ trace.length ≤ radius := by
  constructor
  · exact neighborhoodTrace n p q radius held
  · intro ⟨trace,h,bound⟩; exact traceNeighborhood n p q trace h radius bound

-- Local views retain the process identities together with their inputs.
def view (n : Network) (inputs : SFT.Mathematics.ProbabilityObservations.Observation)
    (p : String) (radius : Nat) : List (String × Option String) :=
  (neighborhood n p radius).map (fun q => (q,image inputs q))

theorem viewRow (n : Network) (inputs : SFT.Mathematics.ProbabilityObservations.Observation)
    (p q : String) (radius : Nat) (h : q ∈ neighborhood n p radius) :
    (q,image inputs q) ∈ view n inputs p radius := memMap _ _ _ h

theorem viewProvenance (n : Network) (inputs : SFT.Mathematics.ProbabilityObservations.Observation)
    (p : String) (radius : Nat) (row : String × Option String) (h : row ∈ view n inputs p radius) :
    ∃ q, q ∈ neighborhood n p radius ∧ (q,image inputs q) = row := memMapPreimage _ _ _ h

theorem indistinguishableOutput (f : List (String × Option String) → String)
    (first second : List (String × Option String)) (same : first = second) : f first = f second := congrArg f same

theorem lowerWitness (first second : List (String × Option String)) (a b : String)
    (same : first = second) (different : a ≠ b) :
    ¬ ∃ f : List (String × Option String) → String, f first = a ∧ f second = b := by
  intro ⟨f,ha,hb⟩; exact different (ha.symm.trans ((congrArg f same).trans hb))

def query (n : Network) (p : String) (radius : Nat) : Option (List String) :=
  if has n.processes p then some (neighborhood n p radius) else none

theorem queryBoundary (n : Network) (p : String) (radius : Nat) (absent : p ∉ n.processes) :
    query n p radius = none := by
  unfold query
  cases held : has n.processes p with
  | false => rfl
  | true => exact False.elim (absent ((hasIff _ _).mp held))

theorem omittedRowRejected (n : Network) (a b : String) (trace : List (String × String))
    (edge : String × String) (used : edge ∈ trace) (missing : edge ∉ n.rows) : ¬ Reach n a trace b :=
  fun h => missing (traceRows n a b trace h edge used)

end SFT.Computation.Locality
