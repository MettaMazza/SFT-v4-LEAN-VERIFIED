import SFT.Physics.StellarResponses
namespace SFT.Physics.StellarTides
open SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Row where
 spin : Nat
 orbit : Nat
 mismatchBefore : Nat
 mismatchAfter : Nat
 direction : String
 deriving DecidableEq
def lockRow (base : Nat) : Row := ⟨base,base,0,0,"one-to-one-lock"⟩
def surplusRow (base excess : Nat) (spinSurplus : Bool) : Row :=
 if spinSurplus then ⟨base+excess,base,excess+1,excess,"spin-surplus-transferred"⟩
 else ⟨base,base+excess,excess+1,excess,"orbit-surplus-transferred"⟩
-- Recursion removes exactly one surplus cycle, preserving the original row order.
def traceFrom (base : Nat) (spinSurplus : Bool) : Nat → List Row
 | 0 => [lockRow base]
 | excess+1 => surplusRow base excess spinSurplus :: traceFrom base spinSurplus excess
def tidalDissipationTrace : GeneratorOperations.CountInput → GeneratorOperations.CountInput → Except String (List Row)
 | .integer (.ofNat (spin+1)),.integer (.ofNat (orbit+1)) =>
   if spin+1 > orbit+1 then .ok (traceFrom (orbit+1) true ((spin+1)-(orbit+1)))
   else .ok (traceFrom (spin+1) false ((orbit+1)-(spin+1)))
 | .boolean _,_ | .integer (.negSucc _),_ | .integer (.ofNat 0),_ | _,.boolean _ | _,.integer (.negSucc _) | _,.integer (.ofNat 0) => .error "cycle counts must be positive wholes"
def rowValue (row : Row) : Value := .object [("spin",.integer (.ofNat row.spin)),("orbit",.integer (.ofNat row.orbit)),("mismatch_before",.integer (.ofNat row.mismatchBefore)),("mismatch_after",.integer (.ofNat row.mismatchAfter)),("direction",.text row.direction)]
def naturalCount : GeneratorOperations.CountInput → Except String Nat
 | .integer (.ofNat a)=>.ok a
 | .integer (.negSucc _) | .boolean _=>.error "cycle counts must be positive wholes"
def tidalTerminal (spin orbit : GeneratorOperations.CountInput) : Except String Value := do
 let trace ← tidalDissipationTrace spin orbit
 let terminal ← match trace.getLast? with | some row=>.ok row | none=>.error "empty tidal trace"
 let a ← naturalCount spin
 let b ← naturalCount orbit
 pure (.object [("trace",.array (trace.map rowValue)),("finite",.boolean (trace.length==a-b+(b-a)+1)),("strictly_dissipative_before_lock",.boolean (trace.dropLast.all (fun row=>row.mismatchAfter<row.mismatchBefore))),("terminal_ratio",.array [.integer (.ofNat terminal.spin),.integer (.ofNat terminal.orbit)]),("terminal_one_to_one",.boolean (terminal.spin==terminal.orbit)),("external_forcing_or_eccentric_resonance_boundary",.text "separate-generated-boundary")])
theorem completeTraceLength (base excess : Nat) (direction : Bool) : (traceFrom base direction excess).length=excess+1 := by
 induction excess with
 | zero=>rfl
 | succ n ih=>exact congrArg Nat.succ ih
theorem completeTraceTerminal (base excess : Nat) (direction : Bool) : (traceFrom base direction excess).getLast?=some (lockRow base) := by
 induction excess with
 | zero=>rfl
 | succ n ih=>
  cases n with
  | zero=>rfl
  | succ k=>exact ih
theorem everySurplusStrictlyDecreases (base excess : Nat) (direction : Bool) :
 (surplusRow base excess direction).mismatchAfter < (surplusRow base excess direction).mismatchBefore := by
 cases direction <;> exact Nat.lt_succ_self excess
#print axioms tidalDissipationTrace
#print axioms tidalTerminal
#print axioms completeTraceLength
#print axioms completeTraceTerminal
#print axioms everySurplusStrictlyDecreases
end SFT.Physics.StellarTides
