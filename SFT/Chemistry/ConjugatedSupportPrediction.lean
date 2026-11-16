import SFT.Chemistry.ElectronSpinPrediction
namespace SFT.Chemistry.ConjugatedSupportPrediction
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
def expectedLaws : List String := ["complete-connected-molecular-support","two-held-opposed-fold-fibres",
 "complete-shared-centre-incidence-retention","structure-sealed-before-observation"]
def programDocument (rows : List Identity) : J :=
 let indexed := rows.zipIdx 1
 let body := indexed.flatMap fun (row,ordinal) =>
  let stem := numbered "conjugated-support-record-" ordinal
  let identities := (identityValues row).zipIdx 1
  let laws := expectedLaws.zipIdx (1+(identityValues row).length)
  [instruction "label" (Text.append stem "-target") ["target-id",row.targetId]] ++
  (identities.map fun (value,position) => instruction "label" (numbered (Text.append stem "-identity-") position)
   ["registered-source-identity",value]) ++
  (laws.map fun (value,position) => instruction "label" (numbered (Text.append stem "-law-") position)
   ["conjugated-support-law",value]) ++
  [instruction "word" (Text.append stem "-word")
   (["premise"] ++ identities.map (fun (_,position) => numbered (Text.append stem "-identity-") position) ++
    laws.map (fun (_,position) => numbered (Text.append stem "-law-") position))]
 let tableArguments := indexed.flatMap fun (_,ordinal) =>
  let stem := numbered "conjugated-support-record-" ordinal
  [Text.append stem "-target",Text.append stem "-word"]
 .object [("schema",.text "sft-v3-fold-program/1"),
 ("program_id",.text "SFT-EXP-CHEM-CONJUGATED-SUPPORT-001-value-free-vector"),
 ("instructions",.array ([instruction "input" "premise" ["registered-premise"]] ++ body ++
 [instruction "table" "complete-conjugated-support-vector" tableArguments,
 instruction "emit" "" ["complete-conjugated-support-vector"]]))]
#print axioms identityValues
#print axioms expectedLaws
#print axioms programDocument
end SFT.Chemistry.ConjugatedSupportPrediction
