from pathlib import Path
p=Path('work/constants-recovery/SFT/Physics/EvolutionMeasuredSource.lean');s=p.read_text();a=s.index('def finitePrefix');b=s.index('\ndef makeInterval',a)
s=s[:a]+'''def stripEllipsis : Nat → List Char → Nat × List Char
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
''' +s[b:]
s=s.replace('toString x.num','render (.integer x.num)').replace('toString x.den','render (.integer (.ofNat x.den))')
s=s.replace(' | _ => .error "ValueError: measured-value prediction is not an exact Fold interval"\n\ndef endpoints', ' | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => .error "ValueError: measured-value prediction is not an exact Fold interval"\n\ndef endpoints')
s=s.replace(' | _ => .error "ValueError: measured-value prediction is not an exact Fold interval"\n\ndef overlap',' | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .table _ => .error "ValueError: measured-value prediction is not an exact Fold interval"\n\ndef overlap')
a=s.index('def canonicalRatio');b=s.index('\ntheorem intervalFieldsRetained',a)
s=s[:a]+'''def canonicalCount : Option Value → Except String CapabilityValues.PositiveCount
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
''' +s[b:];p.write_text(s)
p=Path('work/constants-recovery/SFT/Physics/EvolutionMeasured.lean');s=p.read_text();a=s.index('  let text ← match String.fromUTF8? bytes');b=s.index('  let rows :=',a);s=s[:a]+'  let text := String.ofList (Text.decode bytes.size bytes.data.toList)\n'+s[b:];s=s.replace('!actualTargetId.startsWith "sha256:"','!Text.isPrefix "sha256:".toUTF8.data.toList actualTargetId.toUTF8.data.toList');p.write_text(s)
