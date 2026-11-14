import SFT.Physics.QuarkDressing
namespace SFT.Physics.CKMFibres
open LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
structure Result where
 massBasis : List Rat
 channelBasis : List Rat
 matrix : List (List Rat)

def sourceIndex {α : Type} : List α → Nat → Option α
 | [],_ => none
 | x::_,0 => some x
 | _::xs,n+1 => sourceIndex xs n

def ckmFibres : Except String Result := do
 let c ← FoldFirstReturn.generatorPeriod
 let mass ← (List.range c).mapM fun i =>
  LeptonRatios.divide (wholeRatio (c*(i+1)-1)) (wholeRatio (c*c))
 let channel ← (List.range c).mapM fun i =>
  LeptonRatios.divide (wholeRatio (i+1)) (wholeRatio c)
 let matrix := mass.map fun m => channel.map fun v =>
  subtract (wholeRatio 1) (if m.blt v then subtract v m else subtract m v)
 let diagonal := (List.range c).map fun i => (sourceIndex ((sourceIndex matrix i).getD []) i).getD zero
 let expected : Rat := ⟨8,9,by decide,by decide⟩
 if !(decide (diagonal=List.replicate c expected)) then
  throw "CKM fibre diagonal did not close"
 pure ⟨mass,channel,matrix⟩

def originalRecord : Result :=
 ⟨[⟨2,9,by decide,by decide⟩,⟨5,9,by decide,by decide⟩,⟨8,9,by decide,by decide⟩],
  [⟨1,3,by decide,by decide⟩,⟨2,3,by decide,by decide⟩,⟨1,1,by decide,by decide⟩],
  [[⟨8,9,by decide,by decide⟩,⟨5,9,by decide,by decide⟩,⟨2,9,by decide,by decide⟩],
   [⟨7,9,by decide,by decide⟩,⟨8,9,by decide,by decide⟩,⟨5,9,by decide,by decide⟩],
   [⟨4,9,by decide,by decide⟩,⟨7,9,by decide,by decide⟩,⟨8,9,by decide,by decide⟩]]⟩

theorem completeSourceRecord : ckmFibres=.ok originalRecord := rfl

theorem completeNineCells : (originalRecord.matrix.map List.length)=[3,3,3] := rfl

theorem originalDiagonal : (List.range 3).map (fun i => (sourceIndex ((sourceIndex originalRecord.matrix i).getD []) i).getD zero)=
 List.replicate 3 (⟨8,9,by decide,by decide⟩ : Rat) := rfl
end SFT.Physics.CKMFibres
