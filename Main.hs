
import Graphics.Shine
import Graphics.Shine.Input
import Graphics.Shine.Picture

import GHCJS.DOM (currentDocumentUnchecked)
import GHCJS.DOM.Window 
import GHCJS.DOM.Document

import FullCanvas
import GraphicsHelpers
import qualified Card as C
import CardRender

import System.Random
import Data.Map as M

main :: IO ()
main = do
    doc <- currentDocumentUnchecked
    win <- getDefaultViewUnchecked doc
    width <- getInnerWidth win
    height <- getInnerHeight win 
    ctx <- fixedSizeCanvas doc width height 

    let 
      g = mkStdGen 9 
      p1 = C.drawHand g
      g' = snd $ next g
      p2 = C.drawHand g'
      initialState = (True, 0, 0)
      draw (False, _, _) = Empty
      draw (True, x, y) = renderHand p1 <> (Translate 0 300 $ renderHand p2) <> (Translate 500 500 $ simpleText $ show x ++ " " ++ show y)
      handleInput (MouseBtn BtnLeft Down _) (_, x, y) = (False, x, y)
      handleInput (MouseBtn BtnLeft Up _) (_, x, y) = (True, x, y)
      handleInput (MouseMove (x, y)) (s, _, _) = (s, x, y)
      handleInput _ s = s
      step _ = id

    play ctx doc 30 initialState draw handleInput step

-- the objectMap keeps track of the position (everything has a rectangle bounding box) of every game object
-- this is used to calculate which object 
-- ideally would stick this in a state monad so every time an object is created it automatically gets stuck in here
objectMap :: M.Map (Int, Int, Int, Int) GameObject
objectMap = undefined

data GameObject = GameObject {
    objId :: Int
  , collisionBox :: (Int, Int, Int, Int) }
  
