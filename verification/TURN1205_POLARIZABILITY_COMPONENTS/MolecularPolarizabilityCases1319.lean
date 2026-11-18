import SFT.Chemistry.MolecularPolarizability
open SFT.Host SFT.Host.Canonical SFT.Chemistry.MolecularPolarizability
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def ratioValue (r : SFT.Chemistry.DihedralTorsion.Ratio) : Value := .array [.integer r.numerator.value,.integer r.denominator.value]
def componentValue (c : Component) : Value := .array [.text c.axis.family,.text c.axis.label,ratioValue c.induced,ratioValue c.electric]
def result {α : Type} (encode : α → Value) : Except String α → Value
 | .error e => .object [("error",.text e)]
 | .ok v => .object [("ok",encode v)]
def main : IO Unit := IO.println (render (.array [
result ratioValue (.ok (exactResponse ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨6,by decide⟩,⟨1,by decide⟩⟩,⟨⟨2,by decide⟩,⟨1,by decide⟩⟩⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨6,by decide⟩,⟨1,by decide⟩⟩,⟨⟨2,by decide⟩,⟨1,by decide⟩⟩⟩) (.count ⟨1,by decide⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨6,by decide⟩,⟨1,by decide⟩⟩,⟨⟨2,by decide⟩,⟨1,by decide⟩⟩⟩) (.count ⟨2,by decide⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨6,by decide⟩,⟨1,by decide⟩⟩,⟨⟨2,by decide⟩,⟨1,by decide⟩⟩⟩) (.count ⟨5,by decide⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨6,by decide⟩,⟨1,by decide⟩⟩,⟨⟨2,by decide⟩,⟨1,by decide⟩⟩⟩) (.count ⟨11,by decide⟩)),
result ratioValue (.ok (exactResponse ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨2,by decide⟩,⟨4,by decide⟩⟩,⟨⟨6,by decide⟩,⟨8,by decide⟩⟩⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨2,by decide⟩,⟨4,by decide⟩⟩,⟨⟨6,by decide⟩,⟨8,by decide⟩⟩⟩) (.count ⟨1,by decide⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨2,by decide⟩,⟨4,by decide⟩⟩,⟨⟨6,by decide⟩,⟨8,by decide⟩⟩⟩) (.count ⟨2,by decide⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨2,by decide⟩,⟨4,by decide⟩⟩,⟨⟨6,by decide⟩,⟨8,by decide⟩⟩⟩) (.count ⟨5,by decide⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨2,by decide⟩,⟨4,by decide⟩⟩,⟨⟨6,by decide⟩,⟨8,by decide⟩⟩⟩) (.count ⟨11,by decide⟩)),
result ratioValue (.ok (exactResponse ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨1,by decide⟩,⟨9,by decide⟩⟩,⟨⟨7,by decide⟩,⟨5,by decide⟩⟩⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨1,by decide⟩,⟨9,by decide⟩⟩,⟨⟨7,by decide⟩,⟨5,by decide⟩⟩⟩) (.count ⟨1,by decide⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨1,by decide⟩,⟨9,by decide⟩⟩,⟨⟨7,by decide⟩,⟨5,by decide⟩⟩⟩) (.count ⟨2,by decide⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨1,by decide⟩,⟨9,by decide⟩⟩,⟨⟨7,by decide⟩,⟨5,by decide⟩⟩⟩) (.count ⟨5,by decide⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨1,by decide⟩,⟨9,by decide⟩⟩,⟨⟨7,by decide⟩,⟨5,by decide⟩⟩⟩) (.count ⟨11,by decide⟩)),
result ratioValue (.ok (exactResponse ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨11,by decide⟩,⟨13,by decide⟩⟩,⟨⟨17,by decide⟩,⟨19,by decide⟩⟩⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨11,by decide⟩,⟨13,by decide⟩⟩,⟨⟨17,by decide⟩,⟨19,by decide⟩⟩⟩) (.count ⟨1,by decide⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨11,by decide⟩,⟨13,by decide⟩⟩,⟨⟨17,by decide⟩,⟨19,by decide⟩⟩⟩) (.count ⟨2,by decide⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨11,by decide⟩,⟨13,by decide⟩⟩,⟨⟨17,by decide⟩,⟨19,by decide⟩⟩⟩) (.count ⟨5,by decide⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨11,by decide⟩,⟨13,by decide⟩⟩,⟨⟨17,by decide⟩,⟨19,by decide⟩⟩⟩) (.count ⟨11,by decide⟩)),
result ratioValue (.ok (exactResponse ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨12,by decide⟩,⟨6,by decide⟩⟩,⟨⟨3,by decide⟩,⟨9,by decide⟩⟩⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨12,by decide⟩,⟨6,by decide⟩⟩,⟨⟨3,by decide⟩,⟨9,by decide⟩⟩⟩) (.count ⟨1,by decide⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨12,by decide⟩,⟨6,by decide⟩⟩,⟨⟨3,by decide⟩,⟨9,by decide⟩⟩⟩) (.count ⟨2,by decide⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨12,by decide⟩,⟨6,by decide⟩⟩,⟨⟨3,by decide⟩,⟨9,by decide⟩⟩⟩) (.count ⟨5,by decide⟩)),
result componentValue (repeatedEqualFieldResponse (.component ⟨⟨"molecular-response-axis","a",rfl,rfl⟩,⟨⟨12,by decide⟩,⟨6,by decide⟩⟩,⟨⟨3,by decide⟩,⟨9,by decide⟩⟩⟩) (.count ⟨11,by decide⟩)),
result componentValue (repeatedEqualFieldResponse .invalid (.count ⟨1,by decide⟩)),
result componentValue (repeatedEqualFieldResponse (.component witnessComponent) .invalid),
result componentValue (component ⟨"wrong","a",rfl,rfl⟩ (.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩) (.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩)),
result componentValue (component axisA .invalid (.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩)),
result componentValue (component axisA (.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩) .invalid),
result ratioValue (exactIsotropicResponse (.tuple [])),
result ratioValue (exactIsotropicResponse (.tuple [.component firstComponent])),
result ratioValue (exactIsotropicResponse (.tuple [.component firstComponent,.component secondComponent])),
result ratioValue (exactIsotropicResponse (.tuple [.component firstComponent,.component secondComponent,.component thirdComponent])),
result ratioValue (exactIsotropicResponse (.tuple [.component firstComponent,.component firstComponent,.component thirdComponent])),
result ratioValue (exactIsotropicResponse (.tuple [.component firstComponent,.component secondComponent,.component thirdComponent,.component firstComponent])),
result ratioValue (exactIsotropicResponse (.tuple [.component thirdComponent,.component secondComponent,.component firstComponent])),
result ratioValue (exactIsotropicResponse .other),
result ratioValue (exactIsotropicResponse (.tuple [.component firstComponent,.invalid,.component thirdComponent])),
result (fun _ => .boolean true) (validateCarrier ⟨⟨"molecular-species","held",rfl,rfl⟩,⟨"molecular-state","held",rfl,rfl⟩,⟨"molecular-conformation","held",rfl,rfl⟩,⟨"external-electric-distinction","held",rfl,rfl⟩,⟨"polarizability-definition","held",rfl,rfl⟩,⟨"measurement-method","held",rfl,rfl⟩,⟨"measurement-condition","held",rfl,rfl⟩,⟨"measurement-unit","held",rfl,rfl⟩⟩),
result (fun _ => .boolean true) (validateCarrier ⟨⟨"wrong","held",rfl,rfl⟩,⟨"molecular-state","held",rfl,rfl⟩,⟨"molecular-conformation","held",rfl,rfl⟩,⟨"external-electric-distinction","held",rfl,rfl⟩,⟨"polarizability-definition","held",rfl,rfl⟩,⟨"measurement-method","held",rfl,rfl⟩,⟨"measurement-condition","held",rfl,rfl⟩,⟨"measurement-unit","held",rfl,rfl⟩⟩),
result (fun _ => .boolean true) (validateCarrier ⟨⟨"molecular-species","held",rfl,rfl⟩,⟨"wrong","held",rfl,rfl⟩,⟨"molecular-conformation","held",rfl,rfl⟩,⟨"external-electric-distinction","held",rfl,rfl⟩,⟨"polarizability-definition","held",rfl,rfl⟩,⟨"measurement-method","held",rfl,rfl⟩,⟨"measurement-condition","held",rfl,rfl⟩,⟨"measurement-unit","held",rfl,rfl⟩⟩),
result (fun _ => .boolean true) (validateCarrier ⟨⟨"molecular-species","held",rfl,rfl⟩,⟨"molecular-state","held",rfl,rfl⟩,⟨"wrong","held",rfl,rfl⟩,⟨"external-electric-distinction","held",rfl,rfl⟩,⟨"polarizability-definition","held",rfl,rfl⟩,⟨"measurement-method","held",rfl,rfl⟩,⟨"measurement-condition","held",rfl,rfl⟩,⟨"measurement-unit","held",rfl,rfl⟩⟩),
result (fun _ => .boolean true) (validateCarrier ⟨⟨"molecular-species","held",rfl,rfl⟩,⟨"molecular-state","held",rfl,rfl⟩,⟨"molecular-conformation","held",rfl,rfl⟩,⟨"wrong","held",rfl,rfl⟩,⟨"polarizability-definition","held",rfl,rfl⟩,⟨"measurement-method","held",rfl,rfl⟩,⟨"measurement-condition","held",rfl,rfl⟩,⟨"measurement-unit","held",rfl,rfl⟩⟩),
result (fun _ => .boolean true) (validateCarrier ⟨⟨"molecular-species","held",rfl,rfl⟩,⟨"molecular-state","held",rfl,rfl⟩,⟨"molecular-conformation","held",rfl,rfl⟩,⟨"external-electric-distinction","held",rfl,rfl⟩,⟨"wrong","held",rfl,rfl⟩,⟨"measurement-method","held",rfl,rfl⟩,⟨"measurement-condition","held",rfl,rfl⟩,⟨"measurement-unit","held",rfl,rfl⟩⟩),
result (fun _ => .boolean true) (validateCarrier ⟨⟨"molecular-species","held",rfl,rfl⟩,⟨"molecular-state","held",rfl,rfl⟩,⟨"molecular-conformation","held",rfl,rfl⟩,⟨"external-electric-distinction","held",rfl,rfl⟩,⟨"polarizability-definition","held",rfl,rfl⟩,⟨"wrong","held",rfl,rfl⟩,⟨"measurement-condition","held",rfl,rfl⟩,⟨"measurement-unit","held",rfl,rfl⟩⟩),
result (fun _ => .boolean true) (validateCarrier ⟨⟨"molecular-species","held",rfl,rfl⟩,⟨"molecular-state","held",rfl,rfl⟩,⟨"molecular-conformation","held",rfl,rfl⟩,⟨"external-electric-distinction","held",rfl,rfl⟩,⟨"polarizability-definition","held",rfl,rfl⟩,⟨"measurement-method","held",rfl,rfl⟩,⟨"wrong","held",rfl,rfl⟩,⟨"measurement-unit","held",rfl,rfl⟩⟩),
result (fun _ => .boolean true) (validateCarrier ⟨⟨"molecular-species","held",rfl,rfl⟩,⟨"molecular-state","held",rfl,rfl⟩,⟨"molecular-conformation","held",rfl,rfl⟩,⟨"external-electric-distinction","held",rfl,rfl⟩,⟨"polarizability-definition","held",rfl,rfl⟩,⟨"measurement-method","held",rfl,rfl⟩,⟨"measurement-condition","held",rfl,rfl⟩,⟨"wrong","held",rfl,rfl⟩⟩)]))
