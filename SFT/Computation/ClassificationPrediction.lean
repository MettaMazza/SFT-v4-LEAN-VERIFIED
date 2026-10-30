import SFT.Computation.Inference
namespace SFT.Computation.ClassificationPrediction
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation

structure Training where
  inputs : List String
  labels : List String
  hypotheses : List Inference.Hypothesis
  examples : List Inference.Evidence

structure Sealed (training : Training) where
  hypothesis : Inference.Hypothesis
  retained : hypothesis ∈ Inference.retained training.examples training.hypotheses

def outputs (training : Training) (sealed : Sealed training) (input : String) : List String :=
  (sealed.hypothesis.2.filter (fun row => decide (row.1 = input) && has training.inputs row.1 && has training.labels row.2)).map Prod.snd

theorem outputMeaning (training : Training) (sealed : Sealed training) (input label : String) : label ∈ outputs training sealed input ↔
    (input,label) ∈ sealed.hypothesis.2 ∧ input ∈ training.inputs ∧ label ∈ training.labels := by
  constructor
  · intro h; obtain ⟨row,held,same⟩ := memMapPreimage _ _ _ h
    have p := (filterMemberIff _ _ _).mp held; have q := (andTrue _ _).mp p.2; have z := (andTrue _ _).mp q.1
    have first := of_decide_eq_true z.1
    cases row with
    | mk a b =>
      dsimp at first same
      cases first
      cases same
      exact ⟨p.1,(hasIff _ _).mp z.2,(hasIff _ _).mp q.2⟩
  · intro h; exact memMap Prod.snd (input,label) _ ((filterMemberIff _ _ _).mpr
      ⟨h.1,(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨decide_eq_true rfl,(hasIff _ _).mpr h.2.1⟩,(hasIff _ _).mpr h.2.2⟩⟩)

def predict (training : Training) (sealed : Sealed training) (input : String) : Except String String :=
  match outputs training sealed input with
  | [] => .error "prediction requires exactly one supported label"
  | label::rest => match rest with
    | [] => .ok label
    | _::_ => .error "prediction requires exactly one supported label"

theorem predictionMeaning (training : Training) (sealed : Sealed training) (input label : String) :
    predict training sealed input = .ok label ↔ outputs training sealed input = [label] := by
  unfold predict
  cases rows : outputs training sealed input with
  | nil => constructor <;> intro h <;> cases h
  | cons a as => cases as with
    | nil => constructor <;> intro h <;> cases h <;> rfl
    | cons b bs => constructor <;> intro h <;> cases h

theorem predictionSource (training : Training) (sealed : Sealed training) (input label : String)
    (h : predict training sealed input = .ok label) :
    (input,label) ∈ sealed.hypothesis.2 ∧ input ∈ training.inputs ∧ label ∈ training.labels := by
  have rows := (predictionMeaning _ _ _ _).mp h
  apply (outputMeaning _ _ _ _).mp
  rw [rows]; exact .head _

theorem trainingRetained (training : Training) (sealed : Sealed training) (row : Inference.Evidence)
    (held : row ∈ training.examples) : row ∈ sealed.hypothesis.2 :=
  ((Inference.retainedMeaning _ _ _).mp sealed.retained).2 row held

structure Target where
  input : String
  label : String
  deriving DecidableEq

structure Prediction (training : Training) (sealed : Sealed training) where
  input : String
  label : String
  checked : predict training sealed input = .ok label

def agrees (training : Training) (sealed : Sealed training) (target : Target) : Bool :=
  match predict training sealed target.input with
  | .ok label => decide (label = target.label)
  | .error _ => false

def matchesLedger (training : Training) (sealed : Sealed training) (targets : List Target) : List Target :=
  targets.filter (agrees training sealed)
def nonmatches (training : Training) (sealed : Sealed training) (targets : List Target) : List Target :=
  targets.filter (fun t => !agrees training sealed t)

theorem agreementMeaning (training : Training) (sealed : Sealed training) (t : Target) : agrees training sealed t = true ↔
    predict training sealed t.input = .ok t.label := by
  unfold agrees
  cases run : predict training sealed t.input with
  | error err => constructor <;> intro h <;> cases h
  | ok label =>
    constructor
    · intro h; have same := of_decide_eq_true h; cases same; rfl
    · intro h; cases h; exact decide_eq_true rfl

theorem matchLedgerMeaning (training : Training) (sealed : Sealed training) (targets : List Target) (t : Target) :
    t ∈ matchesLedger training sealed targets ↔ t ∈ targets ∧ predict training sealed t.input = .ok t.label := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,(agreementMeaning _ _ _).mp p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(agreementMeaning _ _ _).mpr h.2⟩

theorem nonmatchMeaning (training : Training) (sealed : Sealed training) (targets : List Target) (t : Target) :
    t ∈ nonmatches training sealed targets ↔ t ∈ targets ∧ agrees training sealed t = false := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,(notTrue _).mp p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(notTrue _).mpr h.2⟩

theorem evaluationExhaustion (training : Training) (sealed : Sealed training) (targets : List Target) (t : Target)
    (held : t ∈ targets) : t ∈ matchesLedger training sealed targets ∨ t ∈ nonmatches training sealed targets := by
  cases h : agrees training sealed t with
  | false => exact .inr ((nonmatchMeaning _ _ _ _).mpr ⟨held,h⟩)
  | true => exact .inl ((filterMemberIff _ _ _).mpr ⟨held,h⟩)

def falsified (training : Training) (sealed : Sealed training) (target : Target) : Bool :=
  match predict training sealed target.input with
  | .ok label => decide (label ≠ target.label)
  | .error _ => false

def falsifications (training : Training) (sealed : Sealed training) (targets : List Target) : List Target :=
  targets.filter (falsified training sealed)

theorem falsifiedMeaning (training : Training) (sealed : Sealed training) (t : Target) : falsified training sealed t = true ↔
    ∃ label, predict training sealed t.input = .ok label ∧ label ≠ t.label := by
  unfold falsified
  cases run : predict training sealed t.input with
  | error err =>
    constructor
    · intro h; cases h
    · intro ⟨label,h,_⟩; cases h
  | ok label =>
    constructor
    · intro h; exact ⟨label,rfl,of_decide_eq_true h⟩
    · intro ⟨other,h,different⟩; cases h; exact decide_eq_true different

theorem falsificationMeaning (training : Training) (sealed : Sealed training) (targets : List Target) (t : Target) :
    t ∈ falsifications training sealed targets ↔ t ∈ targets ∧ ∃ label, predict training sealed t.input = .ok label ∧ label ≠ t.label := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,(falsifiedMeaning _ _ _).mp p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(falsifiedMeaning _ _ _).mpr h.2⟩

theorem evaluationDisjoint (training : Training) (sealed : Sealed training) (targets : List Target) (t : Target)
    (h : t ∈ matchesLedger training sealed targets) : t ∉ falsifications training sealed targets := by
  intro bad
  have same := ((matchLedgerMeaning _ _ _ _).mp h).2
  obtain ⟨label,run,different⟩ := ((falsificationMeaning _ _ _ _).mp bad).2
  rw [same] at run
  cases run
  exact different rfl

theorem noPredictionNotFalsified (training : Training) (sealed : Sealed training) (t : Target) (err : String)
    (h : predict training sealed t.input = .error err) : falsified training sealed t = false := by
  unfold falsified; rw [h]

theorem unsupportedInput (training : Training) (sealed : Sealed training) (input label : String)
    (absent : input ∉ training.inputs) : predict training sealed input ≠ .ok label :=
  fun h => absent (predictionSource _ _ _ _ h).2.1

structure TargetCustody (training : Training) where
  sealed : Sealed training
  targets : List Target
  heldApart : ∀ target, target ∈ targets → ∀ row, row ∈ training.examples → target.input ≠ row.1

theorem targetNotTraining (training : Training) (custody : TargetCustody training) (target : Target)
    (held : target ∈ custody.targets) : (target.input,target.label) ∉ training.examples := by
  intro bad; exact custody.heldApart target held (target.input,target.label) bad rfl

structure Extension (first second : Training) : Prop where
  hypotheses : ∀ h, h ∈ first.hypotheses → h ∈ second.hypotheses
  examples : ∀ e, e ∈ second.examples → e ∈ first.examples
  inputs : first.inputs = second.inputs
  labels : first.labels = second.labels

def extendSealed (first second : Training) (inc : Extension first second) (sealed : Sealed first) : Sealed second :=
  ⟨sealed.hypothesis,(Inference.retainedMeaning _ _ _).mpr
    ⟨inc.hypotheses _ ((Inference.retainedMeaning _ _ _).mp sealed.retained).1,
     fun e held => trainingRetained first sealed e (inc.examples e held)⟩⟩

theorem extensionPreservesOutputs (first second : Training) (inc : Extension first second) (sealed : Sealed first) (input : String) :
    outputs second (extendSealed _ _ inc sealed) input = outputs first sealed input := by
  unfold outputs extendSealed
  rw [inc.inputs,inc.labels]

theorem extensionPreservesPrediction (first second : Training) (inc : Extension first second) (sealed : Sealed first) (input : String) :
    predict second (extendSealed _ _ inc sealed) input = predict first sealed input := by
  unfold predict
  rw [extensionPreservesOutputs]

end SFT.Computation.ClassificationPrediction
