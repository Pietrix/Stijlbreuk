import React, { useState, useEffect } from 'react';
import styles from './bottom-nav.module.scss';
import { Link, useLocation } from 'react-router-dom';
import classNames from 'classnames';

const BottomNav = () => {
  const [active, setActive] = useState("");

  const location = useLocation();

  // Get the current pathname and set the active page with the curretnt path without the "/" (substring(1))
  useEffect(() => {
    setActive(location.pathname.substring(1));
  }, [location])

  return (
    <div className={classNames(styles.wrapper, (active === "trip") && styles.hidden)}>
      {/* Change the icon when the page is active */}
      <Link to="/"><img className={styles.icon} src={active === "" ? "./images/icons/icon-home-active.svg" : "./images/icons/icon-home.svg"} alt="" /></Link>
      <Link to="/count"><img className={styles.icon} src={active === "count" ? "./images/icons/icon-count-active.svg" : "./images/icons/icon-count.svg"} alt="" /></Link>
      <Link to="/trip">
        <div className={classNames(styles.trip, active === "trip" && styles.tripActive)}>
          <img className={styles.icon} src="./images/icons/icon-trip.svg" alt="" />
        </div>
      </Link>
      <Link to="/challenges"><img className={styles.icon} src={active === "challenges" ? "./images/icons/icon-challenge-active.svg" : "./images/icons/icon-challenge.svg"} alt="" /></Link>
      <Link to="/profile"><img className={styles.icon} src={active === "profile" ? "./images/icons/icon-profile-active.svg" : "./images/icons/icon-profile.svg"} alt="" /></Link>
    </div>
  )
}

export default BottomNav