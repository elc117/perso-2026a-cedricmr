{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

module Tipos where

import Data.Aeson (ToJSON, FromJSON)
import GHC.Generics (Generic)
import Database.SQLite.Simple (FromRow)
import Database.SQLite.Simple.FromRow (fromRow, field)

data Treino = Treino
    { treinoId      :: Int
    , data_         :: String
    , grupoMuscular :: String
    , observacao    :: String
    } deriving (Show, Eq, Generic, ToJSON, FromJSON)

instance FromRow Treino where
    fromRow = Treino <$> field <*> field <*> field <*> field

data Exercicio = Exercicio
    { exercicioId   :: Int
    , treinoIdRef   :: Int
    , nomeExercicio :: String
    , series        :: Int
    , repeticoes    :: Int
    , cargaKg       :: Double
    } deriving (Show, Eq, Generic, ToJSON, FromJSON)

instance FromRow Exercicio where
    fromRow = Exercicio <$> field <*> field <*> field <*> field <*> field <*> field