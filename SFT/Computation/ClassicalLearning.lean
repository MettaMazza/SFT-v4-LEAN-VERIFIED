import SFT.Computation.Generalization
namespace SFT.Computation.ClassicalLearning
open SFT.Computation.ClassificationPrediction
open SFT.Mathematics.DiscreteObjects
abbrev Model := Generalization.Model
structure Report where
  inferred : Except String (List String)
  targets : List Target
  predictions : List (String × Except String String)
  passed : Bool
  resources : List (String × Nat)

def inference (m : Model) := Inference.consistentHypotheses m.training.examples m.training.hypotheses
def predictionLedger (m : Model) : List (String × Except String String) :=
  m.withheld.map (fun input => (input,predict m.training m.sealed input))
def resources (m : Model) : List (String × Nat) :=
  [("examples",m.training.examples.length),("hypotheses",m.training.hypotheses.length),
   ("withheld",m.withheld.length),("targets",(Generalization.targetRows m).length)]
def report (m : Model) : Report :=
  ⟨inference m,Generalization.targetRows m,predictionLedger m,Generalization.passes m,resources m⟩

theorem inferenceExact (m : Model)
    (unique : distinct (m.training.hypotheses.map Prod.fst) = true)
    (nonempty : (m.training.examples.isEmpty || m.training.hypotheses.isEmpty) = false) :
    (report m).inferred = .ok ((Inference.retained m.training.examples m.training.hypotheses).map Prod.fst) :=
  Inference.executableOutput _ _ unique nonempty

theorem sealedSource (m : Model) : m.sealed.hypothesis ∈ m.training.hypotheses ∧
    ∀ e, e ∈ m.training.examples → e ∈ m.sealed.hypothesis.2 :=
  (Inference.retainedMeaning _ _ _).mp m.sealed.retained

theorem evaluationExact (m : Model) : (report m).passed = true ↔
    ∀ t, t ∈ (report m).targets → predict m.training m.sealed t.input = .ok t.label := Generalization.exactPass _

theorem completePredictionLedger (m : Model) (input : String) :
    (input,predict m.training m.sealed input) ∈ (report m).predictions ↔ input ∈ m.withheld := by
  constructor
  · intro held
    obtain ⟨original,member,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ held
    have identity := congrArg Prod.fst same
    dsimp only at identity
    cases identity
    exact member
  · intro held; exact SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held

theorem everyHeldTarget (m : Model) (passed : (report m).passed = true) (input : String) (held : input ∈ m.withheld) :
    ∃ t, t ∈ m.targets ∧ t.input = input ∧ predict m.training m.sealed input = .ok t.label :=
  Generalization.everyWithheldChecked _ passed _ held

theorem evaluationCustody (m : Model) (input label : String) (held : input ∈ m.withheld) :
    (input,label) ∉ m.training.examples := Generalization.withheldNotTraining _ _ held _
theorem oldPredictionRetained (first second : Model) (inc : Generalization.Extension first second)
    (input : String) (held : input ∈ first.withheld) :
    (input,predict first.training first.sealed input) ∈ (report second).predictions := by
  rw [← inc.predictions]
  exact (completePredictionLedger _ _).mpr (inc.withheld _ held)

theorem earlierFailureRetained (first second : Model) (inc : Generalization.Extension first second)
    (target : Target) (failed : target ∈ Generalization.failures first) : target ∈ Generalization.failures second :=
  Generalization.failureExtension _ _ inc _ failed

theorem enlargedEvaluationChecksOld (first second : Model) (inc : Generalization.Extension first second)
    (passed : (report second).passed = true) (target : Target) (held : target ∈ (report first).targets) :
    predict first.training first.sealed target.input = .ok target.label := Generalization.checkedOldTargets _ _ inc passed _ held

theorem reportReproducible (first second : Model)
    (training : first.training = second.training)
    (hypothesis : first.sealed.hypothesis = second.sealed.hypothesis)
    (withheld : first.withheld = second.withheld) (targets : first.targets = second.targets) : report first = report second := by
  cases first with
  | mk ft fs fw fg fc fh =>
    cases second with
    | mk st ss sw sg sc sh =>
      cases training
      cases fs with
      | mk firstHyp firstHeld =>
        cases ss with
        | mk secondHyp secondHeld =>
          cases hypothesis
          cases withheld
          cases targets
          rfl
end SFT.Computation.ClassicalLearning
