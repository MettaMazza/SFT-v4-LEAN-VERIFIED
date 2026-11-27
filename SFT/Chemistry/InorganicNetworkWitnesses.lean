import SFT.Chemistry.InorganicNetworkDerivation
namespace SFT.Chemistry.InorganicNetworkWitnesses
open InorganicNetwork InorganicColour
open SFT.Physics.CapabilityValues

def acid := lewisStep "pair" "base" "acid" "adduct"
def acidNetwork : Except String Network := do reactionNetwork "acid-base" ["base","acid","adduct"] [← acid] [] ["pair"]
def oxidation := redoxStep "forward" "donor" "acceptor" ⟨2,by decide⟩
def reduction : Except String Redox := do reverseRedox (← oxidation) "reverse"
def redoxNetwork : Except String Network := do reactionNetwork "redox" ["donor","acceptor"] [] [← oxidation] ["forward"]
def extended : Except String Network := do appendRedox (← acidNetwork) (← oxidation)
def lewisWitness : Bool := match acidNetwork,acid with
 | .ok s,.ok a => s.path.length==1 && a.pair.length==2 && s.species.any (sameLabel a.adduct)
 | .error _,.error _ | .error _,.ok _ | .ok _,.error _ => false
def redoxWitness : Bool := match redoxNetwork,oxidation with
 | .ok s,.ok o => s.path.length==1 && o.electrons.length==2
 | .error _,.error _ | .error _,.ok _ | .ok _,.error _ => false
def reverseWitness : Bool := match reduction,oxidation with
 | .ok r,.ok o => DefectChemistry.sameLabels r.electrons o.electrons && sameLabel r.donor o.acceptor && sameLabel r.acceptor o.donor
 | .error _,.error _ | .error _,.ok _ | .ok _,.error _ => false
def successorWitness : Bool := match extended,acid,oxidation with
 | .ok s,.ok a,.ok o => s.path.length==2 && DefectChemistry.sameLabels s.path [a.step,o.step]
 | .error _,_,_ => false
 | .ok _,.error _,_ => false
 | .ok _,.ok _,.error _ => false
def speciesWitness : Bool := match (do reactionNetwork "bad" ["base","acid"] [← acid] [] ["pair"]) with
 | .error _ => true | .ok _ => false
set_option maxRecDepth 10000
set_option maxHeartbeats 20000000
theorem lewisPassed : lewisWitness=true := by decide
theorem redoxPassed : redoxWitness=true := by decide
theorem reversePassed : reverseWitness=true := by decide
theorem successorPassed : successorWitness=true := by decide
theorem speciesPassed : speciesWitness=true := by decide
end SFT.Chemistry.InorganicNetworkWitnesses
