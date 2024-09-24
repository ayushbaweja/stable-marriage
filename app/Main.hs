module Main where

import Matching (stableMarriage)

main :: IO ()
main = do
    let menPrefs = [[0,1], [1,0]]
    let womenPrefs = [[1,0], [0,1]]
    let result = stableMarriage menPrefs womenPrefs
    print result