import SFT.Physics.QuantumSupportWalsh
namespace SFT.Physics.QuantumSupportJoint
open QuantumSupportPreparation QuantumSupportWalsh GeneratorOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev Joint := String × String
def labels (labelPrefix : String) (size : CountInput) : Except String (List String) := do
 let n ← SpinStatisticsCondensation.positiveWhole size labelPrefix
 pure ((List.range n).map (fun i => SFT.Host.Text.append (SFT.Host.Text.append labelPrefix "-") (toString (i+1))))
def isFactorableJoint (rows : List Joint) : Except String Bool := do
 if rows.isEmpty || rows.eraseDups.length != rows.length then throw "joint support must be nonempty and unique"
 let left := (rows.map Prod.fst).eraseDups
 let right := (rows.map Prod.snd).eraseDups
 let product := left.flatMap (fun a => right.map (fun b => (a,b)))
 pure (rows.all (fun row => product.contains row) && product.all (fun row => rows.contains row))
structure JointCensus where
 leftSize : Nat
 rightSize : Nat
 jointCells : Nat
 nonemptySupports : Nat
 factorableSupports : Nat
 nonfactorableSupports : Nat
 expectedFactorable : Nat
 censusComplete : Bool
 fullProductFactorable : Bool
 projectionsComplete : Bool
 remoteRelabelInvariant : Bool
private def reverseLabel (pairs : List (String × String)) (label : String) : String :=
 match pairs.find? (fun p => p.1==label) with
 | some p => p.2
 | none => label
def jointSubsetCensus (leftSize rightSize : CountInput) : Except String JointCensus := do
 let left ← labels "left" leftSize
 let right ← labels "right" rightSize
 let cells := left.flatMap (fun a => right.map (fun b => (a,b)))
 let reversedRight := right.zip right.reverse
 let (factorable,nonfactorable,projections,remote) ← (List.range cells.length).foldlM
  (fun (factorable,nonfactorable,projections,remote) index =>
   (combinations (index+1) cells).foldlM (fun (factorable,nonfactorable,projections,remote) support => do
    let factorableHere ← isFactorableJoint support
    let lc := left.map (fun label => (support.filter (fun row => row.1==label)).length)
    let rc := right.map (fun label => (support.filter (fun row => row.2==label)).length)
    let relabelled := support.map (fun (a,b) => (a,reverseLabel reversedRight b))
    let relabelledLeft := left.map (fun label => (relabelled.filter (fun row => row.1==label)).length)
    pure (factorable+if factorableHere then 1 else 0,
     nonfactorable+if factorableHere then 0 else 1,
     projections && lc.foldl Nat.add 0==index+1 && rc.foldl Nat.add 0==index+1,
     remote && lc==relabelledLeft)) (factorable,nonfactorable,projections,remote)) (0,0,true,true)
 let expected := (2^left.length-1)*(2^right.length-1)
 let full ← isFactorableJoint cells
 pure ⟨left.length,right.length,cells.length,2^cells.length-1,factorable,nonfactorable,expected,
  factorable==expected && factorable+nonfactorable==2^cells.length-1,full,projections,remote⟩
structure CoprimeCensus where
 left : Nat
 right : Nat
 joint : Nat
 rows : List (Nat × Nat)
 oneVisit : Bool
 productExceedsSum : Bool
 productAloneIsEntanglement : Bool
def coprimeTraceCensus (leftSize rightSize : CountInput) : Except String CoprimeCensus := do
 let left ← SpinStatisticsCondensation.positiveWhole leftSize "left period"
 let right ← SpinStatisticsCondensation.positiveWhole rightSize "right period"
 let common := left*right
 let rows := (List.range common).map (fun step => (step%left+1,step%right+1))
 pure ⟨left,right,common,rows,rows.eraseDups.length==common,decide (left+right<common),false⟩
end SFT.Physics.QuantumSupportJoint
