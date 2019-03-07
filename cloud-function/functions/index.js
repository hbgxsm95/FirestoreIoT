//
//  index.js
//  Created by Peiqin Zhao on 3/4/19.
//  Copyright © 2019 Google LLC. All rights reserved.
//
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const app = admin.initializeApp()
const db = admin.firestore();
const nodemailer = require('nodemailer');
// Configure the email transport using the default SMTP transport and a GMail account.
// For other types of transports such as Sendgrid see https://nodemailer.com/transports/
// TODO: Configure the `gmail.email` and `gmail.password` Google Cloud environment variables.
const gmailEmail = functions.config().gmail.email;
const gmailPassword = functions.config().gmail.password;
const mailTransport = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: gmailEmail,
    pass: gmailPassword,
  },
});

exports.sendEmailAlert = functions.firestore.document('/sensor/{sensor}').onWrite((change, context) => {
  var newSampledValue = change.after.data().sampledValue;
  var sensorRef = db.collection('sensor').doc(context.params.sensor);

  sensorRef.get().then(async function(doc){
    if(doc.exists && doc.data().threshold < newSampledValue){
       const mailOptions = {
          from: '"Firestore IoT." <noreply@firestore.com>',
          to: gmailEmail,
        };
        // Building Email message.
        mailOptions.subject = 'Sensor Alert!';
        mailOptions.text =
            'Detected Value Above Threahold: ' + newSampledValue.toString(); 
        
        try {
          await mailTransport.sendMail(mailOptions);
          console.log('Successfully Send the Alert Email');
        } catch(error) {
          console.error('There was an error while sending the email:', error);
        }
    } else{
      console.error('There is no corresponding sensor in the collection');
    }
  }).catch(function(error){
    console.log('Error getting document:', error);
  });

  return null;
});
