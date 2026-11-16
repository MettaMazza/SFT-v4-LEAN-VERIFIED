import SFT.Physics.QuantumSupportPreparation
namespace SFT.Physics.QuantumSupportBell
open QuantumSupportPreparation LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure LocalCensus where
 strategyCount : Nat
 maximumWins : Nat
 settingCount : Nat
 localBound : Rat
 allBounded : Bool
 rows : List (Word × Word × Nat)
private def responseAt : Word → Nat → String
 | [],_ => ""
 | x::_,0 => x
 | _::xs,n+1 => responseAt xs n
def bellLocalRecordCensus : LocalCensus :=
 let settings := [held,returned]
 let responses := words 2
 let rows := responses.flatMap (fun left => responses.map (fun right =>
  let wins := (settings.zipIdx).foldl (fun wins (ls,li) =>
   wins+(settings.zipIdx).foldl (fun n (rs,ri) =>
    n+if ((responseAt left li==responseAt right ri)==(!(ls==returned && rs==returned))) then 1 else 0) 0) 0
  (left,right,wins)))
 ⟨rows.length,(rows.map (fun row => row.2.2)).foldl max 0,4,normalize 3 4 (by decide),rows.all (fun row => decide (row.2.2≤3)),rows⟩
structure Inclusive where
 settingRows : List (String × String × List (String × String))
 settingCount : Nat
 outcomesPerSetting : List Nat
 allRelations : Bool
 localCountsInvariant : Bool
 remoteCountsInvariant : Bool
 noSignalling : Bool
def settingInclusiveNoSignalSupport : Inclusive :=
 let settings := [held,returned]
 let rows := settings.flatMap (fun ls => settings.map (fun rs =>
  let requiredSame := !(ls==returned && rs==returned)
  let outcomes := settings.flatMap (fun a => (settings.filter (fun b => (a==b)==requiredSame)).map (fun b => (a,b)))
  (ls,rs,outcomes)))
 let localInvariant := rows.all (fun row => settings.all (fun label => (row.2.2.filter (fun (a,_) => a==label)).length==1))
 let remote := rows.all (fun row => settings.all (fun label => (row.2.2.filter (fun (_,b) => b==label)).length==1))
 ⟨rows,rows.length,rows.map (fun row => row.2.2.length),rows.all (fun row => row.2.2.length==2),localInvariant,remote,localInvariant && remote⟩
theorem originalSixteenStrategies : bellLocalRecordCensus.strategyCount=16 := rfl
theorem originalMaximumThree : bellLocalRecordCensus.maximumWins=3 := rfl
theorem originalEveryLocalRecordBounded : bellLocalRecordCensus.allBounded=true := rfl
theorem originalAllSettingsSatisfied : settingInclusiveNoSignalSupport.allRelations=true := rfl
theorem originalBothMarginals : settingInclusiveNoSignalSupport.localCountsInvariant=true ∧ settingInclusiveNoSignalSupport.remoteCountsInvariant=true := ⟨rfl,rfl⟩
theorem originalNoSignalling : settingInclusiveNoSignalSupport.noSignalling=true := rfl
end SFT.Physics.QuantumSupportBell
