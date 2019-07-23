{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}

module Lib where

import GHC.Generics
import Data.Aeson


import Aws.Lambda
import qualified Data.ByteString.Lazy.Char8 as ByteString

data GET
data POST
data HttpMethod = POST | GET

parseHttpMethod :: String -> Maybe HttpMethod
parseHttpMethod "GET" = Just GET
parseHttpMethod "POST" = Just POST
parseHttpMethod _ = Nothing



data APIGatewayRequest = APIGatewayRequest
  { resource :: String
  -- , path :: ByteString
  , httpMethod :: String
  -- , headers :: RequestHeaders
  -- , queryStringParameters :: [(ByteString, Maybe ByteString)]
  -- , pathParameters :: HashMap String String
  -- , stageVariables :: HashMap String String
  , body :: String
  } deriving (Generic, FromJSON)
  
data Person = Person
  { personName :: String
  , personAge :: Int
  } deriving (Generic)
instance FromJSON Person
instance ToJSON Person

-- handler :: Person -> Context -> IO (Either String Person)
-- handler person context =
--   if personAge person > 0 then
--     return (Right person)
--   else
--     return (Left "A person's age must be positive")


handler :: APIGatewayRequest -> Context -> IO (Either String Person)
handler request context =
  case parseHttpMethod (httpMethod request) of
    Just POST -> return (Left "Posted")
    Just GET -> return (Left "Gotter")
    Nothing -> return (Left "Dunno")