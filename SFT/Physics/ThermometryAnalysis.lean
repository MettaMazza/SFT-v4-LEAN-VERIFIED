import SFT.Host.Canonical
namespace SFT.Physics.ThermometryAnalysis
open SFT.Host.Canonical
structure Target where
 exact : Int
 acousticCenter : Int
 acousticUncertainty : Int
 electronicCenter : Int
 electronicUncertainty : Int
 scale : Int
 routes : Int
 accuracy : Int
 distinctRoutes : Bool
 kinetic : Bool
 johnson : Bool
 dyadicNotClaimed : Bool
 responseNotClaimed : Bool
 allRows : Bool

-- The original exact_thermal_analysis integer operation; Boolean fields encode
-- the source's literal identity tests (is True / is False), not truthiness.
def exactAnalysis (t : Target) : Value :=
 let a := (t.acousticCenter-t.acousticUncertainty,t.acousticCenter+t.acousticUncertainty)
 let e := (t.electronicCenter-t.electronicUncertainty,t.electronicCenter+t.electronicUncertainty)
 let positive := [a.1,a.2,e.1,e.2,t.exact,t.acousticUncertainty,t.electronicUncertainty,t.scale].all
   (fun x => @decide (0<x) (Int.decLt 0 x)) && decide (a.1≤a.2) && decide (e.1≤e.2)
 .object [
 ("positive_exact_carriers",.boolean positive),
 ("acoustic_interval",.array [.integer a.1,.integer a.2]),
 ("electronic_interval",.array [.integer e.1,.integer e.2]),
 ("acoustic_contains_exact",.boolean (decide (a.1≤t.exact) && decide (t.exact≤a.2))),
 ("electronic_contains_exact",.boolean (decide (e.1≤t.exact) && decide (t.exact≤e.2))),
 ("route_count_exact",.boolean (decide (t.routes=2))),
 ("routes_distinct",.boolean t.distinctRoutes),
 ("kinetic_temperature_relation",.boolean t.kinetic),
 ("johnson_response_relation",.boolean t.johnson),
 ("johnson_accuracy_retained",.boolean (decide (t.accuracy=1))),
 ("dyadic_direct_measurement_not_claimed",.boolean t.dyadicNotClaimed),
 ("fold_response_direct_measurement_not_claimed",.boolean t.responseNotClaimed),
 ("all_rows_retained",.boolean t.allRows)]

def registeredTarget : Target :=
 ⟨13806490,13806484,28,13806510,170,10^30,2,1,true,true,true,true,true,true⟩

theorem originalAcousticBounds :
 (registeredTarget.acousticCenter-registeredTarget.acousticUncertainty,
  registeredTarget.acousticCenter+registeredTarget.acousticUncertainty)=(13806456,13806512) := rfl

theorem originalElectronicBounds :
 (registeredTarget.electronicCenter-registeredTarget.electronicUncertainty,
  registeredTarget.electronicCenter+registeredTarget.electronicUncertainty)=(13806340,13806680) := rfl

theorem originalBothContain :
 (decide ((13806456:Int)≤registeredTarget.exact) && decide (registeredTarget.exact≤13806512)) &&
 (decide ((13806340:Int)≤registeredTarget.exact) && decide (registeredTarget.exact≤13806680))=true := rfl

theorem originalTamperedAcousticRejected :
 (decide ((13000000:Int)-registeredTarget.acousticUncertainty≤registeredTarget.exact) &&
  decide (registeredTarget.exact≤13000000+registeredTarget.acousticUncertainty))=false := rfl
end SFT.Physics.ThermometryAnalysis
