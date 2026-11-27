import SFT.Chemistry.DefectChemistry
namespace SFT.Chemistry.DefectFormulaDerivation
open SFT.Physics.CapabilityValues DefectChemistry

def reading (f : FormulaEntry) : String × Nat := (f.species.label,f.primitiveCount.value)
def row (xs : List String) (divisor : Nat) (label : String) : Except String FormulaEntry := do
 let species ← heldLabel "chemical-species" label
 let n ← count (labelCount xs label / divisor)
 formulaEntry species n

theorem rowReading (xs : List String) (divisor : Nat) (label : String) (f : FormulaEntry)
 (h : row xs divisor label=.ok f) : reading f=(label,labelCount xs label/divisor) := by
 unfold row at h
 cases hs : heldLabel "chemical-species" label with
 | error err => rw [hs] at h; cases h
 | ok species =>
  rw [hs] at h
  change (do let n ← count (labelCount xs label/divisor); formulaEntry species n)=.ok f at h
  cases hn : count (labelCount xs label/divisor) with
  | error err => rw [hn] at h; cases h
  | ok n =>
   rw [hn] at h
   obtain ⟨hsp,hnum⟩ := SolidLocalDerivation.formulaEntryRetains species n f h
   have name : species.label=label := by
    unfold heldLabel at hs
    repeat first | split at hs | cases hs | rfl
   have number : n.value=labelCount xs label/divisor := by
    unfold count at hn
    repeat first | split at hn | cases hn | rfl
   unfold reading
   rw [hsp,hnum,name,number]

theorem rowVector (xs : List String) (divisor : Nat) (labels : List String) (out : List FormulaEntry)
 (h : labels.mapM (row xs divisor)=.ok out) :
 out.map reading=labels.map (fun label => (label,labelCount xs label/divisor)) := by
 let expected := fun label => (label,labelCount xs label/divisor)
 have rev : ∀ (fs acc : List FormulaEntry), (fs.reverseAux acc).map reading=(fs.map reading).reverseAux (acc.map reading) := by
  intro fs
  induction fs with
  | nil => intro acc; rfl
  | cons f fs ih => intro acc; exact ih (f::acc)
 have loop : ∀ (labels : List String) (acc result : List FormulaEntry),
  List.mapM.loop (row xs divisor) labels acc=.ok result →
  result.map reading=(acc.map reading).reverseAux (labels.map expected) := by
  intro labels
  induction labels with
  | nil =>
   intro acc result h
   change Except.ok acc.reverse=Except.ok result at h
   cases h
   exact rev acc []
  | cons label labels ih =>
   intro acc result h
   unfold List.mapM.loop at h
   cases hr : row xs divisor label with
   | error err => rw [hr] at h; cases h
   | ok f =>
    rw [hr] at h
    have tail := ih (f::acc) result h
    change result.map reading=(acc.map reading).reverseAux (reading f::labels.map expected) at tail
    rw [rowReading xs divisor label f hr] at tail
    exact tail
 exact loop labels [] out h

theorem completePrimitiveVector (xs : List String) (out : List FormulaEntry)
 (h : primitiveFormula xs=.ok out) :
 out.map reading=(orderedLabels xs).map (fun label => (label,labelCount xs label/(match (orderedLabels xs).map (labelCount xs) with | [] => 0 | n::ns => ns.foldl Nat.gcd n))) := by
 unfold primitiveFormula at h
 split at h
 · cases h
 · exact rowVector xs _ (orderedLabels xs) out h
end SFT.Chemistry.DefectFormulaDerivation
