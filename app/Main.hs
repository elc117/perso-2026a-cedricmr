{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty
import Network.Wai.Middleware.Cors
import Rotas
import Testes
import Banco
import Database.SQLite.Simple

main :: IO ()
main = do
    Testes.main
    conn <- open "diario.db"
    iniciarBanco conn
    scotty 3000 $ do
        middleware (cors (const $ Just policy))
        rotas conn
  where
    policy = simpleCorsResourcePolicy
        { corsRequestHeaders = ["Content-Type"]
        , corsMethods = ["GET", "POST"]
        }