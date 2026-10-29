import SFT.Computation.ParallelResources
namespace SFT.Computation.BoundResources
open UniversalInterpretation StateTransition StateComposition
open SFT.InformationScience.EncodingMaps

inductive Measure where | time | space

def measured (measure : Measure) (ledger : ResourceRecord.Ledger) : Nat :=
  match measure with | .time => ledger.timeCount | .space => ledger.spaceCount

structure Record where
  model : String
  request : Request
  observed : List String
  occupied : List String
  resources : ResourceRecord.Ledger

def Verified (registry : List (String × Request)) (record : Record) : Prop :=
  lookupFirst registry record.model = some record.request ∧
    run record.request.machine record.request.initial record.request.actions = .ok record.observed ∧
    ResourceRecord.resourceLedger record.observed record.occupied = .ok record.resources

theorem constructiveTrace (registry : List (String × Request)) (record : Record)
    (verified : Verified registry record) :
    (record.model,record.request) ∈ registry ∧
      ∃ before terminal, record.observed = before ++ [terminal] ∧
        Path record.request.machine record.request.initial record.request.actions before terminal := by
  obtain ⟨held,before,terminal,equal,path⟩ := nativePath _ _ _ _ verified.2.1
  exact ⟨lookupRow _ _ _ verified.1,before,terminal,equal,path⟩

theorem exactMeasure (registry : List (String × Request)) (record : Record)
    (verified : Verified registry record) :
    measured .time record.resources = record.observed.length ∧
      measured .space record.resources = record.occupied.length :=
  (ResourceRecord.recordReconstructs _ _ _ verified.2.2).2.2

-- Construct an attained bound over the complete registered finite family.
theorem attainedUpper (measure : Measure) (head : Record) (rest : List Record) :
    ∃ peak, peak ∈ head :: rest ∧ ∀ record, record ∈ head :: rest →
      measured measure record.resources ≤ measured measure peak.resources := by
  induction rest generalizing head with
  | nil =>
    refine ⟨head,.head [],?_⟩
    intro record held
    cases held with
    | head => exact Nat.le_refl _
    | tail _ impossible => cases impossible
  | cons next rest ih =>
    obtain ⟨peak,member,bound⟩ := ih next
    cases Nat.le_total (measured measure head.resources) (measured measure peak.resources) with
    | inl le =>
      refine ⟨peak,.tail head member,?_⟩
      intro record held
      cases held with
      | head => exact le
      | tail _ member => exact bound record member
    | inr le =>
      refine ⟨head,.head _,?_⟩
      intro record held
      cases held with
      | head => exact Nat.le_refl _
      | tail _ member => exact Nat.le_trans (bound record member) le

theorem verifiedUpper (registry : List (String × Request)) (measure : Measure)
    (head : Record) (rest : List Record)
    (verified : ∀ record, record ∈ head :: rest → Verified registry record) :
    ∃ peak, peak ∈ head :: rest ∧ Verified registry peak ∧
      ∀ record, record ∈ head :: rest → measured measure record.resources ≤ measured measure peak.resources := by
  obtain ⟨peak,held,bound⟩ := attainedUpper measure head rest
  exact ⟨peak,held,verified peak held,bound⟩

-- Indistinguishability is relative to the explicitly registered observation
-- and required-answer maps of the problem family, not an imported lower bound.
def Correct (family : List String) (required observe respond : String → String) : Prop :=
  ∀ input, input ∈ family → respond (observe input) = required input

def AdversarialPair (family : List String) (required observe : String → String)
    (left right : String) : Prop :=
  left ∈ family ∧ right ∈ family ∧ observe left = observe right ∧ required left ≠ required right

theorem indistinguishabilityExcludesCorrect (family : List String)
    (required observe respond : String → String) (left right : String)
    (witness : AdversarialPair family required observe left right) :
    ¬ Correct family required observe respond := by
  intro correct
  exact witness.2.2.2 ((correct left witness.1).symm.trans
    ((congrArg respond witness.2.2.1).trans (correct right witness.2.1)))

structure Comparison where
  identity : String
  observe : String → String
  respond : String → String
  resources : ResourceRecord.Ledger

-- Each below-bound member must have its own retained adversarial witness.
theorem lowerCertificate (models : List Comparison) (family : List String)
    (required : String → String) (measure : Measure) (bound : Nat)
    (witnesses : ∀ model, model ∈ models → measured measure model.resources < bound →
      ∃ left right, AdversarialPair family required model.observe left right) :
    ∀ model, model ∈ models → Correct family required model.observe model.respond →
      ¬ measured measure model.resources < bound := by
  intro model held correct below
  obtain ⟨left,right,witness⟩ := witnesses model held below
  exact indistinguishabilityExcludesCorrect _ _ _ _ _ _ witness correct

theorem retainedAdversary (family extension : List String) (required observe : String → String)
    (left right : String) (witness : AdversarialPair family required observe left right) :
    AdversarialPair (family ++ extension) required observe left right :=
  ⟨SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ witness.1,
    SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ witness.2.1,witness.2.2⟩

theorem comparisonComposition (first second : List Comparison) (family : List String)
    (required : String → String) (measure : Measure) (bound : Nat)
    (left : ∀ model, model ∈ first → measured measure model.resources < bound →
      ∃ a b, AdversarialPair family required model.observe a b)
    (right : ∀ model, model ∈ second → measured measure model.resources < bound →
      ∃ a b, AdversarialPair family required model.observe a b) :
    ∀ model, model ∈ first ++ second → measured measure model.resources < bound →
      ∃ a b, AdversarialPair family required model.observe a b := by
  intro model held below
  cases SFT.Foundation.Count.TraceDerivation.memAppendCases _ _ _ held with
  | inl one => exact left model one below
  | inr two => exact right model two below

theorem singletonUpper (measure : Measure) (record : Record) :
    ∀ other, other ∈ [record] → measured measure other.resources ≤ measured measure record.resources := by
  intro other held
  cases held with
  | head => exact Nat.le_refl _
  | tail _ impossible => cases impossible
end SFT.Computation.BoundResources
