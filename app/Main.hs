module Main where

import LineLength

main :: IO ()
main = print =<< runGetLineT lengthNextLine
