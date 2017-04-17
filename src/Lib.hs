module Lib
    ( get
    ) where

import Network.HTTP.Conduit

get :: String -> IO ()
get url = simpleHttp url >>= print
