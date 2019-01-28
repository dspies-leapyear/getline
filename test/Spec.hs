{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE LambdaCase #-}

import           Control.Monad.IO.Class
import           Control.Monad.State            ( StateT
                                                , evalStateT
                                                )
import qualified Control.Monad.State           as State
import           Test.Hspec

import           LineLength

main :: IO ()
main = hspec spec

spec :: Spec
spec =
  describe "lengthNextLine" $ it "should get the length of the next line" $ do
    result <- runMockGetLineT ["hello world!"] lengthNextLine
    result `shouldBe` 12

newtype MockGetLineT m a = MockGetLineT (StateT [String] m a)
  deriving (Functor, Applicative, Monad)

instance Monad m => MonadGetLine (MockGetLineT m) where
  nextLine = MockGetLineT $ State.get >>= \case
    []       -> error "No more lines"
    (x : xs) -> do
      State.put xs
      return x

runMockGetLineT :: Monad m => [String] -> MockGetLineT m a -> m a
runMockGetLineT allLines (MockGetLineT act) = evalStateT act allLines
