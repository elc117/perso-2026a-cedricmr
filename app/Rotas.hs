{-# LANGUAGE OverloadedStrings #-}

module Rotas where

import Web.Scotty
import Data.Aeson (toJSON)
import Tipos
import Logica
import Network.HTTP.Types.Status (status404)

-- Dados simulados
treinosMock :: [Treino]
treinosMock =
    [ Treino 1 "2026-04-01" "Peito" "Treino leve"
    , Treino 2 "2026-04-03" "Costas" ""
    , Treino 3 "2026-04-05" "Peito" "Treino pesado"
    ]

rotas :: ScottyM ()
rotas = do
    get "/treinos" $ do
        json (toJSON treinosMock)

    get "/treinos/:id" $ do
        tid <- pathParam "id"
        case buscarPorId tid treinosMock of
            Nothing -> do
                status status404
                json ("Treino não encontrado" :: String)
            Just treino -> json (toJSON treino)

