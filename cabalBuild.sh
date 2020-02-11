cabal v2-build --ghcjs -w /opt/ghcjs/8.4/bin/ghcjs && 
rm -r ~/Downloads/ghcjsBuild/ && 
cp -r dist-newstyle/build/x86_64-linux/ghcjs-8.4.0.1/cardgame-0.1.0.0/x/cardgame/build/cardgame/cardgame.jsexe/ ~/Downloads/ghcjsBuild/ &&
cp -r dist-newstyle/build/x86_64-linux/ghcjs-8.4.0.1/cardgame-0.1.0.0/x/cardgame/build/cardgame/cardgame.jsexe/* AppDist/www/ghcjs &&echo "built"
