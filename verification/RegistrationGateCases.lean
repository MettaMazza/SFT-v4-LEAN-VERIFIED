import SFT
open SFT.Engine SFT.Host.Canonical

def emit (r : ClaimRegistration) (known : Bool) (e : Option String) : IO Unit :=
  IO.println (render (.array ((registrationViolations
    (fun id => known && SFT.Host.Text.equal id "a") r e).map Value.text)))

def main : IO Unit := do
  let good := "sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  let other := "sha256:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
  let base := SFT.Foundation.Root.Evidence.registrationData good
  for id in [rootTheoremId,"downstream"] do
    for roots in [[],[rootTheoremId],["other"],[rootTheoremId,rootTheoremId]] do
      for deps in [[],["a"],["b","a"],["a","a"],["β","α","a"],["β","β","a"]] do
        for known in [false,true] do
          emit {base with claimId := id, rootTheorems := roots, dependencies := deps} known none
  for axioms in [[],["injected"]] do
    for params in [[],["fitted"]] do
      for provenance in [[],[ProvenanceClass.directForcing],[.forwardForcing,.constitutionalRelation,.observationalDerivation]] do
        for source in [good,"bad",other] do
          for executed in [none,some good,some "invalid",some other] do
            emit {base with axioms := axioms,freeParameters := params,provenance := provenance,sourceHash := source} false executed
  for mode in [EvidenceMode.formal,.empirical] do
    for mask in List.range 16 do
      let r := {base with
        evidenceMode := mode
        claimId := if mask % 2 == 1 then " \t" else base.claimId
        title := if mask / 2 % 2 == 1 then "" else base.title
        branch := if mask / 4 % 2 == 1 then "\n" else base.branch
        statement := if mask / 8 % 2 == 1 then " " else base.statement}
      emit r false none
