
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
      p1Init = C.drawHand g
      g' = snd $ next g
      p2Init = C.drawHand g'
      initialState = (True, 0, 0, p1Init, p2Init)
      draw (_, x, y, p1, p2) = renderHand p1 <> (Translate 0 300 $ renderHand p2) <> (Translate 500 500 $ simpleText $ show x ++ " " ++ show y)
      step _ = id

    play ctx doc 30 initialState draw handleInput step

handleInput (MouseBtn BtnLeft Down _) (_, x, y) = (False, x, y)
handleInput (MouseBtn BtnLeft Up _) (_, x, y) = (True, x, y)
handleInput (MouseMove (x, y)) (s, _, _) = (s, x, y)
handleInput _ s = s
