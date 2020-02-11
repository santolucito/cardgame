{-# LANGUAGE LambdaCase #-}

import Graphics.Shine
import Graphics.Shine.Input
import Graphics.Shine.Picture

import GHCJS.DOM (currentDocumentUnchecked)
import GHCJS.DOM.Window 
import GHCJS.DOM.Document

import FullCanvas
import GraphicsHelpers
import qualified Card as C

import System.Random

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
      initialState = True
      draw False = Empty
      draw True = renderHand p1 <> (Translate 0 300 $ renderHand p2)
      handleInput (MouseBtn BtnLeft Down _) = const True
      handleInput (MouseBtn BtnLeft Up _) = const True
      handleInput _ = id
      step _ = id

    play ctx doc 30 initialState draw handleInput step

cardSizeX = 60

renderHand :: C.Hand -> Picture
renderHand hand = Translate 40 60 $ mconcat $
   (zipWith (renderCard 0) [0, (floor $ cardSizeX+10)..] $ map fst hand)
   ++
   (zipWith (renderCard 120) [0, (floor $ cardSizeX+10)..] $ map snd hand)
    
renderCard :: Int -> Int -> C.Card -> Picture
renderCard y x card = let
   faceUpDisp = (Colored black (Rect cardSizeX 100))
     <> (Colored (toJSColor $ C.color card) $ Translate (-10) (-20) (simpleText $ show $ C.value card))
   faceDownDisp = (Colored black (RectF cardSizeX 100)) 
 in Translate (fromIntegral x) (fromIntegral y) $
   if C.isFaceUp card then faceUpDisp else faceDownDisp

toJSColor :: C.CardColor -> Color
toJSColor = \case 
  C.Red -> red
  C.Black -> black

