import SFT.Physics.CapabilityDocuments
open SFT.Physics.CapabilityDocuments SFT.Physics.CapabilityValues
def rendered : Except String SFT.Physics.CapabilityValues.Value → String | .error e => SFT.Host.Text.append "error:" e | .ok v => SFT.Host.Canonical.render (canonical v)
def valueDoc0 : Document := .object [("kind",(.text "empty_one"))]
def valueDoc1 : Document := .object [("kind",(.text "count")),("value",(.integer (1)))]
def valueDoc2 : Document := .object [("kind",(.text "ratio")),("numerator",(.integer (2))),("denominator",(.integer (4)))]
def valueDoc3 : Document := .object [("kind",(.text "label")),("family",(.text "f")),("label",(.text "x"))]
def valueDoc4 : Document := .object [("kind",(.text "word")),("cells",(.array []))]
def valueDoc5 : Document := .object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))]
def valueDoc6 : Document := .object [("kind",(.text "word")),("cells",(.array [(.object [("kind",(.text "empty_one"))]),(.object [("kind",(.text "count")),("value",(.integer (1)))]),(.object [("kind",(.text "ratio")),("numerator",(.integer (2))),("denominator",(.integer (4)))]),(.object [("kind",(.text "label")),("family",(.text "f")),("label",(.text "x"))])]))]
def valueDoc7 : Document := .object [("kind",(.text "table")),("entries",(.array [(.object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))])]))]
def valueDoc8 : Document := .null
def valueDoc9 : Document := .boolean true
def valueDoc10 : Document := .integer (2)
def valueDoc11 : Document := .text "x"
def valueDoc12 : Document := .array []
def valueDoc13 : Document := .object []
def valueDoc14 : Document := .object [("kind",(.text "unknown"))]
def valueDoc15 : Document := .object [("kind",(.null))]
def valueDoc16 : Document := .object [("kind",(.array []))]
def valueDoc17 : Document := .object [("kind",(.object []))]
def valueDoc18 : Document := .object []
def valueDoc19 : Document := .object [("kind",(.text "empty_one")),("extra",(.integer (1)))]
def valueDoc20 : Document := .object [("value",(.integer (1)))]
def valueDoc21 : Document := .object [("kind",(.text "count"))]
def valueDoc22 : Document := .object [("kind",(.text "count")),("value",(.integer (1))),("extra",(.integer (1)))]
def valueDoc23 : Document := .object [("numerator",(.integer (2))),("denominator",(.integer (4)))]
def valueDoc24 : Document := .object [("kind",(.text "ratio")),("denominator",(.integer (4)))]
def valueDoc25 : Document := .object [("kind",(.text "ratio")),("numerator",(.integer (2)))]
def valueDoc26 : Document := .object [("kind",(.text "ratio")),("numerator",(.integer (2))),("denominator",(.integer (4))),("extra",(.integer (1)))]
def valueDoc27 : Document := .object [("family",(.text "f")),("label",(.text "x"))]
def valueDoc28 : Document := .object [("kind",(.text "label")),("label",(.text "x"))]
def valueDoc29 : Document := .object [("kind",(.text "label")),("family",(.text "f"))]
def valueDoc30 : Document := .object [("kind",(.text "label")),("family",(.text "f")),("label",(.text "x")),("extra",(.integer (1)))]
def valueDoc31 : Document := .object [("cells",(.array []))]
def valueDoc32 : Document := .object [("kind",(.text "word"))]
def valueDoc33 : Document := .object [("kind",(.text "word")),("cells",(.array [])),("extra",(.integer (1)))]
def valueDoc34 : Document := .object [("left",(.object [("kind",(.text "empty_one"))])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))]
def valueDoc35 : Document := .object [("kind",(.text "pair")),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))]
def valueDoc36 : Document := .object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))]))]
def valueDoc37 : Document := .object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))])),("extra",(.integer (1)))]
def valueDoc38 : Document := .object [("cells",(.array [(.object [("kind",(.text "empty_one"))]),(.object [("kind",(.text "count")),("value",(.integer (1)))]),(.object [("kind",(.text "ratio")),("numerator",(.integer (2))),("denominator",(.integer (4)))]),(.object [("kind",(.text "label")),("family",(.text "f")),("label",(.text "x"))])]))]
def valueDoc39 : Document := .object [("kind",(.text "word"))]
def valueDoc40 : Document := .object [("kind",(.text "word")),("cells",(.array [(.object [("kind",(.text "empty_one"))]),(.object [("kind",(.text "count")),("value",(.integer (1)))]),(.object [("kind",(.text "ratio")),("numerator",(.integer (2))),("denominator",(.integer (4)))]),(.object [("kind",(.text "label")),("family",(.text "f")),("label",(.text "x"))])])),("extra",(.integer (1)))]
def valueDoc41 : Document := .object [("entries",(.array [(.object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))])]))]
def valueDoc42 : Document := .object [("kind",(.text "table"))]
def valueDoc43 : Document := .object [("kind",(.text "table")),("entries",(.array [(.object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))])])),("extra",(.integer (1)))]
def valueDoc44 : Document := .object [("kind",(.text "count")),("value",(.integer (0)))]
def valueDoc45 : Document := .object [("kind",(.text "ratio")),("numerator",(.integer (0))),("denominator",(.integer (1)))]
def valueDoc46 : Document := .object [("kind",(.text "ratio")),("numerator",(.integer (1))),("denominator",(.integer (0)))]
def valueDoc47 : Document := .object [("kind",(.text "count")),("value",(.integer (-1)))]
def valueDoc48 : Document := .object [("kind",(.text "ratio")),("numerator",(.integer (-1))),("denominator",(.integer (1)))]
def valueDoc49 : Document := .object [("kind",(.text "ratio")),("numerator",(.integer (1))),("denominator",(.integer (-1)))]
def valueDoc50 : Document := .object [("kind",(.text "count")),("value",(.boolean true))]
def valueDoc51 : Document := .object [("kind",(.text "ratio")),("numerator",(.boolean true)),("denominator",(.integer (1)))]
def valueDoc52 : Document := .object [("kind",(.text "ratio")),("numerator",(.integer (1))),("denominator",(.boolean true))]
def valueDoc53 : Document := .object [("kind",(.text "count")),("value",(.boolean false))]
def valueDoc54 : Document := .object [("kind",(.text "ratio")),("numerator",(.boolean false)),("denominator",(.integer (1)))]
def valueDoc55 : Document := .object [("kind",(.text "ratio")),("numerator",(.integer (1))),("denominator",(.boolean false))]
def valueDoc56 : Document := .object [("kind",(.text "count")),("value",(.null))]
def valueDoc57 : Document := .object [("kind",(.text "ratio")),("numerator",(.null)),("denominator",(.integer (1)))]
def valueDoc58 : Document := .object [("kind",(.text "ratio")),("numerator",(.integer (1))),("denominator",(.null))]
def valueDoc59 : Document := .object [("kind",(.text "count")),("value",(.array []))]
def valueDoc60 : Document := .object [("kind",(.text "ratio")),("numerator",(.array [])),("denominator",(.integer (1)))]
def valueDoc61 : Document := .object [("kind",(.text "ratio")),("numerator",(.integer (1))),("denominator",(.array []))]
def valueDoc62 : Document := .object [("kind",(.text "count")),("value",(.object []))]
def valueDoc63 : Document := .object [("kind",(.text "ratio")),("numerator",(.object [])),("denominator",(.integer (1)))]
def valueDoc64 : Document := .object [("kind",(.text "ratio")),("numerator",(.integer (1))),("denominator",(.object []))]
def valueDoc65 : Document := .object [("kind",(.text "count")),("value",(.text "1"))]
def valueDoc66 : Document := .object [("kind",(.text "ratio")),("numerator",(.text "1")),("denominator",(.integer (1)))]
def valueDoc67 : Document := .object [("kind",(.text "ratio")),("numerator",(.integer (1))),("denominator",(.text "1"))]
def valueDoc68 : Document := .object [("kind",(.text "count")),("value",(.integer (1)))]
def valueDoc69 : Document := .object [("kind",(.text "ratio")),("numerator",(.integer (1))),("denominator",(.integer (1)))]
def valueDoc70 : Document := .object [("kind",(.text "ratio")),("numerator",(.integer (1))),("denominator",(.integer (1)))]
def valueDoc71 : Document := .object [("kind",(.text "count")),("value",(.integer (42)))]
def valueDoc72 : Document := .object [("kind",(.text "ratio")),("numerator",(.integer (42))),("denominator",(.integer (1)))]
def valueDoc73 : Document := .object [("kind",(.text "ratio")),("numerator",(.integer (1))),("denominator",(.integer (42)))]
def valueDoc74 : Document := .object [("kind",(.text "label")),("family",(.text "")),("label",(.text "x"))]
def valueDoc75 : Document := .object [("kind",(.text "label")),("family",(.text "f")),("label",(.text ""))]
def valueDoc76 : Document := .object [("kind",(.text "label")),("family",(.text " ")),("label",(.text "x"))]
def valueDoc77 : Document := .object [("kind",(.text "label")),("family",(.text "f")),("label",(.text " "))]
def valueDoc78 : Document := .object [("kind",(.text "label")),("family",(.text "f")),("label",(.text "x"))]
def valueDoc79 : Document := .object [("kind",(.text "label")),("family",(.text "f")),("label",(.text "f"))]
def valueDoc80 : Document := .object [("kind",(.text "label")),("family",(.null)),("label",(.text "x"))]
def valueDoc81 : Document := .object [("kind",(.text "label")),("family",(.text "f")),("label",(.null))]
def valueDoc82 : Document := .object [("kind",(.text "label")),("family",(.boolean true)),("label",(.text "x"))]
def valueDoc83 : Document := .object [("kind",(.text "label")),("family",(.text "f")),("label",(.boolean true))]
def valueDoc84 : Document := .object [("kind",(.text "label")),("family",(.integer (1))),("label",(.text "x"))]
def valueDoc85 : Document := .object [("kind",(.text "label")),("family",(.text "f")),("label",(.integer (1)))]
def valueDoc86 : Document := .object [("kind",(.text "label")),("family",(.array [])),("label",(.text "x"))]
def valueDoc87 : Document := .object [("kind",(.text "label")),("family",(.text "f")),("label",(.array []))]
def valueDoc88 : Document := .object [("kind",(.text "label")),("family",(.object [])),("label",(.text "x"))]
def valueDoc89 : Document := .object [("kind",(.text "label")),("family",(.text "f")),("label",(.object []))]
def valueDoc90 : Document := .object [("kind",(.text "word")),("cells",(.null))]
def valueDoc91 : Document := .object [("kind",(.text "table")),("entries",(.null))]
def valueDoc92 : Document := .object [("kind",(.text "word")),("cells",(.integer (1)))]
def valueDoc93 : Document := .object [("kind",(.text "table")),("entries",(.integer (1)))]
def valueDoc94 : Document := .object [("kind",(.text "word")),("cells",(.text "x"))]
def valueDoc95 : Document := .object [("kind",(.text "table")),("entries",(.text "x"))]
def valueDoc96 : Document := .object [("kind",(.text "word")),("cells",(.object []))]
def valueDoc97 : Document := .object [("kind",(.text "table")),("entries",(.object []))]
def valueDoc98 : Document := .object [("kind",(.text "word")),("cells",(.array []))]
def valueDoc99 : Document := .object [("kind",(.text "table")),("entries",(.array []))]
def valueDoc100 : Document := .object [("kind",(.text "word")),("cells",(.array [(.object [("kind",(.text "empty_one"))])]))]
def valueDoc101 : Document := .object [("kind",(.text "table")),("entries",(.array [(.object [("kind",(.text "empty_one"))])]))]
def valueDoc102 : Document := .object [("kind",(.text "word")),("cells",(.array [(.null)]))]
def valueDoc103 : Document := .object [("kind",(.text "table")),("entries",(.array [(.null)]))]
def valueDoc104 : Document := .object [("kind",(.text "word")),("cells",(.array [(.object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))])]))]
def valueDoc105 : Document := .object [("kind",(.text "table")),("entries",(.array [(.object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))])]))]
def valueDoc106 : Document := .object [("kind",(.text "word")),("cells",(.array [(.object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))]),(.object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))])]))]
def valueDoc107 : Document := .object [("kind",(.text "table")),("entries",(.array [(.object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))]),(.object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))])]))]
def valueDoc108 : Document := .object [("kind",(.text "pair")),("left",(.null)),("right",(.null))]
def valueDoc109 : Document := .object [("kind",(.text "pair")),("left",(.null)),("right",(.array []))]
def valueDoc110 : Document := .object [("kind",(.text "pair")),("left",(.null)),("right",(.object []))]
def valueDoc111 : Document := .object [("kind",(.text "pair")),("left",(.null)),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))]
def valueDoc112 : Document := .object [("kind",(.text "pair")),("left",(.array [])),("right",(.null))]
def valueDoc113 : Document := .object [("kind",(.text "pair")),("left",(.array [])),("right",(.array []))]
def valueDoc114 : Document := .object [("kind",(.text "pair")),("left",(.array [])),("right",(.object []))]
def valueDoc115 : Document := .object [("kind",(.text "pair")),("left",(.array [])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))]
def valueDoc116 : Document := .object [("kind",(.text "pair")),("left",(.object [])),("right",(.null))]
def valueDoc117 : Document := .object [("kind",(.text "pair")),("left",(.object [])),("right",(.array []))]
def valueDoc118 : Document := .object [("kind",(.text "pair")),("left",(.object [])),("right",(.object []))]
def valueDoc119 : Document := .object [("kind",(.text "pair")),("left",(.object [])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))]
def valueDoc120 : Document := .object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.null))]
def valueDoc121 : Document := .object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.array []))]
def valueDoc122 : Document := .object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.object []))]
def valueDoc123 : Document := .object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))]
def valueDoc124 : Document := .object [("kind",(.text "pair")),("left",(.object [("kind",(.text "table")),("entries",(.array [(.object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))])]))])),("right",(.null))]
def valueDoc125 : Document := .object [("kind",(.text "pair")),("left",(.object [("kind",(.text "table")),("entries",(.array [(.object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))])]))])),("right",(.array []))]
def valueDoc126 : Document := .object [("kind",(.text "pair")),("left",(.object [("kind",(.text "table")),("entries",(.array [(.object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))])]))])),("right",(.object []))]
def valueDoc127 : Document := .object [("kind",(.text "pair")),("left",(.object [("kind",(.text "table")),("entries",(.array [(.object [("kind",(.text "pair")),("left",(.object [("kind",(.text "empty_one"))])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))])]))])),("right",(.object [("kind",(.text "count")),("value",(.integer (1)))]))]
def valueDoc128 : Document := .object [("kind",(.text "word")),("cells",(.array [(.object [("kind",(.text "count")),("value",(.integer (1)))])]))]
def valueDoc129 : Document := .object [("kind",(.text "word")),("cells",(.array [(.object [("kind",(.text "word")),("cells",(.array [(.object [("kind",(.text "word")),("cells",(.array [(.object [("kind",(.text "count")),("value",(.integer (1)))])]))])]))])]))]
def valueDoc130 : Document := .object [("kind",(.text "word")),("cells",(.array [(.object [("kind",(.text "word")),("cells",(.array [(.object [("kind",(.text "word")),("cells",(.array [(.object [("kind",(.text "word")),("cells",(.array [(.object [("kind",(.text "word")),("cells",(.array [(.object [("kind",(.text "word")),("cells",(.array [(.object [("kind",(.text "word")),("cells",(.array [(.object [("kind",(.text "word")),("cells",(.array [(.object [("kind",(.text "count")),("value",(.integer (1)))])]))])]))])]))])]))])]))])]))])]))])]))]
def main : IO Unit := do
  IO.println (rendered (loadValue valueDoc0))
  IO.println (rendered (loadValue valueDoc1))
  IO.println (rendered (loadValue valueDoc2))
  IO.println (rendered (loadValue valueDoc3))
  IO.println (rendered (loadValue valueDoc4))
  IO.println (rendered (loadValue valueDoc5))
  IO.println (rendered (loadValue valueDoc6))
  IO.println (rendered (loadValue valueDoc7))
  IO.println (rendered (loadValue valueDoc8))
  IO.println (rendered (loadValue valueDoc9))
  IO.println (rendered (loadValue valueDoc10))
  IO.println (rendered (loadValue valueDoc11))
  IO.println (rendered (loadValue valueDoc12))
  IO.println (rendered (loadValue valueDoc13))
  IO.println (rendered (loadValue valueDoc14))
  IO.println (rendered (loadValue valueDoc15))
  IO.println (rendered (loadValue valueDoc16))
  IO.println (rendered (loadValue valueDoc17))
  IO.println (rendered (loadValue valueDoc18))
  IO.println (rendered (loadValue valueDoc19))
  IO.println (rendered (loadValue valueDoc20))
  IO.println (rendered (loadValue valueDoc21))
  IO.println (rendered (loadValue valueDoc22))
  IO.println (rendered (loadValue valueDoc23))
  IO.println (rendered (loadValue valueDoc24))
  IO.println (rendered (loadValue valueDoc25))
  IO.println (rendered (loadValue valueDoc26))
  IO.println (rendered (loadValue valueDoc27))
  IO.println (rendered (loadValue valueDoc28))
  IO.println (rendered (loadValue valueDoc29))
  IO.println (rendered (loadValue valueDoc30))
  IO.println (rendered (loadValue valueDoc31))
  IO.println (rendered (loadValue valueDoc32))
  IO.println (rendered (loadValue valueDoc33))
  IO.println (rendered (loadValue valueDoc34))
  IO.println (rendered (loadValue valueDoc35))
  IO.println (rendered (loadValue valueDoc36))
  IO.println (rendered (loadValue valueDoc37))
  IO.println (rendered (loadValue valueDoc38))
  IO.println (rendered (loadValue valueDoc39))
  IO.println (rendered (loadValue valueDoc40))
  IO.println (rendered (loadValue valueDoc41))
  IO.println (rendered (loadValue valueDoc42))
  IO.println (rendered (loadValue valueDoc43))
  IO.println (rendered (loadValue valueDoc44))
  IO.println (rendered (loadValue valueDoc45))
  IO.println (rendered (loadValue valueDoc46))
  IO.println (rendered (loadValue valueDoc47))
  IO.println (rendered (loadValue valueDoc48))
  IO.println (rendered (loadValue valueDoc49))
  IO.println (rendered (loadValue valueDoc50))
  IO.println (rendered (loadValue valueDoc51))
  IO.println (rendered (loadValue valueDoc52))
  IO.println (rendered (loadValue valueDoc53))
  IO.println (rendered (loadValue valueDoc54))
  IO.println (rendered (loadValue valueDoc55))
  IO.println (rendered (loadValue valueDoc56))
  IO.println (rendered (loadValue valueDoc57))
  IO.println (rendered (loadValue valueDoc58))
  IO.println (rendered (loadValue valueDoc59))
  IO.println (rendered (loadValue valueDoc60))
  IO.println (rendered (loadValue valueDoc61))
  IO.println (rendered (loadValue valueDoc62))
  IO.println (rendered (loadValue valueDoc63))
  IO.println (rendered (loadValue valueDoc64))
  IO.println (rendered (loadValue valueDoc65))
  IO.println (rendered (loadValue valueDoc66))
  IO.println (rendered (loadValue valueDoc67))
  IO.println (rendered (loadValue valueDoc68))
  IO.println (rendered (loadValue valueDoc69))
  IO.println (rendered (loadValue valueDoc70))
  IO.println (rendered (loadValue valueDoc71))
  IO.println (rendered (loadValue valueDoc72))
  IO.println (rendered (loadValue valueDoc73))
  IO.println (rendered (loadValue valueDoc74))
  IO.println (rendered (loadValue valueDoc75))
  IO.println (rendered (loadValue valueDoc76))
  IO.println (rendered (loadValue valueDoc77))
  IO.println (rendered (loadValue valueDoc78))
  IO.println (rendered (loadValue valueDoc79))
  IO.println (rendered (loadValue valueDoc80))
  IO.println (rendered (loadValue valueDoc81))
  IO.println (rendered (loadValue valueDoc82))
  IO.println (rendered (loadValue valueDoc83))
  IO.println (rendered (loadValue valueDoc84))
  IO.println (rendered (loadValue valueDoc85))
  IO.println (rendered (loadValue valueDoc86))
  IO.println (rendered (loadValue valueDoc87))
  IO.println (rendered (loadValue valueDoc88))
  IO.println (rendered (loadValue valueDoc89))
  IO.println (rendered (loadValue valueDoc90))
  IO.println (rendered (loadValue valueDoc91))
  IO.println (rendered (loadValue valueDoc92))
  IO.println (rendered (loadValue valueDoc93))
  IO.println (rendered (loadValue valueDoc94))
  IO.println (rendered (loadValue valueDoc95))
  IO.println (rendered (loadValue valueDoc96))
  IO.println (rendered (loadValue valueDoc97))
  IO.println (rendered (loadValue valueDoc98))
  IO.println (rendered (loadValue valueDoc99))
  IO.println (rendered (loadValue valueDoc100))
  IO.println (rendered (loadValue valueDoc101))
  IO.println (rendered (loadValue valueDoc102))
  IO.println (rendered (loadValue valueDoc103))
  IO.println (rendered (loadValue valueDoc104))
  IO.println (rendered (loadValue valueDoc105))
  IO.println (rendered (loadValue valueDoc106))
  IO.println (rendered (loadValue valueDoc107))
  IO.println (rendered (loadValue valueDoc108))
  IO.println (rendered (loadValue valueDoc109))
  IO.println (rendered (loadValue valueDoc110))
  IO.println (rendered (loadValue valueDoc111))
  IO.println (rendered (loadValue valueDoc112))
  IO.println (rendered (loadValue valueDoc113))
  IO.println (rendered (loadValue valueDoc114))
  IO.println (rendered (loadValue valueDoc115))
  IO.println (rendered (loadValue valueDoc116))
  IO.println (rendered (loadValue valueDoc117))
  IO.println (rendered (loadValue valueDoc118))
  IO.println (rendered (loadValue valueDoc119))
  IO.println (rendered (loadValue valueDoc120))
  IO.println (rendered (loadValue valueDoc121))
  IO.println (rendered (loadValue valueDoc122))
  IO.println (rendered (loadValue valueDoc123))
  IO.println (rendered (loadValue valueDoc124))
  IO.println (rendered (loadValue valueDoc125))
  IO.println (rendered (loadValue valueDoc126))
  IO.println (rendered (loadValue valueDoc127))
  IO.println (rendered (loadValue valueDoc128))
  IO.println (rendered (loadValue valueDoc129))
  IO.println (rendered (loadValue valueDoc130))
