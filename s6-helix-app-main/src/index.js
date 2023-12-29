import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import { BrowserRouter } from 'react-router-dom';

import 'styles/reset.scss';
import 'styles/theme.scss';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
    // <BrowserRouter basename='/'>
    <BrowserRouter basename='/semester6/eigen-project/helix-app'>
      <App />
    </BrowserRouter>
);