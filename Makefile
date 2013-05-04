
FAY_BASE=../fay/cabal-dev
FAY_TEXT=${FAY_BASE}/share/fay-text-0.1.0.0/src/
FAY=${FAY_BASE}/bin/fay -p --include ${FAY_TEXT}

all:
	${FAY} *.hs
