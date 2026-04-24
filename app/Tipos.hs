module Tipos where

data Treino = Treino
    { treinoId       :: Int
    , data_          :: String
    , grupoMuscular  :: String
    , observacao     :: String
    } deriving (Show, Eq)

data Exercicio = Exercicio
    { exercicioId    :: Int
    , treinoIdRef    :: Int
    , nomeExercicio  :: String
    , series         :: Int
    , repeticoes     :: Int
    , cargaKg        :: Double
    } deriving (Show, Eq)