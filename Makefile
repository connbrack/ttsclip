
name=ttsclip

all: package clean

package: $(name).sh control
	mkdir $(name)
	mkdir $(name)/DEBIAN
	mkdir $(name)/usr
	mkdir $(name)/usr/bin
	cp $(name).sh $(name)/usr/bin/$(name)
	cp control $(name)/DEBIAN/
	dpkg-deb --build $(name)

clean:
	rm -r $(name)




