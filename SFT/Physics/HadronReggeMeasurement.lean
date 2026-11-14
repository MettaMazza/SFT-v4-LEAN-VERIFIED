import SFT.Physics.HadronReggeProofs
import SFT.Physics.HadronReggeRecords
import SFT.Physics.CosmicComponentTransportMeasurement
namespace SFT.Physics.HadronReggeMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals HadronReggeRecords VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev Interval := Rat × Rat
def label : String := "sealed-nine-equals-eight-plus-one-and-twenty-seven-equals-ten-plus-eight-plus-eight-plus-one-match-PDG__complete-five-state-natural-parity-mass-vector-is-strictly-ordered__literal-common-squared-mass-step-is-rejected-by-complete-reported-intervals__exact-affine-Fold-law-retained-at-normalized-fixed-carrier-boundary__rho5-summary-omission-status-retained"
def trajectoryRows (record : Value) : Except String (List Value) := do
 let sources ← field record "sources"
 let summary ← array (← field (← field sources "pdg_2025_meson_summary") "reported_record")
 let listing ← field (← field sources "pdg_2025_rho5_listing") "reported_record"
 let rows := summary ++ [listing]
 let spins ← rows.mapM (fun row => field row "spin_J")
 if !sameValue (.array spins) (.array [.integer 1,.integer 2,.integer 3,.integer 4,.integer 5]) then
  throw "complete positive spin ordering changed"
 pure rows
def exactMassInterval (row : Value) : Except String Interval := do
 let centre ← decimalField row "mass_MeV"
 let uncertainty ← decimalField row "standard_uncertainty_MeV"
 let lower ← RunningConvergence.positiveTake centre uncertainty
 pure (lower,add centre uncertainty)
def squaredMassIntervalGeV2 (row : Value) : Except String Interval := do
 let (lower,upper) ← exactMassInterval row
 let l ← LeptonRatios.divide lower (wholeRatio 1000)
 let u ← LeptonRatios.divide upper (wholeRatio 1000)
 pure (multiply l l,multiply u u)
def successiveSquaredMassSteps (record : Value) : Except String (List Interval) := do
 let squares ← (← trajectoryRows record).mapM squaredMassIntervalGeV2
 (squares.zip (squares.drop 1)).mapM fun (previous,successor) => do
  let lower ← RunningConvergence.positiveTake successor.1 previous.2
  let upper ← RunningConvergence.positiveTake successor.2 previous.1
  if upper.blt lower then throw "measured squared-mass ordering failed"
  pure (lower,upper)
def exactCommonStepExists (record : Value) : Except String Bool := do
 let steps ← successiveSquaredMassSteps record
 match steps with
 | [] => .error "max() arg is an empty sequence"
 | first :: rest =>
  let greatest := rest.foldl (fun acc row => if acc.blt row.1 then row.1 else acc) first.1
  let least := rest.foldl (fun acc row => if row.2.blt acc then row.2 else acc) first.2
  pure (!least.blt greatest)
def intervalText (row : Interval) : Value := .array [.text (CosmicComponentTransportMeasurement.fractionText row.1),.text (CosmicComponentTransportMeasurement.fractionText row.2)]
def measurementAnalysis (record : Value) : Except String Value := do
 let rows ← trajectoryRows record
 let squares ← rows.mapM squaredMassIntervalGeV2
 let steps ← successiveSquaredMassSteps record
 let trajectory ← (rows.zip squares).mapM fun (row,square) => do
  let mass ← exactMassInterval row
  pure (Value.object [("state",← field row "state"),("spin_J",← field row "spin_J"),("JPC",← field row "JPC"),("mass_kind",← field row "mass_kind"),("mass_interval_MeV",intervalText mass),("squared_mass_interval_GeV2",intervalText square),("table_status",← field row "table_status")])
 pure (.object [("trajectory_rows",.array trajectory),("successive_squared_mass_step_intervals_GeV2",.array (steps.map intervalText)),("common_step_intersection_exists",.boolean (← exactCommonStepExists record)),("classification",.text "strict-order-and-Regge-scale-correspondence-with-literal-exact-equal-step-rejected-at-reported-interval-boundary"),("no_fit_performed",.boolean true),("no_residual_correction_admitted",.boolean true)])
def classificationFromRecord (record : Value) : Except String String := do
 let sources ← field record "sources"
 let model ← field (← field sources "pdg_quark_model") "reported_record"
 if !sameValue (← field model "light_flavours") (.array [.text "u",.text "d",.text "s"]) then throw "PDG light-flavour support changed"
 if !sameValue (← field model "light_meson_combination_count") (.integer 9) || !sameValue (← field model "light_meson_partition") (.array [.integer 8,.integer 1]) then throw "PDG meson multiplet record changed"
 if !sameValue (← field model "light_baryon_ordered_support_count") (.integer 27) || !sameValue (← field model "light_baryon_partition") (.array [.integer 10,.integer 8,.integer 8,.integer 1]) then throw "PDG baryon multiplet record changed"
 if !sameValue (← field model "minimal_meson_content") (.text "q-antiquark") || !sameValue (← field model "minimal_baryon_content") (.text "qqq") then throw "PDG minimal hadron composition record changed"
 if !Text.contains (← text (← field model "exotic_boundary")) "non-minimal multiquark" then throw "PDG exotic-composite boundary was omitted"
 let m ← HadronRegge.mesonMultipletPartition
 if m.orderedSupport != 9 || m.predecessorMultiplet != 8 || m.invariantSinglet != 1 then throw "sealed meson partition changed"
 let b ← HadronRegge.baryonMultipletPartition
 if b.orderedSupport != 27 || b.symmetric != 10 || b.mixedFirstHand != 8 || b.mixedSecondHand != 8 || b.antisymmetric != 1 then throw "sealed baryon partition changed"
 let ranks := [1,2,3,4,5]
 let values ← ranks.mapM (fun n => HadronRegge.normalizedReggeSquaredSupport (.count (.integer (.ofNat n))))
 if !(values == ranks.map wholeRatio) then throw "sealed normalized Regge support changed"
 let rows ← trajectoryRows record
 let jpcs ← rows.mapM (fun row => field row "JPC")
 if !sameValue (.array jpcs) (.array [.text "1--",.text "2++",.text "3--",.text "4++",.text "5--"]) then throw "registered natural-parity sequence changed"
 let intervals ← rows.mapM exactMassInterval
 if (intervals.zip (intervals.drop 1)).any (fun (previous,successor) => !previous.2.blt successor.1) then throw "complete physical mass intervals are no longer strictly ordered"
 let last ← LeptonRatios.atIndex rows (rows.length-1)
 if !sameValue (← field last "table_status") (.text "OMITTED FROM SUMMARY TABLE") then throw "rho5 omission status was concealed"
 if (← exactCommonStepExists record) then throw "registered adverse exact-spacing result changed"
 pure label
def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 classificationFromRecord (← authoritativeRecord bytes files payload)
theorem originalClassification : classificationFromRecord registeredRecord=.ok label := rfl
def carrierCheck : Bool := match HadronRegge.mesonMultipletPartition with
 | .error _ => false
 | .ok m => match HadronRegge.baryonMultipletPartition with
  | .error _ => false
  | .ok b => match HadronRegge.normalizedReggeSquaredSupport (.count (.integer 5)) with
   | .error _ => false
   | .ok next => match HadronRegge.normalizedReggeSquaredSupport (.count (.integer 4)) with
    | .error _ => false
    | .ok previous => m.orderedSupport==9 && b.orderedSupport==27 && subtract next previous == wholeRatio 1
theorem carrierCheckPassed : carrierCheck=true := rfl
end SFT.Physics.HadronReggeMeasurement
