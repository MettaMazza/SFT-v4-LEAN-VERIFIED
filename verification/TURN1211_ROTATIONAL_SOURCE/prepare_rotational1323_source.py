from pathlib import Path
p=Path('work/turn1064_recovery/SFT/Chemistry');s=(p/'VibrationalFrequencySource.lean').read_text().replace('VibrationalFrequency','RotationalConstant').replace('PROP-009','PROP-010').replace('p.current.length==9','p.current.length==6')
a=s.index('structure Surface');b=s.index('structure Target',a)
s=s[:a]+'''def signedInteger (s : String) : Bool := match Text.chars s with
 | [] => false
 | c::rest => if c=='-' then !rest.isEmpty && rest.all ElectronSpinHtml.decimal
  else (c::rest).all ElectronSpinHtml.decimal
def sourceStep (prior : List (List String)) (cells : List String) : Except String (List (List String)) := do
 let name := cells.headD ""
 let charge := (cells.drop 1).headD ""
 let species := (cells.drop 2).headD ""
 if name.isEmpty || species.isEmpty || !signedInteger charge then return prior
 if !((cells.drop 3).all fun value => value.isEmpty || decimal value) then
  throw "PROP-010 source contains a non-exact rotational inscription"
 pure (prior++[cells])
def snapshotRows (snapshot : Snapshot) : Except String (List (List String)) := do
 let rows ← (tableRows snapshot.events).foldl (fun acc cells => do sourceStep (← acc) cells) (.ok [])
 if rows.length != 1005 then throw (Text.append "PROP-010 displayed molecular-row count changed: " (toString rows.length))
 pure rows
'''+s[b:]
a=s.index('def sourceRows');s=s[:a]+'''def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (identityDocument targets primary : Value)
 (listSnapshot choiceSnapshot snapshot : Snapshot) : Except String (List Target) := do
 let _ ← [(listSnapshot.bytes,listSnapshotPath,listSnapshotHash),(choiceSnapshot.bytes,choiceSnapshotPath,choiceSnapshotHash),
  (snapshot.bytes,snapshotPath,snapshotHash),(primaryBytes,primaryPath,primaryHash),
  (targetBytes,targetPath,targetHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "PROP-010 registered source changed: " path)
  pure ()
 let rows ← RunningConvergenceMeasurement.array (get targets "rows")
 let counts : List (String × Int) := [("complete_listed_species_count",2186),
  ("complete_unique_formula_composition_query_count",1193),("complete_returned_charge_state_choice_count",1832),
  ("complete_listed_composition_without_returned_choice_count",83),("complete_displayed_molecular_row_count",1005),
  ("complete_displayed_axis_cell_count",3015),("experimental_measurement_present_count",1681),
  ("experimental_measurement_absent_count",1334)]
 let batches ← RunningConvergenceMeasurement.array (get primary "retrieval_batches")
 if !sameValue (get primary "schema") (.text "sft-v3-nist-cccbdb-rotational-constant-primary-records/1") ||
  !(counts.all fun (key,n) => sameValue (get primary key) (.integer n)) ||
  !sameValue (get primary "all_rows_and_axis_absences_preserved") (.boolean true) || batches.length != 6 ||
  !sameValue (get primary "rows") (.array rows) ||
  !sameValue (get targets "schema") (.text "sft-v3-rotational-constant-withheld-measurements/1") ||
  !sameValue (get targets "release_requires_prediction_seal") (.boolean true) ||
  !sameValue (get targets "all_rows_and_axis_absences_preserved") (.boolean true) ||
  !sameValue (get targets "complete_row_count") (.integer 3015) || rows.length != 3015 then
  throw "PROP-010 complete source surface changed"
 let ids ← identities identityBytes identityDocument
 let sources ← snapshotRows snapshot
 let expanded := sources.zipIdx.flatMap fun (cells,index) =>
  ["A","B","C"].zipIdx.map fun (axis,axisIndex) => (cells,index+1,axis,axisIndex+1)
 ((ids.zip rows).zip expanded).mapM fun ((id,row),(cells,molecularOrdinal,axis,axisOrdinal)) => do
  let name := cells.headD ""
  let charge := (cells.drop 1).headD ""
  let species := (cells.drop 2).headD ""
  let inscription := (cells.drop (2+axisOrdinal)).headD ""
  let present := !inscription.isEmpty
  let value ← if present then field row "exact_positive_axis_recurrence_ratio_per_centimeter" >>= pair
   else pure (.emptyOne "empty-One")
  let targetId ← field row "target_id" >>= text
  let molecular ← field id "displayed_molecular_row" >>= JointCorrelationTargets.integer
  let axisCount ← field id "displayed_axis_ordinal" >>= JointCorrelationTargets.integer
  if !sameValue (get id "target_id") (get row "target_id") ||
   molecular != Int.ofNat molecularOrdinal || axisCount != Int.ofNat axisOrdinal ||
   !sameValue (get id "name") (.text name) || !sameValue (get id "species") (.text species) ||
   !sameValue (get id "external_charge_inscription") (.text charge) ||
   !sameValue (get id "axis_label") (.text axis) ||
   !sameValue (get row "measurement_present") (.boolean present) ||
   !sameValue (get row "rotational_constant_inscription_cm_inverse") (if present then .text inscription else .null) then
   throw (Text.append "PROP-010 source reconstruction differs: " targetId)
  pure ⟨targetId,row,value⟩
end SFT.Chemistry.RotationalConstantSource
'''
(p/'RotationalConstantSource.lean').write_text(s)
