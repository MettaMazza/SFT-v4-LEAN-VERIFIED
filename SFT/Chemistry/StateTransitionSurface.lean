import SFT.Chemistry.StateSymmetrySource
namespace SFT.Chemistry.StateTransitionSurface
abbrev Event := ElectronSpinHtml.Event
structure Parser where
 depth : Nat := 0
 inRow : Bool := false
 inCell : Bool := false
 parts : List String := []
 row : List String := []
 rows : List (List String) := []
-- Both original parsers use the same depth/row/cell transition operations.
-- Reuse the verified implementation and retain this source's field names.
def parseEvents (events : List Event) : Parser :=
 let p := StateSymmetrySource.parseEvents events
 ⟨p.tableDepth,p.inRow,p.inCell,p.cellParts,p.currentRow,p.rows⟩
end SFT.Chemistry.StateTransitionSurface
