import SFT.Physics.LeptonDecimal
import SFT.Physics.EvolutionExperiment
namespace SFT.Physics.EvolutionMeasuredSource
open SFT.Host SFT.Host.Canonical LeptonDecimal LeptonIntervals

def lineBreaks : List Nat := [10,11,12,13,28,29,30,133,8232,8233]

def linesFrom : List Char → List Char → List (List Char) → List (List Char)
 | [],current,prior => (current.reverse :: prior).reverse
 | c::cs,current,prior => if lineBreaks.contains c.toNat then
   linesFrom cs [] (current.reverse :: prior)
   else linesFrom cs (c::current) prior

def lines (cs : List Char) : List (List Char) := linesFrom cs [] []

def matchingRows (rows : List (List Char)) (quantity : String) : List (List Char) :=
 rows.filter fun row =>
  110 ≤ row.length && (strip (row.take 60)) == Text.chars quantity

structure Interval where
  quantity : String
  unit : String
  central : Rat
  lower : Rat
  upper : Rat
  uncertainty : String

def stripEllipsis : Nat → List Char → Nat × List Char
 | 0,cs => (0,cs)
 | n+1,[] => (0,[])
 | n+1,c::cs =>
  if (c::cs).take 3 == ['.','.','.'] then
   let result := stripEllipsis n ((c::cs).drop 3)
   (result.1+1,result.2)
  else
   let result := stripEllipsis n cs
   (result.1,c::result.2)

def finitePrefix (text : String) : Except String (Rat × Rat) := do
 let compact := strip ((Text.chars text).filter (fun c => c != ' '))
 let removed := stripEllipsis compact.length compact
 if removed.1 != 1 || compact.head? == some '-' || compact.head? == some '+' then
  .error "ValueError: measurement is not one positive finite decimal prefix"
 else do
  let (prefixText,expText) ← match split 'e' removed.2 with
   | [p] => .ok (p,['0'])
   | [p,e] => .ok (p,e)
   | [] | _::_::_::_ => .error "ValueError: too many values to unpack (expected 2)"
  let lower ← exactDecimal (String.ofList (if expText == ['0'] then prefixText else prefixText ++ ['e'] ++ expText))
  let places := match split '.' prefixText with | _::frac::_ => frac.length | [] | [_] => 0
  let exp ← match exponent expText with
   | some e => .ok e
   | none => .error "ValueError: invalid integer exponent"
  let next := match exp - Int.ofNat places with
   | .ofNat n => normalize (.ofNat (10^n)) 1 (by decide)
   | .negSucc n => normalize 1 (10^(n+1)) (Nat.pow_pos (by decide))
  .ok (lower,add lower next)

def makeInterval (quantity unit : String) (central lower upper : Rat) (uncertainty : String) : Except String Interval :=
 if !(CapabilityValues.nonblank quantity && CapabilityValues.nonblank unit && CapabilityValues.nonblank uncertainty) then
  .error "ValueError: measurement interval requires quantity, unit and uncertainty identity"
 else if !(zero.blt central && zero.blt lower && zero.blt upper) then
  .error "ValueError: measurement interval endpoints must be exact positive fractions"
 else if central.blt lower || upper.blt central then .error "ValueError: measurement interval is not ordered"
 else .ok ⟨quantity,unit,central,lower,upper,uncertainty⟩

def loadRows (rows : List (List Char)) (quantity unit : String) : Except String Interval := do
 let row ← match matchingRows rows quantity with
  | [row] => .ok row
  | [] | _::_::_ => .error (Text.append "ValueError: CODATA quantity must occur exactly once: " quantity)
 let valueRecord := String.ofList (strip ((row.drop 60).take 25))
 let uncertainty := String.ofList (strip ((row.drop 85).take 25))
 let actualUnit := String.ofList (strip (row.drop 110))
 if !Text.equal actualUnit unit then .error (Text.append "ValueError: CODATA unit differs for " quantity)
 else do
  let (lower,upper) ← if Text.contains valueRecord "..." then finitePrefix valueRecord
    else do let central ← exactDecimal valueRecord; .ok (central,central)
  if uncertainty == "(exact)" then makeInterval quantity unit lower lower upper uncertainty
  else do
   let delta ← exactDecimal uncertainty
   if !delta.blt lower then .error "ValueError: measurement uncertainty does not preserve a positive lower endpoint"
   else makeInterval quantity unit lower (subtract lower delta) (add upper delta) uncertainty

def ratioValue (x : Rat) : Except String CapabilityValues.Value :=
 if h : 0 < x.num.toNat then
  .ok (.ratio ⟨x.num.toNat,h⟩ ⟨x.den,Nat.pos_of_ne_zero x.den_nz⟩)
 else .error "ValueError: Fold measured values must remain positive"

def foldPair (x : Interval) : Except String CapabilityValues.Value := do
 .ok (.pair (← ratioValue x.lower) (← ratioValue x.upper))

def fraction (v : CapabilityValues.Value) : Except String Rat :=
 match v with
 | .ratio n d => .ok (normalize (.ofNat n.value) d.value d.positive)
 | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => .error "ValueError: measured-value prediction is not an exact Fold interval"

def endpoints (v : CapabilityValues.Value) : Except String (Rat × Rat) := do
 match v with
 | .pair a b =>
  let lower ← fraction a
  let upper ← fraction b
  if upper.blt lower then .error "ValueError: measured-value prediction interval is not ordered"
  else .ok (lower,upper)
 | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .table _ => .error "ValueError: measured-value prediction is not an exact Fold interval"

def overlap (a b : CapabilityValues.Value) : Except String Bool := do
 let (al,au) ← endpoints a
 let (bl,bu) ← endpoints b
 .ok (!(au.blt bl || bu.blt al))

def fractionJSON (x : Rat) : Value := .object [("numerator",.integer x.num),("denominator",.integer (.ofNat x.den))]
def intervalJSON (x : Rat × Rat) : Value := .array [fractionJSON x.1,fractionJSON x.2]
def fractionText (x : Rat) := Text.join [render (.integer x.num),"/",render (.integer (.ofNat x.den))]

def canonicalCount : Option Value → Except String CapabilityValues.PositiveCount
 | some (.object fs) => match CapabilityDocuments.field "value" fs with
   | some (.integer (.ofNat n)) => CapabilityValues.count n
   | none | some (.integer (.negSucc _)) | some (.text _) | some (.boolean _) | some .null | some (.array _) | some (.object _) =>
     .error "ValueError: measured-value prediction is not an exact Fold interval"
 | none | some (.text _) | some (.boolean _) | some (.integer _) | some .null | some (.array _) =>
   .error "ValueError: measured-value prediction is not an exact Fold interval"

def canonicalRatio : Value → Except String CapabilityValues.Value
 | .object fs => do
  let n ← canonicalCount (CapabilityDocuments.field "numerator" fs)
  let d ← canonicalCount (CapabilityDocuments.field "denominator" fs)
  .ok (.ratio n d)
 | .text _ | .boolean _ | .integer _ | .null | .array _ => .error "ValueError: measured-value prediction is not an exact Fold interval"

def canonicalPair : Value → Except String CapabilityValues.Value
 | .object fs => do
  match CapabilityDocuments.field "left" fs,CapabilityDocuments.field "right" fs with
  | some left,some right => .ok (.pair (← canonicalRatio left) (← canonicalRatio right))
  | none,none | none,some _ | some _,none => .error "ValueError: measured-value prediction is not an exact Fold interval"
 | .text _ | .boolean _ | .integer _ | .null | .array _ => .error "ValueError: measured-value prediction is not an exact Fold interval"

theorem intervalFieldsRetained (quantity unit : String) (central lower upper : Rat) (uncertainty : String)
    (result : Interval) (accepted : makeInterval quantity unit central lower upper uncertainty = .ok result) :
    result.quantity = quantity ∧ result.unit = unit ∧ result.central = central ∧
      result.lower = lower ∧ result.upper = upper ∧ result.uncertainty = uncertainty := by
  unfold makeInterval at accepted
  split at accepted
  · cases accepted
  · split at accepted
    · cases accepted
    · split at accepted
      · cases accepted
      · cases accepted; exact ⟨rfl,rfl,rfl,rfl,rfl,rfl⟩
end SFT.Physics.EvolutionMeasuredSource
