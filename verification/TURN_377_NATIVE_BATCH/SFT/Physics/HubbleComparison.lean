import SFT.Physics.HubbleExperiment
namespace SFT.Physics.HubbleComparison
open ObservationCarrier SFT.Host SFT.Host.Canonical
-- Released values here are the canonical representations of source HeldLabel records.
-- This adapter does not identify arbitrary Python dictionaries with HeldLabel objects.
def lookup (key : String) : List (String × Value) → Option Value
 | [] => none
 | (name,value)::rest => if Text.equal key name then some value else lookup key rest

def releasedLabel (key : String) (released : List (String × Value)) : Except String String :=
 match lookup key released with
 | none => .error (Text.append "KeyError: " key)
 | some (.object fields) =>
   match lookup "label" fields with
   | some (.text label) => .ok label
   | some (.object _) | some (.array _) | some (.boolean _) | some (.integer _) | some .null | none =>
      .error "AttributeError: released target has no label"
 | some (.text _) | some (.array _) | some (.boolean _) | some (.integer _) | some .null =>
    .error "AttributeError: released target has no label"

def compareRows (prediction : String) (released : List (String × Value)) :
    List ExternalTargetRow → Except String (List Comparison)
 | [] => .ok []
 | row::rest => do
   let observed ← releasedLabel row.targetId released
   let tail ← compareRows prediction released rest
   .ok (compareRow prediction row observed :: tail)

theorem completeRowsRetained (prediction : String) (released : List (String × Value))
    (rows : List ExternalTargetRow) (comparisons : List Comparison)
    (success : compareRows prediction released rows = .ok comparisons) :
    comparisons.map Comparison.targetId = rows.map ExternalTargetRow.targetId := by
  induction rows generalizing comparisons with
  | nil => cases success; rfl
  | cons row rest ih =>
    cases found : releasedLabel row.targetId released with
    | error reason => rw [compareRows,found] at success; cases success
    | ok observed =>
      rw [compareRows,found] at success
      dsimp only [Bind.bind,Except.bind] at success
      cases tail : compareRows prediction released rest with
      | error reason => rw [tail] at success; cases success
      | ok retained =>
        rw [tail] at success
        cases success
        change row.targetId :: retained.map Comparison.targetId = row.targetId :: rest.map ExternalTargetRow.targetId
        rw [ih retained tail]

def comparisonValue (row : Comparison) : Value := .object [
 ("target_id",.text row.targetId),("source_id",.text row.sourceId),("source_locator",.text row.sourceLocator),
 ("predicted",.text row.predicted),("observed",.text row.observed),("passed",.boolean row.passed)]
def controlValue (prediction : String) : Value := .object [
 ("target_id",.text "deliberately-tampered-unfavorable-control"),("predicted",.text prediction),
 ("observed",.text "changed-external-observation"),("passed",.boolean (tamperedControlPassed prediction))]
def accepted (prediction : String) (rows : List Comparison) : Bool :=
  allPassed rows && tamperedControlPassed prediction

theorem acceptanceRequiresAllRows (prediction : String) (rows : List Comparison)
    (passed : accepted prediction rows = true) : ∀ row ∈ rows, row.passed = true := by
  apply acceptedRowsAllPass rows
  unfold accepted at passed
  cases all : allPassed rows with
  | false => rw [all] at passed; cases passed
  | true => rfl

theorem missingRowRejects (prediction : String) (released : List (String × Value))
    (row : ExternalTargetRow) (rest : List ExternalTargetRow) (missing : lookup row.targetId released = none) :
    compareRows prediction released (row::rest) = .error (Text.append "KeyError: " row.targetId) := by
  unfold compareRows releasedLabel
  rw [missing]
  rfl

theorem registeredComparisons :
    (compareRows HubbleExperiment.expectedLabel HubbleExperiment.targets HubbleExperiment.targetRows).map
      (fun rows => rows.map Comparison.passed) = .ok [true,true] := rfl

def message (row : Comparison) : String := Text.intercalate "" [row.targetId,": predicted ",row.predicted,
 "; observed ",row.observed,"; exact match ",if row.passed then "True" else "False"]
def sourceIds : List Comparison → List String
 | [] => []
 | row::rest => row.sourceId :: (sourceIds rest).filter (fun s => !Text.equal s row.sourceId)
end SFT.Physics.HubbleComparison
