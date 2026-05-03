
{-# LANGUAGE OverloadedStrings #-}

module Banco where

import Database.SQLite.Simple

import Tipos



iniciarBanco :: Connection -> IO ()
iniciarBanco conn = do
    execute_ conn
        "CREATE TABLE IF NOT EXISTS treinos \
        \(id INTEGER PRIMARY KEY AUTOINCREMENT, \
        \data TEXT NOT NULL, \
        \grupo_muscular TEXT NOT NULL, \
        \observacao TEXT)"
    execute_ conn
        "CREATE TABLE IF NOT EXISTS exercicios \
        \(id INTEGER PRIMARY KEY AUTOINCREMENT, \
        \treino_id INTEGER NOT NULL, \
        \nome TEXT NOT NULL, \
        \series INTEGER NOT NULL, \
        \repeticoes INTEGER NOT NULL, \
        \carga_kg REAL NOT NULL)"


inserirTreino :: Connection -> Treino -> IO ()
inserirTreino conn treino =
    execute conn
        "INSERT INTO treinos (data, grupo_muscular, observacao) VALUES (?, ?, ?)"
        (data_ treino, grupoMuscular treino, observacao treino)


buscarTreinos :: Connection -> IO [Treino]
buscarTreinos conn =
    query_ conn "SELECT id, data, grupo_muscular, observacao FROM treinos"


buscarExercicios :: Connection -> Int -> IO [Exercicio]
buscarExercicios conn tid =
    query conn "SELECT id, treino_id, nome, series, repeticoes, carga_kg FROM exercicios WHERE treino_id = ?" (Only tid)