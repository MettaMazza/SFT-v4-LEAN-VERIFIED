import SFT.Chemistry.ElectrophilicPath
namespace SFT.Chemistry.ElectrophilicWitnesses
open SFT.Host SFT.Physics.CapabilityValues ElectrophilicCarrier ElectrophilicPath
open NucleophilicCarrier (occurrence electron pair bond state electrons sameSet bondAt matchesPair present)
def sourcePaths : Except String (Carrier × ExactExchange × ExactExchange) := do
 let left ← occurrence "aromatic-left"
 let centre ← occurrence "centre"
 let right ← occurrence "aromatic-right"
 let entering ← occurrence "entering-acceptor"
 let leaving ← occurrence "leaving"
 let donor ← pair (← electron "donor-one") (← electron "donor-two")
 let recurrence ← pair (← electron "recurrence-one") (← electron "recurrence-two")
 let displaced ← pair (← electron "leaving-one") (← electron "leaving-two")
 let atoms := [left,centre,right,entering,leaving]
 let donorBond ← bond left centre donor
 let recurrenceBond ← bond centre right recurrence
 let leavingBond ← bond centre leaving displaced
 let enteringBond ← bond centre entering donor
 let restoredBond ← bond left centre displaced
 let source ← state (← heldLabel "substitution-state" "aromatic-source") atoms [donorBond,recurrenceBond,leavingBond] []
 let middle ← state (← heldLabel "substitution-state" "addition-intermediate") atoms [recurrenceBond,leavingBond,enteringBond] []
 let terminal ← state (← heldLabel "substitution-state" "restored-terminal") atoms [restoredBond,recurrenceBond,enteringBond] []
 let c ← carrier (← heldLabel "registered-reaction" "acceptor-exchange") left centre right entering leaving donor recurrence displaced .emptyOne source
 let direct ← transition ⟨1,by decide⟩ source terminal (← heldLabel "acceptor-substitution-action" "exchange-and-restore-in-one-transition")
 let add ← transition ⟨1,by decide⟩ source middle (← heldLabel "acceptor-substitution-action" "transfer-aromatic-pair-to-entering-support")
 let restore ← transition ⟨2,by decide⟩ middle terminal (← heldLabel "acceptor-substitution-action" "relinquish-leaving-pair-to-restore-recurrence")
 return (c,← forcedPath c [source,terminal] [direct],← forcedPath c [source,middle,terminal] [add,restore])
def completeCarrier : Bool := match sourcePaths with
 | .error _ => false
 | .ok (c,_,two) => match NucleophilicPath.itemAt two.states 1 with
  | .error _ => false
  | .ok middle => DihedralTorsion.equalLabels c.source.atoms two.terminal.atoms && sameSet (electrons c.source) (electrons middle) && sameSet (electrons middle) (electrons two.terminal)
def acceptorTransfer : Bool := match sourcePaths with
 | .error _ => false
 | .ok (c,_,two) => singletonEmpty c.slot && matchesPair (bondAt two.terminal (c.centre,c.entering)) c.donorPair
def leavingRelinquishment : Bool := match sourcePaths with
 | .error _ => false
 | .ok (c,_,two) => !present (bondAt two.terminal (c.centre,c.leaving)) && matchesPair (bondAt two.terminal (c.left,c.centre)) c.leavingPair
def recurrenceRestored : Bool := match sourcePaths with
 | .error _ => false
 | .ok (c,_,two) => present (bondAt two.terminal (c.left,c.centre)) && matchesPair (bondAt two.terminal (c.centre,c.right)) c.recurrencePair
def completeFamily : Bool := match sourcePaths with
 | .error _ => false
 | .ok (_,one,two) => one.transitionCount.value==1 && two.transitionCount.value==2
def cleavageFirst : Bool := match sourcePaths with
 | .error _ => false
 | .ok (c,_,_) => match (do
   let added ← bond c.left c.centre c.leavingPair
   let impossible ← state (← heldLabel "substitution-state" "cleavage-first") c.source.atoms (c.source.bonds++[added]) []
   stateRole c impossible) with
  | .error _ => true | .ok _ => false
def successor : Bool := match (do
 let (_,_,two) ← sourcePaths
 extend two (← occurrence "aromatic-successor") (← pair (← electron "successor-one") (← electron "successor-two"))) with
 | .error _ => false | .ok b => b
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
theorem completeCarrierPassed : completeCarrier=true := rfl
theorem acceptorTransferPassed : acceptorTransfer=true := rfl
theorem leavingRelinquishmentPassed : leavingRelinquishment=true := rfl
theorem recurrenceRestoredPassed : recurrenceRestored=true := rfl
theorem completeFamilyPassed : completeFamily=true := rfl
theorem cleavageFirstPassed : cleavageFirst=true := rfl
theorem successorPassed : successor=true := rfl
end SFT.Chemistry.ElectrophilicWitnesses
