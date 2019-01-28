{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module LineLength.Impl where

import Control.Monad.IO.Class

import LineLength.Class

newtype GetLineT m a = GetLineT {runGetLineT :: m a}
  deriving (Functor, Applicative, Monad, MonadIO)

instance MonadIO m => MonadGetLine (GetLineT m) where
  nextLine = liftIO getLine
