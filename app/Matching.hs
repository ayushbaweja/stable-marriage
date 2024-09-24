module Matching (stableMarriage, Person, Preference, Matching) where

import Data.List (elemIndex)
import Data.Maybe (fromJust)

type Person = Int 
type Preference = [Person]
type Matching = [(Person, Person)]

stableMarriage :: [Preference] -> [Preference] -> Matching
stableMarriage menPrefs womenPrefs = reverse (match [] (zip [0..] menPrefs) womenPrefs)

match :: Matching -> [(Person, Preference)] -> [Preference] -> Matching -- needs current state of matching, process one unmatched man at a time, and continue until all men are matched
match matching [] womenPrefs = matching -- no unmatched men
match matching ((man, manPref):restMen) womenPrefs =
    case findFreeWoman man manPref womenPrefs matching of -- case expression of
        Just woman -> match (engage man woman matching) restMen womenPrefs
        Nothing -> match matching restMen womenPrefs

findFreeWoman :: Person -> Preference -> [Preference] -> Matching -> Maybe Person
findFreeWoman _ [] _ _ = Nothing
findFreeWoman man (woman:rest) womenPrefs matching =
    case lookup woman matching of-- lookup search list
        Nothing -> Just woman -- woman is not matched
        Just currentMan -> if prefersOver woman man currentMan womenPrefs -- check if woman wants to "trade up"
                            then Just woman
                            else findFreeWoman man rest womenPrefs matching

prefersOver :: Person -> Person -> Person -> [Preference] -> Bool
prefersOver woman man1 man2 womenPrefs =
    let womanPref = womenPrefs !! (fromIntegral woman) -- extracting preference list of woman
        man1Index = fromJust $ elemIndex man1 womanPref
        man2Index = fromJust $ elemIndex man2 womanPref
    in man1Index < man2Index

engage :: Person -> Person -> Matching -> Matching
engage man woman matching =
    case lookup woman matching of
        Nothing -> (man, woman) : matching
        Just currentMan -> (man, woman) : filter (\(x, y) -> y /= woman) matching