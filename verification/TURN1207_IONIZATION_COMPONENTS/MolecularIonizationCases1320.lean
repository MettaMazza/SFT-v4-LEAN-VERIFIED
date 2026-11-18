import SFT.Chemistry.MolecularIonization
open SFT.Host SFT.Host.Canonical SFT.Chemistry.MolecularIonization
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def ratioValue (r : SFT.Chemistry.DihedralTorsion.Ratio) : Value := .array [.integer r.numerator.value,.integer r.denominator.value]
def result {α : Type} (encode : α → Value) : Except String α → Value
 | .error e => .object [("error",.text e)]
 | .ok v => .object [("ok",encode v)]
def main : IO Unit := IO.println (render (.array [
result ratioValue (orderedIonizationTake (.ratio ⟨⟨8,by decide⟩,⟨1,by decide⟩⟩) (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩)),
result ratioValue (orderedIonizationTake (.ratio ⟨⟨16,by decide⟩,⟨2,by decide⟩⟩) (.ratio ⟨⟨6,by decide⟩,⟨2,by decide⟩⟩)),
result ratioValue (orderedIonizationTake (.ratio ⟨⟨9,by decide⟩,⟨2,by decide⟩⟩) (.ratio ⟨⟨3,by decide⟩,⟨2,by decide⟩⟩)),
result ratioValue (orderedIonizationTake (.ratio ⟨⟨5,by decide⟩,⟨7,by decide⟩⟩) (.ratio ⟨⟨2,by decide⟩,⟨7,by decide⟩⟩)),
result ratioValue (orderedIonizationTake (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩) (.ratio ⟨⟨6,by decide⟩,⟨2,by decide⟩⟩)),
result ratioValue (orderedIonizationTake (.ratio ⟨⟨3,by decide⟩,⟨7,by decide⟩⟩) (.ratio ⟨⟨8,by decide⟩,⟨7,by decide⟩⟩)),
result ratioValue (orderedIonizationTake (.ratio ⟨⟨1,by decide⟩,⟨2,by decide⟩⟩) (.ratio ⟨⟨1,by decide⟩,⟨3,by decide⟩⟩)),
result ratioValue (orderedIonizationTake (.ratio ⟨⟨137,by decide⟩,⟨29,by decide⟩⟩) (.ratio ⟨⟨23,by decide⟩,⟨31,by decide⟩⟩)),
result ratioValue (orderedIonizationTake (.invalid) (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩)),
result ratioValue (orderedIonizationTake (.ratio ⟨⟨8,by decide⟩,⟨1,by decide⟩⟩) (.invalid)),
result ratioValue (leastAdiabaticTake (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩) (.tuple [])),
result ratioValue (leastAdiabaticTake (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩) (.tuple [.ratio ⟨⟨8,by decide⟩,⟨1,by decide⟩⟩])),
result ratioValue (leastAdiabaticTake (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩) (.tuple [.ratio ⟨⟨8,by decide⟩,⟨1,by decide⟩⟩,.ratio ⟨⟨6,by decide⟩,⟨1,by decide⟩⟩,.ratio ⟨⟨7,by decide⟩,⟨1,by decide⟩⟩])),
result ratioValue (leastAdiabaticTake (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩) (.tuple [.ratio ⟨⟨7,by decide⟩,⟨1,by decide⟩⟩,.ratio ⟨⟨8,by decide⟩,⟨1,by decide⟩⟩,.ratio ⟨⟨6,by decide⟩,⟨1,by decide⟩⟩])),
result ratioValue (leastAdiabaticTake (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩) (.tuple [.ratio ⟨⟨12,by decide⟩,⟨2,by decide⟩⟩,.ratio ⟨⟨6,by decide⟩,⟨1,by decide⟩⟩,.ratio ⟨⟨8,by decide⟩,⟨1,by decide⟩⟩])),
result ratioValue (leastAdiabaticTake (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩) (.tuple [.ratio ⟨⟨8,by decide⟩,⟨1,by decide⟩⟩,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩])),
result ratioValue (leastAdiabaticTake (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩) (.tuple [.ratio ⟨⟨9,by decide⟩,⟨2,by decide⟩⟩,.ratio ⟨⟨7,by decide⟩,⟨2,by decide⟩⟩,.ratio ⟨⟨8,by decide⟩,⟨2,by decide⟩⟩])),
result ratioValue (leastAdiabaticTake initial .other),
result ratioValue (leastAdiabaticTake initial (.tuple [.invalid])),
result Value.boolean (verticalNotBelowAdiabatic initial (.tuple [.ratio ⟨⟨8,by decide⟩,⟨1,by decide⟩⟩,.ratio ⟨⟨6,by decide⟩,⟨1,by decide⟩⟩,.ratio ⟨⟨7,by decide⟩,⟨1,by decide⟩⟩]) (.ratio ⟨⟨8,by decide⟩,⟨1,by decide⟩⟩)),
result Value.boolean (verticalNotBelowAdiabatic initial (.tuple [.ratio ⟨⟨8,by decide⟩,⟨1,by decide⟩⟩,.ratio ⟨⟨6,by decide⟩,⟨1,by decide⟩⟩,.ratio ⟨⟨7,by decide⟩,⟨1,by decide⟩⟩]) (.ratio ⟨⟨6,by decide⟩,⟨1,by decide⟩⟩)),
result Value.boolean (verticalNotBelowAdiabatic initial (.tuple [.ratio ⟨⟨8,by decide⟩,⟨1,by decide⟩⟩,.ratio ⟨⟨6,by decide⟩,⟨1,by decide⟩⟩,.ratio ⟨⟨7,by decide⟩,⟨1,by decide⟩⟩]) (.ratio ⟨⟨7,by decide⟩,⟨1,by decide⟩⟩)),
result Value.boolean (verticalNotBelowAdiabatic initial (.tuple [.ratio ⟨⟨8,by decide⟩,⟨1,by decide⟩⟩,.ratio ⟨⟨6,by decide⟩,⟨1,by decide⟩⟩,.ratio ⟨⟨7,by decide⟩,⟨1,by decide⟩⟩]) (.ratio ⟨⟨9,by decide⟩,⟨1,by decide⟩⟩)),
result Value.boolean (verticalNotBelowAdiabatic initial (.tuple [.ratio ⟨⟨8,by decide⟩,⟨1,by decide⟩⟩,.ratio ⟨⟨6,by decide⟩,⟨1,by decide⟩⟩,.ratio ⟨⟨7,by decide⟩,⟨1,by decide⟩⟩]) (.ratio ⟨⟨14,by decide⟩,⟨2,by decide⟩⟩)),
result Value.boolean (verticalNotBelowAdiabatic initial (.tuple []) (.ratio ⟨⟨7,by decide⟩,⟨1,by decide⟩⟩)),
result Value.boolean (verticalNotBelowAdiabatic initial (.tuple [.ratio ⟨⟨2,by decide⟩,⟨1,by decide⟩⟩,.ratio ⟨⟨8,by decide⟩,⟨1,by decide⟩⟩]) (.ratio ⟨⟨8,by decide⟩,⟨1,by decide⟩⟩)),
result Value.boolean (verticalNotBelowAdiabatic initial (.tuple [.ratio ⟨⟨12,by decide⟩,⟨2,by decide⟩⟩,.ratio ⟨⟨7,by decide⟩,⟨1,by decide⟩⟩]) (.ratio ⟨⟨6,by decide⟩,⟨1,by decide⟩⟩)),
result Value.boolean (verticalNotBelowAdiabatic initial (.tuple [.ratio ⟨⟨12,by decide⟩,⟨2,by decide⟩⟩,.ratio ⟨⟨7,by decide⟩,⟨1,by decide⟩⟩]) (.ratio ⟨⟨12,by decide⟩,⟨2,by decide⟩⟩)),
result (fun _ => .boolean true) (validateCarrier ⟨⟨"molecular-species","held",rfl,rfl⟩,⟨"initial-molecular-state","held",rfl,rfl⟩,⟨"initial-molecular-conformation","held",rfl,rfl⟩,⟨"resulting-ionic-state","held",rfl,rfl⟩,⟨"removed-carrier","held",rfl,rfl⟩,⟨"held-removal-orientation","held",rfl,rfl⟩,⟨"ionization-path","held",rfl,rfl⟩,⟨"measurement-condition","held",rfl,rfl⟩⟩),
result (fun _ => .boolean true) (validateCarrier ⟨⟨"wrong","held",rfl,rfl⟩,⟨"initial-molecular-state","held",rfl,rfl⟩,⟨"initial-molecular-conformation","held",rfl,rfl⟩,⟨"resulting-ionic-state","held",rfl,rfl⟩,⟨"removed-carrier","held",rfl,rfl⟩,⟨"held-removal-orientation","held",rfl,rfl⟩,⟨"ionization-path","held",rfl,rfl⟩,⟨"measurement-condition","held",rfl,rfl⟩⟩),
result (fun _ => .boolean true) (validateCarrier ⟨⟨"molecular-species","held",rfl,rfl⟩,⟨"wrong","held",rfl,rfl⟩,⟨"initial-molecular-conformation","held",rfl,rfl⟩,⟨"resulting-ionic-state","held",rfl,rfl⟩,⟨"removed-carrier","held",rfl,rfl⟩,⟨"held-removal-orientation","held",rfl,rfl⟩,⟨"ionization-path","held",rfl,rfl⟩,⟨"measurement-condition","held",rfl,rfl⟩⟩),
result (fun _ => .boolean true) (validateCarrier ⟨⟨"molecular-species","held",rfl,rfl⟩,⟨"initial-molecular-state","held",rfl,rfl⟩,⟨"wrong","held",rfl,rfl⟩,⟨"resulting-ionic-state","held",rfl,rfl⟩,⟨"removed-carrier","held",rfl,rfl⟩,⟨"held-removal-orientation","held",rfl,rfl⟩,⟨"ionization-path","held",rfl,rfl⟩,⟨"measurement-condition","held",rfl,rfl⟩⟩),
result (fun _ => .boolean true) (validateCarrier ⟨⟨"molecular-species","held",rfl,rfl⟩,⟨"initial-molecular-state","held",rfl,rfl⟩,⟨"initial-molecular-conformation","held",rfl,rfl⟩,⟨"wrong","held",rfl,rfl⟩,⟨"removed-carrier","held",rfl,rfl⟩,⟨"held-removal-orientation","held",rfl,rfl⟩,⟨"ionization-path","held",rfl,rfl⟩,⟨"measurement-condition","held",rfl,rfl⟩⟩),
result (fun _ => .boolean true) (validateCarrier ⟨⟨"molecular-species","held",rfl,rfl⟩,⟨"initial-molecular-state","held",rfl,rfl⟩,⟨"initial-molecular-conformation","held",rfl,rfl⟩,⟨"resulting-ionic-state","held",rfl,rfl⟩,⟨"wrong","held",rfl,rfl⟩,⟨"held-removal-orientation","held",rfl,rfl⟩,⟨"ionization-path","held",rfl,rfl⟩,⟨"measurement-condition","held",rfl,rfl⟩⟩),
result (fun _ => .boolean true) (validateCarrier ⟨⟨"molecular-species","held",rfl,rfl⟩,⟨"initial-molecular-state","held",rfl,rfl⟩,⟨"initial-molecular-conformation","held",rfl,rfl⟩,⟨"resulting-ionic-state","held",rfl,rfl⟩,⟨"removed-carrier","held",rfl,rfl⟩,⟨"wrong","held",rfl,rfl⟩,⟨"ionization-path","held",rfl,rfl⟩,⟨"measurement-condition","held",rfl,rfl⟩⟩),
result (fun _ => .boolean true) (validateCarrier ⟨⟨"molecular-species","held",rfl,rfl⟩,⟨"initial-molecular-state","held",rfl,rfl⟩,⟨"initial-molecular-conformation","held",rfl,rfl⟩,⟨"resulting-ionic-state","held",rfl,rfl⟩,⟨"removed-carrier","held",rfl,rfl⟩,⟨"held-removal-orientation","held",rfl,rfl⟩,⟨"wrong","held",rfl,rfl⟩,⟨"measurement-condition","held",rfl,rfl⟩⟩),
result (fun _ => .boolean true) (validateCarrier ⟨⟨"molecular-species","held",rfl,rfl⟩,⟨"initial-molecular-state","held",rfl,rfl⟩,⟨"initial-molecular-conformation","held",rfl,rfl⟩,⟨"resulting-ionic-state","held",rfl,rfl⟩,⟨"removed-carrier","held",rfl,rfl⟩,⟨"held-removal-orientation","held",rfl,rfl⟩,⟨"ionization-path","held",rfl,rfl⟩,⟨"wrong","held",rfl,rfl⟩⟩)]))
