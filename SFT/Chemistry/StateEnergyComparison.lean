import SFT.Chemistry.StateEnergyTargets
import SFT.Chemistry.StateEnergyOrder
namespace SFT.Chemistry.StateEnergyComparison
open SFT.Host StateEnergyTargets
abbrev J := Canonical.Value
structure Row where
 resolved : Resolved
 targetId : String
 speciesId : String
 stateRecord : String
 inscription : String
 quality : String
 designatedGround : Bool
 gapNumerator : Int
 gapDenominator : Int

def le (a b : Row) : Bool := a.resolved.numerator*b.resolved.denominator ≤ b.resolved.numerator*a.resolved.denominator
def insert (row : Row) : List Row → List Row
 | [] => [row]
 | first::rest => if le row first then row::first::rest else first::insert row rest
def sorted : List Row → List Row
 | [] => []
 | row::rest => insert row (sorted rest)

def expectedGapMatches (n d : Nat) (en ed : Int) : Bool :=
 match en,ed with
 | .ofNat a,.ofNat b => b != 0 && n*b == a*d
 | .negSucc a,.negSucc b => n*(b+1) == (a+1)*d
 | .ofNat a,.negSucc _ => n==0 && a==0
 | .negSucc _,.ofNat _ => false

def comparison (ground row : Row) (index : Nat) : J :=
 let n := row.resolved.numerator*ground.resolved.denominator-ground.resolved.numerator*row.resolved.denominator
 let d := row.resolved.denominator*ground.resolved.denominator
 let g := Nat.gcd n d
 let n := n/g
 let d := d/g
 let passed := expectedGapMatches n d row.gapNumerator row.gapDenominator &&
  ((index==0 && n==0) || (index>0 && n>0))
 .object [("target_id",.text row.targetId),("species_row_id",.text row.speciesId),
 ("NIST_state",.text row.stateRecord),("measured_Te_inscription",.text row.inscription),
 ("exact_value_numerator",.integer (.ofNat row.resolved.numerator)),
 ("exact_value_denominator",.integer (.ofNat row.resolved.denominator)),
 ("source_quality",.text row.quality),("is_ground",.boolean row.designatedGround),
 ("gap_from_ground_numerator",.integer (.ofNat n)),("gap_from_ground_denominator",.integer (.ofNat d)),
 ("forced_order_position",if index==0 then .text "structural-empty-One" else .integer (.ofNat index)),
 ("passed",.boolean passed)]

-- Source nested loop checks every later row before advancing to the next left row.
def compareRows (ground : Row) : Nat → List Row → Except String (List J × Nat)
 | _,[] => .ok ([],0)
 | index,left::rest => do
  let result := comparison ground left index
  if rest.any (fun right=>le right left) then throw "ELEC-004 measured pair is not strictly ordered"
  let (results,pairs) ← compareRows ground (index+1) rest
  pure (result::results,rest.length+pairs)

def compareSpecies (species : String) (rows : List Row) : Except String (List J × Nat) := do
 let ordered := sorted rows
 let order ← StateEnergyOrder.buildExactStateOrder species (ordered.map Row.targetId)
 let ground ← match ordered with
  | [] => .error "list index out of range"
  | row::_ => .ok row
 if !ground.designatedGround || (rows.filter Row.designatedGround).length != 1 then
  throw "ELEC-004 source ground is not unique least"
 let result ← compareRows ground 0 ordered
 if order.states.length != rows.length then throw "ELEC-004 exact order lost a state"
 pure result

#print axioms le
#print axioms insert
#print axioms sorted
#print axioms expectedGapMatches
#print axioms comparison
#print axioms compareRows
#print axioms compareSpecies
end SFT.Chemistry.StateEnergyComparison
