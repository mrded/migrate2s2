import Options.Applicative
import Data.Semigroup ((<>))

data Args = Args
  { database   :: String 
  , host       :: String
  , port       :: Int
  , user       :: String
  , password   :: String }

args :: Parser Args
args = Args
      <$> strOption
          ( long "database"
         <> short 'D'
         <> help "Database to use."
         <> metavar "name" )
      <*> strOption
          ( long "host"
         <> short 'h'
         <> help "Connect to host."
         <> showDefault
         <> value "localhost"
         <> metavar "name" )
      <*> option auto
          ( long "port"
         <> short 'P'
         <> help "Port number to use for connection."
         <> showDefault
         <> value 3306
         <> metavar "#" )
      <*> strOption
          ( long "user"
         <> short 'u'
         <> help "user for login."
         <> showDefault
         <> value "root"
         <> metavar "name" )
      <*> strOption
          ( long "password"
         <> short 'p'
         <> help "Password to use when connecting to server."
         <> showDefault
         <> value "root"
         <> metavar "name" )

main :: IO ()
main = greet =<< execParser opts
  where
    opts = info (args <**> helper)
      ( fullDesc <> progDesc "Migrates images to S3" )

greet :: Args -> IO ()
greet (Args database host user password port) = putStrLn $ "Connecting to "
         ++ host
         ++ ":"
         ++ port 
         ++ "/" 
         ++ database

greet _ = return ()
