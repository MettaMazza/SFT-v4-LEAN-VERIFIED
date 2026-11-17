import SFT.Chemistry.ConfigurationOrder
import SFT.Chemistry.ElectronSpinHtml
import SFT.Chemistry.JointCorrelationTargets
import SFT.Physics.LeptonDecimal
namespace SFT.Chemistry.ConfigurationObservation
open SFT.Host SFT.Host.Canonical SFT.Physics
open JointCorrelationTargets (field text integer)
abbrev J := Value
structure Parser where
 inRow : Bool := false
 inCell : Bool := false
 parts : List String := []
 row : List String := []
 rows : List (List String) := []
def startTag (p : Parser) (tag : String) : Parser :=
 if Text.equal (Text.lowerAscii tag) "tr" then {p with inRow:=true,row:=[]}
 else if p.inRow && (Text.equal (Text.lowerAscii tag) "td" || Text.equal (Text.lowerAscii tag) "th") then
  {p with inCell:=true,parts:=[]}
 else p
def endTag (p : Parser) (tag : String) : Parser :=
 if p.inCell && (Text.equal (Text.lowerAscii tag) "td" || Text.equal (Text.lowerAscii tag) "th") then
  {p with row:=p.row++[ElectronSpinHtml.normalizeSpace (Text.join p.parts)],inCell:=false}
 else if p.inRow && Text.equal (Text.lowerAscii tag) "tr" then
  {p with rows:=if p.row.isEmpty then p.rows else p.rows++[p.row],inRow:=false}
 else p
def handle (p : Parser) : ElectronSpinHtml.Event → Parser
 | .startTag tag _ => startTag p tag
 | .endTag tag => endTag p tag
 | .data s => if p.inCell then {p with parts:=p.parts++[s]} else p
def parseEvents (events : List ElectronSpinHtml.Event) : List (List String) :=
 (events.foldl handle {}).rows

def itemAt {A : Type} (xs : List A) (i : Nat) : Except String A :=
 match xs with
 | [] => .error "IndexError"
 | x::rest => match i with
   | 0 => .ok x
   | n+1 => itemAt rest n

def rowText (row : J) (key : String) : Except String String := field row key >>= text

def intEqual (a b : Int) : Bool := decide (a = b)

def reconstruct (events : List ElectronSpinHtml.Event) (registered : List J) : Except String (List J) := do
 let raw := (parseEvents events).filter fun r =>
  r.length == 4 && (Text.equal (r.headD "") "1" || Text.equal (r.headD "") "2") &&
  (match itemAt r 1 with | .error _ => false | .ok s => !s.isEmpty && (Text.chars s).all Char.isDigit)
 if raw.length != 50 || registered.length != 50 then throw "ELEC-011 complete path missing"
 let _ ← (raw.zip registered).zipIdx |>.mapM fun ((source,row),index) => do
  let wanted ← ["torsion_index","angle_inscription_degrees","energy_inscription_kj_mol","energy_inscription_cm_inverse"].mapM fun key => do
   let v ← field row key
   match v with
   | .integer n => pure (match n with | .ofNat k => toString k | .negSucc k => Text.append "-" (toString (k+1)))
   | .text s => pure s
   | .null | .boolean _ | .array _ | .object _ => throw "invalid source field"
  let position ← field row "path_position" >>= integer
  if !(wanted.zip source).all (fun (a,b) => Text.equal a b) || !intEqual position (Int.ofNat (index+1)) then
   throw "ELEC-011 source reconstruction differs"
 pure registered

-- The hash-bound source inscriptions include structural least-energy glyphs.
-- Reuse the exact decimal parser, retaining zero as EmptyOne at exactRepr.
def exact (inscription : String) : Except String Rat := do
 let compact := LeptonDecimal.strip ((Text.chars inscription).filter (fun c => c != ' '))
 let pieces := LeptonDecimal.split 'e' compact
 let (coefficientChars, exp) ← match pieces with
  | [] => throw "invalid decimal inscription"
  | coefficient::rest => match rest with
    | [] => pure (coefficient, (0 : Int))
    | exponentChars::tail =>
      if !tail.isEmpty then throw "invalid decimal inscription"
      match LeptonDecimal.exponent exponentChars with
      | none => throw "invalid exponent inscription"
      | some e => pure (coefficient,e)
 let (n,places) ← LeptonDecimal.coefficient coefficientChars
 if n == 0 then pure LeptonIntervals.zero
 else match exp with
  | .ofNat power => pure (LeptonIntervals.normalize (.ofNat (n*10^power)) (10^places) (Nat.pow_pos (by decide)))
  | .negSucc power => pure (LeptonIntervals.normalize (.ofNat n) (10^(places+(power+1))) (Nat.pow_pos (by decide)))

def intText : Int → String
 | .ofNat n => toString n
 | .negSucc n => Text.append "-" (toString (n+1))


def exactRepr (r : Rat) : Except String String :=
 if intEqual r.num 0 then .ok "EmptyOne(identity='empty-One')"
 else if r.num < 0 then .error "an SFT count must be a positive counted value"
 else .ok (Text.intercalate "" ["PositiveRatio(numerator=PositiveCount(value=",intText r.num,"), denominator=PositiveCount(value=",toString r.den,"))"])
structure Row where
 source : J
 kj : Rat
 cm : Rat

def readRow (source : J) : Except String Row := do
 let kj ← exact (← rowText source "energy_inscription_kj_mol")
 let cm ← exact (← rowText source "energy_inscription_cm_inverse")
 let _ ← exactRepr kj
 let _ ← exactRepr cm
 if (intEqual kj.num 0) != (intEqual cm.num 0) then throw "ELEC-011 unit surfaces disagree on absence"
 pure ⟨source,kj,cm⟩
structure Counts where
 positive : Nat := 0
 absence : Nat := 0
 basin : Nat := 0
 barrier : Nat := 0
 ordinary : Nat := 0
 recurrenceDuplicate : Nat := 0

def countHeight (counts : Counts) (value : Rat) : Counts :=
 if intEqual value.num 0 then {counts with absence:=counts.absence+1}
 else {counts with positive:=counts.positive+1}

def pathCounts (path : List Row) (counts : Counts) : Except String Counts := do
 let first ← itemAt path 0
 let last ← itemAt path (path.length-1)
 if !Text.equal (← rowText first.source "angle_inscription_degrees") "0" ||
  !Text.equal (← rowText last.source "angle_inscription_degrees") "360" ||
  !(intEqual first.kj.num last.kj.num && first.kj.den == last.kj.den) then throw "ELEC-011 recurrence differs"
 let unique := path.take (path.length-1)
 let counts := {counts with recurrenceDuplicate:=counts.recurrenceDuplicate+1}
 let counts ← unique.zipIdx.foldlM (fun counts (row,index) => do
  let left ← itemAt unique ((index+unique.length-1)%unique.length)
  let right ← itemAt unique ((index+1)%unique.length)
  let counted := countHeight counts row.kj
  if row.kj.blt left.kj && row.kj.blt right.kj then pure {counted with basin:=counted.basin+1}
  else if left.kj.blt row.kj && right.kj.blt row.kj then pure {counted with barrier:=counted.barrier+1}
  else pure {counted with ordinary:=counted.ordinary+1}) counts
 pure (countHeight counts last.kj)

def counts (rows : List Row) : Except String Counts := do
 let grouped ← rows.foldlM (fun (acc : List Row × List Row) row => do
  let group ← field row.source "torsion_index" >>= integer
  if intEqual group 1 then pure (acc.1++[row],acc.2)
  else if intEqual group 2 then pure (acc.1,acc.2++[row])
  else throw "KeyError") ([],[])
 pathCounts grouped.2 (← pathCounts grouped.1 {})
def countFields (c : Counts) : List (String × Nat) :=
 [("positive",c.positive),("absence",c.absence),("basin",c.basin),("barrier",c.barrier),("ordinary",c.ordinary),("recurrence_duplicate",c.recurrenceDuplicate)]
def countsPassed (c : Counts) : Bool :=
 c.positive == 46 && c.absence == 4 && c.basin == 6 && c.barrier == 6 && c.ordinary == 36 && c.recurrenceDuplicate == 2
end SFT.Chemistry.ConfigurationObservation
