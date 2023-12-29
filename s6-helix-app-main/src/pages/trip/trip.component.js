import React, { useRef, useState, useEffect, useCallback } from 'react';
import styles from './trip.module.scss';
import { divIcon, map } from 'leaflet';
import { renderToStaticMarkup } from 'react-dom/server';
import { MapContainer, TileLayer, Marker, useMap, Polyline, Popup } from 'react-leaflet';
import { useNavigate } from 'react-router-dom';
import Draggable from 'react-draggable';
import Webcam from 'react-webcam';
import classNames from 'classnames';

// Basic markers to show on map
const markers = [
  {
    "lat": 51.649860,
    "lng": 5.043642,
    "img": "./images/trip/entrance.jpg",
    "place": "Huys van de Vijf Zintuigen"
  },
  {
    "lat": 51.648016,
    "lng": 5.050261,
    "img": "./images/trip/baron.jpg",
    "place": "Baron 1898"
  }
];

// Array for all the inputs from the check-in page
const inputsNewCheckIn = [
  {
    "type": "location"
  },
  {
    "type": "description"
  }
]

// All locations to choose from when checking in
const locations = [
  {
    "lat": 51.652449,
    "lng": 5.045592,
    "img": "./images/trip/droomvlucht.jpg",
    "place": "Droomvlucht"
  },
  {
    "lat": 51.647176,
    "lng": 5.053299,
    "img": "./images/trip/python.jpg",
    "place": "Python"
  },
  {
    "lat": 51.652009,
    "lng": 5.052521,
    "img": "./images/trip/vogel-rok.jpg",
    "place": "Vogel Rok"
  }
]

const Trip = () => {
  const navigate = useNavigate();
  const ref = useRef(null);
  const [heightOverlay, setHeightOverlay] = useState(0);

  const [active, setActive] = useState("Trip");
  const [checkIn, setCheckIn] = useState(false);
  const [openCamera, setOpenCamera] = useState(false);
  const [tripInput, setTripInput] = useState(inputsNewCheckIn);
  const [allMarks, setAllMarks] = useState(markers);
  const [allLatLng, setAllLatLng] = useState([]);

  // Get height from overlay menu (bottom of the screen) and set variable with that height
  useEffect(() => {
    if (!ref?.current?.clientHeight) {
      return;
    }
    setHeightOverlay(ref?.current?.clientHeight);
  }, [ref?.current?.clientHeight]);

  // Render all markers
  const Markers = () => {
    const map = useMap();
    return (
      // Map all markers in the array
      allMarks.map((marker, key) => (
        <Marker
          icon={createIcon(marker.img)}
          position={[marker.lat, marker.lng]}
          key={key} eventHandlers={{
            click: () => {
              map.setView(
                [
                  marker.lat,
                  marker.lng
                ],
                17
              );
            }
          }}>
          <Popup className={styles.popup}>
            <img src={marker.img} />
            <p>{marker.place}</p>
          </Popup>
        </Marker>
      )))
  }

  // Function to create the icons to display on the map with leaflet
  function createIcon(_iconImg) {
    return divIcon({
      html: renderToStaticMarkup((<div className={styles.icon}><img src={_iconImg} /></div>)),
      iconAnchor: [25, 25]
    })
  }



  // Update array value when input value changes
  function changeValue(targetValue, type) {
    const newCheck = tripInput.map((input) => {
      // Check if the type is the same as the input
      if (input.type === type) {
        // Return old value from array and update with new value
        return {
          ...input,
          value: targetValue
        }
      }
      // Return the array if type is not the same
      else {
        return {
          ...input
        }
      }
    })
    // Set the new array to variable
    setTripInput(newCheck)
  }

  // Function to open or close the camera overlay
  function OpenCamera() {
    // Check if all the inputs are filled in
    tripInput.map((input) => {
      if (input.value) {
        setOpenCamera(true);
        setCheckIn(false)
      } else {
        setOpenCamera(false);
        setCheckIn(false);
      }
    })
  }

  // Get all the latitudes and longitudes from all the markers
  useEffect(() => {
    let latLng = [];
    allMarks.map((mark) => {
      latLng.push([mark.lat, mark.lng])
    })
    setAllLatLng(latLng);
  }, [allMarks])

  // Function to create the photo and place the marker on the map
  const cameraRef = useRef(null);
  const addImage = () => {
    if (cameraRef.current) {
      // Create photo
      const photo = cameraRef.current.getScreenshot();
      setOpenCamera(false);

      // Checck if value from location selector is the same as one of the options in the locations array
      locations.map((location) => {
        if (tripInput[0].value === location.place) {
          // If it is the same than add a marker with the values from that place to the markers array. Also add the photo to the array
          setAllMarks(allMarks.concat({
            "lat": location.lat,
            "lng": location.lng,
            "img": photo,
            "place": location.place
          }))
        }
      })
    }
  }

  return (
    <div className={styles.trip}>
      <div className={styles.topBar}>
        <img src="images/icons/icon-back.svg" onClick={() => navigate(-1)} alt="" />
        <h5>My trip to Efteling</h5>
      </div>
      {/* Map component */}
      <MapContainer center={[51.65, 5.05]} zoom={15} scrollWheelZoom={true} className={styles.map} zoomControl={false}>
        <TileLayer
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        />
        <Markers />
        <Polyline pathOptions={{ color: 'white', weight: 6, dashArray: "10 15" }} positions={allLatLng} />
      </MapContainer>
      {/* Draggable overlay menu */}
      <Draggable
        cancel='strong'
        axis='y'
        // Assign bounds to draggable component so it won't allow users to drag it of position
        bounds={
          {
            bottom: window.innerHeight - 40,
            top: (heightOverlay > (window.innerHeight - 300)) ? 300 : (window.innerHeight - heightOverlay)
          }
        }
        // Assign a default position
        defaultPosition={
          {
            x: 0,
            y: (window.innerHeight - 40)
          }
        }
      >
        <div ref={ref} className={styles.overlay}>
          <strong className={styles.addLocation} onClick={() => setCheckIn(true)}>
            <img src="./images/icons/icon-add-location.svg" alt="" />
          </strong>
          <div className={styles.overlayTop}>
            <strong className={styles.navigation}>
              <p className={active === "Trip" ? styles.active : ""} onClick={(clicked) => setActive(clicked.target.innerHTML)}>Trip</p>
              <p className={active === "Gallery" ? styles.active : ""} onClick={(clicked) => setActive(clicked.target.innerHTML)}>Gallery</p>
              <p className={active === "Stats" ? styles.active : ""} onClick={(clicked) => setActive(clicked.target.innerHTML)}>Stats</p>
              <span className={styles.indicator} />
            </strong>
          </div>
          <strong className={styles.innerOverlay}>
            {/* Check which tab in the menu is active and display that tab */}
            {active === "Trip" &&
              <div className={classNames(styles.tripInfo, styles.inside)}>
                Lorem ipsum dolor, sit amet consectetur adipisicing elit. Neque eius quia pariatur voluptates dolorum velit vitae, delectus ex, asperiores perspiciatis, non ut aliquid ipsam ad officia sint tempore. Eum, voluptatem?
              </div>
            }
            {active === "Gallery" &&
              <div className={classNames(styles.tripGallery, styles.inside)}>
                {allMarks.map((mark, index) => (
                  <img src={mark.img} alt={index} key={index} className={styles.tripImg} />
                ))}
              </div>
            }
            {active === "Stats" &&
              <div className={classNames(styles.tripStats, styles.inside)}>
                Lorem ipsum dolor, sit amet consectetur adipisicing elit. Neque eius quia pariatur voluptates dolorum velit vitae, delectus ex, asperiores perspiciatis, non ut aliquid ipsam ad officia sint tempore. Eum, voluptatem?
              </div>
            }
          </strong>
        </div>
      </Draggable>

      {/* Check if the button to add a check in is pushed and open this overlay */}
      {checkIn &&
        <div className={styles.checkIn}>
          <h3>New check-in:</h3>
          <h4 onClick={() => setCheckIn(false)}>X</h4>
          <div className={styles.form}>
            <div className={styles.input} >
              <p>Location: *</p>
              <select defaultValue={"DEFAULT"} onChange={(event) => changeValue(event.target.value, "location")}>
                <option value="DEFAULT" hidden disabled>Choose location...</option>
                {/* Map all options from array */}
                {locations.map((location, index) => (
                  <option value={location.place} key={index}>{location.place}</option>
                ))}
              </select>
            </div>
            <div className={styles.input}>
              <p>Description: *</p>
              <input type="text" onChange={(event) => changeValue(event.target.value, "description")} />
            </div>
          </div>

          <div className={styles.addCheck} onClick={() => OpenCamera()}>
            <img src="./images/icons/icon-add-location.svg" alt="" />
          </div>
        </div>
      }
      {/* Check if the camera needs to be openend to create a picture to add to the check in */}
      {openCamera &&
        <div className={styles.cameraWrapper}>
          {/* Camera component */}
          <Webcam
            audio={false}
            ref={cameraRef}
            screenshotFormat="image/jpeg"
            className={styles.camera}
            height={window.innerHeight}
            width={window.innerWidth}
            forceScreenshotSourceSize
            videoConstraints={{ height: window.innerHeight, width: window.innerWidth, facingMode: 'environment' }}
          />
          {/* Create photo on click */}
          <div onClick={() => addImage()} className={styles.cameraButton} />
        </div>
      }
    </div>
  )
}

export default Trip