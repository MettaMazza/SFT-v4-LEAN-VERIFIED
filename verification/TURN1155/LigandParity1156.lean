import SFT.Chemistry.LigandDenticity
open SFT.Chemistry.LigandDenticity
open SFT.Physics.CapabilityValues
def label (h : HeldLabel) := h.family++":"++h.label
def labels (xs : List HeldLabel) := String.intercalate ";" (xs.map label)
def showRecord (r : Record) := String.intercalate "|" [label r.carrier,label r.central,toString r.denticity.value,labels r.donors,labels r.attachments,labels r.internalConnections,label r.state,labels r.closedTrace]
def main : IO Unit := do
 for n in List.range 12 do
  let e ← IO.ofExcept (entity (n+1))
  let t ← IO.ofExcept (topology (n+1))
  let r ← IO.ofExcept (forced e t)
  IO.println (showRecord r)
