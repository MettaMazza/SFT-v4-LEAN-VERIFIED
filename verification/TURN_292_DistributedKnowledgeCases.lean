import SFT.Computation.DistributedKnowledge
open SFT.Computation.DistributedKnowledge
set_option maxRecDepth 10000
def o000 : Observer := ⟨"p",[("e0","0"),("e1","0"),("e2","0")]⟩
def m000 : Model := ⟨["e0","e1","e2"],[o000]⟩
example : individual m000.executions o000 "e0" [] = false := by decide
example : common m000 "e0" [] = false := by decide
example : individual m000.executions o000 "e0" ["e0"] = false := by decide
example : common m000 "e0" ["e0"] = false := by decide
example : individual m000.executions o000 "e0" ["e1"] = false := by decide
example : common m000 "e0" ["e1"] = false := by decide
example : individual m000.executions o000 "e0" ["e0","e1"] = false := by decide
example : common m000 "e0" ["e0","e1"] = false := by decide
example : individual m000.executions o000 "e0" ["e2"] = false := by decide
example : common m000 "e0" ["e2"] = false := by decide
example : individual m000.executions o000 "e0" ["e0","e2"] = false := by decide
example : common m000 "e0" ["e0","e2"] = false := by decide
example : individual m000.executions o000 "e0" ["e1","e2"] = false := by decide
example : common m000 "e0" ["e1","e2"] = false := by decide
example : individual m000.executions o000 "e0" ["e0","e1","e2"] = true := by decide
example : common m000 "e0" ["e0","e1","e2"] = true := by decide
example : individual m000.executions o000 "e1" [] = false := by decide
example : common m000 "e1" [] = false := by decide
example : individual m000.executions o000 "e1" ["e0"] = false := by decide
example : common m000 "e1" ["e0"] = false := by decide
example : individual m000.executions o000 "e1" ["e1"] = false := by decide
example : common m000 "e1" ["e1"] = false := by decide
example : individual m000.executions o000 "e1" ["e0","e1"] = false := by decide
example : common m000 "e1" ["e0","e1"] = false := by decide
example : individual m000.executions o000 "e1" ["e2"] = false := by decide
example : common m000 "e1" ["e2"] = false := by decide
example : individual m000.executions o000 "e1" ["e0","e2"] = false := by decide
example : common m000 "e1" ["e0","e2"] = false := by decide
example : individual m000.executions o000 "e1" ["e1","e2"] = false := by decide
example : common m000 "e1" ["e1","e2"] = false := by decide
example : individual m000.executions o000 "e1" ["e0","e1","e2"] = true := by decide
example : common m000 "e1" ["e0","e1","e2"] = true := by decide
example : individual m000.executions o000 "e2" [] = false := by decide
example : common m000 "e2" [] = false := by decide
example : individual m000.executions o000 "e2" ["e0"] = false := by decide
example : common m000 "e2" ["e0"] = false := by decide
example : individual m000.executions o000 "e2" ["e1"] = false := by decide
example : common m000 "e2" ["e1"] = false := by decide
example : individual m000.executions o000 "e2" ["e0","e1"] = false := by decide
example : common m000 "e2" ["e0","e1"] = false := by decide
example : individual m000.executions o000 "e2" ["e2"] = false := by decide
example : common m000 "e2" ["e2"] = false := by decide
example : individual m000.executions o000 "e2" ["e0","e2"] = false := by decide
example : common m000 "e2" ["e0","e2"] = false := by decide
example : individual m000.executions o000 "e2" ["e1","e2"] = false := by decide
example : common m000 "e2" ["e1","e2"] = false := by decide
example : individual m000.executions o000 "e2" ["e0","e1","e2"] = true := by decide
example : common m000 "e2" ["e0","e1","e2"] = true := by decide
def o001 : Observer := ⟨"p",[("e0","0"),("e1","0"),("e2","1")]⟩
def m001 : Model := ⟨["e0","e1","e2"],[o001]⟩
example : individual m001.executions o001 "e0" [] = false := by decide
example : common m001 "e0" [] = false := by decide
example : individual m001.executions o001 "e0" ["e0"] = false := by decide
example : common m001 "e0" ["e0"] = false := by decide
example : individual m001.executions o001 "e0" ["e1"] = false := by decide
example : common m001 "e0" ["e1"] = false := by decide
example : individual m001.executions o001 "e0" ["e0","e1"] = true := by decide
example : common m001 "e0" ["e0","e1"] = true := by decide
example : individual m001.executions o001 "e0" ["e2"] = false := by decide
example : common m001 "e0" ["e2"] = false := by decide
example : individual m001.executions o001 "e0" ["e0","e2"] = false := by decide
example : common m001 "e0" ["e0","e2"] = false := by decide
example : individual m001.executions o001 "e0" ["e1","e2"] = false := by decide
example : common m001 "e0" ["e1","e2"] = false := by decide
example : individual m001.executions o001 "e0" ["e0","e1","e2"] = true := by decide
example : common m001 "e0" ["e0","e1","e2"] = true := by decide
example : individual m001.executions o001 "e1" [] = false := by decide
example : common m001 "e1" [] = false := by decide
example : individual m001.executions o001 "e1" ["e0"] = false := by decide
example : common m001 "e1" ["e0"] = false := by decide
example : individual m001.executions o001 "e1" ["e1"] = false := by decide
example : common m001 "e1" ["e1"] = false := by decide
example : individual m001.executions o001 "e1" ["e0","e1"] = true := by decide
example : common m001 "e1" ["e0","e1"] = true := by decide
example : individual m001.executions o001 "e1" ["e2"] = false := by decide
example : common m001 "e1" ["e2"] = false := by decide
example : individual m001.executions o001 "e1" ["e0","e2"] = false := by decide
example : common m001 "e1" ["e0","e2"] = false := by decide
example : individual m001.executions o001 "e1" ["e1","e2"] = false := by decide
example : common m001 "e1" ["e1","e2"] = false := by decide
example : individual m001.executions o001 "e1" ["e0","e1","e2"] = true := by decide
example : common m001 "e1" ["e0","e1","e2"] = true := by decide
example : individual m001.executions o001 "e2" [] = false := by decide
example : common m001 "e2" [] = false := by decide
example : individual m001.executions o001 "e2" ["e0"] = false := by decide
example : common m001 "e2" ["e0"] = false := by decide
example : individual m001.executions o001 "e2" ["e1"] = false := by decide
example : common m001 "e2" ["e1"] = false := by decide
example : individual m001.executions o001 "e2" ["e0","e1"] = false := by decide
example : common m001 "e2" ["e0","e1"] = false := by decide
example : individual m001.executions o001 "e2" ["e2"] = true := by decide
example : common m001 "e2" ["e2"] = true := by decide
example : individual m001.executions o001 "e2" ["e0","e2"] = true := by decide
example : common m001 "e2" ["e0","e2"] = true := by decide
example : individual m001.executions o001 "e2" ["e1","e2"] = true := by decide
example : common m001 "e2" ["e1","e2"] = true := by decide
example : individual m001.executions o001 "e2" ["e0","e1","e2"] = true := by decide
example : common m001 "e2" ["e0","e1","e2"] = true := by decide
def o010 : Observer := ⟨"p",[("e0","0"),("e1","1"),("e2","0")]⟩
def m010 : Model := ⟨["e0","e1","e2"],[o010]⟩
example : individual m010.executions o010 "e0" [] = false := by decide
example : common m010 "e0" [] = false := by decide
example : individual m010.executions o010 "e0" ["e0"] = false := by decide
example : common m010 "e0" ["e0"] = false := by decide
example : individual m010.executions o010 "e0" ["e1"] = false := by decide
example : common m010 "e0" ["e1"] = false := by decide
example : individual m010.executions o010 "e0" ["e0","e1"] = false := by decide
example : common m010 "e0" ["e0","e1"] = false := by decide
example : individual m010.executions o010 "e0" ["e2"] = false := by decide
example : common m010 "e0" ["e2"] = false := by decide
example : individual m010.executions o010 "e0" ["e0","e2"] = true := by decide
example : common m010 "e0" ["e0","e2"] = true := by decide
example : individual m010.executions o010 "e0" ["e1","e2"] = false := by decide
example : common m010 "e0" ["e1","e2"] = false := by decide
example : individual m010.executions o010 "e0" ["e0","e1","e2"] = true := by decide
example : common m010 "e0" ["e0","e1","e2"] = true := by decide
example : individual m010.executions o010 "e1" [] = false := by decide
example : common m010 "e1" [] = false := by decide
example : individual m010.executions o010 "e1" ["e0"] = false := by decide
example : common m010 "e1" ["e0"] = false := by decide
example : individual m010.executions o010 "e1" ["e1"] = true := by decide
example : common m010 "e1" ["e1"] = true := by decide
example : individual m010.executions o010 "e1" ["e0","e1"] = true := by decide
example : common m010 "e1" ["e0","e1"] = true := by decide
example : individual m010.executions o010 "e1" ["e2"] = false := by decide
example : common m010 "e1" ["e2"] = false := by decide
example : individual m010.executions o010 "e1" ["e0","e2"] = false := by decide
example : common m010 "e1" ["e0","e2"] = false := by decide
example : individual m010.executions o010 "e1" ["e1","e2"] = true := by decide
example : common m010 "e1" ["e1","e2"] = true := by decide
example : individual m010.executions o010 "e1" ["e0","e1","e2"] = true := by decide
example : common m010 "e1" ["e0","e1","e2"] = true := by decide
example : individual m010.executions o010 "e2" [] = false := by decide
example : common m010 "e2" [] = false := by decide
example : individual m010.executions o010 "e2" ["e0"] = false := by decide
example : common m010 "e2" ["e0"] = false := by decide
example : individual m010.executions o010 "e2" ["e1"] = false := by decide
example : common m010 "e2" ["e1"] = false := by decide
example : individual m010.executions o010 "e2" ["e0","e1"] = false := by decide
example : common m010 "e2" ["e0","e1"] = false := by decide
example : individual m010.executions o010 "e2" ["e2"] = false := by decide
example : common m010 "e2" ["e2"] = false := by decide
example : individual m010.executions o010 "e2" ["e0","e2"] = true := by decide
example : common m010 "e2" ["e0","e2"] = true := by decide
example : individual m010.executions o010 "e2" ["e1","e2"] = false := by decide
example : common m010 "e2" ["e1","e2"] = false := by decide
example : individual m010.executions o010 "e2" ["e0","e1","e2"] = true := by decide
example : common m010 "e2" ["e0","e1","e2"] = true := by decide
def o011 : Observer := ⟨"p",[("e0","0"),("e1","1"),("e2","1")]⟩
def m011 : Model := ⟨["e0","e1","e2"],[o011]⟩
example : individual m011.executions o011 "e0" [] = false := by decide
example : common m011 "e0" [] = false := by decide
example : individual m011.executions o011 "e0" ["e0"] = true := by decide
example : common m011 "e0" ["e0"] = true := by decide
example : individual m011.executions o011 "e0" ["e1"] = false := by decide
example : common m011 "e0" ["e1"] = false := by decide
example : individual m011.executions o011 "e0" ["e0","e1"] = true := by decide
example : common m011 "e0" ["e0","e1"] = true := by decide
example : individual m011.executions o011 "e0" ["e2"] = false := by decide
example : common m011 "e0" ["e2"] = false := by decide
example : individual m011.executions o011 "e0" ["e0","e2"] = true := by decide
example : common m011 "e0" ["e0","e2"] = true := by decide
example : individual m011.executions o011 "e0" ["e1","e2"] = false := by decide
example : common m011 "e0" ["e1","e2"] = false := by decide
example : individual m011.executions o011 "e0" ["e0","e1","e2"] = true := by decide
example : common m011 "e0" ["e0","e1","e2"] = true := by decide
example : individual m011.executions o011 "e1" [] = false := by decide
example : common m011 "e1" [] = false := by decide
example : individual m011.executions o011 "e1" ["e0"] = false := by decide
example : common m011 "e1" ["e0"] = false := by decide
example : individual m011.executions o011 "e1" ["e1"] = false := by decide
example : common m011 "e1" ["e1"] = false := by decide
example : individual m011.executions o011 "e1" ["e0","e1"] = false := by decide
example : common m011 "e1" ["e0","e1"] = false := by decide
example : individual m011.executions o011 "e1" ["e2"] = false := by decide
example : common m011 "e1" ["e2"] = false := by decide
example : individual m011.executions o011 "e1" ["e0","e2"] = false := by decide
example : common m011 "e1" ["e0","e2"] = false := by decide
example : individual m011.executions o011 "e1" ["e1","e2"] = true := by decide
example : common m011 "e1" ["e1","e2"] = true := by decide
example : individual m011.executions o011 "e1" ["e0","e1","e2"] = true := by decide
example : common m011 "e1" ["e0","e1","e2"] = true := by decide
example : individual m011.executions o011 "e2" [] = false := by decide
example : common m011 "e2" [] = false := by decide
example : individual m011.executions o011 "e2" ["e0"] = false := by decide
example : common m011 "e2" ["e0"] = false := by decide
example : individual m011.executions o011 "e2" ["e1"] = false := by decide
example : common m011 "e2" ["e1"] = false := by decide
example : individual m011.executions o011 "e2" ["e0","e1"] = false := by decide
example : common m011 "e2" ["e0","e1"] = false := by decide
example : individual m011.executions o011 "e2" ["e2"] = false := by decide
example : common m011 "e2" ["e2"] = false := by decide
example : individual m011.executions o011 "e2" ["e0","e2"] = false := by decide
example : common m011 "e2" ["e0","e2"] = false := by decide
example : individual m011.executions o011 "e2" ["e1","e2"] = true := by decide
example : common m011 "e2" ["e1","e2"] = true := by decide
example : individual m011.executions o011 "e2" ["e0","e1","e2"] = true := by decide
example : common m011 "e2" ["e0","e1","e2"] = true := by decide
def o100 : Observer := ⟨"p",[("e0","1"),("e1","0"),("e2","0")]⟩
def m100 : Model := ⟨["e0","e1","e2"],[o100]⟩
example : individual m100.executions o100 "e0" [] = false := by decide
example : common m100 "e0" [] = false := by decide
example : individual m100.executions o100 "e0" ["e0"] = true := by decide
example : common m100 "e0" ["e0"] = true := by decide
example : individual m100.executions o100 "e0" ["e1"] = false := by decide
example : common m100 "e0" ["e1"] = false := by decide
example : individual m100.executions o100 "e0" ["e0","e1"] = true := by decide
example : common m100 "e0" ["e0","e1"] = true := by decide
example : individual m100.executions o100 "e0" ["e2"] = false := by decide
example : common m100 "e0" ["e2"] = false := by decide
example : individual m100.executions o100 "e0" ["e0","e2"] = true := by decide
example : common m100 "e0" ["e0","e2"] = true := by decide
example : individual m100.executions o100 "e0" ["e1","e2"] = false := by decide
example : common m100 "e0" ["e1","e2"] = false := by decide
example : individual m100.executions o100 "e0" ["e0","e1","e2"] = true := by decide
example : common m100 "e0" ["e0","e1","e2"] = true := by decide
example : individual m100.executions o100 "e1" [] = false := by decide
example : common m100 "e1" [] = false := by decide
example : individual m100.executions o100 "e1" ["e0"] = false := by decide
example : common m100 "e1" ["e0"] = false := by decide
example : individual m100.executions o100 "e1" ["e1"] = false := by decide
example : common m100 "e1" ["e1"] = false := by decide
example : individual m100.executions o100 "e1" ["e0","e1"] = false := by decide
example : common m100 "e1" ["e0","e1"] = false := by decide
example : individual m100.executions o100 "e1" ["e2"] = false := by decide
example : common m100 "e1" ["e2"] = false := by decide
example : individual m100.executions o100 "e1" ["e0","e2"] = false := by decide
example : common m100 "e1" ["e0","e2"] = false := by decide
example : individual m100.executions o100 "e1" ["e1","e2"] = true := by decide
example : common m100 "e1" ["e1","e2"] = true := by decide
example : individual m100.executions o100 "e1" ["e0","e1","e2"] = true := by decide
example : common m100 "e1" ["e0","e1","e2"] = true := by decide
example : individual m100.executions o100 "e2" [] = false := by decide
example : common m100 "e2" [] = false := by decide
example : individual m100.executions o100 "e2" ["e0"] = false := by decide
example : common m100 "e2" ["e0"] = false := by decide
example : individual m100.executions o100 "e2" ["e1"] = false := by decide
example : common m100 "e2" ["e1"] = false := by decide
example : individual m100.executions o100 "e2" ["e0","e1"] = false := by decide
example : common m100 "e2" ["e0","e1"] = false := by decide
example : individual m100.executions o100 "e2" ["e2"] = false := by decide
example : common m100 "e2" ["e2"] = false := by decide
example : individual m100.executions o100 "e2" ["e0","e2"] = false := by decide
example : common m100 "e2" ["e0","e2"] = false := by decide
example : individual m100.executions o100 "e2" ["e1","e2"] = true := by decide
example : common m100 "e2" ["e1","e2"] = true := by decide
example : individual m100.executions o100 "e2" ["e0","e1","e2"] = true := by decide
example : common m100 "e2" ["e0","e1","e2"] = true := by decide
def o101 : Observer := ⟨"p",[("e0","1"),("e1","0"),("e2","1")]⟩
def m101 : Model := ⟨["e0","e1","e2"],[o101]⟩
example : individual m101.executions o101 "e0" [] = false := by decide
example : common m101 "e0" [] = false := by decide
example : individual m101.executions o101 "e0" ["e0"] = false := by decide
example : common m101 "e0" ["e0"] = false := by decide
example : individual m101.executions o101 "e0" ["e1"] = false := by decide
example : common m101 "e0" ["e1"] = false := by decide
example : individual m101.executions o101 "e0" ["e0","e1"] = false := by decide
example : common m101 "e0" ["e0","e1"] = false := by decide
example : individual m101.executions o101 "e0" ["e2"] = false := by decide
example : common m101 "e0" ["e2"] = false := by decide
example : individual m101.executions o101 "e0" ["e0","e2"] = true := by decide
example : common m101 "e0" ["e0","e2"] = true := by decide
example : individual m101.executions o101 "e0" ["e1","e2"] = false := by decide
example : common m101 "e0" ["e1","e2"] = false := by decide
example : individual m101.executions o101 "e0" ["e0","e1","e2"] = true := by decide
example : common m101 "e0" ["e0","e1","e2"] = true := by decide
example : individual m101.executions o101 "e1" [] = false := by decide
example : common m101 "e1" [] = false := by decide
example : individual m101.executions o101 "e1" ["e0"] = false := by decide
example : common m101 "e1" ["e0"] = false := by decide
example : individual m101.executions o101 "e1" ["e1"] = true := by decide
example : common m101 "e1" ["e1"] = true := by decide
example : individual m101.executions o101 "e1" ["e0","e1"] = true := by decide
example : common m101 "e1" ["e0","e1"] = true := by decide
example : individual m101.executions o101 "e1" ["e2"] = false := by decide
example : common m101 "e1" ["e2"] = false := by decide
example : individual m101.executions o101 "e1" ["e0","e2"] = false := by decide
example : common m101 "e1" ["e0","e2"] = false := by decide
example : individual m101.executions o101 "e1" ["e1","e2"] = true := by decide
example : common m101 "e1" ["e1","e2"] = true := by decide
example : individual m101.executions o101 "e1" ["e0","e1","e2"] = true := by decide
example : common m101 "e1" ["e0","e1","e2"] = true := by decide
example : individual m101.executions o101 "e2" [] = false := by decide
example : common m101 "e2" [] = false := by decide
example : individual m101.executions o101 "e2" ["e0"] = false := by decide
example : common m101 "e2" ["e0"] = false := by decide
example : individual m101.executions o101 "e2" ["e1"] = false := by decide
example : common m101 "e2" ["e1"] = false := by decide
example : individual m101.executions o101 "e2" ["e0","e1"] = false := by decide
example : common m101 "e2" ["e0","e1"] = false := by decide
example : individual m101.executions o101 "e2" ["e2"] = false := by decide
example : common m101 "e2" ["e2"] = false := by decide
example : individual m101.executions o101 "e2" ["e0","e2"] = true := by decide
example : common m101 "e2" ["e0","e2"] = true := by decide
example : individual m101.executions o101 "e2" ["e1","e2"] = false := by decide
example : common m101 "e2" ["e1","e2"] = false := by decide
example : individual m101.executions o101 "e2" ["e0","e1","e2"] = true := by decide
example : common m101 "e2" ["e0","e1","e2"] = true := by decide
def o110 : Observer := ⟨"p",[("e0","1"),("e1","1"),("e2","0")]⟩
def m110 : Model := ⟨["e0","e1","e2"],[o110]⟩
example : individual m110.executions o110 "e0" [] = false := by decide
example : common m110 "e0" [] = false := by decide
example : individual m110.executions o110 "e0" ["e0"] = false := by decide
example : common m110 "e0" ["e0"] = false := by decide
example : individual m110.executions o110 "e0" ["e1"] = false := by decide
example : common m110 "e0" ["e1"] = false := by decide
example : individual m110.executions o110 "e0" ["e0","e1"] = true := by decide
example : common m110 "e0" ["e0","e1"] = true := by decide
example : individual m110.executions o110 "e0" ["e2"] = false := by decide
example : common m110 "e0" ["e2"] = false := by decide
example : individual m110.executions o110 "e0" ["e0","e2"] = false := by decide
example : common m110 "e0" ["e0","e2"] = false := by decide
example : individual m110.executions o110 "e0" ["e1","e2"] = false := by decide
example : common m110 "e0" ["e1","e2"] = false := by decide
example : individual m110.executions o110 "e0" ["e0","e1","e2"] = true := by decide
example : common m110 "e0" ["e0","e1","e2"] = true := by decide
example : individual m110.executions o110 "e1" [] = false := by decide
example : common m110 "e1" [] = false := by decide
example : individual m110.executions o110 "e1" ["e0"] = false := by decide
example : common m110 "e1" ["e0"] = false := by decide
example : individual m110.executions o110 "e1" ["e1"] = false := by decide
example : common m110 "e1" ["e1"] = false := by decide
example : individual m110.executions o110 "e1" ["e0","e1"] = true := by decide
example : common m110 "e1" ["e0","e1"] = true := by decide
example : individual m110.executions o110 "e1" ["e2"] = false := by decide
example : common m110 "e1" ["e2"] = false := by decide
example : individual m110.executions o110 "e1" ["e0","e2"] = false := by decide
example : common m110 "e1" ["e0","e2"] = false := by decide
example : individual m110.executions o110 "e1" ["e1","e2"] = false := by decide
example : common m110 "e1" ["e1","e2"] = false := by decide
example : individual m110.executions o110 "e1" ["e0","e1","e2"] = true := by decide
example : common m110 "e1" ["e0","e1","e2"] = true := by decide
example : individual m110.executions o110 "e2" [] = false := by decide
example : common m110 "e2" [] = false := by decide
example : individual m110.executions o110 "e2" ["e0"] = false := by decide
example : common m110 "e2" ["e0"] = false := by decide
example : individual m110.executions o110 "e2" ["e1"] = false := by decide
example : common m110 "e2" ["e1"] = false := by decide
example : individual m110.executions o110 "e2" ["e0","e1"] = false := by decide
example : common m110 "e2" ["e0","e1"] = false := by decide
example : individual m110.executions o110 "e2" ["e2"] = true := by decide
example : common m110 "e2" ["e2"] = true := by decide
example : individual m110.executions o110 "e2" ["e0","e2"] = true := by decide
example : common m110 "e2" ["e0","e2"] = true := by decide
example : individual m110.executions o110 "e2" ["e1","e2"] = true := by decide
example : common m110 "e2" ["e1","e2"] = true := by decide
example : individual m110.executions o110 "e2" ["e0","e1","e2"] = true := by decide
example : common m110 "e2" ["e0","e1","e2"] = true := by decide
def o111 : Observer := ⟨"p",[("e0","1"),("e1","1"),("e2","1")]⟩
def m111 : Model := ⟨["e0","e1","e2"],[o111]⟩
example : individual m111.executions o111 "e0" [] = false := by decide
example : common m111 "e0" [] = false := by decide
example : individual m111.executions o111 "e0" ["e0"] = false := by decide
example : common m111 "e0" ["e0"] = false := by decide
example : individual m111.executions o111 "e0" ["e1"] = false := by decide
example : common m111 "e0" ["e1"] = false := by decide
example : individual m111.executions o111 "e0" ["e0","e1"] = false := by decide
example : common m111 "e0" ["e0","e1"] = false := by decide
example : individual m111.executions o111 "e0" ["e2"] = false := by decide
example : common m111 "e0" ["e2"] = false := by decide
example : individual m111.executions o111 "e0" ["e0","e2"] = false := by decide
example : common m111 "e0" ["e0","e2"] = false := by decide
example : individual m111.executions o111 "e0" ["e1","e2"] = false := by decide
example : common m111 "e0" ["e1","e2"] = false := by decide
example : individual m111.executions o111 "e0" ["e0","e1","e2"] = true := by decide
example : common m111 "e0" ["e0","e1","e2"] = true := by decide
example : individual m111.executions o111 "e1" [] = false := by decide
example : common m111 "e1" [] = false := by decide
example : individual m111.executions o111 "e1" ["e0"] = false := by decide
example : common m111 "e1" ["e0"] = false := by decide
example : individual m111.executions o111 "e1" ["e1"] = false := by decide
example : common m111 "e1" ["e1"] = false := by decide
example : individual m111.executions o111 "e1" ["e0","e1"] = false := by decide
example : common m111 "e1" ["e0","e1"] = false := by decide
example : individual m111.executions o111 "e1" ["e2"] = false := by decide
example : common m111 "e1" ["e2"] = false := by decide
example : individual m111.executions o111 "e1" ["e0","e2"] = false := by decide
example : common m111 "e1" ["e0","e2"] = false := by decide
example : individual m111.executions o111 "e1" ["e1","e2"] = false := by decide
example : common m111 "e1" ["e1","e2"] = false := by decide
example : individual m111.executions o111 "e1" ["e0","e1","e2"] = true := by decide
example : common m111 "e1" ["e0","e1","e2"] = true := by decide
example : individual m111.executions o111 "e2" [] = false := by decide
example : common m111 "e2" [] = false := by decide
example : individual m111.executions o111 "e2" ["e0"] = false := by decide
example : common m111 "e2" ["e0"] = false := by decide
example : individual m111.executions o111 "e2" ["e1"] = false := by decide
example : common m111 "e2" ["e1"] = false := by decide
example : individual m111.executions o111 "e2" ["e0","e1"] = false := by decide
example : common m111 "e2" ["e0","e1"] = false := by decide
example : individual m111.executions o111 "e2" ["e2"] = false := by decide
example : common m111 "e2" ["e2"] = false := by decide
example : individual m111.executions o111 "e2" ["e0","e2"] = false := by decide
example : common m111 "e2" ["e0","e2"] = false := by decide
example : individual m111.executions o111 "e2" ["e1","e2"] = false := by decide
example : common m111 "e2" ["e1","e2"] = false := by decide
example : individual m111.executions o111 "e2" ["e0","e1","e2"] = true := by decide
example : common m111 "e2" ["e0","e1","e2"] = true := by decide
def chain : Model := ⟨["a","b","c"],[⟨"p",[("a","x"),("b","x"),("c","y")]⟩,⟨"q",[("a","x"),("b","y"),("c","y")]⟩]⟩
example : individual chain.executions ⟨"p",[("a","x"),("b","x"),("c","y")]⟩ "a" ["a","b"] = true := by decide
example : common chain "a" ["a","b"] = false := by decide
example : common chain "a" ["a","b","c"] = true := by decide
example : decision chain "outside" ["a","b","c"] = none := by decide
