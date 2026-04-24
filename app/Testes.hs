module Testes where

import Tipos
import Logica

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

testeFiltrarPorGrupo :: Bool
testeFiltrarPorGrupo = length (filtrarPorGrupo "Peito" treinos) == 2

testeVolumeTreino :: Bool
testeVolumeTreino = volumeTreino [Exercicio 1 1 "Supino" 3 10 60.0] == 1800.0

testeMaiorCarga :: Bool
testeMaiorCarga = maiorCarga "Supino" exercicios == Just 80.0

testeMaiorCargaVazia :: Bool
testeMaiorCargaVazia = maiorCarga "Agachamento" exercicios == Nothing

main :: IO ()
main = do
    putStrLn $ "filtrarPorGrupo: " ++ show testeFiltrarPorGrupo
    putStrLn $ "volumeTreino:    " ++ show testeVolumeTreino
    putStrLn $ "maiorCarga:      " ++ show testeMaiorCarga
    putStrLn $ "maiorCargaVazia: " ++ show testeMaiorCargaVazia