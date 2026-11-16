import SFT.Physics.ThermalEquilibriumResponseCertificate
namespace SFT.Physics.ThermalEquilibriumCertificateProof
open ThermalEquilibriumResponseCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem originalCertificateFlags : certificate.toOption.map
 (fun c => (c.temperature,c.equilibrium,c.canonical,c.weights,c.fluctuation,c.noise)) =
 some (true,true,true,true,true,true) := by decide +kernel

theorem originalCertificate : certificate = .ok ⟨true,true,true,true,true,true⟩ := by
 have flags := originalCertificateFlags
 cases h : certificate with
 | error e => rw [h] at flags; cases flags
 | ok c =>
   cases c with
   | mk t e c w f n =>
     rw [h] at flags
     change some (t,e,c,w,f,n)=some (true,true,true,true,true,true) at flags
     have same := Option.some.inj flags
     cases same
     rfl
end SFT.Physics.ThermalEquilibriumCertificateProof
