{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty
import Rotas
import Testes
import Banco
import Database.SQLite.Simple

main :: IO ()
main = do
    Testes.main
    conn <- open "diario.db"
    iniciarBanco conn
    scotty 3000 (rotas conn)