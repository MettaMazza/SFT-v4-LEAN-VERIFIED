import SFT.Chemistry.NucleophilicPath
namespace SFT.Chemistry.NucleophilicWitnesses
open SFT.Host SFT.Physics.CapabilityValues NucleophilicCarrier NucleophilicPath

def sourcePaths : Except String (Carrier × ExactSubstitution × ExactSubstitution) := do
 let centre ← occurrence "centre"
 let retained ← occurrence "retained"
 let entering ← occurrence "entering"
 let leaving ← occurrence "leaving"
 let retainedPair ← pair (← electron "retained-one") (← electron "retained-two")
 let enteringPair ← pair (← electron "entering-one") (← electron "entering-two")
 let leavingPair ← pair (← electron "leaving-one") (← electron "leaving-two")
 let atoms := [centre,retained,entering,leaving]
 let retainedBond ← bond centre retained retainedPair
 let leavingBond ← bond centre leaving leavingPair
 let enteringBond ← bond centre entering enteringPair
 let freeEntering ← freePair entering enteringPair
 let freeLeaving ← freePair leaving leavingPair
 let source ← state (← heldLabel "substitution-state" "source") atoms [retainedBond,leavingBond] [freeEntering]
 let middle ← state (← heldLabel "substitution-state" "cleaved-intermediate") atoms [retainedBond] [freeEntering,freeLeaving]
 let terminal ← state (← heldLabel "substitution-state" "terminal") atoms [retainedBond,enteringBond] [freeLeaving]
 let c ← carrier (← heldLabel "registered-reaction" "exchange-carrier") centre retained entering leaving enteringPair leavingPair source
 let concerted ← transition ⟨1,by decide⟩ source terminal (← heldLabel "substitution-action" "exchange-support-in-one-transition")
 let cleavage ← transition ⟨1,by decide⟩ source middle (← heldLabel "substitution-action" "cleave-displaced-support")
 let formation ← transition ⟨2,by decide⟩ middle terminal (← heldLabel "substitution-action" "form-entering-support")
 return (c,← forcedPath c [source,terminal] [concerted],← forcedPath c [source,middle,terminal] [cleavage,formation])

def completeCarrier : Bool := match sourcePaths with
 | .error _ => false
 | .ok (c,one,_) => DihedralTorsion.equalLabels one.terminal.atoms c.source.atoms && sameSet (electrons one.terminal) (electrons c.source)
def minimalChange : Bool := match sourcePaths with
 | .error _ => false
 | .ok (c,one,_) => present (bondAt one.terminal (c.centre,c.entering)) && !present (bondAt one.terminal (c.centre,c.leaving))
def pairRetention : Bool := match sourcePaths with
 | .error _ => false
 | .ok (c,one,_) => matchesPair (bondAt one.terminal (c.centre,c.entering)) c.enteringPair && matchesPair (freeAt one.terminal c.leaving) c.leavingPair
def completeFamily : Bool := match sourcePaths with
 | .error _ => false
 | .ok (_,one,two) => one.transitionCount.value==1 && two.transitionCount.value==2
def formationFirst : Bool := match sourcePaths with
 | .error _ => false
 | .ok (c,_,_) => match (do
   let extra ← bond c.centre c.entering c.enteringPair
   let impossible ← state (← heldLabel "substitution-state" "doubly-occupied-slot") c.source.atoms (c.source.bonds++[extra]) []
   stateRole c impossible) with
  | .error _ => true | .ok _ => false
def pairCollapse : Bool := match (do let e ← electron "same"; pair e e) with
 | .error _ => true | .ok _ => false
def successor : Bool := match (do
 let (c,_,two) ← sourcePaths
 extend c two (← occurrence "successor") (← pair (← electron "successor-one") (← electron "successor-two"))) with
 | .error _ => false | .ok b => b
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
theorem completeCarrierPassed : completeCarrier=true := rfl
theorem minimalChangePassed : minimalChange=true := rfl
theorem pairRetentionPassed : pairRetention=true := rfl
theorem completeFamilyPassed : completeFamily=true := rfl
theorem formationFirstPassed : formationFirst=true := rfl
theorem pairCollapsePassed : pairCollapse=true := rfl
theorem successorPassed : successor=true := rfl
end SFT.Chemistry.NucleophilicWitnesses
