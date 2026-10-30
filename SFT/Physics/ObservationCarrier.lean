import SFT.Physics.CapabilityDocuments
namespace SFT.Physics.ObservationCarrier
-- measurement_laws.py: the One witness and generated successor retain named pairings.
def onePair : List (String × String) := [("observation", "reference")]
def appendPair (prior : List (String × String)) (observation reference : String) :=
  prior ++ [(observation, reference)]
theorem oneReferencePair : onePair.length = 1 := rfl
theorem successorRetainsPrior (prior : List (String × String)) (observation reference : String) :
    (appendPair prior observation reference).take prior.length = prior := by
  induction prior with
  | nil => rfl
  | cons first rest ih =>
    change first :: (appendPair rest observation reference).take rest.length = first :: rest
    rw [ih]
theorem successorAddsOne (prior : List (String × String)) (observation reference : String) :
    (appendPair prior observation reference).length = prior.length + 1 := by
  induction prior with
  | nil => rfl
  | cons first rest ih =>
    change (appendPair rest observation reference).length + 1 = (rest.length + 1) + 1
    rw [ih]
-- generated_empirical_law.py: original comparison fields, after release and label extraction.
structure ExternalTargetRow where
  targetId : String
  sourceId : String
  sourceLocator : String
  observedLabel : String
structure Comparison where
  targetId : String
  sourceId : String
  sourceLocator : String
  predicted : String
  observed : String
  passed : Bool

def compareRow (prediction : String) (row : ExternalTargetRow) (releasedLabel : String) : Comparison :=
  ⟨row.targetId, row.sourceId, row.sourceLocator, prediction, releasedLabel,
    decide (prediction = releasedLabel)⟩
theorem comparisonRetainsCoordinates (prediction : String) (row : ExternalTargetRow) (releasedLabel : String) :
    (compareRow prediction row releasedLabel).targetId = row.targetId ∧
    (compareRow prediction row releasedLabel).sourceId = row.sourceId ∧
    (compareRow prediction row releasedLabel).sourceLocator = row.sourceLocator ∧
    (compareRow prediction row releasedLabel).predicted = prediction ∧
    (compareRow prediction row releasedLabel).observed = releasedLabel :=
  ⟨rfl,rfl,rfl,rfl,rfl⟩
theorem comparisonPassesExactly (prediction : String) (row : ExternalTargetRow) (releasedLabel : String) :
    (compareRow prediction row releasedLabel).passed = true ↔ prediction = releasedLabel := by
  change decide (prediction = releasedLabel) = true ↔ prediction = releasedLabel
  exact ⟨of_decide_eq_true, fun equal => decide_eq_true equal⟩

def tamperedControlPassed (prediction : String) : Bool :=
  decide (prediction ≠ "changed-external-observation")
theorem tamperedControlRejectsChanged : tamperedControlPassed "changed-external-observation" = false := by decide

def allPassed (rows : List Comparison) : Bool := rows.all (fun row => row.passed)
theorem acceptedRowsAllPass (rows : List Comparison) (accepted : allPassed rows = true) :
    ∀ row ∈ rows, row.passed = true := by
  induction rows with
  | nil => intro row membership; cases membership
  | cons first rest ih =>
    change (first.passed && allPassed rest) = true at accepted
    have both : first.passed = true ∧ allPassed rest = true := by
      cases firstValue : first.passed <;> cases restValue : allPassed rest <;>
        first | exact ⟨rfl, rfl⟩ | simp only [firstValue, restValue, Bool.false_and, Bool.true_and] at accepted; cases accepted
    intro row membership
    cases membership with
    | head => exact both.1
    | tail _ membership => exact ih both.2 row membership
end SFT.Physics.ObservationCarrier
