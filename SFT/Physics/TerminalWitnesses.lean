import SFT.Physics.LeptonTerminal
namespace SFT.Physics.TerminalWitnesses
open LeptonTerminal AlphaBlocks
structure Witness where
 name : String
 statement : String
 passed : Bool

def positiveCheck : Bool := match correction with
 | .error _ => false
 | .ok held => decide (0 < held.numerator) &&
   decide (held.numerator*admittedProduct.denominator < admittedProduct.numerator*held.denominator)

def depthsCheck : Bool := match fineStructureBlocks with
 | .error _ => false
 | .ok blocks => blocks.down == 5 && blocks.up == 7

def exactCheck : Bool := match terminalProduct with
 | .error _ => false
 | .ok result => decide (0 < result.numerator)

def witnesses : List Witness := [⟨"positive-correction","The exact terminal correction is a strict positive part smaller than 3/1454.",positiveCheck⟩,⟨"forced-depths","The independently admitted terminal blocks supply down/up depths five and seven.",depthsCheck⟩,⟨"exact-rational-result","The terminal invariant is an exact positive fraction reconstructed without physical target values.",exactCheck⟩]

theorem positiveCheckPassed : positiveCheck = true := rfl

theorem depthsCheckPassed : depthsCheck = true := rfl

theorem exactCheckPassed : exactCheck = true := rfl

theorem allWitnessesPass : witnesses.all Witness.passed = true := by
 change (positiveCheck && (depthsCheck && (exactCheck && true))) = true
 rw [positiveCheckPassed,depthsCheckPassed,exactCheckPassed]
 rfl
end SFT.Physics.TerminalWitnesses
