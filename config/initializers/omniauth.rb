Rails.application.config.middleware.use OmniAuth::Builder do
   # provider :twitter, "i0KU4jLYYjWzxpTraWviw", "djMu7QStnBK89MkfIg78tIZ4sFhmGOYjdCjDD0Wsc"
   # provider :google_oauth2, ENV['129207227761-e3p1hkk4gaakn3s6prrhjmr5vg1fsr60.apps.googleusercontent.com'], ENV['zIk4MEfpz_hTX2-q-rCnTSuE']
   #provider :google_oauth2, ENV['129207227761-e3p1hkk4gaakn3s6prrhjmr5vg1fsr60.apps.googleusercontent.com'], ENV['zIk4MEfpz_hTX2-q-rCnTSuE']
   provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], skip_jwt: true
end