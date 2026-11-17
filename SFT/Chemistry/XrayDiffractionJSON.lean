import SFT.Host.Canonical
import SFT.Host.SHA256Window
namespace SFT.Chemistry.XrayDiffractionJSON
open SFT.Host
-- Original decimal JSON inscriptions are external OCR provenance, not scientific parameters.
inductive Document where
 | scalar (value : Canonical.Value)
 | decimal (inscription : String)
 | array (values : List Document)
 | object (fields : List (String × Document))
def quote (text : String) : String := Text.intercalate "" ["\"",Text.join ((Text.chars text).map (fun c => if c.toNat>126 then String.ofList [c] else Canonical.escapeChar c)),"\""]
mutual
 def render : Document → String
  | .scalar (.text value) => quote value
  | .scalar .null => "null"
  | .scalar (.integer value) => Canonical.render (.integer value)
  | .scalar (.boolean value) => Canonical.render (.boolean value)
  | .scalar (.array values) => Canonical.render (.array values)
  | .scalar (.object fields) => Canonical.render (.object fields)
  | .decimal inscription => inscription
  | .array values => Text.intercalate "" ["[",Text.intercalate "," (renderValues values),"]"]
  | .object fields => Text.intercalate "" ["{",Text.intercalate "," ((Canonical.sortFields (renderFields fields)).map Prod.snd),"}"]
 def renderValues : List Document → List String
  | [] => []
  | value::rest => render value::renderValues rest
 def renderFields : List (String × Document) → List (String × String)
  | [] => []
  | (key,value)::rest => (key,Text.intercalate "" [quote key,":",render value])::renderFields rest
end
mutual
 def view : Document → Canonical.Value
  | .scalar value => value
  | .decimal inscription => .text inscription
  | .array values => .array (viewValues values)
  | .object fields => .object (viewFields fields)
 def viewValues : List Document → List Canonical.Value
  | [] => []
  | value::rest => view value::viewValues rest
 def viewFields : List (String × Document) → List (String × Canonical.Value)
  | [] => []
  | (key,value)::rest => (key,view value)::viewFields rest
end
def field (document : Document) (key : String) : Except String Document := match document with
 | .object fields => match fields.find? (fun row => Text.equal row.1 key) with
  | none => .error (Text.append "KeyError: " key)
  | some row => .ok row.2
 | .scalar _ | .decimal _ | .array _ => .error "object expected"
def identity (document : Document) : String := Text.append "sha256:" (SHA256Window.digest (render document).toUTF8)
end SFT.Chemistry.XrayDiffractionJSON
