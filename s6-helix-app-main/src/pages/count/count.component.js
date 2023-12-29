import React from 'react';
import styles from './count.module.scss';
import axios from 'axios';
import { useState,useEffect } from 'react';
import rides_Efteling from 'data/rides.json';
import classNames from 'classnames';

const Count = () => {

  const [rides, setRides] = useState([])
  const [Orides, setORides] = useState([])
  const [active, setActive] = useState('all')
  

  useEffect(() => {
    //Get Efteling Api
    axios.get('/app/wis')
      .then(response => {
          const data = response.data.AttractionInfo.filter(rides => {
          return rides.Type == 'Attracties'});
    // Filter out the rides and combine singleriders waitingtime
        data.map((ride, index) => {
          rides_Efteling[index].WaitingTime = ride.WaitingTime
          rides_Efteling[index].State = ride.State
          if(ride.Name.includes('Single-rider')){
            rides_Efteling[index-1].WaitingTimeSingle = ride.WaitingTime
          }
        });
    // Filter out the singelriders objects
        setRides(rides_Efteling.filter(ride => {
          return ride.Name.indexOf('Single-rIder') === -1
        }));
        setORides(rides_Efteling.filter(ride => {
          return ride.Name.indexOf('Single-rIder') === -1
        }));

      })
      .catch(error => {
        console.error(error);
      });
  }, []);

  console.log(rides)
  
  return (
    <> {rides.length > 0 && (<>
      <div className={styles.wrapper}> 
      {/* filters */}
      <div className={styles.filters}>
      <p className={classNames(styles.filter, active === 'all' && styles.filter_Active)} onClick={function(){setRides(Orides); setActive('all')}}>All</p>
      <p className={classNames(styles.filter, active === 'rollercoasters' && styles.filter_Active)} onClick={function(){setRides(Orides.filter(ride => {return ride.Type === "Rollercoaster"})); setActive('rollercoasters')}}>Rollercoasters</p>
      <p className={classNames(styles.filter, active === 'darkrides' && styles.filter_Active)} onClick={function(){setRides(Orides.filter(ride => {return ride.Type === "Darkride"})); setActive('darkrides')}}>Darkrides</p>
      <p className={classNames(styles.filter, active === 'flatrides' && styles.filter_Active)} onClick={function(){setRides(Orides.filter(ride => {return ride.Type === "Flatride"})); setActive('flatrides')}}>Flatrides</p>
      </div>
      {/* Map rides */}
        {rides.map((ride) => (
          <div key={ride.Id} className={styles.rideCard}>
            <img className={styles.rideImages} src={ride.Image} alt="rideImages" />
            <div className={styles.info}>
              <h6>{ride.Name}</h6>
              <p className={styles.type}>{ride.Type}</p>
              {/* Waitingtimes */}
              <div className={styles.waitingTimes}>
                {((ride.WaitingTime || ride.WaitingTime === 0 )&& ride.State === "open") &&
                  <>
                    {ride.WaitingTimeSingle &&
                      <img className={styles.icon} src="/images/icons/icon-group.svg" alt="icon" />
                    }
                    <p className={styles.time}>{ride.WaitingTime}</p>
                    <p>&nbsp;min&nbsp;</p>

                    {ride.WaitingTimeSingle &&
                      <>
                        <img className={styles.icon} src="/images/icons/icon-single.svg" alt="icon" />
                        <p className={styles.time}>{ride.WaitingTimeSingle}</p>
                        <p>&nbsp;min&nbsp;</p>
                      </>
                    }
                  </>
                }
                {/* Maintenance exception */}
                {ride.State === "inonderhoud" &&
                  <>
                    <p>Maintenance</p>
                  </>
                }
                 {/* Closed exception */}
                {(ride.WaitingTime === undefined && ride.State === "") && 
                <>
                    <p>Closed&nbsp;</p>
                </>
                }

              </div>
            </div> 
            {/* Split count number */}
            <div className={styles.count}>
              {ride.Count.split("").map((number, index) => (
                <h3 key={index}>{number}</h3>
              ))}
            </div>
          </div>
        ))}
      </div>
    </>)}</>

  )
}


export default Count