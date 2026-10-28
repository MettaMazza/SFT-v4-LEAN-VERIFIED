import SFT.Mathematics.LogicForms
import SFT.Mathematics.GeometryTopology
namespace SFT.Mathematics.LogicInference
open LogicForms DiscreteObjects AlgebraOperations GeometryTopology SFT.Foundation.Count.TraceDerivation

abbrev Rule := String × List Proposition × Proposition

def ruleRecord (step : ProofStep) : Rule := (step.rule,step.premises,step.conclusion)

def proofIsValid (available : List Proposition) (steps : List ProofStep) (rules : List Rule) : Bool :=
  match steps with
  | [] => true
  | step :: rest =>
    if !step.premises.all (has available) then false
    else if !has rules (ruleRecord step) then false
    else proofIsValid (available ++ [step.conclusion]) rest rules

def afterSteps (available : List Proposition) : List ProofStep → List Proposition
  | [] => available
  | step :: rest => afterSteps (available ++ [step.conclusion]) rest

inductive AcceptedTrace (rules : List Rule) : List Proposition → List ProofStep → Prop where
  | done (available : List Proposition) : AcceptedTrace rules available []
  | step {available : List Proposition} {entry : ProofStep} {rest : List ProofStep} :
      (∀ premise, premise ∈ entry.premises → premise ∈ available) →
      ruleRecord entry ∈ rules →
      AcceptedTrace rules (available ++ [entry.conclusion]) rest →
      AcceptedTrace rules available (entry :: rest)

def consistent (admitted : List Proposition) : Bool :=
  admitted.all (fun proposition => !has admitted (denied proposition))

def grammarComplete (generated decided : List Proposition) : Bool :=
  distinct generated && generated.all (fun proposition => has decided proposition || has decided (denied proposition))

theorem checkerIffTrace (available : List Proposition) (steps : List ProofStep) (rules : List Rule) :
    proofIsValid available steps rules = true ↔ AcceptedTrace rules available steps := by
  induction steps generalizing available with
  | nil => exact ⟨fun _ => .done available,fun _ => rfl⟩
  | cons entry rest ih =>
    constructor
    · intro passed
      change (if !entry.premises.all (has available) then false else if !has rules (ruleRecord entry) then false
        else proofIsValid (available ++ [entry.conclusion]) rest rules) = true at passed
      cases hp : entry.premises.all (has available) with
      | false => rw [hp] at passed; cases passed
      | true =>
        rw [hp] at passed
        cases hr : has rules (ruleRecord entry) with
        | false => rw [hr] at passed; cases passed
        | true =>
          rw [hr] at passed
          exact .step (fun p member => (hasIff _ _).mp (allTrueAtMember _ _ hp p member))
            ((hasIff _ _).mp hr) ((ih _).mp passed)
    · intro trace
      cases trace with
      | step premises registered tail =>
        have hp := (allTrueIffMembers _ _).mpr (fun p member => (hasIff _ _).mpr (premises p member))
        have hr := (hasIff _ _).mpr registered
        change (if !entry.premises.all (has available) then false else if !has rules (ruleRecord entry) then false
          else proofIsValid (available ++ [entry.conclusion]) rest rules) = true
        rw [hp,hr]
        exact (ih _).mpr tail

theorem traceSound (rules : List Rule) (property : Proposition → Prop)
    (ruleSound : ∀ record, record ∈ rules → (∀ premise, premise ∈ record.2.1 → property premise) → property record.2.2)
    (available : List Proposition) (steps : List ProofStep)
    (trace : AcceptedTrace rules available steps)
    (premisesSound : ∀ premise, premise ∈ available → property premise) :
    ∀ result, result ∈ afterSteps available steps → property result := by
  induction trace with
  | done available => exact premisesSound
  | @step available entry rest premises registered tail ih =>
    apply ih
    intro proposition member
    cases memAppendCases proposition available [entry.conclusion] member with
    | inl old => exact premisesSound proposition old
    | inr new =>
      cases new with
      | head => exact ruleSound (ruleRecord entry) registered (fun p hp => premisesSound p (premises p hp))
      | tail _ impossible => cases impossible

theorem checkedProofSound (rules : List Rule) (property : Proposition → Prop)
    (ruleSound : ∀ record, record ∈ rules → (∀ premise, premise ∈ record.2.1 → property premise) → property record.2.2)
    (available : List Proposition) (steps : List ProofStep)
    (valid : proofIsValid available steps rules = true)
    (premisesSound : ∀ premise, premise ∈ available → property premise) :
    ∀ result, result ∈ afterSteps available steps → property result :=
  traceSound rules property ruleSound available steps ((checkerIffTrace _ _ _).mp valid) premisesSound

theorem consistentMeaning (admitted : List Proposition) :
    consistent admitted = true ↔ ∀ proposition, proposition ∈ admitted → ¬ denied proposition ∈ admitted := by
  constructor
  · intro h proposition member
    exact (absentIff _ _).mp ((notTrue _).mp (allTrueAtMember _ _ h proposition member))
  · intro h
    apply (allTrueIffMembers _ _).mpr
    intro proposition member
    rw [(absentIff _ _).mpr (h proposition member)]
    rfl

theorem opposingPairRejected (admitted : List Proposition) (proposition : Proposition)
    (held : proposition ∈ admitted) (opposed : denied proposition ∈ admitted) : consistent admitted = false := by
  cases h : consistent admitted with
  | false => rfl
  | true => exact False.elim (((consistentMeaning _).mp h) proposition held opposed)

theorem grammarCompletenessMeaning (generated decided : List Proposition) :
    grammarComplete generated decided = true ↔ distinct generated = true ∧
      ∀ proposition, proposition ∈ generated → proposition ∈ decided ∨ denied proposition ∈ decided := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    refine ⟨p.1,?_⟩
    intro proposition member
    have decision := allTrueAtMember _ _ p.2 proposition member
    cases first : has decided proposition with
    | true => exact Or.inl ((hasIff _ _).mp first)
    | false => rw [first] at decision; exact Or.inr ((hasIff _ _).mp decision)
  · intro h
    apply (andTrue _ _).mpr
    refine ⟨h.1,(allTrueIffMembers _ _).mpr ?_⟩
    intro proposition member
    cases h.2 proposition member with
    | inl held => rw [(hasIff _ _).mpr held]; rfl
    | inr deniedHeld => rw [(hasIff _ _).mpr deniedHeld]; cases has decided proposition <;> rfl

theorem emptyProofValid (premises : List Proposition) (rules : List Rule) : proofIsValid premises [] rules = true := rfl

theorem emptyGrammarComplete (decided : List Proposition) : grammarComplete [] decided = true := rfl

end SFT.Mathematics.LogicInference
