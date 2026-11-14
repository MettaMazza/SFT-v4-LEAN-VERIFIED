import SFT.Physics.ElectroweakMixing
import SFT.Physics.UnifiedConstantsFoundation
namespace SFT.Physics.PMNSSupport
open AlphaCovers FoldFirstReturn GeneratorOperations
open LeptonIntervals
set_option maxRecDepth 20000

structure Support where
 atmospheric : Rat
 solar : Rat
 reactor : Rat

def squaredSupport : Except String Support := do
 let binary ← binaryCount
 let generator ← generatorPeriod
 let atmospheric ← UnifiedConstantsFoundation.fraction 1 binary
 let solar ← UnifiedConstantsFoundation.fraction 1 generator
 let tower ← positivePower (.integer (.ofNat binary)) (.integer (.ofNat generator))
 let cell ← UnifiedConstantsFoundation.fraction 1 tower
 .ok ⟨atmospheric,solar,multiply (multiply atmospheric solar) cell⟩

def terminalSupport : Support := ⟨normalize 1 2 (by decide),normalize 1 3 (by decide),normalize 1 48 (by decide)⟩

theorem sourceAssembly : squaredSupport=.ok terminalSupport := by
 unfold squaredSupport
 rw [binaryCountTwo,generatorPeriodThree]
 rfl

theorem atmosphericReading : terminalSupport.atmospheric.num=1 ∧ terminalSupport.atmospheric.den=2 := ⟨rfl,rfl⟩
theorem solarReading : terminalSupport.solar.num=1 ∧ terminalSupport.solar.den=3 := ⟨rfl,rfl⟩
theorem reactorReading : terminalSupport.reactor.num=1 ∧ terminalSupport.reactor.den=48 := ⟨rfl,rfl⟩

theorem fullBinaryTower : positivePower (.integer (.ofNat 2)) (.integer (.ofNat 3))=.ok 8 := rfl

theorem generatedTowerCardinality : (SFT.Foundation.FoldAssembly.supportAfterExtensions 3).length=8 :=
 (GeneratorThreeDerivation.completeSupportCount 3).symm

theorem reactorFromSeparations :
 multiply (multiply terminalSupport.atmospheric terminalSupport.solar) (normalize 1 8 (by decide))=terminalSupport.reactor := rfl

theorem completeCellsReassemble : multiply terminalSupport.reactor (normalize 8 1 (by decide))=
 multiply terminalSupport.atmospheric terminalSupport.solar := rfl

theorem reactorPositive : 0<terminalSupport.reactor.num := by decide
theorem reactorProper : terminalSupport.reactor.num<Int.ofNat terminalSupport.reactor.den := by decide
end SFT.Physics.PMNSSupport
