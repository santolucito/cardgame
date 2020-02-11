module FullCanvas (actualFullScreenCanvas) where

import Graphics.Shine

import GHCJS.DOM.CanvasRenderingContext2D
import GHCJS.DOM.Document (getBody)
import GHCJS.DOM.NonElementParentNode (getElementById)
import GHCJS.DOM.Element (setInnerHTML)
import GHCJS.DOM.Types (JSM, Element, MouseEvent, IsDocument, Document)


customAttributesCanvas :: Document -> String -> JSM CanvasRenderingContext2D
customAttributesCanvas doc attrs = do
    Just body <- getBody doc
    setInnerHTML body canvasHtml
    Just c <- getElementById doc "canvas"
    toContext c
  where canvasHtml :: String
        canvasHtml = "<canvas id=\"canvas\" " ++ attrs ++ " </canvas> "

actualFullScreenCanvas :: Document -> JSM CanvasRenderingContext2D
actualFullScreenCanvas doc = customAttributesCanvas doc attributes
  where attributes :: String
        attributes = "style=\"border:1px solid #000000; width:100%; height:100%; top:0px;bottom:0px;left:0px;right:0px;\""

