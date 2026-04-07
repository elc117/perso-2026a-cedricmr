{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import Data.Monoid(mconcat)

main :: IO ()
main = scotty 3000 $ do
  get "/" $ do
    text "isso é um teste"

  get "/:word" $ do
    beam <- pathParam "word"
    html $ mconcat ["<h1>scotty, ", beam, " me up!</h1>"]
