import SFT.Applications.Discovery.Core
namespace SFT.Applications.Discovery
-- Original independent module call chains used by usde_discovery.ep.
def noLossPartition : Fraction := fraction 1 1
def secondInvariant : Fraction := fraction 1 (2*colourCount)
def leadingThirdInvariant : Fraction := fraction 1 (2*wholePower colourCount 5-1)
def sumOfLeptonMasses : Fraction := subtract (multiply noLossPartition noLossPartition) (add secondInvariant secondInvariant)
def koideRatio : Fraction := divide sumOfLeptonMasses (multiply noLossPartition noLossPartition)
def sectorCoupling (p : Int) : Fraction := subtract (fraction 1 1) (fraction 1 p)
def sinSquaredMixing : Fraction := fraction 1 (wholePower binaryCount 2)
def cosSquaredMixing : Fraction := subtract (fraction 1 1) sinSquaredMixing
def generationalVolume : Int := wholePower colourCount colourCount
def generationalCoveringDepth : Int := minimalBinaryCover generationalVolume
-- This is the exact forced_to_be check called by the original module.
def coveringEnforcement : Bool := decide (generationalCoveringDepth = binaryCount+colourCount)
theorem coveringEnforcementPassed : coveringEnforcement = true := by decide

def totalBinaryVolume : Int := wholePower binaryCount generationalCoveringDepth
def baryonFraction : Fraction := fraction generationalCoveringDepth totalBinaryVolume
def darkFraction : Fraction := fraction generationalVolume totalBinaryVolume
def relicVolume : Int := wholePower colourCount colourCount
def relicDepth : Int := minimalBinaryCover relicVolume
def relicFractionOfMatter : Fraction := fraction relicVolume (wholePower 2 relicDepth)
def vacuumFraction : Fraction := fraction binaryCount colourCount
def matterFraction : Fraction := fraction 1 colourCount
def darkEnergyDensity : Fraction := vacuumFraction
def matterDensity : Fraction := matterFraction
def baryonDensity : Fraction := multiply matterDensity baryonFraction
def coldDarkMatterDensity : Fraction := multiply matterDensity darkFraction
end SFT.Applications.Discovery
