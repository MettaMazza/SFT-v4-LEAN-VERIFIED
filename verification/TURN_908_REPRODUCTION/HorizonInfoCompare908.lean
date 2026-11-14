import SFT.Physics.HorizonInformation
open SFT.Physics SFT.Host.Canonical
def main : IO Unit := do
 match HorizonInformation.horizonInformationLedger with
 | .error message => IO.println (render (.object [("error",.text message)]))
 | .ok r => IO.println (render (.object [("locally_closed_predecessor",.array (r.locallyClosedPredecessor.map (fun _ => .array []))),("retained_boundary_records",.array (r.retainedBoundaryRecords.map (fun row => .array [.text row.1,.integer (.ofNat row.2)]))),("reconstructible_with_complete_inverse_record",.boolean r.reconstructibleWithCompleteInverseRecord)]))
