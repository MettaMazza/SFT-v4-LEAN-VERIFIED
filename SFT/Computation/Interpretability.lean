import SFT.Computation.SearchPlanning
namespace SFT.Computation.Interpretability
open SFT.Computation.StateTransition
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
structure Model where
  description : String
  system : System
  premises : List String
  decisions : List (String × String)
  counterfactuals : List (String × List String)
structure Certificate where
  description : String
  initial : String
  actions : List String
  trace : List String
  premises : List String
  decision : String

def verify (m : Model) (c : Certificate) : Bool :=
  match run m.system c.initial c.actions with
  | .error _ => false
  | .ok trace => decide (c.description = m.description) && decide (c.trace = trace) &&
      decide (c.premises = m.premises) && has m.decisions (SFT.Computation.SearchPlanning.terminal c.initial trace,c.decision)

theorem verificationMeaning (m : Model) (c : Certificate) : verify m c = true ↔
    c.description = m.description ∧ run m.system c.initial c.actions = .ok c.trace ∧
    c.premises = m.premises ∧ (SFT.Computation.SearchPlanning.terminal c.initial c.trace,c.decision) ∈ m.decisions := by
  unfold verify
  cases execution : run m.system c.initial c.actions with
  | error e =>
    constructor
    · intro bad; cases bad
    · intro h; cases h.2.1
  | ok trace =>
    constructor
    · intro h
      have a := (andTrue _ _).mp h
      have b := (andTrue _ _).mp a.1
      have d := (andTrue _ _).mp b.1
      have same : c.trace = trace := of_decide_eq_true d.2
      refine ⟨of_decide_eq_true d.1,?_,of_decide_eq_true b.2,?_⟩
      · exact congrArg Except.ok same.symm
      · rw [same]; exact (hasIff _ _).mp a.2
    · intro h
      have same : trace = c.trace := Except.ok.inj h.2.1
      exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr
        ⟨decide_eq_true h.1,decide_eq_true same.symm⟩,decide_eq_true h.2.2.1⟩,
        (hasIff _ _).mpr (same.symm ▸ h.2.2.2)⟩

theorem verifiedExecution (m : Model) (c : Certificate) (checked : verify m c = true) :
    c.initial ∈ m.system.states ∧ Execution m.system c.initial c.actions c.trace := by
  have h := (runAdmission _ _ _ _).mp ((verificationMeaning _ _).mp checked).2.1
  exact ⟨h.1,(runFromMeaning _ _ _ _).mp h.2⟩

def counterfactualLedger (m : Model) : List ((String × List String) × Except String (List String)) :=
  m.counterfactuals.map (fun input => (input,run m.system input.1 input.2))
theorem traceTampered (m : Model) (c : Certificate) (actual : List String)
    (ran : run m.system c.initial c.actions = .ok actual) (changed : c.trace ≠ actual) : verify m c = false := by
  cases checked : verify m c with
  | false => rfl
  | true =>
    have p := ((verificationMeaning _ _).mp checked).2.1
    rw [ran] at p
    exact False.elim (changed (Except.ok.inj p).symm)

theorem premiseTampered (m : Model) (c : Certificate) (changed : c.premises ≠ m.premises) : verify m c = false := by
  cases checked : verify m c with
  | false => rfl
  | true => exact False.elim (changed ((verificationMeaning _ _).mp checked).2.2.1)

theorem descriptionTampered (m : Model) (c : Certificate) (changed : c.description ≠ m.description) : verify m c = false := by
  cases checked : verify m c with
  | false => rfl
  | true => exact False.elim (changed ((verificationMeaning _ _).mp checked).1)

theorem counterfactualComplete (m : Model) (input : String × List String) :
    (input,run m.system input.1 input.2) ∈ counterfactualLedger m ↔ input ∈ m.counterfactuals := by
  constructor
  · intro held
    obtain ⟨original,member,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ held
    have identity := congrArg Prod.fst same
    dsimp only at identity
    cases identity
    exact member
  · intro held; exact SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held
structure Extension (first second : Model) where
  description : first.description = second.description
  premises : first.premises = second.premises
  admitted : create second.system.states second.system.actions second.system.transitions = .ok second.system
  states : ∀ x, x ∈ first.system.states → x ∈ second.system.states
  rows : ∀ x, x ∈ first.system.transitions → x ∈ second.system.transitions
  decisions : ∀ x, x ∈ first.decisions → x ∈ second.decisions

theorem verifiedExtension (first second : Model) (extension : Extension first second)
    (c : Certificate) (checked : verify first c = true) : verify second c = true := by
  have h := (verificationMeaning _ _).mp checked
  exact (verificationMeaning _ _).mpr ⟨h.1.trans extension.description,
    SFT.Computation.StateExtension.extendRun _ _ extension.admitted extension.states extension.rows _ _ _ h.2.1,
    h.2.2.1.trans extension.premises,extension.decisions _ h.2.2.2⟩

theorem serialCertificate (m : Model) (initial middle last decision : String)
    (left right before after : List String) (held : initial ∈ m.system.states)
    (first : SFT.Computation.StateComposition.Path m.system initial left before middle)
    (second : SFT.Computation.StateComposition.Path m.system middle right after last)
    (decided : (last,decision) ∈ m.decisions) :
    verify m ⟨m.description,initial,left ++ right,(before ++ after) ++ [last],m.premises,decision⟩ = true := by
  apply (verificationMeaning _ _).mpr
  refine ⟨rfl,SFT.Computation.StateComposition.nativeComposition _ _ _ _ _ _ _ _ held first second,rfl,?_⟩
  change (SFT.Computation.SearchPlanning.terminal initial ((before ++ after) ++ [last]),decision) ∈ m.decisions
  rw [SFT.Computation.SearchPlanning.terminalAppend]; exact decided

theorem decisionRejected (m : Model) (c : Certificate)
    (absent : (SFT.Computation.SearchPlanning.terminal c.initial c.trace,c.decision) ∉ m.decisions) : verify m c = false := by
  cases checked : verify m c with
  | false => rfl
  | true => exact False.elim (absent ((verificationMeaning _ _).mp checked).2.2.2)
end SFT.Computation.Interpretability
