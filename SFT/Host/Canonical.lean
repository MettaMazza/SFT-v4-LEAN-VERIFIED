import SFT.Host.SHA256
/-! Translation of sft/engine/canonical.py for the JSON domain used by Root.
Dataclass/Enum adapters are explicit source-field objects and strings at call sites.
Integer, string, bool, null, array and unique string-keyed objects are supported.
Float and Fraction adapters outside Root remain pending. -/
namespace SFT.Host.Canonical
local infixr:65 " +++ " => SFT.Host.Text.append
inductive Value where
 | text : String → Value
 | boolean : Bool → Value
 | integer : Int → Value
 | null : Value
 | array : List Value → Value
 | object : List (String × Value) → Value
 deriving Repr

def hex4 (n : Nat) : String := String.ofList <|
  (List.range 4).map fun i => SHA256.hexDigit ((n / 2^(4*(3-i))) % 16)

def escapeChar (c : Char) : String :=
  let n := c.toNat
  if n == 34 then "\\\"" else if n == 92 then "\\\\"
  else if n == 8 then "\\b" else if n == 9 then "\\t"
  else if n == 10 then "\\n" else if n == 12 then "\\f" else if n == 13 then "\\r"
  else if n < 32 || n > 126 then
    if n < 65536 then "\\u" +++ hex4 n
    else "\\u" +++ hex4 (55296 + (n-65536)/1024) +++ "\\u" +++ hex4 (56320 + (n-65536)%1024)
  else String.ofList [c]

def quote (s : String) : String := "\"" +++ Text.join ((Text.chars s).map escapeChar) +++ "\""

def insertField (v : String × String) : List (String × String) → List (String × String)
 | [] => [v]
 | x::xs => if Text.le v.1 x.1 then v::x::xs else x :: insertField v xs
def sortFields : List (String × String) → List (String × String)
 | [] => []
 | x::xs => insertField x (sortFields xs)

mutual
 def render : Value → String
  | .text s => quote s
  | .boolean b => if b then "true" else "false"
  | .integer i => String.ofList (if i < 0 then '-' :: Nat.toDigits 10 i.natAbs else Nat.toDigits 10 i.natAbs)
  | .null => "null"
  | .array xs => "[" +++ Text.intercalate "," (renderValues xs) +++ "]"
  | .object xs => "{" +++ Text.intercalate "," ((sortFields (renderFields xs)).map Prod.snd) +++ "}"
 def renderValues : List Value → List String
  | [] => []
  | x::xs => render x :: renderValues xs
 def renderFields : List (String × Value) → List (String × String)
  | [] => []
  | x::xs => renderField x :: renderFields xs
 def renderField : String × Value → String × String
  | (k,v) => (k, quote k +++ ":" +++ render v)
end

def identity (v : Value) : String := "sha256:" +++ SHA256.digest (render v).toUTF8
end SFT.Host.Canonical
