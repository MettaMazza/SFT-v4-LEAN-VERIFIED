import SFT.Physics.RadioactiveRecords
import SFT.Physics.RadioactiveDecay
namespace SFT.Physics.RadioactiveMeasuredRows
open SFT.Host SFT.Host.Canonical LeptonIntervals RunningConvergenceMeasurement
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Row where
 mass : Int
 charge : Int
 stateIndex : String
 nuclide : String
 halfLifeInscription : String
 halfLife : Option Rat
 halfLifeUnit : String
 halfLifeUncertainty : String
 branchingRecord : String
 modeCodes : List String
def segment (line : List Char) (start stop : Nat) : List Char := (line.drop start).take (stop-start)
def stripped (line : List Char) (start stop : Nat) : String := String.ofList (LeptonDecimal.strip (segment line start stop))
def modeCodes (branching : String) : List String :=
 (LeptonDecimal.split ';' (Text.chars branching)).flatMap (fun part =>
  let initialCode := (LeptonDecimal.strip part).takeWhile (fun c => !(['=',' ','<','~','?','>'].contains c))
  let code := String.ofList initialCode
  if initialCode.isEmpty || Text.equal code "IS" then [] else [code])
def numericHalfLife (text : String) : Option Rat :=
 if Text.equal text "" || Text.equal text "stbl" || Text.equal text "p-unst" || Text.contains text "#" then none
 else (LeptonDecimal.exactDecimal text).toOption
def parseLine (raw : List Char) : Option Row :=
 if raw.head? == some '#' || raw.length < 17 then none else
 let line := raw ++ List.replicate (209-raw.length) ' '
 match LeptonDecimal.exponent (LeptonDecimal.strip (segment line 0 3)),LeptonDecimal.exponent (LeptonDecimal.strip (segment line 4 7)) with
 | some mass,some charge =>
   let half := stripped line 69 78
   let branching := stripped line 119 209
   some ⟨mass,charge,String.ofList (segment line 7 8),stripped line 11 17,half,numericHalfLife half,stripped line 78 80,stripped line 81 88,branching,modeCodes branching⟩
 | none,_ => none
 | some _,none => none
def rowsFromText (text : String) : Except String (List Row) := do
 let rows := (LeptonDecimal.split '\n' (Text.chars text)).filterMap parseLine
 if rows.length != 5843 then throw "complete NUBASE2020 state census changed"
 pure rows
def nubaseRows (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String (List Row) := do
 let _ ← RadioactiveRecords.authoritativeRecord bytes files payload
 let raw ← match files.find? (fun p => Text.equal p.1 RadioactiveRecords.rawPath) with
  | none => .error (Text.append "FileNotFoundError: " RadioactiveRecords.rawPath)
  | some pair => .ok (String.ofList (Text.decode pair.2.size pair.2.data.toList))
 rowsFromText raw
def pureConversionCodes : List String := ["B","B-","B+","2B-","2B+","EC","EC+B+","e+"]
def primitiveTraceForCode (code : String) : Except String (List String) :=
 if Text.equal code "IT" then .ok [RadioactiveDecay.deexcitation.name]
 else if pureConversionCodes.any (fun name => Text.equal name code) then .ok [RadioactiveDecay.conversion.name]
 else if Text.equal (String.ofList ((Text.chars code).take 2)) "B-" || Text.equal (String.ofList ((Text.chars code).take 2)) "B+" then
  .ok [RadioactiveDecay.conversion.name,RadioactiveDecay.release.name]
 else if Text.equal code "" then .error "empty decay code has no primitive trace"
 else .ok [RadioactiveDecay.release.name]
def rowByCoordinate (rows : List Row) (mass charge : Int) (state : String) : Except String Row :=
 let found :=  rows.filter (fun row => (@decide (row.mass=mass) (Int.decEq row.mass mass)) && (@decide (row.charge=charge) (Int.decEq row.charge charge)) && Text.equal row.stateIndex state)
 match found with
 | [row] => .ok row
 | [] => .error "NUBASE2020 coordinate is absent or duplicated"
 | _::_::_ => .error "NUBASE2020 coordinate is absent or duplicated"
end SFT.Physics.RadioactiveMeasuredRows
