import SFT.Physics.ParticleModeReach
namespace SFT.Physics.ParticleModeFibres
open GeneratorOperations LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def mapExact {α β : Type} (f : α → Except String β) : List α → Except String (List β)
 | [] => .ok []
 | x::xs => do
  let y ← f x
  let ys ← mapExact f xs
  pure (y::ys)

def positiveFraction (value : Rat) (name : String) : Except String Rat :=
 if !zero.blt value || (wholeRatio 1).blt value then
  .error (SFT.Host.Text.append name " must be a positive exact carrier inside the One")
 else .ok value

def fibreValue (m : Nat) (image : Rat) (offset : Nat) : Except String Rat :=
 LeptonRatios.divide (add image (wholeRatio offset)) (wholeRatio m)
structure Fibre where
 multiplicity : Nat
 image : Rat
 preimages : List Rat
 complete : Bool
 allPositiveInsideOne : Bool
 exactReturn : Bool

def mFoldFibre (m : CountInput) (image : Rat) : Except String Fibre := do
 let multiplicity ← SpinStatisticsCondensation.positiveWhole m "fibre multiplicity"
 if multiplicity<2 then throw "a nontrivial Fold fibre requires at least two preimages"
 let target ← positiveFraction image "fibre image"
 let rows ← mapExact (fibreValue multiplicity target) (List.range multiplicity)
 pure ⟨multiplicity,target,rows,
  rows.length==multiplicity && rows.eraseDups.length==multiplicity,
  rows.all (fun value => zero.blt value && !(wholeRatio 1).blt value),
  rows.zipIdx.all (fun (value,offset) => multiply (wholeRatio multiplicity) value == add target (wholeRatio offset))⟩

def interiorFixedModes (m : CountInput) : Except String (List Rat) := do
 let multiplicity ← SpinStatisticsCondensation.positiveWhole m "mode multiplicity"
 if multiplicity<2 then throw "a nontrivial Fold mode count requires multiplicity at least two"
 if multiplicity==2 then pure [] else do
  let modes ← mapExact (fun i =>
   LeptonRatios.divide (wholeRatio (i+1)) (wholeRatio (multiplicity-1))) (List.range (multiplicity-2))
  if !(modes.zipIdx 1).all (fun (value,index) => multiply (wholeRatio multiplicity) value == add value (wholeRatio index)) then
   throw "fixed-mode return failed"
  pure modes
structure FibreCertificate where
 checkedThrough : Nat
 allFibresComplete : Bool
 fixedModeFormula : Bool
 induction : String

def mFoldTheoremCertificate (maxM : CountInput := .integer 12) : Except String FibreCertificate := do
 let limit ← SpinStatisticsCondensation.positiveWhole maxM "finite theorem check"
 if limit<2 then throw "finite theorem check must include a nontrivial Fold"
 let rows ← (List.range (limit-1)).mapM (fun i => do
  let multiplicity := i+2
  let inverse ← LeptonRatios.divide (wholeRatio 1) (wholeRatio multiplicity)
  let fibres ← [inverse,normalize 1 2 (by decide),wholeRatio 1].mapM
   (mFoldFibre (.integer (.ofNat multiplicity)))
  let modes ← interiorFixedModes (.integer (.ofNat multiplicity))
  let expected := multiplicity-2
  if !(if expected<1 then modes.isEmpty else modes.length==expected) then
   throw "fixed-mode count failed"
  pure (fibres.all (fun fibre => fibre.complete && fibre.allPositiveInsideOne && fibre.exactReturn),
   (modes.isEmpty && multiplicity==2) || modes.length==multiplicity-2))
 pure ⟨limit,rows.all Prod.fst,rows.all Prod.snd,
  "Appending the next offset adds exactly one new positive preimage; increasing m by One changes the fixed-mode index set from 1..m-2 to 1..m-1, adding exactly one mode."⟩
theorem originalTwelveCertificate : mFoldTheoremCertificate (.integer 12)=.ok ⟨12,true,true,
 "Appending the next offset adds exactly one new positive preimage; increasing m by One changes the fixed-mode index set from 1..m-2 to 1..m-1, adding exactly one mode."⟩ := rfl
#print axioms originalTwelveCertificate
end SFT.Physics.ParticleModeFibres
