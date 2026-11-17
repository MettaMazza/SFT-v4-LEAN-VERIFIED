import SFT.Chemistry.StateSymmetry
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.StateSymmetry
def labelValue (x : HeldLabel) : Canonical.Value := .object [("family",.text x.family),("label",.text x.label)]
def countValue (x : PositiveCount) : Canonical.Value := .object [("value",.integer (.ofNat x.value))]
def rankValue : AxisRank → Canonical.Value
 | .emptyOne s => .object [("identity",.text s)]
 | .count c => countValue c
def optionalValue : OptionalLabel → Canonical.Value
 | .emptyOne s => .object [("identity",.text s)]
 | .held h => labelValue h
def signatureValue (s : Signature) : Canonical.Value := .object [
 ("molecular_carrier",labelValue s.molecularCarrier),("positive_spin_multiplicity",countValue s.multiplicity),
 ("axis_rank",rankValue s.axisRank),("positive_axis_orientation_count",countValue s.orientationCount),
 ("inversion_label",optionalValue s.inversion),("reflection_label",optionalValue s.reflection),
 ("axis_component",optionalValue s.axisComponent),("component_kind",optionalValue s.componentKind)]
def classValue (c : EquivalenceClass) : Canonical.Value := .object [
 ("signature",signatureValue c.signature),("component_occurrences",.array (c.occurrences.map labelValue))]
def resultValue : Except String EquivalenceClass → Canonical.Value
 | .error e => .object [("error",.text e)]
 | .ok c => .object [("ok",classValue c)]
def results : List Canonical.Value := [
resultValue (fromSource "H2" ⟨1,by decide⟩ "Σ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨1,by decide⟩ "Π" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨1,by decide⟩ "Δ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨1,by decide⟩ "Φ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨2,by decide⟩ "Σ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨2,by decide⟩ "Π" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨2,by decide⟩ "Δ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨2,by decide⟩ "Φ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨3,by decide⟩ "Σ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨3,by decide⟩ "Π" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨3,by decide⟩ "Δ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨3,by decide⟩ "Φ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨4,by decide⟩ "Σ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨4,by decide⟩ "Π" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨4,by decide⟩ "Δ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨4,by decide⟩ "Φ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨5,by decide⟩ "Σ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨5,by decide⟩ "Π" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨5,by decide⟩ "Δ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨5,by decide⟩ "Φ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨6,by decide⟩ "Σ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨6,by decide⟩ "Π" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨6,by decide⟩ "Δ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨6,by decide⟩ "Φ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨7,by decide⟩ "Σ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨7,by decide⟩ "Π" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨7,by decide⟩ "Δ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨7,by decide⟩ "Φ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨8,by decide⟩ "Σ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨8,by decide⟩ "Π" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨8,by decide⟩ "Δ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨8,by decide⟩ "Φ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨9,by decide⟩ "Σ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨9,by decide⟩ "Π" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨9,by decide⟩ "Δ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨9,by decide⟩ "Φ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨10,by decide⟩ "Σ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨10,by decide⟩ "Π" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨10,by decide⟩ "Δ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨10,by decide⟩ "Φ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨11,by decide⟩ "Σ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨11,by decide⟩ "Π" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨11,by decide⟩ "Δ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨11,by decide⟩ "Φ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨12,by decide⟩ "Σ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨12,by decide⟩ "Π" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨12,by decide⟩ "Δ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "H2" ⟨12,by decide⟩ "Φ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "NO" ⟨2,by decide⟩ "Π" "absence" "absence" "absence" "r" >>= buildClass),
resultValue (fromSource "H2" ⟨1,by decide⟩ "Σ" "g" "plus-fibre" "absence" "absence" >>= buildClass),
resultValue (fromSource "x" ⟨1,by decide⟩ "invalid" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "" ⟨1,by decide⟩ "Σ" "absence" "absence" "absence" "absence" >>= buildClass),
resultValue (fromSource "x" ⟨1,by decide⟩ "Σ" "" "absence" "absence" "absence" >>= buildClass)
]
def main : IO Unit := IO.println (Canonical.render (.array results))
