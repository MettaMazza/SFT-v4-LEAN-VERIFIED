-- OperationalChemistrySpec.validate, preserving the original guard order.
def validateSpec (identity : String) (parents : List String)
 (axes : List (String × List (String × Bool))) (operational : List Bool) : Except String Unit := do
 if !(SFT.Host.Text.chars "SFT-CHEM-").isPrefixOf (SFT.Host.Text.chars identity) || parents.isEmpty then
  throw "operational Chemistry specification has invalid identity"
 if axes.length != 8 || !SFT.Mathematics.DiscreteObjects.distinct (axes.map Prod.fst) then
  throw "operational Chemistry specification requires eight distinct axes"
 if axes.any (fun axis => axis.2.length != 2) then throw "operational dimensions must be binary"
 let _ ← axes.mapM fun axis => do
  if (axis.2.filter Prod.snd).length != 1 then throw (SFT.Host.Text.intercalate "" ["dimension ",axis.1," requires one preserving form"])
 if operational.isEmpty || !operational.all id then throw "operational Chemistry witness failed"
 return ()
def registeredSpecValid : Except String Unit := validateSpec claimId dependencies [("description",[("different-classical-and-quantum-chemistries",false),("common-generated-molecular-description",true)]),("embedding",[("lossy-classical-reencoding",false),("singleton-branch-classical-embedding",true)]),("reversibility",[("hidden-irreversible-predecessor",false),("reversible-classical-transition-submodel",true)]),("quantum",[("selected-branch-execution",false),("complete-branchwise-quantum-execution",true)]),("chemistry",[("mode-specific-transition-law",false),("one-admitted-chemical-transition-law",true)]),("observation",[("result-without-shared-decoder",false),("shared-chemical-decoder-and-record",true)]),("result",[("one-way-result-simulation",false),("bidirectional-result-and-inverse-preservation",true)]),("resource",[("uncounted-correspondence-overhead",false),("exact-positive-overhead-ledger",true)])] [MolecularCorrespondence.branchwiseWitness.toOption.getD false,
 MolecularCorrespondence.inverseWitness.toOption.getD false,MolecularCorrespondence.recordWitness.toOption.getD false]
theorem registeredSpecPassed : registeredSpecValid = .ok () := rfl
