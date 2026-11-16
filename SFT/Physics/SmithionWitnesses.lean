import SFT.Physics.SmithionSpectrum
namespace SFT.Physics.SmithionWitnesses
open SmithionSpectrum SmithionFlavour LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match theoremCertificate with | .error _=>false | .ok c=>c.quarkCrossLock
def witness1 : Bool := match theoremCertificate with | .error _=>false | .ok c=>c.twelveRoots && c.allRootsDisjointPositive
def witness2 : Bool := match relicCertificate with | .error _=>false | .ok c=>c.neutralCompleteFibres.all id && c.lightestUnique.all id
def witness3 : Bool := match abundanceCertificate with | .error _=>false | .ok c=>c.darkToBaryon==normalize 27 5 (by decide) && c.matterToBaryon==normalize 32 5 (by decide)
def witness4 : Bool := match lfvCertificate with | .error _=>false | .ok c=>(c.integerRatio.length==3 && (c.integerRatio.zip [3,5,20]).all (fun (a,b)=>@decide (a=b) (Int.decEq a b))) && c.tauRatio==wholeRatio 4
def witness5 : Bool := match lfvCertificate with | .error _=>false | .ok c=>c.betaSlopes==[(2,wholeRatio 1),(3,wholeRatio 2),(5,wholeRatio 4),(7,wholeRatio 6)]
theorem witness0Passed : witness0=true := rfl
#print axioms witness0Passed
theorem witness1Passed : witness1=true := rfl
#print axioms witness1Passed
theorem witness2Passed : witness2=true := rfl
#print axioms witness2Passed
theorem witness3Passed : witness3=true := rfl
#print axioms witness3Passed
theorem witness4Passed : witness4=true := rfl
#print axioms witness4Passed
theorem witness5Passed : witness5=true := rfl
#print axioms witness5Passed
def witnesses : List Witness := [⟨"quark-cross-lock","The same product family returns both independently admitted sharpened quark products.",witness0⟩,⟨"twelve-roots","The complete four-cubic census contains exactly twelve disjoint positive rational root enclosures.",witness1⟩,⟨"neutral-lightest","Both new sectors have complete neutral fibres and every spectrum has one unique least root.",witness2⟩,⟨"abundance","The exact cover partition forces both abundance ratios.",witness3⟩,⟨"lfv","The complete transition table reduces exactly to 3:5:20 and the same-parent tau ratio is four.",witness4⟩,⟨"beta","Coupling divided by its sector shortfall is p-1 at every admitted prime sector.",witness5⟩]
end SFT.Physics.SmithionWitnesses
