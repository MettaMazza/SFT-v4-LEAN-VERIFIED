import SFT.Foundation.RootEvidence
open SFT.Host SFT.Host.Canonical

def main : IO Unit := do
  for n in [0,1,3,55,56,63,64,65,119,120,127,128,129,255,1000,10000] do
    let bytes := ByteArray.mk ((List.range n).toArray.map fun i => UInt8.ofNat (i * 73 + 19))
    IO.println ("sha\t" ++ toString n ++ "\t" ++ SHA256.digest bytes)
  let samples : List Value := [
    .null, .boolean true, .boolean false, .integer 0, .integer (-12345678901234567890),
    .text "", .text (String.ofList ((List.range 128).map Char.ofNat)),
    .text (String.ofList ([233, 937, 20013, 65535, 65536, 128512, 1114111].map Char.ofNat)),
    .object [("z", .array [.integer 1, .boolean true, .null]), ("a", .text "quote\"slash\\")],
    .object [("Ω", .object [("b", .integer 2), ("a", .integer 1)]), ("Z", .array []), ("é", .text "x")]]
  for v in samples do IO.println ("json\t" ++ render v ++ "\t" ++ identity v)
  match SFT.Foundation.Root.Evidence.decideCandidate "invalid-id" with
  | .error _ => IO.println "unknown-id\trejected"
  | .ok _ => throw (IO.userError "Unknown ID unexpectedly accepted")
  for c in SFT.Foundation.Root.candidates do
    match SFT.Foundation.Root.Evidence.decideCandidate (SFT.Foundation.Root.candidateId c) with
    | .ok _ => pure ()
    | .error e => throw (IO.userError e)
