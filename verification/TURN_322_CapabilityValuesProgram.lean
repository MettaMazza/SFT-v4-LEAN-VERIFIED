import SFT.Physics.CapabilityValues
namespace SFT.Physics.CapabilityValues
def v0 : Value := .emptyOne "empty-One"
def v1 : Value := .emptyOne "custom-empty"
def v2 : Value := .count ⟨1,by decide⟩
def v3 : Value := .count ⟨2,by decide⟩
def v4 : Value := .ratio ⟨1,by decide⟩ ⟨2,by decide⟩
def v5 : Value := .ratio ⟨2,by decide⟩ ⟨4,by decide⟩
def v6 : Value := .label ⟨"f","x",by decide,by decide⟩
def v7 : Value := .label ⟨"f","y",by decide,by decide⟩
def v8 : Value := .label ⟨"unicode","λ😀",by decide,by decide⟩
def v9 : Value := .word []
def v10 : Value := .word [(.count ⟨1,by decide⟩),(.emptyOne "empty-One")]
def v11 : Value := .pair (.count ⟨1,by decide⟩) (.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)
def v12 : Value := .table [(.label ⟨"f","x",by decide,by decide⟩,.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.label ⟨"f","y",by decide,by decide⟩,.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]
def v13 : Value := .word [(.table [(.label ⟨"f","x",by decide,by decide⟩,.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.label ⟨"f","y",by decide,by decide⟩,.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]),(.label ⟨"unicode","λ😀",by decide,by decide⟩),(.word [(.count ⟨1,by decide⟩),(.emptyOne "empty-One")])]
end SFT.Physics.CapabilityValues
open SFT.Physics.CapabilityValues
def main : IO Unit := do
  IO.println (identity v0)
  IO.println (identity v1)
  IO.println (identity v2)
  IO.println (identity v3)
  IO.println (identity v4)
  IO.println (identity v5)
  IO.println (identity v6)
  IO.println (identity v7)
  IO.println (identity v8)
  IO.println (identity v9)
  IO.println (identity v10)
  IO.println (identity v11)
  IO.println (identity v12)
  IO.println (identity v13)
