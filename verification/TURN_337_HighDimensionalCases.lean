import SFT.Computation.HighDimensional
open SFT.Computation.HighDimensional SFT.Mathematics.DiscreteObjects
set_option maxRecDepth 1000000
example : (productSupport [],productCardinality []) = ([[]],1) := rfl
example : (productSupport [[]],productCardinality [[]]) = ([],0) := rfl
example : (productSupport [["a"]],productCardinality [["a"]]) = ([["a"]],1) := rfl
example : (productSupport [["a","b"]],productCardinality [["a","b"]]) = ([["a"],["b"]],2) := rfl
example : (productSupport [["b","a"]],productCardinality [["b","a"]]) = ([["b"],["a"]],2) := rfl
example : (productSupport [["a","a"]],productCardinality [["a","a"]]) = ([["a"],["a"]],2) := rfl
example : (productSupport [[],[]],productCardinality [[],[]]) = ([],0) := rfl
example : (productSupport [[],["a"]],productCardinality [[],["a"]]) = ([],0) := rfl
example : (productSupport [[],["a","b"]],productCardinality [[],["a","b"]]) = ([],0) := rfl
example : (productSupport [[],["b","a"]],productCardinality [[],["b","a"]]) = ([],0) := rfl
example : (productSupport [[],["a","a"]],productCardinality [[],["a","a"]]) = ([],0) := rfl
example : (productSupport [["a"],[]],productCardinality [["a"],[]]) = ([],0) := rfl
example : (productSupport [["a"],["a"]],productCardinality [["a"],["a"]]) = ([["a","a"]],1) := rfl
example : (productSupport [["a"],["a","b"]],productCardinality [["a"],["a","b"]]) = ([["a","a"],["a","b"]],2) := rfl
example : (productSupport [["a"],["b","a"]],productCardinality [["a"],["b","a"]]) = ([["a","b"],["a","a"]],2) := rfl
example : (productSupport [["a"],["a","a"]],productCardinality [["a"],["a","a"]]) = ([["a","a"],["a","a"]],2) := rfl
example : (productSupport [["a","b"],[]],productCardinality [["a","b"],[]]) = ([],0) := rfl
example : (productSupport [["a","b"],["a"]],productCardinality [["a","b"],["a"]]) = ([["a","a"],["b","a"]],2) := rfl
example : (productSupport [["a","b"],["a","b"]],productCardinality [["a","b"],["a","b"]]) = ([["a","a"],["a","b"],["b","a"],["b","b"]],4) := rfl
example : (productSupport [["a","b"],["b","a"]],productCardinality [["a","b"],["b","a"]]) = ([["a","b"],["a","a"],["b","b"],["b","a"]],4) := rfl
example : (productSupport [["a","b"],["a","a"]],productCardinality [["a","b"],["a","a"]]) = ([["a","a"],["a","a"],["b","a"],["b","a"]],4) := rfl
example : (productSupport [["b","a"],[]],productCardinality [["b","a"],[]]) = ([],0) := rfl
example : (productSupport [["b","a"],["a"]],productCardinality [["b","a"],["a"]]) = ([["b","a"],["a","a"]],2) := rfl
example : (productSupport [["b","a"],["a","b"]],productCardinality [["b","a"],["a","b"]]) = ([["b","a"],["b","b"],["a","a"],["a","b"]],4) := rfl
example : (productSupport [["b","a"],["b","a"]],productCardinality [["b","a"],["b","a"]]) = ([["b","b"],["b","a"],["a","b"],["a","a"]],4) := rfl
example : (productSupport [["b","a"],["a","a"]],productCardinality [["b","a"],["a","a"]]) = ([["b","a"],["b","a"],["a","a"],["a","a"]],4) := rfl
example : (productSupport [["a","a"],[]],productCardinality [["a","a"],[]]) = ([],0) := rfl
example : (productSupport [["a","a"],["a"]],productCardinality [["a","a"],["a"]]) = ([["a","a"],["a","a"]],2) := rfl
example : (productSupport [["a","a"],["a","b"]],productCardinality [["a","a"],["a","b"]]) = ([["a","a"],["a","b"],["a","a"],["a","b"]],4) := rfl
example : (productSupport [["a","a"],["b","a"]],productCardinality [["a","a"],["b","a"]]) = ([["a","b"],["a","a"],["a","b"],["a","a"]],4) := rfl
example : (productSupport [["a","a"],["a","a"]],productCardinality [["a","a"],["a","a"]]) = ([["a","a"],["a","a"],["a","a"],["a","a"]],4) := rfl
example : (productSupport [[],[],[]],productCardinality [[],[],[]]) = ([],0) := rfl
example : (productSupport [[],[],["a"]],productCardinality [[],[],["a"]]) = ([],0) := rfl
example : (productSupport [[],[],["a","b"]],productCardinality [[],[],["a","b"]]) = ([],0) := rfl
example : (productSupport [[],[],["b","a"]],productCardinality [[],[],["b","a"]]) = ([],0) := rfl
example : (productSupport [[],[],["a","a"]],productCardinality [[],[],["a","a"]]) = ([],0) := rfl
example : (productSupport [[],["a"],[]],productCardinality [[],["a"],[]]) = ([],0) := rfl
example : (productSupport [[],["a"],["a"]],productCardinality [[],["a"],["a"]]) = ([],0) := rfl
example : (productSupport [[],["a"],["a","b"]],productCardinality [[],["a"],["a","b"]]) = ([],0) := rfl
example : (productSupport [[],["a"],["b","a"]],productCardinality [[],["a"],["b","a"]]) = ([],0) := rfl
example : (productSupport [[],["a"],["a","a"]],productCardinality [[],["a"],["a","a"]]) = ([],0) := rfl
example : (productSupport [[],["a","b"],[]],productCardinality [[],["a","b"],[]]) = ([],0) := rfl
example : (productSupport [[],["a","b"],["a"]],productCardinality [[],["a","b"],["a"]]) = ([],0) := rfl
example : (productSupport [[],["a","b"],["a","b"]],productCardinality [[],["a","b"],["a","b"]]) = ([],0) := rfl
example : (productSupport [[],["a","b"],["b","a"]],productCardinality [[],["a","b"],["b","a"]]) = ([],0) := rfl
example : (productSupport [[],["a","b"],["a","a"]],productCardinality [[],["a","b"],["a","a"]]) = ([],0) := rfl
example : (productSupport [[],["b","a"],[]],productCardinality [[],["b","a"],[]]) = ([],0) := rfl
example : (productSupport [[],["b","a"],["a"]],productCardinality [[],["b","a"],["a"]]) = ([],0) := rfl
example : (productSupport [[],["b","a"],["a","b"]],productCardinality [[],["b","a"],["a","b"]]) = ([],0) := rfl
example : (productSupport [[],["b","a"],["b","a"]],productCardinality [[],["b","a"],["b","a"]]) = ([],0) := rfl
example : (productSupport [[],["b","a"],["a","a"]],productCardinality [[],["b","a"],["a","a"]]) = ([],0) := rfl
example : (productSupport [[],["a","a"],[]],productCardinality [[],["a","a"],[]]) = ([],0) := rfl
example : (productSupport [[],["a","a"],["a"]],productCardinality [[],["a","a"],["a"]]) = ([],0) := rfl
example : (productSupport [[],["a","a"],["a","b"]],productCardinality [[],["a","a"],["a","b"]]) = ([],0) := rfl
example : (productSupport [[],["a","a"],["b","a"]],productCardinality [[],["a","a"],["b","a"]]) = ([],0) := rfl
example : (productSupport [[],["a","a"],["a","a"]],productCardinality [[],["a","a"],["a","a"]]) = ([],0) := rfl
example : (productSupport [["a"],[],[]],productCardinality [["a"],[],[]]) = ([],0) := rfl
example : (productSupport [["a"],[],["a"]],productCardinality [["a"],[],["a"]]) = ([],0) := rfl
example : (productSupport [["a"],[],["a","b"]],productCardinality [["a"],[],["a","b"]]) = ([],0) := rfl
example : (productSupport [["a"],[],["b","a"]],productCardinality [["a"],[],["b","a"]]) = ([],0) := rfl
example : (productSupport [["a"],[],["a","a"]],productCardinality [["a"],[],["a","a"]]) = ([],0) := rfl
example : (productSupport [["a"],["a"],[]],productCardinality [["a"],["a"],[]]) = ([],0) := rfl
example : (productSupport [["a"],["a"],["a"]],productCardinality [["a"],["a"],["a"]]) = ([["a","a","a"]],1) := rfl
example : (productSupport [["a"],["a"],["a","b"]],productCardinality [["a"],["a"],["a","b"]]) = ([["a","a","a"],["a","a","b"]],2) := rfl
example : (productSupport [["a"],["a"],["b","a"]],productCardinality [["a"],["a"],["b","a"]]) = ([["a","a","b"],["a","a","a"]],2) := rfl
example : (productSupport [["a"],["a"],["a","a"]],productCardinality [["a"],["a"],["a","a"]]) = ([["a","a","a"],["a","a","a"]],2) := rfl
example : (productSupport [["a"],["a","b"],[]],productCardinality [["a"],["a","b"],[]]) = ([],0) := rfl
example : (productSupport [["a"],["a","b"],["a"]],productCardinality [["a"],["a","b"],["a"]]) = ([["a","a","a"],["a","b","a"]],2) := rfl
example : (productSupport [["a"],["a","b"],["a","b"]],productCardinality [["a"],["a","b"],["a","b"]]) = ([["a","a","a"],["a","a","b"],["a","b","a"],["a","b","b"]],4) := rfl
example : (productSupport [["a"],["a","b"],["b","a"]],productCardinality [["a"],["a","b"],["b","a"]]) = ([["a","a","b"],["a","a","a"],["a","b","b"],["a","b","a"]],4) := rfl
example : (productSupport [["a"],["a","b"],["a","a"]],productCardinality [["a"],["a","b"],["a","a"]]) = ([["a","a","a"],["a","a","a"],["a","b","a"],["a","b","a"]],4) := rfl
example : (productSupport [["a"],["b","a"],[]],productCardinality [["a"],["b","a"],[]]) = ([],0) := rfl
example : (productSupport [["a"],["b","a"],["a"]],productCardinality [["a"],["b","a"],["a"]]) = ([["a","b","a"],["a","a","a"]],2) := rfl
example : (productSupport [["a"],["b","a"],["a","b"]],productCardinality [["a"],["b","a"],["a","b"]]) = ([["a","b","a"],["a","b","b"],["a","a","a"],["a","a","b"]],4) := rfl
example : (productSupport [["a"],["b","a"],["b","a"]],productCardinality [["a"],["b","a"],["b","a"]]) = ([["a","b","b"],["a","b","a"],["a","a","b"],["a","a","a"]],4) := rfl
example : (productSupport [["a"],["b","a"],["a","a"]],productCardinality [["a"],["b","a"],["a","a"]]) = ([["a","b","a"],["a","b","a"],["a","a","a"],["a","a","a"]],4) := rfl
example : (productSupport [["a"],["a","a"],[]],productCardinality [["a"],["a","a"],[]]) = ([],0) := rfl
example : (productSupport [["a"],["a","a"],["a"]],productCardinality [["a"],["a","a"],["a"]]) = ([["a","a","a"],["a","a","a"]],2) := rfl
example : (productSupport [["a"],["a","a"],["a","b"]],productCardinality [["a"],["a","a"],["a","b"]]) = ([["a","a","a"],["a","a","b"],["a","a","a"],["a","a","b"]],4) := rfl
example : (productSupport [["a"],["a","a"],["b","a"]],productCardinality [["a"],["a","a"],["b","a"]]) = ([["a","a","b"],["a","a","a"],["a","a","b"],["a","a","a"]],4) := rfl
example : (productSupport [["a"],["a","a"],["a","a"]],productCardinality [["a"],["a","a"],["a","a"]]) = ([["a","a","a"],["a","a","a"],["a","a","a"],["a","a","a"]],4) := rfl
example : (productSupport [["a","b"],[],[]],productCardinality [["a","b"],[],[]]) = ([],0) := rfl
example : (productSupport [["a","b"],[],["a"]],productCardinality [["a","b"],[],["a"]]) = ([],0) := rfl
example : (productSupport [["a","b"],[],["a","b"]],productCardinality [["a","b"],[],["a","b"]]) = ([],0) := rfl
example : (productSupport [["a","b"],[],["b","a"]],productCardinality [["a","b"],[],["b","a"]]) = ([],0) := rfl
example : (productSupport [["a","b"],[],["a","a"]],productCardinality [["a","b"],[],["a","a"]]) = ([],0) := rfl
example : (productSupport [["a","b"],["a"],[]],productCardinality [["a","b"],["a"],[]]) = ([],0) := rfl
example : (productSupport [["a","b"],["a"],["a"]],productCardinality [["a","b"],["a"],["a"]]) = ([["a","a","a"],["b","a","a"]],2) := rfl
example : (productSupport [["a","b"],["a"],["a","b"]],productCardinality [["a","b"],["a"],["a","b"]]) = ([["a","a","a"],["a","a","b"],["b","a","a"],["b","a","b"]],4) := rfl
example : (productSupport [["a","b"],["a"],["b","a"]],productCardinality [["a","b"],["a"],["b","a"]]) = ([["a","a","b"],["a","a","a"],["b","a","b"],["b","a","a"]],4) := rfl
example : (productSupport [["a","b"],["a"],["a","a"]],productCardinality [["a","b"],["a"],["a","a"]]) = ([["a","a","a"],["a","a","a"],["b","a","a"],["b","a","a"]],4) := rfl
example : (productSupport [["a","b"],["a","b"],[]],productCardinality [["a","b"],["a","b"],[]]) = ([],0) := rfl
example : (productSupport [["a","b"],["a","b"],["a"]],productCardinality [["a","b"],["a","b"],["a"]]) = ([["a","a","a"],["a","b","a"],["b","a","a"],["b","b","a"]],4) := rfl
example : (productSupport [["a","b"],["a","b"],["a","b"]],productCardinality [["a","b"],["a","b"],["a","b"]]) = ([["a","a","a"],["a","a","b"],["a","b","a"],["a","b","b"],["b","a","a"],["b","a","b"],["b","b","a"],["b","b","b"]],8) := rfl
example : (productSupport [["a","b"],["a","b"],["b","a"]],productCardinality [["a","b"],["a","b"],["b","a"]]) = ([["a","a","b"],["a","a","a"],["a","b","b"],["a","b","a"],["b","a","b"],["b","a","a"],["b","b","b"],["b","b","a"]],8) := rfl
example : (productSupport [["a","b"],["a","b"],["a","a"]],productCardinality [["a","b"],["a","b"],["a","a"]]) = ([["a","a","a"],["a","a","a"],["a","b","a"],["a","b","a"],["b","a","a"],["b","a","a"],["b","b","a"],["b","b","a"]],8) := rfl
example : (productSupport [["a","b"],["b","a"],[]],productCardinality [["a","b"],["b","a"],[]]) = ([],0) := rfl
example : (productSupport [["a","b"],["b","a"],["a"]],productCardinality [["a","b"],["b","a"],["a"]]) = ([["a","b","a"],["a","a","a"],["b","b","a"],["b","a","a"]],4) := rfl
example : (productSupport [["a","b"],["b","a"],["a","b"]],productCardinality [["a","b"],["b","a"],["a","b"]]) = ([["a","b","a"],["a","b","b"],["a","a","a"],["a","a","b"],["b","b","a"],["b","b","b"],["b","a","a"],["b","a","b"]],8) := rfl
example : (productSupport [["a","b"],["b","a"],["b","a"]],productCardinality [["a","b"],["b","a"],["b","a"]]) = ([["a","b","b"],["a","b","a"],["a","a","b"],["a","a","a"],["b","b","b"],["b","b","a"],["b","a","b"],["b","a","a"]],8) := rfl
example : (productSupport [["a","b"],["b","a"],["a","a"]],productCardinality [["a","b"],["b","a"],["a","a"]]) = ([["a","b","a"],["a","b","a"],["a","a","a"],["a","a","a"],["b","b","a"],["b","b","a"],["b","a","a"],["b","a","a"]],8) := rfl
example : (productSupport [["a","b"],["a","a"],[]],productCardinality [["a","b"],["a","a"],[]]) = ([],0) := rfl
example : (productSupport [["a","b"],["a","a"],["a"]],productCardinality [["a","b"],["a","a"],["a"]]) = ([["a","a","a"],["a","a","a"],["b","a","a"],["b","a","a"]],4) := rfl
example : (productSupport [["a","b"],["a","a"],["a","b"]],productCardinality [["a","b"],["a","a"],["a","b"]]) = ([["a","a","a"],["a","a","b"],["a","a","a"],["a","a","b"],["b","a","a"],["b","a","b"],["b","a","a"],["b","a","b"]],8) := rfl
example : (productSupport [["a","b"],["a","a"],["b","a"]],productCardinality [["a","b"],["a","a"],["b","a"]]) = ([["a","a","b"],["a","a","a"],["a","a","b"],["a","a","a"],["b","a","b"],["b","a","a"],["b","a","b"],["b","a","a"]],8) := rfl
example : (productSupport [["a","b"],["a","a"],["a","a"]],productCardinality [["a","b"],["a","a"],["a","a"]]) = ([["a","a","a"],["a","a","a"],["a","a","a"],["a","a","a"],["b","a","a"],["b","a","a"],["b","a","a"],["b","a","a"]],8) := rfl
example : (productSupport [["b","a"],[],[]],productCardinality [["b","a"],[],[]]) = ([],0) := rfl
example : (productSupport [["b","a"],[],["a"]],productCardinality [["b","a"],[],["a"]]) = ([],0) := rfl
example : (productSupport [["b","a"],[],["a","b"]],productCardinality [["b","a"],[],["a","b"]]) = ([],0) := rfl
example : (productSupport [["b","a"],[],["b","a"]],productCardinality [["b","a"],[],["b","a"]]) = ([],0) := rfl
example : (productSupport [["b","a"],[],["a","a"]],productCardinality [["b","a"],[],["a","a"]]) = ([],0) := rfl
example : (productSupport [["b","a"],["a"],[]],productCardinality [["b","a"],["a"],[]]) = ([],0) := rfl
example : (productSupport [["b","a"],["a"],["a"]],productCardinality [["b","a"],["a"],["a"]]) = ([["b","a","a"],["a","a","a"]],2) := rfl
example : (productSupport [["b","a"],["a"],["a","b"]],productCardinality [["b","a"],["a"],["a","b"]]) = ([["b","a","a"],["b","a","b"],["a","a","a"],["a","a","b"]],4) := rfl
example : (productSupport [["b","a"],["a"],["b","a"]],productCardinality [["b","a"],["a"],["b","a"]]) = ([["b","a","b"],["b","a","a"],["a","a","b"],["a","a","a"]],4) := rfl
example : (productSupport [["b","a"],["a"],["a","a"]],productCardinality [["b","a"],["a"],["a","a"]]) = ([["b","a","a"],["b","a","a"],["a","a","a"],["a","a","a"]],4) := rfl
example : (productSupport [["b","a"],["a","b"],[]],productCardinality [["b","a"],["a","b"],[]]) = ([],0) := rfl
example : (productSupport [["b","a"],["a","b"],["a"]],productCardinality [["b","a"],["a","b"],["a"]]) = ([["b","a","a"],["b","b","a"],["a","a","a"],["a","b","a"]],4) := rfl
example : (productSupport [["b","a"],["a","b"],["a","b"]],productCardinality [["b","a"],["a","b"],["a","b"]]) = ([["b","a","a"],["b","a","b"],["b","b","a"],["b","b","b"],["a","a","a"],["a","a","b"],["a","b","a"],["a","b","b"]],8) := rfl
example : (productSupport [["b","a"],["a","b"],["b","a"]],productCardinality [["b","a"],["a","b"],["b","a"]]) = ([["b","a","b"],["b","a","a"],["b","b","b"],["b","b","a"],["a","a","b"],["a","a","a"],["a","b","b"],["a","b","a"]],8) := rfl
example : (productSupport [["b","a"],["a","b"],["a","a"]],productCardinality [["b","a"],["a","b"],["a","a"]]) = ([["b","a","a"],["b","a","a"],["b","b","a"],["b","b","a"],["a","a","a"],["a","a","a"],["a","b","a"],["a","b","a"]],8) := rfl
example : (productSupport [["b","a"],["b","a"],[]],productCardinality [["b","a"],["b","a"],[]]) = ([],0) := rfl
example : (productSupport [["b","a"],["b","a"],["a"]],productCardinality [["b","a"],["b","a"],["a"]]) = ([["b","b","a"],["b","a","a"],["a","b","a"],["a","a","a"]],4) := rfl
example : (productSupport [["b","a"],["b","a"],["a","b"]],productCardinality [["b","a"],["b","a"],["a","b"]]) = ([["b","b","a"],["b","b","b"],["b","a","a"],["b","a","b"],["a","b","a"],["a","b","b"],["a","a","a"],["a","a","b"]],8) := rfl
example : (productSupport [["b","a"],["b","a"],["b","a"]],productCardinality [["b","a"],["b","a"],["b","a"]]) = ([["b","b","b"],["b","b","a"],["b","a","b"],["b","a","a"],["a","b","b"],["a","b","a"],["a","a","b"],["a","a","a"]],8) := rfl
example : (productSupport [["b","a"],["b","a"],["a","a"]],productCardinality [["b","a"],["b","a"],["a","a"]]) = ([["b","b","a"],["b","b","a"],["b","a","a"],["b","a","a"],["a","b","a"],["a","b","a"],["a","a","a"],["a","a","a"]],8) := rfl
example : (productSupport [["b","a"],["a","a"],[]],productCardinality [["b","a"],["a","a"],[]]) = ([],0) := rfl
example : (productSupport [["b","a"],["a","a"],["a"]],productCardinality [["b","a"],["a","a"],["a"]]) = ([["b","a","a"],["b","a","a"],["a","a","a"],["a","a","a"]],4) := rfl
example : (productSupport [["b","a"],["a","a"],["a","b"]],productCardinality [["b","a"],["a","a"],["a","b"]]) = ([["b","a","a"],["b","a","b"],["b","a","a"],["b","a","b"],["a","a","a"],["a","a","b"],["a","a","a"],["a","a","b"]],8) := rfl
example : (productSupport [["b","a"],["a","a"],["b","a"]],productCardinality [["b","a"],["a","a"],["b","a"]]) = ([["b","a","b"],["b","a","a"],["b","a","b"],["b","a","a"],["a","a","b"],["a","a","a"],["a","a","b"],["a","a","a"]],8) := rfl
example : (productSupport [["b","a"],["a","a"],["a","a"]],productCardinality [["b","a"],["a","a"],["a","a"]]) = ([["b","a","a"],["b","a","a"],["b","a","a"],["b","a","a"],["a","a","a"],["a","a","a"],["a","a","a"],["a","a","a"]],8) := rfl
example : (productSupport [["a","a"],[],[]],productCardinality [["a","a"],[],[]]) = ([],0) := rfl
example : (productSupport [["a","a"],[],["a"]],productCardinality [["a","a"],[],["a"]]) = ([],0) := rfl
example : (productSupport [["a","a"],[],["a","b"]],productCardinality [["a","a"],[],["a","b"]]) = ([],0) := rfl
example : (productSupport [["a","a"],[],["b","a"]],productCardinality [["a","a"],[],["b","a"]]) = ([],0) := rfl
example : (productSupport [["a","a"],[],["a","a"]],productCardinality [["a","a"],[],["a","a"]]) = ([],0) := rfl
example : (productSupport [["a","a"],["a"],[]],productCardinality [["a","a"],["a"],[]]) = ([],0) := rfl
example : (productSupport [["a","a"],["a"],["a"]],productCardinality [["a","a"],["a"],["a"]]) = ([["a","a","a"],["a","a","a"]],2) := rfl
example : (productSupport [["a","a"],["a"],["a","b"]],productCardinality [["a","a"],["a"],["a","b"]]) = ([["a","a","a"],["a","a","b"],["a","a","a"],["a","a","b"]],4) := rfl
example : (productSupport [["a","a"],["a"],["b","a"]],productCardinality [["a","a"],["a"],["b","a"]]) = ([["a","a","b"],["a","a","a"],["a","a","b"],["a","a","a"]],4) := rfl
example : (productSupport [["a","a"],["a"],["a","a"]],productCardinality [["a","a"],["a"],["a","a"]]) = ([["a","a","a"],["a","a","a"],["a","a","a"],["a","a","a"]],4) := rfl
example : (productSupport [["a","a"],["a","b"],[]],productCardinality [["a","a"],["a","b"],[]]) = ([],0) := rfl
example : (productSupport [["a","a"],["a","b"],["a"]],productCardinality [["a","a"],["a","b"],["a"]]) = ([["a","a","a"],["a","b","a"],["a","a","a"],["a","b","a"]],4) := rfl
example : (productSupport [["a","a"],["a","b"],["a","b"]],productCardinality [["a","a"],["a","b"],["a","b"]]) = ([["a","a","a"],["a","a","b"],["a","b","a"],["a","b","b"],["a","a","a"],["a","a","b"],["a","b","a"],["a","b","b"]],8) := rfl
example : (productSupport [["a","a"],["a","b"],["b","a"]],productCardinality [["a","a"],["a","b"],["b","a"]]) = ([["a","a","b"],["a","a","a"],["a","b","b"],["a","b","a"],["a","a","b"],["a","a","a"],["a","b","b"],["a","b","a"]],8) := rfl
example : (productSupport [["a","a"],["a","b"],["a","a"]],productCardinality [["a","a"],["a","b"],["a","a"]]) = ([["a","a","a"],["a","a","a"],["a","b","a"],["a","b","a"],["a","a","a"],["a","a","a"],["a","b","a"],["a","b","a"]],8) := rfl
example : (productSupport [["a","a"],["b","a"],[]],productCardinality [["a","a"],["b","a"],[]]) = ([],0) := rfl
example : (productSupport [["a","a"],["b","a"],["a"]],productCardinality [["a","a"],["b","a"],["a"]]) = ([["a","b","a"],["a","a","a"],["a","b","a"],["a","a","a"]],4) := rfl
example : (productSupport [["a","a"],["b","a"],["a","b"]],productCardinality [["a","a"],["b","a"],["a","b"]]) = ([["a","b","a"],["a","b","b"],["a","a","a"],["a","a","b"],["a","b","a"],["a","b","b"],["a","a","a"],["a","a","b"]],8) := rfl
example : (productSupport [["a","a"],["b","a"],["b","a"]],productCardinality [["a","a"],["b","a"],["b","a"]]) = ([["a","b","b"],["a","b","a"],["a","a","b"],["a","a","a"],["a","b","b"],["a","b","a"],["a","a","b"],["a","a","a"]],8) := rfl
example : (productSupport [["a","a"],["b","a"],["a","a"]],productCardinality [["a","a"],["b","a"],["a","a"]]) = ([["a","b","a"],["a","b","a"],["a","a","a"],["a","a","a"],["a","b","a"],["a","b","a"],["a","a","a"],["a","a","a"]],8) := rfl
example : (productSupport [["a","a"],["a","a"],[]],productCardinality [["a","a"],["a","a"],[]]) = ([],0) := rfl
example : (productSupport [["a","a"],["a","a"],["a"]],productCardinality [["a","a"],["a","a"],["a"]]) = ([["a","a","a"],["a","a","a"],["a","a","a"],["a","a","a"]],4) := rfl
example : (productSupport [["a","a"],["a","a"],["a","b"]],productCardinality [["a","a"],["a","a"],["a","b"]]) = ([["a","a","a"],["a","a","b"],["a","a","a"],["a","a","b"],["a","a","a"],["a","a","b"],["a","a","a"],["a","a","b"]],8) := rfl
example : (productSupport [["a","a"],["a","a"],["b","a"]],productCardinality [["a","a"],["a","a"],["b","a"]]) = ([["a","a","b"],["a","a","a"],["a","a","b"],["a","a","a"],["a","a","b"],["a","a","a"],["a","a","b"],["a","a","a"]],8) := rfl
example : (productSupport [["a","a"],["a","a"],["a","a"]],productCardinality [["a","a"],["a","a"],["a","a"]]) = ([["a","a","a"],["a","a","a"],["a","a","a"],["a","a","a"],["a","a","a"],["a","a","a"],["a","a","a"],["a","a","a"]],8) := rfl
def model : Model := ⟨[["a","b"]],by intro axis member; cases member with | head => exact ⟨rfl,rfl⟩ | tail _ h => cases h⟩
example : sparseRelation model [] = .ok [] := rfl
example : run model [] ["a"] [] = some ["a"] := rfl
example : run model [] ["a"] [(["a"],["a"])] = none := rfl
example : run model [] ["a"] [(["a"],["b"])] = none := rfl
example : run model [] ["a"] [(["b"],["a"])] = none := rfl
example : run model [] ["a"] [(["b"],["b"])] = none := rfl
example : run model [] ["a"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [] ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [] ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [] ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [] ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [] ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [] ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [] ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [] ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [] ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [] ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [] ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [] ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [] ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [] ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [] ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [] ["b"] [] = some ["b"] := rfl
example : run model [] ["b"] [(["a"],["a"])] = none := rfl
example : run model [] ["b"] [(["a"],["b"])] = none := rfl
example : run model [] ["b"] [(["b"],["a"])] = none := rfl
example : run model [] ["b"] [(["b"],["b"])] = none := rfl
example : run model [] ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [] ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [] ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [] ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [] ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [] ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [] ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [] ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [] ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [] ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [] ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [] ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [] ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [] ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [] ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [] ["b"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [] ["outside"] [] = none := rfl
example : run model [] ["outside"] [(["a"],["a"])] = none := rfl
example : run model [] ["outside"] [(["a"],["b"])] = none := rfl
example : run model [] ["outside"] [(["b"],["a"])] = none := rfl
example : run model [] ["outside"] [(["b"],["b"])] = none := rfl
example : run model [] ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [] ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [] ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [] ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [] ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [] ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [] ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [] ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [] ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [] ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [] ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [] ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [] ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [] ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [] ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [] ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : sparseRelation model [(["a"],["a"])] = .ok [(["a"],["a"])] := rfl
example : run model [(["a"],["a"])] ["a"] [] = some ["a"] := rfl
example : run model [(["a"],["a"])] ["a"] [(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"])] ["a"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["a"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["a"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["a"] [(["a"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"])] ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [] = some ["b"] := rfl
example : run model [(["a"],["a"])] ["b"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["b"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"])] ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : sparseRelation model [(["a"],["b"])] = .ok [(["a"],["b"])] := rfl
example : run model [(["a"],["b"])] ["a"] [] = some ["a"] := rfl
example : run model [(["a"],["b"])] ["a"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["a"] [(["a"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["b"])] ["a"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["a"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["a"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [] = some ["b"] := rfl
example : run model [(["a"],["b"])] ["b"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["b"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : sparseRelation model [(["a"],["a"]),(["a"],["b"])] = .ok [(["a"],["a"]),(["a"],["b"])] := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["a"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["a"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["a"],["a"]),(["a"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["b"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : sparseRelation model [(["b"],["a"])] = .ok [(["b"],["a"])] := rfl
example : run model [(["b"],["a"])] ["a"] [] = some ["a"] := rfl
example : run model [(["b"],["a"])] ["a"] [(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [] = some ["b"] := rfl
example : run model [(["b"],["a"])] ["b"] [(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [(["b"],["a"])] = some ["a"] := rfl
example : run model [(["b"],["a"])] ["b"] [(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["b"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"])] ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : sparseRelation model [(["a"],["a"]),(["b"],["a"])] = .ok [(["a"],["a"]),(["b"],["a"])] := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["a"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["b"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["b"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["b"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"])] ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : sparseRelation model [(["a"],["b"]),(["b"],["a"])] = .ok [(["a"],["b"]),(["b"],["a"])] := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [] = some ["a"] := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["b"]),(["b"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [] = some ["b"] := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["a"]),(["a"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : sparseRelation model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] = .ok [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["a"]),(["a"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["b"]),(["b"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["a"]),(["a"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["b"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : sparseRelation model [(["b"],["b"])] = .ok [(["b"],["b"])] := rfl
example : run model [(["b"],["b"])] ["a"] [] = some ["a"] := rfl
example : run model [(["b"],["b"])] ["a"] [(["a"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["a"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["b"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["b"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [] = some ["b"] := rfl
example : run model [(["b"],["b"])] ["b"] [(["a"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [(["a"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [(["b"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [(["b"],["b"])] = some ["b"] := rfl
example : run model [(["b"],["b"])] ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["b"] [(["b"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : run model [(["b"],["b"])] ["outside"] [] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["a"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["a"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["b"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["b"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : sparseRelation model [(["a"],["a"]),(["b"],["b"])] = .ok [(["a"],["a"]),(["b"],["b"])] := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : sparseRelation model [(["a"],["b"]),(["b"],["b"])] = .ok [(["a"],["b"]),(["b"],["b"])] := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [] = some ["a"] := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [] = some ["b"] := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : sparseRelation model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] = .ok [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["a"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : sparseRelation model [(["b"],["a"]),(["b"],["b"])] = .ok [(["b"],["a"]),(["b"],["b"])] := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [] = some ["a"] := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [] = some ["b"] := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"])] = some ["a"] := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"])] = some ["b"] := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["b"],["a"])] = some ["a"] := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : sparseRelation model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] = .ok [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["b"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : sparseRelation model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = .ok [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [] = some ["a"] := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["b"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [] = some ["b"] := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["a"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["b"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : sparseRelation model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = .ok [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["a"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["b"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["a"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["a"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["b"],["a"])] = some ["a"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["b"] [(["b"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : run model [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : sparseRelation model [(["a"],["outside"])] = .error "ValueError: a relation is a held selection of the complete pair-cell support" := rfl
example : sparseRelation model [(["outside"],["a"])] = .error "ValueError: a relation is a held selection of the complete pair-cell support" := rfl
example : sparseRelation model [(["a"],["b"]),(["a"],["b"])] = .error "ValueError: a relation is a held selection of the complete pair-cell support" := rfl
example : project [] [] = some [] := rfl
example : project [0] [] = none := rfl
example : project [1] [] = none := rfl
example : project [2] [] = none := rfl
example : project [0,0] [] = none := rfl
example : project [0,1] [] = none := rfl
example : project [0,2] [] = none := rfl
example : project [1,0] [] = none := rfl
example : project [1,1] [] = none := rfl
example : project [1,2] [] = none := rfl
example : project [2,0] [] = none := rfl
example : project [2,1] [] = none := rfl
example : project [2,2] [] = none := rfl
example : project [] ["a"] = some [] := rfl
example : project [0] ["a"] = some ["a"] := rfl
example : project [1] ["a"] = none := rfl
example : project [2] ["a"] = none := rfl
example : project [0,0] ["a"] = some ["a","a"] := rfl
example : project [0,1] ["a"] = none := rfl
example : project [0,2] ["a"] = none := rfl
example : project [1,0] ["a"] = none := rfl
example : project [1,1] ["a"] = none := rfl
example : project [1,2] ["a"] = none := rfl
example : project [2,0] ["a"] = none := rfl
example : project [2,1] ["a"] = none := rfl
example : project [2,2] ["a"] = none := rfl
example : project [] ["a","b"] = some [] := rfl
example : project [0] ["a","b"] = some ["a"] := rfl
example : project [1] ["a","b"] = some ["b"] := rfl
example : project [2] ["a","b"] = none := rfl
example : project [0,0] ["a","b"] = some ["a","a"] := rfl
example : project [0,1] ["a","b"] = some ["a","b"] := rfl
example : project [0,2] ["a","b"] = none := rfl
example : project [1,0] ["a","b"] = some ["b","a"] := rfl
example : project [1,1] ["a","b"] = some ["b","b"] := rfl
example : project [1,2] ["a","b"] = none := rfl
example : project [2,0] ["a","b"] = none := rfl
example : project [2,1] ["a","b"] = none := rfl
example : project [2,2] ["a","b"] = none := rfl
example : project [] ["a","a"] = some [] := rfl
example : project [0] ["a","a"] = some ["a"] := rfl
example : project [1] ["a","a"] = some ["a"] := rfl
example : project [2] ["a","a"] = none := rfl
example : project [0,0] ["a","a"] = some ["a","a"] := rfl
example : project [0,1] ["a","a"] = some ["a","a"] := rfl
example : project [0,2] ["a","a"] = none := rfl
example : project [1,0] ["a","a"] = some ["a","a"] := rfl
example : project [1,1] ["a","a"] = some ["a","a"] := rfl
example : project [1,2] ["a","a"] = none := rfl
example : project [2,0] ["a","a"] = none := rfl
example : project [2,1] ["a","a"] = none := rfl
example : project [2,2] ["a","a"] = none := rfl
example : factorRows [] = [([],[])] := rfl
example : factorRows [[]] = [] := rfl
example : factorRows [[("a","a")]] = [(["a"],["a"])] := rfl
example : factorRows [[("a","b"),("b","a")]] = [(["a"],["b"]),(["b"],["a"])] := rfl
example : factorRows [[("a","a"),("a","a")]] = [(["a"],["a"]),(["a"],["a"])] := rfl
example : factorRows [[],[]] = [] := rfl
example : factorRows [[],[("a","a")]] = [] := rfl
example : factorRows [[],[("a","b"),("b","a")]] = [] := rfl
example : factorRows [[],[("a","a"),("a","a")]] = [] := rfl
example : factorRows [[("a","a")],[]] = [] := rfl
example : factorRows [[("a","a")],[("a","a")]] = [(["a","a"],["a","a"])] := rfl
example : factorRows [[("a","a")],[("a","b"),("b","a")]] = [(["a","a"],["a","b"]),(["a","b"],["a","a"])] := rfl
example : factorRows [[("a","a")],[("a","a"),("a","a")]] = [(["a","a"],["a","a"]),(["a","a"],["a","a"])] := rfl
example : factorRows [[("a","b"),("b","a")],[]] = [] := rfl
example : factorRows [[("a","b"),("b","a")],[("a","a")]] = [(["a","a"],["b","a"]),(["b","a"],["a","a"])] := rfl
example : factorRows [[("a","b"),("b","a")],[("a","b"),("b","a")]] = [(["a","a"],["b","b"]),(["a","b"],["b","a"]),(["b","a"],["a","b"]),(["b","b"],["a","a"])] := rfl
example : factorRows [[("a","b"),("b","a")],[("a","a"),("a","a")]] = [(["a","a"],["b","a"]),(["a","a"],["b","a"]),(["b","a"],["a","a"]),(["b","a"],["a","a"])] := rfl
example : factorRows [[("a","a"),("a","a")],[]] = [] := rfl
example : factorRows [[("a","a"),("a","a")],[("a","a")]] = [(["a","a"],["a","a"]),(["a","a"],["a","a"])] := rfl
example : factorRows [[("a","a"),("a","a")],[("a","b"),("b","a")]] = [(["a","a"],["a","b"]),(["a","b"],["a","a"]),(["a","a"],["a","b"]),(["a","b"],["a","a"])] := rfl
example : factorRows [[("a","a"),("a","a")],[("a","a"),("a","a")]] = [(["a","a"],["a","a"]),(["a","a"],["a","a"]),(["a","a"],["a","a"]),(["a","a"],["a","a"])] := rfl
example : factorRows [[],[],[]] = [] := rfl
example : factorRows [[],[],[("a","a")]] = [] := rfl
example : factorRows [[],[],[("a","b"),("b","a")]] = [] := rfl
example : factorRows [[],[],[("a","a"),("a","a")]] = [] := rfl
example : factorRows [[],[("a","a")],[]] = [] := rfl
example : factorRows [[],[("a","a")],[("a","a")]] = [] := rfl
example : factorRows [[],[("a","a")],[("a","b"),("b","a")]] = [] := rfl
example : factorRows [[],[("a","a")],[("a","a"),("a","a")]] = [] := rfl
example : factorRows [[],[("a","b"),("b","a")],[]] = [] := rfl
example : factorRows [[],[("a","b"),("b","a")],[("a","a")]] = [] := rfl
example : factorRows [[],[("a","b"),("b","a")],[("a","b"),("b","a")]] = [] := rfl
example : factorRows [[],[("a","b"),("b","a")],[("a","a"),("a","a")]] = [] := rfl
example : factorRows [[],[("a","a"),("a","a")],[]] = [] := rfl
example : factorRows [[],[("a","a"),("a","a")],[("a","a")]] = [] := rfl
example : factorRows [[],[("a","a"),("a","a")],[("a","b"),("b","a")]] = [] := rfl
example : factorRows [[],[("a","a"),("a","a")],[("a","a"),("a","a")]] = [] := rfl
example : factorRows [[("a","a")],[],[]] = [] := rfl
example : factorRows [[("a","a")],[],[("a","a")]] = [] := rfl
example : factorRows [[("a","a")],[],[("a","b"),("b","a")]] = [] := rfl
example : factorRows [[("a","a")],[],[("a","a"),("a","a")]] = [] := rfl
example : factorRows [[("a","a")],[("a","a")],[]] = [] := rfl
example : factorRows [[("a","a")],[("a","a")],[("a","a")]] = [(["a","a","a"],["a","a","a"])] := rfl
example : factorRows [[("a","a")],[("a","a")],[("a","b"),("b","a")]] = [(["a","a","a"],["a","a","b"]),(["a","a","b"],["a","a","a"])] := rfl
example : factorRows [[("a","a")],[("a","a")],[("a","a"),("a","a")]] = [(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"])] := rfl
example : factorRows [[("a","a")],[("a","b"),("b","a")],[]] = [] := rfl
example : factorRows [[("a","a")],[("a","b"),("b","a")],[("a","a")]] = [(["a","a","a"],["a","b","a"]),(["a","b","a"],["a","a","a"])] := rfl
example : factorRows [[("a","a")],[("a","b"),("b","a")],[("a","b"),("b","a")]] = [(["a","a","a"],["a","b","b"]),(["a","a","b"],["a","b","a"]),(["a","b","a"],["a","a","b"]),(["a","b","b"],["a","a","a"])] := rfl
example : factorRows [[("a","a")],[("a","b"),("b","a")],[("a","a"),("a","a")]] = [(["a","a","a"],["a","b","a"]),(["a","a","a"],["a","b","a"]),(["a","b","a"],["a","a","a"]),(["a","b","a"],["a","a","a"])] := rfl
example : factorRows [[("a","a")],[("a","a"),("a","a")],[]] = [] := rfl
example : factorRows [[("a","a")],[("a","a"),("a","a")],[("a","a")]] = [(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"])] := rfl
example : factorRows [[("a","a")],[("a","a"),("a","a")],[("a","b"),("b","a")]] = [(["a","a","a"],["a","a","b"]),(["a","a","b"],["a","a","a"]),(["a","a","a"],["a","a","b"]),(["a","a","b"],["a","a","a"])] := rfl
example : factorRows [[("a","a")],[("a","a"),("a","a")],[("a","a"),("a","a")]] = [(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"])] := rfl
example : factorRows [[("a","b"),("b","a")],[],[]] = [] := rfl
example : factorRows [[("a","b"),("b","a")],[],[("a","a")]] = [] := rfl
example : factorRows [[("a","b"),("b","a")],[],[("a","b"),("b","a")]] = [] := rfl
example : factorRows [[("a","b"),("b","a")],[],[("a","a"),("a","a")]] = [] := rfl
example : factorRows [[("a","b"),("b","a")],[("a","a")],[]] = [] := rfl
example : factorRows [[("a","b"),("b","a")],[("a","a")],[("a","a")]] = [(["a","a","a"],["b","a","a"]),(["b","a","a"],["a","a","a"])] := rfl
example : factorRows [[("a","b"),("b","a")],[("a","a")],[("a","b"),("b","a")]] = [(["a","a","a"],["b","a","b"]),(["a","a","b"],["b","a","a"]),(["b","a","a"],["a","a","b"]),(["b","a","b"],["a","a","a"])] := rfl
example : factorRows [[("a","b"),("b","a")],[("a","a")],[("a","a"),("a","a")]] = [(["a","a","a"],["b","a","a"]),(["a","a","a"],["b","a","a"]),(["b","a","a"],["a","a","a"]),(["b","a","a"],["a","a","a"])] := rfl
example : factorRows [[("a","b"),("b","a")],[("a","b"),("b","a")],[]] = [] := rfl
example : factorRows [[("a","b"),("b","a")],[("a","b"),("b","a")],[("a","a")]] = [(["a","a","a"],["b","b","a"]),(["a","b","a"],["b","a","a"]),(["b","a","a"],["a","b","a"]),(["b","b","a"],["a","a","a"])] := rfl
example : factorRows [[("a","b"),("b","a")],[("a","b"),("b","a")],[("a","b"),("b","a")]] = [(["a","a","a"],["b","b","b"]),(["a","a","b"],["b","b","a"]),(["a","b","a"],["b","a","b"]),(["a","b","b"],["b","a","a"]),(["b","a","a"],["a","b","b"]),(["b","a","b"],["a","b","a"]),(["b","b","a"],["a","a","b"]),(["b","b","b"],["a","a","a"])] := rfl
example : factorRows [[("a","b"),("b","a")],[("a","b"),("b","a")],[("a","a"),("a","a")]] = [(["a","a","a"],["b","b","a"]),(["a","a","a"],["b","b","a"]),(["a","b","a"],["b","a","a"]),(["a","b","a"],["b","a","a"]),(["b","a","a"],["a","b","a"]),(["b","a","a"],["a","b","a"]),(["b","b","a"],["a","a","a"]),(["b","b","a"],["a","a","a"])] := rfl
example : factorRows [[("a","b"),("b","a")],[("a","a"),("a","a")],[]] = [] := rfl
example : factorRows [[("a","b"),("b","a")],[("a","a"),("a","a")],[("a","a")]] = [(["a","a","a"],["b","a","a"]),(["a","a","a"],["b","a","a"]),(["b","a","a"],["a","a","a"]),(["b","a","a"],["a","a","a"])] := rfl
example : factorRows [[("a","b"),("b","a")],[("a","a"),("a","a")],[("a","b"),("b","a")]] = [(["a","a","a"],["b","a","b"]),(["a","a","b"],["b","a","a"]),(["a","a","a"],["b","a","b"]),(["a","a","b"],["b","a","a"]),(["b","a","a"],["a","a","b"]),(["b","a","b"],["a","a","a"]),(["b","a","a"],["a","a","b"]),(["b","a","b"],["a","a","a"])] := rfl
example : factorRows [[("a","b"),("b","a")],[("a","a"),("a","a")],[("a","a"),("a","a")]] = [(["a","a","a"],["b","a","a"]),(["a","a","a"],["b","a","a"]),(["a","a","a"],["b","a","a"]),(["a","a","a"],["b","a","a"]),(["b","a","a"],["a","a","a"]),(["b","a","a"],["a","a","a"]),(["b","a","a"],["a","a","a"]),(["b","a","a"],["a","a","a"])] := rfl
example : factorRows [[("a","a"),("a","a")],[],[]] = [] := rfl
example : factorRows [[("a","a"),("a","a")],[],[("a","a")]] = [] := rfl
example : factorRows [[("a","a"),("a","a")],[],[("a","b"),("b","a")]] = [] := rfl
example : factorRows [[("a","a"),("a","a")],[],[("a","a"),("a","a")]] = [] := rfl
example : factorRows [[("a","a"),("a","a")],[("a","a")],[]] = [] := rfl
example : factorRows [[("a","a"),("a","a")],[("a","a")],[("a","a")]] = [(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"])] := rfl
example : factorRows [[("a","a"),("a","a")],[("a","a")],[("a","b"),("b","a")]] = [(["a","a","a"],["a","a","b"]),(["a","a","b"],["a","a","a"]),(["a","a","a"],["a","a","b"]),(["a","a","b"],["a","a","a"])] := rfl
example : factorRows [[("a","a"),("a","a")],[("a","a")],[("a","a"),("a","a")]] = [(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"])] := rfl
example : factorRows [[("a","a"),("a","a")],[("a","b"),("b","a")],[]] = [] := rfl
example : factorRows [[("a","a"),("a","a")],[("a","b"),("b","a")],[("a","a")]] = [(["a","a","a"],["a","b","a"]),(["a","b","a"],["a","a","a"]),(["a","a","a"],["a","b","a"]),(["a","b","a"],["a","a","a"])] := rfl
example : factorRows [[("a","a"),("a","a")],[("a","b"),("b","a")],[("a","b"),("b","a")]] = [(["a","a","a"],["a","b","b"]),(["a","a","b"],["a","b","a"]),(["a","b","a"],["a","a","b"]),(["a","b","b"],["a","a","a"]),(["a","a","a"],["a","b","b"]),(["a","a","b"],["a","b","a"]),(["a","b","a"],["a","a","b"]),(["a","b","b"],["a","a","a"])] := rfl
example : factorRows [[("a","a"),("a","a")],[("a","b"),("b","a")],[("a","a"),("a","a")]] = [(["a","a","a"],["a","b","a"]),(["a","a","a"],["a","b","a"]),(["a","b","a"],["a","a","a"]),(["a","b","a"],["a","a","a"]),(["a","a","a"],["a","b","a"]),(["a","a","a"],["a","b","a"]),(["a","b","a"],["a","a","a"]),(["a","b","a"],["a","a","a"])] := rfl
example : factorRows [[("a","a"),("a","a")],[("a","a"),("a","a")],[]] = [] := rfl
example : factorRows [[("a","a"),("a","a")],[("a","a"),("a","a")],[("a","a")]] = [(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"])] := rfl
example : factorRows [[("a","a"),("a","a")],[("a","a"),("a","a")],[("a","b"),("b","a")]] = [(["a","a","a"],["a","a","b"]),(["a","a","b"],["a","a","a"]),(["a","a","a"],["a","a","b"]),(["a","a","b"],["a","a","a"]),(["a","a","a"],["a","a","b"]),(["a","a","b"],["a","a","a"]),(["a","a","a"],["a","a","b"]),(["a","a","b"],["a","a","a"])] := rfl
example : factorRows [[("a","a"),("a","a")],[("a","a"),("a","a")],[("a","a"),("a","a")]] = [(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"]),(["a","a","a"],["a","a","a"])] := rfl
