import SFT.Physics.SymmetryActionIndexArrangements
import SFT.Mathematics.LimitComputations
import SFT.Host.Text
namespace SFT.Physics.SymmetryActionClasses
open SFT.Mathematics.LimitComputations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev Edge := Int × Int × Rat
def indexAt {α : Type} : List α → Nat → Option α
 | [], _ => none
 | value::_, 0 => some value
 | _::rest, n+1 => indexAt rest n
def tupleAt {α : Type} (items : List α) (index : Int) : Except String α :=
 match index with
 | .ofNat n => match indexAt items n with
   | none => .error "IndexError: tuple index out of range"
   | some value => .ok value
 | .negSucc n => if n<items.length then
    match indexAt items (items.length-(n+1)) with
    | none => .error "IndexError: tuple index out of range"
    | some value => .ok value
   else .error "IndexError: tuple index out of range"
def chargeChecks (permutation : List Int) (charges : List String) : List Nat → Except String Bool
 | [] => .ok true
 | index::rest => do
  let mapped ← tupleAt permutation (.ofNat index)
  let source ← tupleAt charges (.ofNat index)
  let target ← tupleAt charges mapped
  if SFT.Host.Text.equal source target then chargeChecks permutation charges rest else pure false
def symmetryPreservesCharge (permutation : List Int) (charges : List String) : Except String Bool :=
 chargeChecks permutation charges (List.range charges.length)
def selectCharges (charges : List String) : List (List Nat) → Except String (List (List Int))
 | [] => .ok []
 | permutation::rest => do
  let mapped := permutation.map Int.ofNat
  let keep ← symmetryPreservesCharge mapped charges
  let tail ← selectCharges charges rest
  pure (if keep then mapped::tail else tail)
def chargePreservingBijections (charges : List String) : Except String (List (List Int)) :=
 if charges.isEmpty then .error "a conserved partition requires generated support"
 else selectCharges charges (SymmetryActionIndexArrangements.arrangementsCore (List.range charges.length))
def edgeEqual (a b : Edge) : Bool := equalInt a.1 b.1 && equalInt a.2.1 b.2.1 && equalRat a.2.2 b.2.2
def edgeChecks (permutation : List Int) (held : List Edge) : List Edge → Except String Bool
 | [] => .ok true
 | (source,target,carrier)::rest => do
  let mappedSource ← tupleAt permutation source
  let mappedTarget ← tupleAt permutation target
  if held.any (fun e => edgeEqual (mappedSource,mappedTarget,carrier) e) then
   edgeChecks permutation held rest
  else pure false
def preservesEdgesAndCarriers (permutation : List Int) (edges : List Edge) : Except String Bool :=
 edgeChecks permutation edges edges
def selectEdges (edges : List Edge) : List (List Int) → Except String (List (List Int))
 | [] => .ok []
 | permutation::rest => do
  let keep ← preservesEdgesAndCarriers permutation edges
  let tail ← selectEdges edges rest
  pure (if keep then permutation::tail else tail)
def completeSymmetryClass (charges : List String) (edges : List Edge) : Except String (List (List Int)) := do
 let permutations ← chargePreservingBijections charges
 selectEdges edges permutations
end SFT.Physics.SymmetryActionClasses
