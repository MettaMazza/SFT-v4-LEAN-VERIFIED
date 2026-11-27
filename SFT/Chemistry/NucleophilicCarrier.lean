import SFT.Chemistry.DihedralTorsion
namespace SFT.Chemistry.NucleophilicCarrier
open SFT.Host SFT.Physics.CapabilityValues
open DihedralTorsion (equalLabel equalLabels distinctAtoms)

structure Pair where
 first : HeldLabel
 second : HeldLabel
structure Bond where
 left : HeldLabel
 right : HeldLabel
 pair : Pair
structure FreePair where
 owner : HeldLabel
 pair : Pair
structure State where
 identity : HeldLabel
 atoms : List HeldLabel
 bonds : List Bond
 freePairs : List FreePair
structure Carrier where
 identity : HeldLabel
 centre : HeldLabel
 retained : HeldLabel
 entering : HeldLabel
 leaving : HeldLabel
 enteringPair : Pair
 leavingPair : Pair
 source : State
structure Transition where
 occurrence : PositiveCount
 entry : State
 exit : State
 action : HeldLabel

def occurrence (label : String) := heldLabel "substitution-atom-occurrence" label
def electron (label : String) := heldLabel "held-electron-occurrence" label
def pair (first second : HeldLabel) : Except String Pair := do
 if !Text.equal first.family "held-electron-occurrence" || !Text.equal second.family "held-electron-occurrence" || equalLabel first second then
  throw "a joining pair requires two distinct held electron occurrences"
 return ⟨first,second⟩
def bond (left right : HeldLabel) (joining : Pair) : Except String Bond := do
 if !Text.equal left.family "substitution-atom-occurrence" || !Text.equal right.family "substitution-atom-occurrence" || equalLabel left right then
  throw "a bond joins two distinct retained atom occurrences"
 return ⟨left,right,joining⟩
def freePair (owner : HeldLabel) (joining : Pair) : Except String FreePair := do
 if !Text.equal owner.family "substitution-atom-occurrence" then throw "a free pair requires one retained carrier occurrence"
 return ⟨owner,joining⟩
def samePair (a b : Pair) : Bool := equalLabel a.first b.first && equalLabel a.second b.second
def sameEdge (a b : HeldLabel × HeldLabel) : Bool :=
 (equalLabel a.1 b.1 && equalLabel a.2 b.2) || (equalLabel a.1 b.2 && equalLabel a.2 b.1)
def edge (b : Bond) := (b.left,b.right)
def sameBond (a b : Bond) : Bool := equalLabel a.left b.left && equalLabel a.right b.right && samePair a.pair b.pair
def sameFree (a b : FreePair) : Bool := equalLabel a.owner b.owner && samePair a.pair b.pair
-- Dataclass equality retains order; only endpoint/electron frozensets ignore it.
def sameSequence {α : Type} (equal : α → α → Bool) : List α → List α → Bool
 | [],[] => true
 | a::as,b::bs => equal a b && sameSequence equal as bs
 | [],_::_ | _::_,[] => false
def sameState (a b : State) : Bool := equalLabel a.identity b.identity && equalLabels a.atoms b.atoms &&
 sameSequence sameBond a.bonds b.bonds && sameSequence sameFree a.freePairs b.freePairs
def pairAtoms (p : Pair) : List HeldLabel :=
 if equalLabel p.first p.second then [p.first] else [p.first,p.second]
def electrons (state : State) : List HeldLabel :=
 state.bonds.flatMap (fun b => pairAtoms b.pair) ++ state.freePairs.flatMap (fun f => pairAtoms f.pair)
def contains (xs : List HeldLabel) (x : HeldLabel) : Bool := xs.any (equalLabel x)
def sameSet (a b : List HeldLabel) : Bool := a.all (contains b) && b.all (contains a)
def distinctEdges : List Bond → Bool
 | [] => true
 | b::bs => !(bs.any (fun c => sameEdge (edge b) (edge c))) && distinctEdges bs

def state (identity : HeldLabel) (atoms : List HeldLabel) (bonds : List Bond) (freePairs : List FreePair) : Except String State := do
 if !Text.equal identity.family "substitution-state" then throw "a substitution state requires one held state identity"
 if atoms.length<4 || !distinctAtoms atoms then throw "the complete substitution carrier requires distinct atom occurrences"
 if atoms.any (fun a => !Text.equal a.family "substitution-atom-occurrence") then throw "the substitution carrier contains an invalid atom occurrence"
 if bonds.any (fun b => !contains atoms b.left || !contains atoms b.right) then throw "a retained bond leaves the declared carrier"
 if freePairs.any (fun f => !contains atoms f.owner) then throw "a free pair leaves the declared carrier"
 if !distinctEdges bonds then throw "a bond occurrence cannot be duplicated"
 let out : State := ⟨identity,atoms,bonds,freePairs⟩
 if !distinctAtoms (electrons out) then throw "each held electron occurrence must occupy exactly one support"
 return out

-- Both original maps use last-value semantics. Free-pair owners need not be unique.
def bondAt (state : State) (key : HeldLabel × HeldLabel) : Option Pair :=
 match state.bonds.reverse.find? (fun b => sameEdge (edge b) key) with
 | none => none | some b => some b.pair
def freeAt (state : State) (owner : HeldLabel) : Option Pair :=
 match state.freePairs.reverse.find? (fun f => equalLabel f.owner owner) with
 | none => none | some f => some f.pair
def matchesPair (value : Option Pair) (wanted : Pair) : Bool :=
 match value with | none => false | some p => samePair p wanted
def present {α : Type} : Option α → Bool
 | none => false | some _ => true

def carrier (identity centre retained entering leaving : HeldLabel) (enteringPair leavingPair : Pair) (source : State) : Except String Carrier := do
 if !Text.equal identity.family "registered-reaction" then throw "substitution requires one registered reaction carrier"
 let roles := [centre,retained,entering,leaving]
 if !distinctAtoms roles || roles.any (fun a => !contains source.atoms a) then throw "substitution roles require four distinct retained occurrences"
 let retainedKey := (centre,retained)
 let leavingKey := (centre,leaving)
 if !present (bondAt source retainedKey) || !present (bondAt source leavingKey) then throw "source must contain the retained and displaced bonds"
 let extras := source.bonds.filter (fun b => !(sameEdge (edge b) retainedKey || sameEdge (edge b) leavingKey))
 if extras.any (fun b => [centre,entering,leaving].any (fun a => equalLabel a b.left || equalLabel a b.right)) then
  throw "source extensions cannot change the single exchange slot or free carriers"
 if !matchesPair (bondAt source leavingKey) leavingPair then throw "the displaced bond must retain its complete held pair"
 let enteringFree ← freePair entering enteringPair
 if !sameSequence sameFree source.freePairs [enteringFree] then throw "the entering carrier must hold exactly the entering pair"
 return ⟨identity,centre,retained,entering,leaving,enteringPair,leavingPair,source⟩

def transition (occurrence : PositiveCount) (entry exit : State) (action : HeldLabel) : Except String Transition := do
 if !Text.equal action.family "substitution-action" || !(["cleave-displaced-support","form-entering-support","exchange-support-in-one-transition"].any (Text.equal action.label)) then
  throw "transition action is outside the generated substitution alphabet"
 if !equalLabels entry.atoms exit.atoms then throw "every atom occurrence must survive a substitution transition"
 if !sameSet (electrons entry) (electrons exit) then throw "every held electron occurrence must survive a substitution transition"
 return ⟨occurrence,entry,exit,action⟩

def stateRole (c : Carrier) (s : State) : Except String String := do
 let retained := bondAt s (c.centre,c.retained)
 let leaving := bondAt s (c.centre,c.leaving)
 let entering := bondAt s (c.centre,c.entering)
 if !present retained then throw "the unchanged substrate bond must remain retained"
 if present leaving && present entering then throw "the single exchange slot cannot carry entering and leaving bonds together"
 if present leaving then
  if !matchesPair leaving c.leavingPair || !matchesPair (freeAt s c.entering) c.enteringPair then throw "source support allocation changed"
  return "source"
 if present entering then
  if !matchesPair entering c.enteringPair || !matchesPair (freeAt s c.leaving) c.leavingPair then throw "terminal support allocation changed"
  return "terminal"
 if matchesPair (freeAt s c.entering) c.enteringPair && matchesPair (freeAt s c.leaving) c.leavingPair then return "cleaved-intermediate"
 throw "state is not generated by the exact exchange support"
end SFT.Chemistry.NucleophilicCarrier
