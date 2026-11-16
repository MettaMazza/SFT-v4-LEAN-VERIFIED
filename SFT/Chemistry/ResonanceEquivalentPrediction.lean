import SFT.Chemistry.ElectronSpinPrediction
namespace SFT.Chemistry.ResonanceEquivalentPrediction
open SFT.Host ElectronSpinPrediction
abbrev J := Canonical.Value
-- Values are the source's str conversions in IDENTITY_KEYS order.
structure Identity where
 targetId : String
 sourceRecordOrdinal : String
 sourceId : String
 authority : String
 registeredIdentity : String
 sourceRecordRole : String
 custodyClass : String

def identityValues (row : Identity) : List String :=
 [row.sourceRecordOrdinal,row.sourceId,row.authority,row.registeredIdentity,row.sourceRecordRole,row.custodyClass]
def expectedLaws : List String := ["one-complete-molecular-carrier","multiple-formal-encodings",
 "complete-fold-fibre-complement","representation-not-equilibrium-or-species"]
def programDocument (rows : List Identity) : J :=
 let indexed := rows.zipIdx 1
 let body := indexed.flatMap fun (row,ordinal) =>
  let stem := numbered "resonance-equivalence-record-" ordinal
  let identities := (identityValues row).zipIdx 1
  let laws := expectedLaws.zipIdx (1+(identityValues row).length)
  [instruction "label" (Text.append stem "-target") ["target-id",row.targetId]] ++
  (identities.map fun (value,position) => instruction "label" (numbered (Text.append stem "-identity-") position)
   ["registered-source-identity",value]) ++
  (laws.map fun (value,position) => instruction "label" (numbered (Text.append stem "-law-") position)
   ["representation-law",value]) ++
  [instruction "word" (Text.append stem "-word")
   (["premise"] ++ identities.map (fun (_,position) => numbered (Text.append stem "-identity-") position) ++
    laws.map (fun (_,position) => numbered (Text.append stem "-law-") position))]
 let tableArguments := indexed.flatMap fun (_,ordinal) =>
  let stem := numbered "resonance-equivalence-record-" ordinal
  [Text.append stem "-target",Text.append stem "-word"]
 .object [("schema",.text "sft-v3-fold-program/1"),
 ("program_id",.text "SFT-EXP-CHEM-RESONANCE-EQUIVALENT-REPRESENTATION-002-value-free-vector"),
 ("instructions",.array ([instruction "input" "premise" ["registered-premise"]] ++ body ++
 [instruction "table" "complete-representation-vector" tableArguments,
 instruction "emit" "" ["complete-representation-vector"]]))]
#print axioms identityValues
#print axioms expectedLaws
#print axioms programDocument
end SFT.Chemistry.ResonanceEquivalentPrediction
