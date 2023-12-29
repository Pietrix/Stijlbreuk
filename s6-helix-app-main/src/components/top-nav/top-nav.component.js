import React from 'react';
import { useState, useEffect } from 'react';
import styles from './top-nav.module.scss';
import { useLocation } from 'react-router-dom';
import classNames from 'classnames';

const TopNav = () => {

  const [nav, setNav] = useState("default");

  const [active, setActive] = useState("");

  const location = useLocation();

  useEffect(() => {
    setActive(location.pathname.substring(1));
  }, [location])

  return (
    //logo
    <div className={classNames(styles.wrapper, (active === "trip") && styles.hidden)}>
      <img className={styles.logo} src="./images/logo-v1-blue.png" alt="Logo" />

      {/* Search */}
      {nav == "search" &&
        <img className={styles.icon} src="./images/search.svg" alt="Logo" />
      }
      {/* Edit */}
      {nav == "edit" &&
        <img className={styles.icon} src="./images/edit.svg" alt="Logo" />
      }
      {/* Add */}
      {nav == "add" &&
        <img className={styles.icon} src="./images/add.svg" alt="Logo" />
      }
      {/* leaderboard */}
      {nav == "leader" &&
        <img className={styles.icon} src="./images/leaderboard.svg" alt="Logo" />
      }

    </div>
  )
}

export default TopNav