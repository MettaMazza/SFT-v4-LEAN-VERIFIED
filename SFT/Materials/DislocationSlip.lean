import SFT.Materials.DislocationCircuit
namespace SFT.Materials.DislocationSlip
open DislocationCircuit

structure System where
 reference : Lattice.Record
 line : Line reference
 site : String
 onLine : site ∈ line.support
 plane : List String
 planeHeld : ∀ x, x ∈ plane → x ∈ reference.cells.graph.nodes
 startsInPlane : site ∈ plane
 compatible : ∀ x, x ∈ plane →
  transport (line.circuit site onLine) x ∈ plane
 observationBoundary : SFT.Host.Canonical.Value

def position (s : System) (n : Nat) :=
 Lattice.translate (wholeTranslation (s.line.circuit s.site s.onLine)) n s.site

theorem successorUsesSameBurgersAction (s : System) (n : Nat) :
 position s (n+1) = transport (s.line.circuit s.site s.onLine) (position s n) := rfl

theorem everyPositionOnPlane (s : System) (n : Nat) : position s n ∈ s.plane := by
 induction n with
 | zero => exact s.startsInPlane
 | succ n ih => exact s.compatible _ ih

theorem everyPositionOnCarrier (s : System) (n : Nat) :
 position s n ∈ s.reference.cells.graph.nodes :=
 everySlipOnCarrier s.line s.site s.onLine n

theorem firstAdvanceIsHeldMismatch (s : System) : position s 1 ≠ s.site :=
 firstSlipIsNonclosing s.line s.site s.onLine

theorem constituentWordRetained (s : System) (n : Nat) :
 s.reference.word (position s n) = s.reference.word s.site :=
 everySlipRetainsWord s.line s.site s.onLine n

theorem everyPlaneAdjacencyRetained (s : System) (n : Nat) (x y : String)
 (hx : x ∈ s.plane) (hy : y ∈ s.plane) :
 (Lattice.translate (wholeTranslation (s.line.circuit s.site s.onLine)) n x,
  Lattice.translate (wholeTranslation (s.line.circuit s.site s.onLine)) n y) ∈ s.reference.cells.graph.edges ↔
 (x,y) ∈ s.reference.cells.graph.edges :=
 everySlipRetainsAdjacency s.line s.site s.onLine n x y (s.planeHeld x hx) (s.planeHeld y hy)

def history (s : System) (n : Nat) := slipHistory s.line s.site s.onLine n

theorem countedWholeAdvance (s : System) (n : Nat) : (history s n).length = n+1 :=
 slipHistoryComplete s.line s.site s.onLine n

theorem priorAdvanceRetained (s : System) (n : Nat) (prior : String) (held : prior ∈ history s n) :
 prior ∈ history s (n+1) := previousSlipRetained s.line s.site s.onLine n prior held

def record (s : System) (n : Nat) := (s,n,history s n)

theorem dislocationRecordRetained (s : System) (n : Nat) :
 (record s n).1.line = s.line := rfl

theorem slipSystemBoundaryRetained (s : System) (n : Nat) :
 (record s n).1.observationBoundary = s.observationBoundary := rfl

def records (rows : List (System × Nat)) := rows.map (fun row => record row.1 row.2)

theorem base (s : System) (n : Nat) : records [(s,n)] = [record s n] := rfl

theorem successor (rows : List (System × Nat)) (s : System) (n : Nat) :
 records (rows ++ [(s,n)]) = records rows ++ [record s n] := by
 induction rows with
 | nil => rfl
 | cons head rest ih => exact congrArg (List.cons (record head.1 head.2)) ih

end SFT.Materials.DislocationSlip
