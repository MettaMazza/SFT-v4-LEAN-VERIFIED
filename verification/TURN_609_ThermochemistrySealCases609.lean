import SFT.Chemistry.ThermochemistrySealInputs
open SFT.Host SFT.Host.Canonical SFT.Chemistry

def setField : Value → String → Value → Value
 | .object fields,k,v => .object (fields.map fun (name,x) => (name, if Text.equal name k then v else x))
 | v,_,_ => v

def reseal (v : Value) := setField v "sealed_payload_hash" (.text (identity (ThermochemistrySeal.removeClaimedHash v)))
def main : IO Unit := do
 let original := ThermochemistrySealInputs.sealedRecord
 let cases := [(ThermochemistrySealInputs.derivation,original),
 ("changed",original),
 (ThermochemistrySealInputs.derivation,setField original "external_target_content_opened" (.boolean true)),
 (ThermochemistrySealInputs.derivation,setField original "claim_predictions" (.array [])),
 (ThermochemistrySealInputs.derivation,reseal (setField original "external_source_identities_selected" (.boolean true)))]
 for (source,record) in cases do
  IO.println (match ThermochemistrySeal.validate source.toUTF8 record with | .ok _ => "ok" | .error _ => "rejected")
