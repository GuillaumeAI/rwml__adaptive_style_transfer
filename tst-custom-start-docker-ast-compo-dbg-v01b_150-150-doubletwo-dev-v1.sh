tdir=/a/lib/results/gia-ds-DavidBouchardGagnon-v01b-210510-864/doubletwo/150

cd /a/lib/samples/content
p=92

mkdir -p $tdir
for c in *jpg ; do gia-ast $c $p;ff=${c%.*}; mv $ff'__stylized__'* $tdir;done

