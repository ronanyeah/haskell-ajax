{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

module Lib
    ( go
    ) where

import Data.Aeson
import Data.Text
import qualified Data.ByteString.Lazy as B
import Network.HTTP.Conduit (simpleHttp)
import GHC.Generics

data Post =
  Post { id     :: Int
       , userId :: Int
       , title  :: Text
       , body   :: Text
         } deriving (Show,Generic)

instance FromJSON Post
instance ToJSON Post

jsonURL :: String
jsonURL = "https://jsonplaceholder.typicode.com/posts/1"

getJSON :: IO B.ByteString
getJSON = simpleHttp jsonURL

go = do
 d <- (eitherDecode <$> getJSON) :: IO (Either String Post)
 case d of
  Left err -> putStrLn err
  Right ps -> print ps
