module Logica where

import Tipos


-- Filtra por grupo muscular
filtrarPorGrupo :: String -> [Treino] -> [Treino]
filtrarPorGrupo grupo = filter (\t -> grupoMuscular t == grupo)

-- Volume total: series * reps * carga
volumeTreino :: [Exercicio] -> Double
volumeTreino exercicios = foldl (\acc e -> acc + fromIntegral (series e * repeticoes e) * cargaKg e) 0 exercicios

-- Maior carga de um exercício
maiorCarga :: String -> [Exercicio] -> Maybe Double
maiorCarga nome exercicios =
    let filtrados = filter (\e -> nomeExercicio e == nome) exercicios
    in case filtrados of
        [] -> Nothing
        xs -> Just $ maximum $ map cargaKg xs

-- Busca treino por id
buscarPorId :: Int -> [Treino] -> Maybe Treino
buscarPorId treinoId_ treinos =
    let filtrados = filter (\t -> treinoId t == treinoId_) treinos
    in if null filtrados
        then Nothing
        else Just (head filtrados)