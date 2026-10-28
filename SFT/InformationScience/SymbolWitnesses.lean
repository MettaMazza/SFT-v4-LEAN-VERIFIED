import SFT.InformationScience.SymbolLedger
namespace SFT.InformationScience.SymbolWitnesses
open SymbolObservation SymbolClasses SymbolLedger
structure Witness where
  name : String
  statement : String
  passed : Bool

def a : Symbol := ("form-a","held-a")
def b : Symbol := ("form-b","held-b")
def c : Symbol := ("form-c","held-c")
def alphabet : List Symbol := [a,b,c]
def fine : Observation := [(a,"seen-a"),(b,"seen-b"),(c,"seen-c")]
def coarse : Observation := [(a,"seen-left"),(b,"seen-left"),(c,"seen-right")]
def fineCheck : Bool := match distinctionLedger alphabet fine with
  | .error _ => false
  | .ok pair => pair.1.length == 3 && pair.2.isEmpty
def coarseCheck : Bool := match distinctionLedger alphabet coarse with
  | .error _ => false
  | .ok pair => decide (pair.2 = [(a,b)])
def symmetryCheck : Bool := match distinguishable fine a b with
  | .error _ => false
  | .ok left => match distinguishable fine b a with
    | .error _ => false
    | .ok right => decide (left = right)
def irreflexivityCheck : Bool := match distinguishable fine a a with
  | .error _ => false
  | .ok value => !value
def classCheck : Bool := match observationClasses alphabet coarse with
  | .error _ => false
  | .ok rows => match rows with
    | [] => false
    | first :: _ => decide (first = ("seen-left",[a,b]))
def witnesses : List Witness := [
  ⟨"total-observation","The fine observation classifies every symbol exactly once.",(validateObservation alphabet fine)⟩,
  ⟨"fine-distinction","Fine observation retains every nonidentity pair distinction.",(fineCheck)⟩,
  ⟨"coarse-closure","Coarse observation closes only the a/b distinction while retaining both microforms.",(coarseCheck)⟩,
  ⟨"symmetry","Swapping a distinguished pair does not change its status.",(symmetryCheck)⟩,
  ⟨"irreflexivity","A canonical symbol is not distinguished from itself.",(irreflexivityCheck)⟩,
  ⟨"class-retention","The coarse class retains both exact left microforms.",(classCheck)⟩
]

theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl

end SFT.InformationScience.SymbolWitnesses
