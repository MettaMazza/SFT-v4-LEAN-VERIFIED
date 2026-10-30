import SFT.Computation.SecurityPartition
namespace SFT.Computation.Signature
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation

structure Row where
  key : String
  message : String
  signature : String
  deriving DecidableEq

structure Model where
  messages : List String
  keys : List String
  signing : List Row
  verification : List Row
  adversary : List Row

def supported (m : Model) (r : Row) : Bool := has m.messages r.message && has m.keys r.key
def signs (m : Model) (r : Row) : Bool := supported m r && has m.signing r
def verifies (m : Model) (r : Row) : Bool := supported m r && has m.verification r

def signed (m : Model) : List Row := m.signing.filter (supported m)
def accepted (m : Model) : List Row := m.verification.filter (supported m)
def forgeries (m : Model) : List Row := m.adversary.filter (fun r => verifies m r && !has m.signing r)

theorem signingMeaning (m : Model) (r : Row) : signs m r = true ↔
    r.message ∈ m.messages ∧ r.key ∈ m.keys ∧ r ∈ m.signing := by
  constructor
  · intro h; have p := (andTrue _ _).mp h; have q := (andTrue _ _).mp p.1
    exact ⟨(hasIff _ _).mp q.1,(hasIff _ _).mp q.2,(hasIff _ _).mp p.2⟩
  · intro h; exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(hasIff _ _).mpr h.1,(hasIff _ _).mpr h.2.1⟩,(hasIff _ _).mpr h.2.2⟩

theorem signedMeaning (m : Model) (r : Row) : r ∈ signed m ↔ signs m r = true := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h
    exact (andTrue _ _).mpr ⟨p.2,(hasIff _ _).mpr p.1⟩
  · intro h; have p := (andTrue _ _).mp h
    exact (filterMemberIff _ _ _).mpr ⟨(hasIff _ _).mp p.2,p.1⟩

def correct (m : Model) : Bool := (signed m).all (verifies m)

theorem exactCorrectness (m : Model) : correct m = true ↔ ∀ r, signs m r = true → verifies m r = true := by
  constructor
  · intro h r hr; exact allTrueAtMember _ _ h r ((signedMeaning _ _).mpr hr)
  · intro h; exact (allTrueIffMembers _ _).mpr (fun r hr => h r ((signedMeaning _ _).mp hr))

theorem forgeryMeaning (m : Model) (r : Row) : r ∈ forgeries m ↔
    r ∈ m.adversary ∧ verifies m r = true ∧ r ∉ m.signing := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; have q := (andTrue _ _).mp p.2
    refine ⟨p.1,q.1,?_⟩
    intro member; have yes := (hasIff _ _).mpr member; rw [yes] at q; cases q.2
  · intro h
    have absent : has m.signing r = false := by
      cases test : has m.signing r with
      | false => rfl
      | true => exact False.elim (h.2.2 ((hasIff _ _).mp test))
    exact (filterMemberIff _ _ _).mpr ⟨h.1,(andTrue _ _).mpr ⟨h.2.1,(notTrue _).mpr absent⟩⟩

def unforgeable (m : Model) : Bool := m.adversary.all (fun r => if verifies m r then has m.signing r else true)

theorem exactUnforgeability (m : Model) : unforgeable m = true ↔
    ∀ r, r ∈ m.adversary → verifies m r = true → r ∈ m.signing := by
  constructor
  · intro h r held accepted
    have result := allTrueAtMember _ _ h r held
    rw [accepted] at result; exact (hasIff _ _).mp result
  · intro h; apply (allTrueIffMembers _ _).mpr
    intro r held
    cases test : verifies m r with
    | false => rfl
    | true => exact (hasIff _ _).mpr (h r held test)

theorem noGeneratedForgery (m : Model) (checked : unforgeable m = true) (r : Row) : r ∉ forgeries m := by
  intro h; have p := (forgeryMeaning _ _).mp h
  exact p.2.2 ((exactUnforgeability m).mp checked r p.1 p.2.1)

structure SigningTrace (m : Model) where
  row : Row
  source : signs m row = true

structure VerificationTrace (m : Model) where
  row : Row
  source : verifies m row = true

def correctnessTrace (m : Model) (checked : correct m = true) (trace : SigningTrace m) : VerificationTrace m :=
  ⟨trace.row,(exactCorrectness m).mp checked _ trace.source⟩

theorem correctnessRetainsRow (m : Model) (checked : correct m = true) (trace : SigningTrace m) :
    (correctnessTrace m checked trace).row = trace.row := rfl

theorem verificationMeaning (m : Model) (r : Row) : verifies m r = true ↔
    r.message ∈ m.messages ∧ r.key ∈ m.keys ∧ r ∈ m.verification := by
  constructor
  · intro h; have p := (andTrue _ _).mp h; have q := (andTrue _ _).mp p.1
    exact ⟨(hasIff _ _).mp q.1,(hasIff _ _).mp q.2,(hasIff _ _).mp p.2⟩
  · intro h; exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(hasIff _ _).mpr h.1,(hasIff _ _).mpr h.2.1⟩,(hasIff _ _).mpr h.2.2⟩

theorem acceptedMeaning (m : Model) (r : Row) : r ∈ accepted m ↔ verifies m r = true := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h
    exact (andTrue _ _).mpr ⟨p.2,(hasIff _ _).mpr p.1⟩
  · intro h; have p := (andTrue _ _).mp h
    exact (filterMemberIff _ _ _).mpr ⟨(hasIff _ _).mp p.2,p.1⟩

structure Extension (first second : Model) : Prop where
  messages : ∀ x, x ∈ first.messages → x ∈ second.messages
  keys : ∀ x, x ∈ first.keys → x ∈ second.keys
  signing : ∀ r, r ∈ first.signing → r ∈ second.signing
  verification : ∀ r, r ∈ first.verification → r ∈ second.verification
  adversary : ∀ r, r ∈ first.adversary → r ∈ second.adversary

theorem signingExtension (first second : Model) (inc : Extension first second) (r : Row)
    (h : signs first r = true) : signs second r = true := by
  have p := (signingMeaning _ _).mp h
  exact (signingMeaning _ _).mpr ⟨inc.messages _ p.1,inc.keys _ p.2.1,inc.signing _ p.2.2⟩

theorem verificationExtension (first second : Model) (inc : Extension first second) (r : Row)
    (h : verifies first r = true) : verifies second r = true := by
  have p := (verificationMeaning _ _).mp h
  exact (verificationMeaning _ _).mpr ⟨inc.messages _ p.1,inc.keys _ p.2.1,inc.verification _ p.2.2⟩

def extendSigning (first second : Model) (inc : Extension first second) (trace : SigningTrace first) : SigningTrace second :=
  ⟨trace.row,signingExtension _ _ inc _ trace.source⟩

def extendVerification (first second : Model) (inc : Extension first second) (trace : VerificationTrace first) : VerificationTrace second :=
  ⟨trace.row,verificationExtension _ _ inc _ trace.source⟩

theorem missingKeyRejected (m : Model) (r : Row) (absent : r.key ∉ m.keys) : verifies m r ≠ true :=
  fun h => absent ((verificationMeaning _ _).mp h).2.1

theorem outsideAdversary (m : Model) (r : Row) (absent : r ∉ m.adversary) : r ∉ forgeries m :=
  fun h => absent ((forgeryMeaning _ _).mp h).1

end SFT.Computation.Signature
