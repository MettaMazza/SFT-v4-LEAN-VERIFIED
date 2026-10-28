import SFT.Mathematics.LogicInference
namespace SFT.Mathematics.LogicWitnesses
open LogicForms LogicInference
structure Witness where
  name : String
  statement : String
  passed : Bool

def p : Proposition := ⟨"P",.held,rfl⟩
def q : Proposition := ⟨"Q",.held,rfl⟩
def rule : Rule := ("P-to-Q",[p],q)
def step : ProofStep := ⟨[p],q,"P-to-Q",rfl,rfl⟩
def changedStep : ProofStep := ⟨[p],q,"unregistered",rfl,rfl⟩
def disjunctionCheck : Bool := match disjunction p q p with
  | .error _ => false
  | .ok result => decide (result = ("held-alternative",p,(p,q)))
def witnesses : List Witness := [
  ⟨"held-denial","Denial preserves P while changing only its held orientation.",(decide (denied p = (⟨"P",.complementaryHeld,rfl⟩ : Proposition)) && decide (denied (denied p) = p))⟩,
  ⟨"joint-proof","Conjunction retains both exact constituent proofs.",(decide (conjunction p q = ("joint-complete",p,q)))⟩,
  ⟨"held-disjunction","Disjunction retains the supported branch and both alternatives.",(disjunctionCheck)⟩,
  ⟨"proof-replay","The registered P-to-Q step replays from its available premise.",(proofIsValid [p] [step] [rule])⟩,
  ⟨"tampered-rule-control","Changing the rule identity invalidates the same conclusion trace.",(!proofIsValid [p] [changedStep] [rule])⟩,
  ⟨"consistency","P and Q are consistent, while P and its held denial are not.",(consistent [p,q] && !consistent [p,denied p])⟩,
  ⟨"bounded-completeness","Both registered proposition forms have explicit held decisions.",(grammarComplete [p,q] [p,q])⟩
]

theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl

end SFT.Mathematics.LogicWitnesses
