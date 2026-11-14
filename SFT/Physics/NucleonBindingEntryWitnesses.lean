import SFT.Physics.NucleonBindingRoots
namespace SFT.Physics.NucleonBindingEntryWitnesses
open NucleonBinding LeptonIntervals VacuumLedgerProofs
structure Witness where
 name : String
 statement : String
 passed : Bool
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def colourCheck : Bool := match colourCycle with
 | .error _ => false
 | .ok rows => rows == [normalize 1 7 (by decide),normalize 2 7 (by decide),normalize 4 7 (by decide)]
def wordsCheck : Bool := match nucleonFlavourWords with
 | .error _ => false
 | .ok words => words == (["up","up","down"],["up","down","down"])
def ledgerCheck : Bool := match nucleonMassLedger with
 | .error _ => false
 | .ok ledger => ledger.bare == normalize 1 128 (by decide) && ledger.heldCycle == normalize 127 128 (by decide)
def dominanceCheck : Bool := match nucleonMassLedger with
 | .error _ => false
 | .ok ledger => ledger.bare.blt (normalize 1 100 (by decide)) && (normalize 99 100 (by decide)).blt ledger.heldCycle
def orderingCheck : Bool := match NucleonBindingRoots.neutronProtonOrderCertificate with
 | .error _ => false
 | .ok cert => (normalize 1 1000 (by decide)).blt cert.netNeutronSurplusLower
def witnesses : List Witness := [⟨"colour-One","The complete generated colour cycle sums to the One.",colourCheck⟩,⟨"nucleon-words","Complete positive count splits force uud charged and udd neutral.",wordsCheck⟩,⟨"mass-ledger","One depth-seven cell and its positive predecessor close the whole mass ledger.",ledgerCheck⟩,⟨"dominance","The exact bare share is below one percent and held share above ninety-nine percent.",dominanceCheck⟩,⟨"ordering","The exact light-flavour surplus remains positive after the admitted proton dressing.",orderingCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.NucleonBindingEntryWitnesses
