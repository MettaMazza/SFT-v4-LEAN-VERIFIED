import SFT.Physics.CapabilityOperations
set_option maxRecDepth 1000000
set_option maxHeartbeats 10000000
open SFT.Physics.CapabilityValues SFT.Physics.CapabilityOperations
def outcome : Except String Value → String | .error e => "error:" ++ e | .ok v => SFT.Host.Canonical.render (canonical v)
example : outcome (resolved .word []) = "{\"cells\":[]}" := by decide
example : outcome (resolved .word [(.emptyOne "empty-One")]) = "{\"cells\":[{\"identity\":\"empty-One\"}]}" := by decide
example : outcome (resolved .word [(.count ⟨1,by decide⟩)]) = "{\"cells\":[{\"value\":1}]}" := by decide
example : outcome (resolved .word [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"cells\":[{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}]}" := by decide
example : outcome (resolved .word [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"cells\":[{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}}]}" := by decide
example : outcome (resolved .word [(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"cells\":[{\"family\":\"f\",\"label\":\"x\"}]}" := by decide
example : outcome (resolved .word [(.word [])]) = "{\"cells\":[{\"cells\":[]}]}" := by decide
example : outcome (resolved .word [(.emptyOne "empty-One"),(.emptyOne "empty-One")]) = "{\"cells\":[{\"identity\":\"empty-One\"},{\"identity\":\"empty-One\"}]}" := by decide
example : outcome (resolved .word [(.emptyOne "empty-One"),(.count ⟨1,by decide⟩)]) = "{\"cells\":[{\"identity\":\"empty-One\"},{\"value\":1}]}" := by decide
example : outcome (resolved .word [(.emptyOne "empty-One"),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"cells\":[{\"identity\":\"empty-One\"},{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}]}" := by decide
example : outcome (resolved .word [(.emptyOne "empty-One"),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"cells\":[{\"identity\":\"empty-One\"},{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}}]}" := by decide
example : outcome (resolved .word [(.emptyOne "empty-One"),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"cells\":[{\"identity\":\"empty-One\"},{\"family\":\"f\",\"label\":\"x\"}]}" := by decide
example : outcome (resolved .word [(.emptyOne "empty-One"),(.word [])]) = "{\"cells\":[{\"identity\":\"empty-One\"},{\"cells\":[]}]}" := by decide
example : outcome (resolved .word [(.count ⟨1,by decide⟩),(.emptyOne "empty-One")]) = "{\"cells\":[{\"value\":1},{\"identity\":\"empty-One\"}]}" := by decide
example : outcome (resolved .word [(.count ⟨1,by decide⟩),(.count ⟨1,by decide⟩)]) = "{\"cells\":[{\"value\":1},{\"value\":1}]}" := by decide
example : outcome (resolved .word [(.count ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"cells\":[{\"value\":1},{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}]}" := by decide
example : outcome (resolved .word [(.count ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"cells\":[{\"value\":1},{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}}]}" := by decide
example : outcome (resolved .word [(.count ⟨1,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"cells\":[{\"value\":1},{\"family\":\"f\",\"label\":\"x\"}]}" := by decide
example : outcome (resolved .word [(.count ⟨1,by decide⟩),(.word [])]) = "{\"cells\":[{\"value\":1},{\"cells\":[]}]}" := by decide
example : outcome (resolved .word [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.emptyOne "empty-One")]) = "{\"cells\":[{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}},{\"identity\":\"empty-One\"}]}" := by decide
example : outcome (resolved .word [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.count ⟨1,by decide⟩)]) = "{\"cells\":[{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}},{\"value\":1}]}" := by decide
example : outcome (resolved .word [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"cells\":[{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}},{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}]}" := by decide
example : outcome (resolved .word [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"cells\":[{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}},{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}}]}" := by decide
example : outcome (resolved .word [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"cells\":[{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}},{\"family\":\"f\",\"label\":\"x\"}]}" := by decide
example : outcome (resolved .word [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.word [])]) = "{\"cells\":[{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}},{\"cells\":[]}]}" := by decide
example : outcome (resolved .word [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.emptyOne "empty-One")]) = "{\"cells\":[{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}},{\"identity\":\"empty-One\"}]}" := by decide
example : outcome (resolved .word [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.count ⟨1,by decide⟩)]) = "{\"cells\":[{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}},{\"value\":1}]}" := by decide
example : outcome (resolved .word [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"cells\":[{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}},{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}]}" := by decide
example : outcome (resolved .word [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"cells\":[{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}},{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}}]}" := by decide
example : outcome (resolved .word [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"cells\":[{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}},{\"family\":\"f\",\"label\":\"x\"}]}" := by decide
example : outcome (resolved .word [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.word [])]) = "{\"cells\":[{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}},{\"cells\":[]}]}" := by decide
example : outcome (resolved .word [(.label ⟨"f","x",by decide,by decide⟩),(.emptyOne "empty-One")]) = "{\"cells\":[{\"family\":\"f\",\"label\":\"x\"},{\"identity\":\"empty-One\"}]}" := by decide
example : outcome (resolved .word [(.label ⟨"f","x",by decide,by decide⟩),(.count ⟨1,by decide⟩)]) = "{\"cells\":[{\"family\":\"f\",\"label\":\"x\"},{\"value\":1}]}" := by decide
example : outcome (resolved .word [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"cells\":[{\"family\":\"f\",\"label\":\"x\"},{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}]}" := by decide
example : outcome (resolved .word [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"cells\":[{\"family\":\"f\",\"label\":\"x\"},{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}}]}" := by decide
example : outcome (resolved .word [(.label ⟨"f","x",by decide,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"cells\":[{\"family\":\"f\",\"label\":\"x\"},{\"family\":\"f\",\"label\":\"x\"}]}" := by decide
example : outcome (resolved .word [(.label ⟨"f","x",by decide,by decide⟩),(.word [])]) = "{\"cells\":[{\"family\":\"f\",\"label\":\"x\"},{\"cells\":[]}]}" := by decide
example : outcome (resolved .word [(.word []),(.emptyOne "empty-One")]) = "{\"cells\":[{\"cells\":[]},{\"identity\":\"empty-One\"}]}" := by decide
example : outcome (resolved .word [(.word []),(.count ⟨1,by decide⟩)]) = "{\"cells\":[{\"cells\":[]},{\"value\":1}]}" := by decide
example : outcome (resolved .word [(.word []),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"cells\":[{\"cells\":[]},{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}]}" := by decide
example : outcome (resolved .word [(.word []),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"cells\":[{\"cells\":[]},{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}}]}" := by decide
example : outcome (resolved .word [(.word []),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"cells\":[{\"cells\":[]},{\"family\":\"f\",\"label\":\"x\"}]}" := by decide
example : outcome (resolved .word [(.word []),(.word [])]) = "{\"cells\":[{\"cells\":[]},{\"cells\":[]}]}" := by decide
example : outcome (resolved .word [(.emptyOne "empty-One"),(.count ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"cells\":[{\"identity\":\"empty-One\"},{\"value\":1},{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}]}" := by decide
example : outcome (resolved .pair []) = "error:pair requires exactly 2 argument(s)" := by decide
example : outcome (resolved .pair [(.emptyOne "empty-One")]) = "error:pair requires exactly 2 argument(s)" := by decide
example : outcome (resolved .pair [(.count ⟨1,by decide⟩)]) = "error:pair requires exactly 2 argument(s)" := by decide
example : outcome (resolved .pair [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:pair requires exactly 2 argument(s)" := by decide
example : outcome (resolved .pair [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:pair requires exactly 2 argument(s)" := by decide
example : outcome (resolved .pair [(.label ⟨"f","x",by decide,by decide⟩)]) = "error:pair requires exactly 2 argument(s)" := by decide
example : outcome (resolved .pair [(.word [])]) = "error:pair requires exactly 2 argument(s)" := by decide
example : outcome (resolved .pair [(.emptyOne "empty-One"),(.emptyOne "empty-One")]) = "{\"left\":{\"identity\":\"empty-One\"},\"right\":{\"identity\":\"empty-One\"}}" := by decide
example : outcome (resolved .pair [(.emptyOne "empty-One"),(.count ⟨1,by decide⟩)]) = "{\"left\":{\"identity\":\"empty-One\"},\"right\":{\"value\":1}}" := by decide
example : outcome (resolved .pair [(.emptyOne "empty-One"),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"left\":{\"identity\":\"empty-One\"},\"right\":{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}}" := by decide
example : outcome (resolved .pair [(.emptyOne "empty-One"),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"left\":{\"identity\":\"empty-One\"},\"right\":{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}}}" := by decide
example : outcome (resolved .pair [(.emptyOne "empty-One"),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"left\":{\"identity\":\"empty-One\"},\"right\":{\"family\":\"f\",\"label\":\"x\"}}" := by decide
example : outcome (resolved .pair [(.emptyOne "empty-One"),(.word [])]) = "{\"left\":{\"identity\":\"empty-One\"},\"right\":{\"cells\":[]}}" := by decide
example : outcome (resolved .pair [(.count ⟨1,by decide⟩),(.emptyOne "empty-One")]) = "{\"left\":{\"value\":1},\"right\":{\"identity\":\"empty-One\"}}" := by decide
example : outcome (resolved .pair [(.count ⟨1,by decide⟩),(.count ⟨1,by decide⟩)]) = "{\"left\":{\"value\":1},\"right\":{\"value\":1}}" := by decide
example : outcome (resolved .pair [(.count ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"left\":{\"value\":1},\"right\":{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}}" := by decide
example : outcome (resolved .pair [(.count ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"left\":{\"value\":1},\"right\":{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}}}" := by decide
example : outcome (resolved .pair [(.count ⟨1,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"left\":{\"value\":1},\"right\":{\"family\":\"f\",\"label\":\"x\"}}" := by decide
example : outcome (resolved .pair [(.count ⟨1,by decide⟩),(.word [])]) = "{\"left\":{\"value\":1},\"right\":{\"cells\":[]}}" := by decide
example : outcome (resolved .pair [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.emptyOne "empty-One")]) = "{\"left\":{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}},\"right\":{\"identity\":\"empty-One\"}}" := by decide
example : outcome (resolved .pair [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.count ⟨1,by decide⟩)]) = "{\"left\":{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}},\"right\":{\"value\":1}}" := by decide
example : outcome (resolved .pair [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"left\":{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}},\"right\":{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}}" := by decide
example : outcome (resolved .pair [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"left\":{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}},\"right\":{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}}}" := by decide
example : outcome (resolved .pair [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"left\":{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}},\"right\":{\"family\":\"f\",\"label\":\"x\"}}" := by decide
example : outcome (resolved .pair [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.word [])]) = "{\"left\":{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}},\"right\":{\"cells\":[]}}" := by decide
example : outcome (resolved .pair [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.emptyOne "empty-One")]) = "{\"left\":{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}},\"right\":{\"identity\":\"empty-One\"}}" := by decide
example : outcome (resolved .pair [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.count ⟨1,by decide⟩)]) = "{\"left\":{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}},\"right\":{\"value\":1}}" := by decide
example : outcome (resolved .pair [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"left\":{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}},\"right\":{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}}" := by decide
example : outcome (resolved .pair [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"left\":{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}},\"right\":{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}}}" := by decide
example : outcome (resolved .pair [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"left\":{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}},\"right\":{\"family\":\"f\",\"label\":\"x\"}}" := by decide
example : outcome (resolved .pair [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.word [])]) = "{\"left\":{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}},\"right\":{\"cells\":[]}}" := by decide
example : outcome (resolved .pair [(.label ⟨"f","x",by decide,by decide⟩),(.emptyOne "empty-One")]) = "{\"left\":{\"family\":\"f\",\"label\":\"x\"},\"right\":{\"identity\":\"empty-One\"}}" := by decide
example : outcome (resolved .pair [(.label ⟨"f","x",by decide,by decide⟩),(.count ⟨1,by decide⟩)]) = "{\"left\":{\"family\":\"f\",\"label\":\"x\"},\"right\":{\"value\":1}}" := by decide
example : outcome (resolved .pair [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"left\":{\"family\":\"f\",\"label\":\"x\"},\"right\":{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}}" := by decide
example : outcome (resolved .pair [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"left\":{\"family\":\"f\",\"label\":\"x\"},\"right\":{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}}}" := by decide
example : outcome (resolved .pair [(.label ⟨"f","x",by decide,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"left\":{\"family\":\"f\",\"label\":\"x\"},\"right\":{\"family\":\"f\",\"label\":\"x\"}}" := by decide
example : outcome (resolved .pair [(.label ⟨"f","x",by decide,by decide⟩),(.word [])]) = "{\"left\":{\"family\":\"f\",\"label\":\"x\"},\"right\":{\"cells\":[]}}" := by decide
example : outcome (resolved .pair [(.word []),(.emptyOne "empty-One")]) = "{\"left\":{\"cells\":[]},\"right\":{\"identity\":\"empty-One\"}}" := by decide
example : outcome (resolved .pair [(.word []),(.count ⟨1,by decide⟩)]) = "{\"left\":{\"cells\":[]},\"right\":{\"value\":1}}" := by decide
example : outcome (resolved .pair [(.word []),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"left\":{\"cells\":[]},\"right\":{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}}" := by decide
example : outcome (resolved .pair [(.word []),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"left\":{\"cells\":[]},\"right\":{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}}}" := by decide
example : outcome (resolved .pair [(.word []),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"left\":{\"cells\":[]},\"right\":{\"family\":\"f\",\"label\":\"x\"}}" := by decide
example : outcome (resolved .pair [(.word []),(.word [])]) = "{\"left\":{\"cells\":[]},\"right\":{\"cells\":[]}}" := by decide
example : outcome (resolved .pair [(.emptyOne "empty-One"),(.count ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:pair requires exactly 2 argument(s)" := by decide
example : outcome (resolved .lookup []) = "error:lookup requires exactly 2 argument(s)" := by decide
example : outcome (resolved .lookup [(.emptyOne "empty-One")]) = "error:lookup requires exactly 2 argument(s)" := by decide
example : outcome (resolved .lookup [(.count ⟨1,by decide⟩)]) = "error:lookup requires exactly 2 argument(s)" := by decide
example : outcome (resolved .lookup [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:lookup requires exactly 2 argument(s)" := by decide
example : outcome (resolved .lookup [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:lookup requires exactly 2 argument(s)" := by decide
example : outcome (resolved .lookup [(.label ⟨"f","x",by decide,by decide⟩)]) = "error:lookup requires exactly 2 argument(s)" := by decide
example : outcome (resolved .lookup [(.word [])]) = "error:lookup requires exactly 2 argument(s)" := by decide
example : outcome (resolved .lookup [(.emptyOne "empty-One"),(.emptyOne "empty-One")]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.emptyOne "empty-One"),(.count ⟨1,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.emptyOne "empty-One"),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.emptyOne "empty-One"),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.emptyOne "empty-One"),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.emptyOne "empty-One"),(.word [])]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.count ⟨1,by decide⟩),(.emptyOne "empty-One")]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.count ⟨1,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.count ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.count ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.count ⟨1,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.count ⟨1,by decide⟩),(.word [])]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.emptyOne "empty-One")]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.word [])]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.emptyOne "empty-One")]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.word [])]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.label ⟨"f","x",by decide,by decide⟩),(.emptyOne "empty-One")]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.label ⟨"f","x",by decide,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.label ⟨"f","x",by decide,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.label ⟨"f","x",by decide,by decide⟩),(.word [])]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.word []),(.emptyOne "empty-One")]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.word []),(.count ⟨1,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.word []),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.word []),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.word []),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.word []),(.word [])]) = "error:lookup requires a generated Fold table" := by decide
example : outcome (resolved .lookup [(.emptyOne "empty-One"),(.count ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:lookup requires exactly 2 argument(s)" := by decide
example : outcome (resolved .junction []) = "error:junction requires exactly 2 argument(s)" := by decide
example : outcome (resolved .junction [(.emptyOne "empty-One")]) = "error:junction requires exactly 2 argument(s)" := by decide
example : outcome (resolved .junction [(.count ⟨1,by decide⟩)]) = "error:junction requires exactly 2 argument(s)" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:junction requires exactly 2 argument(s)" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:junction requires exactly 2 argument(s)" := by decide
example : outcome (resolved .junction [(.label ⟨"f","x",by decide,by decide⟩)]) = "error:junction requires exactly 2 argument(s)" := by decide
example : outcome (resolved .junction [(.word [])]) = "error:junction requires exactly 2 argument(s)" := by decide
example : outcome (resolved .junction [(.emptyOne "empty-One"),(.emptyOne "empty-One")]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.emptyOne "empty-One"),(.count ⟨1,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.emptyOne "empty-One"),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.emptyOne "empty-One"),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.emptyOne "empty-One"),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.emptyOne "empty-One"),(.word [])]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.count ⟨1,by decide⟩),(.emptyOne "empty-One")]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.count ⟨1,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.count ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.count ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.count ⟨1,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.count ⟨1,by decide⟩),(.word [])]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.emptyOne "empty-One")]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.word [])]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.emptyOne "empty-One")]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.word [])]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.label ⟨"f","x",by decide,by decide⟩),(.emptyOne "empty-One")]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.label ⟨"f","x",by decide,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.label ⟨"f","x",by decide,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.label ⟨"f","x",by decide,by decide⟩),(.word [])]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.word []),(.emptyOne "empty-One")]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.word []),(.count ⟨1,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.word []),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.word []),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.word []),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.word []),(.word [])]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .junction [(.emptyOne "empty-One"),(.count ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:junction requires exactly 2 argument(s)" := by decide
example : outcome (resolved .product []) = "error:product requires exactly 2 argument(s)" := by decide
example : outcome (resolved .product [(.emptyOne "empty-One")]) = "error:product requires exactly 2 argument(s)" := by decide
example : outcome (resolved .product [(.count ⟨1,by decide⟩)]) = "error:product requires exactly 2 argument(s)" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:product requires exactly 2 argument(s)" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:product requires exactly 2 argument(s)" := by decide
example : outcome (resolved .product [(.label ⟨"f","x",by decide,by decide⟩)]) = "error:product requires exactly 2 argument(s)" := by decide
example : outcome (resolved .product [(.word [])]) = "error:product requires exactly 2 argument(s)" := by decide
example : outcome (resolved .product [(.emptyOne "empty-One"),(.emptyOne "empty-One")]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.emptyOne "empty-One"),(.count ⟨1,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.emptyOne "empty-One"),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.emptyOne "empty-One"),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.emptyOne "empty-One"),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.emptyOne "empty-One"),(.word [])]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.count ⟨1,by decide⟩),(.emptyOne "empty-One")]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.count ⟨1,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.count ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.count ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.count ⟨1,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.count ⟨1,by decide⟩),(.word [])]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.emptyOne "empty-One")]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":4},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"denominator\":{\"value\":4},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.word [])]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.emptyOne "empty-One")]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":4},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"denominator\":{\"value\":4},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.word [])]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.label ⟨"f","x",by decide,by decide⟩),(.emptyOne "empty-One")]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.label ⟨"f","x",by decide,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.label ⟨"f","x",by decide,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.label ⟨"f","x",by decide,by decide⟩),(.word [])]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.word []),(.emptyOne "empty-One")]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.word []),(.count ⟨1,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.word []),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.word []),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.word []),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.word []),(.word [])]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .product [(.emptyOne "empty-One"),(.count ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:product requires exactly 2 argument(s)" := by decide
example : outcome (resolved .quotient []) = "error:quotient requires exactly 2 argument(s)" := by decide
example : outcome (resolved .quotient [(.emptyOne "empty-One")]) = "error:quotient requires exactly 2 argument(s)" := by decide
example : outcome (resolved .quotient [(.count ⟨1,by decide⟩)]) = "error:quotient requires exactly 2 argument(s)" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:quotient requires exactly 2 argument(s)" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:quotient requires exactly 2 argument(s)" := by decide
example : outcome (resolved .quotient [(.label ⟨"f","x",by decide,by decide⟩)]) = "error:quotient requires exactly 2 argument(s)" := by decide
example : outcome (resolved .quotient [(.word [])]) = "error:quotient requires exactly 2 argument(s)" := by decide
example : outcome (resolved .quotient [(.emptyOne "empty-One"),(.emptyOne "empty-One")]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.emptyOne "empty-One"),(.count ⟨1,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.emptyOne "empty-One"),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.emptyOne "empty-One"),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.emptyOne "empty-One"),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.emptyOne "empty-One"),(.word [])]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.count ⟨1,by decide⟩),(.emptyOne "empty-One")]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.count ⟨1,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.count ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.count ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.count ⟨1,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.count ⟨1,by decide⟩),(.word [])]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.emptyOne "empty-One")]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.word [])]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.emptyOne "empty-One")]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.word [])]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.label ⟨"f","x",by decide,by decide⟩),(.emptyOne "empty-One")]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.label ⟨"f","x",by decide,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.label ⟨"f","x",by decide,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.label ⟨"f","x",by decide,by decide⟩),(.word [])]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.word []),(.emptyOne "empty-One")]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.word []),(.count ⟨1,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.word []),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.word []),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.word []),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.word []),(.word [])]) = "error:exact arithmetic requires two positive ratios" := by decide
example : outcome (resolved .quotient [(.emptyOne "empty-One"),(.count ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:quotient requires exactly 2 argument(s)" := by decide
example : outcome (resolved .same []) = "error:same requires exactly 2 argument(s)" := by decide
example : outcome (resolved .same [(.emptyOne "empty-One")]) = "error:same requires exactly 2 argument(s)" := by decide
example : outcome (resolved .same [(.count ⟨1,by decide⟩)]) = "error:same requires exactly 2 argument(s)" := by decide
example : outcome (resolved .same [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:same requires exactly 2 argument(s)" := by decide
example : outcome (resolved .same [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:same requires exactly 2 argument(s)" := by decide
example : outcome (resolved .same [(.label ⟨"f","x",by decide,by decide⟩)]) = "error:same requires exactly 2 argument(s)" := by decide
example : outcome (resolved .same [(.word [])]) = "error:same requires exactly 2 argument(s)" := by decide
example : outcome (resolved .same [(.emptyOne "empty-One"),(.emptyOne "empty-One")]) = "{\"family\":\"comparison\",\"label\":\"same-form\"}" := by decide
example : outcome (resolved .same [(.emptyOne "empty-One"),(.count ⟨1,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.emptyOne "empty-One"),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.emptyOne "empty-One"),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.emptyOne "empty-One"),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.emptyOne "empty-One"),(.word [])]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.count ⟨1,by decide⟩),(.emptyOne "empty-One")]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.count ⟨1,by decide⟩),(.count ⟨1,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"same-form\"}" := by decide
example : outcome (resolved .same [(.count ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.count ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.count ⟨1,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.count ⟨1,by decide⟩),(.word [])]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.emptyOne "empty-One")]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.count ⟨1,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"same-form\"}" := by decide
example : outcome (resolved .same [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.word [])]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.emptyOne "empty-One")]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.count ⟨1,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"same-form\"}" := by decide
example : outcome (resolved .same [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.word [])]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.label ⟨"f","x",by decide,by decide⟩),(.emptyOne "empty-One")]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.label ⟨"f","x",by decide,by decide⟩),(.count ⟨1,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.label ⟨"f","x",by decide,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"same-form\"}" := by decide
example : outcome (resolved .same [(.label ⟨"f","x",by decide,by decide⟩),(.word [])]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.word []),(.emptyOne "empty-One")]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.word []),(.count ⟨1,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.word []),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.word []),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.word []),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"family\":\"comparison\",\"label\":\"different-form\"}" := by decide
example : outcome (resolved .same [(.word []),(.word [])]) = "{\"family\":\"comparison\",\"label\":\"same-form\"}" := by decide
example : outcome (resolved .same [(.emptyOne "empty-One"),(.count ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:same requires exactly 2 argument(s)" := by decide
example : outcome (resolved .assertSame []) = "error:assert_same requires exactly 2 argument(s)" := by decide
example : outcome (resolved .assertSame [(.emptyOne "empty-One")]) = "error:assert_same requires exactly 2 argument(s)" := by decide
example : outcome (resolved .assertSame [(.count ⟨1,by decide⟩)]) = "error:assert_same requires exactly 2 argument(s)" := by decide
example : outcome (resolved .assertSame [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:assert_same requires exactly 2 argument(s)" := by decide
example : outcome (resolved .assertSame [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:assert_same requires exactly 2 argument(s)" := by decide
example : outcome (resolved .assertSame [(.label ⟨"f","x",by decide,by decide⟩)]) = "error:assert_same requires exactly 2 argument(s)" := by decide
example : outcome (resolved .assertSame [(.word [])]) = "error:assert_same requires exactly 2 argument(s)" := by decide
example : outcome (resolved .assertSame [(.emptyOne "empty-One"),(.emptyOne "empty-One")]) = "{\"identity\":\"empty-One\"}" := by decide
example : outcome (resolved .assertSame [(.emptyOne "empty-One"),(.count ⟨1,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.emptyOne "empty-One"),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.emptyOne "empty-One"),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.emptyOne "empty-One"),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.emptyOne "empty-One"),(.word [])]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.count ⟨1,by decide⟩),(.emptyOne "empty-One")]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.count ⟨1,by decide⟩),(.count ⟨1,by decide⟩)]) = "{\"identity\":\"empty-One\"}" := by decide
example : outcome (resolved .assertSame [(.count ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.count ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.count ⟨1,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.count ⟨1,by decide⟩),(.word [])]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.emptyOne "empty-One")]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"identity\":\"empty-One\"}" := by decide
example : outcome (resolved .assertSame [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.word [])]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.emptyOne "empty-One")]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"identity\":\"empty-One\"}" := by decide
example : outcome (resolved .assertSame [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.word [])]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.label ⟨"f","x",by decide,by decide⟩),(.emptyOne "empty-One")]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.label ⟨"f","x",by decide,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.label ⟨"f","x",by decide,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"identity\":\"empty-One\"}" := by decide
example : outcome (resolved .assertSame [(.label ⟨"f","x",by decide,by decide⟩),(.word [])]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.word []),(.emptyOne "empty-One")]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.word []),(.count ⟨1,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.word []),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.word []),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.word []),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:asserted Fold forms are not identical" := by decide
example : outcome (resolved .assertSame [(.word []),(.word [])]) = "{\"identity\":\"empty-One\"}" := by decide
example : outcome (resolved .assertSame [(.emptyOne "empty-One"),(.count ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:assert_same requires exactly 2 argument(s)" := by decide
example : outcome (resolved .emit []) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.emptyOne "empty-One")]) = "{\"identity\":\"empty-One\"}" := by decide
example : outcome (resolved .emit [(.count ⟨1,by decide⟩)]) = "{\"value\":1}" := by decide
example : outcome (resolved .emit [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .emit [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "{\"denominator\":{\"value\":4},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .emit [(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"family\":\"f\",\"label\":\"x\"}" := by decide
example : outcome (resolved .emit [(.word [])]) = "{\"cells\":[]}" := by decide
example : outcome (resolved .emit [(.emptyOne "empty-One"),(.emptyOne "empty-One")]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.emptyOne "empty-One"),(.count ⟨1,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.emptyOne "empty-One"),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.emptyOne "empty-One"),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.emptyOne "empty-One"),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.emptyOne "empty-One"),(.word [])]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.count ⟨1,by decide⟩),(.emptyOne "empty-One")]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.count ⟨1,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.count ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.count ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.count ⟨1,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.count ⟨1,by decide⟩),(.word [])]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.emptyOne "empty-One")]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.word [])]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.emptyOne "empty-One")]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩),(.word [])]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.label ⟨"f","x",by decide,by decide⟩),(.emptyOne "empty-One")]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.label ⟨"f","x",by decide,by decide⟩),(.count ⟨1,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.label ⟨"f","x",by decide,by decide⟩),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.label ⟨"f","x",by decide,by decide⟩),(.word [])]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.word []),(.emptyOne "empty-One")]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.word []),(.count ⟨1,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.word []),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.word []),(.ratio ⟨2,by decide⟩ ⟨4,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.word []),(.label ⟨"f","x",by decide,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.word []),(.word [])]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .emit [(.emptyOne "empty-One"),(.count ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "error:emit requires exactly 1 argument(s)" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":5}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":5}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":6},\"numerator\":{\"value\":5}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":5}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":6},\"numerator\":{\"value\":7}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":7}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":6},\"numerator\":{\"value\":5}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":7}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":10}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":6},\"numerator\":{\"value\":11}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":5}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":7}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":8}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":5}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":7}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":5}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":5}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":5}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":6},\"numerator\":{\"value\":7}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":8}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":5}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":11}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":6},\"numerator\":{\"value\":13}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":5}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":7}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":10}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":5}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":11}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":6}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":9}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":5}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":6},\"numerator\":{\"value\":11}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":7}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":5}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":6},\"numerator\":{\"value\":13}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":9}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":5}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":5}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":5}}" := by decide
example : outcome (resolved .junction [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":4},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":6},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":4},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":6},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":9},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":9},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":6}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":9},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":9},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":6}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":9}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":9}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":4},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":9}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":4},\"numerator\":{\"value\":9}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .product [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":4},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":4},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":6},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":6},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":9},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":9},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":6}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":9},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":9},\"numerator\":{\"value\":4}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":6}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":9}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":9}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":9}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":4},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":4},\"numerator\":{\"value\":9}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":3}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]) = "{\"denominator\":{\"value\":3},\"numerator\":{\"value\":2}}" := by decide
example : outcome (resolved .quotient [(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨3,by decide⟩)]) = "{\"denominator\":{\"value\":1},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .lookup [(.table [(.label ⟨"f","x",by decide,by decide⟩,.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]),(.label ⟨"f","x",by decide,by decide⟩)]) = "{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}" := by decide
example : outcome (resolved .lookup [(.table [(.label ⟨"f","x",by decide,by decide⟩,.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]),(.emptyOne "empty-One")]) = "error:lookup must retain exactly one registered image" := by decide
example : outcome (resolved .table []) = "error:table requires complete key/value pairs" := by decide
example : outcome (resolved .table [(.label ⟨"f","x",by decide,by decide⟩)]) = "error:table requires complete key/value pairs" := by decide
example : outcome (resolved .table [(.label ⟨"f","x",by decide,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)]) = "{\"entries\":[{\"left\":{\"family\":\"f\",\"label\":\"x\"},\"right\":{\"denominator\":{\"value\":2},\"numerator\":{\"value\":1}}}]}" := by decide
