module LineLength
    ( lengthNextLine
    , module X
    ) where

import LineLength.Class as X
import LineLength.Impl as X

lengthNextLine :: MonadGetLine m => m Int
lengthNextLine = length <$> nextLine
