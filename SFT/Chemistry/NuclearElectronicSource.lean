import SFT.Chemistry.StateEnergySourceTables
import SFT.Chemistry.JointCorrelationTargets
import SFT.Chemistry.NuclearElectronic
namespace SFT.Chemistry.NuclearElectronicSource
open SFT.Host SFT.Physics.CapabilityValues
open ElectronSpinHtml (decimal)
abbrev J := Canonical.Value
-- The original TERM_PATTERN searches anywhere, rather than requiring a whole term.
def termHere (cs : List Char) : Bool := match cs with
 | [] => false
 | c::rest =>
  if c.toNat != 94 then false else
  match rest with
  | [] => false
  | d::ds =>
   if !(49 ≤ d.toNat && d.toNat ≤ 57) then false else
   match ds.dropWhile decimal with
   | [] => false
   | symbol::_ => [931,928,916,934].contains symbol.toNat

def hasTerm : List Char → Bool
 | [] => false
 | c::cs => termHere (c::cs) || hasTerm cs

def stateRows (events : List ElectronSpinHtml.Event) : List (List String) :=
 (StateEnergySourceTables.parseEvents events).rows.filter fun row =>
  row.length == 13 && hasTerm (Text.chars (row.headD ""))

def startsChars : List Char → List Char → Bool
 | [],_ => true
 | _::_,[] => false
 | a::as,b::bs => a.toNat == b.toNat && startsChars as bs

def afterChars (needle : List Char) : List Char → Option (List Char)
 | [] => if needle.isEmpty then some [] else none
 | c::cs => if startsChars needle (c::cs) then some ((c::cs).drop needle.length) else afterChars needle cs

-- WEIGHT_PATTERN uses a non-greedy DOTALL span and retains the first following text.
def molecularWeight (html : String) : Except String String := do
 let tail ← match afterChars (Text.chars "Molecular weight") (Text.chars html) with
  | none => throw "ELEC-012 molecular weight missing"
  | some cs => pure cs
 let tail ← match afterChars (Text.chars "</a>:</strong>") tail with
  | none => throw "ELEC-012 molecular weight missing"
  | some cs => pure cs
 let text := (tail.dropWhile whitespace).takeWhile (fun c => c.toNat != 60)
 if text.isEmpty && (tail.takeWhile whitespace).isEmpty then throw "ELEC-012 molecular weight missing"
 return String.ofList ((text.reverse.dropWhile whitespace).reverse)

structure Snapshot where
 path : String
 actualHash : String
 html : String
 events : List ElectronSpinHtml.Event

structure Identity where
 targetId : String
 snapshotPath : String
 snapshotHash : String
 stateRowOrdinal : Int
 nuclearIsotopeLabels : List String

structure Target where
 targetId : String
 stateCells : List String
 molecularWeightInscription : String
 nuclearIsotopeLabels : List String
 retained : J

def targetDictionary (rows : List Target) : List Target := rows.foldl (fun acc row =>
 if acc.any (fun x => Text.equal x.targetId row.targetId) then
  acc.map (fun x => if Text.equal x.targetId row.targetId then row else x)
 else acc ++ [row]) []

def atNat {α : Type} : List α → Nat → Except String α
 | [],_ => .error "tuple index out of range"
 | x::_,0 => .ok x
 | _::xs,n+1 => atNat xs n

def atInt {α : Type} (xs : List α) (i : Int) : Except String α :=
 match i with
 | .ofNat n => atNat xs n
 | .negSucc n => if n+1 ≤ xs.length then atNat xs (xs.length-(n+1)) else .error "tuple index out of range"

def rows (identities : List Identity) (targets : List Target) (snapshots : List Snapshot) : Except String (List J) := do
 let byId := targetDictionary targets
 if identities.length != 95 || byId.length != 95 then throw "ELEC-012 complete row surface missing"
 identities.mapM fun identity => do
  let snapshot ← match snapshots.find? (fun s => Text.equal s.path identity.snapshotPath) with
   | none => throw "ELEC-012 NIST snapshot changed"
   | some s => pure s
  if !Text.equal snapshot.actualHash identity.snapshotHash then throw "ELEC-012 NIST snapshot changed"
  let weight ← molecularWeight snapshot.html
  let raw ← atInt (stateRows snapshot.events) (identity.stateRowOrdinal-1)
  let target ← match byId.find? (fun t => Text.equal t.targetId identity.targetId) with
   | none => throw (Text.intercalate "" ["'",identity.targetId,"'"])
   | some t => pure t
  if !NuclearElectronic.equalNuclear raw target.stateCells || !Text.equal weight target.molecularWeightInscription ||
   !NuclearElectronic.equalNuclear identity.nuclearIsotopeLabels target.nuclearIsotopeLabels then
   throw "ELEC-012 independent source reconstruction differs"
  return target.retained
end SFT.Chemistry.NuclearElectronicSource
