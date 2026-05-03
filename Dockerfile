FROM haskell:9.6.7

WORKDIR /app

COPY haskell-server.cabal .
RUN cabal update && cabal build --only-dependencies

COPY . .
RUN cabal build

RUN cp $(cabal list-bin haskell-server) /app/haskell-server-exe

EXPOSE 3000

CMD ["/app/haskell-server-exe"]