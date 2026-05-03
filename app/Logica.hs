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

-- Busca exercicios de um treino
exerciciosDeTreino :: Int -> [Exercicio] -> [Exercicio]
exerciciosDeTreino tid = filter (\e -> treinoIdRef e == tid)

-- Evolução de carga de um exercício
evolucaoCarga :: [Exercicio] -> [Double]
evolucaoCarga exercicios = map cargaKg exercicios

-- Recordes por exercicio (nome, maior carga)
recordes :: [Exercicio] -> [(String, Double)]
recordes exercicios =
    let nomes = map nomeExercicio exercicios
        unicos = foldl (\acc n -> if n `elem` acc then acc else acc ++ [n]) [] nomes
    in map (\n -> (n, maybe 0 id (maiorCarga n exercicios))) unicos


-- Quantidade de treinos por grupo muscular
frequenciaPorGrupo :: [Treino] -> [(String, Int)]
frequenciaPorGrupo treinos =
    let grupos = map grupoMuscular treinos
        unicos = foldl (\acc g -> if g `elem` acc then acc else acc ++ [g]) [] grupos
    in map (\g -> (g, length (filtrarPorGrupo g treinos))) unicos