import SFT.Foundation.MeasurementProtocol
open SFT.Foundation.MeasurementProtocol SFT.Host.Canonical
example : acceptsValue = .boolean true := rfl
example : acceptsValue (.null) (.integer 0) (.array [.integer 1]) (.text "source-id") = .text "source-id" := rfl
example : acceptsValue (.text "") (.array []) (.integer 0) (.text "source-id") = .integer 0 := rfl
example : acceptsValue (.boolean false) (.boolean false) (.text "") (.text "source-id") = .text "" := rfl
example : acceptsValue (.boolean false) (.boolean false) (.object []) (.text "source-id") = .object [] := rfl
example : acceptsValue (.text "opened") (.boolean false) (.boolean true) (.text "source-id") = .boolean false := rfl
example : acceptsValue (.boolean false) (.integer (-1)) (.boolean true) (.text "source-id") = .boolean false := rfl
example : acceptsValue (.boolean false) (.boolean false) (.integer 3) (.null) = .null := rfl
example : acceptsValue (.boolean false) (.boolean false) (.null) (.boolean true) = .null := rfl
example : acceptsValue (.boolean false) (.boolean false) (.boolean true) (.array []) = .array [] := rfl
example : acceptsValue (.boolean false) (.boolean false) (.boolean true) (.object [("id", .integer 2)]) = .object [("id", .integer 2)] := rfl
example : acceptsValue (.array [.null]) (.boolean false) (.boolean true) (.text "source-id") = .boolean false := rfl
