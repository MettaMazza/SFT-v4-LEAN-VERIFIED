import SFT.Chemistry.SelectionRule
open SFT.Chemistry.SelectionRule
def showSignature : Option StateSignature → String
 | none => "none"
 | some s => String.intercalate ":" [s.state.family,s.state.label,toString s.multiplicity.value,s.inversion.family,s.inversion.label,s.axis.family,s.axis.label]
def showRecord : Except String (SelectionRecord Unit) → String
 | .error e => "error:"++e
 | .ok r => String.intercalate "|" [showSignature r.initial,showSignature r.terminal,r.observationClass.family,r.observationClass.label,(match r.mediatorOrAbsence with | .emptyOne => "EMPTY_ONE" | .held h => h.family++":"++h.label | .other _ => "OTHER"),r.retainedRecord.family,r.retainedRecord.label]
def main : IO Unit := do
 let s0 ← IO.ofExcept (signature "S0" 1 "g" "Σ")
 let s1 ← IO.ofExcept (signature "S1" 1 "g" "Π")
 let s2 ← IO.ofExcept (signature "S2" 1 "g" "Δ")
 let s3 ← IO.ofExcept (signature "S3" 1 "g" "Φ")
 let s4 ← IO.ofExcept (signature "S4" 1 "g" "other")
 let s5 ← IO.ofExcept (signature "S5" 1 "u" "Σ")
 let s6 ← IO.ofExcept (signature "S6" 1 "u" "Π")
 let s7 ← IO.ofExcept (signature "S7" 1 "u" "Δ")
 let s8 ← IO.ofExcept (signature "S8" 1 "u" "Φ")
 let s9 ← IO.ofExcept (signature "S9" 1 "u" "other")
 let s10 ← IO.ofExcept (signature "S10" 1 "?" "Σ")
 let s11 ← IO.ofExcept (signature "S11" 1 "?" "Π")
 let s12 ← IO.ofExcept (signature "S12" 1 "?" "Δ")
 let s13 ← IO.ofExcept (signature "S13" 1 "?" "Φ")
 let s14 ← IO.ofExcept (signature "S14" 1 "?" "other")
 let s15 ← IO.ofExcept (signature "S15" 2 "g" "Σ")
 let s16 ← IO.ofExcept (signature "S16" 2 "g" "Π")
 let s17 ← IO.ofExcept (signature "S17" 2 "g" "Δ")
 let s18 ← IO.ofExcept (signature "S18" 2 "g" "Φ")
 let s19 ← IO.ofExcept (signature "S19" 2 "g" "other")
 let s20 ← IO.ofExcept (signature "S20" 2 "u" "Σ")
 let s21 ← IO.ofExcept (signature "S21" 2 "u" "Π")
 let s22 ← IO.ofExcept (signature "S22" 2 "u" "Δ")
 let s23 ← IO.ofExcept (signature "S23" 2 "u" "Φ")
 let s24 ← IO.ofExcept (signature "S24" 2 "u" "other")
 let s25 ← IO.ofExcept (signature "S25" 2 "?" "Σ")
 let s26 ← IO.ofExcept (signature "S26" 2 "?" "Π")
 let s27 ← IO.ofExcept (signature "S27" 2 "?" "Δ")
 let s28 ← IO.ofExcept (signature "S28" 2 "?" "Φ")
 let s29 ← IO.ofExcept (signature "S29" 2 "?" "other")
 for a in [s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29] do
  for b in [s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29] do
   IO.println (toString (directObservationAllowed a b))
 for a in [none,some s0,some s1,some s4,some s5,some s15] do
  for b in [none,some s0,some s1,some s4,some s5,some s15] do
   for observed in [false,true] do
    for coupled in [false,true] do
     for mediator in [none,some "bridge",some ""] do
      IO.println (showRecord (classifyObservation a b "record" observed coupled mediator))
