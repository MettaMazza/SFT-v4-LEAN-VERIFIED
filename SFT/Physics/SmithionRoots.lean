import SFT.Physics.SmithionInvariants
namespace SFT.Physics.SmithionRoots
open LeptonIntervals VacuumLedgerProofs GeneratorOperations SmithionInvariants
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
inductive Side where
 | empty
 | positive (magnitude : Rat)
 | counter (magnitude : Rat)
def cubicSide (x second third : Rat) : Side :=
 let positive := add (multiply (multiply x x) x) (multiply second x)
 let counter := add (multiply x x) third
 if positive==counter then .empty else
 if counter.blt positive then .positive (subtract positive counter) else .counter (subtract counter positive)
def sideTag : Side → Nat
 | .empty => 0
 | .positive _ => 1
 | .counter _ => 2
abbrev Bracket := Option Rat × Rat
structure Scan where
 lower : Option Rat
 lowerSide : Side
 rows : List Bracket
def appendGridPoint (second third upper : Rat) (scan : Scan) : Scan :=
 let upperSide := cubicSide upper second third
 let crossingRows := if sideTag upperSide==0 || sideTag scan.lowerSide != sideTag upperSide then scan.rows ++ [(scan.lower,upper)] else scan.rows
 let rows := match scan.lower with
  | none => crossingRows
  | some lower => if sideTag scan.lowerSide==0 then scan.rows ++ [(some lower,lower)] else crossingRows
 ⟨some upper,upperSide,rows⟩
def signChangeBrackets (second third : Rat) (gridDepth : CountInput) : Except String (List Bracket) := do
 let d ← match gridDepth with
  | .integer (.ofNat (n+1)) => .ok (n+1)
  | .integer (.ofNat 0) | .integer (.negSucc _) | .boolean _ => .error "grid depth must be positive"
 let binary ← AlphaCovers.binaryCount
 let support ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat d))
 let points ← (List.range support).mapM (fun i=>LeptonRatios.divide (wholeRatio (i+1)) (wholeRatio support))
 let result := points.foldl (fun s x=>appendGridPoint second third x s) ⟨none,.counter third,[]⟩
 let generator ← FoldFirstReturn.generatorPeriod
 if result.rows.length != generator then .error "complete grid did not isolate exactly three positive roots" else .ok result.rows
def bisectBracket (bracket : Bracket) (second third : Rat) : Except String Bracket := do
 let binary ← AlphaCovers.binaryCount
 let midpoint ← LeptonRatios.divide (match bracket.1 with | none=>bracket.2 | some lower=>add lower bracket.2) (wholeRatio binary)
 let lowerSide := match bracket.1 with | none=>Side.counter third | some lower=>cubicSide lower second third
 let midpointSide := cubicSide midpoint second third
 if sideTag midpointSide==0 then .ok (some midpoint,midpoint) else
 if sideTag lowerSide==0 || sideTag lowerSide != sideTag midpointSide then .ok (bracket.1,midpoint) else .ok (some midpoint,bracket.2)
def refine (second third : Rat) : Nat → List Bracket → Except String (List Bracket)
 | 0,rows => .ok rows
 | n+1,rows => do refine second third n (← rows.mapM (fun row=>bisectBracket row second third))
def spectrumRootBrackets (sector : CountInput) (kind : String) (halvings : CountInput) : Except String (List Bracket) := do
 let count ← match halvings with
  | .integer (.ofNat (n+1)) => .ok (n+1)
  | .integer (.ofNat 0) | .integer (.negSucc _) | .boolean _ => .error "root refinement requires a positive halving count"
 let (_,second,third) ← spectrumInvariants sector kind
 let brackets ← signChangeBrackets second third (.integer 10)
 refine second third count brackets
def massRatioEnclosures (sector : CountInput) (kind : String) : Except String (List (Rat × Rat)) := do
 let roots ← spectrumRootBrackets sector kind (.integer 60)
 let light ← match roots with | []=>.error "tuple index out of range" | x::_=>.ok x
 let lightLower ← match light.1 with | none=>.error "TypeError" | some x=>.ok x
 let binary ← AlphaCovers.binaryCount
 let other ← roots.drop 1 |>.mapM (fun (lower,upper)=>do
  let lower ← match lower with | none=>.error "TypeError" | some x=>.ok x
  .ok (← LeptonRatios.divide (multiply lower lower) (multiply (wholeRatio binary) (multiply light.2 light.2)),
       ← LeptonRatios.divide (multiply upper upper) (multiply (wholeRatio binary) (multiply lightLower lightLower))))
 .ok ((wholeRatio 1,wholeRatio 1)::other)
#print axioms cubicSide
#print axioms signChangeBrackets
#print axioms bisectBracket
#print axioms spectrumRootBrackets
#print axioms massRatioEnclosures
end SFT.Physics.SmithionRoots
