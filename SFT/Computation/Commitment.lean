import SFT.Computation.SecurityPartition
namespace SFT.Computation.Commitment
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
open SFT.Mathematics.ProbabilityObservations
open SFT.Foundation.Count.TraceDerivation

structure Row where
  message : String
  opening : String
  commitment : String
  deriving DecidableEq

structure Model where
  messages : List String
  openings : List String
  commits : List Row
  verification : List Row
  observation : Observation

def supported (m : Model) (r : Row) : Bool := has m.messages r.message && has m.openings r.opening
def generated (m : Model) (r : Row) : Bool := supported m r && has m.commits r
def verifies (m : Model) (r : Row) : Bool := supported m r && has m.verification r

def accepted (m : Model) : List Row := m.verification.filter (supported m)

theorem acceptedMeaning (m : Model) (r : Row) : r ∈ accepted m ↔ verifies m r = true := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h
    exact (andTrue _ _).mpr ⟨p.2,(hasIff _ _).mpr p.1⟩
  · intro h; have p := (andTrue _ _).mp h
    exact (filterMemberIff _ _ _).mpr ⟨(hasIff _ _).mp p.2,p.1⟩

def pairs (m : Model) : List (Row × Row) :=
  (accepted m).flatMap (fun a => (accepted m).map (fun b => (a,b)))

theorem pairMeaning (m : Model) (a b : Row) : (a,b) ∈ pairs m ↔ verifies m a = true ∧ verifies m b = true := by
  constructor
  · intro h
    obtain ⟨x,hx,h⟩ := SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ h
    obtain ⟨y,hy,id⟩ := memMapPreimage _ _ _ h
    have xa := congrArg Prod.fst id; have yb := congrArg Prod.snd id
    cases xa; cases yb; exact ⟨(acceptedMeaning _ _).mp hx,(acceptedMeaning _ _).mp hy⟩
  · intro h
    exact SFT.Foundation.CommonRefinement.memFlatMap _ _ a (a,b) ((acceptedMeaning _ _).mpr h.1)
      (memMap (fun b => (a,b)) b _ ((acceptedMeaning _ _).mpr h.2))

def binding (m : Model) : Bool := (pairs m).all (fun p =>
  if p.1.commitment = p.2.commitment then decide (p.1.message = p.2.message) else true)

theorem exactBinding (m : Model) : binding m = true ↔
    ∀ a, verifies m a = true → ∀ b, verifies m b = true → a.commitment = b.commitment → a.message = b.message := by
  constructor
  · intro h a ha b hb same
    have result := allTrueAtMember _ _ h (a,b) ((pairMeaning _ _ _).mpr ⟨ha,hb⟩)
    change (if a.commitment = b.commitment then decide (a.message = b.message) else true) = true at result
    rw [ite_eq_left same] at result; exact of_decide_eq_true result
  · intro h; apply (allTrueIffMembers _ _).mpr
    intro pair held; have p := (pairMeaning _ _ _).mp held
    change (if pair.1.commitment = pair.2.commitment then decide (pair.1.message = pair.2.message) else true) = true
    by_cases same : pair.1.commitment = pair.2.commitment
    · rw [ite_eq_left same]; exact decide_eq_true (h _ p.1 _ p.2 same)
    · rw [ite_eq_right same]

def bindingCollisions (m : Model) : List (Row × Row) := (pairs m).filter (fun p =>
  decide (p.1.commitment = p.2.commitment) && decide (p.1.message ≠ p.2.message))

theorem collisionMeaning (m : Model) (a b : Row) : (a,b) ∈ bindingCollisions m ↔
    verifies m a = true ∧ verifies m b = true ∧ a.commitment = b.commitment ∧ a.message ≠ b.message := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; have q := (pairMeaning _ _ _).mp p.1
    have t := (andTrue _ _).mp p.2
    exact ⟨q.1,q.2,of_decide_eq_true t.1,of_decide_eq_true t.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨(pairMeaning _ _ _).mpr ⟨h.1,h.2.1⟩,
    (andTrue _ _).mpr ⟨decide_eq_true h.2.2.1,decide_eq_true h.2.2.2⟩⟩

theorem incompatibleOpenings (m : Model) (a b : Row) (held : (a,b) ∈ bindingCollisions m) : binding m ≠ true := by
  intro h; have p := (collisionMeaning _ _ _).mp held
  exact p.2.2.2 ((exactBinding m).mp h a p.1 b p.2.1 p.2.2.1)

structure CommitTrace (m : Model) where
  row : Row
  source : generated m row = true

structure OpeningTrace (m : Model) (commit : CommitTrace m) where
  row : Row
  sameCommitment : row.commitment = commit.row.commitment
  accepted : verifies m row = true

theorem twoOpeningsAgree (m : Model) (checked : binding m = true) (commit : CommitTrace m)
    (first second : OpeningTrace m commit) : first.row.message = second.row.message :=
  (exactBinding m).mp checked _ first.accepted _ second.accepted (first.sameCommitment.trans second.sameCommitment.symm)

def observationClass (m : Model) (view : String) : List Row :=
  m.commits.filter (fun r => supported m r && belongs m.observation view r.commitment)

theorem observationClassMeaning (m : Model) (view : String) (r : Row) : r ∈ observationClass m view ↔
    generated m r = true ∧ image m.observation r.commitment = some view := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; have q := (andTrue _ _).mp p.2
    exact ⟨(andTrue _ _).mpr ⟨q.1,(hasIff _ _).mpr p.1⟩,(belongsMeaning _ _ _).mp q.2⟩
  · intro h; have p := (andTrue _ _).mp h.1
    exact (filterMemberIff _ _ _).mpr ⟨(hasIff _ _).mp p.2,(andTrue _ _).mpr ⟨p.1,(belongsMeaning _ _ _).mpr h.2⟩⟩

theorem hiddenMessagesCannotRecover (m : Model) (view : String) (a b : Row)
    (ha : a ∈ observationClass m view) (hb : b ∈ observationClass m view) (different : a.message ≠ b.message) :
    ¬ ∃ decode : Option String → String,
      decode (image m.observation a.commitment) = a.message ∧ decode (image m.observation b.commitment) = b.message := by
  intro ⟨decode,left,right⟩
  have same := ((observationClassMeaning _ _ _).mp ha).2.trans ((observationClassMeaning _ _ _).mp hb).2.symm
  exact different (left.symm.trans ((congrArg decode same).trans right))

theorem bindingHidingBoundary (m : Model) (view : String) (a b : Row)
    (ha : a ∈ observationClass m view) (hb : b ∈ observationClass m view)
    (va : verifies m a = true) (vb : verifies m b = true) (different : a.message ≠ b.message)
    (observationSeparatesCommitments : image m.observation a.commitment = image m.observation b.commitment → a.commitment = b.commitment) :
    binding m ≠ true := by
  have same := ((observationClassMeaning _ _ _).mp ha).2.trans ((observationClassMeaning _ _ _).mp hb).2.symm
  exact incompatibleOpenings m a b ((collisionMeaning _ _ _).mpr ⟨va,vb,observationSeparatesCommitments same,different⟩)

structure Extension (first second : Model) : Prop where
  messages : ∀ x, x ∈ first.messages → x ∈ second.messages
  openings : ∀ x, x ∈ first.openings → x ∈ second.openings
  commits : ∀ r, r ∈ first.commits → r ∈ second.commits
  verification : ∀ r, r ∈ first.verification → r ∈ second.verification
  observation : ∀ r, r ∈ first.commits → image second.observation r.commitment = image first.observation r.commitment

theorem supportExtension (first second : Model) (inc : Extension first second) (r : Row)
    (h : supported first r = true) : supported second r = true := by
  have p := (andTrue _ _).mp h
  exact (andTrue _ _).mpr ⟨(hasIff _ _).mpr (inc.messages _ ((hasIff _ _).mp p.1)),
    (hasIff _ _).mpr (inc.openings _ ((hasIff _ _).mp p.2))⟩

theorem generatedExtension (first second : Model) (inc : Extension first second) (r : Row)
    (h : generated first r = true) : generated second r = true := by
  have p := (andTrue _ _).mp h
  exact (andTrue _ _).mpr ⟨supportExtension _ _ inc r p.1,(hasIff _ _).mpr (inc.commits _ ((hasIff _ _).mp p.2))⟩

theorem verificationExtension (first second : Model) (inc : Extension first second) (r : Row)
    (h : verifies first r = true) : verifies second r = true := by
  have p := (andTrue _ _).mp h
  exact (andTrue _ _).mpr ⟨supportExtension _ _ inc r p.1,(hasIff _ _).mpr (inc.verification _ ((hasIff _ _).mp p.2))⟩

def extendCommit (first second : Model) (inc : Extension first second) (commit : CommitTrace first) : CommitTrace second :=
  ⟨commit.row,generatedExtension _ _ inc _ commit.source⟩

def extendOpening (first second : Model) (inc : Extension first second) (commit : CommitTrace first)
    (opening : OpeningTrace first commit) : OpeningTrace second (extendCommit first second inc commit) :=
  ⟨opening.row,opening.sameCommitment,verificationExtension _ _ inc _ opening.accepted⟩

theorem hiddenExtension (first second : Model) (inc : Extension first second) (r : Row) (view : String)
    (held : r ∈ observationClass first view) : r ∈ observationClass second view := by
  have p := (observationClassMeaning _ _ _).mp held
  have source := (hasIff _ _).mp ((andTrue _ _).mp p.1).2
  exact (observationClassMeaning _ _ _).mpr ⟨generatedExtension _ _ inc r p.1,(inc.observation r source).trans p.2⟩

end SFT.Computation.Commitment
