import SFT.Physics.CubicAtomicSupport
namespace SFT.Physics.MolecularSpectrum
open LeptonIntervals VacuumLedgerProofs
structure Hierarchy where
 electronic : Rat
 molecularRotationVibration : Rat
 twoMolecularQuanta : Rat
def molecularSpectrumHierarchy : Except String Hierarchy := do
 let binary ← AlphaCovers.binaryCount
 let electronic ← LeptonRatios.divide (wholeRatio 1) (wholeRatio binary)
 let molecular ← LeptonRatios.divide (wholeRatio 1) (wholeRatio (binary^binary))
 pure ⟨electronic,molecular,multiply (wholeRatio binary) molecular⟩
def originalHierarchy : Hierarchy := ⟨normalize 1 2 (by decide),normalize 1 4 (by decide),normalize 1 2 (by decide)⟩
theorem completeSourceRecord : molecularSpectrumHierarchy=.ok originalHierarchy := rfl
theorem completeRecomposition : add originalHierarchy.molecularRotationVibration originalHierarchy.molecularRotationVibration=originalHierarchy.electronic := rfl
theorem strictSpectralOrder : originalHierarchy.molecularRotationVibration.blt originalHierarchy.electronic=true := rfl
end SFT.Physics.MolecularSpectrum
