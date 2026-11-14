import SFT.Physics.CoupledEnsembleSynchronizationCertificate
namespace SFT.Physics.CoupledEnsembleSynchronizationMeasurement
open LeptonIntervals
local instance : BEq Int := ⟨fun a b => match a,b with
 | .ofNat a,.ofNat b => a==b
 | .negSucc a,.negSucc b => a==b
 | .ofNat _,.negSucc _ => false
 | .negSucc _,.ofNat _ => false⟩
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
-- V3 legacy_cast subtracts complete Ones only while the value exceeds One.
-- Exact remainder retains One at integral endpoints and leaves all other inputs unchanged.
def legacyCast (value : Rat) : Rat :=
 if (normalize 1 1 (by decide)).blt value then
  let remainder := value.num.toNat % value.den
  if remainder==0 then normalize 1 1 (by decide)
  else normalize (.ofNat remainder) value.den value.den_pos
 else value
def legacyFold (value : Rat) : Rat := legacyCast (add value value)
def legacySeparation (left right : Rat) : Rat :=
 if left==right then normalize 1 1 (by decide) else
  let larger := if right.blt left then left else right
  let smaller := if right.blt left then right else left
  let forward := subtract larger smaller
  let back := subtract (normalize 1 1 (by decide)) forward
  if back.blt forward then back else forward
def legacyStep (points : List Rat) (coupling : Rat) : List Rat :=
 let folded := points.map legacyFold
 folded.map (fun point =>
  let nearest := folded.foldl (fun (held : Option (Rat × Rat)) other =>
   if other==point then held else
    let separation := legacySeparation point other
    match held with
    | none => some (other,separation)
    | some (_,distance) => if separation.blt distance then some (other,separation) else held) none
  match nearest with
  | none => point
  | some (other,separation) =>
   let move := multiply coupling separation
   let ahead := legacyCast (add point separation)
   if ahead==other then legacyCast (add point move)
   else legacyCast (add point (subtract (normalize 1 1 (by decide)) move)))
def occupiedRegionCount (points : List Rat) (regions : Int) : Nat :=
 let labels := points.map (fun point =>
  let label := (point.num*regions)/(.ofNat point.den)
  if label==regions then (1 : Int) else label+1)
 labels.eraseDups.length
structure Recurrence where
 coupling : Rat
 regionCountRecurrence : List Nat
 finalRegionCount : Nat
 finalPoints : List Rat
 terminalCommonPoint : List Rat
def independentRecurrence (denominator members steps regions : Int) (coupling : Rat) : Except String Recurrence := do
 let points ← (List.range members.toNat).mapM (fun index =>
  match denominator with
  | .ofNat 0 => .error "Fraction(1, 0)"
  | .ofNat (d+1) => .ok (normalize (.ofNat (index+1)) (d+1) (Nat.zero_lt_succ d))
  | .negSucc d => .ok (normalize (-Int.ofNat (index+1)) (d+1) (Nat.zero_lt_succ d)))
 let (points,counts) := (List.range steps.toNat).foldl (fun (state : List Rat × List Nat) _ =>
  let next := legacyStep state.1 coupling
  (next,state.2 ++ [occupiedRegionCount next regions])) (points,[])
 let finalCount ← match counts.reverse with | [] => .error "list index out of range" | x::_ => .ok x
 let terminal ← if points.eraseDups.length==1 then
  match points with | [] => .error "tuple index out of range" | p::_ => .ok [p]
  else .ok []
 pure ⟨coupling,counts,finalCount,points,terminal⟩
structure Analysis where
 denominator : Int
 memberCount : Int
 stepCount : Int
 regionCount : Int
 couplings : List Rat
 recurrences : List Recurrence
 finalRegionCounts : List Nat
 printedFinalRegionCounts : List Int
 allPrintedRowsReproduced : Bool
 halfOneUniquelyReachesOneRegion : Bool
 halfOneRecurrence : List Nat
 halfOneTerminalPoint : List Rat
 halfOneTerminalMembersIdentical : Bool
 halfOneFirstOneRegionStep : Nat
def exactMeasurementAnalysis (denominator members steps regions : Int)
 (couplings : List Rat) (printed : List Int) : Except String Analysis := do
 let recurrences ← couplings.mapM (independentRecurrence denominator members steps regions)
 let half ← match recurrences.drop 2 with | [] => .error "tuple index out of range" | h::_ => .ok h
 let finalCounts := recurrences.map Recurrence.finalRegionCount
 let firstOne ← match (half.regionCountRecurrence.zipIdx 1).find? (fun (count,_) => count==1) with
  | none => .error "StopIteration"
  | some (_,step) => .ok step
 pure ⟨denominator,members,steps,regions,couplings,recurrences,finalCounts,printed,
  finalCounts.map Int.ofNat==printed,
  half.finalRegionCount==1 && (recurrences.zipIdx).all (fun (r,i) => if i==2 then true else 1<r.finalRegionCount),
  half.regionCountRecurrence,half.terminalCommonPoint,half.finalPoints.eraseDups.length==1,firstOne⟩
end SFT.Physics.CoupledEnsembleSynchronizationMeasurement
