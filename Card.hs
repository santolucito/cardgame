module Card where

import Data.Char
import System.Random

--use random to get a card
-- assign the id randomly, not a great idea, but will work for now until we migrate the objectMap to a monad
drawCard :: Face -> Int -> Card
drawCard upOrDown i = Card {
    color = toEnum (i `mod` 2)
  , face = upOrDown
  , suit  = toEnum (i `mod` 4)
  , value = (i `mod` 13) + 1 
  , cardId = i }

drawHand :: StdGen -> Hand
drawHand g = let
  front = zip [Up, Down, Up, Down] $ take 4 cardSeeds
  back = zip [Down, Up, Down, Up] $ drop 4 cardSeeds
  cardSeeds = take 8 $ randoms g
  getRow which = map (uncurry drawCard) $ which 
 in
  zip (getRow front) (getRow back)

type Hand = [(Card, Card)]
data CardColor = Red | Black 
              deriving (Eq, Enum, Show)
data Face = Up | Down
              deriving (Eq, Enum, Show)
data Suit = Spades | Diamonds | Hearts | Clubs
              deriving (Eq, Enum, Show)

--given a card datatype
data Card = Card { color :: CardColor
                 , face :: Face
                 , suit :: Suit
                 , value :: Int 
                 , cardId :: Int}
              deriving (Eq)

instance Show Card where
  show c = let 
     v = if isFaceDown c then "?" else show $ value c
    in
      "-----\n" ++
      "| "++v++" |\n" ++
      "-----\n" 

displayHand h = 
  concatMap (show. fst) h ++ "\n" ++
  concatMap (show. snd) h 

instance Ord Card where
  compare c1 c2 = compare (value c1) (value c2)

isFaceDown :: Card -> Bool
isFaceDown = (==) Down . face
isFaceUp :: Card -> Bool
isFaceUp = not. isFaceDown 

isRed :: Card -> Bool
isRed = (==) Red . color
isBlack :: Card -> Bool
isBlack = not. isRed

faceUp card = card { face = Up } 
faceDown card = card { face = Down } 
flipOver card = 
  if (face card == Down)
  then card { face = Up }
  else card { face = Down }

