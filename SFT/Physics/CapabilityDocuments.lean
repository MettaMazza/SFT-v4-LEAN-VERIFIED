import SFT.Physics.CapabilityExecution
namespace SFT.Physics.CapabilityDocuments
open CapabilityPrediction CapabilityAdmission
abbrev Document := SFT.Host.Canonical.Value

def field (name : String) : List (String × Document) → Option Document
 | [] => none
 | (key,v)::rest => if key = name then some v else field name rest

def exactKeys (fields : List (String × Document)) (names : List String) : Bool :=
  fields.all (fun p => SFT.Mathematics.DiscreteObjects.has names p.1) &&
  names.all (fun name => fields.any (fun p => p.1 == name))

def opcode (name : String) : Option Opcode := allOpcodes.find? (fun op => opcodeName op == name)

def strings : List Document → Except String (List String)
 | [] => .ok []
 | v::rest =>
   match v with
   | .text s => do
     let remaining ← strings rest
     pure (s::remaining)
   | .boolean _ | .integer _ | .null | .array _ | .object _ =>
     .error "Fold instruction fields have invalid host types"

def asText : Option Document → Option String
 | some (.text s) => some s
 | none | some (.boolean _) | some (.integer _) | some .null | some (.array _) | some (.object _) => none

def asArray : Option Document → Option (List Document)
 | some (.array xs) => some xs
 | none | some (.text _) | some (.boolean _) | some (.integer _) | some .null | some (.object _) => none

def loadInstruction (doc : Document) : Except String Instruction := do
  match doc with
  | .object fields =>
    if !exactKeys fields ["opcode","destination","arguments"] then
      .error "Fold instruction has missing or additional fields"
    else
      let op ← match field "opcode" fields with
        | some (.text s) => match opcode s with
          | some op => .ok op
          | none => .error "Fold instruction names an unregistered opcode"
        | none | some (.boolean _) | some (.integer _) | some .null | some (.array _) | some (.object _) =>
          .error "Fold instruction names an unregistered opcode"
      match asText (field "destination" fields),asArray (field "arguments" fields) with
      | some dest,some args =>
        let names ← strings args
        instruction op dest names
      | none,none | none,some _ | some _,none => .error "Fold instruction fields have invalid host types"
  | .text _ | .boolean _ | .integer _ | .null | .array _ => .error "Fold instruction has missing or additional fields"

def loadInstructions : List Document → Except String (List Instruction)
 | [] => .ok []
 | doc::rest => do
   let i ← loadInstruction doc
   let tail ← loadInstructions rest
   pure (i::tail)

def loadProgramFields (fields : List (String × Document)) : Except String Program := do
  if !exactKeys fields ["schema","program_id","instructions"] then
    .error "Fold program document has missing or additional fields"
  else if asText (field "schema" fields) != some "sft-v3-fold-program/1" then
    .error "Fold program schema identity is not admitted"
  else match asText (field "program_id" fields),asArray (field "instructions" fields) with
    | some id,some rows =>
      if rows.isEmpty then .error "Fold program identity or instruction support is invalid"
      else
        let instructions ← loadInstructions rows
        program id instructions
    | none,none | none,some _ | some _,none => .error "Fold program identity or instruction support is invalid"

def mappingPositiveCount : Document → Except String CapabilityValues.PositiveCount
 | .integer (.ofNat n) =>
   if h : 0 < n then .ok ⟨n,h⟩
   else .error "Fold value count must be a positive generated host count"
 | .integer (.negSucc _) | .text _ | .boolean _ | .null | .array _ | .object _ =>
   .error "Fold value count must be a positive generated host count"

def countValue (v : Document) : Except String CapabilityValues.Value := do
  let n ← mappingPositiveCount v
  pure (.count n)

def ratioValue (left right : Document) : Except String CapabilityValues.Value := do
  let n ← mappingPositiveCount left
  let d ← mappingPositiveCount right
  pure (.ratio n d)

def labelValue (family label : Document) : Except String CapabilityValues.Value :=
  match asText (some family),asText (some label) with
  | some f,some l => do
    let held ← CapabilityValues.heldLabel f l
    pure (.label held)
  | none,none | none,some _ | some _,none =>
    .error "held-label document contains invalid host types"

theorem countDocumentPositive (n : Nat) (h : 0 < n) :
    mappingPositiveCount (.integer (.ofNat n)) = .ok ⟨n,h⟩ := by
  dsimp only [mappingPositiveCount]
  rw [dite_eq_left h]

theorem booleanCountRejected (b : Bool) :
    mappingPositiveCount (.boolean b) = .error "Fold value count must be a positive generated host count" := rfl

theorem opcodeRoundTrip (op : Opcode) : opcode (opcodeName op) = some op := by
  cases op <;> decide
inductive Prepared where
 | node : Document → Except String CapabilityValues.Value → List Prepared → Prepared
def preparedSourceData : Prepared → Document | .node s _ _ => s
def preparedResult : Prepared → Except String CapabilityValues.Value | .node _ r _ => r
def preparedChildren : Prepared → List Prepared | .node _ _ c => c

def missingKind : Except String CapabilityValues.Value := .error "Fold value document lacks a kind"
def badFields : Except String CapabilityValues.Value := .error "Fold value document has missing or additional fields"
def preparedField (name : String) : List (String × Prepared) → Prepared
 | [] => .node .null missingKind []
 | (key,v)::rest => if key = name then v else preparedField name rest

def isObject : Document → Bool
 | .object _ => true
 | .text _ | .boolean _ | .integer _ | .null | .array _ => false

def isArray : Document → Bool
 | .array _ => true
 | .text _ | .boolean _ | .integer _ | .null | .object _ => false

def gather : List Prepared → Except String (List CapabilityValues.Value)
 | [] => .ok []
 | v::rest => do
   let value ← (preparedResult v)
   let values ← gather rest
   pure (value::values)

def gatherPairs : List Prepared → Except String (List (CapabilityValues.Value × CapabilityValues.Value))
 | [] => .ok []
 | entry::rest => do
   if !isObject (preparedSourceData entry) then .error "table entry is not an exact Fold pair"
   else
     let v ← (preparedResult entry)
     match v with
     | .pair left right =>
       let tail ← gatherPairs rest
       pure ((left,right)::tail)
     | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .table _ =>
       .error "table entry is not an exact Fold pair"

def evaluateObject (fields : List (String × Document)) (prepared : List (String × Prepared)) : Except String CapabilityValues.Value :=
  match field "kind" fields with
  | none => missingKind
  | some kind =>
    match kind with
    | .text name =>
      if name = "empty_one" then
        if exactKeys fields ["kind"] then .ok CapabilityOperations.emptyOne else badFields
      else if name = "count" then
        if exactKeys fields ["kind","value"] then countValue (preparedSourceData (preparedField "value" prepared)) else badFields
      else if name = "ratio" then
        if exactKeys fields ["kind","numerator","denominator"] then
          ratioValue (preparedSourceData (preparedField "numerator" prepared)) (preparedSourceData (preparedField "denominator" prepared))
        else badFields
      else if name = "label" then
        if exactKeys fields ["kind","family","label"] then
          labelValue (preparedSourceData (preparedField "family" prepared)) (preparedSourceData (preparedField "label" prepared))
        else badFields
      else if name = "word" then
        if !exactKeys fields ["kind","cells"] then badFields
        else
          let cells := preparedField "cells" prepared
          if !isArray (preparedSourceData cells) then .error "word cells must be a generated list"
          else do
            let values ← gather (preparedChildren cells)
            pure (.word values)
      else if name = "pair" then
        if !exactKeys fields ["kind","left","right"] then badFields
        else
          let left := preparedField "left" prepared
          let right := preparedField "right" prepared
          if !isObject (preparedSourceData left) || !isObject (preparedSourceData right) then .error "pair cells must be exact Fold documents"
          else do
            let l ← (preparedResult left)
            let r ← (preparedResult right)
            pure (.pair l r)
      else if name = "table" then
        if !exactKeys fields ["kind","entries"] then badFields
        else
          let entries := preparedField "entries" prepared
          if !isArray (preparedSourceData entries) then .error "table entries must be generated support"
          else do
            let pairs ← gatherPairs (preparedChildren entries)
            CapabilityValues.table pairs
      else badFields
    | .boolean _ | .integer _ | .null => badFields
    | .array _ => .error "unhashable type: 'list'"
    | .object _ => .error "unhashable type: 'dict'"

mutual
 def prepare : Document → Prepared
  | .text s => .node (.text s) missingKind []
  | .boolean b => .node (.boolean b) missingKind []
  | .integer n => .node (.integer n) missingKind []
  | .null => .node .null missingKind []
  | .array xs => .node (.array xs) missingKind (prepareList xs)
  | .object fields => .node (.object fields) (evaluateObject fields (prepareFields fields)) []
 def prepareList : List Document → List Prepared
  | [] => []
  | x::rest => prepare x::prepareList rest
 def prepareFields : List (String × Document) → List (String × Prepared)
  | [] => []
  | (key,v)::rest => (key,prepare v)::prepareFields rest
end

def loadValue (doc : Document) : Except String CapabilityValues.Value := (preparedResult (prepare doc))

theorem preparedSource (doc : Document) : (preparedSourceData (prepare doc)) = doc := by
  cases doc <;> rfl

theorem wordChildren (docs : List Document) : (preparedChildren (prepare (.array docs))) = prepareList docs := rfl

end SFT.Physics.CapabilityDocuments
