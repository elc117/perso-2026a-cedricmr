{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

module Tipos where

import Data.Aeson (ToJSON, FromJSON)
import GHC.Generics (Generic)

data Treino = Treino
    { treinoId      :: Int
    , data_         :: String
    , grupoMuscular :: String
    , observacao    :: String
    } deriving (Show, Eq, Generic, ToJSON, FromJSON)

data Exercicio = Exercicio
    { exercicioId   :: Int
    , treinoIdRef   :: Int
    , nomeExercicio :: String
    , series        :: Int
    , repeticoes    :: Int
    , cargaKg       :: Double
    } deriving (Show, Eq, Generic, ToJSON, FromJSON)