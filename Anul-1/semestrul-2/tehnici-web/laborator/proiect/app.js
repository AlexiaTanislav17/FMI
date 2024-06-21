var express = require("express");
var fs = require("fs");
var app = express();

//app.use(express.static("/site"));

app.use((req, res, next) => {
    res.status(404).send("Pagina nu a fost gasita!");
});

app.get('/data', (req, res) => {
    const jsonData = require('./data.json');
    res.json(jsonData);
});


app.get('/', (req, res) => {
    res.sendFile(__dirname + '/feedback.html');
});

app.post('/submit', (req, res) => {
    const data = req.body;
    res.send('Datele au fost primite cu succes!');
});

const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = 3000;

app.use(bodyParser.urlencoded({ extended: true }));   //ca sa le dea post

app.use(express.static('public')); // facem folder pt fisiere statice dar nu vrea


app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'feedback.html'));   //nu cred ca ar trb sa pun aceeasi ruta
});

app.post('/submit', (req, res) => {       // ruta pentru luarea datelor din formular prin post
    const { name, email, feedback } = req.body;

    const feedbackEntry = { name, email, feedback };
    const feedbacks = JSON.parse(fs.readFileSync('feedbacks.json', 'utf-8')) || [];
    feedbacks.push(feedbackEntry);

    if (feedbacks.length > 5) {
        feedbacks.shift();
    }

    fs.writeFileSync('feedbacks.json', JSON.stringify(feedbacks, null, 2));

    res.send('<html><body><h1>Thank you, ' + name + ', for your feedback!</h1><a href="/">Submit another feedback</a></body></html>');
});


app.get('/data', (req, res) => {  // ruta pentru luarea datelor din fis json cu ajax
    const feedbacks = JSON.parse(fs.readFileSync('feedbacks.json', 'utf-8')) || [];
    res.json(feedbacks);
});


app.use((req, res) => {
    res.status(404).send('<html><body><h1>404 - Page Not Found</h1><a href="/">Go to Home</a></body></html>');
});



// app.get("/ex0", function(req, res) {
//     res.send("Hello!");     
// });

// app.get("/ex1", function(req, res) {
   
// });

app.listen(5000, function() {
    console.log("A pornit serverul!");
});