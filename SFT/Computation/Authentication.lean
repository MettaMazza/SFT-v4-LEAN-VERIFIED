import SFT.Computation.SecurityPartition
namespace SFT.Computation.Authentication
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation

structure Credential where
  identity : String
  principal : String
  deriving DecidableEq

structure Response where
  credential : String
  challenge : String
  response : String
  deriving DecidableEq

structure Attempt where
  actor : String
  claimed : String
  credential : String
  challenge : String
  response : String
  deriving DecidableEq

structure Model where
  principals : List String
  credentials : List Credential
  challenges : List String
  responses : List Response
  attempts : List Attempt

def matching (a : Attempt) (c : Credential) : Bool :=
  decide (c.identity = a.credential) && decide (c.principal = a.claimed)

def witnesses (m : Model) (a : Attempt) : List Credential := m.credentials.filter (matching a)

def supported (m : Model) (a : Attempt) : Bool :=
  has m.attempts a && has m.principals a.claimed && has m.challenges a.challenge

def accepts (m : Model) (a : Attempt) : Bool :=
  supported m a && !(witnesses m a).isEmpty &&
  has m.responses ⟨a.credential,a.challenge,a.response⟩

theorem witnessMeaning (m : Model) (a : Attempt) (c : Credential) : c ∈ witnesses m a ↔
    c ∈ m.credentials ∧ c.identity = a.credential ∧ c.principal = a.claimed := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; have q := (andTrue _ _).mp p.2
    exact ⟨p.1,of_decide_eq_true q.1,of_decide_eq_true q.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(andTrue _ _).mpr ⟨decide_eq_true h.2.1,decide_eq_true h.2.2⟩⟩

theorem acceptanceBoundary (m : Model) (a : Attempt) (h : accepts m a = true) :
    a ∈ m.attempts ∧ a.claimed ∈ m.principals ∧ a.challenge ∈ m.challenges ∧
    ⟨a.credential,a.challenge,a.response⟩ ∈ m.responses := by
  have p := (andTrue _ _).mp h
  have q := (andTrue _ _).mp p.1
  have r := (andTrue _ _).mp q.1
  have t := (andTrue _ _).mp r.1
  exact ⟨(hasIff _ _).mp t.1,(hasIff _ _).mp t.2,(hasIff _ _).mp r.2,(hasIff _ _).mp p.2⟩

theorem acceptedCredential (m : Model) (a : Attempt) (h : accepts m a = true) :
    ∃ c, c ∈ m.credentials ∧ c.identity = a.credential ∧ c.principal = a.claimed := by
  have p := (andTrue _ _).mp ((andTrue _ _).mp h).1
  cases rows : witnesses m a with
  | nil => rw [rows] at p; cases p.2
  | cons c cs =>
    have held : c ∈ witnesses m a := by rw [rows]; exact .head _
    exact ⟨c,(witnessMeaning _ _ _).mp held⟩

def accepted (m : Model) : List Attempt := m.attempts.filter (accepts m)
def impersonations (m : Model) : List Attempt :=
  (accepted m).filter (fun a => decide (a.actor ≠ a.claimed))

theorem impersonationMeaning (m : Model) (a : Attempt) : a ∈ impersonations m ↔
    accepts m a = true ∧ a.actor ≠ a.claimed := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h
    exact ⟨((filterMemberIff _ _ _).mp p.1).2,of_decide_eq_true p.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨(filterMemberIff _ _ _).mpr
      ⟨(acceptanceBoundary _ _ h.1).1,h.1⟩,decide_eq_true h.2⟩

def authentic (m : Model) : Bool := (accepted m).all (fun a => decide (a.actor = a.claimed))

theorem exactAuthenticity (m : Model) : authentic m = true ↔
    ∀ a, accepts m a = true → a.actor = a.claimed := by
  constructor
  · intro h a ha
    exact of_decide_eq_true (allTrueAtMember _ _ h a
      ((filterMemberIff _ _ _).mpr ⟨(acceptanceBoundary _ _ ha).1,ha⟩))
  · intro h; apply (allTrueIffMembers _ _).mpr
    intro a ha; exact decide_eq_true (h a ((filterMemberIff _ _ _).mp ha).2)

theorem rejectedImpersonation (m : Model) (checked : authentic m = true) (a : Attempt)
    (different : a.actor ≠ a.claimed) : accepts m a ≠ true :=
  fun h => different ((exactAuthenticity m).mp checked a h)

structure VerificationTrace (m : Model) (a : Attempt) : Prop where
  attempt : a ∈ m.attempts
  principal : a.claimed ∈ m.principals
  challenge : a.challenge ∈ m.challenges
  credential : ∃ c, c ∈ m.credentials ∧ c.identity = a.credential ∧ c.principal = a.claimed
  response : ⟨a.credential,a.challenge,a.response⟩ ∈ m.responses

theorem exactVerificationTrace (m : Model) (a : Attempt) : accepts m a = true ↔ VerificationTrace m a := by
  constructor
  · intro h; have p := acceptanceBoundary m a h
    exact ⟨p.1,p.2.1,p.2.2.1,acceptedCredential m a h,p.2.2.2⟩
  · intro h
    obtain ⟨c,hc,id,owner⟩ := h.credential
    have member := (witnessMeaning m a c).mpr ⟨hc,id,owner⟩
    have nonempty : !(witnesses m a).isEmpty = true := by
      cases rows : witnesses m a with
      | nil => rw [rows] at member; cases member
      | cons c cs => rfl
    exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr
      ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(hasIff _ _).mpr h.attempt,(hasIff _ _).mpr h.principal⟩,
        (hasIff _ _).mpr h.challenge⟩,nonempty⟩,(hasIff _ _).mpr h.response⟩

structure Extension (first second : Model) : Prop where
  principals : ∀ x, x ∈ first.principals → x ∈ second.principals
  credentials : ∀ x, x ∈ first.credentials → x ∈ second.credentials
  challenges : ∀ x, x ∈ first.challenges → x ∈ second.challenges
  responses : ∀ x, x ∈ first.responses → x ∈ second.responses
  attempts : ∀ x, x ∈ first.attempts → x ∈ second.attempts

theorem traceExtension (first second : Model) (inc : Extension first second) (a : Attempt)
    (h : VerificationTrace first a) : VerificationTrace second a := by
  obtain ⟨c,hc,id,owner⟩ := h.credential
  exact ⟨inc.attempts _ h.attempt,inc.principals _ h.principal,inc.challenges _ h.challenge,
    ⟨c,inc.credentials c hc,id,owner⟩,inc.responses _ h.response⟩

theorem acceptanceExtension (first second : Model) (inc : Extension first second) (a : Attempt)
    (h : accepts first a = true) : accepts second a = true :=
  (exactVerificationTrace _ _).mpr (traceExtension _ _ inc a ((exactVerificationTrace _ _).mp h))

theorem unregisteredAttempt (m : Model) (a : Attempt) (absent : a ∉ m.attempts) : accepts m a ≠ true :=
  fun h => absent (acceptanceBoundary m a h).1

theorem missingChallenge (m : Model) (a : Attempt) (absent : a.challenge ∉ m.challenges) : accepts m a ≠ true :=
  fun h => absent (acceptanceBoundary m a h).2.2.1

theorem missingResponse (m : Model) (a : Attempt)
    (absent : (⟨a.credential,a.challenge,a.response⟩ : Response) ∉ m.responses) : accepts m a ≠ true :=
  fun h => absent (acceptanceBoundary m a h).2.2.2

theorem acceptedImpersonationFails (m : Model) (a : Attempt) (held : accepts m a = true)
    (different : a.actor ≠ a.claimed) : authentic m ≠ true :=
  fun h => different ((exactAuthenticity m).mp h a held)

end SFT.Computation.Authentication
