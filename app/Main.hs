{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty
import Rotas
import Testes

main :: IO ()
main = do
    Testes.main
    scotty 3000 rotas