import SFT.Physics.VacuumAuthoritativeWitnesses
open SFT.Physics SFT.Host.Canonical VacuumAuthoritativeRecords VacuumAuthoritativeWitnesses
def fraction (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def main : IO Unit := do
 let floor ← IO.ofExcept (floorFromSources registeredSources)
 let polarization ← IO.ofExcept (polarizationFromSources registeredSources)
 let inertia ← IO.ofExcept (inertiaFromSources registeredSources)
 let extraction ← IO.ofExcept (extractionFromSources registeredSources)
 IO.println (render (.object [("sources",registeredSources),("floor",.text floor),
  ("polarization",.array [.text polarization.1,.object (polarization.2.map fun (k,v) => (k,fraction v))]),
  ("inertia",.text inertia),("extraction",.text extraction)]))
