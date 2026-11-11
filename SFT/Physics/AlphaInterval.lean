import SFT.Physics.LeptonSource
import SFT.Physics.AlphaRatio
namespace SFT.Physics.AlphaInterval
open LeptonSource LeptonDecimal LeptonIntervals LeptonIsolation SFT.Host
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000

def quantity := "inverse fine-structure constant"

-- The original alpha-specific guard and messages, using the established parser.
def sourceIntervalRows (rows : List (List Char)) : Except String (Rat × Rat × Rat) :=
 match matchingRows rows quantity with
 | [] => .error "ValueError: CODATA inverse fine-structure row must occur exactly once"
 | row::rest => match rest with
   | _::_ => .error "ValueError: CODATA inverse fine-structure row must occur exactly once"
   | [] => do
     let central ← exactDecimal (String.ofList (strip ((row.drop 60).take 25)))
     let uncertainty ← exactDecimal (String.ofList (strip ((row.drop 85).take 25)))
     if !uncertainty.blt central then
       .error "ValueError: CODATA uncertainty does not preserve a positive interval"
     else .ok (subtract central uncertainty,central,add central uncertainty)

def sourceInterval (text : String) : Except String (Rat × Rat × Rat) :=
 sourceIntervalRows (lines (Text.chars text))

def sealedRatio : Except String Rat := do
 let p ← AlphaRatio.inverseFineStructure none
 pure (BoundaryGrowth.asFraction p)

def inInterval (lower upper : Rat) : Except String Bool := do
 let ratio ← sealedRatio
 pure (!(ratio.blt lower) && !(upper.blt ratio))

def precheckRows (rows : List (List Char)) : Except String Unit := do
 let (lower,_,upper) ← sourceIntervalRows rows
 let inside ← inInterval lower upper
 if inside then .ok () else .error "ValueError: sealed terminal inverse alpha is outside the source interval"

def lower : Rat := endpoint 137035999156 1000000000 (by decide)
def central : Rat := endpoint 137035999177 1000000000 (by decide)
def upper : Rat := endpoint 137035999198 1000000000 (by decide)

theorem registeredInterval : sourceIntervalRows snapshotRows=.ok (lower,central,upper) := rfl
theorem exactIntervalPassed : inInterval lower upper=.ok true := rfl
theorem centralRetained : (lower.blt central && central.blt upper)=true := rfl

theorem registeredPasses : precheckRows snapshotRows=.ok () := by
 unfold precheckRows
 rw [registeredInterval]
 change (do let inside ← inInterval lower upper
            if inside then .ok () else .error "ValueError: sealed terminal inverse alpha is outside the source interval")=.ok ()
 rw [exactIntervalPassed]
 rfl

theorem missingRowRejected (rows : List (List Char))
 (missing : matchingRows rows quantity=[]) :
 sourceIntervalRows rows=.error "ValueError: CODATA inverse fine-structure row must occur exactly once" := by
 unfold sourceIntervalRows
 rw [missing]

theorem repeatedRowRejected (rows : List (List Char)) (first second : List Char) (rest : List (List Char))
 (repeated : matchingRows rows quantity=first::second::rest) :
 sourceIntervalRows rows=.error "ValueError: CODATA inverse fine-structure row must occur exactly once" := by
 unfold sourceIntervalRows
 rw [repeated]

def validateWith {α : Type} (rows : List (List Char)) (blind : Unit → Except String α) : Except String α := do
 precheckRows rows
 blind ()

theorem registeredDelegates {α : Type} (blind : Unit → Except String α) :
 validateWith snapshotRows blind=blind () := by
 unfold validateWith
 rw [registeredPasses]
 rfl

theorem failedRecordStops {α : Type} (rows : List (List Char)) (blind : Unit → Except String α)
 (message : String) (failed : precheckRows rows=.error message) :
 validateWith rows blind=.error message := by
 unfold validateWith
 rw [failed]
 rfl

end SFT.Physics.AlphaInterval
