import SFT.Chemistry.CoordinationNumber
open SFT.Chemistry.CoordinationNumber SFT.Chemistry.CoordinationEntity SFT.Physics.CapabilityValues
def describe : Except String Record → String
 | .error e => "error:"++e
 | .ok r => String.intercalate "|" [r.entityIdentity.family++":"++r.entityIdentity.label,r.centralOccurrence.family++":"++r.centralOccurrence.label,toString r.positiveDirectIncidenceCount.value,String.intercalate "," (r.orderedIncidenceTraces.map fun x => x.family++":"++x.label)]
def showBool : Except String Bool → String
 | .error e => "error:"++e
 | .ok b => toString b
def main : IO Unit := do
 for n in List.range 25 do
  IO.println (describe (do forcedNumber (← generatedEntity n)))
 for i in List.range 24 do
  let n := i+1
  let e ← IO.ofExcept (generatedEntity n)
  let next ← IO.ofExcept (SFT.Chemistry.CoordinationNumber.generatedAttachment (n+1))
  let skip := {next with sourceOccurrence := ⟨n+2,by omega⟩}
  let other ← IO.ofExcept (heldLabel "coordination-central-occurrence" "other")
  let old ← IO.ofExcept (SFT.Chemistry.CoordinationNumber.generatedAttachment 1)
  for s in [next,skip,{next with centralOccurrence:=other},{next with ligandOccurrence:=old.ligandOccurrence},{next with attachmentTrace:=old.attachmentTrace}] do
   IO.println (showBool (appendIncrements e s))
