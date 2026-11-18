import SFT.Chemistry.InternalEnergyComposition
namespace SFT.Chemistry.HeatWorkTransferPartition
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- Exact source: heat_work_transfer_partition_law_v1.py at
-- 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
structure ChemicalTransferRecord where
 boundary : HeldLabel
 chemicalPath : HeldLabel
 orientation : HeldLabel
 carrierObservation : HeldLabel
 transferClass : HeldLabel
 exactPositiveMagnitude : Ratio
structure ChemicalHeatWorkPartition where
 boundary : HeldLabel
 chemicalPath : HeldLabel
 records : List ChemicalTransferRecord
 heatTotal : Height
 workTotal : Height
 completeTransferTotal : Ratio
def heatClass : HeldLabel := ⟨"chemical-transfer-class","heat-transfer",rfl,rfl⟩
def workClass : HeldLabel := ⟨"chemical-transfer-class","work-transfer",rfl,rfl⟩
def transferClassFromObservation (input : LabelInput) : Except String HeldLabel := do
 let label ← match input with
  | .held label =>
   if Text.equal label.family "transfer-carrier-observation" then pure label
   else throw "transfer carrier requires a held observation class"
  | .other => throw "transfer carrier requires a held observation class"
 if Text.equal label.label "carrier-label-closed-by-receiving-macro-observation" then pure heatClass
 else if Text.equal label.label "organized-source-response-label-retained" then pure workClass
 else throw "unforced transfer carrier observation"
structure RecordFields where
 boundary : LabelInput
 chemicalPath : LabelInput
 orientation : LabelInput
 carrierObservation : LabelInput
 transferClass : LabelInput
 exactPositiveMagnitude : Height
def recordField (input : LabelInput) (family : String) : Except String HeldLabel :=
 match input with
 | .other => .error "chemical transfer record lost a held identity"
 | .held label => if Text.equal label.family family then .ok label
   else .error "chemical transfer record lost a held identity"
def makeRecord (f : RecordFields) : Except String ChemicalTransferRecord := do
 let boundary ← recordField f.boundary "chemical-boundary"
 let path ← recordField f.chemicalPath "chemical-path"
 let orientation ← recordField f.orientation "energy-transfer-orientation"
 let observation ← recordField f.carrierObservation "transfer-carrier-observation"
 let transferClass ← recordField f.transferClass "chemical-transfer-class"
 if !(Text.equal orientation.label "into-held-support" || Text.equal orientation.label "out-of-held-support") then
  throw "transfer direction must remain a held orientation"
 let forced ← transferClassFromObservation (.held observation)
 if !equalLabel transferClass forced then throw "heat/work class was not forced by carrier observation"
 match f.exactPositiveMagnitude with
 | .ratio magnitude => pure ⟨boundary,path,orientation,observation,transferClass,magnitude⟩
 | .emptyOne | .otherEmptyOne _ | .invalid => throw "transfer content must be exact and positive"
def chemicalTransferRecord (boundary path orientation observation : LabelInput) (magnitude : Height) : Except String ChemicalTransferRecord := do
 let forced ← transferClassFromObservation observation
 makeRecord ⟨boundary,path,orientation,observation,.held forced,magnitude⟩
def classTotal (records : List ChemicalTransferRecord) : Height :=
 match records with
 | [] => .emptyOne
 | first::rest => .ratio (rawRatio (rest.foldl
   (fun total record => AlphaRatio.add total (fraction record.exactPositiveMagnitude))
   (fraction first.exactPositiveMagnitude)))
inductive RecordInput where
 | record (value : ChemicalTransferRecord)
 | other
inductive RecordsInput where
 | tuple (values : List RecordInput)
 | other
def partitionChemicalTransfers (input : RecordsInput) : Except String ChemicalHeatWorkPartition := do
 let raw ← match input with
  | .tuple (first::rest) => pure (first::rest)
  | .tuple [] | .other => throw "chemical transfer partition requires a nonempty exact path"
 let records ← raw.mapM fun input => match input with
  | .record value => pure value
  | .other => throw "chemical transfer partition requires a nonempty exact path"
 match records with
 | [] => throw "chemical transfer partition requires a nonempty exact path"
 | first::rest =>
  if records.any (fun record => !equalLabel record.boundary first.boundary || !equalLabel record.chemicalPath first.chemicalPath) then
   throw "one partition cannot merge different boundaries or chemical paths"
  let heat := records.filter fun record => Text.equal record.transferClass.label "heat-transfer"
  let work := records.filter fun record => Text.equal record.transferClass.label "work-transfer"
  if heat.length + work.length != records.length then throw "heat/work partition omitted a transfer record"
  let total := rawRatio (rest.foldl (fun total record => AlphaRatio.add total (fraction record.exactPositiveMagnitude)) (fraction first.exactPositiveMagnitude))
  pure ⟨first.boundary,first.chemicalPath,records,classTotal heat,classTotal work,total⟩
def equalRecord (a b : ChemicalTransferRecord) : Bool :=
 equalLabel a.boundary b.boundary && equalLabel a.chemicalPath b.chemicalPath &&
 equalLabel a.orientation b.orientation && equalLabel a.carrierObservation b.carrierObservation &&
 equalLabel a.transferClass b.transferClass && InternalEnergyComposition.equalRatio a.exactPositiveMagnitude b.exactPositiveMagnitude
def equalRecords : List ChemicalTransferRecord → List ChemicalTransferRecord → Bool
 | [],[] => true
 | first::rest,next::tail => equalRecord first next && equalRecords rest tail
 | [],_::_ | _::_,[] => false
def appendTransferPreservesPartition (input : RecordsInput) (extension : RecordInput) : Except String Bool := do
 let prior ← partitionChemicalTransfers input
 let extension ← match extension with
  | .record value => pure value
  | .other => throw "'NoneType' object has no attribute 'boundary'"
 if !equalLabel extension.boundary prior.boundary || !equalLabel extension.chemicalPath prior.chemicalPath then
  throw "transfer successor changed the held boundary or chemical path"
 let extended ← partitionChemicalTransfers (.tuple ((prior.records++[extension]).map RecordInput.record))
 let expected := rawRatio (AlphaRatio.add (fraction prior.completeTransferTotal) (fraction extension.exactPositiveMagnitude))
 pure (equalRecords (extended.records.take (extended.records.length-1)) prior.records &&
  InternalEnergyComposition.equalRatio extended.completeTransferTotal expected)
def witnessRecord (observation : HeldLabel) (magnitude : Ratio) : Except String ChemicalTransferRecord :=
 chemicalTransferRecord (.held ⟨"chemical-boundary","held-boundary",rfl,rfl⟩)
  (.held ⟨"chemical-path","held-path",rfl,rfl⟩)
  (.held ⟨"energy-transfer-orientation","into-held-support",rfl,rfl⟩) (.held observation) (.ratio magnitude)
def closedObservation : HeldLabel := ⟨"transfer-carrier-observation","carrier-label-closed-by-receiving-macro-observation",rfl,rfl⟩
def retainedObservation : HeldLabel := ⟨"transfer-carrier-observation","organized-source-response-label-retained",rfl,rfl⟩
def firstRecord := witnessRecord closedObservation ⟨⟨2,by decide⟩,⟨3,by decide⟩⟩
def secondRecord := witnessRecord closedObservation ⟨⟨5,by decide⟩,⟨4,by decide⟩⟩
def thirdRecord := witnessRecord retainedObservation ⟨⟨7,by decide⟩,⟨5,by decide⟩⟩
def heatOnly : Except String ChemicalHeatWorkPartition := do
 let first ← firstRecord
 let second ← secondRecord
 partitionChemicalTransfers (.tuple [.record first,.record second])
def complete : Except String ChemicalHeatWorkPartition := do
 let first ← firstRecord
 let second ← secondRecord
 let third ← thirdRecord
 partitionChemicalTransfers (.tuple [.record first,.record second,.record third])
theorem forcedClassesWitness : (do
 let first ← firstRecord
 let third ← thirdRecord
 pure (Text.equal first.transferClass.label "heat-transfer" && Text.equal third.transferClass.label "work-transfer"))=(Except.ok true : Except String Bool) := rfl
theorem disjointCompleteWitness : (do let partition ← complete; pure partition.records.length)=(Except.ok 3 : Except String Nat) := rfl
theorem exactClassTotalsWitness : (do let partition ← complete; pure (partition.heatTotal,partition.workTotal))=
 (Except.ok (.ratio ⟨⟨23,by decide⟩,⟨12,by decide⟩⟩,.ratio ⟨⟨7,by decide⟩,⟨5,by decide⟩⟩) : Except String (Height×Height)) := rfl
theorem structuralAbsenceWitness : (do let partition ← heatOnly; pure partition.workTotal)=(Except.ok .emptyOne : Except String Height) := rfl
theorem completeTotalWitness : (do let partition ← complete; pure partition.completeTransferTotal)=
 (Except.ok ⟨⟨199,by decide⟩,⟨60,by decide⟩⟩ : Except String Ratio) := rfl
theorem appendOnlyWitness : (do
 let first ← firstRecord
 let second ← secondRecord
 let third ← thirdRecord
 appendTransferPreservesPartition (.tuple [.record first,.record second]) (.record third))=.ok true := rfl
end SFT.Chemistry.HeatWorkTransferPartition
