

BURPJAR=imagelocationscanner_burp.jar


# If we let eclipse build for me.  Probably a better way.
BIN=$(HOME)/proj/eclipse-workspace/burp_image_scan/bin


$(BURPJAR): 
	mkdir -p burp-build
	cd burp-build ; unzip -q ../lib/metadata-extractor-2.8.1.jar ; cd ..
	cd burp-build ; unzip -q ../lib/xmpcore-5.1.2.jar ; cd ..
	#cp -r $(BIN)/* burp-build
	cp BappManifest.bmf burp-build
	cp BappManifest.html burp-build
	cp LICENSE burp-build
	cd burp-build ; zip -q -r ../$(BURPJAR) META-INF org burp com ; cd ..
	cd src ; zip -q -u ../$(BURPJAR) burp/*.class com/veggiespam/imagelocationscanner/*.class ; cd ..


compile:
	javac -classpath lib/metadata-extractor-2.8.1.jar:lib/xmpcore-5.1.2.jar \
		src/burp/*.java \
		src/com/veggiespam/imagelocationscanner/ILS.java


do_not_use: 
	# 
	rm -rf dest
	mkdir dest
	cp -R $(BIN)/com $(BIN)/burp dest
	cd dest ; unzip ../metadata-extractor-2.8.1.jar ; cd ..
	touch x

	

clean:
	rm -rf $(BURPJAR) burp-build
	find . -name \*.class -exec rm {} \;


run:
	java -classpath $(BURPJAR) com.veggiespam.imagelocationscanner.ILS
