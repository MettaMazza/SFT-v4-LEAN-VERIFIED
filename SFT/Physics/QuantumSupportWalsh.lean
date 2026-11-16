import SFT.Physics.QuantumSupportPreparation
namespace SFT.Physics.QuantumSupportWalsh
open QuantumSupportPreparation LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure SupportCertificate where
 depth : Nat
 branchCount : Nat
 positionSupport : Nat
 frequencySupport : Nat
 modeRows : List (Word × Nat × Nat × Option Nat)
 parsevalSum : Nat
 parsevalIdentity : Bool
 supportProduct : Nat
 supportBound : Bool
 normalizedProduct : Rat
 unitFreeBound : Bool
 squaredProduct : Rat
 squaredFloor : Rat
 squaredBound : Bool
def walshSupportCertificate (depth : CountInput) (support : List Word) : Except String SupportCertificate := do
 let ws ← binaryWords depth
 if support.isEmpty || support.eraseDups.length != support.length || !(support.all (fun w => ws.contains w)) then
  throw "Walsh support must be a nonempty unique subset of complete binary support"
 let rows ← ws.mapM fun mode => do
  let phases ← support.mapM (fun point => walshPhase point mode)
  let h := (phases.filter (fun p => p==held)).length
  let r := (phases.filter (fun p => p==returned)).length
  pure (mode,h,r,imbalance h r)
 let occupied := rows.filter (fun row => row.2.2.2.isSome)
 let st := support.length
 let sf := occupied.length
 let n := ws.length
 let parseval := rows.foldl (fun s row => s+(magnitude row.2.2.2)^2) 0
 let normalized ← LeptonRatios.divide (wholeRatio (st*sf)) (wholeRatio n)
 let position ← LeptonRatios.divide (wholeRatio st) (wholeRatio n)
 let frequency ← LeptonRatios.divide (wholeRatio sf) (wholeRatio n)
 let squared := multiply (multiply position position) (multiply frequency frequency)
 let floor ← LeptonRatios.divide (wholeRatio 1) (wholeRatio (n*n))
 let d ← SpinStatisticsCondensation.positiveWhole depth "binary depth"
 pure ⟨d,n,st,sf,rows,parseval,parseval==n*st,st*sf,decide (n≤st*sf),normalized,
  !normalized.blt (wholeRatio 1),squared,floor,!squared.blt floor⟩
structure Orthogonality where
 depth : Nat
 branchCount : Nat
 diagonalComplete : Bool
 offDiagonalCancels : Bool
 rows : List (Word × Word × Nat × Nat)
def orthogonalityCertificate (depth : CountInput) : Except String Orthogonality := do
 let ws ← binaryWords depth
 let nested ← ws.mapM fun left => ws.mapM fun right => do
  let products ← ws.mapM fun mode => do
   let lp ← walshPhase left mode
   let rp ← walshPhase right mode
   pure (if lp==rp then held else returned)
  pure (left,right,(products.filter (fun p => p==held)).length,(products.filter (fun p => p==returned)).length)
 let rows := nested.flatten
 let diagonal := (rows.filter (fun row => row.1==row.2.1)).all (fun row => row.2.2.1==ws.length && row.2.2.2==0)
 let offDiagonal := (rows.filter (fun row => row.1!=row.2.1)).all (fun row => row.2.2.1==row.2.2.2 && row.2.2.1+row.2.2.2==ws.length)
 let d ← SpinStatisticsCondensation.positiveWhole depth "binary depth"
 pure ⟨d,ws.length,diagonal,offDiagonal,rows⟩
-- Same include-first order as itertools.combinations.
def combinations {α : Type} : Nat → List α → List (List α)
 | 0,_ => [[]]
 | _+1,[] => []
 | k+1,x::xs => (combinations k xs).map (List.cons x) ++ combinations (k+1) xs
structure WalshCensus where
 maxDepth : Nat
 candidateSupports : Nat
 saturatedSupports : Nat
 allPass : Bool
def completeWalshCensus (maxDepth : CountInput) : Except String WalshCensus := do
 let limit ← SpinStatisticsCondensation.positiveWhole maxDepth "Walsh census depth"
 let (total,saturated) ← (List.range limit).foldlM (fun (total,saturated) index => do
  let depth := index+1
  let input := CountInput.integer (.ofNat depth)
  let ws ← binaryWords input
  let orthogonal ← orthogonalityCertificate input
  if !orthogonal.diagonalComplete || !orthogonal.offDiagonalCancels then throw "Walsh orthogonality failed"
  (List.range ws.length).foldlM (fun (total,saturated) size =>
   (combinations (size+1) ws).foldlM (fun (total,saturated) selected => do
    let c ← walshSupportCertificate input selected
    if !c.parsevalIdentity || !c.supportBound || !c.unitFreeBound || !c.squaredBound then
     throw "Walsh support census found a failed bound"
    pure (total+1,saturated+if c.supportProduct==c.branchCount then 1 else 0)) (total,saturated)) (total,saturated)) (0,0)
 pure ⟨limit,total,saturated,true⟩
structure SpacingCertificate where
 positionSpread : Rat
 frequencySpread : Rat
 product : Rat
 spacingCancelled : Bool
def spacingCancellationCertificate (depth : CountInput) (selected : List Word) (spacing : Rat) : Except String SpacingCertificate := do
 let c ← walshSupportCertificate depth selected
 if !zero.blt spacing then throw "spacing must be a positive exact Fold fraction"
 let position := multiply (wholeRatio c.positionSupport) spacing
 let frequency ← LeptonRatios.divide (← LeptonRatios.divide (wholeRatio c.frequencySupport) (wholeRatio c.branchCount)) spacing
 let product := multiply position frequency
 pure ⟨position,frequency,product,VelocityComposition.ratEqual product c.normalizedProduct⟩
end SFT.Physics.QuantumSupportWalsh
