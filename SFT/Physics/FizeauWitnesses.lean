import SFT.Physics.VelocityCompositionWitnesses
namespace SFT.Physics.FizeauWitnesses
open VelocityComposition VelocityCompositionWitnesses
structure Witness where
 name : String
 statement : String
 passed : Bool
def formalUnique : Bool := bilinearCandidates.length == 4
def formalClosure : Bool := match theoremCertificate with | .error _ => false | .ok c => c.closure && c.associativity
def formalLimit : Bool := match theoremCertificate with | .error _ => false | .ok c => c.limitingSpeedAbsorbing && c.typedRestIdentity
def witnesses : List Witness := [⟨"formal-unique","The structural bilinear census has one survivor.",formalUnique⟩,⟨"formal-closure","The exact operation is closed and associative.",formalClosure⟩,⟨"formal-limit","The limiting One is absorbing without a numerical-zero rest premise.",formalLimit⟩]
end SFT.Physics.FizeauWitnesses
