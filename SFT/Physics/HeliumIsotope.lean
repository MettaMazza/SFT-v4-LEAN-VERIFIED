import SFT.Physics.ThermalHistory
namespace SFT.Physics.HeliumIsotope
open GeneratorOperations LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def heliumConstituents : Nat := 4
def nonemptySubwordMasks : CountInput → Except String (List Nat)
 | .boolean _ => .error "helium constituent count must be a positive whole"
 | .integer (.negSucc _) => .error "helium constituent count must be a positive whole"
 | .integer (.ofNat 0) => .error "helium constituent count must be a positive whole"
 | .integer (.ofNat (n+1)) => .ok ((List.range (2^(n+1)-1)).map (fun i => i+1))
def completeCaptureCells : Except String (List (Nat × Nat)) := do
 let masks ← nonemptySubwordMasks (.integer (.ofNat heliumConstituents))
 .ok (((List.range heliumConstituents).map (fun i => i+1)).flatMap (fun c => masks.map (fun m => (c,m))))
structure Ledger where
 constituents : Nat
 nonemptySubwords : List Nat
 captureCells : List (Nat × Nat)
 completeCellCount : Nat
 globalIdentityRecords : List String
 isotopeCellCount : Nat
 analyticHeliumFamily : Rat
 isotopeConversion : Rat
 physicalHeliumIsotopeShare : Rat
 physicalHydrogenFamilyShare : Rat
 partitionCloses : Bool
def isotopeClosureLedger : Except String Ledger := do
 let cells ← completeCaptureCells
 let analytic := (← ThermalHistory.freezeoutCaptureLedger).heliumShare
 let identities := ["one-bound-composite-identity"]
 let isotopeCells := cells.length-identities.length
 let conversion ← LeptonRatios.divide (wholeRatio isotopeCells) (wholeRatio cells.length)
 let helium := multiply analytic conversion
 let hydrogen := normalize 181 240 (by decide)
 .ok ⟨heliumConstituents,← nonemptySubwordMasks (.integer (.ofNat heliumConstituents)),cells,cells.length,
 identities,isotopeCells,analytic,conversion,helium,hydrogen,add helium hydrogen == wholeRatio 1⟩
structure Certificate where
 fourConstituents : Bool
 completeNonemptySubwords : Bool
 completeCaptureProduct : Bool
 oneCompositeIdentity : Bool
 isotopeConversion : Bool
 physicalPartition : Bool
def theoremCertificate : Except String Certificate := do
 let ledger ← isotopeClosureLedger
 .ok ⟨ledger.constituents==4,
 ledger.nonemptySubwords.length==15 && ledger.nonemptySubwords.eraseDups == (List.range 15).map (fun i=>i+1),
 ledger.captureCells.length==60 && ledger.captureCells.eraseDups.length==60,
 ledger.globalIdentityRecords.length==1,ledger.isotopeConversion==normalize 59 60 (by decide),
 ledger.physicalHeliumIsotopeShare==normalize 59 240 (by decide) &&
 ledger.physicalHydrogenFamilyShare==normalize 181 240 (by decide) && ledger.partitionCloses⟩
theorem originalSubwords : nonemptySubwordMasks (.integer 4) = .ok [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15] := rfl
theorem fullCertificate : theoremCertificate = .ok ⟨true,true,true,true,true,true⟩ := rfl
theorem physicalShares : (do let ledger ← isotopeClosureLedger; pure (ledger.physicalHeliumIsotopeShare,ledger.physicalHydrogenFamilyShare)) =
 Except.ok (normalize 59 240 (by decide),normalize 181 240 (by decide)) := rfl
#print axioms nonemptySubwordMasks
#print axioms isotopeClosureLedger
#print axioms originalSubwords
#print axioms fullCertificate
#print axioms physicalShares
end SFT.Physics.HeliumIsotope
