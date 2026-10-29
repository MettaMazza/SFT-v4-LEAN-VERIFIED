import SFT.Computation.OrderingTrace
import SFT.Foundation.DerivationTrace
namespace SFT.Computation.ArithmeticTrace
open SFT.Foundation ExactOperations ExactPartCarrier DerivationTrace

inductive Execution : Part → List String → List DerivationRow → Part → Prop where
 | base (initial : Part) : Execution initial [] [] initial
 | next (initial intermediate terminal : Part) (op : String) (ops : List String) (rows : List DerivationRow)
     (step : execute op initial = .ok intermediate)
     (tail : Execution intermediate ops rows terminal) :
     Execution initial (op :: ops) (row op (stepInputs op initial) intermediate :: rows) terminal

theorem generatedExecution (ops : List String) (initial : Part) (rows : List DerivationRow) (terminal : Part)
    (generated : recordFrom initial ops = .ok (rows,terminal)) : Execution initial ops rows terminal := by
  induction ops generalizing initial rows terminal with
  | nil => cases generated; exact .base initial
  | cons op ops ih =>
    cases h : execute op initial with
    | error e => unfold recordFrom at generated; rw [h] at generated; cases generated
    | ok next =>
      cases t : recordFrom next ops with
      | error e => unfold recordFrom at generated; rw [h] at generated; dsimp only at generated; rw [t] at generated; cases generated
      | ok pair =>
        obtain ⟨tail,last⟩ := pair
        unfold recordFrom at generated
        rw [h] at generated; dsimp only at generated; rw [t] at generated
        cases generated
        exact .next _ _ _ _ _ _ h (ih next tail terminal t)

theorem executionGenerates (initial terminal : Part) (ops : List String) (rows : List DerivationRow)
    (trace : Execution initial ops rows terminal) : recordFrom initial ops = .ok (rows,terminal) := by
  induction trace with
  | base => rfl
  | next initial intermediate terminal op ops rows step tail ih =>
    unfold recordFrom; rw [step]; dsimp only; rw [ih]

theorem completeTerminationTrace (initial terminal : Part) (ops : List String) (rows : List DerivationRow)
    (trace : Execution initial ops rows terminal) :
    rows.length = ops.length ∧ rows.map DerivationRow.operation = ops := by
  induction trace with
  | base => exact ⟨rfl,rfl⟩
  | next initial intermediate terminal op ops rows step tail ih =>
    exact ⟨congrArg Nat.succ ih.1,congrArg (List.cons op) ih.2⟩

theorem intermediateIdentities (initial terminal : Part) (ops : List String) (rows : List DerivationRow)
    (trace : Execution initial ops rows terminal) :
    ∀ item, item ∈ rows → item.outputHash = partIdentity item.output := by
  induction trace with
  | base => intro item impossible; cases impossible
  | next initial intermediate terminal op ops rows step tail ih =>
    intro item held
    cases held with
    | head => rfl
    | tail _ member => exact ih item member

theorem everyIntermediateExact (rows : List DerivationRow) (item : DerivationRow) (_held : item ∈ rows) :
    0 < item.output.numerator ∧ item.output.numerator ≤ item.output.denominator ∧
      item.output.numerator.Coprime item.output.denominator :=
  ⟨item.output.positive,item.output.throughOne,item.output.reduced⟩

theorem terminalReconstruction (initial terminal : Part) (ops : List String) (rows : List DerivationRow)
    (trace : Execution initial ops rows terminal) : replayFrom initial rows = .ok terminal :=
  generatedTraceReplays _ _ _ _ (executionGenerates _ _ _ _ trace)

theorem traceComposition (initial middle terminal : Part) (firstOps secondOps : List String)
    (firstRows secondRows : List DerivationRow)
    (first : Execution initial firstOps firstRows middle)
    (second : Execution middle secondOps secondRows terminal) :
    Execution initial (firstOps ++ secondOps) (firstRows ++ secondRows) terminal := by
  induction first with
  | base => exact second
  | next initial next middle op ops rows step tail ih => exact .next _ _ _ _ _ _ step (ih second)

theorem arithmeticSuccessor (initial current next : Part) (ops : List String) (rows : List DerivationRow)
    (prior : Execution initial ops rows current) (op : String) (step : execute op current = .ok next) :
    Execution initial (ops ++ [op]) (rows ++ [row op (stepInputs op current) next]) next :=
  traceComposition _ _ _ _ _ _ _ prior (.next _ _ _ _ _ _ step (.base next))

theorem normalizedIntermediateValue (n d : Nat) (positive : 0 < n) (denominator : 0 < d) :
    n * (normalizePositive n d positive denominator).denominator =
      (normalizePositive n d positive denominator).numerator * d :=
  normalizedValuePreserved _ _ _ _

theorem rejectedFirstOperation (initial : Part) (op : String) (rest : List String) (reason : String)
    (rejected : execute op initial = .error reason) : recordFrom initial (op :: rest) = .error reason := by
  unfold recordFrom; rw [rejected]

theorem structuralOneBase : Execution one [] [] one := .base one

end SFT.Computation.ArithmeticTrace
