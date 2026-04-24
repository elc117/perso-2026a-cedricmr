{-# LANGUAGE OverloadedStrings #-}

module Rotas where

import Web.Scotty

rotas :: ScottyM ()
rotas = do
    get "/" $ do
        text "Diário de Treinos API funcionando!"