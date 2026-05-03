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

exerciciosMock :: [Exercicio]
exerciciosMock =
    [ Exercicio 1 1 "Supino" 3 10 60.0
    , Exercicio 2 1 "Crucifixo" 3 12 20.0
    , Exercicio 3 3 "Supino" 4 8 80.0
    , Exercicio 4 2 "Remada" 3 10 50.0
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
    
    get "/treinos/:id/exercicios" $ do
        tid <- pathParam "id"
        json (toJSON (exerciciosDeTreino tid exerciciosMock))

    post "/treinos" $ do
        treino <- jsonData
        json (toJSON (treino :: Treino))    

