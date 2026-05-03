{-# LANGUAGE OverloadedStrings #-}

module Rotas where

import Web.Scotty
import Data.Aeson (toJSON)
import Tipos
import Logica
import Banco
import Network.HTTP.Types.Status (status404)
import Database.SQLite.Simple

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

rotas :: Connection -> ScottyM ()
rotas conn = do
    get "/treinos" $ do
        treinos <- liftIO (buscarTreinos conn)
        json (toJSON treinos)

    get "/treinos/:id" $ do
        tid <- pathParam "id"
        treinos <- liftIO (buscarTreinos conn)
        case buscarPorId tid treinos of
            Nothing -> do
                status status404
                json ("Treino não encontrado" :: String)
            Just treino -> json (toJSON treino)

    get "/treinos/:id/exercicios" $ do
        tid <- pathParam "id"
        exercicios <- liftIO (buscarExercicios conn tid)
        json (toJSON exercicios)

    post "/treinos" $ do
        treino <- jsonData
        liftIO (inserirTreino conn treino)
        json (toJSON (treino :: Treino))
