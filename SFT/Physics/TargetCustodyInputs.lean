import SFT.Physics.TargetCustody
namespace SFT.Physics.TargetCustodyInputs
open SFT.Host.Canonical SFT.Physics.TargetCustody

-- Entries of the source Mapping after canonical value conversion; keys retain
-- their original string/non-string distinction for the source admission check.
def namedTargets : List (Value × Value) → Option (List (String × Value))
 | [] => some []
 | (key,value)::rest => match key with
   | .text name => match namedTargets rest with
     | none => none
     | some rows => some ((name,value)::rows)
   | .boolean _ => none
   | .integer _ => none
   | .null => none
   | .array _ => none
   | .object _ => none

def createVaultInput (experiment custodian : String) (entries : List (Value × Value))
    (nonce expectedEnvelope : String) : Except String Vault :=
  if !SFT.Physics.LeptonPrediction.nonblank experiment || !SFT.Physics.LeptonPrediction.nonblank custodian ||
      !SFT.Physics.LeptonPrediction.nonblank nonce then
    .error "CustodyHalt: target vault requires experiment, custodian and nonce identities"
  else match namedTargets entries with
    | none => .error "CustodyHalt: target vault requires complete named target support"
    | some values => createVault experiment custodian values nonce expectedEnvelope

theorem completeTargetEntries (entries : List (Value × Value)) (values : List (String × Value))
    (accepted : namedTargets entries = some values) :
    values.map (fun row => (Value.text row.1,row.2)) = entries := by
  induction entries generalizing values with
  | nil => cases Option.some.inj accepted; rfl
  | cons entry rest ih =>
    obtain ⟨key,value⟩ := entry
    cases key with
    | text name =>
      unfold namedTargets at accepted
      cases tail : namedTargets rest with
      | none => rw [tail] at accepted; cases accepted
      | some rows =>
        rw [tail] at accepted
        cases Option.some.inj accepted
        change (Value.text name,value) :: rows.map (fun row => (Value.text row.1,row.2)) = _
        rw [ih rows tail]
    | boolean b => cases accepted
    | integer n => cases accepted
    | null => cases accepted
    | array xs => cases accepted
    | object xs => cases accepted

theorem everyNamedPackageAccepted (values : List (String × Value)) :
    namedTargets (values.map (fun row => (Value.text row.1,row.2))) = some values := by
  induction values with
  | nil => rfl
  | cons row rest ih =>
    obtain ⟨name,value⟩ := row
    change (match namedTargets (rest.map (fun row => (Value.text row.1,row.2))) with
      | none => none | some rows => some ((name,value)::rows)) = _
    rw [ih]
end SFT.Physics.TargetCustodyInputs
