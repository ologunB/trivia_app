importScripts("https://www.gstatic.com/firebasejs/7.20.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.20.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyDBouuAWouF_M988RQH-IgUDWwKchbHI_I",
  authDomain: "triviablog-78fd9.firebaseapp.com",
  projectId: "triviablog-78fd9",
  storageBucket: "triviablog-78fd9.appspot.com",
  messagingSenderId: "339747895631",
  appId: "1:339747895631:web:20ba63eaad0339a195ad3a",
  measurementId: "G-5GY6LQ5HRH"
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  console.log("onBackgroundMessage", payload);
  const notificationTitle = payload.notification.title;
  const notificationOptions = { body: payload.notification.body, icon: 'favicon.png'};

  self.registration.showNotification(notificationTitle, notificationOptions);
});

/*messaging.onMessage((payload) => {
  console.log("onMessage", payload);
  const notificationTitle = payload.notification.title;
  const notificationOptions = { body: payload.notification.body, icon: 'favicon.png'};

  self.registration.showNotification(notificationTitle, notificationOptions);
});*/


