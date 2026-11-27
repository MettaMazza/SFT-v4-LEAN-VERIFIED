import SFT.Chemistry.MolecularGraphEnumeration
import SFT.Chemistry.MulticentreSupport
namespace SFT.Chemistry.ConformerCarrier
open SFT.Host SFT.Physics.CapabilityValues
open MulticentreSupport (sameLabel sameWord)
abbrev Bond := PositiveCount × PositiveCount

def orderedBond (left right : PositiveCount) : Except String Bond :=
 if left.value==right.value then .error "a molecular bond requires two distinct positive positions"
 else .ok (if left.value<right.value then (left,right) else (right,left))
def sameBond (a b : Bond) : Bool := a.1.value==b.1.value && a.2.value==b.2.value
def positions (size : Nat) : List PositiveCount :=
 (List.range size).map fun i => ⟨i+1,Nat.zero_lt_succ i⟩
def containsPosition (xs : List PositiveCount) (x : PositiveCount) : Bool := xs.any (fun a => a.value==x.value)
def uniquePositions (xs : List PositiveCount) : List PositiveCount :=
 xs.foldl (fun seen x => if containsPosition seen x then seen else seen++[x]) []
def distinctBonds (xs : List Bond) : Bool :=
 (xs.foldl (fun seen x => if seen.any (sameBond x) then seen else seen++[x]) []).length==xs.length
-- Each expansion retains the reached set and every endpoint of an incident bond.
def expand (bonds : List Bond) (reached : List PositiveCount) : List PositiveCount :=
 uniquePositions (reached ++ bonds.flatMap (fun (a,b) =>
  if containsPosition reached a || containsPosition reached b then [a,b] else []))
def reach : Nat → List Bond → List PositiveCount → List PositiveCount
 | 0,_,reached => reached
 | n+1,bonds,reached =>
  let expanded := expand bonds reached
  if expanded.length==reached.length then reached else reach n bonds expanded
def bondLE (a b : Bond) : Bool :=
 if a.1.value==b.1.value then a.2.value<=b.2.value else a.1.value<=b.1.value
def insertBond (b : Bond) : List Bond → List Bond
 | [] => [b]
 | a::rest => if bondLE b a then b::a::rest else a::insertBond b rest
def sortBonds : List Bond → List Bond
 | [] => []
 | b::rest => insertBond b (sortBonds rest)
structure Graph where
 atomTypes : List HeldLabel
 bonds : List Bond

def graph (atoms : List HeldLabel) (bonds : List Bond) : Except String Graph := do
 if atoms.isEmpty || !(atoms.all fun a => Text.equal a.family "atom-type") then
  throw "a conformer carrier requires positive finite atom support"
 let allowed := positions atoms.length
 let normalized ← bonds.mapM fun (a,b) => orderedBond a b
 if normalized.isEmpty || !distinctBonds normalized ||
   !(normalized.all fun (a,b) => containsPosition allowed a && containsPosition allowed b) then
  throw "molecular bonds must be complete distinct positive-position pairs"
 let reached := reach atoms.length normalized [⟨1,by decide⟩]
 if !(allowed.all (containsPosition reached)) then
  throw "conformer generation requires one connected molecular graph"
 return ⟨atoms,sortBonds normalized⟩

structure Rotor where
 orderedSites : List PositiveCount

def validateRotor (rotor : Rotor) (g : Graph) : Except String Unit := do
 if (uniquePositions rotor.orderedSites).length != 4 ||
  !(rotor.orderedSites.all (containsPosition (positions g.atomTypes.length))) then
  throw "a rotor requires four distinct retained molecular positions"
 let required ← ((rotor.orderedSites.zip (rotor.orderedSites.drop 1)).take 3).mapM fun (a,b) => orderedBond a b
 if !(required.all fun b => g.bonds.any (sameBond b)) then
  throw "a rotor requires the complete ordered three-bond path"
 return ()
def reversedSites (rotor : Rotor) := rotor.orderedSites.reverse

structure Alphabet where
 states : List HeldLabel
 reversal : List (HeldLabel × HeldLabel)
-- Python dict retains the last value for a repeated key.
def reversalLookup (pairs : List (HeldLabel × HeldLabel)) (state : HeldLabel) : Option HeldLabel :=
 (pairs.reverse.find? fun pair => sameLabel pair.1 state).map Prod.snd

def alphabet (states : List HeldLabel) (reversal : List (HeldLabel × HeldLabel)) : Except String Alphabet := do
 if states.isEmpty || !MulticentreSupport.distinct states ||
   !(states.all fun s => Text.equal s.family "torsion-state") then
  throw "each rotor requires a complete positive finite held-state alphabet"
 let keys := reversal.map Prod.fst
 if !(states.all fun s => keys.any (sameLabel s)) ||
    !(keys.all fun k => states.any (sameLabel k)) ||
    !(states.all fun state => match reversalLookup reversal state with
       | none => false | some value => states.any (sameLabel value)) then
  throw "torsion reversal must cover every held state exactly once"
 if !(states.all fun state => match reversalLookup reversal state with
  | none => false
  | some value => match reversalLookup reversal value with
    | none => false | some twice => sameLabel twice state) then
  throw "torsion reversal must be an exact involution"
 return ⟨states,reversal⟩
def reverseState (a : Alphabet) (state : HeldLabel) : Except String HeldLabel :=
 match reversalLookup a.reversal state with
 | none => .error "torsion state is outside the registered alphabet"
 | some result => .ok result

structure Action where
 image : List PositiveCount

def action (image : List PositiveCount) : Except String Action :=
 if (uniquePositions image).length != image.length ||
   !((positions image.length).all (containsPosition image)) then
  .error "graph action must be a complete positive-position bijection"
 else .ok ⟨image⟩
def apply (a : Action) (position : PositiveCount) : Except String PositiveCount :=
 match MolecularGraphEnumeration.atIndex a.image (position.value-1) with
 | none => .error "tuple index out of range"
 | some value => .ok value

def allActions (g : Graph) : Except String (List Action) := do
 let candidates := MolecularGraphEnumeration.permutations ((positions g.atomTypes.length).map PositiveCount.value)
 let checked ← candidates.mapM fun values => do
  let a ← action (← values.mapM count)
  let atomMatches ← (positions g.atomTypes.length).mapM fun p => do
   let mapped ← apply a p
   match MolecularGraphEnumeration.atIndex g.atomTypes (p.value-1),
    MolecularGraphEnumeration.atIndex g.atomTypes (mapped.value-1) with
   | some x,some y => pure (sameLabel x y)
   | none, none | none, some _ | some _, none => throw "tuple index out of range"
  if !(atomMatches.all id) then return none
  let mapped ← g.bonds.mapM fun (left,right) => do orderedBond (← apply a left) (← apply a right)
  if (mapped.all fun b => g.bonds.any (sameBond b)) && (g.bonds.all fun b => mapped.any (sameBond b)) then
   return some a
  else return none
 let result := checked.filterMap id
 if result.isEmpty then throw "complete graph-automorphism enumeration returned structural EmptyOne"
 return result
end SFT.Chemistry.ConformerCarrier
