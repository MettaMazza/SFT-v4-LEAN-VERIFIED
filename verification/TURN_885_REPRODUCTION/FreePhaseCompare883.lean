import SFT.Physics.FreePhase
open SFT.Physics SFT.Host.Canonical FreePhase
def fraction (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def outcome (x : Except String Value) : Value := match x with | .ok v => .object [("ok",v)] | .error e => .object [("error",.text e)]
def main : IO Unit := do
 IO.println (render (outcome ((cyclicAdvance (.fraction ⟨1,3,by decide,by decide⟩) (.fraction ⟨1,4,by decide,by decide⟩)).map (fraction))))
 IO.println (render (outcome ((cyclicAdvance (.fraction ⟨1,3,by decide,by decide⟩) (.fraction ⟨8,3,by decide,by decide⟩)).map (fraction))))
 IO.println (render (outcome ((cyclicAdvance (.fraction ⟨1,1,by decide,by decide⟩) (.fraction ⟨1,1,by decide,by decide⟩)).map (fraction))))
 IO.println (render (outcome ((cyclicAdvance (.fraction ⟨1,2,by decide,by decide⟩) (.fraction ⟨1,2,by decide,by decide⟩)).map (fraction))))
 IO.println (render (outcome ((cyclicAdvance (.fraction ⟨0,1,by decide,by decide⟩) (.fraction ⟨1,2,by decide,by decide⟩)).map (fraction))))
 IO.println (render (outcome ((cyclicAdvance (.fraction ⟨2,1,by decide,by decide⟩) (.fraction ⟨1,2,by decide,by decide⟩)).map (fraction))))
 IO.println (render (outcome ((cyclicAdvance .nonFraction (.fraction ⟨1,2,by decide,by decide⟩)).map (fraction))))
 IO.println (render (outcome ((freeParticlePhase (.fraction ⟨1,3,by decide,by decide⟩) (.fraction ⟨1,4,by decide,by decide⟩)).map (fun x => Value.object [("momentum",fraction x.momentum),("dispersion",fraction x.dispersion),("phase_after",fraction x.phaseAfter)]))))
 IO.println (render (outcome ((freeParticlePhase (.fraction ⟨1,1,by decide,by decide⟩) (.fraction ⟨1,2,by decide,by decide⟩)).map (fun x => Value.object [("momentum",fraction x.momentum),("dispersion",fraction x.dispersion),("phase_after",fraction x.phaseAfter)]))))
 IO.println (render (outcome ((freeParticlePhase (.fraction ⟨1,2,by decide,by decide⟩) (.fraction ⟨2,3,by decide,by decide⟩)).map (fun x => Value.object [("momentum",fraction x.momentum),("dispersion",fraction x.dispersion),("phase_after",fraction x.phaseAfter)]))))
 IO.println (render (outcome ((potentialPhaseEvolution (.fraction ⟨1,3,by decide,by decide⟩) (.fraction ⟨1,8,by decide,by decide⟩) (.fraction ⟨1,4,by decide,by decide⟩)).map (fun x => Value.object [("kinetic",fraction x.1),("potential",fraction x.2.1),("total",fraction x.2.2.1),("phase_after",fraction x.2.2.2)]))))
 IO.println (render (outcome ((potentialPhaseEvolution (.fraction ⟨3,4,by decide,by decide⟩) (.fraction ⟨7,3,by decide,by decide⟩) (.fraction ⟨8,7,by decide,by decide⟩)).map (fun x => Value.object [("kinetic",fraction x.1),("potential",fraction x.2.1),("total",fraction x.2.2.1),("phase_after",fraction x.2.2.2)]))))
