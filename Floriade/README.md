# SM4 Floriade Groep 1

The Dutch Footprint will be exhibited to the public at the Floriade. On the map of the Floriade we see a huge foot that occupies an area of ​​5 hectares. Because that's how big the Dutch Footprint is. If we were to divide it fairly with the rest of the world, we would have to live on a smaller footing. 1.6 hectares to be exact. This message will be conveyed during the Floriade:

- by showing the 5 hectares with an enormous footprint on the floor plan of the Floriade
- with an information kiosk (on the boulevard near the big toe
- with information boards (2 /4)
- with an app developed by Fontys students


**This App**

_This is the iOS version_

With this app you can see a virtual foot on top of the floor plan of the Floriade in an Augmented Reality environment. You can also calculate your own ecological footprint by means of a questionnaire consisting of 12 questions.
You can also open a satellite map that you can walk through in the Floriade itself.

**Design**

This is our figma link to our design::

https://www.figma.com/file/CHPTam2uy1y4mZ4Ffkfn9b/Floriade?node-id=0%3A1

Or a link to our Design in PDF:

[Floriade.pdf](https://git.fhict.nl/I431978/sm4-floriade/-/blob/main/Floriade.pdf?expanded=true&viewer=rich)

**Starting the App**

Download this repository and unzip it.
Open the following file in Xcode:

`.../FloriadeIOS/FloriadeIOS.xcodeproj`

Here you will see the root which opens into 3 folders:
```
FloriadeIOS
FloriadeIOSTests
FloriadeIOSUITests
```

Open the root placed above the 3 folders, also called FloriadeIOS, which is the project itself.
Over here you will be able to see the project properties, and 3 targets. The 3 folders shown above are these 3 targets.

Select the folder `FloriadeIOS` and select the property "Signing & Capabilities".

Here you will have to select your own team and make use of your own bundle identifier.
When you've selected and added these properties, you will be able to build the app on your iPhone.

Plug your iPhone into your device and TRUST your device (this gives you the right to build an application on your phone).

Now building it the first time, won't open your application, you will have to give your verify your own team on your iPhone. Go to:

`Setting -> General -> VPN & Device Management`

Here you'll notice a Developer App called: "Apple Development: (your team)". Open this Developer App and Verify your App.

And done! You've got the app on your phone and you're able to build newer versions as well.
