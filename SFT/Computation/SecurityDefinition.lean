import SFT.Computation.SecurityPartition
namespace SFT.Computation.SecurityDefinition
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations

structure Attempt where
  adversary : String
  secret : String
  view : String
  guess : String
  cost : Nat
  deriving DecidableEq
structure Model where
  secrets : List String
  observations : List (String × String)
  adversaries : List String
  attempts : List Attempt

def admitted (m : Model) (a : Attempt) : Bool :=
  has m.secrets a.secret && has m.observations (a.secret,a.view) && has m.adversaries a.adversary
def rows (m : Model) : List Attempt := m.attempts.filter (admitted m)
def successes (m : Model) : List Attempt := (rows m).filter (fun a => decide (a.guess = a.secret))
def bounded (m : Model) (budget : Nat) : List Attempt := (rows m).filter (fun a => decide (a.cost ≤ budget))
def boundedSuccesses (m : Model) (budget : Nat) : List Attempt :=
  (bounded m budget).filter (fun a => decide (a.guess = a.secret))

theorem rowMeaning (m : Model) (a : Attempt) : a ∈ rows m ↔
    a ∈ m.attempts ∧ a.secret ∈ m.secrets ∧ (a.secret,a.view) ∈ m.observations ∧ a.adversary ∈ m.adversaries := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; have q := (andTrue _ _).mp p.2; have t := (andTrue _ _).mp q.1
    exact ⟨p.1,(hasIff _ _).mp t.1,(hasIff _ _).mp t.2,(hasIff _ _).mp q.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(hasIff _ _).mpr h.2.1,(hasIff _ _).mpr h.2.2.1⟩,(hasIff _ _).mpr h.2.2.2⟩⟩

theorem successMeaning (m : Model) (a : Attempt) : a ∈ successes m ↔ a ∈ rows m ∧ a.guess = a.secret := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,of_decide_eq_true p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem boundedMeaning (m : Model) (budget : Nat) (a : Attempt) : a ∈ bounded m budget ↔ a ∈ rows m ∧ a.cost ≤ budget := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,of_decide_eq_true p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem boundedSuccessMeaning (m : Model) (budget : Nat) (a : Attempt) : a ∈ boundedSuccesses m budget ↔
    a ∈ successes m ∧ a.cost ≤ budget := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; have q := (boundedMeaning _ _ _).mp p.1
    exact ⟨(successMeaning _ _).mpr ⟨q.1,of_decide_eq_true p.2⟩,q.2⟩
  · intro h; have p := (successMeaning _ _).mp h.1
    exact (filterMemberIff _ _ _).mpr ⟨(boundedMeaning _ _ _).mpr ⟨p.1,h.2⟩,decide_eq_true p.2⟩

def allFail (m : Model) : Bool := (rows m).all (fun a => decide (a.guess ≠ a.secret))
def boundedFail (m : Model) (budget : Nat) : Bool := (bounded m budget).all (fun a => decide (a.guess ≠ a.secret))

theorem exactAllFail (m : Model) : allFail m = true ↔ ∀ a, a ∈ rows m → a.guess ≠ a.secret := by
  constructor
  · intro h a held; exact of_decide_eq_true (allTrueAtMember _ _ h a held)
  · intro h; exact (allTrueIffMembers _ _).mpr (fun a held => decide_eq_true (h a held))

theorem exactBoundedFail (m : Model) (budget : Nat) : boundedFail m budget = true ↔
    ∀ a, a ∈ rows m → a.cost ≤ budget → a.guess ≠ a.secret := by
  constructor
  · intro h a held cost; exact of_decide_eq_true (allTrueAtMember _ _ h a ((boundedMeaning _ _ _).mpr ⟨held,cost⟩))
  · intro h; exact (allTrueIffMembers _ _).mpr (fun a held => decide_eq_true (h a ((boundedMeaning _ _ _).mp held).1 ((boundedMeaning _ _ _).mp held).2))

theorem allImpliesBounded (m : Model) (budget : Nat) (h : allFail m = true) : boundedFail m budget = true :=
  (exactBoundedFail _ _).mpr (fun a held _ => (exactAllFail _).mp h a held)

theorem smallerBudget (m : Model) (small large : Nat) (bound : small ≤ large) (h : boundedFail m large = true) : boundedFail m small = true :=
  (exactBoundedFail _ _).mpr (fun a held cost => (exactBoundedFail _ _).mp h a held (Nat.le_trans cost bound))

def observationClass (m : Model) (view : String) : List String :=
  m.secrets.filter (fun s => has m.observations (s,view))

theorem classMeaning (m : Model) (view secret : String) : secret ∈ observationClass m view ↔
    secret ∈ m.secrets ∧ (secret,view) ∈ m.observations := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,(hasIff _ _).mp p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(hasIff _ _).mpr h.2⟩

theorem closedClassNoRecovery (m : Model) (view a b : String) (ha : a ∈ observationClass m view)
    (hb : b ∈ observationClass m view) (different : a ≠ b) :
    ¬ ∃ decode : String → String, decode view = a ∧ decode view = b := by
  intro ⟨decode,left,right⟩; exact different (left.symm.trans right)

structure Reduction (first second : Model) where
  translate : Attempt → Attempt
  source : ∀ a, a ∈ rows first → translate a ∈ rows second
  success : ∀ a, a ∈ rows first → a.guess = a.secret → (translate a).guess = (translate a).secret
  cost : ∀ a, (translate a).cost ≤ a.cost

theorem reductionBoundedFailure (first second : Model) (r : Reduction first second) (budget : Nat)
    (checked : boundedFail second budget = true) : boundedFail first budget = true := by
  apply (exactBoundedFail _ _).mpr
  intro a held cost success
  exact (exactBoundedFail _ _).mp checked (r.translate a) (r.source a held) (Nat.le_trans (r.cost a) cost) (r.success a held success)

def fullObservationClosure (m : Model) : Bool :=
  m.observations.all (fun row => if has m.secrets row.1 then m.secrets.all (fun secret => has m.observations (secret,row.2)) else true)

theorem exactObservationClosure (m : Model) : fullObservationClosure m = true ↔
    ∀ secret view, secret ∈ m.secrets → (secret,view) ∈ m.observations →
      ∀ other, other ∈ m.secrets → (other,view) ∈ m.observations := by
  constructor
  · intro h secret view held obs other otherHeld
    have checked := allTrueAtMember _ _ h (secret,view) obs
    rw [(hasIff _ _).mpr held] at checked
    exact (hasIff _ _).mp (allTrueAtMember _ _ checked other otherHeld)
  · intro h; apply (allTrueIffMembers _ _).mpr
    intro row held
    cases test : has m.secrets row.1 with
    | false => rfl
    | true => exact (allTrueIffMembers _ _).mpr (fun other otherHeld => (hasIff _ _).mpr (h row.1 row.2 ((hasIff _ _).mp test) held other otherHeld))

theorem observationNoRecovery (m : Model) (checked : fullObservationClosure m = true)
    (a b view : String) (ha : a ∈ m.secrets) (hb : b ∈ m.secrets)
    (observed : (a,view) ∈ m.observations) (different : a ≠ b) :
    b ∈ observationClass m view ∧ ¬ ∃ decode : String → String, decode view = a ∧ decode view = b := by
  have bobs := (exactObservationClosure m).mp checked a view ha observed b hb
  exact ⟨(classMeaning _ _ _).mpr ⟨hb,bobs⟩,
    closedClassNoRecovery m view a b ((classMeaning _ _ _).mpr ⟨ha,observed⟩) ((classMeaning _ _ _).mpr ⟨hb,bobs⟩) different⟩

structure Extension (first second : Model) : Prop where
  secrets : ∀ x, x ∈ first.secrets → x ∈ second.secrets
  observations : ∀ x, x ∈ first.observations → x ∈ second.observations
  adversaries : ∀ x, x ∈ first.adversaries → x ∈ second.adversaries
  attempts : ∀ x, x ∈ first.attempts → x ∈ second.attempts

theorem rowExtension (first second : Model) (inc : Extension first second) (a : Attempt) (held : a ∈ rows first) : a ∈ rows second := by
  have p := (rowMeaning _ _).mp held
  exact (rowMeaning _ _).mpr ⟨inc.attempts _ p.1,inc.secrets _ p.2.1,inc.observations _ p.2.2.1,inc.adversaries _ p.2.2.2⟩

theorem successExtension (first second : Model) (inc : Extension first second) (a : Attempt) (held : a ∈ successes first) : a ∈ successes second := by
  have p := (successMeaning _ _).mp held
  exact (successMeaning _ _).mpr ⟨rowExtension _ _ inc _ p.1,p.2⟩

theorem boundedSuccessExtension (first second : Model) (inc : Extension first second) (budget : Nat) (a : Attempt)
    (held : a ∈ boundedSuccesses first budget) : a ∈ boundedSuccesses second budget := by
  have p := (boundedSuccessMeaning _ _ _).mp held
  exact (boundedSuccessMeaning _ _ _).mpr ⟨successExtension _ _ inc _ p.1,p.2⟩

def identityReduction (m : Model) : Reduction m m :=
  ⟨fun a => a,fun _ held => held,fun _ _ success => success,fun _ => Nat.le_refl _⟩

def composeReduction (first middle last : Model) (left : Reduction first middle) (right : Reduction middle last) : Reduction first last :=
  ⟨fun a => right.translate (left.translate a),
   fun a held => right.source _ (left.source _ held),
   fun a held success => right.success _ (left.source _ held) (left.success _ held success),
   fun a => Nat.le_trans (right.cost _) (left.cost a)⟩

theorem composedTranslation (first middle last : Model) (left : Reduction first middle) (right : Reduction middle last) (a : Attempt) :
    (composeReduction _ _ _ left right).translate a = right.translate (left.translate a) := rfl

end SFT.Computation.SecurityDefinition
