module LineLength.Class where

class Monad m => MonadGetLine m where
  nextLine :: m String
