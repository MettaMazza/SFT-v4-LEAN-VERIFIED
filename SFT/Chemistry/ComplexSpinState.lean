import SFT.Chemistry.LigandStateSplitting
namespace SFT.Chemistry.ComplexSpinState
open SFT.Host SFT.Physics.CapabilityValues
inductive ExactCount where
 | empty (identity : String := "empty-One")
 | positive (value : PositiveCount)
def number : ExactCount → Nat
 | .empty _ => 0
 | .positive n => n.value
def exactCount (n : Nat) : ExactCount :=
 if h : 0<n then .positive ⟨n,h⟩ else .empty "empty-One"
structure Capacity where
 lower : PositiveCount
 upper : PositiveCount
def capacity (lower upper : PositiveCount) : Except String Capacity :=
 if lower.value==3 && upper.value==2 then .ok ⟨lower,upper⟩
 else .error "INORG-007 requires the forced three-plus-two split support"
def forcedCapacity : Capacity := ⟨⟨3,by decide⟩,⟨2,by decide⟩⟩
structure Signature where
 electrons : PositiveCount
 lowerPairs : ExactCount
 lowerSingles : ExactCount
 upperPairs : ExactCount
 upperSingles : ExactCount
def signature (electrons : PositiveCount) (lp ls up us : ExactCount) : Except String Signature := do
 if number lp+number ls>3 || number up+number us>2 then
  throw "occupancy exceeds the forced split-block support"
 if 2*(number lp+number up)+number ls+number us != electrons.value then
  throw "pair and single support must exhaust every electron occurrence"
 return ⟨electrons,lp,ls,up,us⟩
def pairClosures (s : Signature) : ExactCount := exactCount (number s.lowerPairs+number s.upperPairs)
def unmatched (s : Signature) : ExactCount := exactCount (number s.lowerSingles+number s.upperSingles)
def crossings (s : Signature) : ExactCount := exactCount (2*number s.upperPairs+number s.upperSingles)
def spinWidth (s : Signature) : PositiveCount := ⟨number (unmatched s)+1,Nat.zero_lt_succ _⟩
def sameCount : ExactCount → ExactCount → Bool
 | .empty a,.empty b => Text.equal a b
 | .empty _,.positive _ | .positive _,.empty _ => false
 | .positive a,.positive b => a.value==b.value
def sameSignature (a b : Signature) : Bool :=
 a.electrons.value==b.electrons.value && sameCount a.lowerPairs b.lowerPairs &&
 sameCount a.lowerSingles b.lowerSingles && sameCount a.upperPairs b.upperPairs && sameCount a.upperSingles b.upperSingles
def distinctSignatures : List Signature → Bool
 | [] => true
 | first::rest => !(rest.any (sameSignature first)) && distinctSignatures rest
def enumerate (electrons : PositiveCount) (cap : Capacity := forcedCapacity) : Except String (List Signature) := do
 let words := (List.range 4).flatMap fun lp => (List.range 4).flatMap fun ls =>
  (List.range 3).flatMap fun up => (List.range 3).map fun us => (lp,ls,up,us)
 let admitted := words.filter fun (lp,ls,up,us) => lp+ls<=cap.lower.value && up+us<=cap.upper.value && 2*(lp+up)+ls+us==electrons.value
 let rows ← admitted.mapM fun (lp,ls,up,us) => signature electrons (exactCount lp) (exactCount ls) (exactCount up) (exactCount us)
 if rows.isEmpty || !distinctSignatures rows then
  throw "complete spin-state enumeration must be positive and duplicate-free"
 return rows
def leastKey : ExactCount → Nat × Nat
 | .empty _ => (0,0)
 | .positive n => (1,n.value)
def pairLE (a b : Nat × Nat) : Bool := if a.1==b.1 then a.2<=b.2 else a.1<=b.1
def pairEqual (a b : Nat × Nat) : Bool := a.1==b.1 && a.2==b.2
def lowKey (s : Signature) : (Nat × Nat) × (Nat × Nat) := (leastKey (crossings s),leastKey (unmatched s))
def keyEqual (a b : (Nat × Nat) × (Nat × Nat)) : Bool := pairEqual a.1 b.1 && pairEqual a.2 b.2
def keyLE (a b : (Nat × Nat) × (Nat × Nat)) : Bool :=
 if pairEqual a.1 b.1 then pairLE a.2 b.2 else pairLE a.1 b.1
def insertLow (s : Signature) : List Signature → List Signature
 | [] => [s]
 | first::rest => if keyLE (lowKey s) (lowKey first) then s::first::rest else first::insertLow s rest
def sortLow : List Signature → List Signature
 | [] => []
 | first::rest => insertLow first (sortLow rest)
def low (rows : List Signature) : Except String Signature := do
 if rows.isEmpty then throw "low-spin selection requires the complete positive census"
 match sortLow rows with
 | [] => throw "list index out of range"
 | first::rest =>
  let survivors := (first::rest).filter fun s => keyEqual (lowKey s) (lowKey first)
  match survivors with
  | [] => throw "low-spin extremum is not unique in the complete quotient census"
  | survivor::tail =>
   if !tail.isEmpty then throw "low-spin extremum is not unique in the complete quotient census"
   return survivor
def high (rows : List Signature) : Except String Signature := do
 match rows with
 | [] => throw "high-spin selection requires the complete positive census"
 | first::rest =>
  let maximum := rest.foldl (fun best s => max best (number (unmatched s))) (number (unmatched first))
  let candidates := rows.filter fun s => number (unmatched s)==maximum
  match candidates with
  | [] => throw "min() arg is an empty sequence"
  | candidate::others =>
   let minimum := others.foldl (fun best s => min best (number (crossings s))) (number (crossings candidate))
   let survivors := candidates.filter fun s => number (crossings s)==minimum
   match survivors with
   | [] => throw "high-spin extremum is not unique in the complete quotient census"
   | survivor::tail =>
    if !tail.isEmpty then throw "high-spin extremum is not unique in the complete quotient census"
    return survivor
def pathCost (s : Signature) (recurrence : ExactCount) : ExactCount :=
 match recurrence with
 | .empty _ => exactCount (number (pairClosures s))
 | .positive n => exactCount (number (pairClosures s)+n.value*number (crossings s))
structure Order where
 recurrence : ExactCount
 highState : Signature
 lowState : Signature
 highCost : ExactCount
 lowCost : ExactCount
 relation : HeldLabel
def orderRecord (recurrence : ExactCount) (hi lo : Signature) (highCost lowCost : ExactCount) (label : HeldLabel) : Except String Order := do
 if !Text.equal label.family "complex-spin-state-order" ||
  !(Text.equal label.label "high-precedes-low" || Text.equal label.label "crossover-coincidence" || Text.equal label.label "low-precedes-high") then
  throw "complex spin-state order is outside the generated trichotomy"
 return ⟨recurrence,hi,lo,highCost,lowCost,label⟩
def order (hi lo : Signature) (recurrence : ExactCount) : Except String Order := do
 if hi.electrons.value != lo.electrons.value then
  throw "spin-state comparison requires one retained electron support"
 let highCost := pathCost hi recurrence
 let lowCost := pathCost lo recurrence
 let label := if number highCost<number lowCost then "high-precedes-low"
  else if number lowCost<number highCost then "low-precedes-high" else "crossover-coincidence"
 orderRecord recurrence hi lo highCost lowCost (← heldLabel "complex-spin-state-order" label)
def sixCensus : Except String (List Signature) := enumerate ⟨6,by decide⟩
def sixVector : Except String (List Order) := do
 let rows ← sixCensus
 let hi ← high rows
 let lo ← low rows
 [.empty "empty-One",.positive ⟨1,by decide⟩,.positive ⟨2,by decide⟩].mapM (order hi lo)
def censusCount : Nat := match sixCensus with | .error _ => 0 | .ok rows => rows.length
def orderLabels : List String := match sixVector with | .error _ => [] | .ok rows => rows.map (fun r=>r.relation.label)
theorem sixCensusHasTen : censusCount=10 := by decide
theorem originalTrichotomy : orderLabels=["high-precedes-low","crossover-coincidence","low-precedes-high"] := by decide
end SFT.Chemistry.ComplexSpinState
