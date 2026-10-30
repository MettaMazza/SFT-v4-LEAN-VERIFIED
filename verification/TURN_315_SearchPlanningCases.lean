import SFT.Computation.SearchPlanning
namespace SFT.Computation.SearchPlanning
def m0_0_a_0 : Model := ⟨⟨[],["go"],[]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m0_0_a_0 = [] := by decide
example : failures m0_0_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_0_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_0_a_1 : Model := ⟨⟨[],["go"],[]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_0_a_1 = [] := by decide
example : failures m0_0_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_0_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_0_a_2 : Model := ⟨⟨[],["go"],[]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_0_a_2 = [] := by decide
example : failures m0_0_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_0_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_0_a_3 : Model := ⟨⟨[],["go"],[]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_0_a_3 = [] := by decide
example : failures m0_0_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_0_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_0_b_0 : Model := ⟨⟨[],["go"],[]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m0_0_b_0 = [] := by decide
example : failures m0_0_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_0_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_0_b_1 : Model := ⟨⟨[],["go"],[]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_0_b_1 = [] := by decide
example : failures m0_0_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_0_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_0_b_2 : Model := ⟨⟨[],["go"],[]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_0_b_2 = [] := by decide
example : failures m0_0_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_0_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_0_b_3 : Model := ⟨⟨[],["go"],[]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_0_b_3 = [] := by decide
example : failures m0_0_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_0_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_1_a_0 : Model := ⟨⟨[],["go"],[("a","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m0_1_a_0 = [] := by decide
example : failures m0_1_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_1_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_1_a_1 : Model := ⟨⟨[],["go"],[("a","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_1_a_1 = [] := by decide
example : failures m0_1_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_1_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_1_a_2 : Model := ⟨⟨[],["go"],[("a","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_1_a_2 = [] := by decide
example : failures m0_1_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_1_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_1_a_3 : Model := ⟨⟨[],["go"],[("a","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_1_a_3 = [] := by decide
example : failures m0_1_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_1_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_1_b_0 : Model := ⟨⟨[],["go"],[("a","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m0_1_b_0 = [] := by decide
example : failures m0_1_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_1_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_1_b_1 : Model := ⟨⟨[],["go"],[("a","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_1_b_1 = [] := by decide
example : failures m0_1_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_1_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_1_b_2 : Model := ⟨⟨[],["go"],[("a","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_1_b_2 = [] := by decide
example : failures m0_1_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_1_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_1_b_3 : Model := ⟨⟨[],["go"],[("a","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_1_b_3 = [] := by decide
example : failures m0_1_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_1_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_2_a_0 : Model := ⟨⟨[],["go"],[("a","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m0_2_a_0 = [] := by decide
example : failures m0_2_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_2_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_2_a_1 : Model := ⟨⟨[],["go"],[("a","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_2_a_1 = [] := by decide
example : failures m0_2_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_2_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_2_a_2 : Model := ⟨⟨[],["go"],[("a","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_2_a_2 = [] := by decide
example : failures m0_2_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_2_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_2_a_3 : Model := ⟨⟨[],["go"],[("a","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_2_a_3 = [] := by decide
example : failures m0_2_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_2_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_2_b_0 : Model := ⟨⟨[],["go"],[("a","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m0_2_b_0 = [] := by decide
example : failures m0_2_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_2_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_2_b_1 : Model := ⟨⟨[],["go"],[("a","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_2_b_1 = [] := by decide
example : failures m0_2_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_2_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_2_b_2 : Model := ⟨⟨[],["go"],[("a","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_2_b_2 = [] := by decide
example : failures m0_2_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_2_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_2_b_3 : Model := ⟨⟨[],["go"],[("a","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_2_b_3 = [] := by decide
example : failures m0_2_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_2_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_3_a_0 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m0_3_a_0 = [] := by decide
example : failures m0_3_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_3_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_3_a_1 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_3_a_1 = [] := by decide
example : failures m0_3_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_3_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_3_a_2 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_3_a_2 = [] := by decide
example : failures m0_3_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_3_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_3_a_3 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_3_a_3 = [] := by decide
example : failures m0_3_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_3_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_3_b_0 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m0_3_b_0 = [] := by decide
example : failures m0_3_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_3_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_3_b_1 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_3_b_1 = [] := by decide
example : failures m0_3_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_3_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_3_b_2 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_3_b_2 = [] := by decide
example : failures m0_3_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_3_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_3_b_3 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_3_b_3 = [] := by decide
example : failures m0_3_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_3_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_4_a_0 : Model := ⟨⟨[],["go"],[("b","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m0_4_a_0 = [] := by decide
example : failures m0_4_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_4_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_4_a_1 : Model := ⟨⟨[],["go"],[("b","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_4_a_1 = [] := by decide
example : failures m0_4_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_4_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_4_a_2 : Model := ⟨⟨[],["go"],[("b","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_4_a_2 = [] := by decide
example : failures m0_4_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_4_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_4_a_3 : Model := ⟨⟨[],["go"],[("b","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_4_a_3 = [] := by decide
example : failures m0_4_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_4_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_4_b_0 : Model := ⟨⟨[],["go"],[("b","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m0_4_b_0 = [] := by decide
example : failures m0_4_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_4_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_4_b_1 : Model := ⟨⟨[],["go"],[("b","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_4_b_1 = [] := by decide
example : failures m0_4_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_4_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_4_b_2 : Model := ⟨⟨[],["go"],[("b","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_4_b_2 = [] := by decide
example : failures m0_4_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_4_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_4_b_3 : Model := ⟨⟨[],["go"],[("b","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_4_b_3 = [] := by decide
example : failures m0_4_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_4_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_5_a_0 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m0_5_a_0 = [] := by decide
example : failures m0_5_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_5_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_5_a_1 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_5_a_1 = [] := by decide
example : failures m0_5_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_5_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_5_a_2 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_5_a_2 = [] := by decide
example : failures m0_5_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_5_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_5_a_3 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_5_a_3 = [] := by decide
example : failures m0_5_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_5_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_5_b_0 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m0_5_b_0 = [] := by decide
example : failures m0_5_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_5_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_5_b_1 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_5_b_1 = [] := by decide
example : failures m0_5_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_5_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_5_b_2 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_5_b_2 = [] := by decide
example : failures m0_5_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_5_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_5_b_3 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_5_b_3 = [] := by decide
example : failures m0_5_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_5_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_6_a_0 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m0_6_a_0 = [] := by decide
example : failures m0_6_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_6_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_6_a_1 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_6_a_1 = [] := by decide
example : failures m0_6_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_6_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_6_a_2 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_6_a_2 = [] := by decide
example : failures m0_6_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_6_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_6_a_3 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_6_a_3 = [] := by decide
example : failures m0_6_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_6_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_6_b_0 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m0_6_b_0 = [] := by decide
example : failures m0_6_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_6_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_6_b_1 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_6_b_1 = [] := by decide
example : failures m0_6_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_6_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_6_b_2 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_6_b_2 = [] := by decide
example : failures m0_6_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_6_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_6_b_3 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_6_b_3 = [] := by decide
example : failures m0_6_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_6_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_7_a_0 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m0_7_a_0 = [] := by decide
example : failures m0_7_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_7_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_7_a_1 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_7_a_1 = [] := by decide
example : failures m0_7_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_7_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_7_a_2 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_7_a_2 = [] := by decide
example : failures m0_7_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_7_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_7_a_3 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_7_a_3 = [] := by decide
example : failures m0_7_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_7_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_7_b_0 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m0_7_b_0 = [] := by decide
example : failures m0_7_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_7_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_7_b_1 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_7_b_1 = [] := by decide
example : failures m0_7_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_7_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_7_b_2 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_7_b_2 = [] := by decide
example : failures m0_7_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_7_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_7_b_3 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_7_b_3 = [] := by decide
example : failures m0_7_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_7_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_8_a_0 : Model := ⟨⟨[],["go"],[("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m0_8_a_0 = [] := by decide
example : failures m0_8_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_8_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_8_a_1 : Model := ⟨⟨[],["go"],[("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_8_a_1 = [] := by decide
example : failures m0_8_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_8_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_8_a_2 : Model := ⟨⟨[],["go"],[("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_8_a_2 = [] := by decide
example : failures m0_8_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_8_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_8_a_3 : Model := ⟨⟨[],["go"],[("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_8_a_3 = [] := by decide
example : failures m0_8_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_8_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_8_b_0 : Model := ⟨⟨[],["go"],[("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m0_8_b_0 = [] := by decide
example : failures m0_8_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_8_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_8_b_1 : Model := ⟨⟨[],["go"],[("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_8_b_1 = [] := by decide
example : failures m0_8_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_8_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_8_b_2 : Model := ⟨⟨[],["go"],[("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_8_b_2 = [] := by decide
example : failures m0_8_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_8_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_8_b_3 : Model := ⟨⟨[],["go"],[("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_8_b_3 = [] := by decide
example : failures m0_8_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_8_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_9_a_0 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m0_9_a_0 = [] := by decide
example : failures m0_9_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_9_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_9_a_1 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_9_a_1 = [] := by decide
example : failures m0_9_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_9_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_9_a_2 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_9_a_2 = [] := by decide
example : failures m0_9_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_9_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_9_a_3 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_9_a_3 = [] := by decide
example : failures m0_9_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_9_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_9_b_0 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m0_9_b_0 = [] := by decide
example : failures m0_9_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_9_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_9_b_1 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_9_b_1 = [] := by decide
example : failures m0_9_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_9_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_9_b_2 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_9_b_2 = [] := by decide
example : failures m0_9_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_9_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_9_b_3 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_9_b_3 = [] := by decide
example : failures m0_9_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_9_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_10_a_0 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m0_10_a_0 = [] := by decide
example : failures m0_10_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_10_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_10_a_1 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_10_a_1 = [] := by decide
example : failures m0_10_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_10_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_10_a_2 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_10_a_2 = [] := by decide
example : failures m0_10_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_10_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_10_a_3 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_10_a_3 = [] := by decide
example : failures m0_10_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_10_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_10_b_0 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m0_10_b_0 = [] := by decide
example : failures m0_10_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_10_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_10_b_1 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_10_b_1 = [] := by decide
example : failures m0_10_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_10_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_10_b_2 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_10_b_2 = [] := by decide
example : failures m0_10_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_10_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_10_b_3 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_10_b_3 = [] := by decide
example : failures m0_10_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_10_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_11_a_0 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m0_11_a_0 = [] := by decide
example : failures m0_11_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_11_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_11_a_1 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_11_a_1 = [] := by decide
example : failures m0_11_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_11_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_11_a_2 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_11_a_2 = [] := by decide
example : failures m0_11_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_11_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_11_a_3 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_11_a_3 = [] := by decide
example : failures m0_11_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_11_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_11_b_0 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m0_11_b_0 = [] := by decide
example : failures m0_11_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_11_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_11_b_1 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_11_b_1 = [] := by decide
example : failures m0_11_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_11_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_11_b_2 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_11_b_2 = [] := by decide
example : failures m0_11_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_11_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_11_b_3 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_11_b_3 = [] := by decide
example : failures m0_11_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_11_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_12_a_0 : Model := ⟨⟨[],["go"],[("b","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m0_12_a_0 = [] := by decide
example : failures m0_12_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_12_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_12_a_1 : Model := ⟨⟨[],["go"],[("b","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_12_a_1 = [] := by decide
example : failures m0_12_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_12_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_12_a_2 : Model := ⟨⟨[],["go"],[("b","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_12_a_2 = [] := by decide
example : failures m0_12_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_12_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_12_a_3 : Model := ⟨⟨[],["go"],[("b","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_12_a_3 = [] := by decide
example : failures m0_12_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_12_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_12_b_0 : Model := ⟨⟨[],["go"],[("b","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m0_12_b_0 = [] := by decide
example : failures m0_12_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_12_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_12_b_1 : Model := ⟨⟨[],["go"],[("b","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_12_b_1 = [] := by decide
example : failures m0_12_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_12_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_12_b_2 : Model := ⟨⟨[],["go"],[("b","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_12_b_2 = [] := by decide
example : failures m0_12_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_12_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_12_b_3 : Model := ⟨⟨[],["go"],[("b","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_12_b_3 = [] := by decide
example : failures m0_12_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_12_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_13_a_0 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m0_13_a_0 = [] := by decide
example : failures m0_13_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_13_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_13_a_1 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_13_a_1 = [] := by decide
example : failures m0_13_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_13_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_13_a_2 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_13_a_2 = [] := by decide
example : failures m0_13_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_13_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_13_a_3 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_13_a_3 = [] := by decide
example : failures m0_13_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_13_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_13_b_0 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m0_13_b_0 = [] := by decide
example : failures m0_13_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_13_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_13_b_1 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_13_b_1 = [] := by decide
example : failures m0_13_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_13_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_13_b_2 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_13_b_2 = [] := by decide
example : failures m0_13_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_13_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_13_b_3 : Model := ⟨⟨[],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_13_b_3 = [] := by decide
example : failures m0_13_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_13_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_14_a_0 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m0_14_a_0 = [] := by decide
example : failures m0_14_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_14_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_14_a_1 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_14_a_1 = [] := by decide
example : failures m0_14_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_14_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_14_a_2 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_14_a_2 = [] := by decide
example : failures m0_14_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_14_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_14_a_3 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_14_a_3 = [] := by decide
example : failures m0_14_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_14_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_14_b_0 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m0_14_b_0 = [] := by decide
example : failures m0_14_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_14_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_14_b_1 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_14_b_1 = [] := by decide
example : failures m0_14_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_14_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_14_b_2 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_14_b_2 = [] := by decide
example : failures m0_14_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_14_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_14_b_3 : Model := ⟨⟨[],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_14_b_3 = [] := by decide
example : failures m0_14_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_14_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_15_a_0 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m0_15_a_0 = [] := by decide
example : failures m0_15_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_15_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_15_a_1 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_15_a_1 = [] := by decide
example : failures m0_15_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_15_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_15_a_2 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_15_a_2 = [] := by decide
example : failures m0_15_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_15_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_15_a_3 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_15_a_3 = [] := by decide
example : failures m0_15_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_15_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_15_b_0 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m0_15_b_0 = [] := by decide
example : failures m0_15_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m0_15_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_15_b_1 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m0_15_b_1 = [] := by decide
example : failures m0_15_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m0_15_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_15_b_2 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m0_15_b_2 = [] := by decide
example : failures m0_15_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m0_15_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m0_15_b_3 : Model := ⟨⟨[],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m0_15_b_3 = [] := by decide
example : failures m0_15_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m0_15_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_0_a_0 : Model := ⟨⟨["a"],["go"],[]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m1_0_a_0 = [] := by decide
example : failures m1_0_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_0_a_0 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_0_a_1 : Model := ⟨⟨["a"],["go"],[]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_0_a_1 = [[]] := by decide
example : failures m1_0_a_1 = [["go"],["go","go"]] := by decide
example : ledger m1_0_a_1 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_0_a_2 : Model := ⟨⟨["a"],["go"],[]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_0_a_2 = [] := by decide
example : failures m1_0_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_0_a_2 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_0_a_3 : Model := ⟨⟨["a"],["go"],[]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_0_a_3 = [[]] := by decide
example : failures m1_0_a_3 = [["go"],["go","go"]] := by decide
example : ledger m1_0_a_3 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_0_b_0 : Model := ⟨⟨["a"],["go"],[]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m1_0_b_0 = [] := by decide
example : failures m1_0_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_0_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_0_b_1 : Model := ⟨⟨["a"],["go"],[]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_0_b_1 = [] := by decide
example : failures m1_0_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m1_0_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_0_b_2 : Model := ⟨⟨["a"],["go"],[]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_0_b_2 = [] := by decide
example : failures m1_0_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_0_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_0_b_3 : Model := ⟨⟨["a"],["go"],[]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_0_b_3 = [] := by decide
example : failures m1_0_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m1_0_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_1_a_0 : Model := ⟨⟨["a"],["go"],[("a","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m1_1_a_0 = [] := by decide
example : failures m1_1_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_1_a_0 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m1_1_a_1 : Model := ⟨⟨["a"],["go"],[("a","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_1_a_1 = [[],["go"],["go","go"]] := by decide
example : failures m1_1_a_1 = [] := by decide
example : ledger m1_1_a_1 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m1_1_a_2 : Model := ⟨⟨["a"],["go"],[("a","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_1_a_2 = [] := by decide
example : failures m1_1_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_1_a_2 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m1_1_a_3 : Model := ⟨⟨["a"],["go"],[("a","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_1_a_3 = [[],["go"],["go","go"]] := by decide
example : failures m1_1_a_3 = [] := by decide
example : ledger m1_1_a_3 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m1_1_b_0 : Model := ⟨⟨["a"],["go"],[("a","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m1_1_b_0 = [] := by decide
example : failures m1_1_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_1_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_1_b_1 : Model := ⟨⟨["a"],["go"],[("a","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_1_b_1 = [] := by decide
example : failures m1_1_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m1_1_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_1_b_2 : Model := ⟨⟨["a"],["go"],[("a","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_1_b_2 = [] := by decide
example : failures m1_1_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_1_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_1_b_3 : Model := ⟨⟨["a"],["go"],[("a","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_1_b_3 = [] := by decide
example : failures m1_1_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m1_1_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_2_a_0 : Model := ⟨⟨["a"],["go"],[("a","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m1_2_a_0 = [] := by decide
example : failures m1_2_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_2_a_0 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_2_a_1 : Model := ⟨⟨["a"],["go"],[("a","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_2_a_1 = [[]] := by decide
example : failures m1_2_a_1 = [["go"],["go","go"]] := by decide
example : ledger m1_2_a_1 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_2_a_2 : Model := ⟨⟨["a"],["go"],[("a","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_2_a_2 = [["go"]] := by decide
example : failures m1_2_a_2 = [[],["go","go"]] := by decide
example : ledger m1_2_a_2 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_2_a_3 : Model := ⟨⟨["a"],["go"],[("a","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_2_a_3 = [[],["go"]] := by decide
example : failures m1_2_a_3 = [["go","go"]] := by decide
example : ledger m1_2_a_3 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_2_b_0 : Model := ⟨⟨["a"],["go"],[("a","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m1_2_b_0 = [] := by decide
example : failures m1_2_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_2_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_2_b_1 : Model := ⟨⟨["a"],["go"],[("a","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_2_b_1 = [] := by decide
example : failures m1_2_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m1_2_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_2_b_2 : Model := ⟨⟨["a"],["go"],[("a","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_2_b_2 = [] := by decide
example : failures m1_2_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_2_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_2_b_3 : Model := ⟨⟨["a"],["go"],[("a","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_2_b_3 = [] := by decide
example : failures m1_2_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m1_2_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_3_a_0 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m1_3_a_0 = [] := by decide
example : failures m1_3_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_3_a_0 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_3_a_1 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_3_a_1 = [[]] := by decide
example : failures m1_3_a_1 = [["go"],["go","go"]] := by decide
example : ledger m1_3_a_1 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_3_a_2 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_3_a_2 = [] := by decide
example : failures m1_3_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_3_a_2 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_3_a_3 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_3_a_3 = [[]] := by decide
example : failures m1_3_a_3 = [["go"],["go","go"]] := by decide
example : ledger m1_3_a_3 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_3_b_0 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m1_3_b_0 = [] := by decide
example : failures m1_3_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_3_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_3_b_1 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_3_b_1 = [] := by decide
example : failures m1_3_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m1_3_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_3_b_2 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_3_b_2 = [] := by decide
example : failures m1_3_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_3_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_3_b_3 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_3_b_3 = [] := by decide
example : failures m1_3_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m1_3_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_4_a_0 : Model := ⟨⟨["a"],["go"],[("b","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m1_4_a_0 = [] := by decide
example : failures m1_4_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_4_a_0 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_4_a_1 : Model := ⟨⟨["a"],["go"],[("b","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_4_a_1 = [[]] := by decide
example : failures m1_4_a_1 = [["go"],["go","go"]] := by decide
example : ledger m1_4_a_1 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_4_a_2 : Model := ⟨⟨["a"],["go"],[("b","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_4_a_2 = [] := by decide
example : failures m1_4_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_4_a_2 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_4_a_3 : Model := ⟨⟨["a"],["go"],[("b","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_4_a_3 = [[]] := by decide
example : failures m1_4_a_3 = [["go"],["go","go"]] := by decide
example : ledger m1_4_a_3 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_4_b_0 : Model := ⟨⟨["a"],["go"],[("b","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m1_4_b_0 = [] := by decide
example : failures m1_4_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_4_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_4_b_1 : Model := ⟨⟨["a"],["go"],[("b","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_4_b_1 = [] := by decide
example : failures m1_4_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m1_4_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_4_b_2 : Model := ⟨⟨["a"],["go"],[("b","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_4_b_2 = [] := by decide
example : failures m1_4_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_4_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_4_b_3 : Model := ⟨⟨["a"],["go"],[("b","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_4_b_3 = [] := by decide
example : failures m1_4_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m1_4_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_5_a_0 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m1_5_a_0 = [] := by decide
example : failures m1_5_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_5_a_0 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m1_5_a_1 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_5_a_1 = [[],["go"],["go","go"]] := by decide
example : failures m1_5_a_1 = [] := by decide
example : ledger m1_5_a_1 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m1_5_a_2 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_5_a_2 = [] := by decide
example : failures m1_5_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_5_a_2 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m1_5_a_3 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_5_a_3 = [[],["go"],["go","go"]] := by decide
example : failures m1_5_a_3 = [] := by decide
example : ledger m1_5_a_3 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m1_5_b_0 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m1_5_b_0 = [] := by decide
example : failures m1_5_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_5_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_5_b_1 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_5_b_1 = [] := by decide
example : failures m1_5_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m1_5_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_5_b_2 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_5_b_2 = [] := by decide
example : failures m1_5_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_5_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_5_b_3 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_5_b_3 = [] := by decide
example : failures m1_5_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m1_5_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_6_a_0 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m1_6_a_0 = [] := by decide
example : failures m1_6_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_6_a_0 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .ok ["a","b","a"])] := rfl
def m1_6_a_1 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_6_a_1 = [[],["go","go"]] := by decide
example : failures m1_6_a_1 = [["go"]] := by decide
example : ledger m1_6_a_1 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .ok ["a","b","a"])] := rfl
def m1_6_a_2 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_6_a_2 = [["go"]] := by decide
example : failures m1_6_a_2 = [[],["go","go"]] := by decide
example : ledger m1_6_a_2 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .ok ["a","b","a"])] := rfl
def m1_6_a_3 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_6_a_3 = [[],["go"],["go","go"]] := by decide
example : failures m1_6_a_3 = [] := by decide
example : ledger m1_6_a_3 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .ok ["a","b","a"])] := rfl
def m1_6_b_0 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m1_6_b_0 = [] := by decide
example : failures m1_6_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_6_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_6_b_1 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_6_b_1 = [] := by decide
example : failures m1_6_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m1_6_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_6_b_2 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_6_b_2 = [] := by decide
example : failures m1_6_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_6_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_6_b_3 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_6_b_3 = [] := by decide
example : failures m1_6_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m1_6_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_7_a_0 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m1_7_a_0 = [] := by decide
example : failures m1_7_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_7_a_0 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_7_a_1 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_7_a_1 = [[]] := by decide
example : failures m1_7_a_1 = [["go"],["go","go"]] := by decide
example : ledger m1_7_a_1 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_7_a_2 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_7_a_2 = [] := by decide
example : failures m1_7_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_7_a_2 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_7_a_3 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_7_a_3 = [[]] := by decide
example : failures m1_7_a_3 = [["go"],["go","go"]] := by decide
example : ledger m1_7_a_3 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_7_b_0 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m1_7_b_0 = [] := by decide
example : failures m1_7_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_7_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_7_b_1 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_7_b_1 = [] := by decide
example : failures m1_7_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m1_7_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_7_b_2 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_7_b_2 = [] := by decide
example : failures m1_7_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_7_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_7_b_3 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_7_b_3 = [] := by decide
example : failures m1_7_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m1_7_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_8_a_0 : Model := ⟨⟨["a"],["go"],[("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m1_8_a_0 = [] := by decide
example : failures m1_8_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_8_a_0 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_8_a_1 : Model := ⟨⟨["a"],["go"],[("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_8_a_1 = [[]] := by decide
example : failures m1_8_a_1 = [["go"],["go","go"]] := by decide
example : ledger m1_8_a_1 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_8_a_2 : Model := ⟨⟨["a"],["go"],[("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_8_a_2 = [] := by decide
example : failures m1_8_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_8_a_2 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_8_a_3 : Model := ⟨⟨["a"],["go"],[("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_8_a_3 = [[]] := by decide
example : failures m1_8_a_3 = [["go"],["go","go"]] := by decide
example : ledger m1_8_a_3 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_8_b_0 : Model := ⟨⟨["a"],["go"],[("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m1_8_b_0 = [] := by decide
example : failures m1_8_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_8_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_8_b_1 : Model := ⟨⟨["a"],["go"],[("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_8_b_1 = [] := by decide
example : failures m1_8_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m1_8_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_8_b_2 : Model := ⟨⟨["a"],["go"],[("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_8_b_2 = [] := by decide
example : failures m1_8_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_8_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_8_b_3 : Model := ⟨⟨["a"],["go"],[("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_8_b_3 = [] := by decide
example : failures m1_8_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m1_8_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_9_a_0 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m1_9_a_0 = [] := by decide
example : failures m1_9_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_9_a_0 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m1_9_a_1 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_9_a_1 = [[],["go"],["go","go"]] := by decide
example : failures m1_9_a_1 = [] := by decide
example : ledger m1_9_a_1 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m1_9_a_2 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_9_a_2 = [] := by decide
example : failures m1_9_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_9_a_2 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m1_9_a_3 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_9_a_3 = [[],["go"],["go","go"]] := by decide
example : failures m1_9_a_3 = [] := by decide
example : ledger m1_9_a_3 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m1_9_b_0 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m1_9_b_0 = [] := by decide
example : failures m1_9_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_9_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_9_b_1 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_9_b_1 = [] := by decide
example : failures m1_9_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m1_9_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_9_b_2 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_9_b_2 = [] := by decide
example : failures m1_9_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_9_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_9_b_3 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_9_b_3 = [] := by decide
example : failures m1_9_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m1_9_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_10_a_0 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m1_10_a_0 = [] := by decide
example : failures m1_10_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_10_a_0 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .ok ["a","b","b"])] := rfl
def m1_10_a_1 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_10_a_1 = [[]] := by decide
example : failures m1_10_a_1 = [["go"],["go","go"]] := by decide
example : ledger m1_10_a_1 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .ok ["a","b","b"])] := rfl
def m1_10_a_2 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_10_a_2 = [["go"],["go","go"]] := by decide
example : failures m1_10_a_2 = [[]] := by decide
example : ledger m1_10_a_2 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .ok ["a","b","b"])] := rfl
def m1_10_a_3 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_10_a_3 = [[],["go"],["go","go"]] := by decide
example : failures m1_10_a_3 = [] := by decide
example : ledger m1_10_a_3 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .ok ["a","b","b"])] := rfl
def m1_10_b_0 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m1_10_b_0 = [] := by decide
example : failures m1_10_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_10_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_10_b_1 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_10_b_1 = [] := by decide
example : failures m1_10_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m1_10_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_10_b_2 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_10_b_2 = [] := by decide
example : failures m1_10_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_10_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_10_b_3 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_10_b_3 = [] := by decide
example : failures m1_10_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m1_10_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_11_a_0 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m1_11_a_0 = [] := by decide
example : failures m1_11_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_11_a_0 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_11_a_1 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_11_a_1 = [[]] := by decide
example : failures m1_11_a_1 = [["go"],["go","go"]] := by decide
example : ledger m1_11_a_1 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_11_a_2 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_11_a_2 = [] := by decide
example : failures m1_11_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_11_a_2 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_11_a_3 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_11_a_3 = [[]] := by decide
example : failures m1_11_a_3 = [["go"],["go","go"]] := by decide
example : ledger m1_11_a_3 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_11_b_0 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m1_11_b_0 = [] := by decide
example : failures m1_11_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_11_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_11_b_1 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_11_b_1 = [] := by decide
example : failures m1_11_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m1_11_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_11_b_2 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_11_b_2 = [] := by decide
example : failures m1_11_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_11_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_11_b_3 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_11_b_3 = [] := by decide
example : failures m1_11_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m1_11_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_12_a_0 : Model := ⟨⟨["a"],["go"],[("b","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m1_12_a_0 = [] := by decide
example : failures m1_12_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_12_a_0 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_12_a_1 : Model := ⟨⟨["a"],["go"],[("b","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_12_a_1 = [[]] := by decide
example : failures m1_12_a_1 = [["go"],["go","go"]] := by decide
example : ledger m1_12_a_1 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_12_a_2 : Model := ⟨⟨["a"],["go"],[("b","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_12_a_2 = [] := by decide
example : failures m1_12_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_12_a_2 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_12_a_3 : Model := ⟨⟨["a"],["go"],[("b","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_12_a_3 = [[]] := by decide
example : failures m1_12_a_3 = [["go"],["go","go"]] := by decide
example : ledger m1_12_a_3 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_12_b_0 : Model := ⟨⟨["a"],["go"],[("b","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m1_12_b_0 = [] := by decide
example : failures m1_12_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_12_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_12_b_1 : Model := ⟨⟨["a"],["go"],[("b","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_12_b_1 = [] := by decide
example : failures m1_12_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m1_12_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_12_b_2 : Model := ⟨⟨["a"],["go"],[("b","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_12_b_2 = [] := by decide
example : failures m1_12_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_12_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_12_b_3 : Model := ⟨⟨["a"],["go"],[("b","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_12_b_3 = [] := by decide
example : failures m1_12_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m1_12_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_13_a_0 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m1_13_a_0 = [] := by decide
example : failures m1_13_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_13_a_0 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m1_13_a_1 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_13_a_1 = [[],["go"],["go","go"]] := by decide
example : failures m1_13_a_1 = [] := by decide
example : ledger m1_13_a_1 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m1_13_a_2 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_13_a_2 = [] := by decide
example : failures m1_13_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_13_a_2 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m1_13_a_3 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_13_a_3 = [[],["go"],["go","go"]] := by decide
example : failures m1_13_a_3 = [] := by decide
example : ledger m1_13_a_3 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m1_13_b_0 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m1_13_b_0 = [] := by decide
example : failures m1_13_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_13_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_13_b_1 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_13_b_1 = [] := by decide
example : failures m1_13_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m1_13_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_13_b_2 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_13_b_2 = [] := by decide
example : failures m1_13_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_13_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_13_b_3 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_13_b_3 = [] := by decide
example : failures m1_13_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m1_13_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_14_a_0 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m1_14_a_0 = [] := by decide
example : failures m1_14_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_14_a_0 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_14_a_1 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_14_a_1 = [[]] := by decide
example : failures m1_14_a_1 = [["go"],["go","go"]] := by decide
example : ledger m1_14_a_1 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_14_a_2 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_14_a_2 = [["go"]] := by decide
example : failures m1_14_a_2 = [[],["go","go"]] := by decide
example : ledger m1_14_a_2 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_14_a_3 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_14_a_3 = [[],["go"]] := by decide
example : failures m1_14_a_3 = [["go","go"]] := by decide
example : ledger m1_14_a_3 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_14_b_0 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m1_14_b_0 = [] := by decide
example : failures m1_14_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_14_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_14_b_1 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_14_b_1 = [] := by decide
example : failures m1_14_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m1_14_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_14_b_2 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_14_b_2 = [] := by decide
example : failures m1_14_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_14_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_14_b_3 : Model := ⟨⟨["a"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_14_b_3 = [] := by decide
example : failures m1_14_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m1_14_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_15_a_0 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m1_15_a_0 = [] := by decide
example : failures m1_15_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_15_a_0 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_15_a_1 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_15_a_1 = [[]] := by decide
example : failures m1_15_a_1 = [["go"],["go","go"]] := by decide
example : ledger m1_15_a_1 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_15_a_2 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_15_a_2 = [] := by decide
example : failures m1_15_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_15_a_2 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_15_a_3 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_15_a_3 = [[]] := by decide
example : failures m1_15_a_3 = [["go"],["go","go"]] := by decide
example : ledger m1_15_a_3 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m1_15_b_0 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m1_15_b_0 = [] := by decide
example : failures m1_15_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m1_15_b_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_15_b_1 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m1_15_b_1 = [] := by decide
example : failures m1_15_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m1_15_b_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_15_b_2 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m1_15_b_2 = [] := by decide
example : failures m1_15_b_2 = [[],["go"],["go","go"]] := by decide
example : ledger m1_15_b_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m1_15_b_3 : Model := ⟨⟨["a"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m1_15_b_3 = [] := by decide
example : failures m1_15_b_3 = [[],["go"],["go","go"]] := by decide
example : ledger m1_15_b_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_0_a_0 : Model := ⟨⟨["b"],["go"],[]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m2_0_a_0 = [] := by decide
example : failures m2_0_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_0_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_0_a_1 : Model := ⟨⟨["b"],["go"],[]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_0_a_1 = [] := by decide
example : failures m2_0_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_0_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_0_a_2 : Model := ⟨⟨["b"],["go"],[]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_0_a_2 = [] := by decide
example : failures m2_0_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m2_0_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_0_a_3 : Model := ⟨⟨["b"],["go"],[]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_0_a_3 = [] := by decide
example : failures m2_0_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m2_0_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_0_b_0 : Model := ⟨⟨["b"],["go"],[]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m2_0_b_0 = [] := by decide
example : failures m2_0_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_0_b_0 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_0_b_1 : Model := ⟨⟨["b"],["go"],[]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_0_b_1 = [] := by decide
example : failures m2_0_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_0_b_1 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_0_b_2 : Model := ⟨⟨["b"],["go"],[]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_0_b_2 = [[]] := by decide
example : failures m2_0_b_2 = [["go"],["go","go"]] := by decide
example : ledger m2_0_b_2 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_0_b_3 : Model := ⟨⟨["b"],["go"],[]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_0_b_3 = [[]] := by decide
example : failures m2_0_b_3 = [["go"],["go","go"]] := by decide
example : ledger m2_0_b_3 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_1_a_0 : Model := ⟨⟨["b"],["go"],[("a","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m2_1_a_0 = [] := by decide
example : failures m2_1_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_1_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_1_a_1 : Model := ⟨⟨["b"],["go"],[("a","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_1_a_1 = [] := by decide
example : failures m2_1_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_1_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_1_a_2 : Model := ⟨⟨["b"],["go"],[("a","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_1_a_2 = [] := by decide
example : failures m2_1_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m2_1_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_1_a_3 : Model := ⟨⟨["b"],["go"],[("a","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_1_a_3 = [] := by decide
example : failures m2_1_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m2_1_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_1_b_0 : Model := ⟨⟨["b"],["go"],[("a","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m2_1_b_0 = [] := by decide
example : failures m2_1_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_1_b_0 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_1_b_1 : Model := ⟨⟨["b"],["go"],[("a","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_1_b_1 = [] := by decide
example : failures m2_1_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_1_b_1 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_1_b_2 : Model := ⟨⟨["b"],["go"],[("a","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_1_b_2 = [[]] := by decide
example : failures m2_1_b_2 = [["go"],["go","go"]] := by decide
example : ledger m2_1_b_2 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_1_b_3 : Model := ⟨⟨["b"],["go"],[("a","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_1_b_3 = [[]] := by decide
example : failures m2_1_b_3 = [["go"],["go","go"]] := by decide
example : ledger m2_1_b_3 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_2_a_0 : Model := ⟨⟨["b"],["go"],[("a","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m2_2_a_0 = [] := by decide
example : failures m2_2_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_2_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_2_a_1 : Model := ⟨⟨["b"],["go"],[("a","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_2_a_1 = [] := by decide
example : failures m2_2_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_2_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_2_a_2 : Model := ⟨⟨["b"],["go"],[("a","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_2_a_2 = [] := by decide
example : failures m2_2_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m2_2_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_2_a_3 : Model := ⟨⟨["b"],["go"],[("a","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_2_a_3 = [] := by decide
example : failures m2_2_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m2_2_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_2_b_0 : Model := ⟨⟨["b"],["go"],[("a","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m2_2_b_0 = [] := by decide
example : failures m2_2_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_2_b_0 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_2_b_1 : Model := ⟨⟨["b"],["go"],[("a","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_2_b_1 = [] := by decide
example : failures m2_2_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_2_b_1 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_2_b_2 : Model := ⟨⟨["b"],["go"],[("a","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_2_b_2 = [[]] := by decide
example : failures m2_2_b_2 = [["go"],["go","go"]] := by decide
example : ledger m2_2_b_2 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_2_b_3 : Model := ⟨⟨["b"],["go"],[("a","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_2_b_3 = [[]] := by decide
example : failures m2_2_b_3 = [["go"],["go","go"]] := by decide
example : ledger m2_2_b_3 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_3_a_0 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m2_3_a_0 = [] := by decide
example : failures m2_3_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_3_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_3_a_1 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_3_a_1 = [] := by decide
example : failures m2_3_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_3_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_3_a_2 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_3_a_2 = [] := by decide
example : failures m2_3_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m2_3_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_3_a_3 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_3_a_3 = [] := by decide
example : failures m2_3_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m2_3_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_3_b_0 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m2_3_b_0 = [] := by decide
example : failures m2_3_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_3_b_0 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_3_b_1 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_3_b_1 = [] := by decide
example : failures m2_3_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_3_b_1 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_3_b_2 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_3_b_2 = [[]] := by decide
example : failures m2_3_b_2 = [["go"],["go","go"]] := by decide
example : ledger m2_3_b_2 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_3_b_3 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_3_b_3 = [[]] := by decide
example : failures m2_3_b_3 = [["go"],["go","go"]] := by decide
example : ledger m2_3_b_3 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_4_a_0 : Model := ⟨⟨["b"],["go"],[("b","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m2_4_a_0 = [] := by decide
example : failures m2_4_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_4_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_4_a_1 : Model := ⟨⟨["b"],["go"],[("b","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_4_a_1 = [] := by decide
example : failures m2_4_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_4_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_4_a_2 : Model := ⟨⟨["b"],["go"],[("b","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_4_a_2 = [] := by decide
example : failures m2_4_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m2_4_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_4_a_3 : Model := ⟨⟨["b"],["go"],[("b","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_4_a_3 = [] := by decide
example : failures m2_4_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m2_4_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_4_b_0 : Model := ⟨⟨["b"],["go"],[("b","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m2_4_b_0 = [] := by decide
example : failures m2_4_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_4_b_0 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_4_b_1 : Model := ⟨⟨["b"],["go"],[("b","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_4_b_1 = [["go"]] := by decide
example : failures m2_4_b_1 = [[],["go","go"]] := by decide
example : ledger m2_4_b_1 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_4_b_2 : Model := ⟨⟨["b"],["go"],[("b","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_4_b_2 = [[]] := by decide
example : failures m2_4_b_2 = [["go"],["go","go"]] := by decide
example : ledger m2_4_b_2 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_4_b_3 : Model := ⟨⟨["b"],["go"],[("b","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_4_b_3 = [[],["go"]] := by decide
example : failures m2_4_b_3 = [["go","go"]] := by decide
example : ledger m2_4_b_3 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_5_a_0 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m2_5_a_0 = [] := by decide
example : failures m2_5_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_5_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_5_a_1 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_5_a_1 = [] := by decide
example : failures m2_5_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_5_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_5_a_2 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_5_a_2 = [] := by decide
example : failures m2_5_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m2_5_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_5_a_3 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_5_a_3 = [] := by decide
example : failures m2_5_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m2_5_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_5_b_0 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m2_5_b_0 = [] := by decide
example : failures m2_5_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_5_b_0 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .ok ["b","a","a"])] := rfl
def m2_5_b_1 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_5_b_1 = [["go"],["go","go"]] := by decide
example : failures m2_5_b_1 = [[]] := by decide
example : ledger m2_5_b_1 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .ok ["b","a","a"])] := rfl
def m2_5_b_2 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_5_b_2 = [[]] := by decide
example : failures m2_5_b_2 = [["go"],["go","go"]] := by decide
example : ledger m2_5_b_2 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .ok ["b","a","a"])] := rfl
def m2_5_b_3 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_5_b_3 = [[],["go"],["go","go"]] := by decide
example : failures m2_5_b_3 = [] := by decide
example : ledger m2_5_b_3 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .ok ["b","a","a"])] := rfl
def m2_6_a_0 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m2_6_a_0 = [] := by decide
example : failures m2_6_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_6_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_6_a_1 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_6_a_1 = [] := by decide
example : failures m2_6_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_6_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_6_a_2 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_6_a_2 = [] := by decide
example : failures m2_6_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m2_6_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_6_a_3 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_6_a_3 = [] := by decide
example : failures m2_6_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m2_6_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_6_b_0 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m2_6_b_0 = [] := by decide
example : failures m2_6_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_6_b_0 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .ok ["b","a","b"])] := rfl
def m2_6_b_1 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_6_b_1 = [["go"]] := by decide
example : failures m2_6_b_1 = [[],["go","go"]] := by decide
example : ledger m2_6_b_1 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .ok ["b","a","b"])] := rfl
def m2_6_b_2 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_6_b_2 = [[],["go","go"]] := by decide
example : failures m2_6_b_2 = [["go"]] := by decide
example : ledger m2_6_b_2 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .ok ["b","a","b"])] := rfl
def m2_6_b_3 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_6_b_3 = [[],["go"],["go","go"]] := by decide
example : failures m2_6_b_3 = [] := by decide
example : ledger m2_6_b_3 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .ok ["b","a","b"])] := rfl
def m2_7_a_0 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m2_7_a_0 = [] := by decide
example : failures m2_7_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_7_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_7_a_1 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_7_a_1 = [] := by decide
example : failures m2_7_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_7_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_7_a_2 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_7_a_2 = [] := by decide
example : failures m2_7_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m2_7_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_7_a_3 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_7_a_3 = [] := by decide
example : failures m2_7_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m2_7_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_7_b_0 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m2_7_b_0 = [] := by decide
example : failures m2_7_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_7_b_0 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_7_b_1 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_7_b_1 = [["go"]] := by decide
example : failures m2_7_b_1 = [[],["go","go"]] := by decide
example : ledger m2_7_b_1 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_7_b_2 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_7_b_2 = [[]] := by decide
example : failures m2_7_b_2 = [["go"],["go","go"]] := by decide
example : ledger m2_7_b_2 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_7_b_3 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_7_b_3 = [[],["go"]] := by decide
example : failures m2_7_b_3 = [["go","go"]] := by decide
example : ledger m2_7_b_3 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_8_a_0 : Model := ⟨⟨["b"],["go"],[("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m2_8_a_0 = [] := by decide
example : failures m2_8_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_8_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_8_a_1 : Model := ⟨⟨["b"],["go"],[("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_8_a_1 = [] := by decide
example : failures m2_8_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_8_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_8_a_2 : Model := ⟨⟨["b"],["go"],[("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_8_a_2 = [] := by decide
example : failures m2_8_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m2_8_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_8_a_3 : Model := ⟨⟨["b"],["go"],[("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_8_a_3 = [] := by decide
example : failures m2_8_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m2_8_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_8_b_0 : Model := ⟨⟨["b"],["go"],[("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m2_8_b_0 = [] := by decide
example : failures m2_8_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_8_b_0 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m2_8_b_1 : Model := ⟨⟨["b"],["go"],[("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_8_b_1 = [] := by decide
example : failures m2_8_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_8_b_1 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m2_8_b_2 : Model := ⟨⟨["b"],["go"],[("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_8_b_2 = [[],["go"],["go","go"]] := by decide
example : failures m2_8_b_2 = [] := by decide
example : ledger m2_8_b_2 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m2_8_b_3 : Model := ⟨⟨["b"],["go"],[("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_8_b_3 = [[],["go"],["go","go"]] := by decide
example : failures m2_8_b_3 = [] := by decide
example : ledger m2_8_b_3 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m2_9_a_0 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m2_9_a_0 = [] := by decide
example : failures m2_9_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_9_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_9_a_1 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_9_a_1 = [] := by decide
example : failures m2_9_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_9_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_9_a_2 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_9_a_2 = [] := by decide
example : failures m2_9_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m2_9_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_9_a_3 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_9_a_3 = [] := by decide
example : failures m2_9_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m2_9_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_9_b_0 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m2_9_b_0 = [] := by decide
example : failures m2_9_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_9_b_0 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m2_9_b_1 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_9_b_1 = [] := by decide
example : failures m2_9_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_9_b_1 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m2_9_b_2 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_9_b_2 = [[],["go"],["go","go"]] := by decide
example : failures m2_9_b_2 = [] := by decide
example : ledger m2_9_b_2 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m2_9_b_3 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_9_b_3 = [[],["go"],["go","go"]] := by decide
example : failures m2_9_b_3 = [] := by decide
example : ledger m2_9_b_3 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m2_10_a_0 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m2_10_a_0 = [] := by decide
example : failures m2_10_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_10_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_10_a_1 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_10_a_1 = [] := by decide
example : failures m2_10_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_10_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_10_a_2 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_10_a_2 = [] := by decide
example : failures m2_10_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m2_10_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_10_a_3 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_10_a_3 = [] := by decide
example : failures m2_10_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m2_10_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_10_b_0 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m2_10_b_0 = [] := by decide
example : failures m2_10_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_10_b_0 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m2_10_b_1 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_10_b_1 = [] := by decide
example : failures m2_10_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_10_b_1 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m2_10_b_2 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_10_b_2 = [[],["go"],["go","go"]] := by decide
example : failures m2_10_b_2 = [] := by decide
example : ledger m2_10_b_2 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m2_10_b_3 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_10_b_3 = [[],["go"],["go","go"]] := by decide
example : failures m2_10_b_3 = [] := by decide
example : ledger m2_10_b_3 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m2_11_a_0 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m2_11_a_0 = [] := by decide
example : failures m2_11_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_11_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_11_a_1 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_11_a_1 = [] := by decide
example : failures m2_11_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_11_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_11_a_2 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_11_a_2 = [] := by decide
example : failures m2_11_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m2_11_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_11_a_3 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_11_a_3 = [] := by decide
example : failures m2_11_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m2_11_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_11_b_0 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m2_11_b_0 = [] := by decide
example : failures m2_11_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_11_b_0 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m2_11_b_1 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_11_b_1 = [] := by decide
example : failures m2_11_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_11_b_1 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m2_11_b_2 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_11_b_2 = [[],["go"],["go","go"]] := by decide
example : failures m2_11_b_2 = [] := by decide
example : ledger m2_11_b_2 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m2_11_b_3 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_11_b_3 = [[],["go"],["go","go"]] := by decide
example : failures m2_11_b_3 = [] := by decide
example : ledger m2_11_b_3 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m2_12_a_0 : Model := ⟨⟨["b"],["go"],[("b","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m2_12_a_0 = [] := by decide
example : failures m2_12_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_12_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_12_a_1 : Model := ⟨⟨["b"],["go"],[("b","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_12_a_1 = [] := by decide
example : failures m2_12_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_12_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_12_a_2 : Model := ⟨⟨["b"],["go"],[("b","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_12_a_2 = [] := by decide
example : failures m2_12_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m2_12_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_12_a_3 : Model := ⟨⟨["b"],["go"],[("b","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_12_a_3 = [] := by decide
example : failures m2_12_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m2_12_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_12_b_0 : Model := ⟨⟨["b"],["go"],[("b","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m2_12_b_0 = [] := by decide
example : failures m2_12_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_12_b_0 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_12_b_1 : Model := ⟨⟨["b"],["go"],[("b","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_12_b_1 = [] := by decide
example : failures m2_12_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_12_b_1 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_12_b_2 : Model := ⟨⟨["b"],["go"],[("b","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_12_b_2 = [[]] := by decide
example : failures m2_12_b_2 = [["go"],["go","go"]] := by decide
example : ledger m2_12_b_2 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_12_b_3 : Model := ⟨⟨["b"],["go"],[("b","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_12_b_3 = [[]] := by decide
example : failures m2_12_b_3 = [["go"],["go","go"]] := by decide
example : ledger m2_12_b_3 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_13_a_0 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m2_13_a_0 = [] := by decide
example : failures m2_13_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_13_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_13_a_1 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_13_a_1 = [] := by decide
example : failures m2_13_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_13_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_13_a_2 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_13_a_2 = [] := by decide
example : failures m2_13_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m2_13_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_13_a_3 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_13_a_3 = [] := by decide
example : failures m2_13_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m2_13_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_13_b_0 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m2_13_b_0 = [] := by decide
example : failures m2_13_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_13_b_0 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_13_b_1 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_13_b_1 = [] := by decide
example : failures m2_13_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_13_b_1 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_13_b_2 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_13_b_2 = [[]] := by decide
example : failures m2_13_b_2 = [["go"],["go","go"]] := by decide
example : ledger m2_13_b_2 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_13_b_3 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_13_b_3 = [[]] := by decide
example : failures m2_13_b_3 = [["go"],["go","go"]] := by decide
example : ledger m2_13_b_3 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_14_a_0 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m2_14_a_0 = [] := by decide
example : failures m2_14_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_14_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_14_a_1 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_14_a_1 = [] := by decide
example : failures m2_14_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_14_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_14_a_2 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_14_a_2 = [] := by decide
example : failures m2_14_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m2_14_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_14_a_3 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_14_a_3 = [] := by decide
example : failures m2_14_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m2_14_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_14_b_0 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m2_14_b_0 = [] := by decide
example : failures m2_14_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_14_b_0 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_14_b_1 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_14_b_1 = [] := by decide
example : failures m2_14_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_14_b_1 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_14_b_2 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_14_b_2 = [[]] := by decide
example : failures m2_14_b_2 = [["go"],["go","go"]] := by decide
example : ledger m2_14_b_2 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_14_b_3 : Model := ⟨⟨["b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_14_b_3 = [[]] := by decide
example : failures m2_14_b_3 = [["go"],["go","go"]] := by decide
example : ledger m2_14_b_3 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_15_a_0 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m2_15_a_0 = [] := by decide
example : failures m2_15_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_15_a_0 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_15_a_1 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_15_a_1 = [] := by decide
example : failures m2_15_a_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_15_a_1 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_15_a_2 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_15_a_2 = [] := by decide
example : failures m2_15_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m2_15_a_2 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_15_a_3 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_15_a_3 = [] := by decide
example : failures m2_15_a_3 = [[],["go"],["go","go"]] := by decide
example : ledger m2_15_a_3 = [([], .error "ValueError: initial state is outside the carrier"),(["go"], .error "ValueError: initial state is outside the carrier"),(["go","go"], .error "ValueError: initial state is outside the carrier")] := rfl
def m2_15_b_0 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m2_15_b_0 = [] := by decide
example : failures m2_15_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m2_15_b_0 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_15_b_1 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m2_15_b_1 = [] := by decide
example : failures m2_15_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m2_15_b_1 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_15_b_2 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m2_15_b_2 = [[]] := by decide
example : failures m2_15_b_2 = [["go"],["go","go"]] := by decide
example : ledger m2_15_b_2 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m2_15_b_3 : Model := ⟨⟨["b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m2_15_b_3 = [[]] := by decide
example : failures m2_15_b_3 = [["go"],["go","go"]] := by decide
example : ledger m2_15_b_3 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_0_a_0 : Model := ⟨⟨["a","b"],["go"],[]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m3_0_a_0 = [] := by decide
example : failures m3_0_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_0_a_0 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_0_a_1 : Model := ⟨⟨["a","b"],["go"],[]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_0_a_1 = [[]] := by decide
example : failures m3_0_a_1 = [["go"],["go","go"]] := by decide
example : ledger m3_0_a_1 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_0_a_2 : Model := ⟨⟨["a","b"],["go"],[]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_0_a_2 = [] := by decide
example : failures m3_0_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m3_0_a_2 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_0_a_3 : Model := ⟨⟨["a","b"],["go"],[]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_0_a_3 = [[]] := by decide
example : failures m3_0_a_3 = [["go"],["go","go"]] := by decide
example : ledger m3_0_a_3 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_0_b_0 : Model := ⟨⟨["a","b"],["go"],[]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m3_0_b_0 = [] := by decide
example : failures m3_0_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_0_b_0 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_0_b_1 : Model := ⟨⟨["a","b"],["go"],[]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_0_b_1 = [] := by decide
example : failures m3_0_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m3_0_b_1 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_0_b_2 : Model := ⟨⟨["a","b"],["go"],[]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_0_b_2 = [[]] := by decide
example : failures m3_0_b_2 = [["go"],["go","go"]] := by decide
example : ledger m3_0_b_2 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_0_b_3 : Model := ⟨⟨["a","b"],["go"],[]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_0_b_3 = [[]] := by decide
example : failures m3_0_b_3 = [["go"],["go","go"]] := by decide
example : ledger m3_0_b_3 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_1_a_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m3_1_a_0 = [] := by decide
example : failures m3_1_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_1_a_0 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m3_1_a_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_1_a_1 = [[],["go"],["go","go"]] := by decide
example : failures m3_1_a_1 = [] := by decide
example : ledger m3_1_a_1 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m3_1_a_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_1_a_2 = [] := by decide
example : failures m3_1_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m3_1_a_2 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m3_1_a_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_1_a_3 = [[],["go"],["go","go"]] := by decide
example : failures m3_1_a_3 = [] := by decide
example : ledger m3_1_a_3 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m3_1_b_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m3_1_b_0 = [] := by decide
example : failures m3_1_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_1_b_0 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_1_b_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_1_b_1 = [] := by decide
example : failures m3_1_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m3_1_b_1 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_1_b_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_1_b_2 = [[]] := by decide
example : failures m3_1_b_2 = [["go"],["go","go"]] := by decide
example : ledger m3_1_b_2 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_1_b_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_1_b_3 = [[]] := by decide
example : failures m3_1_b_3 = [["go"],["go","go"]] := by decide
example : ledger m3_1_b_3 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_2_a_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m3_2_a_0 = [] := by decide
example : failures m3_2_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_2_a_0 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_2_a_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_2_a_1 = [[]] := by decide
example : failures m3_2_a_1 = [["go"],["go","go"]] := by decide
example : ledger m3_2_a_1 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_2_a_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_2_a_2 = [["go"]] := by decide
example : failures m3_2_a_2 = [[],["go","go"]] := by decide
example : ledger m3_2_a_2 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_2_a_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_2_a_3 = [[],["go"]] := by decide
example : failures m3_2_a_3 = [["go","go"]] := by decide
example : ledger m3_2_a_3 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_2_b_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m3_2_b_0 = [] := by decide
example : failures m3_2_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_2_b_0 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_2_b_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_2_b_1 = [] := by decide
example : failures m3_2_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m3_2_b_1 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_2_b_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_2_b_2 = [[]] := by decide
example : failures m3_2_b_2 = [["go"],["go","go"]] := by decide
example : ledger m3_2_b_2 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_2_b_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_2_b_3 = [[]] := by decide
example : failures m3_2_b_3 = [["go"],["go","go"]] := by decide
example : ledger m3_2_b_3 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_3_a_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m3_3_a_0 = [] := by decide
example : failures m3_3_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_3_a_0 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_3_a_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_3_a_1 = [[]] := by decide
example : failures m3_3_a_1 = [["go"],["go","go"]] := by decide
example : ledger m3_3_a_1 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_3_a_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_3_a_2 = [] := by decide
example : failures m3_3_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m3_3_a_2 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_3_a_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_3_a_3 = [[]] := by decide
example : failures m3_3_a_3 = [["go"],["go","go"]] := by decide
example : ledger m3_3_a_3 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_3_b_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m3_3_b_0 = [] := by decide
example : failures m3_3_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_3_b_0 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_3_b_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_3_b_1 = [] := by decide
example : failures m3_3_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m3_3_b_1 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_3_b_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_3_b_2 = [[]] := by decide
example : failures m3_3_b_2 = [["go"],["go","go"]] := by decide
example : ledger m3_3_b_2 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_3_b_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_3_b_3 = [[]] := by decide
example : failures m3_3_b_3 = [["go"],["go","go"]] := by decide
example : ledger m3_3_b_3 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_4_a_0 : Model := ⟨⟨["a","b"],["go"],[("b","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m3_4_a_0 = [] := by decide
example : failures m3_4_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_4_a_0 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_4_a_1 : Model := ⟨⟨["a","b"],["go"],[("b","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_4_a_1 = [[]] := by decide
example : failures m3_4_a_1 = [["go"],["go","go"]] := by decide
example : ledger m3_4_a_1 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_4_a_2 : Model := ⟨⟨["a","b"],["go"],[("b","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_4_a_2 = [] := by decide
example : failures m3_4_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m3_4_a_2 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_4_a_3 : Model := ⟨⟨["a","b"],["go"],[("b","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_4_a_3 = [[]] := by decide
example : failures m3_4_a_3 = [["go"],["go","go"]] := by decide
example : ledger m3_4_a_3 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_4_b_0 : Model := ⟨⟨["a","b"],["go"],[("b","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m3_4_b_0 = [] := by decide
example : failures m3_4_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_4_b_0 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_4_b_1 : Model := ⟨⟨["a","b"],["go"],[("b","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_4_b_1 = [["go"]] := by decide
example : failures m3_4_b_1 = [[],["go","go"]] := by decide
example : ledger m3_4_b_1 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_4_b_2 : Model := ⟨⟨["a","b"],["go"],[("b","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_4_b_2 = [[]] := by decide
example : failures m3_4_b_2 = [["go"],["go","go"]] := by decide
example : ledger m3_4_b_2 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_4_b_3 : Model := ⟨⟨["a","b"],["go"],[("b","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_4_b_3 = [[],["go"]] := by decide
example : failures m3_4_b_3 = [["go","go"]] := by decide
example : ledger m3_4_b_3 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_5_a_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m3_5_a_0 = [] := by decide
example : failures m3_5_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_5_a_0 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m3_5_a_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_5_a_1 = [[],["go"],["go","go"]] := by decide
example : failures m3_5_a_1 = [] := by decide
example : ledger m3_5_a_1 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m3_5_a_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_5_a_2 = [] := by decide
example : failures m3_5_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m3_5_a_2 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m3_5_a_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_5_a_3 = [[],["go"],["go","go"]] := by decide
example : failures m3_5_a_3 = [] := by decide
example : ledger m3_5_a_3 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m3_5_b_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m3_5_b_0 = [] := by decide
example : failures m3_5_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_5_b_0 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .ok ["b","a","a"])] := rfl
def m3_5_b_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_5_b_1 = [["go"],["go","go"]] := by decide
example : failures m3_5_b_1 = [[]] := by decide
example : ledger m3_5_b_1 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .ok ["b","a","a"])] := rfl
def m3_5_b_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_5_b_2 = [[]] := by decide
example : failures m3_5_b_2 = [["go"],["go","go"]] := by decide
example : ledger m3_5_b_2 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .ok ["b","a","a"])] := rfl
def m3_5_b_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_5_b_3 = [[],["go"],["go","go"]] := by decide
example : failures m3_5_b_3 = [] := by decide
example : ledger m3_5_b_3 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .ok ["b","a","a"])] := rfl
def m3_6_a_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m3_6_a_0 = [] := by decide
example : failures m3_6_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_6_a_0 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .ok ["a","b","a"])] := rfl
def m3_6_a_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_6_a_1 = [[],["go","go"]] := by decide
example : failures m3_6_a_1 = [["go"]] := by decide
example : ledger m3_6_a_1 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .ok ["a","b","a"])] := rfl
def m3_6_a_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_6_a_2 = [["go"]] := by decide
example : failures m3_6_a_2 = [[],["go","go"]] := by decide
example : ledger m3_6_a_2 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .ok ["a","b","a"])] := rfl
def m3_6_a_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_6_a_3 = [[],["go"],["go","go"]] := by decide
example : failures m3_6_a_3 = [] := by decide
example : ledger m3_6_a_3 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .ok ["a","b","a"])] := rfl
def m3_6_b_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m3_6_b_0 = [] := by decide
example : failures m3_6_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_6_b_0 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .ok ["b","a","b"])] := rfl
def m3_6_b_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_6_b_1 = [["go"]] := by decide
example : failures m3_6_b_1 = [[],["go","go"]] := by decide
example : ledger m3_6_b_1 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .ok ["b","a","b"])] := rfl
def m3_6_b_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_6_b_2 = [[],["go","go"]] := by decide
example : failures m3_6_b_2 = [["go"]] := by decide
example : ledger m3_6_b_2 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .ok ["b","a","b"])] := rfl
def m3_6_b_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_6_b_3 = [[],["go"],["go","go"]] := by decide
example : failures m3_6_b_3 = [] := by decide
example : ledger m3_6_b_3 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .ok ["b","a","b"])] := rfl
def m3_7_a_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m3_7_a_0 = [] := by decide
example : failures m3_7_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_7_a_0 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_7_a_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_7_a_1 = [[]] := by decide
example : failures m3_7_a_1 = [["go"],["go","go"]] := by decide
example : ledger m3_7_a_1 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_7_a_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_7_a_2 = [] := by decide
example : failures m3_7_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m3_7_a_2 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_7_a_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_7_a_3 = [[]] := by decide
example : failures m3_7_a_3 = [["go"],["go","go"]] := by decide
example : ledger m3_7_a_3 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_7_b_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m3_7_b_0 = [] := by decide
example : failures m3_7_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_7_b_0 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_7_b_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_7_b_1 = [["go"]] := by decide
example : failures m3_7_b_1 = [[],["go","go"]] := by decide
example : ledger m3_7_b_1 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_7_b_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_7_b_2 = [[]] := by decide
example : failures m3_7_b_2 = [["go"],["go","go"]] := by decide
example : ledger m3_7_b_2 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_7_b_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_7_b_3 = [[],["go"]] := by decide
example : failures m3_7_b_3 = [["go","go"]] := by decide
example : ledger m3_7_b_3 = [([], .ok ["b"]),(["go"], .ok ["b","a"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_8_a_0 : Model := ⟨⟨["a","b"],["go"],[("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m3_8_a_0 = [] := by decide
example : failures m3_8_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_8_a_0 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_8_a_1 : Model := ⟨⟨["a","b"],["go"],[("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_8_a_1 = [[]] := by decide
example : failures m3_8_a_1 = [["go"],["go","go"]] := by decide
example : ledger m3_8_a_1 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_8_a_2 : Model := ⟨⟨["a","b"],["go"],[("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_8_a_2 = [] := by decide
example : failures m3_8_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m3_8_a_2 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_8_a_3 : Model := ⟨⟨["a","b"],["go"],[("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_8_a_3 = [[]] := by decide
example : failures m3_8_a_3 = [["go"],["go","go"]] := by decide
example : ledger m3_8_a_3 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_8_b_0 : Model := ⟨⟨["a","b"],["go"],[("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m3_8_b_0 = [] := by decide
example : failures m3_8_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_8_b_0 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m3_8_b_1 : Model := ⟨⟨["a","b"],["go"],[("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_8_b_1 = [] := by decide
example : failures m3_8_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m3_8_b_1 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m3_8_b_2 : Model := ⟨⟨["a","b"],["go"],[("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_8_b_2 = [[],["go"],["go","go"]] := by decide
example : failures m3_8_b_2 = [] := by decide
example : ledger m3_8_b_2 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m3_8_b_3 : Model := ⟨⟨["a","b"],["go"],[("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_8_b_3 = [[],["go"],["go","go"]] := by decide
example : failures m3_8_b_3 = [] := by decide
example : ledger m3_8_b_3 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m3_9_a_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m3_9_a_0 = [] := by decide
example : failures m3_9_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_9_a_0 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m3_9_a_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_9_a_1 = [[],["go"],["go","go"]] := by decide
example : failures m3_9_a_1 = [] := by decide
example : ledger m3_9_a_1 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m3_9_a_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_9_a_2 = [] := by decide
example : failures m3_9_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m3_9_a_2 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m3_9_a_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_9_a_3 = [[],["go"],["go","go"]] := by decide
example : failures m3_9_a_3 = [] := by decide
example : ledger m3_9_a_3 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m3_9_b_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m3_9_b_0 = [] := by decide
example : failures m3_9_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_9_b_0 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m3_9_b_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_9_b_1 = [] := by decide
example : failures m3_9_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m3_9_b_1 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m3_9_b_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_9_b_2 = [[],["go"],["go","go"]] := by decide
example : failures m3_9_b_2 = [] := by decide
example : ledger m3_9_b_2 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m3_9_b_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_9_b_3 = [[],["go"],["go","go"]] := by decide
example : failures m3_9_b_3 = [] := by decide
example : ledger m3_9_b_3 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m3_10_a_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m3_10_a_0 = [] := by decide
example : failures m3_10_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_10_a_0 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .ok ["a","b","b"])] := rfl
def m3_10_a_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_10_a_1 = [[]] := by decide
example : failures m3_10_a_1 = [["go"],["go","go"]] := by decide
example : ledger m3_10_a_1 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .ok ["a","b","b"])] := rfl
def m3_10_a_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_10_a_2 = [["go"],["go","go"]] := by decide
example : failures m3_10_a_2 = [[]] := by decide
example : ledger m3_10_a_2 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .ok ["a","b","b"])] := rfl
def m3_10_a_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_10_a_3 = [[],["go"],["go","go"]] := by decide
example : failures m3_10_a_3 = [] := by decide
example : ledger m3_10_a_3 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .ok ["a","b","b"])] := rfl
def m3_10_b_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m3_10_b_0 = [] := by decide
example : failures m3_10_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_10_b_0 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m3_10_b_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_10_b_1 = [] := by decide
example : failures m3_10_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m3_10_b_1 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m3_10_b_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_10_b_2 = [[],["go"],["go","go"]] := by decide
example : failures m3_10_b_2 = [] := by decide
example : ledger m3_10_b_2 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m3_10_b_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_10_b_3 = [[],["go"],["go","go"]] := by decide
example : failures m3_10_b_3 = [] := by decide
example : ledger m3_10_b_3 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m3_11_a_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m3_11_a_0 = [] := by decide
example : failures m3_11_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_11_a_0 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_11_a_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_11_a_1 = [[]] := by decide
example : failures m3_11_a_1 = [["go"],["go","go"]] := by decide
example : ledger m3_11_a_1 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_11_a_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_11_a_2 = [] := by decide
example : failures m3_11_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m3_11_a_2 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_11_a_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_11_a_3 = [[]] := by decide
example : failures m3_11_a_3 = [["go"],["go","go"]] := by decide
example : ledger m3_11_a_3 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_11_b_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m3_11_b_0 = [] := by decide
example : failures m3_11_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_11_b_0 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m3_11_b_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_11_b_1 = [] := by decide
example : failures m3_11_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m3_11_b_1 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m3_11_b_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_11_b_2 = [[],["go"],["go","go"]] := by decide
example : failures m3_11_b_2 = [] := by decide
example : ledger m3_11_b_2 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m3_11_b_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_11_b_3 = [[],["go"],["go","go"]] := by decide
example : failures m3_11_b_3 = [] := by decide
example : ledger m3_11_b_3 = [([], .ok ["b"]),(["go"], .ok ["b","b"]),(["go","go"], .ok ["b","b","b"])] := rfl
def m3_12_a_0 : Model := ⟨⟨["a","b"],["go"],[("b","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m3_12_a_0 = [] := by decide
example : failures m3_12_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_12_a_0 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_12_a_1 : Model := ⟨⟨["a","b"],["go"],[("b","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_12_a_1 = [[]] := by decide
example : failures m3_12_a_1 = [["go"],["go","go"]] := by decide
example : ledger m3_12_a_1 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_12_a_2 : Model := ⟨⟨["a","b"],["go"],[("b","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_12_a_2 = [] := by decide
example : failures m3_12_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m3_12_a_2 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_12_a_3 : Model := ⟨⟨["a","b"],["go"],[("b","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_12_a_3 = [[]] := by decide
example : failures m3_12_a_3 = [["go"],["go","go"]] := by decide
example : ledger m3_12_a_3 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_12_b_0 : Model := ⟨⟨["a","b"],["go"],[("b","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m3_12_b_0 = [] := by decide
example : failures m3_12_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_12_b_0 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_12_b_1 : Model := ⟨⟨["a","b"],["go"],[("b","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_12_b_1 = [] := by decide
example : failures m3_12_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m3_12_b_1 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_12_b_2 : Model := ⟨⟨["a","b"],["go"],[("b","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_12_b_2 = [[]] := by decide
example : failures m3_12_b_2 = [["go"],["go","go"]] := by decide
example : ledger m3_12_b_2 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_12_b_3 : Model := ⟨⟨["a","b"],["go"],[("b","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_12_b_3 = [[]] := by decide
example : failures m3_12_b_3 = [["go"],["go","go"]] := by decide
example : ledger m3_12_b_3 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_13_a_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m3_13_a_0 = [] := by decide
example : failures m3_13_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_13_a_0 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m3_13_a_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_13_a_1 = [[],["go"],["go","go"]] := by decide
example : failures m3_13_a_1 = [] := by decide
example : ledger m3_13_a_1 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m3_13_a_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_13_a_2 = [] := by decide
example : failures m3_13_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m3_13_a_2 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m3_13_a_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_13_a_3 = [[],["go"],["go","go"]] := by decide
example : failures m3_13_a_3 = [] := by decide
example : ledger m3_13_a_3 = [([], .ok ["a"]),(["go"], .ok ["a","a"]),(["go","go"], .ok ["a","a","a"])] := rfl
def m3_13_b_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m3_13_b_0 = [] := by decide
example : failures m3_13_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_13_b_0 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_13_b_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_13_b_1 = [] := by decide
example : failures m3_13_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m3_13_b_1 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_13_b_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_13_b_2 = [[]] := by decide
example : failures m3_13_b_2 = [["go"],["go","go"]] := by decide
example : ledger m3_13_b_2 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_13_b_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_13_b_3 = [[]] := by decide
example : failures m3_13_b_3 = [["go"],["go","go"]] := by decide
example : ledger m3_13_b_3 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_14_a_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m3_14_a_0 = [] := by decide
example : failures m3_14_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_14_a_0 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_14_a_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_14_a_1 = [[]] := by decide
example : failures m3_14_a_1 = [["go"],["go","go"]] := by decide
example : ledger m3_14_a_1 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_14_a_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_14_a_2 = [["go"]] := by decide
example : failures m3_14_a_2 = [[],["go","go"]] := by decide
example : ledger m3_14_a_2 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_14_a_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_14_a_3 = [[],["go"]] := by decide
example : failures m3_14_a_3 = [["go","go"]] := by decide
example : ledger m3_14_a_3 = [([], .ok ["a"]),(["go"], .ok ["a","b"]),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_14_b_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m3_14_b_0 = [] := by decide
example : failures m3_14_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_14_b_0 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_14_b_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_14_b_1 = [] := by decide
example : failures m3_14_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m3_14_b_1 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_14_b_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_14_b_2 = [[]] := by decide
example : failures m3_14_b_2 = [["go"],["go","go"]] := by decide
example : ledger m3_14_b_2 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_14_b_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_14_b_3 = [[]] := by decide
example : failures m3_14_b_3 = [["go"],["go","go"]] := by decide
example : ledger m3_14_b_3 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_15_a_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",[],[[],["go"],["go","go"]]⟩
example : selected m3_15_a_0 = [] := by decide
example : failures m3_15_a_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_15_a_0 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_15_a_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_15_a_1 = [[]] := by decide
example : failures m3_15_a_1 = [["go"],["go","go"]] := by decide
example : ledger m3_15_a_1 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_15_a_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_15_a_2 = [] := by decide
example : failures m3_15_a_2 = [[],["go"],["go","go"]] := by decide
example : ledger m3_15_a_2 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_15_a_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_15_a_3 = [[]] := by decide
example : failures m3_15_a_3 = [["go"],["go","go"]] := by decide
example : ledger m3_15_a_3 = [([], .ok ["a"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_15_b_0 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",[],[[],["go"],["go","go"]]⟩
example : selected m3_15_b_0 = [] := by decide
example : failures m3_15_b_0 = [[],["go"],["go","go"]] := by decide
example : ledger m3_15_b_0 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_15_b_1 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["a"],[[],["go"],["go","go"]]⟩
example : selected m3_15_b_1 = [] := by decide
example : failures m3_15_b_1 = [[],["go"],["go","go"]] := by decide
example : ledger m3_15_b_1 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_15_b_2 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["b"],[[],["go"],["go","go"]]⟩
example : selected m3_15_b_2 = [[]] := by decide
example : failures m3_15_b_2 = [["go"],["go","go"]] := by decide
example : ledger m3_15_b_2 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
def m3_15_b_3 : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b",["a","b"],[[],["go"],["go","go"]]⟩
example : selected m3_15_b_3 = [[]] := by decide
example : failures m3_15_b_3 = [["go"],["go","go"]] := by decide
example : ledger m3_15_b_3 = [([], .ok ["b"]),(["go"], .error "ValueError: the requested transition is not exactly generated"),(["go","go"], .error "ValueError: the requested transition is not exactly generated")] := rfl
theorem nativeComposition : ["go","go"] ∈ selected m3_10_a_2 :=
  planComposition _ "b" "b" ["go"] ["go"] ["a"] ["b"] (.head _)
    (.next _ _ _ _ _ _ rfl (.identity _)) (.next _ _ _ _ _ _ rfl (.identity _))
    (.tail _ (.tail _ (.head _))) (.head _)
theorem nativeExecution : ∃ trace, m3_10_a_2.initial ∈ m3_10_a_2.system.states ∧
    SFT.Computation.StateTransition.Execution m3_10_a_2.system m3_10_a_2.initial ["go","go"] trace ∧
    terminal m3_10_a_2.initial trace ∈ m3_10_a_2.goals := selectedExecution _ _ nativeComposition
#print axioms nativeComposition
#print axioms nativeExecution
end SFT.Computation.SearchPlanning
