import SFT.Physics.UnifiedConstantsTerminal
import SFT.Physics.UnifiedConstantsGraph
import SFT.Host.Canonical
namespace SFT.Physics.UnifiedConstantsCertificate
open UnifiedConstantsFoundation UnifiedConstantsTerminal UnifiedConstantsGraph SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 16000000
structure Certificate where
 foundationOrder : Fields
 terminal : Fields
 successorProbe : Fields
 allSectorsReachOne : Bool
 sharedGeometry : Bool
 everyDependentMoves : Bool
 independentControlsHold : Bool
 leadingTerminalCrossLock : Bool

def theoremCertificate : Except String Certificate := do
 let generator ← FoldFirstReturn.generatorPeriod
 let leading ← foundationOrderVector (count generator)
 let successor ← foundationOrderVector (count (generator+1))
 let terminal ← admittedTerminalVector
 let rooted ← UnifiedConstantsGraph.allSectorsReachOne
 .ok ⟨orderFields leading,terminal,orderFields successor,rooted,UnifiedConstantsGraph.sharedGeometry,
   changedFields (dependentFields leading) (orderFields leading) (orderFields successor),
   sameFields heldFields (orderFields leading) (orderFields successor),
   sameFields sharedFields terminal (orderFields leading)⟩

def fieldValue : FieldValue → Value
 | .count n => .integer (.ofNat n)
 | .fraction q => .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def fieldsValue (fs : Fields) : Value := .object (fs.map fun (k,v) => (k,fieldValue v))
def certificateValue (c : Certificate) : Value := .object [
 ("foundation_order",fieldsValue c.foundationOrder),("terminal",fieldsValue c.terminal),
 ("successor_probe",fieldsValue c.successorProbe),("all_sectors_reach_One",.boolean c.allSectorsReachOne),
 ("shared_geometry_not_disconnected_list",.boolean c.sharedGeometry),
 ("every_generator_dependent_carrier_moves",.boolean c.everyDependentMoves),
 ("independent_controls_hold",.boolean c.independentControlsHold),
 ("leading_terminal_cross_lock",.boolean c.leadingTerminalCrossLock)]

def fiveChecks (c : Certificate) : Bool × Bool × Bool × Bool × Bool :=
 (c.allSectorsReachOne,c.sharedGeometry,c.leadingTerminalCrossLock,c.everyDependentMoves,c.independentControlsHold)

theorem allOriginalChecks : theoremCertificate.map fiveChecks = .ok (true,true,true,true,true) := by
 unfold theoremCertificate
 rw [UnifiedConstantsGraph.allSevenReachable]
 rfl
end SFT.Physics.UnifiedConstantsCertificate
