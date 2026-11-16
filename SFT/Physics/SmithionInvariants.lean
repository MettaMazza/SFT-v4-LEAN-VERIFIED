import SFT.Physics.SmithionFlavour
namespace SFT.Physics.SmithionInvariants
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def colouredProduct (sector depth : CountInput) : Except String Rat := do
 let p ← (SectorInventory.chargeKindCount sector).mapError (fun _=>"coloured product requires an admitted prime sector and positive depth")
 let d ← match depth with
  | .integer (.ofNat (n+1)) => .ok (n+1)
  | .integer (.ofNat 0) | .integer (.negSucc _) | .boolean _ => .error "coloured product requires an admitted prime sector and positive depth"
 let binary ← AlphaCovers.binaryCount
 let power ← AlphaCovers.positivePower (.integer (.ofNat p)) (.integer (.ofNat d))
 let support := p*(binary*power-1)-1
 LeptonRatios.divide (wholeRatio p) (wholeRatio support)
def spectrumDepth (sector : CountInput) (kind : String) : Except String Nat := do
 let p ← (SectorInventory.chargeKindCount sector).mapError (fun _=>"spectrum depth requires an admitted sector and generated kind")
 if !(SFT.Host.Text.equal kind "down" || SFT.Host.Text.equal kind "up") then throw "spectrum depth requires an admitted sector and generated kind"
 let generator ← FoldFirstReturn.generatorPeriod
 let exponent := if SFT.Host.Text.equal kind "down" then generator else generator+1
 let power ← AlphaCovers.positivePower (.integer (.ofNat p)) (.integer (.ofNat exponent))
 AlphaCovers.minimalBinaryCover (.integer (.ofNat power))
def pairSum (sector : CountInput) (kind : String) : Except String Rat := do
 let p ← (SectorInventory.chargeKindCount sector).mapError (fun _=>"pair sum requires an admitted sector and generated kind")
 if !(SFT.Host.Text.equal kind "down" || SFT.Host.Text.equal kind "up") then throw "pair sum requires an admitted sector and generated kind"
 let binary ← AlphaCovers.binaryCount
 let generator ← FoldFirstReturn.generatorPeriod
 let denominator := if SFT.Host.Text.equal kind "down" then binary^generator else binary^binary*p
 LeptonRatios.divide (wholeRatio 1) (wholeRatio denominator)
def spectrumInvariants (sector : CountInput) (kind : String) : Except String (Rat × Rat × Rat) := do
 let depth ← spectrumDepth sector kind
 .ok (wholeRatio 1,← pairSum sector kind,← colouredProduct sector (.integer (.ofNat depth)))
theorem originalDepths : ([5,7] : List Nat).flatMap (fun p=>["down","up"].map (fun k=>spectrumDepth (.integer (.ofNat p)) k)) = [.ok 7,.ok 10,.ok 9,.ok 12] := rfl
#print axioms colouredProduct
#print axioms spectrumDepth
#print axioms pairSum
#print axioms spectrumInvariants
#print axioms originalDepths
end SFT.Physics.SmithionInvariants
