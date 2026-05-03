module Testes where

import Tipos
import Logica

-- Dados de exemplo
treinos :: [Treino]
treinos =
    [ Treino 1 "2026-04-01" "Peito" "Treino leve"
    , Treino 2 "2026-04-03" "Costas" ""
    , Treino 3 "2026-04-05" "Peito" "Treino pesado"
    ]

exercicios :: [Exercicio]
exercicios =
    [ Exercicio 1 1 "Supino" 3 10 60.0
    , Exercicio 2 1 "Crucifixo" 3 12 20.0
    , Exercicio 3 3 "Supino" 4 8 80.0
    , Exercicio 4 2 "Remada" 3 10 50.0
    ]

-- Testes
testeFiltrarPorGrupo :: Bool
testeFiltrarPorGrupo = length (filtrarPorGrupo "Peito" treinos) == 2

testeVolumeTreino :: Bool
testeVolumeTreino = volumeTreino [Exercicio 1 1 "Supino" 3 10 60.0] == 1800.0

testeMaiorCarga :: Bool
testeMaiorCarga = maiorCarga "Supino" exercicios == Just 80.0

testeMaiorCargaVazia :: Bool
testeMaiorCargaVazia = maiorCarga "Agachamento" exercicios == Nothing

testeBuscarPorId :: Bool
testeBuscarPorId = buscarPorId 2 treinos == Just (Treino 2 "2026-04-03" "Costas" "")

testeEvolucaoCarga :: Bool
testeEvolucaoCarga = evolucaoCarga (filter (\e -> nomeExercicio e == "Supino") exercicios) == [60.0, 80.0]

testeRecordes :: Bool
testeRecordes = recordes exercicios == [("Supino", 80.0), ("Crucifixo", 20.0), ("Remada", 50.0)]

testeFrequenciaPorGrupo :: Bool
testeFrequenciaPorGrupo = frequenciaPorGrupo treinos == [("Peito", 2), ("Costas", 1)]


main :: IO ()
main = do
    putStrLn $ "filtrarPorGrupo:    " ++ show testeFiltrarPorGrupo
    putStrLn $ "volumeTreino:       " ++ show testeVolumeTreino
    putStrLn $ "maiorCarga:         " ++ show testeMaiorCarga
    putStrLn $ "maiorCargaVazia:    " ++ show testeMaiorCargaVazia
    putStrLn $ "buscarPorId:        " ++ show testeBuscarPorId
    putStrLn $ "evolucaoCarga:      " ++ show testeEvolucaoCarga
    putStrLn $ "recordes:           " ++ show testeRecordes
    putStrLn $ "frequenciaPorGrupo: " ++ show testeFrequenciaPorGrupo