import SFT.Chemistry.DihedralTorsionEvidence
import SFT.Chemistry.BondDissociationEnergyExperiment
namespace SFT.Chemistry.DihedralTorsionExperiment
open SFT.Host SFT.Host.Canonical DihedralTorsion
open SFT.Physics.CapabilityValues (PositiveCount)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev instruction := BondDissociationEnergyExperiment.instruction
def claimId : String := "SFT-CHEM-DIHEDRAL-TORSIONAL-STATE-004"
def experimentId : String := "SFT-EXP-CHEM-DIHEDRAL-TORSIONAL-STATE-004"
def frozenRelation : String := "A molecular dihedral is an ordered four-site periodic carrier with held orientation, not a signed continuum scalar. At the registered 24-sector resolution, structural EmptyOne, each positive sector successor and recurrent One exactly generate the coordinate cycle. Complete cyclic neighbour order forces conformer minima and barriers; each barrier magnitude is the ordered positive Take to its adjacent conformer. The coordinate and operation seal before all fifty NIST angle and energy rows open."
def falsification : String := "The claim fails if any of fifty post-seal source angles differs from its generated EmptyOne/sector-part/recurrent-One coordinate; if a conformer or barrier fails complete cyclic neighbour order; if any barrier Take is non-positive or loses an adjacent minimum; if either ordered four-atom carrier, rotor, orientation, source condition, ordinary row, least-state row or energy-unit inscription is erased; if any source value is readable before sealing; or if a signed, continuum, fitted or selected-row form is admitted."
def identityPath : String := "experiments/external_sources/chemistry/dihedral_torsion_target_identities_v1.json"
def identityHash : String := "sha256:64ce9b81aa4a979092d9af0dcce852dc72d5b0d52ad3392c0112678268154182"
def targetPath : String := "experiments/external_sources/chemistry/dihedral_torsion_withheld_targets_v1.json"
def targetHash : String := "sha256:89218d8bd40d6cc4a822cb3bb0745d8f6f7a7fe78b219022b735ef5bb513ea1e"
def targetIds : List String := ["ethanol-torsion-1-sector-01","ethanol-torsion-1-sector-02","ethanol-torsion-1-sector-03","ethanol-torsion-1-sector-04","ethanol-torsion-1-sector-05","ethanol-torsion-1-sector-06","ethanol-torsion-1-sector-07","ethanol-torsion-1-sector-08","ethanol-torsion-1-sector-09","ethanol-torsion-1-sector-10","ethanol-torsion-1-sector-11","ethanol-torsion-1-sector-12","ethanol-torsion-1-sector-13","ethanol-torsion-1-sector-14","ethanol-torsion-1-sector-15","ethanol-torsion-1-sector-16","ethanol-torsion-1-sector-17","ethanol-torsion-1-sector-18","ethanol-torsion-1-sector-19","ethanol-torsion-1-sector-20","ethanol-torsion-1-sector-21","ethanol-torsion-1-sector-22","ethanol-torsion-1-sector-23","ethanol-torsion-1-sector-24","ethanol-torsion-1-sector-25","ethanol-torsion-2-sector-01","ethanol-torsion-2-sector-02","ethanol-torsion-2-sector-03","ethanol-torsion-2-sector-04","ethanol-torsion-2-sector-05","ethanol-torsion-2-sector-06","ethanol-torsion-2-sector-07","ethanol-torsion-2-sector-08","ethanol-torsion-2-sector-09","ethanol-torsion-2-sector-10","ethanol-torsion-2-sector-11","ethanol-torsion-2-sector-12","ethanol-torsion-2-sector-13","ethanol-torsion-2-sector-14","ethanol-torsion-2-sector-15","ethanol-torsion-2-sector-16","ethanol-torsion-2-sector-17","ethanol-torsion-2-sector-18","ethanol-torsion-2-sector-19","ethanol-torsion-2-sector-20","ethanol-torsion-2-sector-21","ethanol-torsion-2-sector-22","ethanol-torsion-2-sector-23","ethanol-torsion-2-sector-24","ethanol-torsion-2-sector-25"]
structure Rotor where
 index : Nat
 label : String
 atoms : List String
 kind : String
structure Row where
 targetId : String
 rotor : Rotor
 position : PositiveCount
 coordinate : Height
 coordinateForm : String
def rotors : List Rotor :=
 [⟨1,"ethanol-OH-internal-rotation",["1","2","3","4"],"OH"⟩,
 ⟨2,"ethanol-CH3-internal-rotation",["3","2","1","5"],"CH3"⟩]
def structuralRows : Except String (List Row) := do
 let rows ← rotors.mapM fun rotor =>
  (List.range 25).mapM fun index => do
   let position : PositiveCount := ⟨index+1,Nat.zero_lt_succ index⟩
   let coordinate ← generatedCoordinate (.count position) (.count ⟨24,by decide⟩)
   let digits := if position.value<10 then Text.append "0" (toString position.value) else toString position.value
   let target := Text.intercalate "" ["ethanol-torsion-",toString rotor.index,"-sector-",digits]
   let form := if position.value==1 then "structural-EmptyOne-anchor" else if position.value==25 then "recurrent-One" else "positive-exact-turn-part"
   pure (⟨target,rotor,position,coordinate,form⟩ : Row)
 pure rows.flatten
def rowPrefix (ordinal : Nat) := Text.append "torsion-state-" (toString (ordinal+1))
def labels (row : Row) : List (String × String) :=
 [("target-id",row.targetId),("molecular-carrier","ethanol"),
 ("molecular-state","gauche-ethanol-internal-rotation"),("torsion-identity",row.rotor.label),
 ("rotor-type",row.rotor.kind),("held-orientation","source-forward-periodic-order")] ++
 row.rotor.atoms.map (fun atom => ("ordered-torsion-atom",atom)) ++
 [("coordinate-form",row.coordinateForm),("state-law","complete-cyclic-neighbour-order"),
 ("barrier-law","ordered-positive-Take-to-adjacent-conformer")]
def rowInstructions (ordinal : Nat) (row : Row) : Except String (List Value) := do
 let key := rowPrefix ordinal
 let destination := fun n => Text.intercalate "" [key,"-label-",toString (n+1)]
 let indexed := (labels row).zipIdx
 let labelRows := indexed.map fun ((family,label),n) => instruction "label" (destination n) [family,label]
 let positionName := Text.append key "-position"
 let sectorName := Text.append key "-sectors"
 let coordinateName := Text.append key "-coordinate"
 let coordinateInstruction ← match row.coordinate with
  | .emptyOne => pure (instruction "empty_one" coordinateName ["structural-empty-One"])
  | .ratio r => pure (instruction "ratio" coordinateName [toString r.numerator.value,toString r.denominator.value])
  | .otherEmptyOne _ | .invalid => throw "generated torsion coordinate left its source domain"
 let registers := ("premise" :: indexed.map (fun (_,n) => destination n)) ++ [positionName,sectorName,coordinateName]
 pure (labelRows ++ [instruction "count" positionName [toString row.position.value],
  instruction "count" sectorName ["24"],coordinateInstruction,instruction "word" (Text.append key "-word") registers])
def predictionProgramDocument : Except String Value := do
 let rows ← structuralRows
 let indexed := rows.zipIdx
 let instructions ← indexed.mapM fun (row,ordinal) => rowInstructions ordinal row
 let arguments := indexed.flatMap fun (_,ordinal) =>
  [Text.append (rowPrefix ordinal) "-label-1",Text.append (rowPrefix ordinal) "-word"]
 pure (.object [("schema",.text "sft-v3-fold-program/1"),
 ("program_id",.text (Text.append experimentId "-value-free-coordinate-and-operation-prediction")),
 ("instructions",.array ([instruction "input" "premise" ["registered-premise"]] ++ instructions.flatten ++
 [instruction "table" "dihedral-torsion-vector" arguments,instruction "emit" "" ["dihedral-torsion-vector"]]))])
def experimentRegistrationRecord : Except String Value := do
 let document ← predictionProgramDocument
 pure (.object [("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("provenance",.text "observational_derivation"),("frozen_relation",.text frozenRelation),
 ("identity_registry",.array [.text identityPath,.text identityHash]),
 ("withheld_measurement_registry",.array [.text targetPath,.text targetHash]),
 ("prediction_program",document),("target_ids",.array (targetIds.map Value.text)),
 ("all_angle_energy_and_extrema_outcomes_absent_from_prediction",.boolean true),
 ("falsification_condition",.text falsification)])
theorem fiftyRows : structuralRows.map List.length = .ok 50 := rfl
theorem completePredictionConstructed : predictionProgramDocument.isOk = true := rfl
theorem completeRegistrationConstructed : experimentRegistrationRecord.isOk = true := rfl

def expectedLabel : String := "exact-held-dihedral-cycle-conformer-and-positive-barrier-Take"
def dimensions : List (String × List (String × Bool)) := [("carrier",[("unordered-or-three-site-angle",false),("named-ordered-four-site-carrier",true)]),("orientation",[("signed-conventional-angle",false),("held-cycle-orientation",true)]),("coordinate",[("continuum-rotation-coordinate",false),("generated-sector-successor-coordinate",true)]),("state",[("named-conformer-without-neighbours",false),("complete-neighbour-conformer-state",true)]),("barrier",[("imported-saddle-or-signed-difference",false),("local-barrier-and-ordered-positive-Take",true)]),("recurrence",[("duplicated-terminal-configuration",false),("terminal-One-identifies-anchor-class",true)]),("prediction",[("angle-or-energy-target-readable",false),("value-free-coordinate-and-operation-seal",true)]),("record",[("selected-extrema-or-one-rotor",false),("complete-two-rotor-fifty-row-vector",true)])]
def snapshotHashes : List String := ["sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if DihedralTorsionEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !SFT.Physics.CapabilityValues.nonblank expectedLabel || !SFT.Physics.CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([DihedralTorsionWitnesses.coordinateWitness,DihedralTorsionWitnesses.orderWitness,DihedralTorsionWitnesses.transitionsWitness,DihedralTorsionWitnesses.reverseWitness].all id) then throw "Chemistry operational witness failed"
 return ()
theorem registeredSpecValid : validateSpec = .ok () := rfl
end SFT.Chemistry.DihedralTorsionExperiment
