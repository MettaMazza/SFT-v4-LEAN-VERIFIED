import SFT.Computation.ManyBody
open SFT.Computation.ManyBody SFT.Mathematics.DiscreteObjects SFT.Mathematics.GraphOperations
set_option maxRecDepth 1000000
def model : Model := ⟨[⟨"A",["a","b"]⟩,⟨"B",["x","y"]⟩],[("A","B")],by rfl,by intro body member; cases member with | head => exact ⟨rfl,rfl⟩ | tail _ tail => cases tail with | head => exact ⟨rfl,rfl⟩ | tail _ impossible => cases impossible⟩
def configuration0 : Configuration model := ⟨[],formValue emptyOne,by rfl⟩
example : (configurationFactorization model configuration0,correlationLedger model [],missingCombinations model []) = (false,[(["a","x"],false),(["a","y"],false),(["b","x"],false),(["b","y"],false)],[["a","x"],["a","y"],["b","x"],["b","y"]]) := rfl
def configuration1 : Configuration model := ⟨[["a","x"]],collectionValue [["a","x"]],by rfl⟩
example : (configurationFactorization model configuration1,correlationLedger model [["a","x"]],missingCombinations model [["a","x"]]) = (false,[(["a","x"],true),(["a","y"],false),(["b","x"],false),(["b","y"],false)],[["a","y"],["b","x"],["b","y"]]) := rfl
def configuration2 : Configuration model := ⟨[["a","y"]],collectionValue [["a","y"]],by rfl⟩
example : (configurationFactorization model configuration2,correlationLedger model [["a","y"]],missingCombinations model [["a","y"]]) = (false,[(["a","x"],false),(["a","y"],true),(["b","x"],false),(["b","y"],false)],[["a","x"],["b","x"],["b","y"]]) := rfl
def configuration3 : Configuration model := ⟨[["a","x"],["a","y"]],collectionValue [["a","x"],["a","y"]],by rfl⟩
example : (configurationFactorization model configuration3,correlationLedger model [["a","x"],["a","y"]],missingCombinations model [["a","x"],["a","y"]]) = (false,[(["a","x"],true),(["a","y"],true),(["b","x"],false),(["b","y"],false)],[["b","x"],["b","y"]]) := rfl
def configuration4 : Configuration model := ⟨[["b","x"]],collectionValue [["b","x"]],by rfl⟩
example : (configurationFactorization model configuration4,correlationLedger model [["b","x"]],missingCombinations model [["b","x"]]) = (false,[(["a","x"],false),(["a","y"],false),(["b","x"],true),(["b","y"],false)],[["a","x"],["a","y"],["b","y"]]) := rfl
def configuration5 : Configuration model := ⟨[["a","x"],["b","x"]],collectionValue [["a","x"],["b","x"]],by rfl⟩
example : (configurationFactorization model configuration5,correlationLedger model [["a","x"],["b","x"]],missingCombinations model [["a","x"],["b","x"]]) = (false,[(["a","x"],true),(["a","y"],false),(["b","x"],true),(["b","y"],false)],[["a","y"],["b","y"]]) := rfl
def configuration6 : Configuration model := ⟨[["a","y"],["b","x"]],collectionValue [["a","y"],["b","x"]],by rfl⟩
example : (configurationFactorization model configuration6,correlationLedger model [["a","y"],["b","x"]],missingCombinations model [["a","y"],["b","x"]]) = (false,[(["a","x"],false),(["a","y"],true),(["b","x"],true),(["b","y"],false)],[["a","x"],["b","y"]]) := rfl
def configuration7 : Configuration model := ⟨[["a","x"],["a","y"],["b","x"]],collectionValue [["a","x"],["a","y"],["b","x"]],by rfl⟩
example : (configurationFactorization model configuration7,correlationLedger model [["a","x"],["a","y"],["b","x"]],missingCombinations model [["a","x"],["a","y"],["b","x"]]) = (false,[(["a","x"],true),(["a","y"],true),(["b","x"],true),(["b","y"],false)],[["b","y"]]) := rfl
def configuration8 : Configuration model := ⟨[["b","y"]],collectionValue [["b","y"]],by rfl⟩
example : (configurationFactorization model configuration8,correlationLedger model [["b","y"]],missingCombinations model [["b","y"]]) = (false,[(["a","x"],false),(["a","y"],false),(["b","x"],false),(["b","y"],true)],[["a","x"],["a","y"],["b","x"]]) := rfl
def configuration9 : Configuration model := ⟨[["a","x"],["b","y"]],collectionValue [["a","x"],["b","y"]],by rfl⟩
example : (configurationFactorization model configuration9,correlationLedger model [["a","x"],["b","y"]],missingCombinations model [["a","x"],["b","y"]]) = (false,[(["a","x"],true),(["a","y"],false),(["b","x"],false),(["b","y"],true)],[["a","y"],["b","x"]]) := rfl
def configuration10 : Configuration model := ⟨[["a","y"],["b","y"]],collectionValue [["a","y"],["b","y"]],by rfl⟩
example : (configurationFactorization model configuration10,correlationLedger model [["a","y"],["b","y"]],missingCombinations model [["a","y"],["b","y"]]) = (false,[(["a","x"],false),(["a","y"],true),(["b","x"],false),(["b","y"],true)],[["a","x"],["b","x"]]) := rfl
def configuration11 : Configuration model := ⟨[["a","x"],["a","y"],["b","y"]],collectionValue [["a","x"],["a","y"],["b","y"]],by rfl⟩
example : (configurationFactorization model configuration11,correlationLedger model [["a","x"],["a","y"],["b","y"]],missingCombinations model [["a","x"],["a","y"],["b","y"]]) = (false,[(["a","x"],true),(["a","y"],true),(["b","x"],false),(["b","y"],true)],[["b","x"]]) := rfl
def configuration12 : Configuration model := ⟨[["b","x"],["b","y"]],collectionValue [["b","x"],["b","y"]],by rfl⟩
example : (configurationFactorization model configuration12,correlationLedger model [["b","x"],["b","y"]],missingCombinations model [["b","x"],["b","y"]]) = (false,[(["a","x"],false),(["a","y"],false),(["b","x"],true),(["b","y"],true)],[["a","x"],["a","y"]]) := rfl
def configuration13 : Configuration model := ⟨[["a","x"],["b","x"],["b","y"]],collectionValue [["a","x"],["b","x"],["b","y"]],by rfl⟩
example : (configurationFactorization model configuration13,correlationLedger model [["a","x"],["b","x"],["b","y"]],missingCombinations model [["a","x"],["b","x"],["b","y"]]) = (false,[(["a","x"],true),(["a","y"],false),(["b","x"],true),(["b","y"],true)],[["a","y"]]) := rfl
def configuration14 : Configuration model := ⟨[["a","y"],["b","x"],["b","y"]],collectionValue [["a","y"],["b","x"],["b","y"]],by rfl⟩
example : (configurationFactorization model configuration14,correlationLedger model [["a","y"],["b","x"],["b","y"]],missingCombinations model [["a","y"],["b","x"],["b","y"]]) = (false,[(["a","x"],false),(["a","y"],true),(["b","x"],true),(["b","y"],true)],[["a","x"]]) := rfl
def configuration15 : Configuration model := ⟨[["a","x"],["a","y"],["b","x"],["b","y"]],collectionValue [["a","x"],["a","y"],["b","x"],["b","y"]],by rfl⟩
example : (configurationFactorization model configuration15,correlationLedger model [["a","x"],["a","y"],["b","x"],["b","y"]],missingCombinations model [["a","x"],["a","y"],["b","x"],["b","y"]]) = (true,[(["a","x"],true),(["a","y"],true),(["b","x"],true),(["b","y"],true)],[]) := rfl
def update0 : Update model := ⟨[],by rfl⟩
example : execute model update0 ["a","x"] [] = some ["a","x"] := rfl
example : execute model update0 ["a","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["a","y"] [] = some ["a","y"] := rfl
example : execute model update0 ["a","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["b","x"] [] = some ["b","x"] := rfl
example : execute model update0 ["b","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["b","y"] [] = some ["b","y"] := rfl
example : execute model update0 ["b","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["outside"] [] = none := rfl
example : execute model update0 ["outside"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["outside"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["outside"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["outside"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update0 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update0 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update0 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update0 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
def update1 : Update model := ⟨[(["a","x"],["a","x"])],by rfl⟩
example : execute model update1 ["a","x"] [] = some ["a","x"] := rfl
example : execute model update1 ["a","x"] [(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update1 ["a","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["a","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["a","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update1 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["a","y"] [] = some ["a","y"] := rfl
example : execute model update1 ["a","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["b","x"] [] = some ["b","x"] := rfl
example : execute model update1 ["b","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["b","y"] [] = some ["b","y"] := rfl
example : execute model update1 ["b","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["outside"] [] = none := rfl
example : execute model update1 ["outside"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["outside"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["outside"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["outside"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update1 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update1 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update1 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update1 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
def update2 : Update model := ⟨[(["a","x"],["a","y"])],by rfl⟩
example : execute model update2 ["a","x"] [] = some ["a","x"] := rfl
example : execute model update2 ["a","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["a","x"] [(["a","x"],["a","y"])] = some ["a","y"] := rfl
example : execute model update2 ["a","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["a","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["a","y"] [] = some ["a","y"] := rfl
example : execute model update2 ["a","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["b","x"] [] = some ["b","x"] := rfl
example : execute model update2 ["b","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["b","y"] [] = some ["b","y"] := rfl
example : execute model update2 ["b","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["outside"] [] = none := rfl
example : execute model update2 ["outside"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["outside"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["outside"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["outside"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update2 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update2 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update2 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update2 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
def update3 : Update model := ⟨[(["a","x"],["a","x"]),(["a","x"],["a","y"])],by rfl⟩
example : execute model update3 ["a","x"] [] = some ["a","x"] := rfl
example : execute model update3 ["a","x"] [(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update3 ["a","x"] [(["a","x"],["a","y"])] = some ["a","y"] := rfl
example : execute model update3 ["a","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["a","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update3 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = some ["a","y"] := rfl
example : execute model update3 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["a","y"] [] = some ["a","y"] := rfl
example : execute model update3 ["a","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["b","x"] [] = some ["b","x"] := rfl
example : execute model update3 ["b","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["b","y"] [] = some ["b","y"] := rfl
example : execute model update3 ["b","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["outside"] [] = none := rfl
example : execute model update3 ["outside"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["outside"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["outside"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["outside"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update3 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update3 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update3 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update3 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
def update4 : Update model := ⟨[(["a","y"],["a","x"])],by rfl⟩
example : execute model update4 ["a","x"] [] = some ["a","x"] := rfl
example : execute model update4 ["a","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["a","y"] [] = some ["a","y"] := rfl
example : execute model update4 ["a","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["a","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["a","y"] [(["a","y"],["a","x"])] = some ["a","x"] := rfl
example : execute model update4 ["a","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["b","x"] [] = some ["b","x"] := rfl
example : execute model update4 ["b","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["b","y"] [] = some ["b","y"] := rfl
example : execute model update4 ["b","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["outside"] [] = none := rfl
example : execute model update4 ["outside"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["outside"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["outside"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["outside"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update4 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update4 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update4 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update4 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
def update5 : Update model := ⟨[(["a","x"],["a","x"]),(["a","y"],["a","x"])],by rfl⟩
example : execute model update5 ["a","x"] [] = some ["a","x"] := rfl
example : execute model update5 ["a","x"] [(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update5 ["a","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["a","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["a","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update5 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["a","y"] [] = some ["a","y"] := rfl
example : execute model update5 ["a","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["a","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["a","y"] [(["a","y"],["a","x"])] = some ["a","x"] := rfl
example : execute model update5 ["a","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update5 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["b","x"] [] = some ["b","x"] := rfl
example : execute model update5 ["b","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["b","y"] [] = some ["b","y"] := rfl
example : execute model update5 ["b","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["outside"] [] = none := rfl
example : execute model update5 ["outside"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["outside"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["outside"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["outside"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update5 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update5 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update5 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update5 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
def update6 : Update model := ⟨[(["a","x"],["a","y"]),(["a","y"],["a","x"])],by rfl⟩
example : execute model update6 ["a","x"] [] = some ["a","x"] := rfl
example : execute model update6 ["a","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["a","x"] [(["a","x"],["a","y"])] = some ["a","y"] := rfl
example : execute model update6 ["a","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["a","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = some ["a","x"] := rfl
example : execute model update6 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["a","y"] [] = some ["a","y"] := rfl
example : execute model update6 ["a","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["a","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["a","y"] [(["a","y"],["a","x"])] = some ["a","x"] := rfl
example : execute model update6 ["a","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = some ["a","y"] := rfl
example : execute model update6 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["b","x"] [] = some ["b","x"] := rfl
example : execute model update6 ["b","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["b","y"] [] = some ["b","y"] := rfl
example : execute model update6 ["b","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["outside"] [] = none := rfl
example : execute model update6 ["outside"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["outside"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["outside"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["outside"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update6 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update6 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update6 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update6 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
def update7 : Update model := ⟨[(["a","x"],["a","x"]),(["a","x"],["a","y"]),(["a","y"],["a","x"])],by rfl⟩
example : execute model update7 ["a","x"] [] = some ["a","x"] := rfl
example : execute model update7 ["a","x"] [(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update7 ["a","x"] [(["a","x"],["a","y"])] = some ["a","y"] := rfl
example : execute model update7 ["a","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["a","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update7 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = some ["a","y"] := rfl
example : execute model update7 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = some ["a","x"] := rfl
example : execute model update7 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["a","y"] [] = some ["a","y"] := rfl
example : execute model update7 ["a","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["a","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["a","y"] [(["a","y"],["a","x"])] = some ["a","x"] := rfl
example : execute model update7 ["a","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update7 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = some ["a","y"] := rfl
example : execute model update7 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["b","x"] [] = some ["b","x"] := rfl
example : execute model update7 ["b","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["b","y"] [] = some ["b","y"] := rfl
example : execute model update7 ["b","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["outside"] [] = none := rfl
example : execute model update7 ["outside"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["outside"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["outside"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["outside"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update7 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update7 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update7 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update7 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
def update8 : Update model := ⟨[(["a","y"],["a","y"])],by rfl⟩
example : execute model update8 ["a","x"] [] = some ["a","x"] := rfl
example : execute model update8 ["a","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["a","y"] [] = some ["a","y"] := rfl
example : execute model update8 ["a","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["a","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["a","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["a","y"] [(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update8 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update8 ["b","x"] [] = some ["b","x"] := rfl
example : execute model update8 ["b","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["b","y"] [] = some ["b","y"] := rfl
example : execute model update8 ["b","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["outside"] [] = none := rfl
example : execute model update8 ["outside"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["outside"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["outside"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["outside"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update8 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update8 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update8 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update8 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
def update9 : Update model := ⟨[(["a","x"],["a","x"]),(["a","y"],["a","y"])],by rfl⟩
example : execute model update9 ["a","x"] [] = some ["a","x"] := rfl
example : execute model update9 ["a","x"] [(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update9 ["a","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["a","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["a","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update9 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["a","y"] [] = some ["a","y"] := rfl
example : execute model update9 ["a","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["a","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["a","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["a","y"] [(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update9 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update9 ["b","x"] [] = some ["b","x"] := rfl
example : execute model update9 ["b","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["b","y"] [] = some ["b","y"] := rfl
example : execute model update9 ["b","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["outside"] [] = none := rfl
example : execute model update9 ["outside"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["outside"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["outside"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["outside"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update9 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update9 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update9 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update9 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
def update10 : Update model := ⟨[(["a","x"],["a","y"]),(["a","y"],["a","y"])],by rfl⟩
example : execute model update10 ["a","x"] [] = some ["a","x"] := rfl
example : execute model update10 ["a","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["a","x"] [(["a","x"],["a","y"])] = some ["a","y"] := rfl
example : execute model update10 ["a","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["a","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update10 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["a","y"] [] = some ["a","y"] := rfl
example : execute model update10 ["a","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["a","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["a","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["a","y"] [(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update10 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update10 ["b","x"] [] = some ["b","x"] := rfl
example : execute model update10 ["b","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["b","y"] [] = some ["b","y"] := rfl
example : execute model update10 ["b","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["outside"] [] = none := rfl
example : execute model update10 ["outside"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["outside"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["outside"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["outside"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update10 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update10 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update10 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update10 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
def update11 : Update model := ⟨[(["a","x"],["a","x"]),(["a","x"],["a","y"]),(["a","y"],["a","y"])],by rfl⟩
example : execute model update11 ["a","x"] [] = some ["a","x"] := rfl
example : execute model update11 ["a","x"] [(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update11 ["a","x"] [(["a","x"],["a","y"])] = some ["a","y"] := rfl
example : execute model update11 ["a","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["a","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update11 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = some ["a","y"] := rfl
example : execute model update11 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update11 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["a","y"] [] = some ["a","y"] := rfl
example : execute model update11 ["a","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["a","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["a","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["a","y"] [(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update11 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update11 ["b","x"] [] = some ["b","x"] := rfl
example : execute model update11 ["b","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["b","y"] [] = some ["b","y"] := rfl
example : execute model update11 ["b","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["outside"] [] = none := rfl
example : execute model update11 ["outside"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["outside"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["outside"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["outside"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update11 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update11 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update11 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update11 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
def update12 : Update model := ⟨[(["a","y"],["a","x"]),(["a","y"],["a","y"])],by rfl⟩
example : execute model update12 ["a","x"] [] = some ["a","x"] := rfl
example : execute model update12 ["a","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["a","y"] [] = some ["a","y"] := rfl
example : execute model update12 ["a","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["a","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["a","y"] [(["a","y"],["a","x"])] = some ["a","x"] := rfl
example : execute model update12 ["a","y"] [(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update12 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = some ["a","x"] := rfl
example : execute model update12 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update12 ["b","x"] [] = some ["b","x"] := rfl
example : execute model update12 ["b","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["b","y"] [] = some ["b","y"] := rfl
example : execute model update12 ["b","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["outside"] [] = none := rfl
example : execute model update12 ["outside"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["outside"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["outside"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["outside"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update12 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update12 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update12 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update12 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
def update13 : Update model := ⟨[(["a","x"],["a","x"]),(["a","y"],["a","x"]),(["a","y"],["a","y"])],by rfl⟩
example : execute model update13 ["a","x"] [] = some ["a","x"] := rfl
example : execute model update13 ["a","x"] [(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update13 ["a","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["a","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["a","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update13 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["a","y"] [] = some ["a","y"] := rfl
example : execute model update13 ["a","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["a","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["a","y"] [(["a","y"],["a","x"])] = some ["a","x"] := rfl
example : execute model update13 ["a","y"] [(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update13 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update13 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = some ["a","x"] := rfl
example : execute model update13 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update13 ["b","x"] [] = some ["b","x"] := rfl
example : execute model update13 ["b","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["b","y"] [] = some ["b","y"] := rfl
example : execute model update13 ["b","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["outside"] [] = none := rfl
example : execute model update13 ["outside"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["outside"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["outside"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["outside"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update13 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update13 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update13 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update13 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
def update14 : Update model := ⟨[(["a","x"],["a","y"]),(["a","y"],["a","x"]),(["a","y"],["a","y"])],by rfl⟩
example : execute model update14 ["a","x"] [] = some ["a","x"] := rfl
example : execute model update14 ["a","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["a","x"] [(["a","x"],["a","y"])] = some ["a","y"] := rfl
example : execute model update14 ["a","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["a","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = some ["a","x"] := rfl
example : execute model update14 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update14 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["a","y"] [] = some ["a","y"] := rfl
example : execute model update14 ["a","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["a","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["a","y"] [(["a","y"],["a","x"])] = some ["a","x"] := rfl
example : execute model update14 ["a","y"] [(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update14 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = some ["a","y"] := rfl
example : execute model update14 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = some ["a","x"] := rfl
example : execute model update14 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update14 ["b","x"] [] = some ["b","x"] := rfl
example : execute model update14 ["b","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["b","y"] [] = some ["b","y"] := rfl
example : execute model update14 ["b","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["outside"] [] = none := rfl
example : execute model update14 ["outside"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["outside"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["outside"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["outside"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update14 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update14 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update14 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update14 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
def update15 : Update model := ⟨[(["a","x"],["a","x"]),(["a","x"],["a","y"]),(["a","y"],["a","x"]),(["a","y"],["a","y"])],by rfl⟩
example : execute model update15 ["a","x"] [] = some ["a","x"] := rfl
example : execute model update15 ["a","x"] [(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update15 ["a","x"] [(["a","x"],["a","y"])] = some ["a","y"] := rfl
example : execute model update15 ["a","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["a","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update15 ["a","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = some ["a","y"] := rfl
example : execute model update15 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["a","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["a","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = some ["a","x"] := rfl
example : execute model update15 ["a","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update15 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["a","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["a","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["a","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["a","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["a","y"] [] = some ["a","y"] := rfl
example : execute model update15 ["a","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["a","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["a","y"] [(["a","y"],["a","x"])] = some ["a","x"] := rfl
example : execute model update15 ["a","y"] [(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update15 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["a","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["a","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["a","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["a","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = some ["a","x"] := rfl
example : execute model update15 ["a","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = some ["a","y"] := rfl
example : execute model update15 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["a","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["a","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = some ["a","x"] := rfl
example : execute model update15 ["a","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = some ["a","y"] := rfl
example : execute model update15 ["b","x"] [] = some ["b","x"] := rfl
example : execute model update15 ["b","x"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["b","x"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["b","y"] [] = some ["b","y"] := rfl
example : execute model update15 ["b","y"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["b","y"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["outside"] [] = none := rfl
example : execute model update15 ["outside"] [(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["outside"] [(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["outside"] [(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["outside"] [(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["outside"] [(["a","x"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["outside"] [(["a","x"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["outside"] [(["a","x"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["outside"] [(["a","x"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["outside"] [(["a","y"],["a","x"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["outside"] [(["a","y"],["a","x"]),(["a","y"],["a","y"])] = none := rfl
example : execute model update15 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","x"])] = none := rfl
example : execute model update15 ["outside"] [(["a","y"],["a","y"]),(["a","x"],["a","y"])] = none := rfl
example : execute model update15 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","x"])] = none := rfl
example : execute model update15 ["outside"] [(["a","y"],["a","y"]),(["a","y"],["a","y"])] = none := rfl
example : makeGraph ["A","B"] [] = .ok ⟨["A","B"],[]⟩ := rfl
example : makeGraph ["A","B"] [("A","A")] = .ok ⟨["A","B"],[("A","A")]⟩ := rfl
example : makeGraph ["A","B"] [("A","B")] = .ok ⟨["A","B"],[("A","B")]⟩ := rfl
example : makeGraph ["A","B"] [("A","A"),("A","B")] = .ok ⟨["A","B"],[("A","A"),("A","B")]⟩ := rfl
example : makeGraph ["A","B"] [("B","A")] = .ok ⟨["A","B"],[("B","A")]⟩ := rfl
example : makeGraph ["A","B"] [("A","A"),("B","A")] = .ok ⟨["A","B"],[("A","A"),("B","A")]⟩ := rfl
example : makeGraph ["A","B"] [("A","B"),("B","A")] = .ok ⟨["A","B"],[("A","B"),("B","A")]⟩ := rfl
example : makeGraph ["A","B"] [("A","A"),("A","B"),("B","A")] = .ok ⟨["A","B"],[("A","A"),("A","B"),("B","A")]⟩ := rfl
example : makeGraph ["A","B"] [("B","B")] = .ok ⟨["A","B"],[("B","B")]⟩ := rfl
example : makeGraph ["A","B"] [("A","A"),("B","B")] = .ok ⟨["A","B"],[("A","A"),("B","B")]⟩ := rfl
example : makeGraph ["A","B"] [("A","B"),("B","B")] = .ok ⟨["A","B"],[("A","B"),("B","B")]⟩ := rfl
example : makeGraph ["A","B"] [("A","A"),("A","B"),("B","B")] = .ok ⟨["A","B"],[("A","A"),("A","B"),("B","B")]⟩ := rfl
example : makeGraph ["A","B"] [("B","A"),("B","B")] = .ok ⟨["A","B"],[("B","A"),("B","B")]⟩ := rfl
example : makeGraph ["A","B"] [("A","A"),("B","A"),("B","B")] = .ok ⟨["A","B"],[("A","A"),("B","A"),("B","B")]⟩ := rfl
example : makeGraph ["A","B"] [("A","B"),("B","A"),("B","B")] = .ok ⟨["A","B"],[("A","B"),("B","A"),("B","B")]⟩ := rfl
example : makeGraph ["A","B"] [("A","A"),("A","B"),("B","A"),("B","B")] = .ok ⟨["A","B"],[("A","A"),("A","B"),("B","A"),("B","B")]⟩ := rfl
example : makeGraph [] [] = .error "ValueError: graph nodes must be a nonempty canonical collection" := rfl
example : makeGraph ["A","A"] [] = .error "ValueError: graph nodes must be a nonempty canonical collection" := rfl
example : makeGraph ["A"] [("A","B")] = .error "ValueError: every edge endpoint must belong to the node carrier" := rfl
example : makeGraph ["A"] [("A","A"),("A","A")] = .error "ValueError: graph relation cannot repeat an edge" := rfl
