import Count from "pages/count/count.component";
import Home from "pages/home/home.component";
import Trip from "pages/trip/trip.component";
import Challenges from "pages/challenges/challenges.component";
import Profile from "pages/profile/profile.component";

import { Router, Route, Routes } from "react-router-dom";
import BottomNav from "components/bottom-nav/bottom-nav.component";
import TopNav from "components/top-nav/top-nav.component";

function App() {
  return (
    <div className="app">
      <div className="innerApp">
        {/* Router to display all the different pages */}
        <Routes>
          <Route index element={<Home />} />
          <Route path="/count" element={<Count />} />
          <Route path="/trip" element={<Trip />} />
          <Route path="/challenges" element={<Challenges />} />
          <Route path="/profile" element={<Profile />} />
        </Routes>
      </div>
      <TopNav />
      <BottomNav />
    </div>
  );
}

export default App;
