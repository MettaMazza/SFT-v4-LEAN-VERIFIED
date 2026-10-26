import SFT.Foundation.ExactOperations
import SFT.Foundation.CommonRefinement
namespace SFT.Foundation.ExactOperationsGrammar
set_option maxRecDepth 20000

inductive Domain where
  | unrestricted | positiveThroughOne

def domainName : Domain → String
  | .unrestricted => "domain-unrestricted"
  | .positiveThroughOne => "domain-exact-positive-through-One"

inductive FullTurn where
  | absence | one

def fullTurnName : FullTurn → String
  | .absence => "full-turn-as-absence"
  | .one => "full-turn-as-One"

inductive FoldComposition where
  | rawJunction | junctionThenCast

def foldName : FoldComposition → String
  | .rawJunction => "fold-raw-junction"
  | .junctionThenCast => "fold-junction-then-cast"

inductive TakeGuard where
  | unguarded | strictlyLarger

def takeName : TakeGuard → String
  | .unguarded => "take-unguarded"
  | .strictlyLarger => "take-strictly-larger"

inductive Unison where
  | unidentified | exactOneRelation

def unisonName : Unison → String
  | .unidentified => "unison-unidentified"
  | .exactOneRelation => "unison-exact-One-relation"

inductive Trace where
  | unbound | rootBound

def traceName : Trace → String
  | .unbound => "trace-unbound"
  | .rootBound => "trace-root-bound"

inductive Extra where
  | noExtra | hasExtra

def extraName : Extra → String
  | .noExtra => "no-extra"
  | .hasExtra => "has-extra"

structure Candidate where
  domain : Domain
  fullTurn : FullTurn
  fold : FoldComposition
  take : TakeGuard
  unison : Unison
  trace : Trace
  extra : Extra

def sourceFields (c : Candidate) : List String := [domainName c.domain, fullTurnName c.fullTurn, foldName c.fold, takeName c.take, unisonName c.unison, traceName c.trace, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)

def exactForm (c : Candidate) : String := SFT.Host.Text.join ["Operational interface has ", SFT.Host.Text.intercalate ", " (sourceFields c), "."]

def survivorId : String := "domain-exact-positive-through-One__full-turn-as-One__fold-junction-then-cast__take-strictly-larger__unison-exact-One-relation__trace-root-bound__no-extra"

def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId

def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (domainName c.domain) "domain-exact-positive-through-One" &&
  SFT.Host.Text.equal (fullTurnName c.fullTurn) "full-turn-as-One" &&
  SFT.Host.Text.equal (foldName c.fold) "fold-junction-then-cast" &&
  SFT.Host.Text.equal (takeName c.take) "take-strictly-larger" &&
  SFT.Host.Text.equal (unisonName c.unison) "unison-exact-One-relation" &&
  SFT.Host.Text.equal (traceName c.trace) "trace-root-bound" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.contains (candidateId c) "domain-unrestricted" then "It admits absence, signed, irrational, imaginary or beyond-One proof values." else
  if SFT.Host.Text.contains (candidateId c) "full-turn-as-absence" then "It turns a completed positive cycle into numerical absence." else
  if SFT.Host.Text.contains (candidateId c) "fold-raw-junction" then "Raw self-junction can leave the admitted part domain." else
  if SFT.Host.Text.contains (candidateId c) "take-unguarded" then "Unguarded removal can produce absence or a signed quantity." else
  if SFT.Host.Text.contains (candidateId c) "unison-unidentified" then "It lacks the exact identity relation for coincident parts." else
  if SFT.Host.Text.contains (candidateId c) "trace-unbound" then "Its result is not bound to the generating operations and root trace." else
  if SFT.Host.Text.contains (candidateId c) "has-extra" then "It introduces an operation, literal or parameter not supplied by the dependencies." else
  "It is exact, closed, positive, root-traced and contains only cast, Fold, guarded Take and unison."

def generationRule : String := "Generate the complete product of domain, full-turn representation, Fold composition, Take guard, unison identity, trace custody and added-data class."
def grammarBoundary : String := "All primitive operational interfaces on exact positive rational parts of the structural One using only complete-One casting, self-junction and a strictly guarded positive Take."

def candidates : List Candidate :=
  ([Domain.unrestricted,.positiveThroughOne]).flatMap fun domain =>
  ([FullTurn.absence,.one]).flatMap fun fullTurn =>
  ([FoldComposition.rawJunction,.junctionThenCast]).flatMap fun fold =>
  ([TakeGuard.unguarded,.strictlyLarger]).flatMap fun take =>
  ([Unison.unidentified,.exactOneRelation]).flatMap fun unison =>
  ([Trace.unbound,.rootBound]).flatMap fun trace =>
  ([Extra.noExtra,.hasExtra]).map fun extra =>
  ⟨domain,fullTurn,fold,take,unison,trace,extra⟩

def survivor : Candidate := ⟨.positiveThroughOne,.one,.junctionThenCast,.strictlyLarger,.exactOneRelation,.rootBound,.noExtra⟩

theorem generatedCardinality : candidates.length = 128 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk domain fullTurn fold take unison trace extra =>
    have hdomain : domain ∈ [Domain.unrestricted,.positiveThroughOne] := by
      cases domain <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfullTurn : fullTurn ∈ [FullTurn.absence,.one] := by
      cases fullTurn <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfold : fold ∈ [FoldComposition.rawJunction,.junctionThenCast] := by
      cases fold <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htake : take ∈ [TakeGuard.unguarded,.strictlyLarger] := by
      cases take <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hunison : unison ∈ [Unison.unidentified,.exactOneRelation] := by
      cases unison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htrace : trace ∈ [Trace.unbound,.rootBound] := by
      cases trace <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.noExtra,.hasExtra] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ domain _ hdomain
    apply CommonRefinement.memFlatMap _ _ fullTurn _ hfullTurn
    apply CommonRefinement.memFlatMap _ _ fold _ hfold
    apply CommonRefinement.memFlatMap _ _ take _ htake
    apply CommonRefinement.memFlatMap _ _ unison _ hunison
    apply CommonRefinement.memFlatMap _ _ trace _ htrace
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 10000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk domain fullTurn fold take unison trace extra =>
    cases domain <;> cases fullTurn <;> cases fold <;> cases take <;> cases unison <;> cases trace <;> cases extra
    all_goals rfl

set_option maxHeartbeats 4000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk domain fullTurn fold take unison trace extra =>
    cases domain <;> cases fullTurn <;> cases fold <;> cases take <;> cases unison <;> cases trace <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.domain = .positiveThroughOne ∧ c.fullTurn = .one ∧ c.fold = .junctionThenCast ∧ c.take = .strictlyLarger ∧ c.unison = .exactOneRelation ∧ c.trace = .rootBound ∧ c.extra = .noExtra

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk domain fullTurn fold take unison trace extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6
      rfl

theorem domainRejected (c : Candidate) (h : c.domain = .unrestricted) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.domain eq
    rw [h] at field
    cases field

theorem fullTurnRejected (c : Candidate) (h : c.fullTurn = .absence) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.fullTurn eq
    rw [h] at field
    cases field

theorem foldRejected (c : Candidate) (h : c.fold = .rawJunction) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.fold eq
    rw [h] at field
    cases field

theorem takeRejected (c : Candidate) (h : c.take = .unguarded) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.take eq
    rw [h] at field
    cases field

theorem unisonRejected (c : Candidate) (h : c.unison = .unidentified) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.unison eq
    rw [h] at field
    cases field

theorem traceRejected (c : Candidate) (h : c.trace = .unbound) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.trace eq
    rw [h] at field
    cases field

theorem extraRejected (c : Candidate) (h : c.extra = .hasExtra) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Foundation.ExactOperationsGrammar
