{-# LANGUAGE LambdaCase #-}

import System.Environment (getArgs)
import System.Process (runCommand, waitForProcess)
import Data.List (intercalate)
import System.Directory (doesFileExist)
import System.Exit (ExitCode(..))

forbiddenURLs :: [String]
forbiddenURLs =
  [ "www.messenger.com",
    "messenger.com",
    "www.facebook.com",
    "facebook.com",
    "www.twitter.com",
    "twitter.com",
    "boards.4channel.org",
    "4channel.org",
    "boards.4chan.org",
    "4chan.org",
    "www.reddit.com",
    "reddit.com" ]

main :: IO ()
main = do
  args <- getArgs
  case args of
    ["1"] -> productivity
    ["0"] -> noProductivity
    [] -> putStrLn "Error: no argument"
    [_] -> putStrLn "Error: invalid argument"
    _ -> putStrLn "Error: too many arguments"

-- save the current config, redirect the forbidden URLs to localhost and flush the DNS cache
productivity :: IO ()
productivity = doesFileExist "/etc/hosts.old" >>= \case
  True -> return ()
  False -> do
    execute "cp /etc/hosts /etc/hosts.old"
    let appendix = intercalate "\\n" $ map ("127.0.0.1 " ++) forbiddenURLs
    execute $ "echo \"" ++ appendix ++ "\" >> /etc/hosts"
    execute "dscacheutil -flushcache"

-- remove the current config and restore the old one
noProductivity :: IO ()
noProductivity = doesFileExist "/etc/hosts.old" >>= \case
  False -> return ()
  True -> do
    execute "rm /etc/hosts"
    execute "mv /etc/hosts.old /etc/hosts"
    execute "dscacheutil -flushcache"

execute :: String -> IO ()
execute cmd = runCommand cmd >>= waitForProcess >>= \case
  ExitSuccess -> return ()
  ExitFailure code -> putStrLn $ "Error: " ++ (head $ words cmd) ++ " returned " ++ show code
