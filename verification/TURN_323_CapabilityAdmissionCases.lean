import SFT.Physics.CapabilityAdmission
open SFT.Physics.CapabilityAdmission
def result {α : Type} : Except String α → String | .ok _ => "ok" | .error e => e
example : result (instruction .input "" []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .input "" ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .input "" ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .input " " []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .input " " ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .input " " ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .input "held" []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .input "held" ["x"]) = "ok" := by decide
example : result (instruction .input "held" ["x","y"]) = "ok" := by decide
example : result (instruction .emptyOne "" []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .emptyOne "" ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .emptyOne "" ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .emptyOne " " []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .emptyOne " " ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .emptyOne " " ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .emptyOne "held" []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .emptyOne "held" ["x"]) = "ok" := by decide
example : result (instruction .emptyOne "held" ["x","y"]) = "ok" := by decide
example : result (instruction .label "" []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .label "" ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .label "" ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .label " " []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .label " " ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .label " " ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .label "held" []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .label "held" ["x"]) = "ok" := by decide
example : result (instruction .label "held" ["x","y"]) = "ok" := by decide
example : result (instruction .count "" []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .count "" ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .count "" ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .count " " []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .count " " ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .count " " ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .count "held" []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .count "held" ["x"]) = "ok" := by decide
example : result (instruction .count "held" ["x","y"]) = "ok" := by decide
example : result (instruction .ratio "" []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .ratio "" ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .ratio "" ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .ratio " " []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .ratio " " ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .ratio " " ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .ratio "held" []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .ratio "held" ["x"]) = "ok" := by decide
example : result (instruction .ratio "held" ["x","y"]) = "ok" := by decide
example : result (instruction .word "" []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .word "" ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .word "" ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .word " " []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .word " " ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .word " " ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .word "held" []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .word "held" ["x"]) = "ok" := by decide
example : result (instruction .word "held" ["x","y"]) = "ok" := by decide
example : result (instruction .pair "" []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .pair "" ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .pair "" ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .pair " " []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .pair " " ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .pair " " ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .pair "held" []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .pair "held" ["x"]) = "ok" := by decide
example : result (instruction .pair "held" ["x","y"]) = "ok" := by decide
example : result (instruction .table "" []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .table "" ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .table "" ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .table " " []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .table " " ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .table " " ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .table "held" []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .table "held" ["x"]) = "ok" := by decide
example : result (instruction .table "held" ["x","y"]) = "ok" := by decide
example : result (instruction .lookup "" []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .lookup "" ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .lookup "" ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .lookup " " []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .lookup " " ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .lookup " " ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .lookup "held" []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .lookup "held" ["x"]) = "ok" := by decide
example : result (instruction .lookup "held" ["x","y"]) = "ok" := by decide
example : result (instruction .junction "" []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .junction "" ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .junction "" ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .junction " " []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .junction " " ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .junction " " ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .junction "held" []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .junction "held" ["x"]) = "ok" := by decide
example : result (instruction .junction "held" ["x","y"]) = "ok" := by decide
example : result (instruction .product "" []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .product "" ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .product "" ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .product " " []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .product " " ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .product " " ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .product "held" []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .product "held" ["x"]) = "ok" := by decide
example : result (instruction .product "held" ["x","y"]) = "ok" := by decide
example : result (instruction .quotient "" []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .quotient "" ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .quotient "" ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .quotient " " []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .quotient " " ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .quotient " " ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .quotient "held" []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .quotient "held" ["x"]) = "ok" := by decide
example : result (instruction .quotient "held" ["x","y"]) = "ok" := by decide
example : result (instruction .same "" []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .same "" ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .same "" ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .same " " []) = "value-producing instruction requires a destination" := by decide
example : result (instruction .same " " ["x"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .same " " ["x","y"]) = "value-producing instruction requires a destination" := by decide
example : result (instruction .same "held" []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .same "held" ["x"]) = "ok" := by decide
example : result (instruction .same "held" ["x","y"]) = "ok" := by decide
example : result (instruction .assertSame "" []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .assertSame "" ["x"]) = "ok" := by decide
example : result (instruction .assertSame "" ["x","y"]) = "ok" := by decide
example : result (instruction .assertSame " " []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .assertSame " " ["x"]) = "ok" := by decide
example : result (instruction .assertSame " " ["x","y"]) = "ok" := by decide
example : result (instruction .assertSame "held" []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .assertSame "held" ["x"]) = "ok" := by decide
example : result (instruction .assertSame "held" ["x","y"]) = "ok" := by decide
example : result (instruction .emit "" []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .emit "" ["x"]) = "ok" := by decide
example : result (instruction .emit "" ["x","y"]) = "ok" := by decide
example : result (instruction .emit " " []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .emit " " ["x"]) = "ok" := by decide
example : result (instruction .emit " " ["x","y"]) = "ok" := by decide
example : result (instruction .emit "held" []) = "every instruction requires its exact argument trace" := by decide
example : result (instruction .emit "held" ["x"]) = "ok" := by decide
example : result (instruction .emit "held" ["x","y"]) = "ok" := by decide
example : result (program "" []) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.input,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.input,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.input,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.input,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.input,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.input,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.input,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.input,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.input,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.input,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.input,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.input,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.input,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.input,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.input,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emptyOne,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emptyOne,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emptyOne,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emptyOne,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emptyOne,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emptyOne,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emptyOne,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emptyOne,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emptyOne,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emptyOne,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emptyOne,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emptyOne,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emptyOne,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emptyOne,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emptyOne,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.label,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.label,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.label,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.label,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.label,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.label,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.label,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.label,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.label,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.label,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.label,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.label,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.label,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.label,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.label,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.count,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.count,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.count,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.count,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.count,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.count,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.count,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.count,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.count,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.count,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.count,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.count,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.count,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.count,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.count,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.ratio,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.ratio,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.ratio,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.ratio,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.ratio,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.ratio,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.ratio,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.ratio,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.ratio,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.ratio,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.ratio,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.ratio,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.ratio,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.ratio,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.ratio,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.word,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.word,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.word,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.word,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.word,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.word,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.word,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.word,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.word,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.word,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.word,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.word,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.word,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.word,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.word,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.pair,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.pair,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.pair,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.pair,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.pair,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.pair,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.pair,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.pair,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.pair,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.pair,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.pair,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.pair,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.pair,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.pair,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.pair,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.table,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.table,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.table,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.table,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.table,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.table,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.table,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.table,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.table,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.table,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.table,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.table,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.table,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.table,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.table,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.lookup,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.lookup,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.lookup,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.lookup,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.lookup,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.lookup,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.lookup,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.lookup,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.lookup,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.lookup,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.lookup,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.lookup,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.lookup,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.lookup,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.lookup,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.junction,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.junction,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.junction,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.junction,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.junction,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.junction,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.junction,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.junction,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.junction,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.junction,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.junction,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.junction,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.junction,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.junction,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.junction,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.product,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.product,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.product,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.product,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.product,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.product,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.product,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.product,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.product,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.product,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.product,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.product,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.product,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.product,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.product,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.quotient,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.quotient,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.quotient,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.quotient,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.quotient,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.quotient,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.quotient,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.quotient,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.quotient,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.quotient,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.quotient,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.quotient,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.quotient,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.quotient,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.quotient,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.same,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.same,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.same,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.same,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.same,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.same,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.same,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.same,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.same,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.same,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.same,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.same,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.same,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.same,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.same,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.assertSame,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.assertSame,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.assertSame,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.assertSame,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.assertSame,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.assertSame,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.assertSame,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.assertSame,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.assertSame,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.assertSame,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.assertSame,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.assertSame,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.assertSame,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.assertSame,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.assertSame,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emit,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emit,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emit,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emit,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emit,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emit,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emit,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emit,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emit,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emit,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emit,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emit,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emit,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emit,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "" [⟨.emit,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " []) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.input,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.input,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.input,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.input,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.input,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.input,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.input,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.input,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.input,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.input,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.input,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.input,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.input,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.input,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.input,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emptyOne,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emptyOne,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emptyOne,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emptyOne,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emptyOne,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emptyOne,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emptyOne,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emptyOne,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emptyOne,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emptyOne,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emptyOne,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emptyOne,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emptyOne,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emptyOne,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emptyOne,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.label,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.label,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.label,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.label,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.label,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.label,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.label,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.label,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.label,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.label,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.label,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.label,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.label,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.label,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.label,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.count,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.count,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.count,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.count,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.count,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.count,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.count,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.count,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.count,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.count,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.count,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.count,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.count,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.count,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.count,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.ratio,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.ratio,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.ratio,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.ratio,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.ratio,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.ratio,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.ratio,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.ratio,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.ratio,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.ratio,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.ratio,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.ratio,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.ratio,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.ratio,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.ratio,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.word,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.word,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.word,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.word,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.word,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.word,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.word,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.word,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.word,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.word,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.word,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.word,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.word,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.word,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.word,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.pair,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.pair,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.pair,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.pair,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.pair,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.pair,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.pair,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.pair,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.pair,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.pair,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.pair,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.pair,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.pair,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.pair,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.pair,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.table,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.table,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.table,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.table,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.table,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.table,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.table,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.table,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.table,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.table,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.table,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.table,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.table,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.table,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.table,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.lookup,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.lookup,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.lookup,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.lookup,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.lookup,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.lookup,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.lookup,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.lookup,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.lookup,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.lookup,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.lookup,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.lookup,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.lookup,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.lookup,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.lookup,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.junction,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.junction,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.junction,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.junction,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.junction,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.junction,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.junction,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.junction,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.junction,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.junction,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.junction,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.junction,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.junction,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.junction,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.junction,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.product,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.product,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.product,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.product,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.product,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.product,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.product,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.product,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.product,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.product,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.product,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.product,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.product,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.product,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.product,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.quotient,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.quotient,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.quotient,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.quotient,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.quotient,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.quotient,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.quotient,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.quotient,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.quotient,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.quotient,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.quotient,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.quotient,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.quotient,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.quotient,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.quotient,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.same,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.same,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.same,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.same,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.same,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.same,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.same,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.same,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.same,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.same,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.same,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.same,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.same,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.same,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.same,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.assertSame,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.assertSame,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.assertSame,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.assertSame,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.assertSame,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.assertSame,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.assertSame,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.assertSame,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.assertSame,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.assertSame,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.assertSame,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.assertSame,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.assertSame,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.assertSame,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.assertSame,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emit,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emit,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emit,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emit,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emit,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emit,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emit,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emit,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emit,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emit,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emit,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emit,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emit,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emit,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program " " [⟨.emit,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "p" []) = "a Fold program requires identity and positive instruction support" := by decide
example : result (program "p" [⟨.input,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emptyOne,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.label,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.count,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.ratio,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.word,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.pair,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.table,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.lookup,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.junction,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.product,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.quotient,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.same,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.assertSame,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emit,"held",["x"]⟩]) = "ok" := by decide
example : result (program "p" [⟨.input,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.input,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.input,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.input,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.input,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.input,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.input,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.input,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.input,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.input,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.input,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.input,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.input,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.input,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.input,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "ok" := by decide
example : result (program "p" [⟨.emptyOne,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emptyOne,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emptyOne,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emptyOne,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emptyOne,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emptyOne,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emptyOne,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emptyOne,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emptyOne,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emptyOne,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emptyOne,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emptyOne,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emptyOne,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emptyOne,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emptyOne,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "ok" := by decide
example : result (program "p" [⟨.label,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.label,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.label,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.label,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.label,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.label,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.label,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.label,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.label,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.label,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.label,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.label,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.label,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.label,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.label,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "ok" := by decide
example : result (program "p" [⟨.count,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.count,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.count,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.count,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.count,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.count,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.count,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.count,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.count,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.count,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.count,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.count,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.count,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.count,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.count,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "ok" := by decide
example : result (program "p" [⟨.ratio,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.ratio,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.ratio,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.ratio,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.ratio,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.ratio,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.ratio,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.ratio,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.ratio,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.ratio,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.ratio,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.ratio,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.ratio,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.ratio,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.ratio,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "ok" := by decide
example : result (program "p" [⟨.word,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.word,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.word,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.word,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.word,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.word,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.word,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.word,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.word,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.word,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.word,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.word,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.word,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.word,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.word,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "ok" := by decide
example : result (program "p" [⟨.pair,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.pair,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.pair,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.pair,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.pair,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.pair,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.pair,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.pair,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.pair,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.pair,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.pair,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.pair,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.pair,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.pair,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.pair,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "ok" := by decide
example : result (program "p" [⟨.table,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.table,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.table,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.table,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.table,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.table,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.table,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.table,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.table,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.table,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.table,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.table,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.table,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.table,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.table,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "ok" := by decide
example : result (program "p" [⟨.lookup,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.lookup,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.lookup,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.lookup,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.lookup,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.lookup,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.lookup,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.lookup,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.lookup,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.lookup,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.lookup,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.lookup,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.lookup,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.lookup,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.lookup,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "ok" := by decide
example : result (program "p" [⟨.junction,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.junction,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.junction,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.junction,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.junction,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.junction,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.junction,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.junction,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.junction,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.junction,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.junction,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.junction,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.junction,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.junction,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.junction,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "ok" := by decide
example : result (program "p" [⟨.product,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.product,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.product,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.product,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.product,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.product,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.product,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.product,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.product,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.product,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.product,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.product,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.product,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.product,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.product,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "ok" := by decide
example : result (program "p" [⟨.quotient,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.quotient,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.quotient,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.quotient,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.quotient,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.quotient,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.quotient,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.quotient,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.quotient,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.quotient,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.quotient,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.quotient,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.quotient,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.quotient,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.quotient,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "ok" := by decide
example : result (program "p" [⟨.same,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.same,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.same,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.same,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.same,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.same,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.same,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.same,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.same,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.same,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.same,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.same,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.same,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.same,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.same,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "ok" := by decide
example : result (program "p" [⟨.assertSame,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.assertSame,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.assertSame,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.assertSame,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.assertSame,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.assertSame,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.assertSame,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.assertSame,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.assertSame,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.assertSame,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.assertSame,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.assertSame,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.assertSame,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.assertSame,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.assertSame,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "ok" := by decide
example : result (program "p" [⟨.emit,"held",["x"]⟩,⟨.input,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emit,"held",["x"]⟩,⟨.emptyOne,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emit,"held",["x"]⟩,⟨.label,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emit,"held",["x"]⟩,⟨.count,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emit,"held",["x"]⟩,⟨.ratio,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emit,"held",["x"]⟩,⟨.word,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emit,"held",["x"]⟩,⟨.pair,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emit,"held",["x"]⟩,⟨.table,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emit,"held",["x"]⟩,⟨.lookup,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emit,"held",["x"]⟩,⟨.junction,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emit,"held",["x"]⟩,⟨.product,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emit,"held",["x"]⟩,⟨.quotient,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emit,"held",["x"]⟩,⟨.same,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emit,"held",["x"]⟩,⟨.assertSame,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
example : result (program "p" [⟨.emit,"held",["x"]⟩,⟨.emit,"held",["x"]⟩]) = "a Fold program must terminate with exactly one emit instruction" := by decide
